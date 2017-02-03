Received: from eggs.gnu.org ([2001:4830:134:3::10]:34618)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZlf8-00088q-5M
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:44:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cZlf6-00009K-Vk
	for qemu-devel@nongnu.org; Fri, 03 Feb 2017 16:44:58 -0500
References: <20170203120254.15062-1-berrange@redhat.com>
	<20170203120254.15062-4-berrange@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5c7df424-d78e-650f-3045-c87fd645b611@redhat.com>
Date: Fri, 3 Feb 2017 22:44:46 +0100
MIME-Version: 1.0
In-Reply-To: <20170203120254.15062-4-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="nBrdV0Atkxr4APOQrQg43phtDtQv6Fk0o"
Subject: Re: [Qemu-devel] [PATCH v2 3/6] qemu-img: add support for
 conv=nocreat, notrunc args to dd command
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
--nBrdV0Atkxr4APOQrQg43phtDtQv6Fk0o
From: Max Reitz <mreitz@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <5c7df424-d78e-650f-3045-c87fd645b611@redhat.com>
Subject: Re: [PATCH v2 3/6] qemu-img: add support for conv=nocreat,notrunc
 args to dd command
References: <20170203120254.15062-1-berrange@redhat.com>
 <20170203120254.15062-4-berrange@redhat.com>
In-Reply-To: <20170203120254.15062-4-berrange@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 03.02.2017 13:02, Daniel P. Berrange wrote:
> The -n arg to the convert command allows use of a pre-existing image,
> rather than creating a new image. This adds equivalent functionality
> to the dd command using the 'conv' arg. If 'conv=3Dnocreat' is used,
> then it will assume the image already exists. The existing image
> will be truncated to match the required output size. 'conv=3Dnotrunc'
> cna be used to preserve the existing image size.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qemu-img-cmds.hx |   4 +-
>  qemu-img.c       | 137 +++++++++++++++++++++++++++++++++++++++++------=
--------
>  qemu-img.texi    |  10 +++-
>  3 files changed, 115 insertions(+), 36 deletions(-)

Quite frankly I don't like this patch very much. It's not bad in itself,
but I don't like the idea of giving qemu-img dd new features until it's
an interface for qemu-img convert. Everything that we add now encourages
new users to use it and will make the conversion a bit more difficult.

As long as qemu-img convert gets a --target-image-opts, I don't think we
need all of this functionality in qemu-img dd.

Anyway, I won't block/NACK this patch, so resuming review.

> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index f054599..b2c5424 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -46,9 +46,9 @@ STEXI
>  ETEXI
> =20
>  DEF("dd", img_dd,
> -    "dd [--image-opts] [-f fmt] [-O output_fmt] [bs=3Dblock_size] [cou=
nt=3Dblocks] [skip=3Dblocks] if=3Dinput of=3Doutput")
> +    "dd [--image-opts] [-f fmt] [-O output_fmt] [bs=3Dblock_size] [cou=
nt=3Dblocks] [skip=3Dblocks] [conv=3Dnocreat,notrunc] if=3Dinput of=3Dout=
put")
>  STEXI
> -@item dd [--image-opts] [-f @var{fmt}] [-O @var{output_fmt}] [bs=3D@va=
r{block_size}] [count=3D@var{blocks}] [skip=3D@var{blocks}] if=3D@var{inp=
ut} of=3D@var{output}
> +@item dd [--image-opts] [-f @var{fmt}] [-O @var{output_fmt}] [bs=3D@va=
r{block_size}] [count=3D@var{blocks}] [skip=3D@var{blocks}] [conv=3Dnocre=
at,notrunc] if=3D@var{input} of=3D@var{output}

I'd just write something like conv=3D@var{convs} or I don't know. There
are other conversion specifiers (or however it's called) that we may
want to support in the future, e.g. sparse or noerror.

>  ETEXI
> =20
>  DEF("info", img_info,
> diff --git a/qemu-img.c b/qemu-img.c
> index 629f9e9..c9ab9e5 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c


[...]

> @@ -3906,6 +3910,31 @@ static int img_dd_skip(const char *arg,
>      return 0;
>  }
> =20
> +static int img_dd_conv(const char *arg,
> +                       struct DdIo *in, struct DdIo *out,
> +                       struct DdInfo *dd)
> +{
> +    char **flags, **tmp;
> +
> +    tmp =3D flags =3D g_strsplit(arg, ",", 0);

"flag_pointer", "cur_flag_pointer" or "flat_iterator" instead of "tmp"
might be more suitable names.

> +
> +    while (tmp && *tmp) {
> +        if (g_str_equal(*tmp, "noconv")) {
> +            dd->flags |=3D C_NOCREAT;
> +        } else if (g_str_equal(*tmp, "notrunc")) {
> +            dd->flags |=3D C_NOTRUNC;
> +        } else {
> +            error_report("invalid conv argument: '%s'", *tmp);
> +            g_strfreev(flags);
> +            return 1;
> +        }
> +        tmp++;
> +    }
> +
> +    g_strfreev(flags);
> +    return 0;
> +}
> +
>  static int img_dd(int argc, char **argv)
>  {
>      int ret =3D 0;

[...]

> @@ -3954,7 +3984,7 @@ static int img_dd(int argc, char **argv)
>          { 0, 0, 0, 0 }
>      };
> =20
> -    while ((c =3D getopt_long(argc, argv, "hf:O:", long_options, NULL)=
)) {
> +    while ((c =3D getopt_long(argc, argv, "hnf:O:", long_options, NULL=
))) {

Looks like a relic from v1.

>          if (c =3D=3D EOF) {
>              break;
>          }

[...]

> diff --git a/qemu-img.texi b/qemu-img.texi
> index 174aae3..9f10562 100644
> --- a/qemu-img.texi
> +++ b/qemu-img.texi
> @@ -326,7 +326,7 @@ skipped. This is useful for formats such as @code{r=
bd} if the target
>  volume has already been created with site specific options that cannot=

>  be supplied through qemu-img.
> =20
> -@item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=3D@var{block_size}] =
[count=3D@var{blocks}] [skip=3D@var{blocks}] if=3D@var{input} of=3D@var{o=
utput}
> +@item dd [-f @var{fmt}] [-O @var{output_fmt}] [bs=3D@var{block_size}] =
[count=3D@var{blocks}] [skip=3D@var{blocks}] [conv=3Dnocreat,notrunc] if=3D=
@var{input} of=3D@var{output}
> =20
>  Dd copies from @var{input} file to @var{output} file converting it fro=
m
>  @var{fmt} format to @var{output_fmt} format.
> @@ -337,6 +337,14 @@ dd will stop reading input after reading @var{bloc=
ks} input blocks.
> =20
>  The size syntax is similar to dd(1)'s size syntax.
> =20
> +If the @code{conv=3Dnocreat} option is specified, the target volume cr=
eation
> +will be skipped. Its length will be truncated to match data length, if=
 it
> +is longer than the required data size. If the @code{conv=3Dnotrunc} op=
tion
> +is specified, no file size shrinking will be done. If the existing out=
put
> +file is too small it will be enlarged to fit. These options are useful=
 for
> +formats such as @code{rbd} if the target volume has already been creat=
ed
> +with site specific options that cannot be supplied through qemu-img.
> +

Good enough for now, but a list/table would probably be more extensible
in the future.

So all in all a patch that does well what it's supposed to do -- I just
don't quite agree on whether that goal is right.

Max

>  @item info [-f @var{fmt}] [--output=3D@var{ofmt}] [--backing-chain] @v=
ar{filename}
> =20
>  Give information about the disk image @var{filename}. Use it in
>=20



--nBrdV0Atkxr4APOQrQg43phtDtQv6Fk0o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliU+c4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AyM0H/3GurGcm2e+LaLmkIpTFCrHgvhmPPvQ6
lXTEnvwwFW3TIUXrHmYbhOMaN5+Ap3BrJj6lUWV/0Tfo6CHmmZQ10jytt0BCSI5M
LylorD2fX3vZ4B8+bmuqp2/uNvXeayYroq/IWdV1a45PvAkxnAkfnUEJiOgaOgpG
1/VSyn3U7hS1N3hs8ipfEQaYojPSAVxeS8j2Tm8K0P7PJKR03wrdBbvAICKb++Tg
/pypqwCadbkMWrImYRDodGZ904M4dl5MI0WXn2uAFjrrJsR/In2zu97nk4uktOW5
c+HdZkN06Gv8nMF7L9sxHvwQ9fNciaKBZhODqonTqMgNtDEL42B13dM=
=fvov
-----END PGP SIGNATURE-----

--nBrdV0Atkxr4APOQrQg43phtDtQv6Fk0o--
