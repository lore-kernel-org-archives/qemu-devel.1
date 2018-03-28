Received: from eggs.gnu.org ([2001:4830:134:3::10]:56379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1Ext-0001Vj-9k
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:34:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1f1Exr-0004Sy-LN
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 13:34:25 -0400
References: <20180322124155.16257-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
Date: Wed, 28 Mar 2018 19:34:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180322124155.16257-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1VSgz8GLF7VbOGj1zXpV27i1VshtG3HvG"
Subject: Re: [Qemu-devel] [PATCH for-2.12 v4] iotests: Test abnormally large
 size in compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1VSgz8GLF7VbOGj1zXpV27i1VshtG3HvG
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>
Message-ID: <de89f57b-bbcc-20c9-b1e4-e9a96e87a31b@redhat.com>
Subject: Re: [PATCH for-2.12 v4] iotests: Test abnormally large size in
 compressed cluster descriptor
References: <20180322124155.16257-1-berto@igalia.com>
In-Reply-To: <20180322124155.16257-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-03-22 13:41, Alberto Garcia wrote:
> L2 entries for compressed clusters have a field that indicates the
> number of sectors used to store the data in the image.
>=20
> That's however not the size of the compressed data itself, just the
> number of sectors where that data is located. The actual data size is
> usually not a multiple of the sector size, and therefore cannot be
> represented with this field.
>=20
> The way it works is that QEMU reads all the specified sectors and
> starts decompressing the data until there's enough to recover the
> original uncompressed cluster. If there are any bytes left that
> haven't been decompressed they are simply ignored.
>=20
> One consequence of this is that even if the size field is larger than
> it needs to be QEMU can handle it just fine: it will read more data
> from disk but it will ignore the extra bytes.
>=20
> This test creates an image with two compressed clusters that use 5
> sectors (2.5 KB) each, increases the size field to the maximum (8192
> sectors, or 4 MB) and verifies that the data can be read without
> problems.
>=20
> This test is important because while the decompressed data takes
> exactly one cluster, the maximum value allowed in the compressed size
> field is twice the cluster size. So although QEMU won't produce images
> with such large values we need to make sure that it can handle them.
>=20
> Another effect of increasing the size field is that it can make
> it include data from the following host cluster(s). In this case
> 'qemu-img check' will detect that the refcounts are not correct, and
> we'll need to rebuild them.
>=20
> Additionally, this patch also tests that decreasing the size corrupts
> the image since the original data can no longer be recovered. In this
> case QEMU returns an error when trying to read the compressed data,
> but 'qemu-img check' doesn't see anything wrong if the refcounts are
> consistent.
>=20
> One possible task for the future is to make 'qemu-img check' verify
> the sizes of the compressed clusters, by trying to decompress the data
> and checking that the size stored in the L2 entry is correct.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> ---
> v4: Resend for 2.12
>=20
> v3: Add TODO comment, as suggested by Eric.
>=20
>     Corrupt the length of the second compressed cluster as well so the
>     uncompressed data would span three host clusters.
>=20
> v2: We now have two scenarios where we make QEMU read data from the
>     next host cluster and from beyond the end of the image. This
>     version also runs qemu-img check on the corrupted image.
>=20
>     If the size field is too small, reading fails but qemu-img check
>     succeeds.
>=20
>     If the size field is too large, reading succeeds but qemu-img
>     check fails (this can be repaired, though).
> ---
>  tests/qemu-iotests/122     | 45 ++++++++++++++++++++++++++++++++++++++=
+++++++
>  tests/qemu-iotests/122.out | 31 +++++++++++++++++++++++++++++++
>  2 files changed, 76 insertions(+)
>=20
> diff --git a/tests/qemu-iotests/122 b/tests/qemu-iotests/122
> index 45b359c2ba..5b9593016c 100755
> --- a/tests/qemu-iotests/122
> +++ b/tests/qemu-iotests/122

Not sure if 122 is the right file for this...

Or, let me rephrase, it does look to me like it is not the right file.
But on the other hand, I don't see a more suitable file.

> @@ -130,6 +130,51 @@ $QEMU_IO -c "read -P 0    1024k 1022k" "$TEST_IMG"=
 2>&1 | _filter_qemu_io | _fil
> =20
> =20
>  echo
> +echo "=3D=3D=3D Corrupted size field in compressed cluster descriptor =
=3D=3D=3D"
> +echo
> +# Create an empty image, fill half of it with data and compress it.
> +# The L2 entries of the two compressed clusters are located at
> +# 0x800000 and 0x800008, their original values are 0x4008000000a00000
> +# and 0x4008000000a00802 (5 sectors for compressed data each).
> +TEST_IMG=3D"$TEST_IMG".1 _make_test_img 8M
> +$QEMU_IO -c "write -P 0x11 0 4M" "$TEST_IMG".1 2>&1 | _filter_qemu_io =
| _filter_testdir
> +$QEMU_IMG convert -c -O qcow2 -o cluster_size=3D2M "$TEST_IMG".1 "$TES=
T_IMG"

Why not just use "write -c" and drop the convert?  (You'd have to use
two writes, though, one for each cluster.)

> +
> +# Reduce size of compressed data to 4 sectors: this corrupts the image=
=2E
> +poke_file "$TEST_IMG" $((0x800000)) "\x40\x06"
> +$QEMU_IO -c "read  -P 0x11 0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io | =
_filter_testdir
> +
> +# 'qemu-img check' however doesn't see anything wrong because it
> +# doesn't try to decompress the data and the refcounts are consistent.=

> +# TODO: update qemu-img so this can be detected
> +_check_test_img
> +
> +# Increase size of compressed data to the maximum (8192 sectors).
> +# This makes QEMU read more data (8192 sectors instead of 5, host
> +# addresses [0xa00000, 0xdfffff]), but the decompression algorithm
> +# stops once we have enough to restore the uncompressed cluster, so
> +# the rest of the data is ignored.
> +poke_file "$TEST_IMG" $((0x800000)) "\x7f\xfe"
> +# Do it also for the second compressed cluster (L2 entry at 0x800008).=

> +# In this case the compressed data would span 3 host clusters
> +# (host addresses: [0xa00802, 0xe00801])
> +poke_file "$TEST_IMG" $((0x800008)) "\x7f\xfe"
> +
> +# Here the image is too small so we're asking QEMU to read beyond the
> +# end of the image.
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io |=
 _filter_testdir
> +# But if we grow the image we won't be reading beyond its end anymore.=

> +$QEMU_IO -c "write -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io |=
 _filter_testdir
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io |=
 _filter_testdir

Both reads result in exactly the same output, though, so it doesn't seem
like qemu cares.

(This is the reason I'm not merging this patch now, because that looks a
bit fishy.)

> +
> +# The refcount data is however wrong because due to the increased size=

> +# of the compressed data it now reaches the following host clusters.
> +# This can be repaired by qemu-img check.

The OFLAG_COPIED repair looks a bit interesting, but, er, well.

Max

(Since a compressed cluster does not correspond 1:1 to a host cluster,
you cannot say that a compressed cluster has a refcount -- only host
clusters are refcounted.  So what is it supposed to mean that a
compressed cluster has a refcount of 1?

I'd argue from a point of usefulness.  In theory, you could modify
compressed clusters in-place, and then you'd need the information
whether you are allowed to.  But that doesn't really depend on whether
the host clusters touched by the compressed cluster have a refcount of
1, instead if depends on how many times the compressed cluster itself is
referenced.  Unfortunately we have no refcounting structure for that.

So all in all OFLAG_COPIED is just useless for compressed clusters.)

> +_check_test_img -r all
> +$QEMU_IO -c "read  -P 0x11  0 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io |=
 _filter_testdir
> +$QEMU_IO -c "read  -P 0x22 4M 4M" "$TEST_IMG" 2>&1 | _filter_qemu_io |=
 _filter_testdir
> +
> +echo
>  echo "=3D=3D=3D Full allocation with -S 0 =3D=3D=3D"
>  echo
> =20
> diff --git a/tests/qemu-iotests/122.out b/tests/qemu-iotests/122.out
> index 47d8656db8..bdda75650f 100644
> --- a/tests/qemu-iotests/122.out
> +++ b/tests/qemu-iotests/122.out
> @@ -99,6 +99,37 @@ read 1024/1024 bytes at offset 1047552
>  read 1046528/1046528 bytes at offset 1048576
>  1022 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> =20
> +=3D=3D=3D Corrupted size field in compressed cluster descriptor =3D=3D=
=3D
> +
> +Formatting 'TEST_DIR/t.IMGFMT.1', fmt=3DIMGFMT size=3D8388608
> +wrote 4194304/4194304 bytes at offset 0
> +4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read failed: Input/output error
> +No errors were found on the image.
> +read 4194304/4194304 bytes at offset 0
> +4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +wrote 4194304/4194304 bytes at offset 4194304
> +4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 4194304/4194304 bytes at offset 0
> +4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +ERROR cluster 6 refcount=3D1 reference=3D3
> +ERROR cluster 7 refcount=3D1 reference=3D2
> +Repairing cluster 6 refcount=3D1 reference=3D3
> +Repairing cluster 7 refcount=3D1 reference=3D2
> +Repairing OFLAG_COPIED data cluster: l2_entry=3D8000000000c00000 refco=
unt=3D3
> +Repairing OFLAG_COPIED data cluster: l2_entry=3D8000000000e00000 refco=
unt=3D2
> +The following inconsistencies were found and repaired:
> +
> +    0 leaked clusters
> +    4 corruptions
> +
> +Double checking the fixed image now...
> +No errors were found on the image.
> +read 4194304/4194304 bytes at offset 0
> +4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +read 4194304/4194304 bytes at offset 4194304
> +4 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +
>  =3D=3D=3D Full allocation with -S 0 =3D=3D=3D
> =20
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>=20



--1VSgz8GLF7VbOGj1zXpV27i1VshtG3HvG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlq70hcACgkQ9AfbAGHV
z0Dnmwf7BNtxWRSFr4ejpjrltfBbLTCI7Q6JWpN3DbW8P1e/Ob7tpCAt+qzqHtgq
Li5wjUU9h+4Vm/OJ5brTXxQtvJpsQstt/JEBm2WVQxDrSFrmFSISWolEG1py8I6i
MzCyM3utQz70moyaYaIG69r3PU0gxF5xfqQAToJrKiPrNiYFI9CXGoSnwOkCjh2I
vi5xzahgQ5Nqad0xSYpiy9fk+N2kSjMKWt7DrcEZvV+N3qzJNr/lyoexYk8NGQZM
FDYkyqBPKEjcgOBm7tg5+PRBVVDSdmkYJSjohl2PotDDeSE/sLPLQCJBwqzto3BR
RAgpoCvJ3oBId3l2FBlfhWYOVkY7Mg==
=MFem
-----END PGP SIGNATURE-----

--1VSgz8GLF7VbOGj1zXpV27i1VshtG3HvG--
