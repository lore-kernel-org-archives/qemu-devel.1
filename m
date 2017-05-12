Received: from eggs.gnu.org ([2001:4830:134:3::10]:46680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9Eyn-0001fO-Ij
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d9Eyl-0004JK-FZ
	for qemu-devel@nongnu.org; Fri, 12 May 2017 14:07:53 -0400
References: <20170511182705.23648-1-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
Date: Fri, 12 May 2017 20:07:38 +0200
MIME-Version: 1.0
In-Reply-To: <20170511182705.23648-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="G1KqDC1V7sHLT8lgk7RKb6Ch4nb0FPbBo"
Subject: Re: [Qemu-devel] [PATCH v4] qemu-img: Check for backing image if
 specified during create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--G1KqDC1V7sHLT8lgk7RKb6Ch4nb0FPbBo
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <19a665be-12c2-2876-0438-08327d94473e@redhat.com>
Subject: Re: [PATCH v4] qemu-img: Check for backing image if specified during
 create
References: <20170511182705.23648-1-jsnow@redhat.com>
In-Reply-To: <20170511182705.23648-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-11 20:27, John Snow wrote:
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1213786
>=20
> Or, rather, force the open of a backing image if one was specified
> for creation. Using a similar -unsafe option as rebase, allow qemu-img
> to ignore the backing file validation if possible.
>=20
> It may not always be possible, as in the existing case when a filesize
> for the new image was not specified.
>=20
> This is accomplished by shifting around the conditionals in
> bdrv_img_create, such that a backing file is always opened unless we
> provide BDRV_O_NO_BACKING. qemu-img is adjusted to pass this new flag
> when -u is provided to create.
>=20
> Sorry for the heinous looking diffstat, but it's mostly whitespace.
>=20
> Reported-by: Yi Sun <yisun@redhat.com>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> v4: Actually do the things Eric told me to.
> v3: Rebased
> v2: Rebased for 2.10
>     Corrected some of my less cromulent grammar
>=20
>=20
>  block.c                    | 73 +++++++++++++++++++++++---------------=
--------
>  qemu-img-cmds.hx           |  4 +--
>  qemu-img.c                 | 16 ++++++----
>  tests/qemu-iotests/082     |  4 +--
>  tests/qemu-iotests/082.out |  4 +--
>  5 files changed, 54 insertions(+), 47 deletions(-)
>=20
> diff --git a/block.c b/block.c
> index a45b9b5..3c3df54 100644
> --- a/block.c
> +++ b/block.c
> @@ -4275,37 +4275,37 @@ void bdrv_img_create(const char *filename, cons=
t char *fmt,
>      // The size for the image must always be specified, with one excep=
tion:
>      // If we are using a backing file, we can obtain the size from the=
re
>      size =3D qemu_opt_get_size(opts, BLOCK_OPT_SIZE, 0);
> -    if (size =3D=3D -1) {

"Hang on, why should this be -1 when the defval is 0? Where does the -1
come from?"
"..."
"Oh, the option exists and is set to -1? Why is that?"
"..."
"Oh, because this function always sets it itself, and because @img_size
is set to (uint64_t)-1."

First, I won't start with how signed integer overflow is
implementation-defined in C because I hope you have thrashed that out
with Eric (I hope that "to thrash out" is a good translation for
"auskaspern" (lit. "to buffoon out").).

Second, well, at least we should put -1 as the default value here, then.

Not strictly your fault or something that you need to fix, but it is
just a single line in the vicinity...

Let me know if you want to address this, for now I'll leave a

Reviewed-by: Max Reitz <mreitz@redhat.com>

here if you don't want to.

Max

> -        if (backing_file) {
> -            BlockDriverState *bs;
> -            char *full_backing =3D g_new0(char, PATH_MAX);
> -            int64_t size;
> -            int back_flags;
> -            QDict *backing_options =3D NULL;
> -
> -            bdrv_get_full_backing_filename_from_filename(filename, bac=
king_file,
> -                                                         full_backing,=
 PATH_MAX,
> -                                                         &local_err);
> -            if (local_err) {
> -                g_free(full_backing);
> -                goto out;
> -            }
> -
> -            /* backing files always opened read-only */
> -            back_flags =3D flags;
> -            back_flags &=3D ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_N=
O_BACKING);
> -
> -            if (backing_fmt) {
> -                backing_options =3D qdict_new();
> -                qdict_put_str(backing_options, "driver", backing_fmt);=

> -            }
> -
> -            bs =3D bdrv_open(full_backing, NULL, backing_options, back=
_flags,
> -                           &local_err);
> +    if (backing_file && !(flags & BDRV_O_NO_BACKING)) {
> +        BlockDriverState *bs;
> +        char *full_backing =3D g_new0(char, PATH_MAX);
> +        int back_flags;
> +        QDict *backing_options =3D NULL;
> +
> +        bdrv_get_full_backing_filename_from_filename(filename, backing=
_file,
> +                                                     full_backing, PAT=
H_MAX,
> +                                                     &local_err);
> +        if (local_err) {
>              g_free(full_backing);
> -            if (!bs) {
> -                goto out;
> -            }
> +            goto out;
> +        }
> +
> +        /* backing files always opened read-only */
> +        back_flags =3D flags;
> +        back_flags &=3D ~(BDRV_O_RDWR | BDRV_O_SNAPSHOT | BDRV_O_NO_BA=
CKING);
> +
> +        if (backing_fmt) {
> +            backing_options =3D qdict_new();
> +            qdict_put_str(backing_options, "driver", backing_fmt);
> +        }
> +
> +        bs =3D bdrv_open(full_backing, NULL, backing_options, back_fla=
gs,
> +                       &local_err);
> +        g_free(full_backing);
> +        if (!bs) {
> +            goto out;
> +        }
> +
> +        if (size =3D=3D -1) {
>              size =3D bdrv_getlength(bs);
>              if (size < 0) {
>                  error_setg_errno(errp, -size, "Could not get size of '=
%s'",
> @@ -4313,14 +4313,15 @@ void bdrv_img_create(const char *filename, cons=
t char *fmt,
>                  bdrv_unref(bs);
>                  goto out;
>              }
> -
>              qemu_opt_set_number(opts, BLOCK_OPT_SIZE, size, &error_abo=
rt);
> -
> -            bdrv_unref(bs);
> -        } else {
> -            error_setg(errp, "Image creation needs a size parameter");=

> -            goto out;
>          }
> +
> +        bdrv_unref(bs);
> +    }
> +
> +    if (size =3D=3D -1) {
> +        error_setg(errp, "Image creation needs a size parameter");
> +        goto out;
>      }
> =20
>      if (!quiet) {
> diff --git a/qemu-img-cmds.hx b/qemu-img-cmds.hx
> index bf4ce59..1d230c6 100644
> --- a/qemu-img-cmds.hx
> +++ b/qemu-img-cmds.hx
> @@ -22,9 +22,9 @@ STEXI
>  ETEXI
> =20
>  DEF("create", img_create,
> -    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F b=
acking_fmt] [-o options] filename [size]")
> +    "create [-q] [--object objectdef] [-f fmt] [-b backing_file] [-F b=
acking_fmt] [-u] [-o options] filename [size]")
>  STEXI
> -@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{b=
acking_file}] [-F @var{backing_fmt}] [-o @var{options}] @var{filename} [@=
var{size}]
> +@item create [--object @var{objectdef}] [-q] [-f @var{fmt}] [-b @var{b=
acking_file}] [-F @var{backing_fmt}] [-u] [-o @var{options}] @var{filenam=
e} [@var{size}]
>  ETEXI
> =20
>  DEF("commit", img_commit,
> diff --git a/qemu-img.c b/qemu-img.c
> index f3b0ab4..dd977a8 100644
> --- a/qemu-img.c
> +++ b/qemu-img.c
> @@ -145,9 +145,11 @@ static void QEMU_NORETURN help(void)
>             "  'snapshot_id_or_name' is deprecated, use 'snapshot_param=
'\n"
>             "    instead\n"
>             "  '-c' indicates that target image must be compressed (qco=
w format only)\n"
> -           "  '-u' enables unsafe rebasing. It is assumed that old and=
 new backing file\n"
> -           "       match exactly. The image doesn't need a working bac=
king file before\n"
> -           "       rebasing in this case (useful for renaming the back=
ing file)\n"
> +           "  '-u' allows unsafe backing chains. For rebasing, it is a=
ssumed that old and\n"
> +           "       new backing file match exactly. The image doesn't n=
eed a working\n"
> +           "       backing file before rebasing in this case (useful f=
or renaming the\n"
> +           "       backing file). For image creation, allow creating w=
ithout attempting\n"
> +           "       to open the backing file.\n"
>             "  '-h' with or without a command shows this help and lists=
 the supported formats\n"
>             "  '-p' show progress of command (only certain commands)\n"=

>             "  '-q' use Quiet mode - do not print any output (except er=
rors)\n"
> @@ -409,6 +411,7 @@ static int img_create(int argc, char **argv)
>      char *options =3D NULL;
>      Error *local_err =3D NULL;
>      bool quiet =3D false;
> +    int flags =3D 0;
> =20
>      for(;;) {
>          static const struct option long_options[] =3D {
> @@ -416,7 +419,7 @@ static int img_create(int argc, char **argv)
>              {"object", required_argument, 0, OPTION_OBJECT},
>              {0, 0, 0, 0}
>          };
> -        c =3D getopt_long(argc, argv, ":F:b:f:he6o:q",
> +        c =3D getopt_long(argc, argv, ":F:b:f:he6o:qu",
>                          long_options, NULL);
>          if (c =3D=3D -1) {
>              break;
> @@ -464,6 +467,9 @@ static int img_create(int argc, char **argv)
>          case 'q':
>              quiet =3D true;
>              break;
> +        case 'u':
> +            flags |=3D BDRV_O_NO_BACKING;
> +            break;
>          case OPTION_OBJECT: {
>              QemuOpts *opts;
>              opts =3D qemu_opts_parse_noisily(&qemu_object_opts,
> @@ -516,7 +522,7 @@ static int img_create(int argc, char **argv)
>      }
> =20
>      bdrv_img_create(filename, fmt, base_filename, base_fmt,
> -                    options, img_size, 0, quiet, &local_err);
> +                    options, img_size, flags, quiet, &local_err);
>      if (local_err) {
>          error_reportf_err(local_err, "%s: ", filename);
>          goto fail;
> diff --git a/tests/qemu-iotests/082 b/tests/qemu-iotests/082
> index ad1d9fa..d5c83d4 100755
> --- a/tests/qemu-iotests/082
> +++ b/tests/qemu-iotests/082
> @@ -85,8 +85,8 @@ run_qemu_img create -f $IMGFMT -o cluster_size=3D4k -=
o help "$TEST_IMG" $size
>  run_qemu_img create -f $IMGFMT -o cluster_size=3D4k -o \? "$TEST_IMG" =
$size
> =20
>  # Looks like a help option, but is part of the backing file name
> -run_qemu_img create -f $IMGFMT -o backing_file=3D"$TEST_IMG",,help "$T=
EST_IMG" $size
> -run_qemu_img create -f $IMGFMT -o backing_file=3D"$TEST_IMG",,\? "$TES=
T_IMG" $size
> +run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,help =
"$TEST_IMG" $size
> +run_qemu_img create -f $IMGFMT -u -o backing_file=3D"$TEST_IMG",,\? "$=
TEST_IMG" $size
> =20
>  # Try to trick qemu-img into creating escaped commas
>  run_qemu_img create -f $IMGFMT -o backing_file=3D"$TEST_IMG", -o help =
"$TEST_IMG" $size
> diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
> index a952330..f2732e4 100644
> --- a/tests/qemu-iotests/082.out
> +++ b/tests/qemu-iotests/082.out
> @@ -146,10 +146,10 @@ lazy_refcounts   Postpone refcount updates
>  refcount_bits    Width of a reference count entry in bits
>  nocow            Turn off copy-on-write (valid only on btrfs)
> =20
> -Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,help TEST=
_DIR/t.qcow2 128M
> +Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,help T=
EST_DIR/t.qcow2 128M
>  Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_fi=
le=3DTEST_DIR/t.qcow2,,help encryption=3Doff cluster_size=3D65536 lazy_re=
fcounts=3Doff refcount_bits=3D16
> =20
> -Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2,,? TEST_DI=
R/t.qcow2 128M
> +Testing: create -f qcow2 -u -o backing_file=3DTEST_DIR/t.qcow2,,? TEST=
_DIR/t.qcow2 128M
>  Formatting 'TEST_DIR/t.qcow2', fmt=3Dqcow2 size=3D134217728 backing_fi=
le=3DTEST_DIR/t.qcow2,,? encryption=3Doff cluster_size=3D65536 lazy_refco=
unts=3Doff refcount_bits=3D16
> =20
>  Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t.qcow2, -o help T=
EST_DIR/t.qcow2 128M
>=20



--G1KqDC1V7sHLT8lgk7RKb6Ch4nb0FPbBo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZFfnqEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQPE5
B/9w8od0AGRrF9SWgtLEyYcDP4AAoIxd2Hk1QmSYkhZKGI+h+brDClRBsE+oOC+n
7ELO+toDxBHqpynJyGiFhKTLQT21uyW5jxyV7PNrPWFm2RV7lcjAqcS8cMM5B1wh
dh+kjpDd6a6DMeIS8tpspMDzlK3jefwM9MTwB6s8jQHnAtd1zFAVig26EzB//hvT
fdEdSkaU55uP01+AOJH0aZvDGzothtz/KZdQIyWHqN+gRmLLnzJtV+HmexP5GL+r
TzkMQ+gWvPOQyELh0cyPCpmtHnIDr1nzq9Vvjr3DO9tcnbV8yNdwaBAcj89yZ7Ir
klB2D25/xpow24RA7mFz0g0f
=pGR6
-----END PGP SIGNATURE-----

--G1KqDC1V7sHLT8lgk7RKb6Ch4nb0FPbBo--
