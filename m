Received: from eggs.gnu.org ([2001:4830:134:3::10]:40535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evV9K-0008Db-Eo
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:38:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1evV9J-0001if-6j
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:38:30 -0400
References: <20180309214611.19122-1-kwolf@redhat.com>
	<20180309214611.19122-7-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <6907a015-63a5-071d-e01a-d3ebac3e457e@redhat.com>
Date: Mon, 12 Mar 2018 22:38:19 +0100
MIME-Version: 1.0
In-Reply-To: <20180309214611.19122-7-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cDAPN7O2YozJK0DOa24CjWEK8r4p64o0m"
Subject: Re: [Qemu-devel] [PATCH 6/7] vhdx: Support .bdrv_co_create
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cDAPN7O2YozJK0DOa24CjWEK8r4p64o0m
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: den@openvz.org, jcody@redhat.com, eblake@redhat.com, qemu-devel@nongnu.org
Message-ID: <6907a015-63a5-071d-e01a-d3ebac3e457e@redhat.com>
Subject: Re: [PATCH 6/7] vhdx: Support .bdrv_co_create
References: <20180309214611.19122-1-kwolf@redhat.com>
 <20180309214611.19122-7-kwolf@redhat.com>
In-Reply-To: <20180309214611.19122-7-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-09 22:46, Kevin Wolf wrote:
> This adds the .bdrv_co_create driver callback to vhdx, which
> enables image creation over QMP.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  qapi/block-core.json |  37 ++++++++++-
>  block/vhdx.c         | 174 ++++++++++++++++++++++++++++++++++++++-----=
--------
>  2 files changed, 167 insertions(+), 44 deletions(-)
>=20
> diff --git a/qapi/block-core.json b/qapi/block-core.json
> index 2eba0eef7e..3a65909c47 100644
> --- a/qapi/block-core.json
> +++ b/qapi/block-core.json
> @@ -3699,6 +3699,41 @@
>              '*static':          'bool' } }
> =20
>  ##
> +# @BlockdevVhdxSubformat:
> +#
> +# @dynamic: Growing image file
> +# @fixed:   Preallocated fixed-size imge file
> +#
> +# Since: 2.12
> +##
> +{ 'enum': 'BlockdevVhdxSubformat',
> +  'data': [ 'dynamic', 'fixed' ] }
> +
> +##
> +# @BlockdevCreateOptionsVhdx:
> +#
> +# Driver specific image creation options for vhdx.
> +#
> +# @file             Node to create the image format on
> +# @size             Size of the virtual disk in bytes
> +# @log-size         Log size in bytes (default: 1 MB)
> +# @block-size       Block size in bytes (default: 1 MB)

Is it?  Currently, the default size is actually 0 and you keep that by a
simple "block_size =3D vhdx_opts->block_size;" assignment.  But the old
help text also states: "0 means auto-calculate based on image size."
This is reflected in the code, even after this patch.  0 can mean 8, 16,
32, or 64 MB.

> +# @subformat        vhdx subformat (default: dynamic)
> +# @block-state-zero Force use of payload blocks of type 'ZERO'. Non-st=
andard,
> +#                   but default.  Do not set to 'off' when using 'qemu=
-img
> +#                   convert' with subformat=3Ddynamic.
> +#
> +# Since: 2.12
> +##
> +{ 'struct': 'BlockdevCreateOptionsVhdx',
> +  'data': { 'file':                 'BlockdevRef',
> +            'size':                 'size',
> +            '*log-size':            'size',
> +            '*block-size':          'size',
> +            '*subformat':           'BlockdevVhdxSubformat',
> +            '*block-state-zero':    'bool' } }
> +
> +##
>  # @BlockdevCreateNotSupported:
>  #
>  # This is used for all drivers that don't support creating images.

[...]

> index d82350d07c..0ce972381f 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c

[...]

> @@ -1792,54 +1797,63 @@ exit:
>   *    .---- ~ ----------- ~ ------------ ~ ---------------- ~ --------=
---.
>   *   1MB
>   */
> -static int coroutine_fn vhdx_co_create_opts(const char *filename, Qemu=
Opts *opts,
> -                                            Error **errp)
> +static int coroutine_fn vhdx_co_create(BlockdevCreateOptions *opts,
> +                                       Error **errp)
>  {

[...]

> =20
> -    if (!strcmp(type, "dynamic")) {
> +    switch (vhdx_opts->subformat) {
> +    case BLOCKDEV_VHDX_SUBFORMAT_DYNAMIC:
>          image_type =3D VHDX_TYPE_DYNAMIC;
> -    } else if (!strcmp(type, "fixed")) {
> +        break;
> +    case BLOCKDEV_VHDX_SUBFORMAT_FIXED:
>          image_type =3D VHDX_TYPE_FIXED;
> -    } else if (!strcmp(type, "differencing")) {
> -        error_setg_errno(errp, ENOTSUP,
> -                         "Differencing files not yet supported");
> -        ret =3D -ENOTSUP;
> -        goto exit;
> -    } else {
> -        error_setg(errp, "Invalid subformat '%s'", type);
> -        ret =3D -EINVAL;
> -        goto exit;
> +        break;
> +    default:
> +        g_assert_not_reached();
>      }

As a follow-up, it might be reasonable to replace VHDXImageType by
BlockdevVhdxSubformat.

> =20
>      /* These are pretty arbitrary, and mainly designed to keep the BAT=

> @@ -1865,21 +1879,17 @@ static int coroutine_fn vhdx_co_create_opts(con=
st char *filename, QemuOpts *opts

There is some code not shown here that silently rounds the log_size and
the block_size to 1 MB, and...

>      block_size =3D block_size > VHDX_BLOCK_SIZE_MAX ? VHDX_BLOCK_SIZE_=
MAX :
>                                                      block_size;

=2E..this.  In other drivers you seemed to follow the approach of not
doing this kind of rounding in the blockdev-create path but only in the
legacy interface.  Is there a reason for doing it differently here?

Max

> =20
> -    ret =3D bdrv_create_file(filename, opts, &local_err);
> -    if (ret < 0) {
> -        error_propagate(errp, local_err);
> -        goto exit;
> +    /* Create BlockBackend to write to the image */
> +    bs =3D bdrv_open_blockdev_ref(vhdx_opts->file, errp);
> +    if (bs =3D=3D NULL) {
> +        return -EIO;
>      }
> =20
> -    blk =3D blk_new_open(filename, NULL, NULL,
> -                       BDRV_O_RDWR | BDRV_O_RESIZE | BDRV_O_PROTOCOL,
> -                       &local_err);
> -    if (blk =3D=3D NULL) {
> -        error_propagate(errp, local_err);
> -        ret =3D -EIO;
> -        goto exit;
> +    blk =3D blk_new(BLK_PERM_WRITE | BLK_PERM_RESIZE, BLK_PERM_ALL);
> +    ret =3D blk_insert_bs(blk, bs, errp);
> +    if (ret < 0) {
> +        goto delete_and_exit;
>      }
> -
>      blk_set_allow_write_beyond_eof(blk, true);
> =20
>      /* Create (A) */


--cDAPN7O2YozJK0DOa24CjWEK8r4p64o0m
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqm80sSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AJP8H/2IzVaNGfxlflW0xKlEcdX7aoMTbvyPa
PlVx0MllsCLUBTtw8XRw5mg+8cJRNKlwiNF6HE32NPNBwWNsd6CUtBY6yy4Kl3P4
dN+7sqyEk74DkpBy2DGdxGEghN5ngM7+yGiY+5BHi2fYmDlw17qZOqck6vl1hmNz
PqCzkDs6AFCvuwbGoiS91bCN/UzBwQLdInJ9aeQu7GeHvuE3xFmUR0wARZwzjWSb
Y1QopiSodmFV1XIIsbmMzFOgaRvexl5Qk9txn2fZwyHDT2uYV2ytTnnbp+FdpxY/
a9yVS48uIabFtu/YLYX3wZMZu9oY4zcpxrjT0POEdkCjR/P2H5ZAsB8=
=QgjF
-----END PGP SIGNATURE-----

--cDAPN7O2YozJK0DOa24CjWEK8r4p64o0m--
