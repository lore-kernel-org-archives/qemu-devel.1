Received: from eggs.gnu.org ([209.51.188.92]:39942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZTi-0001WU-88
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hIZTg-0007PX-To
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 09:59:26 -0400
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
	<20190419140557.102725-4-vsementsov@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f8e6bdca-cc46-c721-4534-1741530a1215@redhat.com>
Date: Mon, 22 Apr 2019 08:59:14 -0500
MIME-Version: 1.0
In-Reply-To: <20190419140557.102725-4-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="afvh5vPvc2i8957LEVODJ7F9CBzEL21RY"
Subject: Re: [Qemu-devel] [PATCH v3 3/3] iotests: test big qcow2 shrink
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com, den@virtuozzo.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--afvh5vPvc2i8957LEVODJ7F9CBzEL21RY
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, mreitz@redhat.com, fam@euphon.net, stefanha@redhat.com,
 den@virtuozzo.com
Message-ID: <f8e6bdca-cc46-c721-4534-1741530a1215@redhat.com>
Subject: Re: [PATCH v3 3/3] iotests: test big qcow2 shrink
References: <20190419140557.102725-1-vsementsov@virtuozzo.com>
 <20190419140557.102725-4-vsementsov@virtuozzo.com>
In-Reply-To: <20190419140557.102725-4-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 4/19/19 9:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> This test checks bug in qcow2_process_discards, fixed by previous
> commit.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---

> +# This test checks that qcow2_process_discards does not truncate a dis=
card
> +# request > 2G.
> +# To reproduce bug we need to overflow int by one sequential discard, =
so we
> +# need size > 2G, bigger cluster size (as with default 64k we may have=
 maximum
> +# of 512M sequential data, corresponding to one L1 entry), and we need=
 some
> +# data of the beginning of the disk mapped to the end of file to preve=
nt
> +# bdrv_co_truncate(bs->file) call in qcow2_co_truncate(), which may su=
ccess

s/may success/might succeed/

> +# anyway.
> +
> +size=3D2100M
> +IMGOPTS=3D"cluster_size=3D1M,preallocation=3Dmetadata"
> +
> +_make_test_img $size
> +$QEMU_IO -c 'discard 0 10M' -c 'discard 2090M 10M' \
> +         -c 'write 2090M 10M' -c 'write 0 10M' "$TEST_IMG" | _filter_q=
emu_io
> +
> +# Check that our trick with swapping first and last 10M chunks succeed=
ed.
> +# Otherwise test will may pass even if bdrv_pdiscard() fails in
> +# qcow2_process_discards()
> +$QEMU_IMG map "$TEST_IMG" | _filter_testdir
> +$QEMU_IMG info "$TEST_IMG" | grep size |  _filter_testdir

Nice - that's a lot faster than v1! And makes the test fit in the quick
group after all.

> +
> +$QEMU_IMG -T 'qcow2_process_discards_failed*' resize --shrink "$TEST_I=
MG" 5M

However, I'm quite certain that trace output is not reliable in iotests.
Depending on configure options, traces might not be enabled at all, or
might not go to stderr. Drop the -T '...'.  Even without the trace line,

> +
> +$QEMU_IMG info "$TEST_IMG" | grep size | _filter_testdir

this second image info is sufficient to prove whether the resize had an
effect (post-patch) or exposes the bug (without patch 2/3). That is,
applying this patch but not 2/3, I see this (with my cleanups to
qemu-img info in place, from Kevin's block-next branch):

+++ /home/eblake/qemu/tests/qemu-iotests/250.out.bad	2019-04-22
08:52:26.072968731 -0500
@@ -14,8 +14,9 @@
 virtual size: 2.05 GiB (2202009600 bytes)
 disk size: 24 MiB
 cluster_size: 1048576
+18274@1555941145.999195:qcow2_process_discards_failed_region offset
0x500000 bytes 0x82a00000 ret -5
 Image resized.
 virtual size: 5 MiB (5242880 bytes)
-disk size: 9.01 MiB
+disk size: 19 MiB

where the trace did indeed show show that we had a bug, but where even
without the trace, the difference in size between 19M with incomplete
discards vs. 9M with patch 2/3 is enough to show that patch 2/3 fixes a b=
ug.

> +virtual size: 2.1G (2202009600 bytes)
> +disk size: 24M
> +cluster_size: 1048576
> +Image resized.
> +virtual size: 5.0M (5242880 bytes)
> +disk size: 9.0M
> +cluster_size: 1048576

When Kevin's block-next branch is applied, you'll need this squashed in:

diff --git a/tests/qemu-iotests/250.out b/tests/qemu-iotests/250.out
index 37e37f0c9e7..d1c1c7180b5 100644
--- a/tests/qemu-iotests/250.out
+++ b/tests/qemu-iotests/250.out
@@ -11,11 +11,11 @@ wrote 10485760/10485760 bytes at offset 0
 Offset          Length          Mapped to       File
 0               0xa00000        0x82f00000      TEST_DIR/t.qcow2
 0x82a00000      0xa00000        0x500000        TEST_DIR/t.qcow2
-virtual size: 2.1G (2202009600 bytes)
-disk size: 24M
+virtual size: 2.05 GiB (2202009600 bytes)
+disk size: 24 MiB
 cluster_size: 1048576
 Image resized.
-virtual size: 5.0M (5242880 bytes)
-disk size: 9.0M
+virtual size: 5 MiB (5242880 bytes)
+disk size: 9.01 MiB
 cluster_size: 1048576
 *** done

With the updated output to match changes to qemu-img output, the grammar
fixes, and with the -T option removed,

Reviewed-by: Eric Blake <eblake@redhat.com>
Tested-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--afvh5vPvc2i8957LEVODJ7F9CBzEL21RY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAly9yLIACgkQp6FrSiUn
Q2oT/ggAiT1Ffr2JER7sPiQVlKTZjdtZ3d8VV5VdX7jSsGXUdx4PP+aHhvJz/MFM
n6FyEJ2n2KudCt66/OJbYiqHdwomBThyZxXrpN6BdZfsiobhebQyIzpWQbNErUpP
G1vwsKvcVYv6rTMHzIIn0GYd9hWxMmNCzHk4tnnkfF8D3h6PTjxpYOk1Nk+imkq7
Iq0JO+uF3E+0XXn+0BrmE4eRjAEv8dKGBUswi6zq0ReOS0gI4wNGjEo/ASMGsAhN
ayIkU/2WzNIIXFWRFeK1H0gUDvXAgBiU/6yKQjjPZ8HtnBKd550plXS/dklGZ2kG
2Pah4FdnDtXnDTTYXDDZ6wK+w2uDlQ==
=aKWY
-----END PGP SIGNATURE-----

--afvh5vPvc2i8957LEVODJ7F9CBzEL21RY--
