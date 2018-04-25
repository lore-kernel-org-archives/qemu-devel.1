Received: from eggs.gnu.org ([2001:4830:134:3::10]:36046)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBLeg-000711-Rw
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:44:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fBLef-0003E2-Eu
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:44:22 -0400
References: <20180423223337.82366-1-eblake@redhat.com>
	<20180423223337.82366-5-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
Date: Wed, 25 Apr 2018 16:44:12 +0200
MIME-Version: 1.0
In-Reply-To: <20180423223337.82366-5-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="9qY4b6Myb2iTvbsul2BpfQG5k8OY6Afho"
Subject: Re: [Qemu-devel] [PATCH v5 4/5] qcow2: Don't allow overflow during
 cluster allocation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9qY4b6Myb2iTvbsul2BpfQG5k8OY6Afho
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, berto@igalia.com
Message-ID: <3fb4c5dd-bb6f-e965-30f2-cafd0e3a2d2c@redhat.com>
Subject: Re: [PATCH v5 4/5] qcow2: Don't allow overflow during cluster
 allocation
References: <20180423223337.82366-1-eblake@redhat.com>
 <20180423223337.82366-5-eblake@redhat.com>
In-Reply-To: <20180423223337.82366-5-eblake@redhat.com>
Content-Type: multipart/mixed;
 boundary="------------36DEA582FE1347B418331CAA"

--------------36DEA582FE1347B418331CAA
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-04-24 00:33, Eric Blake wrote:
> Our code was already checking that we did not attempt to
> allocate more clusters than what would fit in an INT64 (the
> physical maximimum if we can access a full off_t's worth of
> data).  But this does not catch smaller limits enforced by
> various spots in the qcow2 image description: L1 and normal
> clusters of L2 are documented as having bits 63-56 reserved
> for other purposes, capping our maximum offset at 64PB (bit
> 55 is the maximum bit set).  And for compressed images with
> 2M clusters, the cap drops the maximum offset to bit 48, or
> a maximum offset of 512TB.  If we overflow that offset, we
> would write compressed data into one place, but try to
> decompress from another, which won't work.
>=20
> I don't have 512TB handy to prove whether things break if we
> compress so much data that we overflow that limit, and don't
> think that iotests can (quickly) test it either.  Test 138
> comes close (it corrupts an image into thinking something lives
> at 32PB, which is half the maximum for L1 sizing - although
> it relies on 512-byte clusters).  But that test points out
> that we will generally hit other limits first (such as running
> out of memory for the refcount table, or exceeding file system
> limits like 16TB on ext4, etc), so this is more a theoretical
> safety valve than something likely to be hit.

You don't need 512 TB, though, 36 MB is sufficient.

Here's what you do:
(1) Create a 513 TB image with cluster_size=3D2M,refcount_bits=3D1
(2) Take a hex editor and enter 16 refblocks into the reftable
(3) Fill all of those refblocks with 1s

(Funny side note: qemu-img check thinks that image is clean because it
doesn't check refcounts beyond the image end...)

I've attached a compressed test image (unsurprisingly, it compresses
really well).

Before this series:
$ ./qemu-io -c 'write -c 0 2M' test.qcow2
qcow2: Marking image as corrupt: Preventing invalid write on metadata
(overlaps with refcount block); further corruption events will be suppres=
sed
write failed: Input/output error

Aw.

After this series:
$ ./qemu-io -c 'write -c 0 2M' test.qcow2
write failed: Input/output error

(Normal writes just work fine.)


Maybe you want to add a test still -- creating the image is rather quick
(well, you have to write 64 MB of 1s, but other than that).  The only
thing that takes a bit of time is qemu figuring out where the first free
cluster is...  That takes like 15 seconds here.

And another issue of course is...

$ ls -lhs test.qcow2
42M -rw-r--r--. 1 maxx maxx 513T 25. Apr 16:42 test.qcow2

Yeah, that.  Depends on the host file system, of course, whether that is
a real issue. O:-)

Max

> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Alberto Garcia <berto@igalia.com>
>=20
> ---
> v3: use s->cluster_offset_mask instead of open-coding it [Berto],
> use MIN() to clamp offset on small cluster size, add spec patch
> first to justify clamping even on refcount allocations
> ---
>  block/qcow2.h          |  6 ++++++
>  block/qcow2-refcount.c | 21 ++++++++++++++-------
>  2 files changed, 20 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/qcow2.h b/block/qcow2.h
> index 1df15a18aa1..a3b9faa9d53 100644
> --- a/block/qcow2.h
> +++ b/block/qcow2.h
> @@ -41,6 +41,12 @@
>  #define QCOW_MAX_CRYPT_CLUSTERS 32
>  #define QCOW_MAX_SNAPSHOTS 65536
>=20
> +/* Field widths in qcow2 mean normal cluster offsets cannot reach
> + * 64PB; depending on cluster size, compressed clusters can have a
> + * smaller limit (64PB for up to 16k clusters, then ramps down to
> + * 512TB for 2M clusters).  */
> +#define QCOW_MAX_CLUSTER_OFFSET ((1ULL << 56) - 1)
> +
>  /* 8 MB refcount table is enough for 2 PB images at 64k cluster size
>   * (128 GB for 512 byte clusters, 2 EB for 2 MB clusters) */
>  #define QCOW_MAX_REFTABLE_SIZE 0x800000
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 6bfc11bb48f..fcbea3c9644 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -31,7 +31,8 @@
>  #include "qemu/bswap.h"
>  #include "qemu/cutils.h"
>=20
> -static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t siz=
e);
> +static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t siz=
e,
> +                                    uint64_t max);
>  static int QEMU_WARN_UNUSED_RESULT update_refcount(BlockDriverState *b=
s,
>                              int64_t offset, int64_t length, uint64_t a=
ddend,
>                              bool decrease, enum qcow2_discard_type typ=
e);
> @@ -362,7 +363,8 @@ static int alloc_refcount_block(BlockDriverState *b=
s,
>      }
>=20
>      /* Allocate the refcount block itself and mark it as used */
> -    int64_t new_block =3D alloc_clusters_noref(bs, s->cluster_size);
> +    int64_t new_block =3D alloc_clusters_noref(bs, s->cluster_size,
> +                                             QCOW_MAX_CLUSTER_OFFSET);=

>      if (new_block < 0) {
>          return new_block;
>      }
> @@ -954,7 +956,8 @@ int qcow2_update_cluster_refcount(BlockDriverState =
*bs,
>=20
>=20
>  /* return < 0 if error */
> -static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t siz=
e)
> +static int64_t alloc_clusters_noref(BlockDriverState *bs, uint64_t siz=
e,
> +                                    uint64_t max)
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t i, nb_clusters, refcount;
> @@ -979,9 +982,9 @@ retry:
>      }
>=20
>      /* Make sure that all offsets in the "allocated" range are represe=
ntable
> -     * in an int64_t */
> +     * in the requested max */
>      if (s->free_cluster_index > 0 &&
> -        s->free_cluster_index - 1 > (INT64_MAX >> s->cluster_bits))
> +        s->free_cluster_index - 1 > (max >> s->cluster_bits))
>      {
>          return -EFBIG;
>      }
> @@ -1001,7 +1004,7 @@ int64_t qcow2_alloc_clusters(BlockDriverState *bs=
, uint64_t size)
>=20
>      BLKDBG_EVENT(bs->file, BLKDBG_CLUSTER_ALLOC);
>      do {
> -        offset =3D alloc_clusters_noref(bs, size);
> +        offset =3D alloc_clusters_noref(bs, size, QCOW_MAX_CLUSTER_OFF=
SET);
>          if (offset < 0) {
>              return offset;
>          }
> @@ -1083,7 +1086,11 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, =
int size)
>      free_in_cluster =3D s->cluster_size - offset_into_cluster(s, offse=
t);
>      do {
>          if (!offset || free_in_cluster < size) {
> -            int64_t new_cluster =3D alloc_clusters_noref(bs, s->cluste=
r_size);
> +            int64_t new_cluster;
> +
> +            new_cluster =3D alloc_clusters_noref(bs, s->cluster_size,
> +                                               MIN(s->cluster_offset_m=
ask,
> +                                                   QCOW_MAX_CLUSTER_OF=
FSET));
>              if (new_cluster < 0) {
>                  return new_cluster;
>              }
>=20


--------------36DEA582FE1347B418331CAA
Content-Type: application/x-xz;
 name="test.qcow2.xz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="test.qcow2.xz"

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
scRn+wIAAAAABFla
--------------36DEA582FE1347B418331CAA--

--9qY4b6Myb2iTvbsul2BpfQG5k8OY6Afho
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlrglDwACgkQ9AfbAGHV
z0ANxQgAhAWka4Pdurf7PXKDcPoLiFY7UtRFuTc2zKNfbxVLFNkXPGtE7ERRE9QU
uSJSqkCzYQhatQ5gqSNYwRu9/toG977vh7OXAunD4/YIIqhJBcCXMenqwOpuoEHd
Ujg7hjAcU3wrFobwZKjd7PUb5+oB3zTIZsEZ5UJrLJu3FjQ+Lvh5GZaqhjuSo21u
udrmLsl66DvuN2mlan0hylZNBqruoSsdiU2Qono2pROP+lH5xnzPuRXmGWCfdJLs
JXIVtP5uEmgXuKfxV44deri1zT1Fv3jD7Y+CnyFyZDcR46RdtoFZ58GPdneloVvp
JnVYebKp0/DW7G2w9ULindEhICALqQ==
=Teyc
-----END PGP SIGNATURE-----

--9qY4b6Myb2iTvbsul2BpfQG5k8OY6Afho--
