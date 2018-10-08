Received: from eggs.gnu.org ([2001:4830:134:3::10]:50064)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9cVE-00085u-RR
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9cVE-0004U8-0i
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 16:51:44 -0400
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
	<20180817122219.16206-8-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d78f37ac-343d-20bf-a2ce-16ff2fa12677@redhat.com>
Date: Mon, 8 Oct 2018 22:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180817122219.16206-8-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Zt2aOac1k5es2WdaNVprOCwDKRbxGEroG"
Subject: Re: [Qemu-devel] [PATCH v2 7/7] block/qcow2-refcount: fix
 out-of-file L2 entries to be read-as-zero
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
--Zt2aOac1k5es2WdaNVprOCwDKRbxGEroG
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, eblake@redhat.com, den@openvz.org
Message-ID: <d78f37ac-343d-20bf-a2ce-16ff2fa12677@redhat.com>
Subject: Re: [PATCH v2 7/7] block/qcow2-refcount: fix out-of-file L2 entries
 to be read-as-zero
References: <20180817122219.16206-1-vsementsov@virtuozzo.com>
 <20180817122219.16206-8-vsementsov@virtuozzo.com>
In-Reply-To: <20180817122219.16206-8-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.08.18 14:22, Vladimir Sementsov-Ogievskiy wrote:
> Rewrite corrupted L2 table entry, which reference space out of
> underlying file.
>=20
> Make this L2 table entry read-as-all-zeros without any allocation.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 3c004e5bfe..3de3768a3c 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1720,8 +1720,30 @@ static int check_refcounts_l2(BlockDriverState *=
bs, BdrvCheckResult *res,
>              /* Mark cluster as used */
>              csize =3D (((l2_entry >> s->csize_shift) & s->csize_mask) =
+ 1) *
>                      BDRV_SECTOR_SIZE;
> +            if (csize > s->cluster_size) {
> +                ret =3D fix_l2_entry_to_zero(
> +                        bs, res, fix, l2_offset, i, active,
> +                        "compressed cluster larger than cluster: size =
0x%"
> +                        PRIx64, csize);
> +                if (ret < 0) {
> +                    goto fail;
> +                }
> +                continue;
> +            }
> +

This seems recoverable, isn't it?  Can we not try to just limit the
csize, or decompress the cluster with the given csize from the given
offset, disregarding the cluster limit?

>              coffset =3D l2_entry & s->cluster_offset_mask &
>                        ~(BDRV_SECTOR_SIZE - 1);
> +            if (coffset >=3D bdrv_getlength(bs->file->bs)) {
> +                ret =3D fix_l2_entry_to_zero(
> +                        bs, res, fix, l2_offset, i, active,
> +                        "compressed cluster out of file: offset 0x%" P=
RIx64,
> +                        coffset);
> +                if (ret < 0) {
> +                    goto fail;
> +                }
> +                continue;
> +            }
> +
>              ret =3D qcow2_inc_refcounts_imrt(bs, res,
>                                             refcount_table, refcount_ta=
ble_size,
>                                             coffset, csize);
> @@ -1748,6 +1770,16 @@ static int check_refcounts_l2(BlockDriverState *=
bs, BdrvCheckResult *res,
>          {
>              uint64_t offset =3D l2_entry & L2E_OFFSET_MASK;
> =20
> +            if (offset >=3D bdrv_getlength(bs->file->bs)) {
> +                ret =3D fix_l2_entry_to_zero(
> +                        bs, res, fix, l2_offset, i, active,
> +                        "cluster out of file: offset 0x%" PRIx64, offs=
et);
> +                if (ret < 0) {
> +                    goto fail;
> +                }
> +                continue;
> +            }
> +

These other two look OK, but they have another issue:  If this is a v2
image, you cannot create zero clusters; so you'll have to unallocate the
cluster in that case.

Max


--Zt2aOac1k5es2WdaNVprOCwDKRbxGEroG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu7w1UACgkQ9AfbAGHV
z0DWTQf/ZQLgzOpAIhGo8yjjFVA+pHMKEefREgpR7D+4ODsl2f4ZcSR3BjQAYV16
P+PdcVQ2KEwyZKiVx5RBEpX1JGWc3NJD+HSPLjuVKpPgHbsIIiiRLKpzxdyJFmET
te4MUaKkmWWS+AYgn5q6IBFes6bwIqUhNk6HQ18FGV9ivgTiYqLeMvO8EmkhssAd
SoTN3lJPQzMjVu/EC8/lxpSjyDhgC9ODcnwwOx1C4DXpSKbyQ8p/MXbtZ7ce6kJ8
QNmnjupItII+XAU9SHeXNobKABV6CdrivuWsvvsPnPCLq+wZ5MysIKHLWQxj3YbO
KyeJbVgTroe9B7eVU2UA1tpLKlqjWA==
=tF5/
-----END PGP SIGNATURE-----

--Zt2aOac1k5es2WdaNVprOCwDKRbxGEroG--
