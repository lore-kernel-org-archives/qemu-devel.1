Received: from eggs.gnu.org ([2001:4830:134:3::10]:45358)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZmP2-0003QA-KJ
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:32:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZmP1-0001yU-Cr
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 17:32:24 -0500
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-6-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <30f30db6-2bf4-44c6-5267-cd98e8d99bca@redhat.com>
Date: Fri, 3 Feb 2017 23:32:13 +0100
MIME-Version: 1.0
In-Reply-To: <20170203120254.15062-6-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hxUWmS1OOCvCxbGMEPMuOH3h6oaqDbKRn"
Subject: Re: [Qemu-devel] [PATCH v2 5/6] qemu-img: introduce
 --target-image-opts for 'convert' command
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hxUWmS1OOCvCxbGMEPMuOH3h6oaqDbKRn
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <30f30db6-2bf4-44c6-5267-cd98e8d99bca@redhat.com>
Subject: Re: [PATCH v2 5/6] qemu-img: introduce --target-image-opts for
 'convert' command
References: <20170203120254.15062-1-berrange@redhat.com>
 <20170203120254.15062-6-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-6-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 13:02, Daniel P. Berrange wrote:
> The '--image-opts' flags indicates whether the source filename
> includes options. The target filename has to remain in the
> plain filename format though, since it needs to be passed to
> bdrv_create().  When using --skip-create though, it would be
> possible to use image-opts syntax. This adds --target-image-opts
> to indicate that the target filename includes options. Currently
> this mandates use of the --skip-create flag too.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img-cmds.hx |   6 +--
>  qemu-img.c       | 131 ++++++++++++++++++++++++++++++++++++-----------=
--------
>  qemu-img.texi    |  12 ++++-
>  3 files changed, 98 insertions(+), 51 deletions(-)

Apart from what the commit message says, it also introduces that switch
for dd, which I again don't like too much (quelle surprise), if only
because it requires conv=3Dnocreat and thus patch 5 to be useful.

[...]

> diff --git a/qemu-img.c b/qemu-img.c
> index 39fcf09..dc4c6eb 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -1918,7 +1933,7 @@ static int img_convert(int argc, char **argv)
>      bs_n =3D argc - optind - 1;
>      out_filename =3D bs_n >=3D 1 ? argv[argc - 1] : NULL;
> =20
> -    if (options && has_help_option(options)) {
> +    if (out_fmt && options && has_help_option(options)) {

"!out_fmt && options && has_help_option(options)" should probably be an
error.

>          ret =3D print_block_option_help(out_filename, out_fmt);
>          goto out;
>      }
> @@ -1987,22 +2002,22 @@ static int img_convert(int argc, char **argv)
>          goto out;
>      }
> =20
> -    /* Find driver and parse its options */
> -    drv =3D bdrv_find_format(out_fmt);
> -    if (!drv) {
> -        error_report("Unknown file format '%s'", out_fmt);
> -        ret =3D -1;
> -        goto out;
> -    }
> +    if (!skip_create) {
> +        /* Find driver and parse its options */
> +        drv =3D bdrv_find_format(out_fmt);
> +        if (!drv) {
> +            error_report("Unknown file format '%s'", out_fmt);
> +            ret =3D -1;
> +            goto out;
> +        }
> =20
> -    proto_drv =3D bdrv_find_protocol(out_filename, true, &local_err);
> -    if (!proto_drv) {
> -        error_report_err(local_err);
> -        ret =3D -1;
> -        goto out;
> -    }
> +        proto_drv =3D bdrv_find_protocol(out_filename, true, &local_er=
r);
> +        if (!proto_drv) {
> +            error_report_err(local_err);
> +            ret =3D -1;
> +            goto out;
> +        }
> =20
> -    if (!skip_create) {
>          if (!drv->create_opts) {
>              error_report("Format driver '%s' does not support image cr=
eation",
>                           drv->format_name);

Compression may be used with -n. This involves the check whether
drv->bdrv_co_pwritev_compressed is NULL or not -- which is bad if drv is
still NULL:

$ ./qemu-img create -f qcow2 foo.qcow2 64M
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Doff
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ ./qemu-img convert -c -O qcow2 -n null-co:// foo.qcow2
[1]    17179 segmentation fault (core dumped)  ./qemu-img convert -c -O
qcow2 -n null-co:// foo.qcow

Therefore, you should probably only do the check whether compression is
supported if drv is non-NULL; and if it is NULL, do the check again
after the target image has been opened and its driver is known.

[...]

> @@ -4064,13 +4090,22 @@ static int img_dd(int argc, char **argv)
>          arg =3D NULL;
>      }
> =20
> +    if (tgt_image_opts && !(dd.flags & C_NOCREAT)) {
> +        error_report("--target-image-opts requires use of -n flag");

*conv=3Dnocreat

> +        goto out;
> +    }
> +
> +    if (!out_fmt && !tgt_image_opts) {
> +        out_fmt =3D "raw";
> +    }
> +
>      if (!(dd.flags & C_IF && dd.flags & C_OF)) {
>          error_report("Must specify both input and output files");
>          ret =3D -1;
>          goto out;
>      }
> =20
> -    if (optionstr && has_help_option(optionstr)) {
> +    if (out_fmt && optionstr && has_help_option(optionstr)) {

Same as in img_convert().

>          ret =3D print_block_option_help(out.filename, out_fmt);
>          goto out;
>      }

[...]

> @@ -4152,7 +4187,6 @@ static int img_dd(int argc, char **argv)
> =20
>      if (!(dd.flags & C_NOCREAT)) {
>          qemu_opt_set_number(opts, BLOCK_OPT_SIZE, out_size, &error_abo=
rt);
> -
>          ret =3D bdrv_create(drv, out.filename, opts, &local_err);
>          if (ret < 0) {
>              error_reportf_err(local_err,

I'm not sure whether this hunk is necessary...

[...]

> diff --git a/qemu-img.texi b/qemu-img.texi
> index 01acfb8..bda3cc3 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -45,9 +45,17 @@ keys.
> =20
>  @item --image-opts
> =20
> -Indicates that the @var{filename} parameter is to be interpreted as a
> +Indicates that the source @var{filename} parameter is to be interprete=
d as a
>  full option string, not a plain filename. This parameter is mutually
> -exclusive with the @var{-f} and @var{-F} parameters.
> +exclusive with the @var{-f} parameter.

-F is correct, that's the one for qemu-img compare, after all (which
takes two source filenames).

> +
> +@item --target-image-opts
> +
> +Indicates that the target @var{filename} parameter(s) are to be interp=
reted a
> +a full option string, not a plain filename. This parameter is mutually=

> +exclusive with the @var{-F} or @var{-O} parameters. It is currently re=
quired

-F is unrelated to a target ("output") file.

Max

> +to also use the @var{-n} parameter to skip image creation. This restri=
ction
> +will be relaxed in a future release.
> =20
>  @item fmt
>  is the disk image format. It is guessed automatically in most cases. S=
ee below
>=20



--hxUWmS1OOCvCxbGMEPMuOH3h6oaqDbKRn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliVBO0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AWAsH/jy+lx4E+OdyKJbG/ombHV9KuBHMYjUG
JvvzGVbVDjzPKe2JxiBZQmeLOXqLOwNjO2auIK5uAuBdavDimuu+uIg2uRKps7Xe
5y2d6vO9ReW804/GBOiq89odiRJUfoIWbhJkcmj5A9GbCQck2R2AJ8vl/lbbdaaE
L6zVHnDK3BqHieg+89JR1vRuOPDn7ep+t58RgFyIHMzut8h9pTn5Bl3wlihEvhx5
zSGtSulYlcgBBGGyz0CnUM99VFXgd91T1+OmkXrzAseJEzwNjEJC9mEy6ZaXrA6m
hOXIkX9Kexit5zzsgzYnu4Dp70oqzOIn/YjG+GlgBN9Pmk8CisPFaEI=
=uGt+
-----END PGP SIGNATURE-----

--hxUWmS1OOCvCxbGMEPMuOH3h6oaqDbKRn--
