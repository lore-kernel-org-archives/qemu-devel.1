Received: from eggs.gnu.org ([2001:4830:134:3::10]:49463)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4ACb-0006nC-9b
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4ACa-0001yd-5n
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 14:01:09 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-5-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <68eee3c7-a1b2-4011-21e6-1e12b15b90dd@redhat.com>
Date: Fri, 28 Apr 2017 20:00:57 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ovBiJdeiHfmELnp3DDCCI19Sbi2N0el0A"
Subject: Re: [Qemu-devel] [PATCH v10 04/17] qcow2: Optimize zero_single_l2()
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ovBiJdeiHfmELnp3DDCCI19Sbi2N0el0A
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <68eee3c7-a1b2-4011-21e6-1e12b15b90dd@redhat.com>
Subject: Re: [PATCH v10 04/17] qcow2: Optimize zero_single_l2() to minimize L2
 churn
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-5-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-5-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
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
> v10: new patch, replacing earlier attempt to use unallocated clusters,
> and ditching any optimization of v2 files
> ---
>  block/qcow2-cluster.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index db3d937..d542894 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1614,6 +1614,7 @@ static int zero_single_l2(BlockDriverState *bs, u=
int64_t offset,
>      int l2_index;
>      int ret;
>      int i;
> +    bool unmap =3D !!(flags & BDRV_REQ_MAY_UNMAP);
>=20
>      ret =3D get_cluster_table(bs, offset, &l2_table, &l2_index);
>      if (ret < 0) {
> @@ -1629,9 +1630,17 @@ static int zero_single_l2(BlockDriverState *bs, =
uint64_t offset,
>=20
>          old_offset =3D be64_to_cpu(l2_table[l2_index + i]);
>=20
> -        /* Update L2 entries */
> +        /*
> +         * Minimize L2 changes if the cluster already reads back as
> +         * zeroes with correct allocation.
> +         */
> +        if (qcow2_get_cluster_type(old_offset) =3D=3D QCOW2_CLUSTER_ZE=
RO &&
> +            !(unmap && old_offset & L2E_OFFSET_MASK)) {
> +            continue;
> +        }
> +
>          qcow2_cache_entry_mark_dirty(bs, s->l2_table_cache, l2_table);=

> -        if (old_offset & QCOW_OFLAG_COMPRESSED || flags & BDRV_REQ_MAY=
_UNMAP) {
> +        if (old_offset & QCOW_OFLAG_COMPRESSED || unmap) {

Works, but I'd like it better to store the cluster type somewhere and
then use it here instead of checking the COMPRESSED flag.

But it works, so it's up to you:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>              l2_table[l2_index + i] =3D cpu_to_be64(QCOW_OFLAG_ZERO);
>              qcow2_free_any_clusters(bs, old_offset, 1, QCOW2_DISCARD_R=
EQUEST);
>          } else {
>=20



--ovBiJdeiHfmELnp3DDCCI19Sbi2N0el0A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDg1kSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A5jUH/iKubcPfbGV+htQ5pKgrdthhzSWkAHfg
u5tbPy+cNFRrc0tt8rfvN7HCLz5mOmUzPu2Ou9Tv5g5w9PQHx/WKmxoBVrQbEz6W
I59Zd8dqvPztQufN9JvV0SfupfuTDXislmB6higj1p+XgtLF7qCgz7XCJTjTW3Gd
o6nICp08qYy3kXSc2PzLUfbHHcJtO+CqOBdmDdXKIEx6OXP18PWroQwCUyFd9nPd
rBAQ9e9vILFcHmY8hqUGA762ohSsre4JREnFGDSHr/JgxV/fd+sYe8vDi9scEHIO
W8iDxxO6juiILXy5BXY9/fqAXHZdV7DtZKSC6rPSv9Hqu+VnpKXjgaE=
=sT8R
-----END PGP SIGNATURE-----

--ovBiJdeiHfmELnp3DDCCI19Sbi2N0el0A--
