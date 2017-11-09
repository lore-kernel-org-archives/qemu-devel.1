Received: from eggs.gnu.org ([2001:4830:134:3::10]:54859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCb1r-0006nS-59
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 19:49:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1eCb1q-0001Gy-FP
	for qemu-devel@nongnu.org; Wed, 08 Nov 2017 19:49:11 -0500
From: Max Reitz <mreitz@redhat.com>
Message-ID: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
Date: Thu, 9 Nov 2017 01:48:58 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Hfah0C5rUATvtU1etGVMnHmb1XSHNB6uv"
Subject: [Qemu-devel] Intermittent hang of iotest 194 (bdrv_drain_all after
 non-shared storage migration)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Hfah0C5rUATvtU1etGVMnHmb1XSHNB6uv
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <92c47a3f-92a6-4f3a-505f-dc278604a671@redhat.com>
Subject: Intermittent hang of iotest 194 (bdrv_drain_all after non-shared
 storage migration)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

More exciting news from the bdrv_drain() front!

I've noticed in the past that iotest 194 sometimes hangs.  I usually run
the tests on tmpfs, but I've just now verified that it happens on my SSD
just as well.

So the reproducer is a plain:

while ./check -raw 194; do; done

(No difference between raw or qcow2, though.)

And then, after a couple of runs (or a couple ten), it will just hang.
The reason is that the source VM lingers around and doesn't quit
voluntarily -- the test itself was successful, but it just can't exit.

If you force it to exit by killing the VM (e.g. through pkill -11 qemu),
this is the backtrace:

#0  0x00007f7cfc297e06 in ppoll () at /lib64/libc.so.6
#1  0x0000563b846bcac9 in ppoll (__ss=3D0x0, __timeout=3D0x0,
__nfds=3D<optimized out>, __fds=3D<optimized out>) at
/usr/include/bits/poll2.h:77
#2  0x0000563b846bcac9 in qemu_poll_ns (fds=3D<optimized out>,
nfds=3D<optimized out>, timeout=3D<optimized out>) at util/qemu-timer.c:3=
22
#3  0x0000563b846be711 in aio_poll (ctx=3Dctx@entry=3D0x563b856e3e80,
blocking=3D<optimized out>) at util/aio-posix.c:629
#4  0x0000563b8463afa4 in bdrv_drain_recurse
(bs=3Dbs@entry=3D0x563b865568a0, begin=3Dbegin@entry=3Dtrue) at block/io.=
c:201
#5  0x0000563b8463baff in bdrv_drain_all_begin () at block/io.c:381
#6  0x0000563b8463bc99 in bdrv_drain_all () at block/io.c:411
#7  0x0000563b8459888b in block_migration_cleanup (opaque=3D<optimized
out>) at migration/block.c:714
#8  0x0000563b845883be in qemu_savevm_state_cleanup () at
migration/savevm.c:1251
#9  0x0000563b845811fd in migration_thread (opaque=3D0x563b856f1da0) at
migration/migration.c:2298
#10 0x00007f7cfc56f36d in start_thread () at /lib64/libpthread.so.0
#11 0x00007f7cfc2a3e1f in clone () at /lib64/libc.so.6


And when you make bdrv_drain_all_begin() print what we are trying to
drain, you can see that it's the format node (managed by the "raw"
driver in this case).

So I thought, before I put more time into this, let's ask whether the
test author has any ideas. :-)

Max


--Hfah0C5rUATvtU1etGVMnHmb1XSHNB6uv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAloDpfoSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9Aj2IH/0L7Kglnj9LFpE87KHfl5IvQMeAB14F6
OOSouUvdWQfJMNDL3ig8R6DC5P32nEKUPupUD2IPFzq4pyC4MktXf7lXcxJ//Kjp
cnVqtk2YKafDn9gYR8Ud/BAlCrmza0DZHNDVLepmOXTz4S4i3zjNFk4VTs4rbx9J
kh2UuXnP7oUxYCvgb2Rhn1Rbj3Tc3KdFWGwaBGY6w3tOFIaPQwWT5oU0+xszhLJD
PGGA7uuG+Vbs6R4v4W8pLVk5+Kmv2q3WlD0Y2vVqkRJL2K4cj361L1aeL/Go4i7f
tdaA8ToDnNhHOBLnRwVCQDul73YPqkT5r+pQcCavkXiLBT1J5MVWtaU=
=NfHL
-----END PGP SIGNATURE-----

--Hfah0C5rUATvtU1etGVMnHmb1XSHNB6uv--
