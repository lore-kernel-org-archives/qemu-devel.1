Received: from eggs.gnu.org ([2001:4830:134:3::10]:46566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4A38-0004wW-L5
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:51:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4A37-0004lk-CY
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 13:51:22 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-4-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5957bbf1-3093-e95a-73c5-ea5f5b9da3db@redhat.com>
Date: Fri, 28 Apr 2017 19:51:10 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3snOQe2g30S7v2UxSOro1Qr9hR7cHTFX1"
Subject: Re: [Qemu-devel] [PATCH v10 03/17] qcow2: Reuse preallocated zero
 clusters
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
--3snOQe2g30S7v2UxSOro1Qr9hR7cHTFX1
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <5957bbf1-3093-e95a-73c5-ea5f5b9da3db@redhat.com>
Subject: Re: [PATCH v10 03/17] qcow2: Reuse preallocated zero clusters
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-4-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-4-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> From: Max Reitz <mreitz@redhat.com>
>=20
> Instead of just freeing preallocated zero clusters and completely
> allocating them from scratch, reuse them.
>=20
> We cannot do this in handle_copied(), however, since this is a COW
> operation. Therefore, we have to add the new logic to handle_alloc() an=
d
> simply return the existing offset if it exists. The only catch is that
> we have to convince qcow2_alloc_cluster_link_l2() not to free the old
> clusters (because we have reused them).
>=20
> Reported-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: new patch. Max hasn't posted the patch directly on list, but
> did mention it here:
> https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg03936.html
> and that he would post it once he has tests. Well, my later patches
> add a test that requires this one :)  The other two patches that
> he mentioned there are also good, but not essential for my series
> (and I didn't want to write tests to expose the behavior difference,
> because it would deprive Max of that fun).

Well, the main reason I didn't send the patches yet is because I was
tired while writing them ("Date: Sat Apr 22 01:17:52 2017 +0200") and I
wanted to take another look before sending them. I guess now's as good a
time as any.

> ---
>  block/qcow2.h         |  3 ++
>  block/qcow2-cluster.c | 83 +++++++++++++++++++++++++++++++++++--------=
--------
>  2 files changed, 60 insertions(+), 26 deletions(-)

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index d1063df..db3d937 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c

[...]

> @@ -1192,31 +1199,53 @@ static int handle_alloc(BlockDriverState *bs, u=
int64_t guest_offset,
>       * wrong with our code. */
>      assert(nb_clusters > 0);
>=20
> +    if (!*host_offset && qcow2_get_cluster_type(entry) =3D=3D QCOW2_CL=
USTER_ZERO &&
> +        (entry & L2E_OFFSET_MASK) !=3D 0 && (entry & QCOW_OFLAG_COPIED=
))

*host_offset works with this, too, if
start_of_cluster(s, *host_offset) =3D=3D (entry & L2E_OFFSET_MASK).

If !(entry & QCOW_OFLAG_COPIED), we should check whether the refcount
maybe is 1 and then set OFLAG_COPIED. But that is something we don't
even do for normal clusters yet, so it's something to fix another day.

> +    {
> +        /* Try to reuse preallocated zero clusters; contiguous normal =
clusters
> +         * would be fine, too, but count_cow_clusters() above has limi=
ted
> +         * nb_clusters already to a range of COW clusters */
> +        int preallocated_nb_clusters =3D
> +            count_contiguous_clusters(nb_clusters, s->cluster_size, l2=
_table,

s/l2_table/&l2_table[l2_index]/

> +                                      QCOW_OFLAG_COPIED);
> +
> +        if (preallocated_nb_clusters) {

preallocated_nb_clusters must be at least 1, so an assertion would be
better.

Max

> +            nb_clusters =3D preallocated_nb_clusters;
> +            alloc_cluster_offset =3D entry & L2E_OFFSET_MASK;
> +
> +            /* We want to reuse these clusters, so qcow2_alloc_cluster=
_link_l2()
> +             * should not free them. */
> +            keep_old_clusters =3D true;
> +        }
> +    }
> +
>      qcow2_cache_put(bs, s->l2_table_cache, (void **) &l2_table);
>=20
> -    /* Allocate, if necessary at a given offset in the image file */
> -    alloc_cluster_offset =3D start_of_cluster(s, *host_offset);
> -    ret =3D do_alloc_cluster_offset(bs, guest_offset, &alloc_cluster_o=
ffset,
> -                                  &nb_clusters);
> -    if (ret < 0) {
> -        goto fail;
> -    }
> -
> -    /* Can't extend contiguous allocation */
> -    if (nb_clusters =3D=3D 0) {
> -        *bytes =3D 0;
> -        return 0;
> -    }
> -
> -    /* !*host_offset would overwrite the image header and is reserved =
for "no
> -     * host offset preferred". If 0 was a valid host offset, it'd trig=
ger the
> -     * following overlap check; do that now to avoid having an invalid=
 value in
> -     * *host_offset. */
>      if (!alloc_cluster_offset) {
> -        ret =3D qcow2_pre_write_overlap_check(bs, 0, alloc_cluster_off=
set,
> -                                            nb_clusters * s->cluster_s=
ize);
> -        assert(ret < 0);
> -        goto fail;
> +        /* Allocate, if necessary at a given offset in the image file =
*/
> +        alloc_cluster_offset =3D start_of_cluster(s, *host_offset);
> +        ret =3D do_alloc_cluster_offset(bs, guest_offset, &alloc_clust=
er_offset,
> +                                      &nb_clusters);
> +        if (ret < 0) {
> +            goto fail;
> +        }
> +
> +        /* Can't extend contiguous allocation */
> +        if (nb_clusters =3D=3D 0) {
> +            *bytes =3D 0;
> +            return 0;
> +        }
> +
> +        /* !*host_offset would overwrite the image header and is reser=
ved for
> +         * "no host offset preferred". If 0 was a valid host offset, i=
t'd
> +         * trigger the following overlap check; do that now to avoid h=
aving an
> +         * invalid value in *host_offset. */
> +        if (!alloc_cluster_offset) {
> +            ret =3D qcow2_pre_write_overlap_check(bs, 0, alloc_cluster=
_offset,
> +                                                nb_clusters * s->clust=
er_size);
> +            assert(ret < 0);
> +            goto fail;
> +        }
>      }
>=20
>      /*
> @@ -1247,6 +1276,8 @@ static int handle_alloc(BlockDriverState *bs, uin=
t64_t guest_offset,
>          .offset         =3D start_of_cluster(s, guest_offset),
>          .nb_clusters    =3D nb_clusters,
>=20
> +        .keep_old_clusters  =3D keep_old_clusters,
> +
>          .cow_start =3D {
>              .offset     =3D 0,
>              .nb_bytes   =3D offset_into_cluster(s, guest_offset),
>=20



--3snOQe2g30S7v2UxSOro1Qr9hR7cHTFX1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDgQ4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AaxwH/RRIMFGBBhn5p5RV+8boFdx8yv4CM81a
SYmSPx/lHOtTDBoozNg0V+svIcjrGm4WNKWkA76hS9/hwgOochUgCt5/I1AQD4dk
v2SkZz/Wd/KvsJ5qBpFsg9sVh/9hhZSnAY+p2OhNag51JeP8eGvEIusRo6AbZT9o
t0LuItUBBel7DWGksFtKs+UgWoMZeVs2727LxiH+ipdnuAHRECRm6MmExfRNHjCi
JbBmMmbYWxp7FXp1TGy66DWKem2vmucCrMszj8Y7gvg805FQyiutYIEAW/hhw6og
IMi/6npz1y8V3TpaYLQy8s679Mdcp8GxA0XWLfxrToEKGrB+9fZN/9k=
=/4LH
-----END PGP SIGNATURE-----

--3snOQe2g30S7v2UxSOro1Qr9hR7cHTFX1--
