Received: from eggs.gnu.org ([2001:4830:134:3::10]:41590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cykh9-00010B-NY
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cykh8-0000YY-Sv
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 15:46:19 -0400
References: <20170412164445.23039-1-berrange@redhat.com>
	<20170412164445.23039-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c508336e-6d0c-0bd4-9fc6-cd958f2516ce@redhat.com>
Date: Thu, 13 Apr 2017 21:46:07 +0200
MIME-Version: 1.0
In-Reply-To: <20170412164445.23039-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7xNU0xXK6cwPuBqQgFgSaKlshktwF4KD5"
Subject: Re: [Qemu-devel] [PATCH v4 3/4] qemu-img: introduce
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
--7xNU0xXK6cwPuBqQgFgSaKlshktwF4KD5
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <c508336e-6d0c-0bd4-9fc6-cd958f2516ce@redhat.com>
Subject: Re: [PATCH v4 3/4] qemu-img: introduce --target-image-opts for
 'convert' command
References: <20170412164445.23039-1-berrange@redhat.com>
 <20170412164445.23039-4-berrange@redhat.com>
In-Reply-To: <20170412164445.23039-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12.04.2017 18:44, Daniel P. Berrange wrote:
> The '--image-opts' flags indicates whether the source filename
> includes options. The target filename has to remain in the
> plain filename format though, since it needs to be passed to
> bdrv_create().  When using --skip-create though, it would be
> possible to use image-opts syntax. This adds --target-image-opts
> to indicate that the target filename includes options. Currently
> this mandates use of the --skip-create flag too.
>=20
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img-cmds.hx |  4 +--
>  qemu-img.c       | 84 +++++++++++++++++++++++++++++++++++++++---------=
--------
>  qemu-img.texi    | 12 ++++++--
>  3 files changed, 71 insertions(+), 29 deletions(-)

Looks good apart from some minor issues.

[...]

> diff --git a/qemu-img.c b/qemu-img.c
> index 83aff5e..31c4923 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c

[...]

> @@ -2090,6 +2100,11 @@ static int img_convert(int argc, char **argv)
>          goto fail_getopt;
>      }
> =20
> +    if (tgt_image_opts && !skip_create) {
> +        error_report("--target-image-opts requires use of -n flag");
> +        goto fail_getopt;

ret should be set to -1.

> +    }
> +
>      /* Initialize before goto out */
>      if (quiet) {
>          progress =3D 0;
> @@ -2100,8 +2115,13 @@ static int img_convert(int argc, char **argv)
>      out_filename =3D bs_n >=3D 1 ? argv[argc - 1] : NULL;
> =20
>      if (options && has_help_option(options)) {
> -        ret =3D print_block_option_help(out_filename, out_fmt);
> -        goto out;
> +        if (out_fmt) {
> +            ret =3D print_block_option_help(out_filename, out_fmt);
> +            goto out;
> +        } else {
> +            error_report("Option help requires a format be specified")=
;
> +            goto fail_getopt;

Same here.

> +        }
>      }
> =20
>      if (bs_n < 1) {

[...]

> diff --git a/qemu-img.texi b/qemu-img.texi
> index c81db3e..63f597d 100644
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
> +
> +@item --target-image-opts
> +
> +Indicates that the target @var{filename} parameter(s) are to be interp=
reted a

s/a$/as/

> +a full option string, not a plain filename. This parameter is mutually=

> +exclusive with the @var{-O} parameters. It is currently required to al=
so use
> +the @var{-n} parameter to skip image creation. This restriction may be=
 relaxed
> +in a future release.

By the way, since you're referring to -n, you could just call it
"@var{output_filename}" instead of "target @var{filename}", because
that's how convert's target filename is described in this man page.

Max

> =20
>  @item fmt
>  is the disk image format. It is guessed automatically in most cases. S=
ee below
>=20



--7xNU0xXK6cwPuBqQgFgSaKlshktwF4KD5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljv1X8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhMYH/3xOCB7zVe+WCrf+MEzurMzZRxbkvMvK
v/DIq56ULl0G60dNwUfJt6n/ZdF2Fy6RiERtyImOv6Syf40ReP6esUNCjjVDVPAK
HnVjJOYq3jJou8wF4qcm1Crscf/lUCDCfSv6LlEDzTcrHRTf2Lq5MI4PSKK9NqZt
Jse4ZxxKxqXajEjJHFyPLihkSlW55velRdyAbrSe5xYHp5RaMtdfrHrBeW0yUzUT
2RIs4etRhXHo69LaKciFt1a0IAJo4sWU7WqDkzQvfXoxbQ1COuTY0avSE2NarE3S
pRuMz/KiMbZmBtd2MKO8jXuVx8EFPJdMijBBodQCV1YNwewlnKflARA=
=jkDV
-----END PGP SIGNATURE-----

--7xNU0xXK6cwPuBqQgFgSaKlshktwF4KD5--
