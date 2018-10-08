Received: from eggs.gnu.org ([2001:4830:134:3::10]:33694)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Xe7-0004QQ-2o
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:40:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Xe6-0004OY-CH
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 11:40:35 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-4-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cbe06072-1ee8-59bf-32ef-2271042e3881@redhat.com>
Date: Mon, 8 Oct 2018 17:40:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180817122219.16206-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ifUnXOgT3Gw07e3DNF1MBEc58oxa6koHe"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] block/qcow2-refcount:
 check_refcounts_l2: refactor compressed case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ifUnXOgT3Gw07e3DNF1MBEc58oxa6koHe
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <cbe06072-1ee8-59bf-32ef-2271042e3881@redhat.com>
Subject: Re: [PATCH v2 3/7] block/qcow2-refcount: check_refcounts_l2: refactor
 compressed case
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-4-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
> Separate offset and size of compressed cluster.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 566c19fbfa..0ea01e3ee2 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1570,7 +1570,7 @@ static int check_refcounts_l2(BlockDriverState *b=
s, BdrvCheckResult *res,
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t *l2_table, l2_entry;
>      uint64_t next_contiguous_offset =3D 0;
> -    int i, l2_size, nb_csectors, ret;
> +    int i, l2_size, ret;
> =20
>      /* Read L2 table from disk */
>      l2_size =3D s->l2_size * sizeof(uint64_t);
> @@ -1589,6 +1589,9 @@ static int check_refcounts_l2(BlockDriverState *b=
s, BdrvCheckResult *res,
> =20
>          switch (qcow2_get_cluster_type(l2_entry)) {
>          case QCOW2_CLUSTER_COMPRESSED:
> +        {
> +            int64_t csize, coffset;
> +
>              /* Compressed clusters don't have QCOW_OFLAG_COPIED */
>              if (l2_entry & QCOW_OFLAG_COPIED) {
>                  fprintf(stderr, "ERROR: coffset=3D0x%" PRIx64 ": "
> @@ -1599,12 +1602,13 @@ static int check_refcounts_l2(BlockDriverState =
*bs, BdrvCheckResult *res,
>              }
> =20
>              /* Mark cluster as used */
> -            nb_csectors =3D ((l2_entry >> s->csize_shift) &
> -                           s->csize_mask) + 1;
> -            l2_entry &=3D s->cluster_offset_mask;
> +            csize =3D (((l2_entry >> s->csize_shift) & s->csize_mask) =
+ 1) *
> +                    BDRV_SECTOR_SIZE;
> +            coffset =3D l2_entry & s->cluster_offset_mask &
> +                      ~(BDRV_SECTOR_SIZE - 1);

This should actually be 512 instead of BDRV_SECTOR_SIZE (or the former
may be a shift by 9 bits), because this is about qcow2 and not about the
block layer's sector size.

(Other places in the qcow2 driver handling compressed clusters use 512
or shift by 9, too.)

Max

>              ret =3D qcow2_inc_refcounts_imrt(bs, res,
>                                             refcount_table, refcount_ta=
ble_size,
> -                                           l2_entry & ~511, nb_csector=
s * 512);
> +                                           coffset, csize);
>              if (ret < 0) {
>                  goto fail;
>              }
> @@ -1621,6 +1625,7 @@ static int check_refcounts_l2(BlockDriverState *b=
s, BdrvCheckResult *res,
>                  res->bfi.fragmented_clusters++;
>              }
>              break;
> +        }
> =20
>          case QCOW2_CLUSTER_ZERO_ALLOC:
>          case QCOW2_CLUSTER_NORMAL:
>=20



--ifUnXOgT3Gw07e3DNF1MBEc58oxa6koHe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7emQACgkQ9AfbAGHV
z0CHCAf/TqMzystBlUz0Mx0rovCShanTtKV0Oi1hUMnqwyTGC7iC+ykWgXz/bops
Q5JFvoH/APvovsVccLi6cvPP404Zs+/CHWew+jxilfVW7tVDO1dfxDVDo+Bcpn0X
XcfaNKCGKrbRqdT6ivSmTUGSCIhhZQcKjSL4QowDL/hPki9MhjpoouiUbVGrMI2f
w33YcpTenUc21wJytw94hDvL0a3uPTD6dsvGfxfXS59a5GxFgrG8B/8YDGIl4kY/
mNUtiUmC8o1sNUbC9tUcDyoNDA9oVJkv2qE9FhgGFZRvuqsCuOmi2BorpG+ddME/
JXe35LXWmUcGn3UrUgPjpey2v7y7Lw==
=ubdy
-----END PGP SIGNATURE-----

--ifUnXOgT3Gw07e3DNF1MBEc58oxa6koHe--
