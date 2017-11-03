Received: from eggs.gnu.org ([2001:4830:134:3::10]:51895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAepL-0004Wc-7O
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eAepH-0004Nn-0f
	for qemu-devel@nongnu.org; Fri, 03 Nov 2017 12:28:15 -0400
References: <cover.1509718618.git.berto@igalia.com>
	<fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
Date: Fri, 3 Nov 2017 17:27:59 +0100
MIME-Version: 1.0
In-Reply-To: <fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="7UOra02u89rWaEbc4VCAiqIFXjpP76GTI"
Subject: Re: [Qemu-devel] [PATCH v2 3/7] qcow2: Prevent allocating
 compressed clusters at offset 0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7UOra02u89rWaEbc4VCAiqIFXjpP76GTI
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Thomas Huth <thuth@redhat.com>, "R . Nageswara Sastry" <nasastry@in.ibm.com>
Message-ID: <ad3990d7-4356-4764-4da2-01cc59a63075@redhat.com>
Subject: Re: [PATCH v2 3/7] qcow2: Prevent allocating compressed clusters at
 offset 0
References: <cover.1509718618.git.berto@igalia.com>
 <fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
In-Reply-To: <fb53467cf48e95ff3330def1cf1003a5b862b7d9.1509718618.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-11-03 15:18, Alberto Garcia wrote:
> If the refcount data is corrupted then we can end up trying to
> allocate a new compressed cluster at offset 0 in the image, triggering
> an assertion in qcow2_alloc_bytes() that would crash QEMU:
>=20
>   qcow2_alloc_bytes: Assertion `offset' failed.
>=20
> This patch adds an explicit check for this scenario and a new test
> case.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/qcow2-refcount.c     |  8 +++++++-
>  tests/qemu-iotests/060     | 10 ++++++++++
>  tests/qemu-iotests/060.out |  8 ++++++++
>  3 files changed, 25 insertions(+), 1 deletion(-)
>=20
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 9059996c4b..7eaac11429 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -1082,6 +1082,13 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, =
int size)
>                  return new_cluster;
>              }
> =20
> +            if (new_cluster =3D=3D 0) {
> +                qcow2_signal_corruption(bs, true, -1, -1, "Preventing =
invalid "
> +                                        "allocation of compressed clus=
ter "
> +                                        "at offset 0");
> +                return -EIO;
> +            }
> +
>              if (!offset || ROUND_UP(offset, s->cluster_size) !=3D new_=
cluster) {
>                  offset =3D new_cluster;
>                  free_in_cluster =3D s->cluster_size;
> @@ -1090,7 +1097,6 @@ int64_t qcow2_alloc_bytes(BlockDriverState *bs, i=
nt size)
>              }
>          }
> =20
> -        assert(offset);

I don't think this assert() was meant as a protection against offset
being 0. :-)

Reviewed-by: Max Reitz <mreitz@redhat.com>

if the assert() stays.

>          ret =3D update_refcount(bs, offset, size, 1, false, QCOW2_DISC=
ARD_NEVER);
>          if (ret < 0) {
>              offset =3D 0;
> diff --git a/tests/qemu-iotests/060 b/tests/qemu-iotests/060
> index 40f85cc216..c3bce27b33 100755
> --- a/tests/qemu-iotests/060
> +++ b/tests/qemu-iotests/060
> @@ -260,6 +260,16 @@ _make_test_img 64M
>  poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x0=
0\x00"
>  $QEMU_IO -c "write 0 64k" "$TEST_IMG" | _filter_qemu_io
> =20
> +echo
> +echo "=3D=3D=3D Testing empty refcount block with compressed write =3D=
=3D=3D"
> +echo
> +_make_test_img 64M
> +$QEMU_IO -c "write 64k 64k" "$TEST_IMG" | _filter_qemu_io
> +poke_file "$TEST_IMG" "$rb_offset"        "\x00\x00\x00\x00\x00\x00\x0=
0\x00"
> +# The previous write already allocated an L2 table, so now this new
> +# write will try to allocate a compressed data cluster at offset 0.
> +$QEMU_IO -c "write -c 0k 64k" "$TEST_IMG" | _filter_qemu_io
> +
>  # success, all done
>  echo "*** done"
>  rm -f $seq.full
> diff --git a/tests/qemu-iotests/060.out b/tests/qemu-iotests/060.out
> index 5b8b518486..cf8790ff57 100644
> --- a/tests/qemu-iotests/060.out
> +++ b/tests/qemu-iotests/060.out
> @@ -195,4 +195,12 @@ write failed: Input/output error
>  Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
>  qcow2: Marking image as corrupt: Preventing invalid allocation of L2 t=
able at offset 0; further corruption events will be suppressed
>  write failed: Input/output error
> +
> +=3D=3D=3D Testing empty refcount block with compressed write =3D=3D=3D=

> +
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=3DIMGFMT size=3D67108864
> +wrote 65536/65536 bytes at offset 65536
> +64 KiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
> +qcow2: Marking image as corrupt: Preventing invalid allocation of comp=
ressed cluster at offset 0; further corruption events will be suppressed
> +write failed: Input/output error
>  *** done
>=20



--7UOra02u89rWaEbc4VCAiqIFXjpP76GTI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAln8mQ8SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A2FAH/1Kk1PrPMjXitZx6eqF8xJu93xNQZEIy
xtAejM2NRfzuMqGX40Qj/Ijz9gD8w9x8Fipt0bpLpxb1TOcrm4P/vl8YnIVFtNan
Amevweczw8MBBNlPjVD4VsFB+//tyUX28Pz8xZE/E5Rl84CBzT3xJwsH8/zNqjGP
MS/IW8S+RgfyG3EQY5AOkBHGt9CwBHACe/lNPQBZ6oUyQphdSwlhHmwR3Xl3HiTc
So4U1gfbtANzZCV7NeAYZXmPGldPs0LxYSd7d/wXS6ickJYboq2a0L+OZtzaRA2x
dCTJKOH6M6N+BCOuHjkg6WgT6dVeAlQDCk7n5ZUb3GMKSEf9/xx95oY=
=9ud5
-----END PGP SIGNATURE-----

--7UOra02u89rWaEbc4VCAiqIFXjpP76GTI--
