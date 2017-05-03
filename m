Received: from eggs.gnu.org ([2001:4830:134:3::10]:45446)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5z0f-0002vY-De
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:28:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d5z0e-0000Ql-22
	for qemu-devel@nongnu.org; Wed, 03 May 2017 14:28:21 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-12-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0fb599e4-9f19-e0c5-9e71-4e697c43abfd@redhat.com>
Date: Wed, 3 May 2017 20:28:05 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-12-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cNm5GKkh45FoVNWAa9S5LQUpSWpK97T5K"
Subject: Re: [Qemu-devel] [PATCH v10 11/17] qcow2: Discard/zero clusters by
 byte count
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
--cNm5GKkh45FoVNWAa9S5LQUpSWpK97T5K
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <0fb599e4-9f19-e0c5-9e71-4e697c43abfd@redhat.com>
Subject: Re: [PATCH v10 11/17] qcow2: Discard/zero clusters by byte count
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-12-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-12-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> Passing a byte offset, but sector count, when we ultimately
> want to operate on cluster granularity, is madness.  Clean up
> the external interfaces to take both offset and count as bytes,
> while still keeping the assertion added previously that the
> caller must align the values to a cluster.  Then rename things
> to make sure backports don't get confused by changed units:
> instead of qcow2_discard_clusters() and qcow2_zero_clusters(),
> we now have qcow2_cluster_discard() and qcow2_cluster_zeroize().
>=20
> The internal functions still operate on clusters at a time, and
> return an int for number of cleared clusters; but on an image
> with 2M clusters, a single L2 table holds 256k entries that each
> represent a 2M cluster, totalling well over INT_MAX bytes if we
> ever had a request for that many bytes at once.  All our callers
> currently limit themselves to 32-bit bytes (and therefore fewer
> clusters), but by making this function 64-bit clean, we have one
> less place to clean up if we later improve the block layer to
> support 64-bit bytes through all operations (with the block layer
> auto-fragmenting on behalf of more-limited drivers), rather than
> the current state where some interfaces are artificially limited
> to INT_MAX at a time.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: squash in fixup accounting for unaligned file end
> v9: rebase to earlier changes, drop R-b
> v7, v8: only earlier half of series submitted for 2.9
> v6: rebase due to context
> v5: s/count/byte/ to make the units obvious, and rework the math
> to ensure no 32-bit integer overflow on large clusters
> v4: improve function names, split assertion additions into earlier patc=
h
> [no v3 or v2]
> v1: https://lists.gnu.org/archive/html/qemu-devel/2016-12/msg00339.html=

> ---
>  block/qcow2.h          |  9 +++++----
>  block/qcow2-cluster.c  | 40 +++++++++++++++++++++-------------------
>  block/qcow2-snapshot.c |  7 +++----
>  block/qcow2.c          | 21 +++++++++------------
>  4 files changed, 38 insertions(+), 39 deletions(-)

[...]

> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 4f641a9..a47aadc 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1562,16 +1562,16 @@ static int discard_single_l2(BlockDriverState *=
bs, uint64_t offset,
>      return nb_clusters;
>  }
>=20
> -int qcow2_discard_clusters(BlockDriverState *bs, uint64_t offset,
> -    int nb_sectors, enum qcow2_discard_type type, bool full_discard)
> +int qcow2_cluster_discard(BlockDriverState *bs, uint64_t offset,
> +                          uint64_t bytes, enum qcow2_discard_type type=
,
> +                          bool full_discard)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
> -    uint64_t end_offset;
> +    uint64_t end_offset =3D offset + bytes;
>      uint64_t nb_clusters;
> +    int64_t cleared;
>      int ret;
>=20
> -    end_offset =3D offset + (nb_sectors << BDRV_SECTOR_BITS);
> -
>      /* Caller must pass aligned values, except at image end */
>      assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
>      assert(QEMU_IS_ALIGNED(end_offset, s->cluster_size) ||

Applying an s/end_offset - offset/bytes/ to the
nb_clusters =3D size_to_clusters(s, end_offset - offset) following this
would make sense (but won't functionally change anything).

> @@ -1583,13 +1583,15 @@ int qcow2_discard_clusters(BlockDriverState *bs=
, uint64_t offset,
>=20
>      /* Each L2 table is handled by its own loop iteration */
>      while (nb_clusters > 0) {
> -        ret =3D discard_single_l2(bs, offset, nb_clusters, type, full_=
discard);
> -        if (ret < 0) {
> +        cleared =3D discard_single_l2(bs, offset, nb_clusters, type,
> +                                    full_discard);
> +        if (cleared < 0) {
> +            ret =3D cleared;
>              goto fail;
>          }
>=20
> -        nb_clusters -=3D ret;
> -        offset +=3D (ret * s->cluster_size);
> +        nb_clusters -=3D cleared;
> +        offset +=3D (cleared * s->cluster_size);
>      }
>=20
>      ret =3D 0;

[...]

> diff --git a/block/qcow2.c b/block/qcow2.c
> index 8038793..4d34610 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c

[...]

> @@ -2858,18 +2857,16 @@ static int qcow2_make_empty(BlockDriverState *b=
s)
>=20
>      /* This fallback code simply discards every active cluster; this i=
s slow,
>       * but works in all cases */
> -    for (start_sector =3D 0; start_sector < bs->total_sectors;
> -         start_sector +=3D sector_step)
> +    end_offset =3D bs->total_sectors * BDRV_SECTOR_SIZE;
> +    for (offset =3D 0; offset < end_offset; offset +=3D step)
>      {

This opening brace should now be on the previous line.

With at least this fixed (I leave the other thing to your discretion):

Reviewed-by: Max Reitz <mreitz@redhat.com>

>          /* As this function is generally used after committing an exte=
rnal
>           * snapshot, QCOW2_DISCARD_SNAPSHOT seems appropriate. Also, t=
he
>           * default action for this kind of discard is to pass the disc=
ard,
>           * which will ideally result in an actually smaller image file=
, as
>           * is probably desired. */
> -        ret =3D qcow2_discard_clusters(bs, start_sector * BDRV_SECTOR_=
SIZE,
> -                                     MIN(sector_step,
> -                                         bs->total_sectors - start_sec=
tor),
> -                                     QCOW2_DISCARD_SNAPSHOT, true);
> +        ret =3D qcow2_cluster_discard(bs, offset, MIN(step, end_offset=
 - offset),
> +                                    QCOW2_DISCARD_SNAPSHOT, true);
>          if (ret < 0) {
>              break;
>          }
>=20



--cNm5GKkh45FoVNWAa9S5LQUpSWpK97T5K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkKITUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9ArRgIAMQ4qxhAWXMg+GoIpiaPLMvFgjX/FALE
s88ZOgYLU8tMP5JS+3u5cEbjA4AHC0L3W5z+lHIFFT8SJ5YzV61vWLn8bH444dfR
V3jANLRTVtDH2wYV2bA9X+3pXfYLtU8zSngbtqkTA8byv/1baMYrisvvLCyewZWk
sDra4IMOr3Ikii0cJkQyfe5LFTBif7xitDw28nMHGZCOipJo5tFMIl00x74KPiLq
TZFBf9l41M14J/k/AuIKeqTRii8GYaOTATLfr+WQJexGiw8U9BOKtpC6pXUpkOzg
xA1WQQkLfKf6fjXr9/RCQNnApN05xC0F8dqkYalUwvvVt7n41h9Pjzg=
=clsp
-----END PGP SIGNATURE-----

--cNm5GKkh45FoVNWAa9S5LQUpSWpK97T5K--
