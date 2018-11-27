Received: from eggs.gnu.org ([2001:4830:134:3::10]:50451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gRcaE-00055r-UL
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:35:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cfergeau@redhat.com>) id 1gRca8-0004qJ-Rr
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:35:18 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37170)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cfergeau@redhat.com>) id 1gRca8-0004os-KC
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 07:35:12 -0500
Date: Tue, 27 Nov 2018 13:35:02 +0100
From: Christophe Fergeau <cfergeau@redhat.com>
Message-ID: <20181127123502.GZ12172@natto.ory.fergeau.eu>
References: <20181126153036.22414-1-fziglio@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KC8n6y+EC4k2kdZR"
Content-Disposition: inline
In-Reply-To: <20181126153036.22414-1-fziglio@redhat.com>
Subject: Re: [Qemu-devel] [Spice-devel] [PATCH] spice: Use new
 SpiceImageCompression definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Frediano Ziglio <fziglio@redhat.com>
Cc: spice-devel@lists.freedesktop.org, Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org


--KC8n6y+EC4k2kdZR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hey,

On Mon, Nov 26, 2018 at 03:30:36PM +0000, Frediano Ziglio wrote:
> Definitions were updated by spice-server in patch de66161 included
> in 0.12.6 released on 12th June 2015.

QEMU's configure only checks for spice-server 0.12.0:

$pkg_config --atleast-version=3D0.12.0 spice-server

  if $pkg_config --atleast-version=3D0.12.0 spice-server && \
     $pkg_config --atleast-version=3D0.12.3 spice-protocol && \
     compile_prog "$spice_cflags" "$spice_libs" ; then
    spice=3D"yes"
    libs_softmmu=3D"$libs_softmmu $spice_libs"
    QEMU_CFLAGS=3D"$QEMU_CFLAGS $spice_cflags"
    spice_protocol_version=3D$($pkg_config --modversion spice-protocol)
    spice_server_version=3D$($pkg_config --modversion spice-server)
  else
    if test "$spice" =3D "yes" ; then
      feature_not_found "spice" \
          "Install spice-server(>=3D0.12.0) and spice-protocol(>=3D0.12.3) =
devel"
    fi
    spice=3D"no"
  fi

I don't know how far back QEMU wants to support spice-server.
Apart from this, the patch looks good to me.

Christophe

>=20
> Signed-off-by: Frediano Ziglio <fziglio@redhat.com>
> ---
>  ui/spice-core.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
>=20
> diff --git a/ui/spice-core.c b/ui/spice-core.c
> index ebaae24643..2e6a255a35 100644
> --- a/ui/spice-core.c
> +++ b/ui/spice-core.c
> @@ -331,12 +331,12 @@ static const char *stream_video_names[] =3D {
>                 stream_video_names, ARRAY_SIZE(stream_video_names))
> =20
>  static const char *compression_names[] =3D {
> -    [ SPICE_IMAGE_COMPRESS_OFF ]      =3D "off",
> -    [ SPICE_IMAGE_COMPRESS_AUTO_GLZ ] =3D "auto_glz",
> -    [ SPICE_IMAGE_COMPRESS_AUTO_LZ ]  =3D "auto_lz",
> -    [ SPICE_IMAGE_COMPRESS_QUIC ]     =3D "quic",
> -    [ SPICE_IMAGE_COMPRESS_GLZ ]      =3D "glz",
> -    [ SPICE_IMAGE_COMPRESS_LZ ]       =3D "lz",
> +    [ SPICE_IMAGE_COMPRESSION_OFF ]      =3D "off",
> +    [ SPICE_IMAGE_COMPRESSION_AUTO_GLZ ] =3D "auto_glz",
> +    [ SPICE_IMAGE_COMPRESSION_AUTO_LZ ]  =3D "auto_lz",
> +    [ SPICE_IMAGE_COMPRESSION_QUIC ]     =3D "quic",
> +    [ SPICE_IMAGE_COMPRESSION_GLZ ]      =3D "glz",
> +    [ SPICE_IMAGE_COMPRESSION_LZ ]       =3D "lz",
>  };
>  #define parse_compression(_name)                                        \
>      parse_name(_name, "image compression",                              \
> @@ -643,7 +643,7 @@ void qemu_spice_init(void)
>          *x509_cert_file =3D NULL,
>          *x509_cacert_file =3D NULL;
>      int port, tls_port, addr_flags;
> -    spice_image_compression_t compression;
> +    SpiceImageCompression compression;
>      spice_wan_compression_t wan_compr;
>      bool seamless_migration;
> =20
> @@ -754,7 +754,7 @@ void qemu_spice_init(void)
>  #endif
>      }
> =20
> -    compression =3D SPICE_IMAGE_COMPRESS_AUTO_GLZ;
> +    compression =3D SPICE_IMAGE_COMPRESSION_AUTO_GLZ;
>      str =3D qemu_opt_get(opts, "image-compression");
>      if (str) {
>          compression =3D parse_compression(str);
> --=20
> 2.17.2
>=20
> _______________________________________________
> Spice-devel mailing list
> Spice-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/spice-devel

--KC8n6y+EC4k2kdZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEElKn3VmH3emFoZJsjqdjCFCmsbIIFAlv9OfIACgkQqdjCFCms
bIIR8A/+PvoYahGC9eIouMEVjarByWXktB0ZBs3uBItZMoxtXCsFKEFDZMs6TfXV
3QuXPS2kYCkht9dsm5gIcYmpQ20Khpc7Vf2GgJzn1ChtfGVhVUMXSV8gFYDRUOf1
h/JjcssNDY+WV6xvDoKBpNwQfNv6RSJAFfyAYCdHSRM8IfjA4ABmE0ffMEoFZjlu
Q1b66U9r+C6JUYXLyDZcfEG4YkXV6oyIAeX1g3VFLfsg0lBKsMepdC6naNBXrYIw
RJHGaxjBTfsffZYxoIYA/00BNZbfmYORLD0nYOo6REY0wFBRoB/Zhl9h5eCA/1Zc
OBQ0LVsA21Os7hRb97S8yQdR10OshK8xYE3ROlnK+OL0dqis96SjxoD9cvFi9wsz
5GxRC2raXKoNcoi6SCpU4OQlFdfd5uiZFfgGOXGipGSiGLKAhU3YPV2DlDTx25Ju
Nz/S7xTGmy3lO3A+DA9sr/x57Vz5/rTtz/W9qPVfnmIhRyzMT3L7jAxd7T2aBfYf
elRg8NUf3iwB0LSR+YDkgOKE9zu5lCjvgj5KmUHr35DQGBU+bGZ8rqp2ezlXaG9N
O5JMIX42GE+04Kk76vzaWMX8PGHLwMI1sCX8/fI+fPF6x7D58/U8WQbWDpQ2odyV
WD9QJD6WBkX97bLfrCb1mystv4AilXoWxPsVxp2PqvaTzxdp9nk=
=gkas
-----END PGP SIGNATURE-----

--KC8n6y+EC4k2kdZR--
