Received: from eggs.gnu.org ([2001:4830:134:3::10]:59258)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4Cok-00062S-7B
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:48:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d4Coi-0007WU-3a
	for qemu-devel@nongnu.org; Fri, 28 Apr 2017 16:48:42 -0400
References: <20170427014626.11553-1-eblake@redhat.com>
	<20170427014626.11553-10-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
Date: Fri, 28 Apr 2017 22:48:29 +0200
MIME-Version: 1.0
In-Reply-To: <20170427014626.11553-10-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Gm6Qk7h10uNkQJNISN0m4dnc2GVqTFVlF"
Subject: Re: [Qemu-devel] [PATCH v10 09/17] qcow2: Optimize write zero of
 unaligned tail cluster
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
--Gm6Qk7h10uNkQJNISN0m4dnc2GVqTFVlF
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <7f062c75-44bb-7305-c519-26471da74b3d@redhat.com>
Subject: Re: [PATCH v10 09/17] qcow2: Optimize write zero of unaligned tail
 cluster
References: <20170427014626.11553-1-eblake@redhat.com>
 <20170427014626.11553-10-eblake@redhat.com>
In-Reply-To: <20170427014626.11553-10-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 27.04.2017 03:46, Eric Blake wrote:
> We've already improved discards to operate efficiently on the tail
> of an unaligned qcow2 image; it's time to make a similar improvement
> to write zeroes.  The special case is only valid at the tail
> cluster of a file, where we must recognize that any sectors beyond
> the image end would implicitly read as zero, and therefore should
> not penalize our logic for widening a partial cluster into writing
> the whole cluster as zero.
>=20
> Update test 154 to cover the new scenarios, using two images of
> intentionally differing length.
>=20
> While at it, fix the test to gracefully skip when run as
> ./check -qcow2 -o compat=3D0.10 154
> since the older format lacks zero clusters already required earlier
> in the test.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v10: rebase to better reporting of preallocated zero clusters
> v9: new patch
> ---
>  block/qcow2.c              |   7 +++
>  tests/qemu-iotests/154     | 112 +++++++++++++++++++++++++++++++++++++=
+++++++-
>  tests/qemu-iotests/154.out |  83 +++++++++++++++++++++++++++++++++
>  3 files changed, 200 insertions(+), 2 deletions(-)
>=20
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 5c1573c..8038793 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -2449,6 +2449,10 @@ static bool is_zero_sectors(BlockDriverState *bs=
, int64_t start,
>      BlockDriverState *file;
>      int64_t res;
>=20
> +    if (start + count > bs->total_sectors) {
> +        count =3D bs->total_sectors - start;
> +    }
> +
>      if (!count) {
>          return true;
>      }
> @@ -2467,6 +2471,9 @@ static coroutine_fn int qcow2_co_pwrite_zeroes(Bl=
ockDriverState *bs,
>      uint32_t tail =3D (offset + count) % s->cluster_size;
>=20
>      trace_qcow2_pwrite_zeroes_start_req(qemu_coroutine_self(), offset,=
 count);
> +    if (offset + count =3D=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
> +        tail =3D 0;
> +    }
>=20
>      if (head || tail) {
>          int64_t cl_start =3D (offset - head) >> BDRV_SECTOR_BITS;
> diff --git a/tests/qemu-iotests/154 b/tests/qemu-iotests/154
> index 7ca7219..005f09f 100755
> --- a/tests/qemu-iotests/154
> +++ b/tests/qemu-iotests/154
> @@ -2,7 +2,7 @@
>  #
>  # qcow2 specific bdrv_pwrite_zeroes tests with backing files (compleme=
nts 034)
>  #
> -# Copyright (C) 2016 Red Hat, Inc.
> +# Copyright (C) 2016-2017 Red Hat, Inc.
>  #
>  # This program is free software; you can redistribute it and/or modify=

>  # it under the terms of the GNU General Public License as published by=

> @@ -42,7 +42,10 @@ _supported_proto file
>  _supported_os Linux
>=20
>  CLUSTER_SIZE=3D4k
> -size=3D128M
> +size=3D$((128 * 1024 * 1024))
> +
> +# This test requires zero clusters, added in v3 images
> +_unsupported_imgopts compat=3D0.10
>=20
>  echo
>  echo =3D=3D backing file contains zeros =3D=3D
> @@ -299,6 +302,111 @@ $QEMU_IO -c "read -P 0 75k 1k" "$TEST_IMG" | _fil=
ter_qemu_io
>=20
>  $QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
>=20
> +echo
> +echo =3D=3D unaligned image tail cluster, no allocation needed =3D=3D
> +
> +CLUSTER_SIZE=3D1024 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size=
 + 1024))

Any reason for the CLUSTER_SIZE? It passes with 64 kB as well, and I
actually think that would be a better test because as it is, the image's
"unaligned" tail is exactly one cluster (so it isn't really unaligned).

> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
> +
> +# With no backing file, write to all or part of unallocated partial cl=
uster
> +
> +# Backing file: 128m: ... | 00 --

Not sure what the "00 --" is supposed to mean. The cluster size is 1 kB,
so this is just a single cluster; which will be converted from
unallocated to a zero cluster because the tail reads as zero.

> +$QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io
> +
> +# Backing file: 128m: ... | -- 00

Same here, but now it's the head that reads as zero (and it's already a
zero cluster so nothing changes here).

> +$QEMU_IO -c "write -z $size 512" "$TEST_IMG.base" | _filter_qemu_io

But I suppose you mean $((size + 512))?

> +
> +# Backing file: 128m: ... | 00 00

And finally this doesn't change anything either -- but then again this
is a fully aligned request, so I don't quite see the point in testing
this here.

> +$QEMU_IO -c "write -z $size 1024" "$TEST_IMG.base" | _filter_qemu_io
> +
> +# No offset should be allocated, although the cluster itself is consid=
ered
> +# allocated due to the zero flag
> +$QEMU_IO -c "alloc $size 1024" "$TEST_IMG.base" | _filter_qemu_io
> +$QEMU_IMG map --output=3Djson "$TEST_IMG.base" | _filter_qemu_img_map
> +
> +# With backing file that reads as zero, write to all or part of entire=
 cluster
> +
> +# Backing file: 128m: ... | 00 00
> +# Active layer: 128m: ... | 00 00 00 00
> +$QEMU_IO -c "write -z $size 2048" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
> +
> +# Backing file: 128m: ... | 00 00
> +# Active layer: 128m: ... | 00 00 -- --

How so? Shouldn't this just stay a zero cluster because the rest of the
cluster already reads as zero?

> +$QEMU_IO -c "write -z $((size)) 1024" "$TEST_IMG" | _filter_qemu_io
> +
> +# Backing file: 128m: ... | 00 00
> +# Active layer: 128m: ... | -- -- 00 00

Same here.

> +$QEMU_IO -c "write -z $((size + 1024)) 1024" "$TEST_IMG" | _filter_qem=
u_io
> +
> +# Backing file: 128m: ... | 00 00
> +# Active layer: 128m: ... | -- 00 00 --

Same here.

Also, I'm not quite sure what you are testing by just issuing three
consecutive write requests without checking the result each time. You
assume it to be something which you wrote in the comments above each,
but you can't be sure (yes, if something goes wrong in between, the
following final map should catch it, but it's not for certain).

> +$QEMU_IO -c "write -z $((size + 512)) 1024" "$TEST_IMG" | _filter_qemu=
_io
> +
> +# No offset should be allocated, although the cluster itself is consid=
ered
> +# allocated due to the zero flag
> +$QEMU_IO -c "alloc $size 2048" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
> +
> +# Preallocated cluster is not freed when unmap is not requested
> +
> +# Backing file: 128m: ... | XX -- =3D> ... | XX 00
> +$QEMU_IO -c "write $((size)) 512" "$TEST_IMG.base" | _filter_qemu_io
> +$QEMU_IO -c "write -z $((size + 512)) 512" "$TEST_IMG.base" | _filter_=
qemu_io
> +
> +# Backing file: 128m: ... | XX 00 =3D> ... | 00 00
> +$QEMU_IO -c "write -z $((size)) 1024" "$TEST_IMG.base" | _filter_qemu_=
io
> +$QEMU_IMG map --output=3Djson "$TEST_IMG.base" | _filter_qemu_img_map =
|
> +    sed 's/"offset": [0-9]*/"offset": OFFSET/g'
> +
> +echo
> +echo =3D=3D unaligned image tail cluster, allocation required =3D=3D
> +
> +CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size =
+ 1024))
> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
> +
> +# Write beyond backing file must COW
> +# Backing file: 128m: ... | XX --

Here, the "--" is an unallocated cluster...

> +# Active layer: 128m: ... | -- -- 00 --

=2E..while here it is normally allocated data. Or is "--" supposed to mea=
n
you just don't write to that area...?

> +
> +$QEMU_IO -c "write -P 1 $((size)) 512" "$TEST_IMG.base" | _filter_qemu=
_io
> +$QEMU_IO -c "write -z $((size + 1024)) 512" "$TEST_IMG" | _filter_qemu=
_io
> +$QEMU_IO -c "read -P 1 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0 $((size + 512)) 1536" "$TEST_IMG" | _filter_qem=
u_io
> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
> +
> +CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size =
+ 1024))
> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
> +
> +# Writes at boundaries of (partial) cluster must not lose mid-cluster =
data
> +# Backing file: 128m: ... | -- XX
> +# Active layer: 128m: ... | 00 -- -- 00
> +
> +$QEMU_IO -c "write -P 1 $((size + 512)) 512" "$TEST_IMG.base" | _filte=
r_qemu_io
> +$QEMU_IO -c "write -z $((size)) 512" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 1 $((size + 512)) 512" "$TEST_IMG" | _filter_qemu=
_io
> +$QEMU_IO -c "read -P 0 $((size + 1024)) 1024" "$TEST_IMG" | _filter_qe=
mu_> +$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_q=
emu_io

[1]

> +$QEMU_IO -c "read -P 0 $((size)) 512" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 1 $((size + 512)) 512" "$TEST_IMG" | _filter_qemu=
_io
> +$QEMU_IO -c "read -P 0 $((size + 1024)) 1024" "$TEST_IMG" | _filter_qe=
mu_io
> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
> +
> +CLUSTER_SIZE=3D512 TEST_IMG=3D"$TEST_IMG.base" _make_test_img $((size =
+ 1024))
> +_make_test_img -b "$TEST_IMG.base" $((size + 2048))
> +
> +# Partial write must not lose data
> +# Backing file: 128m: ... | -- --
> +# Active layer: 128m: ... | -- -- XX 00

Well, you have basically tested this in [1] already. After the first
write -z to the active layer, the final four sectors are fully allocated
(as they are in a single cluster) and look like this:

00 01 00 00 =3D XX XX XX XX

(Because the 00s are just written as data.)

Now the write -z in [1] just overwrites the last of those four sectors
with zero data (albeit it being zero already).

But if you want to test it again, I'm not stopping you. :-)

Max

> +
> +$QEMU_IO -c "write -P 1 $((size + 1024)) 512" "$TEST_IMG" | _filter_qe=
mu_io
> +$QEMU_IO -c "write -z $((size + 1536)) 512" "$TEST_IMG" | _filter_qemu=
_io
> +$QEMU_IO -c "read -P 0 $((size)) 1024" "$TEST_IMG" | _filter_qemu_io
> +$QEMU_IO -c "read -P 1 $((size + 1024)) 512" "$TEST_IMG" | _filter_qem=
u_io
> +$QEMU_IO -c "read -P 0 $((size + 1536)) 512" "$TEST_IMG" | _filter_qem=
u_io
> +$QEMU_IMG map --output=3Djson "$TEST_IMG" | _filter_qemu_img_map
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/154.out b/tests/qemu-iotests/154.out
> index da9eabd..f8a09af 100644
> --- a/tests/qemu-iotests/154.out
> +++ b/tests/qemu-iotests/154.out
> @@ -282,4 +282,87 @@ read 1024/1024 bytes at offset 76800
>  { "start": 69632, "length": 4096, "depth": 0, "zero": true, "data": fa=
lse},
>  { "start": 73728, "length": 4096, "depth": 0, "zero": false, "data": t=
rue, "offset": 24576},
>  { "start": 77824, "length": 134139904, "depth": 1, "zero": true, "data=
": false}]
> +
> +=3D=3D unaligned image tail cluster, no allocation needed =3D=3D
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134218752
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_=
file=3DTEST_DIR/t.IMGFMT.base
> +wrote 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1024/1024 bytes at offset 134217728
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +1024/1024 bytes allocated at offset 128 MiB
> +[{ "start": 0, "length": 134218752, "depth": 0, "zero": true, "data": =
false}]
> +wrote 2048/2048 bytes at offset 134217728
> +2 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": =
false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data"=
: false}]
> +wrote 1024/1024 bytes at offset 134217728
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1024/1024 bytes at offset 134218752
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1024/1024 bytes at offset 134218240
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +2048/2048 bytes allocated at offset 128 MiB
> +[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": =
false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": true, "data"=
: false}]
> +wrote 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 134218240
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 1024/1024 bytes at offset 134217728
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +[{ "start": 0, "length": 134217728, "depth": 0, "zero": true, "data": =
false},
> +{ "start": 134217728, "length": 1024, "depth": 0, "zero": true, "data"=
: false, "offset": OFFSET}]
> +
> +=3D=3D unaligned image tail cluster, allocation required =3D=3D
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134218752
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_=
file=3DTEST_DIR/t.IMGFMT.base
> +wrote 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 134218752
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 1536/1536 bytes at offset 134218240
> +1.500 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": =
false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data=
": true, "offset": 20480}]
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134218752
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_=
file=3DTEST_DIR/t.IMGFMT.base
> +wrote 512/512 bytes at offset 134218240
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 134218240
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 1024/1024 bytes at offset 134218752
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 134219264
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 134217728
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 134218240
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 1024/1024 bytes at offset 134218752
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": =
false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data=
": true, "offset": 20480}]
> +Formatting 'TEST_DIR/t.IMGFMT.base', fmt=3DIMGFMT size=3D134218752
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D134219776 backing_=
file=3DTEST_DIR/t.IMGFMT.base
> +wrote 512/512 bytes at offset 134218752
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 512/512 bytes at offset 134219264
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 1024/1024 bytes at offset 134217728
> +1 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 134218752
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 512/512 bytes at offset 134219264
> +512 bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +[{ "start": 0, "length": 134217728, "depth": 1, "zero": true, "data": =
false},
> +{ "start": 134217728, "length": 2048, "depth": 0, "zero": false, "data=
": true, "offset": 20480}]
>  *** done
>=20



--Gm6Qk7h10uNkQJNISN0m4dnc2GVqTFVlF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkDqp0SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AhG4H/3XrhfoX5r3x/ezb6a+HV7h5JWFEFiTY
Wn/a4Ck4/ir+At7ExhXBicNiAT5eiROqeqxZt1jW1qNxC8zuPRTG1XV4TyqyD1ud
j95TmRqSV+89D1K2JW08GdXFRKasfEcrmKVCO/aUcXkC/yoCzPKjW37f1QGrKwgO
2NXmiygk/lNxlQgZwfhKQ0PJhe/P9SLkWVOgG+0oq5Pa6+BcgLUOy15QvP2mgKPL
zwtl6pM7rAqvwsY9i79yO5Wn/L/RlSFA57QTvIMoqIPUU302yA8SuTt3Uy09cye4
eeFKavBwomqB9ofXVPAdFxMy46P8GycX7sCxK6NjQ5mJSszIBvvFPrY=
=3bOT
-----END PGP SIGNATURE-----

--Gm6Qk7h10uNkQJNISN0m4dnc2GVqTFVlF--
