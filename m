Received: from eggs.gnu.org ([209.51.188.92]:52819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzVj-00072C-3c
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:44:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gyzVW-00030H-W2
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 08:44:25 -0500
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
	<20181214134240.217870-3-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <24b5583c-98c0-5ef7-dce7-9386ed059b06@redhat.com>
Date: Wed, 27 Feb 2019 13:26:32 +0100
MIME-Version: 1.0
In-Reply-To: <20181214134240.217870-3-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oPxu5rmv6BdRPylXPCdZSt65oiU7uBhNO"
Subject: Re: [Qemu-devel] [PATCH v4 2/5] qcow2-refcount: avoid eating RAM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oPxu5rmv6BdRPylXPCdZSt65oiU7uBhNO
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, den@openvz.org
Message-ID: <24b5583c-98c0-5ef7-dce7-9386ed059b06@redhat.com>
Subject: Re: [PATCH v4 2/5] qcow2-refcount: avoid eating RAM
References: <20181214134240.217870-1-vsementsov@virtuozzo.com>
 <20181214134240.217870-3-vsementsov@virtuozzo.com>
In-Reply-To: <20181214134240.217870-3-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 14.12.18 14:42, Vladimir Sementsov-Ogievskiy wrote:
> qcow2_inc_refcounts_imrt() (through realloc_refcount_array()) can eat
> an unpredictable amount of memory on corrupted table entries, which are=

> referencing regions far beyond the end of file.
>=20
> Prevent this, by skipping such regions from further processing.

Is it actually wrong to reference clusters beyond the EOF?

Hmm...  The spec says everywhere "offset into the image file" (except
for L2 entries pointing to data clusters, but let's say that's just a
mistake).  This implies that offsets have to be within the confines of
the file, OK.

> Interesting that iotest 138 checks exactly the behavior which we fix
> here. So, change the test appropriately.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/qcow2-refcount.c     | 18 ++++++++++++++++++
>  tests/qemu-iotests/138     | 12 +++++-------
>  tests/qemu-iotests/138.out |  5 ++++-
>  3 files changed, 27 insertions(+), 8 deletions(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index b717fdecc6..c41c1fbe00 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1505,12 +1505,30 @@ int qcow2_inc_refcounts_imrt(BlockDriverState *=
bs, BdrvCheckResult *res,
>  {
>      BDRVQcow2State *s =3D bs->opaque;
>      uint64_t start, last, cluster_offset, k, refcount;
> +    int64_t file_len;
>      int ret;
> =20
>      if (size <=3D 0) {
>          return 0;
>      }
> =20
> +    file_len =3D bdrv_getlength(bs->file->bs);

I just had to delete a paragraph where I was questioning the use of
bdrv_getlength() here again, because I remembered I did that before and
decided to give in...

> +    if (file_len < 0) {
> +        return file_len;
> +    }
> +
> +    /* Last cluster of qcow2 image may be semi-allocated, so it's may =
be OK to

With s/it's/it/:

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +     * reference some space after file end but it should be less than =
one
> +     * cluster.
> +     */
> +    if (offset + size - file_len >=3D s->cluster_size) {
> +        fprintf(stderr, "ERROR: counting reference for region exceedin=
g the "
> +                "end of the file by one cluster or more: offset 0x%" P=
RIx64
> +                " size 0x%" PRIx64 "\n", offset, size);
> +        res->corruptions++;
> +        return 0;
> +    }
> +
>      start =3D start_of_cluster(s, offset);
>      last =3D start_of_cluster(s, offset + size - 1);
>      for(cluster_offset =3D start; cluster_offset <=3D last;
> diff --git a/tests/qemu-iotests/138 b/tests/qemu-iotests/138
> index eccbcae3a6..12e20762e5 100755
> --- a/tests/qemu-iotests/138
> +++ b/tests/qemu-iotests/138
> @@ -54,15 +54,13 @@ $QEMU_IO -c 'write 0 512' "$TEST_IMG" | _filter_qem=
u_io
>  # Put the data cluster at a multiple of 2 TB, resulting in the image a=
pparently
>  # having a multiple of 2^32 clusters
>  # (To be more specific: It is at 32 PB)
> -poke_file "$TEST_IMG" 2048 "\x80\x80\x00\x00\x00\x00\x00\x00"
> +poke_file "$TEST_IMG" $((2048 + 8)) "\x00\x80\x00\x00\x00\x00\x00\x00"=

> =20
>  # An offset of 32 PB results in qemu-img check having to allocate an i=
n-memory
> -# refcount table of 128 TB (16 bit refcounts, 512 byte clusters).
> -# This should be generally too much for any system and thus fail.
> -# What this test is checking is that the qcow2 driver actually tries t=
o allocate
> -# such a large amount of memory (and is consequently aborting) instead=
 of having
> -# truncated the cluster count somewhere (which would result in much le=
ss memory
> -# being allocated and then a segfault occurring).
> +# refcount table of 128 TB (16 bit refcounts, 512 byte clusters), if q=
emu-img
> +# don't check that referenced data cluster is far beyond the end of fi=
le.
> +# But starting from 4.0, qemu-img does this check, and instead of "Can=
not
> +# allocate memory", we have an error showing that l2 entry is invalid.=

>  _check_test_img
> =20
>  # success, all done
> diff --git a/tests/qemu-iotests/138.out b/tests/qemu-iotests/138.out
> index 3fe911f85a..aca7d47a80 100644
> --- a/tests/qemu-iotests/138.out
> +++ b/tests/qemu-iotests/138.out
> @@ -5,5 +5,8 @@ QA output created by 138
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D512
>  wrote 512/512 bytes at offset 0
>  512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> -qemu-img: Check failed: Cannot allocate memory
> +ERROR: counting reference for region exceeding the end of the file by =
one cluster or more: offset 0x80000000000000 size 0x200
> +
> +1 errors were found on the image.
> +Data may be corrupted, or further writes to the image may corrupt it.
>  *** done
>=20



--oPxu5rmv6BdRPylXPCdZSt65oiU7uBhNO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlx2gfgACgkQ9AfbAGHV
z0DU8wf/VQyQjlipuWYVYD/pXIal0jHD2/M6O58871O3aP4HNUmUSfspHnB9PIan
klPXbCbpIk6Vq82lPgvLL4U6mBuPC9nK8DOY+Uw2bIZk9UB+p7jc1G6bsgb4GMhv
efHdKDCtAuON2GWYYyeflA8NmLPoizEGHDrrB1wCgaG+A9sIN3fmpKhjHBzlZ++R
cTlcxC6zawhe9zmE0QETCs6V+8FC/iYNNbsH0LCjOAI+sEy5CdGi+mHEGUu/mhJF
QqghQGLTYFJy4Nv4lhTy8lgrjCjrsNMEFnFo/YF1+LXkllTJy2hJjIYJidpR04VP
/+xImpqoFK7tQZ6gpK4ZY9olUF9g2w==
=ztNN
-----END PGP SIGNATURE-----

--oPxu5rmv6BdRPylXPCdZSt65oiU7uBhNO--
