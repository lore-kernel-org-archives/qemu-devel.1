Received: from eggs.gnu.org ([2001:4830:134:3::10]:34682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctw2F-00048n-Kc
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:52:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctw2E-0003dJ-N4
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 08:52:11 -0400
References: <20170330223645.349-1-eblake@redhat.com>
	<20170330223645.349-4-eblake@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
Date: Fri, 31 Mar 2017 14:51:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170330223645.349-4-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GgJKbqPgIuWOFnA1Dg0IXEtlf9vOTL6pO"
Subject: Re: [Qemu-devel] [PATCH v7 3/3] qcow2: Discard unaligned tail when
 wiping image
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
--GgJKbqPgIuWOFnA1Dg0IXEtlf9vOTL6pO
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org
Message-ID: <7827f670-c46a-cf69-c385-569e5114da96@redhat.com>
Subject: Re: [PATCH v7 3/3] qcow2: Discard unaligned tail when wiping image
References: <20170330223645.349-1-eblake@redhat.com>
 <20170330223645.349-4-eblake@redhat.com>
In-Reply-To: <20170330223645.349-4-eblake@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 31.03.2017 00:36, Eric Blake wrote:
> The previous commit pointed out a subtle difference between the
> fast and slow path of qcow2_make_empty(), where we failed to discard
> the final (partial) cluster of an unaligned image.
>=20
> The problem stems from the fact that qcow2_discard_clusters() was
> silently ignoring sub-cluster head and tail on unaligned requests.
> A quick audit of all callers shows that qcow2_snapshot_create() has
> always passed a cluster-aligned request since the call was added
> in commit 1ebf561; qcow2_co_pdiscard() has passed a cluster-aligned
> request since commit ecdbead taught the block layer about preferred
> discard alignment; and qcow2_make_empty() was fixed to pass an
> aligned start (but not necessarily end) in commit a3e1505.
>=20
> Asserting that the start is always aligned also points out that we
> now have a dead check: rounding the end offset down can never result
> in a value less than the aligned start offset (the check was rendered
> dead with commit ecdbead).  Meanwhile, we do not want to round the
> end cluster down in the one case of the end offset matching the
> (unaligned) file size - that final partial cluster should still be
> discarded.
>=20
> With those fixes in place, we can adjust the testsuite so that
> qemu-iotests 97 and 176 are once again identical for qcow2, showing
> that fast and slow paths are back in sync.
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> ---
> v7: new patch
> ---
>  block/qcow2-cluster.c      | 10 ++++------
>  tests/qemu-iotests/176.out |  2 +-
>  2 files changed, 5 insertions(+), 7 deletions(-)
>=20
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 78c11d4..100398c 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -1519,12 +1519,10 @@ int qcow2_discard_clusters(BlockDriverState *bs=
, uint64_t offset,
>=20
>      end_offset =3D offset + (nb_sectors << BDRV_SECTOR_BITS);
>=20
> -    /* Round start up and end down */
> -    offset =3D align_offset(offset, s->cluster_size);
> -    end_offset =3D start_of_cluster(s, end_offset);
> -
> -    if (offset > end_offset) {
> -        return 0;
> +    /* The caller must cluster-align start; round end down except at E=
OF */
> +    assert(QEMU_IS_ALIGNED(offset, s->cluster_size));
> +    if (end_offset !=3D bs->total_sectors * BDRV_SECTOR_SIZE) {
> +        end_offset =3D start_of_cluster(s, end_offset);
>      }

This change looks good and works for qcow2_make_empty(), but
qcow2_co_pdiscard() will still drop these requests:

$ ./qemu-img create -f qcow2 foo.qcow2 512
Formatting 'foo.qcow2', fmt=3Dqcow2 size=3D512 encryption=3Doff
cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ ./qemu-io -c 'write 0 512' foo.qcow2
wrote 512/512 bytes at offset 0
512 bytes, 1 ops; 0.0062 sec (80.167 KiB/sec and 160.3335 ops/sec)
$ ./qemu-img map foo.qcow2
Offset          Length          Mapped to       File
0               0x200           0x50000         foo.qcow2
$ ./qemu-io -c 'discard 0 512' foo.qcow2
discard 512/512 bytes at offset 0
512 bytes, 1 ops; 0.0000 sec (34.877 MiB/sec and 71428.5714 ops/sec)
$ ./qemu-img map foo.qcow2
Offset          Length          Mapped to       File
0               0x200           0x50000         foo.qcow2

We don't necessarily have to fix it for 2.9, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>=20
>      nb_clusters =3D size_to_clusters(s, end_offset - offset);
> diff --git a/tests/qemu-iotests/176.out b/tests/qemu-iotests/176.out
> index 990a41c..6271fa7 100644
> --- a/tests/qemu-iotests/176.out
> +++ b/tests/qemu-iotests/176.out
> @@ -35,7 +35,7 @@ Offset          Length          File
>  Offset          Length          File
>  0x7ffd0000      0x10000         TEST_DIR/t.IMGFMT.base
>  0x7ffe0000      0x20000         TEST_DIR/t.IMGFMT.itmd
> -0x83400000      0x200           TEST_DIR/t.IMGFMT
> +0x83400000      0x200           TEST_DIR/t.IMGFMT.itmd
>=20
>  =3D=3D=3D Test pass 1 =3D=3D=3D
>=20



--GgJKbqPgIuWOFnA1Dg0IXEtlf9vOTL6pO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljeUO4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AuYoIAK5r47l6BK0eaKT8uHFYm8NZqdrYmn4z
vv9msi87xo7EUPDhzwyVxntKh9nRel7/NrMzL+sqCpdYmCxicerCoBJDs9c/m4SJ
IJ6xkZswSBASQfmxcMReaBzctb9mbjm3ibpcxH8mYiwYNynOxy5v3qOV1snkRL4/
ZnNoPBnt/c/fjyVLxlY7cCpuAMzriRfnWCtUnzcbUhjpYLplDZnFuyznRMSfcRkE
hmhIHAx46gvOmnRhg2s5aDUM+JRx8IOEEagFOpOHvCT4qYskfkhxfNCNJy4h/jTs
+iB7Irr8cgsSrt+nFXQ1B+jXDyDA/0OKBhH7ykBNoz8LLyreTBuzzSI=
=5w6k
-----END PGP SIGNATURE-----

--GgJKbqPgIuWOFnA1Dg0IXEtlf9vOTL6pO--
