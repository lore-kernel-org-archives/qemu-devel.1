Received: from eggs.gnu.org ([2001:4830:134:3::10]:59705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEMsD-0006XB-Re
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:02:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cEMsC-0007Wc-R5
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 16:02:01 -0500
References: <20161203181914.7467-1-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
Date: Tue, 6 Dec 2016 22:01:45 +0100
MIME-Version: 1.0
In-Reply-To: <20161203181914.7467-1-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="iE1trte7PjPnptLaAJ1XjFAUtcfmdhxrQ"
Subject: Re: [Qemu-devel] [PATCH] qcow2: Discard/zero clusters by byte count
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--iE1trte7PjPnptLaAJ1XjFAUtcfmdhxrQ
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>
Message-ID: <0c1ad753-561b-62c9-cdd6-2dfebb020b2b@redhat.com>
Subject: Re: [PATCH] qcow2: Discard/zero clusters by byte count
References: <20161203181914.7467-1-eblake@redhat.com>
In-Reply-To: <20161203181914.7467-1-eblake@redhat.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 03.12.2016 19:19, Eric Blake wrote:
> Passing a byte offset, but sector count, when we ultimately
> want to operate on cluster granularity, is madness.  Clean up
> the interfaces to take byte offset and count.  Rename
> qcow2_discard_clusters() and qcow2_zero_clusters() to the
> shorter qcow2_discard() and qcow2_zero() to make sure backports
> don't get confused by changed units.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> ---
>=20
> 2.9 material, depends on 'Don't strand clusters near 2G intervals
> during commit'
>=20
>  block/qcow2.h          |  8 ++++----
>  block/qcow2-cluster.c  | 20 +++++++++++---------
>  block/qcow2-snapshot.c |  7 +++----
>  block/qcow2.c          | 22 ++++++++++------------
>  4 files changed, 28 insertions(+), 29 deletions(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 1823414..a0d169b 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -543,10 +543,10 @@ uint64_t qcow2_alloc_compressed_cluster_offset(Bl=
ockDriverState *bs,
>                                           int compressed_size);
>=20
>  int qcow2_alloc_cluster_link_l2(BlockDriverState *bs, QCowL2Meta *m);
> -int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
> -    int nb_sectors, enum qcow2_discard_type type, bool full_discard);
> -int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_=
sectors,
> -                        int flags);
> +int qcow2_discard(BlockDriverState *bs, uint64_t offset, uint64_t coun=
t,
> +                  enum qcow2_discard_type type, bool full_discard);
> +int qcow2_zero(BlockDriverState *bs, uint64_t offset, uint64_t count,
> +               int flags);
>=20
>  int qcow2_expand_zero_clusters(BlockDriverState *bs,
>                                 BlockDriverAmendStatusCB *status_cb,
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 928c1e2..3ee0815 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1511,19 +1511,17 @@ static int discard_single_l2(BlockDriverState *=
bs, uint64_t offset,
>      return nb_clusters;
>  }
>=20
> -int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
> -    int nb_sectors, enum qcow2_discard_type type, bool full_discard)
> +int qcow2_discard(BlockDriverState *bs, uint64_t offset, uint64_t coun=
t,
> +                  enum qcow2_discard_type type, bool full_discard)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t end_offset;
>      uint64_t nb_clusters;
>      int ret;
>=20
> -    end_offset =3D offset + (nb_sectors << BDRV_SECTOR_BITS);
> -
> -    /* Round start up and end down */
> +    /* Round start up and end down to cluster boundary */
> +    end_offset =3D start_of_cluster(s, offset + count);
>      offset =3D align_offset(offset, s->cluster_size);
> -    end_offset =3D start_of_cluster(s, end_offset);
>=20
>      if (offset > end_offset) {
>          return 0;
> @@ -1595,20 +1593,24 @@ static int zero_single_l2(BlockDriverState *bs,=
 uint64_t offset,
>      return nb_clusters;
>  }
>=20
> -int qcow2_zero_clusters(BlockDriverState *bs, uint64_t offset, int nb_=
sectors,
> -                        int flags)
> +int qcow2_zero(BlockDriverState *bs, uint64_t offset, uint64_t count,
> +               int flags)

Hmm, I personally liked qcow2_zero_clusters() better. qcow2_zero()
doesn't really express that it means the verb "to zero".

Also, while you are making a good point why the function should be
renamed, qcow2_zero_clusters() was much more accurate because offset and
count are expected to be cluster-aligned.

The only alternative I can come up with would be "qcow2_write_zeroes";
that at least solves the first issue I have with this, but not the
second one...

>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t nb_clusters;
>      int ret;
>=20
> +    /* Block layer guarantees cluster alignment */

Hm, it's rather qcow2_co_pwrite_zeroes(), isn't it? The block layer will
split unaligned requests into head, body and tail and it will still
submit head and tail (though separately).

As far as I can see, it's qcow2_co_pwrite_zeroes() which then guarantees
that only the aligned part gets through to qcow2_zero().


The patch looks good apart from these nit picks, though.

Max

> +    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> +    assert(QEMU_IS_ALIGNED(count, s->cluster_size));
> +
>      /* The zero flag is only supported by version 3 and newer */
>      if (s->qcow_version < 3) {
>          return -ENOTSUP;
>      }
>=20
>      /* Each L2 table is handled by its own loop iteration */
> -    nb_clusters =3D size_to_clusters(s, nb_sectors << BDRV_SECTOR_BITS=
);
> +    nb_clusters =3D size_to_clusters(s, count);
>=20
>      s->cache_discards =3D true;



--iE1trte7PjPnptLaAJ1XjFAUtcfmdhxrQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlhHJzkSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArboIAL7B5p0i9VsOKdU5urH2LKjZJw/7URvS
J1gLBnK03gaUyLogO66Er+1N35KNPFnHFtPVDqP5XCWKDoPpnqpL2Lx8sXUO1QtI
pn1q7qOv4kPc0t5cYSKbAL6mD9ggY0lEK062MlK6aQeqZm7f+EKfLkAI6PYwKvMC
E6b1YbY36qYmczMg86/2VHNhpA4UPkB0tzFBkJkKe00uo5cLQy57txiHna5dTsvp
Mkp6uSgd+S6i+872vHeHPfftx1FctAQNcmsUM0TWN9cQl51MxZsHUy1vlICi8/NT
5a9YOn7jlB8WMhJYp3FyjFv1WJi7g2Bffkd/pIwqEwanXgeNsIouuTg=
=CEqc
-----END PGP SIGNATURE-----

--iE1trte7PjPnptLaAJ1XjFAUtcfmdhxrQ--
