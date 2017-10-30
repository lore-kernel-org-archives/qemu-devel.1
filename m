Received: from eggs.gnu.org ([2001:4830:134:3::10]:54004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9DaW-0006P3-Pe
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:11:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9DaR-0003pC-SF
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:11:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:47898)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e9DaR-0003nu-Jt
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:10:55 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e9DaP-0000vv-QK
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 17:10:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C08A22E80C7
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 17:10:53 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Oct 2017 17:03:11 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1728660 <1728660@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150938299200.4586.118755256317964456.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728660] [NEW] qemu-io segfaults at
 block/io.c:2545
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
This is on ppc64le architecture.

Re-production steps:

1. Copy the attached file named test.img to a directory
2. And customize the following command to point to the above directory and =
run the same.
# mv test.img copy.img
# qemu-io <path to>/copy.img -c "discard 108544 97792"

from gdb:
Program terminated with signal 11, Segmentation fault.
#0  0x00000000100af254 in bdrv_co_pdiscard (bs=3D0x3ee89ad0, offset=3D19660=
8, bytes=3D9728) at block/io.c:2545
2545	        if (bs->drv->bdrv_co_pdiscard) {
Missing separate debuginfos, use: debuginfo-install cyrus-sasl-lib-2.1.26-2=
1.el7.ppc64le glib2-2.50.3-3.el7.ppc64le glibc-2.17-196.el7.ppc64le gmp-6.0=
.0-15.el7.ppc64le gnutls-3.3.26-9.el7.ppc64le keyutils-libs-1.5.8-3.el7.ppc=
64le krb5-libs-1.15.1-8.el7.ppc64le libaio-0.3.109-13.el7.ppc64le libcom_er=
r-1.42.9-10.el7.ppc64le libcurl-7.29.0-42.el7.ppc64le libffi-3.0.13-18.el7.=
ppc64le libgcc-4.8.5-16.el7_4.1.ppc64le libidn-1.28-4.el7.ppc64le libselinu=
x-2.5-11.el7.ppc64le libssh2-1.4.3-10.el7_2.1.ppc64le libstdc++-4.8.5-16.el=
7_4.1.ppc64le libtasn1-4.10-1.el7.ppc64le nettle-2.7.1-8.el7.ppc64le nspr-4=
.13.1-1.0.el7_3.ppc64le nss-3.28.4-15.el7_4.ppc64le nss-softokn-freebl-3.28=
.3-8.el7_4.ppc64le nss-util-3.28.4-3.el7.ppc64le openldap-2.4.44-5.el7.ppc6=
4le openssl-libs-1.0.2k-8.el7.ppc64le p11-kit-0.23.5-3.el7.ppc64le pcre-8.3=
2-17.el7.ppc64le zlib-1.2.7-17.el7.ppc64le
(gdb) bt
#0  0x00000000100af254 in bdrv_co_pdiscard (bs=3D0x3ee89ad0, offset=3D19660=
8, bytes=3D9728) at block/io.c:2545
#1  0x000000001008f260 in blk_co_pdiscard (blk=3D0x3ee79410, offset=3D10854=
4, bytes=3D97792) at block/block-backend.c:1447
#2  0x0000000010090884 in blk_pdiscard_entry (opaque=3D0x3fffd7402c58) at b=
lock/block-backend.c:1851
#3  0x00000000101aa444 in coroutine_trampoline (i0=3D1055521728, i1=3D0) at=
 util/coroutine-ucontext.c:79
#4  0x00003fff7a3d2b9c in makecontext () from /lib64/libc.so.6
#5  0x0000000000000000 in ?? ()
(gdb) bt full
#0  0x00000000100af254 in bdrv_co_pdiscard (bs=3D0x3ee89ad0, offset=3D19660=
8, bytes=3D9728) at block/io.c:2545
        num =3D 9728
        req =3D {bs =3D 0x3ee89ad0, offset =3D 108544, bytes =3D 97792, typ=
e =3D BDRV_TRACKED_DISCARD, serialising =3D false, overlap_offset =3D 10854=
4,
          overlap_bytes =3D 97792, list =3D {le_next =3D 0x0, le_prev =3D 0=
x3ee8cd48}, co =3D 0x3ee9fbc0, wait_queue =3D {entries =3D {sqh_first =3D 0=
x0,
              sqh_last =3D 0x3fff7823fe10}}, waiting_for =3D 0x0}
        max_pdiscard =3D 2147467264
        ret =3D 0
        head =3D 0
        tail =3D 9728
        align =3D 16384
        __PRETTY_FUNCTION__ =3D "bdrv_co_pdiscard"
#1  0x000000001008f260 in blk_co_pdiscard (blk=3D0x3ee79410, offset=3D10854=
4, bytes=3D97792) at block/block-backend.c:1447
        ret =3D 0
#2  0x0000000010090884 in blk_pdiscard_entry (opaque=3D0x3fffd7402c58) at b=
lock/block-backend.c:1851
        rwco =3D 0x3fffd7402c58
#3  0x00000000101aa444 in coroutine_trampoline (i0=3D1055521728, i1=3D0) at=
 util/coroutine-ucontext.c:79
        arg =3D {p =3D 0x3ee9fbc0, i =3D {1055521728, 0}}
        self =3D 0x3ee9fbc0
        co =3D 0x3ee9fbc0
#4  0x00003fff7a3d2b9c in makecontext () from /lib64/libc.so.6
No symbol table info available.
#5  0x0000000000000000 in ?? ()
No symbol table info available.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728660

Title:
  qemu-io segfaults at block/io.c:2545

Status in QEMU:
  New

Bug description:
  git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
  This is on ppc64le architecture.

  Re-production steps:

  1. Copy the attached file named test.img to a directory
  2. And customize the following command to point to the above directory an=
d run the same.
  # mv test.img copy.img
  # qemu-io <path to>/copy.img -c "discard 108544 97792"

  from gdb:
  Program terminated with signal 11, Segmentation fault.
  #0  0x00000000100af254 in bdrv_co_pdiscard (bs=3D0x3ee89ad0, offset=3D196=
608, bytes=3D9728) at block/io.c:2545
  2545	        if (bs->drv->bdrv_co_pdiscard) {
  Missing separate debuginfos, use: debuginfo-install cyrus-sasl-lib-2.1.26=
-21.el7.ppc64le glib2-2.50.3-3.el7.ppc64le glibc-2.17-196.el7.ppc64le gmp-6=
.0.0-15.el7.ppc64le gnutls-3.3.26-9.el7.ppc64le keyutils-libs-1.5.8-3.el7.p=
pc64le krb5-libs-1.15.1-8.el7.ppc64le libaio-0.3.109-13.el7.ppc64le libcom_=
err-1.42.9-10.el7.ppc64le libcurl-7.29.0-42.el7.ppc64le libffi-3.0.13-18.el=
7.ppc64le libgcc-4.8.5-16.el7_4.1.ppc64le libidn-1.28-4.el7.ppc64le libseli=
nux-2.5-11.el7.ppc64le libssh2-1.4.3-10.el7_2.1.ppc64le libstdc++-4.8.5-16.=
el7_4.1.ppc64le libtasn1-4.10-1.el7.ppc64le nettle-2.7.1-8.el7.ppc64le nspr=
-4.13.1-1.0.el7_3.ppc64le nss-3.28.4-15.el7_4.ppc64le nss-softokn-freebl-3.=
28.3-8.el7_4.ppc64le nss-util-3.28.4-3.el7.ppc64le openldap-2.4.44-5.el7.pp=
c64le openssl-libs-1.0.2k-8.el7.ppc64le p11-kit-0.23.5-3.el7.ppc64le pcre-8=
.32-17.el7.ppc64le zlib-1.2.7-17.el7.ppc64le
  (gdb) bt
  #0  0x00000000100af254 in bdrv_co_pdiscard (bs=3D0x3ee89ad0, offset=3D196=
608, bytes=3D9728) at block/io.c:2545
  #1  0x000000001008f260 in blk_co_pdiscard (blk=3D0x3ee79410, offset=3D108=
544, bytes=3D97792) at block/block-backend.c:1447
  #2  0x0000000010090884 in blk_pdiscard_entry (opaque=3D0x3fffd7402c58) at=
 block/block-backend.c:1851
  #3  0x00000000101aa444 in coroutine_trampoline (i0=3D1055521728, i1=3D0) =
at util/coroutine-ucontext.c:79
  #4  0x00003fff7a3d2b9c in makecontext () from /lib64/libc.so.6
  #5  0x0000000000000000 in ?? ()
  (gdb) bt full
  #0  0x00000000100af254 in bdrv_co_pdiscard (bs=3D0x3ee89ad0, offset=3D196=
608, bytes=3D9728) at block/io.c:2545
          num =3D 9728
          req =3D {bs =3D 0x3ee89ad0, offset =3D 108544, bytes =3D 97792, t=
ype =3D BDRV_TRACKED_DISCARD, serialising =3D false, overlap_offset =3D 108=
544,
            overlap_bytes =3D 97792, list =3D {le_next =3D 0x0, le_prev =3D=
 0x3ee8cd48}, co =3D 0x3ee9fbc0, wait_queue =3D {entries =3D {sqh_first =3D=
 0x0,
                sqh_last =3D 0x3fff7823fe10}}, waiting_for =3D 0x0}
          max_pdiscard =3D 2147467264
          ret =3D 0
          head =3D 0
          tail =3D 9728
          align =3D 16384
          __PRETTY_FUNCTION__ =3D "bdrv_co_pdiscard"
  #1  0x000000001008f260 in blk_co_pdiscard (blk=3D0x3ee79410, offset=3D108=
544, bytes=3D97792) at block/block-backend.c:1447
          ret =3D 0
  #2  0x0000000010090884 in blk_pdiscard_entry (opaque=3D0x3fffd7402c58) at=
 block/block-backend.c:1851
          rwco =3D 0x3fffd7402c58
  #3  0x00000000101aa444 in coroutine_trampoline (i0=3D1055521728, i1=3D0) =
at util/coroutine-ucontext.c:79
          arg =3D {p =3D 0x3ee9fbc0, i =3D {1055521728, 0}}
          self =3D 0x3ee9fbc0
          co =3D 0x3ee9fbc0
  #4  0x00003fff7a3d2b9c in makecontext () from /lib64/libc.so.6
  No symbol table info available.
  #5  0x0000000000000000 in ?? ()
  No symbol table info available.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728660/+subscriptions
