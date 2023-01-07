if (!require(sf)) {
  install.packages('sf',
                   repos='http://cran.us.r-project.org')
  library(sf)
}

archivo <-
  choose.files(caption = "Seleccione archivo a estandatizar (shp, gpkg)",
              multi = FALSE)
file_name <- paste0(tools::file_path_sans_ext(archivo),
                    '_estandarizado.',
                    tools::file_ext(archivo))

datos <- st_read(archivo)

soloDatos <- st_drop_geometry(datos)

datos_normalizados <- data.frame(sapply(soloDatos, scale))

st_geometry(datos_normalizados) <- st_geometry(datos)



st_write(datos_normalizados,
         file_name)
