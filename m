Received: from eggs.gnu.org ([2001:4830:134:3::10]:35982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kGJ-0002nK-Vz
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:55:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d6kGI-0003if-O2
	for qemu-devel@nongnu.org; Fri, 05 May 2017 16:55:40 -0400
References: <20170504030755.1001-1-eblake@redhat.com>
	<20170504030755.1001-6-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e387660-e081-624b-f8fd-b0de8cd5034a@redhat.com>
Date: Fri, 5 May 2017 22:55:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170504030755.1001-6-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="sRD5RqVB4AKtq5IMBK5OHel4GTgKi8Ddp"
Subject: Re: [Qemu-devel] [PATCH v12 05/10] qcow2: Optimize zero_single_l2()
 to minimize L2 churn
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sRD5RqVB4AKtq5IMBK5OHel4GTgKi8Ddp
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, kwolf@redhat.com
Message-ID: <0e387660-e081-624b-f8fd-b0de8cd5034a@redhat.com>
Subject: Re: [PATCH v12 05/10] qcow2: Optimize zero_single_l2() to minimize L2
 churn
References: <20170504030755.1001-1-eblake@redhat.com>
 <20170504030755.1001-6-eblake@redhat.com>
In-Reply-To: <20170504030755.1001-6-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04.05.2017 05:07, Eric Blake wrote:
> Similar to discard_single_l2(), we should try to avoid dirtying
> the L2 cache when the cluster we are changing already has the
> right characteristics.
>=20
> Note that by the time we get to zero_single_l2(), BDRV_REQ_MAY_UNMAP
> is a requirement to unallocate a cluster (this is because the block
> layer clears that flag if discard.* flags during open requested that
> we never punch holes - see the conversation around commit 170f4b2e,
> https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg07306.html).
> Therefore, this patch can only reuse a zero cluster as-is if either
> unmapping is not requested, or if the zero cluster was not associated
> with an allocation.
>=20
> Technically, there are some cases where an unallocated cluster
> already reads as all zeroes (namely, when there is no backing file
> [easy: check bs->backing], or when the backing file also reads as
> zeroes [harder: we can't check bdrv_get_block_status since we are
> already holding the lock]), where the guest would not immediately see
> a difference if we left that cluster unallocated.  But if the user
> did not request unmapping, leaving an unallocated cluster is wrong;
> and even if the user DID request unmapping, keeping a cluster
> unallocated risks a subtle semantic change of guest-visible contents
> if a backing file is later added, and it is not worth auditing
> whether all internal uses such as mirror properly avoid an unmap
> request.  Thus, this patch is intentionally limited to just clusters
> that are already marked as zero.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v12: store cluster type in temporary
> v11: reserved for blkdebug half of v10
> v10: new patch, replacing earlier attempt to use unallocated clusters,
> and ditching any optimization of v2 files
> ---
>  block/qcow2-cluster.c | 15 +++++++++++++--
>  1 file changed, 13 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 14e2086..78fbe34 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1599,6 +1599,7 @@ static int zero_single_l2(BlockDriverState *bs, u=
int64_t offset,
>      int l2_index;
>      int ret;
>      int i;
> +    bool unmap =3D !!(flags & BDRV_REQ_MAY_UNMAP);
>=20
>      ret =3D get_cluster_table(bs, offset, &l2_table, &l2_index);
>      if (ret < 0) {
> @@ -1611,12 +1612,22 @@ static int zero_single_l2(BlockDriverState *bs,=
 uint64_t offset,
>=20
>      for (i =3D 0; i < nb_clusters; i++) {
>          uint64_t old_offset;
> +        int cluster_type;

Hm, why doesn't this enum have a name yet... Well, if only *someone*
could address that. */me ducks*

Max

>=20
>          old_offset =3D be64_to_cpu(l2_table[l2_index + i]);
>=20
> -        /* Update L2 entries */
> +        /*
> +         * Minimize L2 changes if the cluster already reads back as
> +         * zeroes with correct allocation.
> +         */
> +        cluster_type =3D qcow2_get_cluster_type(old_offset);
> +        if (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_PLAIN ||
> +            (cluster_type =3D=3D QCOW2_CLUSTER_ZERO_ALLOC && !unmap)) =
{
> +            continue;
> +        }
> +
>          qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);=

> -        if (old_offset & QCOW_OFLAG_COMPRESSED || flags & BDRV_REQ_MAY=
_UNMAP) {
> +        if (cluster_type =3D=3D QCOW2_CLUSTER_COMPRESSED || unmap) {
>              l2_table[l2_index + i] =3D cpu_to_be64(QCOW_OFLAG_ZERO);
>              qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_R=
EQUEST);
>          } else {
>=20



--sRD5RqVB4AKtq5IMBK5OHel4GTgKi8Ddp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkM5sESHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ApC8H/0I/6QZ/oUYmIfLmwY8ToSXkVvVU5E1m
dKdbk0dbRgrSl1wN2KuDgYyTIcGlnpQAVjaw4RncAc6KTTrDlLFF4+gHqIAC5vcf
rrTIwJWopjxrlxvBT/Fq9RiiqVxdnIuOCgShcItbcJyEirLqxXarg7KOeBPX/Unp
oUNKnTTA4Zjpg7YXhOUYyGEd2eNfMXbptC9XouH4V4CfS00uPAGPElf4ztH8dTnE
p3S4ZVGhKNfo/BxJH7A1hqBayRIzoHDA11Xgfz9P3J/G5LrQqqFFViDYdn/o3NM+
Koh9O7/P+mUk+UOfI212ww2JfvuGy5smJ8Dtnr1wK3r9jLIJ5VfHXzo=
=3Ipt
-----END PGP SIGNATURE-----

--sRD5RqVB4AKtq5IMBK5OHel4GTgKi8Ddp--
