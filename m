Received: from eggs.gnu.org ([208.118.235.92]:47947)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKgm-0005Pe-Vn
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:42:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ehKfi-0002zC-UR
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 14:38:28 -0500
References: <cover.1516978645.git.berto@igalia.com>
	<0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <4c401bce-cdc8-9c70-7d16-c101ef72e291@redhat.com>
Date: Thu, 1 Feb 2018 20:26:26 +0100
MIME-Version: 1.0
In-Reply-To: <0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="bAnSp1Mty87tw2w5ar4aBNEZ6arkZiiYI"
Subject: Re: [Qemu-devel] [PATCH v3 27/39] qcow2: Update
 qcow2_update_snapshot_refcount() to support L2 slices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>, "Denis V . Lunev" <den@openvz.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bAnSp1Mty87tw2w5ar4aBNEZ6arkZiiYI
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>,
 "Denis V . Lunev" <den@openvz.org>
Message-ID: <4c401bce-cdc8-9c70-7d16-c101ef72e291@redhat.com>
Subject: Re: [PATCH v3 27/39] qcow2: Update qcow2_update_snapshot_refcount()
 to support L2 slices
References: <cover.1516978645.git.berto@igalia.com>
 <0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
In-Reply-To: <0c07738db12f556285f8db01d68c5d6b4304bde9.1516978645.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-01-26 15:59, Alberto Garcia wrote:
> qcow2_update_snapshot_refcount() increases the refcount of all
> clusters of a given snapshot. In order to do that it needs to load all
> its L2 tables and iterate over their entries. Since we'll be loading
> L2 slices instead of full tables we need to add an extra loop that
> iterates over all slices of each L2 table.
>=20
> This function doesn't need any additional changes so apart from that
> this patch simply updates the variable name from l2_table to l2_slice.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c | 31 +++++++++++++++++--------------
>  1 file changed, 17 insertions(+), 14 deletions(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index dfa28301c4..60b521cb89 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1183,17 +1183,20 @@ int qcow2_update_snapshot_refcount(BlockDriverS=
tate *bs,
>      int64_t l1_table_offset, int l1_size, int addend)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> -    uint64_t *l1_table, *l2_table, l2_offset, entry, l1_size2, refcoun=
t;
> +    uint64_t *l1_table, *l2_slice, l2_offset, entry, l1_size2, refcoun=
t;
>      bool l1_allocated =3D false;
>      int64_t old_entry, old_l2_offset;
> +    unsigned slice, slice_size2, n_slices;

Hm, well. Hm.

>      int i, j, l1_modified =3D 0, nb_csectors;
>      int ret;
> =20
>      assert(addend >=3D -1 && addend <=3D 1);
> =20
> -    l2_table =3D NULL;
> +    l2_slice =3D NULL;
>      l1_table =3D NULL;
>      l1_size2 =3D l1_size * sizeof(uint64_t);
> +    slice_size2 =3D s->l2_slice_size * sizeof(uint64_t);
> +    n_slices =3D s->cluster_size / slice_size2;
> =20
>      s->cache_discards =3D true;
> =20

[...]

> @@ -1273,12 +1276,13 @@ int qcow2_update_snapshot_refcount(BlockDriverS=
tate *bs,
>                      case QCOW2_CLUSTER_NORMAL:
>                      case QCOW2_CLUSTER_ZERO_ALLOC:
>                          if (offset_into_cluster(s, offset)) {
> +                            int l2_index =3D slice * s->l2_slice_size =
+ j;
>                              qcow2_signal_corruption(
>                                  bs, true, -1, -1, "Cluster "
>                                  "allocation offset %#" PRIx64
>                                  " unaligned (L2 offset: %#"
>                                  PRIx64 ", L2 index: %#x)",
> -                                offset, l2_offset, j);
> +                                offset, l2_offset, l2_index);

This makes it a bit weird that in other patches l2_index is now
generally the L2 slice index...

Oh well.

Reviewed-by: Max Reitz <mreitz@redhat.com>

>                              ret =3D -EIO;
>                              goto fail;
>                          }


--bAnSp1Mty87tw2w5ar4aBNEZ6arkZiiYI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlpzaeISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AeX0IAL7tRzqkV8639rGr4+ywZuMKHcrNrgQf
wxzzpSolvA8DN09Yip0p9GCOqlFSoeZgvfgqgd9j12GUl2P7D/+8Ej1sM+MiN7S9
jezue3NdcbwdBrBNP5COE1GYFZxQ1Oh8j7ByYPU+s5yebgygnBO1T0F8lnE2BRL6
Z1JjhPLZC7lL40T56uS3MEIKIcTuzlnHqAlUSf5DOZUv1fRrgbG0Koo8bkSxlATM
uxK/g+ux841DwECkjF5Dpj9lgFqvKnpQ8nWaXlJW7WZizK4jL/eVW3jolOtMHMIr
pZJwhYTkqPq670p7tc6ERi/2PF9xJnPBEvJWkUbfgjF7SCHVf0kIA88=
=vx2J
-----END PGP SIGNATURE-----

--bAnSp1Mty87tw2w5ar4aBNEZ6arkZiiYI--
