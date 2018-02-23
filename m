Received: from eggs.gnu.org ([2001:4830:134:3::10]:57750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epD0c-0006QL-Ej
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:03:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1epD0b-0006cg-Fp
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:03:30 -0500
From: Max Reitz <mreitz@redhat.com>
Message-ID: <60d1e2ab-c3a4-cae2-b810-5e46dc124b0b@redhat.com>
Date: Fri, 23 Feb 2018 14:03:15 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cTVstNU3853G7Y69veOjPjKPQB1r3cSaW"
Subject: [Qemu-devel] Intermittent failure of iotest 203
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
--cTVstNU3853G7Y69veOjPjKPQB1r3cSaW
From: Max Reitz <mreitz@redhat.com>
To: Qemu-block <qemu-block@nongnu.org>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <60d1e2ab-c3a4-cae2-b810-5e46dc124b0b@redhat.com>
Subject: Intermittent failure of iotest 203
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

iotest 203 relatively often fails for me, at least when run in parallel.
 When I run the following concurrently on four shells:

$ while TEST_DIR=3D/tmp/t1 ./check -T -qcow2 203; do; done
$ while TEST_DIR=3D/tmp/t2 ./check -T -qcow2 203; do; done
$ while TEST_DIR=3D/tmp/t3 ./check -T -qcow2 203; do; done
$ while TEST_DIR=3D/tmp/t4 ./check -T -qcow2 203; do; done

Very quickly (like under ten iterations), at least one of those starts
to hang and then fails because of a timeout in vm.get_qmp_event().

Before digging deeper into the ppoll() dungeon* myself, I decided to
report this so I wouldn't have to. :-)

*Backtrace:

(gdb) bt
#0  0x00007f354137b4d6 in ppoll () at /lib64/libc.so.6
#1  0x000055b659144299 in ppoll (__ss=3D0x0, __timeout=3D0x7ffe4eaca230,
__nfds=3D<optimized out>, __fds=3D<optimized out>) at
/usr/include/bits/poll2.h:77
#2  0x000055b659144299 in qemu_poll_ns (fds=3D<optimized out>,
nfds=3D<optimized out>, timeout=3Dtimeout@entry=3D39512999619000) at
util/qemu-timer.c:334
#3  0x000055b6591450a3 in os_host_main_loop_wait (timeout=3D<optimized
out>) at util/main-loop.c:255
#4  0x000055b6591450a3 in main_loop_wait (nonblocking=3D<optimized out>)
at util/main-loop.c:515
#5  0x000055b658d4a253 in main_loop () at vl.c:1933
#6  0x000055b658d4a253 in main (argc=3D<optimized out>, argv=3D<optimized=

out>, envp=3D<optimized out>) at vl.c:4757

Max


--cTVstNU3853G7Y69veOjPjKPQB1r3cSaW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqQERQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A7KIH/jnJSYjLWzGe/FD4uapcP/xqEx4cegoH
4Glcl3T4uFf1w4hOGlUDLmF9PeYL5/RFGRs2pUzbfbQB4r+VGhbtyio4j1pwOIBD
K1z6G4PXF9YonU/rqdxlLw5ESCFgSH++knKyRBepFDrqM9Bjai52tYDqtdsiD7q0
ck/phkP72WrjD7RpV7JGkrfBsXcBlBkkUe7EzpU2Gz6OdaHldMndxApChh4Ipqr3
kATN2HIiD/yuqaO6Bkk7Yq2esLrnhZyvAfSgDYa08g/ejX7dWevJRi18vqEZJkaF
jUth93saOd0/ulF00mKb10NgFuOPun12qibXEcxa6JRS1tjuYG+vmZU=
=ycRA
-----END PGP SIGNATURE-----

--cTVstNU3853G7Y69veOjPjKPQB1r3cSaW--
