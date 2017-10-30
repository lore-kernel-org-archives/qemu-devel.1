Received: from eggs.gnu.org ([2001:4830:134:3::10]:39230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9Co4-0002AI-5P
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:20:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9Cny-0007Zt-Mv
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:20:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:38638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e9Cny-0007Yj-Av
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 12:20:50 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e9Cnw-00031A-CW
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 16:20:48 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4FC6F2E80C3
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 16:20:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Oct 2017 16:05:32 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1728643 <1728643@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150937953266.9096.12628007784227392331.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728643] [NEW] qemu-io fails with Assertion
 `*host_offset != 0' failed
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

1. Copy the attached files named test.img to a directory
2. And customize the following command to point to the above directory and =
run the same.
# cp test.img copy.img
# qemu-io <path to>/copy.img -c "write 884736 34816"

from gdb:
(gdb) bt
#0  0x00003fffad63eff0 in raise () from /lib64/libc.so.6
#1  0x00003fffad64136c in abort () from /lib64/libc.so.6
#2  0x00003fffad634c44 in __assert_fail_base () from /lib64/libc.so.6
#3  0x00003fffad634d34 in __assert_fail () from /lib64/libc.so.6
#4  0x000000001006426c in qcow2_alloc_cluster_offset (bs=3D0x391e9ad0, offs=
et=3D884736, bytes=3D0x3fffaa89fb4c, host_offset=3D0x3fffaa89fb58, m=3D0x3f=
ffaa89fb60)
    at block/qcow2-cluster.c:1524
#5  0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x391e9ad0, offset=3D88473=
6, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D0) at block/qcow2.c:1919
#6  0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x391e9ad0, offset=3D88=
4736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D16) at block/io.c:898
#7  0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x391f51a0, req=3D0=
x3fffaa89fdd8, offset=3D884736, bytes=3D34816, align=3D1, qiov=3D0x3fffce0e=
2940, flags=3D16)
    at block/io.c:1440
#8  0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x391f51a0, offset=3D884=
736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block/i=
o.c:1691
#9  0x000000001008da0c in blk_co_pwritev (blk=3D0x391d9410, offset=3D884736=
, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block/bloc=
k-backend.c:1085
#10 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffce0e2958) at bloc=
k/block-backend.c:1110
#11 0x00000000101aa444 in coroutine_trampoline (i0=3D958427472, i1=3D0) at =
util/coroutine-ucontext.c:79
#12 0x00003fffad652b9c in makecontext () from /lib64/libc.so.6
#13 0x0000000000000000 in ?? ()
(gdb) bt full
#0  0x00003fffad63eff0 in raise () from /lib64/libc.so.6
No symbol table info available.
#1  0x00003fffad64136c in abort () from /lib64/libc.so.6
No symbol table info available.
#2  0x00003fffad634c44 in __assert_fail_base () from /lib64/libc.so.6
No symbol table info available.
#3  0x00003fffad634d34 in __assert_fail () from /lib64/libc.so.6
No symbol table info available.
#4  0x000000001006426c in qcow2_alloc_cluster_offset (bs=3D0x391e9ad0, offs=
et=3D884736, bytes=3D0x3fffaa89fb4c, host_offset=3D0x3fffaa89fb58, m=3D0x3f=
ffaa89fb60)
    at block/qcow2-cluster.c:1524
        s =3D 0x391f5d80
        start =3D 919552
        remaining =3D 0
        cluster_offset =3D 399360
        cur_bytes =3D 34816
        ret =3D 1
        __PRETTY_FUNCTION__ =3D "qcow2_alloc_cluster_offset"
#5  0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x391e9ad0, offset=3D88473=
6, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D0) at block/qcow2.c:1919
        s =3D 0x391f5d80
        offset_in_cluster =3D 360448
        ret =3D 0
        cur_bytes =3D 34816
        cluster_offset =3D 0
        hd_qiov =3D {iov =3D 0x391b85a0, niov =3D 0, nalloc =3D 1, size =3D=
 0}
        bytes_done =3D 0
        cluster_data =3D 0x0
        l2meta =3D 0x392074c0
        __PRETTY_FUNCTION__ =3D "qcow2_co_pwritev"
#6  0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x391e9ad0, offset=3D88=
4736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D16) at block/io.c:898
        drv =3D 0x102036f0 <bdrv_qcow2>
        sector_num =3D 958319760
        nb_sectors =3D 2340082071
        ret =3D 743104256
        __PRETTY_FUNCTION__ =3D "bdrv_driver_pwritev"
#7  0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x391f51a0, req=3D0=
x3fffaa89fdd8, offset=3D884736, bytes=3D34816, align=3D1, qiov=3D0x3fffce0e=
2940, flags=3D16)
    at block/io.c:1440
        bs =3D 0x391e9ad0
        drv =3D 0x102036f0 <bdrv_qcow2>
        waited =3D false
        ret =3D 0
        end_sector =3D 1796
        bytes_remaining =3D 34816
        max_transfer =3D 2147483647
        __PRETTY_FUNCTION__ =3D "bdrv_aligned_pwritev"
#8  0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x391f51a0, offset=3D884=
736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block/i=
o.c:1691
        bs =3D 0x391e9ad0
        req =3D {bs =3D 0x391e9ad0, offset =3D 884736, bytes =3D 34816, typ=
e =3D BDRV_TRACKED_WRITE, serialising =3D false, overlap_offset =3D 884736,
          overlap_bytes =3D 34816, list =3D {le_next =3D 0x0, le_prev =3D 0=
x391ecd48}, co =3D 0x39207150, wait_queue =3D {entries =3D {sqh_first =3D 0=
x0,
              sqh_last =3D 0x3fffaa89fe20}}, waiting_for =3D 0x0}
        align =3D 1
---Type <return> to continue, or q <return> to quit---
        head_buf =3D 0x0
        tail_buf =3D 0x0
        local_qiov =3D {iov =3D 0x3fffaa89fdb0, niov =3D -1433797136, nallo=
c =3D 16383, size =3D 884736}
        use_local_qiov =3D false
        ret =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_co_pwritev"
#9  0x000000001008da0c in blk_co_pwritev (blk=3D0x391d9410, offset=3D884736=
, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block/bloc=
k-backend.c:1085
        ret =3D 0
        bs =3D 0x391e9ad0
#10 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffce0e2958) at bloc=
k/block-backend.c:1110
        rwco =3D 0x3fffce0e2958
#11 0x00000000101aa444 in coroutine_trampoline (i0=3D958427472, i1=3D0) at =
util/coroutine-ucontext.c:79
        arg =3D {p =3D 0x39207150, i =3D {958427472, 0}}
        self =3D 0x39207150
        co =3D 0x39207150
#12 0x00003fffad652b9c in makecontext () from /lib64/libc.so.6
No symbol table info available.
#13 0x0000000000000000 in ?? ()
No symbol table info available.


Will be attaching image_fuzzer images.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728643

Title:
  qemu-io fails with Assertion `*host_offset !=3D 0' failed

Status in QEMU:
  New

Bug description:
  git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
  This is on ppc64le architecture.

  Re-production steps:

  1. Copy the attached files named test.img to a directory
  2. And customize the following command to point to the above directory an=
d run the same.
  # cp test.img copy.img
  # qemu-io <path to>/copy.img -c "write 884736 34816"

  from gdb:
  (gdb) bt
  #0  0x00003fffad63eff0 in raise () from /lib64/libc.so.6
  #1  0x00003fffad64136c in abort () from /lib64/libc.so.6
  #2  0x00003fffad634c44 in __assert_fail_base () from /lib64/libc.so.6
  #3  0x00003fffad634d34 in __assert_fail () from /lib64/libc.so.6
  #4  0x000000001006426c in qcow2_alloc_cluster_offset (bs=3D0x391e9ad0, of=
fset=3D884736, bytes=3D0x3fffaa89fb4c, host_offset=3D0x3fffaa89fb58, m=3D0x=
3fffaa89fb60)
      at block/qcow2-cluster.c:1524
  #5  0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x391e9ad0, offset=3D884=
736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D0) at block/qcow2.c:1919
  #6  0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x391e9ad0, offset=3D=
884736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D16) at block/io.c:898
  #7  0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x391f51a0, req=
=3D0x3fffaa89fdd8, offset=3D884736, bytes=3D34816, align=3D1, qiov=3D0x3fff=
ce0e2940, flags=3D16)
      at block/io.c:1440
  #8  0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x391f51a0, offset=3D8=
84736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block=
/io.c:1691
  #9  0x000000001008da0c in blk_co_pwritev (blk=3D0x391d9410, offset=3D8847=
36, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block/bl=
ock-backend.c:1085
  #10 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffce0e2958) at bl=
ock/block-backend.c:1110
  #11 0x00000000101aa444 in coroutine_trampoline (i0=3D958427472, i1=3D0) a=
t util/coroutine-ucontext.c:79
  #12 0x00003fffad652b9c in makecontext () from /lib64/libc.so.6
  #13 0x0000000000000000 in ?? ()
  (gdb) bt full
  #0  0x00003fffad63eff0 in raise () from /lib64/libc.so.6
  No symbol table info available.
  #1  0x00003fffad64136c in abort () from /lib64/libc.so.6
  No symbol table info available.
  #2  0x00003fffad634c44 in __assert_fail_base () from /lib64/libc.so.6
  No symbol table info available.
  #3  0x00003fffad634d34 in __assert_fail () from /lib64/libc.so.6
  No symbol table info available.
  #4  0x000000001006426c in qcow2_alloc_cluster_offset (bs=3D0x391e9ad0, of=
fset=3D884736, bytes=3D0x3fffaa89fb4c, host_offset=3D0x3fffaa89fb58, m=3D0x=
3fffaa89fb60)
      at block/qcow2-cluster.c:1524
          s =3D 0x391f5d80
          start =3D 919552
          remaining =3D 0
          cluster_offset =3D 399360
          cur_bytes =3D 34816
          ret =3D 1
          __PRETTY_FUNCTION__ =3D "qcow2_alloc_cluster_offset"
  #5  0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x391e9ad0, offset=3D884=
736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D0) at block/qcow2.c:1919
          s =3D 0x391f5d80
          offset_in_cluster =3D 360448
          ret =3D 0
          cur_bytes =3D 34816
          cluster_offset =3D 0
          hd_qiov =3D {iov =3D 0x391b85a0, niov =3D 0, nalloc =3D 1, size =
=3D 0}
          bytes_done =3D 0
          cluster_data =3D 0x0
          l2meta =3D 0x392074c0
          __PRETTY_FUNCTION__ =3D "qcow2_co_pwritev"
  #6  0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x391e9ad0, offset=3D=
884736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3D16) at block/io.c:898
          drv =3D 0x102036f0 <bdrv_qcow2>
          sector_num =3D 958319760
          nb_sectors =3D 2340082071
          ret =3D 743104256
          __PRETTY_FUNCTION__ =3D "bdrv_driver_pwritev"
  #7  0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x391f51a0, req=
=3D0x3fffaa89fdd8, offset=3D884736, bytes=3D34816, align=3D1, qiov=3D0x3fff=
ce0e2940, flags=3D16)
      at block/io.c:1440
          bs =3D 0x391e9ad0
          drv =3D 0x102036f0 <bdrv_qcow2>
          waited =3D false
          ret =3D 0
          end_sector =3D 1796
          bytes_remaining =3D 34816
          max_transfer =3D 2147483647
          __PRETTY_FUNCTION__ =3D "bdrv_aligned_pwritev"
  #8  0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x391f51a0, offset=3D8=
84736, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block=
/io.c:1691
          bs =3D 0x391e9ad0
          req =3D {bs =3D 0x391e9ad0, offset =3D 884736, bytes =3D 34816, t=
ype =3D BDRV_TRACKED_WRITE, serialising =3D false, overlap_offset =3D 88473=
6,
            overlap_bytes =3D 34816, list =3D {le_next =3D 0x0, le_prev =3D=
 0x391ecd48}, co =3D 0x39207150, wait_queue =3D {entries =3D {sqh_first =3D=
 0x0,
                sqh_last =3D 0x3fffaa89fe20}}, waiting_for =3D 0x0}
          align =3D 1
  ---Type <return> to continue, or q <return> to quit---
          head_buf =3D 0x0
          tail_buf =3D 0x0
          local_qiov =3D {iov =3D 0x3fffaa89fdb0, niov =3D -1433797136, nal=
loc =3D 16383, size =3D 884736}
          use_local_qiov =3D false
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "bdrv_co_pwritev"
  #9  0x000000001008da0c in blk_co_pwritev (blk=3D0x391d9410, offset=3D8847=
36, bytes=3D34816, qiov=3D0x3fffce0e2940, flags=3DBDRV_REQ_FUA) at block/bl=
ock-backend.c:1085
          ret =3D 0
          bs =3D 0x391e9ad0
  #10 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffce0e2958) at bl=
ock/block-backend.c:1110
          rwco =3D 0x3fffce0e2958
  #11 0x00000000101aa444 in coroutine_trampoline (i0=3D958427472, i1=3D0) a=
t util/coroutine-ucontext.c:79
          arg =3D {p =3D 0x39207150, i =3D {958427472, 0}}
          self =3D 0x39207150
          co =3D 0x39207150
  #12 0x00003fffad652b9c in makecontext () from /lib64/libc.so.6
  No symbol table info available.
  #13 0x0000000000000000 in ?? ()
  No symbol table info available.

  =

  Will be attaching image_fuzzer images.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728643/+subscriptions
