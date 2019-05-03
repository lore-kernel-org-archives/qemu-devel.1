Received: from eggs.gnu.org ([209.51.188.92]:53307)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMhw4-0002pX-7A
	for qemu-devel@nongnu.org; Fri, 03 May 2019 19:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hMhw3-0008JW-5s
	for qemu-devel@nongnu.org; Fri, 03 May 2019 19:49:48 -0400
References: <20190331111747.14685-1-berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b2899621-2124-d257-87cd-0de727aba888@redhat.com>
Date: Sat, 4 May 2019 01:49:39 +0200
MIME-Version: 1.0
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK"
Subject: Re: [Qemu-devel] [PATCH for-4.1] block: Use bdrv_unref_child() for
 all children in bdrv_close()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <b2899621-2124-d257-87cd-0de727aba888@redhat.com>
Subject: Re: [PATCH for-4.1] block: Use bdrv_unref_child() for all children in
 bdrv_close()
References: <20190331111747.14685-1-berto@igalia.com>
In-Reply-To: <20190331111747.14685-1-berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 31.03.19 13:17, Alberto Garcia wrote:
> bdrv_unref_child() does the following things:
>=20
>   - Updates the child->bs->inherits_from pointer.
>   - Calls bdrv_detach_child() to remove the BdrvChild from bs->children=
=2E
>   - Calls bdrv_unref() to unref the child BlockDriverState.
>=20
> When bdrv_unref_child() was introduced in commit 33a604075c it was not
> used in bdrv_close() because the drivers that had additional children
> (like quorum or blkverify) had already called bdrv_unref() on their
> children during their own close functions.
>=20
> This was changed later (in 0bd6e91a7e for quorum, in 3e586be0b2 for
> blkverify) so there's no reason not to use bdrv_unref_child() in
> bdrv_close() anymore.
>=20
> After this there's also no need to remove bs->backing and bs->file
> separately from the rest of the children, so bdrv_close() can be
> simplified.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block.c | 16 +++-------------
>  1 file changed, 3 insertions(+), 13 deletions(-)

Hm, I=E2=80=99m afraid this breaks make check:

$ make -j 4 && make tests/test-bdrv-drain && gtester tests/test-bdrv-drai=
n

TEST: tests/test-bdrv-drain... (pid=3D22321)
test-bdrv-drain: block.c:5397: bdrv_unref: Assertion `bs->refcnt > 0'
failed.

(gdb) bt
#0  0x00007f15c7ffc57f in raise () from /lib64/libc.so.6
#1  0x00007f15c7fe6895 in abort () from /lib64/libc.so.6
#2  0x00007f15c7fe6769 in __assert_fail_base.cold.0 () from /lib64/libc.s=
o.6
#3  0x00007f15c7ff4a26 in __assert_fail () from /lib64/libc.so.6
#4  0x00005562a11b0a00 in bdrv_unref (bs=3D0x5562a3370c30) at block.c:539=
7
#5  bdrv_unref (bs=3D0x5562a3370c30) at block.c:5392
#6  0x00005562a11a7f8f in test_detach_indirect (by_parent_cb=3D<optimized=

out>) at tests/test-bdrv-drain.c:1442
#7  0x00007f15c8766fca in ?? () from /lib64/libglib-2.0.so.0
#8  0x00007f15c8766e84 in ?? () from /lib64/libglib-2.0.so.0
#9  0x00007f15c8766e84 in ?? () from /lib64/libglib-2.0.so.0
#10 0x00007f15c8767282 in g_test_run_suite () from /lib64/libglib-2.0.so.=
0
#11 0x00007f15c87672a5 in g_test_run () from /lib64/libglib-2.0.so.0
#12 0x00005562a11a5b77 in main (argc=3D<optimized out>, argv=3D<optimized=

out>) at tests/test-bdrv-drain.c:1617

So I=E2=80=99ll dequeue this patch for now.

Max


--p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlzM05MACgkQ9AfbAGHV
z0BzNgf+O8nRk8FhleOT2T2xVmcEW6HVv/nVcdMa+pZXDNnRN8a5T5ZpweFuZnwn
VmQ7SaI+C8YWzGCNkpEAjaUqxS6IVCIgykLQ8hl11k7ZZNc2fGj9cGeO0wNEFlre
FzPBtlxQHYKT7jIDUL3FreSIO1BW9EXNupBYziBuXZOfuVjIPlSDeEfgmYiCdUJD
Rb7ML4scyAz3F8wwhb8ZorBwH2Va8DtLzuwsZ2wWZd7yx9ryZ/aNfgx2KKwj6dmr
NqcIlu7yRYswsu6eXtfceoR9KjWoYz448SMLJrYZSkfI8iD/pYGyrMWIUu7k9upI
l3SImzAefVHHq7LyAjhFOIuB6LmEbw==
=G78O
-----END PGP SIGNATURE-----

--p2ZMLAXH3JK9LPExHYiQp1oqrkaZbkvWK--
