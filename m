Received: from eggs.gnu.org ([2001:4830:134:3::10]:56756)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJI8-0003GY-HN
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:28:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAJI7-0004GM-Cx
	for qemu-devel@nongnu.org; Thu, 02 Nov 2017 13:28:32 -0400
References: <cover.1509550787.git.berto@igalia.com>
	<49d365124cf0bffb3fe705678b50b86445d42605.1509550787.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <21c91b89-d4bf-f220-958a-eec02dddc9a4@redhat.com>
Date: Thu, 2 Nov 2017 18:28:18 +0100
MIME-Version: 1.0
In-Reply-To: <49d365124cf0bffb3fe705678b50b86445d42605.1509550787.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cBKusS0MCN5gstjUe7QrWAFAQqua23uxF"
Subject: Re: [Qemu-devel] [PATCH 1/4] qcow2: Prevent allocating refcount
 blocks at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cBKusS0MCN5gstjUe7QrWAFAQqua23uxF
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <21c91b89-d4bf-f220-958a-eec02dddc9a4@redhat.com>
Subject: Re: [PATCH 1/4] qcow2: Prevent allocating refcount blocks at offset 0
References: <cover.1509550787.git.berto@igalia.com>
 <49d365124cf0bffb3fe705678b50b86445d42605.1509550787.git.berto@igalia.com>
In-Reply-To: <49d365124cf0bffb3fe705678b50b86445d42605.1509550787.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-01 16:42, Alberto Garcia wrote:
> Each entry in the qcow2 cache contains an offset field indicating the
> location of the data in the qcow2 image. If the offset is 0 then it
> means that the entry contains no data and is available to be used when
> needed.
>=20
> Because of that it is not possible to store in the cache the first
> cluster of the qcow2 image (offset =3D 0). This is not a problem becaus=
e
> that cluster always contains the qcow2 header and we're not using this
> cache for that.
>=20
> However, if the qcow2 image is corrupted it can happen that we try to
> allocate a new refcount block at offset 0, triggering this assertion
> and crashing QEMU:
>=20
>   qcow2_cache_entry_mark_dirty: Assertion `c->entries[i].offset !=3D 0'=
 failed
>=20
> This patch adds an explicit check for this scenario and a new test
> case.
>=20
> This problem was originally reported here:
>=20
>    https://bugs.launchpad.net/qemu/+bug/1728615
>=20
> Reported-by: R.Nageswara Sastry <nasastry@in.ibm.com>
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c     |  7 +++++++
>  tests/qemu-iotests/060     | 11 +++++++++++
>  tests/qemu-iotests/060.out |  8 ++++++++
>  3 files changed, 26 insertions(+)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index aa3fd6cf17..9059996c4b 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -367,6 +367,13 @@ static int alloc_refcount_block(BlockDriverState *=
bs,
>          return new_block;
>      }
> =20
> +    /* If we're allocating the block at offset 0 then something is wro=
ng */
> +    if (new_block =3D=3D 0) {
> +        qcow2_signal_corruption(bs, true, -1, -1, "Preventing invalid =
"

Technically, the offset is 0 and the size is s->cluster_size, but I
won't insist.

Reviewed-by: Max Reitz <mreitz@redhat.com>

> +                                "allocation of refcount block at offse=
t 0");
> +        return -EIO;
> +    }
> +
>  #ifdef DEBUG_ALLOC2
>      fprintf(stderr, "qcow2: Allocate refcount block %d for %" PRIx64
>          " at %" PRIx64 "\n",
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index 8e95c450eb..dead26aeaf 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -242,6 +242,17 @@ poke_file "$TEST_IMG" "$(($l2_offset+8))" "\x80\x0=
0\x00\x00\x00\x06\x2a\x00"
>  # Should emit two error messages
>  $QEMU_IO -c "discard 0 64k" -c "read 64k 64k" "$TEST_IMG" | _filter_qe=
mu_io
> =20
> +echo
> +echo "=3D=3D=3D Testing empty refcount table with valid L1 and L2 tabl=
es =3D=3D=3D"
> +echo
> +_make_test_img 64M
> +$QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
> +poke_file "$TEST_IMG" "$rt_offset"        "\x00\x00\x00\x00\x00\x00\x0=
0\x00"
> +# Since the first data cluster is already allocated this triggers an
> +# allocation with an explicit offset (using qcow2_alloc_clusters_at())=

> +# causing a refcount block to be allocated at offset 0
> +$QEMU_IO -c "write 0 128k" "$TEST_IMG" | _filter_qemu_io
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
> index 5ca3af491f..872719009c 100644
> --- a/tests/qemu-iotests/060.out
> +++ b/tests/qemu-iotests/060.out
> @@ -181,4 +181,12 @@ qcow2: Marking image as corrupt: Cluster allocatio=
n offset 0x62a00 unaligned (L2
>  discard 65536/65536 bytes at offset 0
>  64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>  read failed: Input/output error
> +
> +=3D=3D=3D Testing empty refcount table with valid L1 and L2 tables =3D=
=3D=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +wrote 65536/65536 bytes at offset 0
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +qcow2: Marking image as corrupt: Preventing invalid allocation of refc=
ount block at offset 0; further corruption events will be suppressed
> +write failed: Input/output error
>  *** done
>=20



--cBKusS0MCN5gstjUe7QrWAFAQqua23uxF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln7VbISHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AnPgH/RgA3jPm9kBwx4Gbt0R1Vo0wdKnIS3qx
Af72qNGHGlzXDG5k1kCGInVPP3oPRsiACp2rwEsPWmYkqE2A9LfsDIXBdY1UZrUn
0MZA0zmIs8KwUsxFNrE6el868MnAH658QVqOjd4KA0vebSeUpiRwUkqkUSZUeP+e
92T2LjYAZqZvU2LpPX4Kvex/cWOmRi7eD4nww7DY3lzotIgbVeR9V2LRlhewTkYS
7s5SNGVSnVwQLN2YwVD3pvn8+H1QXuoU6L7lD6CmgYlaLccox8GP+LuRGwE18xC/
feG3Ztk0qj57/JQpo8vv+8k7T3j6W9oO2RcLMSTUTseg+tW9pna4aew=
=kMGY
-----END PGP SIGNATURE-----

--cBKusS0MCN5gstjUe7QrWAFAQqua23uxF--
