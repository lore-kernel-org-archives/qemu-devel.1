Received: from eggs.gnu.org ([2001:4830:134:3::10]:60984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egCyz-0005ml-NF
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:12:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1egCyr-0002NU-Th
	for qemu-devel@nongnu.org; Mon, 29 Jan 2018 12:12:37 -0500
References: <20180111195225.4226-1-kwolf@redhat.com>
	<20180111195225.4226-5-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <99b05d90-756d-be4c-f6b5-240a26176d57@redhat.com>
Date: Mon, 29 Jan 2018 18:12:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180111195225.4226-5-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="LCwRgzM0j3crP0Copg5SkVeohkrFIuNx1"
Subject: Re: [Qemu-devel] [RFC PATCH 04/10] qcow2: Pass
 BlockdevCreateOptions to qcow2_create2()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LCwRgzM0j3crP0Copg5SkVeohkrFIuNx1
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <99b05d90-756d-be4c-f6b5-240a26176d57@redhat.com>
Subject: Re: [RFC PATCH 04/10] qcow2: Pass BlockdevCreateOptions to
 qcow2_create2()
References: <20180111195225.4226-1-kwolf@redhat.com>
 <20180111195225.4226-5-kwolf@redhat.com>
In-Reply-To: <20180111195225.4226-5-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-11 20:52, Kevin Wolf wrote:
> All of the simple options are now passed to qcow2_create2() in a
> BlockdevCreateOptions object. Still missing: node-name and the
> encryption options.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qcow2.c | 186 ++++++++++++++++++++++++++++++++++++++++++++++----=
--------
>  1 file changed, 148 insertions(+), 38 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index b02bc39a01..09e567324d 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2690,12 +2697,11 @@ static uint64_t qcow2_opt_get_refcount_bits_del=
(QemuOpts *opts, int version,
>      return refcount_bits;
>  }
> =20
> -static int qcow2_create2(BlockDriverState *bs, int64_t total_size,
> -                         const char *backing_file, const char *backing=
_format,
> -                         int flags, size_t cluster_size, PreallocMode =
prealloc,
> -                         QemuOpts *opts, int version, int refcount_ord=
er,
> -                         const char *encryptfmt, Error **errp)
> +static int qcow2_create2(BlockDriverState *bs,
> +                         BlockdevCreateOptions *create_options,

I'd personally really prefer this to be const...

> +                         QemuOpts *opts, const char *encryptfmt, Error=
 **errp)
>  {
> +    BlockdevCreateOptionsQcow2 *qcow2_opts;
>      QDict *options;
> =20
>      /*
> @@ -2712,10 +2718,88 @@ static int qcow2_create2(BlockDriverState *bs, =
int64_t total_size,

[...]

> +
> +    if (!qcow2_opts->has_preallocation) {
> +        qcow2_opts->preallocation =3D PREALLOC_MODE_OFF;
> +    }
> +    if (qcow2_opts->backing_file &&
> +        qcow2_opts->preallocation !=3D PREALLOC_MODE_OFF)
> +    {
> +        error_setg(errp, "Backing file and preallocation cannot be use=
d at "
> +                   "the same time");
> +        return -EINVAL;
> +    }
> +
> +    if (!qcow2_opts->has_lazy_refcounts) {
> +        qcow2_opts->lazy_refcounts =3D false;

=2E..because modifying some ideally QMP-provided objects just looks wrong=
=2E

[...]

> @@ -2804,18 +2888,26 @@ static int qcow2_create2(BlockDriverState *bs, =
int64_t total_size,

[...]

>      /* Want a backing file? There you go.*/
> -    if (backing_file) {
> -        ret =3D bdrv_change_backing_file(blk_bs(blk), backing_file, ba=
cking_format);
> +    if (qcow2_opts->has_backing_file) {
> +        const char *backing_format =3D NULL;
> +
> +        if (qcow2_opts->has_backing_fmt) {
> +            backing_format =3D BlockdevDriver_str(qcow2_opts->backing_=
fmt);
> +        }

has_backing_fmt && !has_backing_file should probably be an error.

Max

> +
> +        ret =3D bdrv_change_backing_file(blk_bs(blk), qcow2_opts->back=
ing_file,
> +                                       backing_format);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "Could not assign backing fil=
e '%s' "
> -                             "with format '%s'", backing_file, backing=
_format);
> +                             "with format '%s'", qcow2_opts->backing_f=
ile,
> +                             backing_format);
>              goto out;
>          }
>      }


--LCwRgzM0j3crP0Copg5SkVeohkrFIuNx1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpvVfMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AKskH/1JFCyUUZ2Jfcpc0I2nnZiMjMNqrAQAv
jnRTmO5Q3/ZI9ZKQ2tSl6gxi8S/hThcnwt0bwd2h9UGNiOlkfIL7bvaH/i4kdRWr
ORitQl69IV8XaYPkdvIOM68vWJqk1IAxs5k65LtVgnL7+49HwcVGa5acborN5p/1
L2K/rLBCeeoMtK7wNf+FNdy7FLARYrcgjF1Cg03B4SpNSuw1xXI+qE6hyLgrkTpL
yTb1iuS1BcTtcwBOqlKvKIciVVBNzsfF28Xfg3bFiZio9bGo1xsrwfZhNjb8zBYF
6DVPmO32zM4yoTswG4wAYxiupqbeQV6oAMI/jhQUxfogvN2kZBnEc2w=
=TOyC
-----END PGP SIGNATURE-----

--LCwRgzM0j3crP0Copg5SkVeohkrFIuNx1--
