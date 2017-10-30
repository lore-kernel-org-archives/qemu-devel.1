Received: from eggs.gnu.org ([2001:4830:134:3::10]:54071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9Dac-0006Tl-P9
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:11:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9Dab-00040Z-16
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:11:06 -0400
Received: from indium.canonical.com ([91.189.90.7]:48350)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e9Daa-0003yz-OL
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 13:11:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e9DaZ-000134-RF
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 17:11:03 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CAD862E80CB
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 17:11:03 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Oct 2017 16:57:15 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1728657 <1728657@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150938258765.4619.4960159407611508533.malonedeb@chaenomeles.canonical.com>
Message-Id: <150938263539.19943.14729032274156278828.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728657] Re: qemu-io: block/qcow2-cluster.c:1109:
 handle_copied: Assertion failed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Attachment added: "test.img tarred"
   https://bugs.launchpad.net/qemu/+bug/1728657/+attachment/5000204/+files/=
test.img_1728657.tar.gz

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728657

Title:
  qemu-io: block/qcow2-cluster.c:1109: handle_copied: Assertion failed

Status in QEMU:
  New

Bug description:
  git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
  This is on ppc64le architecture.

  Re-production steps:

  1. Copy the attached file test.img to a directory
  2. And customize the following command to point to the above directory an=
d run the same.
  # mv test.img copy.img
  # qemu-io <path to>/copy.img -c "write 4105728 2791936"

  from gdb:
  (gdb) bt
  #0  0x00003fffb17eeff0 in raise () from /lib64/libc.so.6
  #1  0x00003fffb17f136c in abort () from /lib64/libc.so.6
  #2  0x00003fffb17e4c44 in __assert_fail_base () from /lib64/libc.so.6
  #3  0x00003fffb17e4d34 in __assert_fail () from /lib64/libc.so.6
  #4  0x00000000100631fc in handle_copied (bs=3D0x42ba9ad0, guest_offset=3D=
4210688, host_offset=3D0x3fffaf4bfab0, bytes=3D0x3fffaf4bfab8, m=3D0x3fffaf=
4bfb60)
      at block/qcow2-cluster.c:1108
  #5  0x0000000010064118 in qcow2_alloc_cluster_offset (bs=3D0x42ba9ad0, of=
fset=3D4194304, bytes=3D0x3fffaf4bfb4c, host_offset=3D0x3fffaf4bfb58, m=3D0=
x3fffaf4bfb60)
      at block/qcow2-cluster.c:1498
  #6  0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x42ba9ad0, offset=3D419=
4304, bytes=3D2703360, qiov=3D0x3fffc7cc9ee0, flags=3D0) at block/qcow2.c:1=
919
  #7  0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x42ba9ad0, offset=3D=
4105728, bytes=3D2791936, qiov=3D0x3fffc7cc9ee0, flags=3D16) at block/io.c:=
898
  #8  0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x42bb8250, req=
=3D0x3fffaf4bfdd8, offset=3D4105728, bytes=3D2791936, align=3D1, qiov=3D0x3=
fffc7cc9ee0, flags=3D16)
      at block/io.c:1440
  #9  0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x42bb8250, offset=3D4=
105728, bytes=3D2791936, qiov=3D0x3fffc7cc9ee0, flags=3DBDRV_REQ_FUA) at bl=
ock/io.c:1691
  #10 0x000000001008da0c in blk_co_pwritev (blk=3D0x42b99410, offset=3D4105=
728, bytes=3D2791936, qiov=3D0x3fffc7cc9ee0, flags=3DBDRV_REQ_FUA) at block=
/block-backend.c:1085
  #11 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffc7cc9ef8) at bl=
ock/block-backend.c:1110
  #12 0x00000000101aa444 in coroutine_trampoline (i0=3D1119572144, i1=3D0) =
at util/coroutine-ucontext.c:79
  #13 0x00003fffb1802b9c in makecontext () from /lib64/libc.so.6
  #14 0x0000000000000000 in ?? ()
  (gdb) bt full
  #0  0x00003fffb17eeff0 in raise () from /lib64/libc.so.6
  No symbol table info available.
  #1  0x00003fffb17f136c in abort () from /lib64/libc.so.6
  No symbol table info available.
  #2  0x00003fffb17e4c44 in __assert_fail_base () from /lib64/libc.so.6
  No symbol table info available.
  #3  0x00003fffb17e4d34 in __assert_fail () from /lib64/libc.so.6
  No symbol table info available.
  #4  0x00000000100631fc in handle_copied (bs=3D0x42ba9ad0, guest_offset=3D=
4210688, host_offset=3D0x3fffaf4bfab0, bytes=3D0x3fffaf4bfab8, m=3D0x3fffaf=
4bfb60)
      at block/qcow2-cluster.c:1108
          s =3D 0x42bb5d80
          l2_index =3D 0
          cluster_offset =3D 4210688
          l2_table =3D 0x0
          nb_clusters =3D 1119575424
          keep_clusters =3D 0
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "handle_copied"
  #5  0x0000000010064118 in qcow2_alloc_cluster_offset (bs=3D0x42ba9ad0, of=
fset=3D4194304, bytes=3D0x3fffaf4bfb4c, host_offset=3D0x3fffaf4bfb58, m=3D0=
x3fffaf4bfb60)
      at block/qcow2-cluster.c:1498
          s =3D 0x42bb5d80
          start =3D 4210688
          remaining =3D 2686976
          cluster_offset =3D 4294983168
          cur_bytes =3D 2686976
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "qcow2_alloc_cluster_offset"
  #6  0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x42ba9ad0, offset=3D419=
4304, bytes=3D2703360, qiov=3D0x3fffc7cc9ee0, flags=3D0) at block/qcow2.c:1=
919
          s =3D 0x42bb5d80
          offset_in_cluster =3D 0
          ret =3D 0
          cur_bytes =3D 2703360
          cluster_offset =3D 4294950912
          hd_qiov =3D {iov =3D 0x42b74fb0, niov =3D 1, nalloc =3D 1, size =
=3D 16384}
          bytes_done =3D 88576
          cluster_data =3D 0x0
          l2meta =3D 0x42bb5d20
          __PRETTY_FUNCTION__ =3D "qcow2_co_pwritev"
  #7  0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x42ba9ad0, offset=3D=
4105728, bytes=3D2791936, qiov=3D0x3fffc7cc9ee0, flags=3D16) at block/io.c:=
898
          drv =3D 0x102036f0 <bdrv_qcow2>
          sector_num =3D 1119538320
          nb_sectors =3D 2841469356
          ret =3D 2116577536
          __PRETTY_FUNCTION__ =3D "bdrv_driver_pwritev"
  #8  0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x42bb8250, req=
=3D0x3fffaf4bfdd8, offset=3D4105728, bytes=3D2791936, align=3D1, qiov=3D0x3=
fffc7cc9ee0, flags=3D16)
      at block/io.c:1440
          bs =3D 0x42ba9ad0
          drv =3D 0x102036f0 <bdrv_qcow2>
          waited =3D false
          ret =3D 0
  ---Type <return> to continue, or q <return> to quit---
          end_sector =3D 13472
          bytes_remaining =3D 2791936
          max_transfer =3D 2147483647
          __PRETTY_FUNCTION__ =3D "bdrv_aligned_pwritev"
  #9  0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x42bb8250, offset=3D4=
105728, bytes=3D2791936, qiov=3D0x3fffc7cc9ee0, flags=3DBDRV_REQ_FUA) at bl=
ock/io.c:1691
          bs =3D 0x42ba9ad0
          req =3D {bs =3D 0x42ba9ad0, offset =3D 4105728, bytes =3D 2791936=
, type =3D BDRV_TRACKED_WRITE, serialising =3D false, overlap_offset =3D 41=
05728,
            overlap_bytes =3D 2791936, list =3D {le_next =3D 0x0, le_prev =
=3D 0x42bacd48}, co =3D 0x42bb50b0, wait_queue =3D {entries =3D {sqh_first =
=3D 0x0,
                sqh_last =3D 0x3fffaf4bfe20}}, waiting_for =3D 0x0}
          align =3D 1
          head_buf =3D 0x0
          tail_buf =3D 0x0
          local_qiov =3D {iov =3D 0x3fffaf4bfdb0, niov =3D -1353974288, nal=
loc =3D 16383, size =3D 4105728}
          use_local_qiov =3D false
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "bdrv_co_pwritev"
  #10 0x000000001008da0c in blk_co_pwritev (blk=3D0x42b99410, offset=3D4105=
728, bytes=3D2791936, qiov=3D0x3fffc7cc9ee0, flags=3DBDRV_REQ_FUA) at block=
/block-backend.c:1085
          ret =3D 0
          bs =3D 0x42ba9ad0
  #11 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffc7cc9ef8) at bl=
ock/block-backend.c:1110
          rwco =3D 0x3fffc7cc9ef8
  #12 0x00000000101aa444 in coroutine_trampoline (i0=3D1119572144, i1=3D0) =
at util/coroutine-ucontext.c:79
          arg =3D {p =3D 0x42bb50b0, i =3D {1119572144, 0}}
          self =3D 0x42bb50b0
          co =3D 0x42bb50b0
  #13 0x00003fffb1802b9c in makecontext () from /lib64/libc.so.6
  No symbol table info available.
  #14 0x0000000000000000 in ?? ()
  No symbol table info available.

  will attach images_fuzzer image.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728657/+subscriptions
