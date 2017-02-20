Received: from eggs.gnu.org ([2001:4830:134:3::10]:52952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfnTq-0006Lt-1j
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:54:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cfnTp-0004nL-3t
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 07:54:14 -0500
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
	<1487006583-24350-23-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d87634b5-544c-81ff-29ec-f53b4d7a714c@redhat.com>
Date: Mon, 20 Feb 2017 13:54:04 +0100
MIME-Version: 1.0
In-Reply-To: <1487006583-24350-23-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="D5kDRAa8ctl7hDHoPtThSImxXg2cAopJk"
Subject: Re: [Qemu-devel] [RFC PATCH 22/41] block: Add
 BdrvChildRole.get_link_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--D5kDRAa8ctl7hDHoPtThSImxXg2cAopJk
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <d87634b5-544c-81ff-29ec-f53b4d7a714c@redhat.com>
Subject: Re: [RFC PATCH 22/41] block: Add BdrvChildRole.get_link_name()
References: <1487006583-24350-1-git-send-email-kwolf@redhat.com>
 <1487006583-24350-23-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487006583-24350-23-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 13.02.2017 18:22, Kevin Wolf wrote:
> For meaningful error messages in the permission system, we want to allo=
w
> the parent of a BdrvChild to generate some kind of human-readable
> identifier for the link represented by the BdrvChild.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   |  8 ++++++++
>  block/block-backend.c     | 20 ++++++++++++++++++++
>  include/block/block_int.h |  4 ++++
>  3 files changed, 32 insertions(+)
>=20
> diff --git a/block.c b/block.c
> index fd06549..2116542 100644
> --- a/block.c
> +++ b/block.c
> @@ -800,6 +800,13 @@ const BdrvChildRole child_format =3D {
>      .drained_end     =3D bdrv_child_cb_drained_end,
>  };
> =20
> +static char *bdrv_backing_link_name(BdrvChild *c)
> +{
> +    BlockDriverState *parent =3D c->opaque;
> +    return g_strdup_printf("backing file link from %s",
> +                           bdrv_get_device_or_node_name(parent));

So in this case it's really about the edge in the BDS graph.

> +}
> +
>  /*
>   * Returns the options and flags that bs->backing should get, based on=
 the
>   * given options and flags for the parent BDS
> @@ -825,6 +832,7 @@ static void bdrv_backing_options(int *child_flags, =
QDict *child_options,
>  }
> =20
>  static const BdrvChildRole child_backing =3D {
> +    .get_link_name   =3D bdrv_backing_link_name,
>      .inherit_options =3D bdrv_backing_options,
>      .drained_begin   =3D bdrv_child_cb_drained_begin,
>      .drained_end     =3D bdrv_child_cb_drained_end,
> diff --git a/block/block-backend.c b/block/block-backend.c
> index 0c23add..a314284 100644
> --- a/block/block-backend.c
> +++ b/block/block-backend.c
> @@ -80,6 +80,7 @@ static const AIOCBInfo block_backend_aiocb_info =3D {=

> =20
>  static void drive_info_del(DriveInfo *dinfo);
>  static BlockBackend *bdrv_first_blk(BlockDriverState *bs);
> +static char *blk_get_attached_dev_id(BlockBackend *blk);
> =20
>  /* All BlockBackends */
>  static QTAILQ_HEAD(, BlockBackend) block_backends =3D
> @@ -102,6 +103,24 @@ static void blk_root_drained_end(BdrvChild *child)=
;
>  static void blk_root_change_media(BdrvChild *child, bool load);
>  static void blk_root_resize(BdrvChild *child);
> =20
> +static char *blk_root_get_link_name(BdrvChild *child)
> +{
> +    BlockBackend *blk =3D child->opaque;
> +    char *dev_id;
> +
> +    if (blk->name) {
> +        return g_strdup(blk->name);

This is considering the BB to be an edge in the BDS graph. I find that a
bit weird, and the fact that it makes complete and total sense after
thinking for some time doesn't change the fact that it is weird.

> +    }
> +
> +    dev_id =3D blk_get_attached_dev_id(blk);
> +    if (*dev_id) {
> +        return dev_id;

But the device model OTOH is definitely not an edge in the BDS graph.

> +    } else {
> +        g_free(dev_id);
> +        return g_strdup("a block device");
> +    }
> +}
> +
>  static const char *blk_root_get_name(BdrvChild *child)
>  {
>      return blk_name(child->opaque);

[...]

Also, I'm curious what you are going to choose as a replacement if the
function pointer is not set. I have a couple of ideas, but most of them
are either not correct or would remove the need for
bdrv_backing_link_name()... Well, I'm curious. :-)

Max


--D5kDRAa8ctl7hDHoPtThSImxXg2cAopJk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliq5uwSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A0q0IAI/ONNteEBnb/CIvmp2qA6LZ3/ZG8A/E
CoCRx4j7lDo5BEhyTSuyjpHyFcriypH4R8MJ8SzO/qQkK9tcKP1ICIlRFmYJCq1W
EttQP390E1DkvMFJ2ysqw6bYS17JJwzwzlhGIB0gcKWyRYYUorZqHxBixcj+Ljlq
jTEut4oVBksPfr0kTmKYY+1bqkrJaVqnN/pc0nlRD1EU1Cm0aE85mtl3qA0Zi1ZP
Ch7U4/Q5clxICubn0NA0yQcn8Humubqq656aclJYGBGz06z4VFlhKnMGHgGctvYY
FsqErDIguZ0amKm3EH7KKGwmdHc8fMaaz2plWn2QUNcxfP1kfcplsnY=
=MlVF
-----END PGP SIGNATURE-----

--D5kDRAa8ctl7hDHoPtThSImxXg2cAopJk--
