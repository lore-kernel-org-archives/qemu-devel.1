Received: from eggs.gnu.org ([2001:4830:134:3::10]:40755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcqYx-00074T-EW
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcqYw-00024F-Ht
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 06:07:35 -0400
Date: Wed, 2 Aug 2017 11:07:24 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170802100724.GD5531@stefanha-x1.localdomain>
References: <20170801134907.31253-1-el13635@mail.ntua.gr>
	<20170801134907.31253-4-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="P+33d92oIH25kiaB"
Content-Disposition: inline
In-Reply-To: <20170801134907.31253-4-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 3/3] block: remove legacy I/O throttling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--P+33d92oIH25kiaB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2017 at 04:49:07PM +0300, Manos Pitsidianakis wrote:
> diff --git a/block.c b/block.c
> index 9ebdba28b0..c6aad25286 100644
> --- a/block.c
> +++ b/block.c
> @@ -1975,6 +1975,7 @@ BdrvChild *bdrv_root_attach_child(BlockDriverState =
*child_bs,
>      child =3D g_new(BdrvChild, 1);
>      *child =3D (BdrvChild) {
>          .bs             =3D NULL,
> +        .parent_bs      =3D NULL,
>          .name           =3D g_strdup(child_name),
>          .role           =3D child_role,
>          .perm           =3D perm,
> @@ -2009,6 +2010,7 @@ BdrvChild *bdrv_attach_child(BlockDriverState *pare=
nt_bs,
>      if (child =3D=3D NULL) {
>          return NULL;
>      }
> +    child->parent_bs =3D parent_bs;
> =20
>      QLIST_INSERT_HEAD(&parent_bs->children, child, next);
>      return child;
> @@ -3729,6 +3731,12 @@ const char *bdrv_get_parent_name(const BlockDriver=
State *bs)
>                  return name;
>              }
>          }
> +        if (c->parent_bs && c->parent_bs->implicit) {
> +            name =3D bdrv_get_parent_name(c->parent_bs);
> +            if (name && *name) {
> +                return name;
> +            }
> +        }
>      }
> =20
>      return NULL;

This should be a separate patch.

Who updates parent_bs if the parent is changed (e.g.
bdrv_replace_node())?

We already have bs->parents.  Why is BdrvChild->parent_bs needed?

> -void blk_io_limits_disable(BlockBackend *blk)
> +void blk_io_limits_disable(BlockBackend *blk, Error **errp)
>  {
> -    assert(blk->public.throttle_group_member.throttle_state);
> -    bdrv_drained_begin(blk_bs(blk));

Is it safe to drop drained_begin?  We must ensure that no I/O requests
run during this function.

> -    throttle_group_unregister_tgm(&blk->public.throttle_group_member);
> -    bdrv_drained_end(blk_bs(blk));
> +    BlockDriverState *bs, *throttle_node;
> +
> +    throttle_node =3D blk_get_public(blk)->throttle_node;

Is blk_get_public() still necessary?  Perhaps we can do away with the
concept of the public struct now.  It doesn't need to be done in this
patch though.

> +
> +    assert(throttle_node && throttle_node->refcnt =3D=3D 1);

Are you sure the throttle_node->refcnt =3D=3D 1 assertion holds?  For
example, does the built-in NBD server have a reference to the throttle
node if nbd-server-add is called after throttling has been enabled?

Since we have the blk->throttle_node pointer we know we're the owner.
Others may be using the node too but we may choose to remove it at any
time.

--P+33d92oIH25kiaB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZgaRcAAoJEJykq7OBq3PI8e0IALEKALiVPGSjgncv2eZv7W1y
woENyF41cgT03KiBamNtFPJRsDh/76jqMX9gsl17InUKVseOIkvavL8XCfdxEc6g
RsBGoJPBjwRR2okKWyOvRCnA012AerF3TXRdTEWqDhIfcKvU6ky4O5VRWD0zt9+F
6rV9KD+5RIUOW8FCj/nojGwe22we4yqdous3r8StlivJl/rdXFLxYb/s+D/FTEQI
TKq/mSsIAlMUrER8OL/sSkXWFPUP8Z79Dl2Y/JkjqalUPfSFDg2I7IHKjdgjV4/7
55pWUcMpfFCxP3i0jOihjWa4TkgVmnqTI0z62bk6SO0Rld9PqAR3+2WK4dhFUK0=
=3+xK
-----END PGP SIGNATURE-----

--P+33d92oIH25kiaB--
