Received: from eggs.gnu.org ([2001:4830:134:3::10]:43879)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9BOs-0001la-R9
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1e9BOp-0002ww-Ky
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:50:50 -0400
Received: from indium.canonical.com ([91.189.90.7]:52970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1e9BOp-0002wa-Bb
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 10:50:47 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1e9BOm-0004At-L5
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 14:50:44 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 9D2BC2E80CB
	for <qemu-devel@nongnu.org>; Mon, 30 Oct 2017 14:50:44 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 30 Oct 2017 14:43:19 -0000
From: "R.Nageswara Sastry" <nasastry@in.ibm.com>
Reply-To: Bug 1728615 <1728615@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <150937459938.20015.8535040492037652631.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1728615] [NEW] qemu-io crashes with SIGABRT and
 Assertion `c->entries[i].offset != 0' failed
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

1. Copy the attached files named backing_img.file and test.img to a directo=
ry
2. And customize the following command to point to the above directory and =
run the same.
/usr/bin/qemu-io <path to>/test.img -c "write 1352192 1707520"

3.Output of the above command.
qemu-io: block/qcow2-cache.c:411: qcow2_cache_entry_mark_dirty: Assertion `=
c->entries[i].offset !=3D 0' failed.
Aborted (core dumped)

from gdb:
(gdb) bt
#0  0x00003fff833eeff0 in raise () from /lib64/libc.so.6
#1  0x00003fff833f136c in abort () from /lib64/libc.so.6
#2  0x00003fff833e4c44 in __assert_fail_base () from /lib64/libc.so.6
#3  0x00003fff833e4d34 in __assert_fail () from /lib64/libc.so.6
#4  0x000000001006a594 in qcow2_cache_entry_mark_dirty (bs=3D0x2e886f60, c=
=3D0x2e879700, table=3D0x3fff81200000) at block/qcow2-cache.c:411
#5  0x0000000010056154 in alloc_refcount_block (bs=3D0x2e886f60, cluster_in=
dex=3D2, refcount_block=3D0x3fff80cff808) at block/qcow2-refcount.c:417
#6  0x0000000010057520 in update_refcount (bs=3D0x2e886f60, offset=3D104857=
6, length=3D524288, addend=3D1, decrease=3Dfalse, type=3DQCOW2_DISCARD_NEVE=
R)
    at block/qcow2-refcount.c:834
#7  0x0000000010057dc8 in qcow2_alloc_clusters_at (bs=3D0x2e886f60, offset=
=3D1048576, nb_clusters=3D1) at block/qcow2-refcount.c:1032
#8  0x00000000100636d8 in do_alloc_cluster_offset (bs=3D0x2e886f60, guest_o=
ffset=3D2097152, host_offset=3D0x3fff80cff9e0, nb_clusters=3D0x3fff80cff9d8)
    at block/qcow2-cluster.c:1221
#9  0x0000000010063afc in handle_alloc (bs=3D0x2e886f60, guest_offset=3D209=
7152, host_offset=3D0x3fff80cffab0, bytes=3D0x3fff80cffab8, m=3D0x3fff80cff=
b60)
    at block/qcow2-cluster.c:1324
#10 0x0000000010064178 in qcow2_alloc_cluster_offset (bs=3D0x2e886f60, offs=
et=3D1572864, bytes=3D0x3fff80cffb4c, host_offset=3D0x3fff80cffb58, m=3D0x3=
fff80cffb60)
    at block/qcow2-cluster.c:1511
#11 0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x2e886f60, offset=3D15728=
64, bytes=3D1486848, qiov=3D0x3fffc85f0bf0, flags=3D0) at block/qcow2.c:1919
#12 0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x2e886f60, offset=3D13=
52192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3D16) at block/io.c:898
#13 0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x2e8927f0, req=3D0=
x3fff80cffdd8, offset=3D1352192, bytes=3D1707520, align=3D1, qiov=3D0x3fffc=
85f0bf0, flags=3D16)
    at block/io.c:1440
#14 0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x2e8927f0, offset=3D135=
2192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at bloc=
k/io.c:1691
#15 0x000000001008da0c in blk_co_pwritev (blk=3D0x2e879410, offset=3D135219=
2, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at block/b=
lock-backend.c:1085
#16 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffc85f0c08) at bloc=
k/block-backend.c:1110
#17 0x00000000101aa444 in coroutine_trampoline (i0=3D780753552, i1=3D0) at =
util/coroutine-ucontext.c:79
#18 0x00003fff83402b9c in makecontext () from /lib64/libc.so.6
#19 0x0000000000000000 in ?? ()
(gdb) bt full
#0  0x00003fff833eeff0 in raise () from /lib64/libc.so.6
No symbol table info available.
#1  0x00003fff833f136c in abort () from /lib64/libc.so.6
No symbol table info available.
#2  0x00003fff833e4c44 in __assert_fail_base () from /lib64/libc.so.6
No symbol table info available.
#3  0x00003fff833e4d34 in __assert_fail () from /lib64/libc.so.6
No symbol table info available.
#4  0x000000001006a594 in qcow2_cache_entry_mark_dirty (bs=3D0x2e886f60, c=
=3D0x2e879700, table=3D0x3fff81200000) at block/qcow2-cache.c:411
        i =3D 0
        __PRETTY_FUNCTION__ =3D "qcow2_cache_entry_mark_dirty"
#5  0x0000000010056154 in alloc_refcount_block (bs=3D0x2e886f60, cluster_in=
dex=3D2, refcount_block=3D0x3fff80cff808) at block/qcow2-refcount.c:417
        s =3D 0x2e893210
        refcount_table_index =3D 0
        ret =3D 0
        new_block =3D 0
        blocks_used =3D 72057594818669408
        meta_offset =3D 1572863
#6  0x0000000010057520 in update_refcount (bs=3D0x2e886f60, offset=3D104857=
6, length=3D524288, addend=3D1, decrease=3Dfalse, type=3DQCOW2_DISCARD_NEVE=
R)
    at block/qcow2-refcount.c:834
        block_index =3D 268870408
        refcount =3D 780741808
        cluster_index =3D 2
        table_index =3D 0
        s =3D 0x2e893210
        start =3D 1048576
        last =3D 1048576
        cluster_offset =3D 1048576
        refcount_block =3D 0x3fff81200000
        old_table_index =3D -1
        ret =3D 16383
#7  0x0000000010057dc8 in qcow2_alloc_clusters_at (bs=3D0x2e886f60, offset=
=3D1048576, nb_clusters=3D1) at block/qcow2-refcount.c:1032
        s =3D 0x2e893210
        cluster_index =3D 3
        refcount =3D 0
        i =3D 1
        ret =3D 0
        __PRETTY_FUNCTION__ =3D "qcow2_alloc_clusters_at"
#8  0x00000000100636d8 in do_alloc_cluster_offset (bs=3D0x2e886f60, guest_o=
ffset=3D2097152, host_offset=3D0x3fff80cff9e0, nb_clusters=3D0x3fff80cff9d8)
    at block/qcow2-cluster.c:1221
        ret =3D 780743184
        s =3D 0x2e893210
#9  0x0000000010063afc in handle_alloc (bs=3D0x2e886f60, guest_offset=3D209=
7152, host_offset=3D0x3fff80cffab0, bytes=3D0x3fff80cffab8, m=3D0x3fff80cff=
b60)
    at block/qcow2-cluster.c:1324
        s =3D 0x2e893210
        l2_index =3D 4
        l2_table =3D 0x0
        entry =3D 0
        nb_clusters =3D 1
        ret =3D 0
---Type <return> to continue, or q <return> to quit---
        keep_old_clusters =3D false
        alloc_cluster_offset =3D 1048576
        __PRETTY_FUNCTION__ =3D "handle_alloc"
        requested_bytes =3D 17960562528
        avail_bytes =3D -2133853344
        nb_bytes =3D 16383
        old_m =3D 0x100000000
#10 0x0000000010064178 in qcow2_alloc_cluster_offset (bs=3D0x2e886f60, offs=
et=3D1572864, bytes=3D0x3fff80cffb4c, host_offset=3D0x3fff80cffb58, m=3D0x3=
fff80cffb60)
    at block/qcow2-cluster.c:1511
        s =3D 0x2e893210
        start =3D 2097152
        remaining =3D 962560
        cluster_offset =3D 1048576
        cur_bytes =3D 962560
        ret =3D 0
        __PRETTY_FUNCTION__ =3D "qcow2_alloc_cluster_offset"
#11 0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x2e886f60, offset=3D15728=
64, bytes=3D1486848, qiov=3D0x3fffc85f0bf0, flags=3D0) at block/qcow2.c:1919
        s =3D 0x2e893210
        offset_in_cluster =3D 0
        ret =3D 0
        cur_bytes =3D 1486848
        cluster_offset =3D 524288
        hd_qiov =3D {iov =3D 0x2e858660, niov =3D 1, nalloc =3D 1, size =3D=
 220672}
        bytes_done =3D 220672
        cluster_data =3D 0x0
        l2meta =3D 0x0
        __PRETTY_FUNCTION__ =3D "qcow2_co_pwritev"
#12 0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x2e886f60, offset=3D13=
52192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3D16) at block/io.c:898
        drv =3D 0x102036f0 <bdrv_qcow2>
        sector_num =3D 780706080
        nb_sectors =3D 3069122264
        ret =3D -203160320
        __PRETTY_FUNCTION__ =3D "bdrv_driver_pwritev"
#13 0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x2e8927f0, req=3D0=
x3fff80cffdd8, offset=3D1352192, bytes=3D1707520, align=3D1, qiov=3D0x3fffc=
85f0bf0, flags=3D16)
    at block/io.c:1440
        bs =3D 0x2e886f60
        drv =3D 0x102036f0 <bdrv_qcow2>
        waited =3D false
        ret =3D 0
        end_sector =3D 5976
        bytes_remaining =3D 1707520
        max_transfer =3D 2147483647
        __PRETTY_FUNCTION__ =3D "bdrv_aligned_pwritev"
#14 0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x2e8927f0, offset=3D135=
2192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at bloc=
k/io.c:1691
        bs =3D 0x2e886f60
        req =3D {bs =3D 0x2e886f60, offset =3D 1352192, bytes =3D 1707520, =
type =3D BDRV_TRACKED_WRITE, serialising =3D false, overlap_offset =3D 1352=
192,
          overlap_bytes =3D 1707520, list =3D {le_next =3D 0x0, le_prev =3D=
 0x2e88a1d8}, co =3D 0x2e895a90, wait_queue =3D {entries =3D {sqh_first =3D=
 0x0,
              sqh_last =3D 0x3fff80cffe20}}, waiting_for =3D 0x0}
        align =3D 1
        head_buf =3D 0x0
---Type <return> to continue, or q <return> to quit---
        tail_buf =3D 0x0
        local_qiov =3D {iov =3D 0x3fff80cffdb0, niov =3D -2133852688, nallo=
c =3D 16383, size =3D 1352192}
        use_local_qiov =3D false
        ret =3D 0
        __PRETTY_FUNCTION__ =3D "bdrv_co_pwritev"
#15 0x000000001008da0c in blk_co_pwritev (blk=3D0x2e879410, offset=3D135219=
2, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at block/b=
lock-backend.c:1085
        ret =3D 0
        bs =3D 0x2e886f60
#16 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffc85f0c08) at bloc=
k/block-backend.c:1110
        rwco =3D 0x3fffc85f0c08
#17 0x00000000101aa444 in coroutine_trampoline (i0=3D780753552, i1=3D0) at =
util/coroutine-ucontext.c:79
        arg =3D {p =3D 0x2e895a90, i =3D {780753552, 0}}
        self =3D 0x2e895a90
        co =3D 0x2e895a90
#18 0x00003fff83402b9c in makecontext () from /lib64/libc.so.6
No symbol table info available.
#19 0x0000000000000000 in ?? ()
No symbol table info available.

Will attach the 'image_fuzzer' images.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1728615

Title:
  qemu-io crashes with SIGABRT and Assertion `c->entries[i].offset !=3D 0'
  failed

Status in QEMU:
  New

Bug description:
  git is at HEAD a93ece47fd9edbd4558db24300056c9a57d3bcd4
  This is on ppc64le architecture.

  Re-production steps:

  1. Copy the attached files named backing_img.file and test.img to a direc=
tory
  2. And customize the following command to point to the above directory an=
d run the same.
  /usr/bin/qemu-io <path to>/test.img -c "write 1352192 1707520"

  3.Output of the above command.
  qemu-io: block/qcow2-cache.c:411: qcow2_cache_entry_mark_dirty: Assertion=
 `c->entries[i].offset !=3D 0' failed.
  Aborted (core dumped)

  from gdb:
  (gdb) bt
  #0  0x00003fff833eeff0 in raise () from /lib64/libc.so.6
  #1  0x00003fff833f136c in abort () from /lib64/libc.so.6
  #2  0x00003fff833e4c44 in __assert_fail_base () from /lib64/libc.so.6
  #3  0x00003fff833e4d34 in __assert_fail () from /lib64/libc.so.6
  #4  0x000000001006a594 in qcow2_cache_entry_mark_dirty (bs=3D0x2e886f60, =
c=3D0x2e879700, table=3D0x3fff81200000) at block/qcow2-cache.c:411
  #5  0x0000000010056154 in alloc_refcount_block (bs=3D0x2e886f60, cluster_=
index=3D2, refcount_block=3D0x3fff80cff808) at block/qcow2-refcount.c:417
  #6  0x0000000010057520 in update_refcount (bs=3D0x2e886f60, offset=3D1048=
576, length=3D524288, addend=3D1, decrease=3Dfalse, type=3DQCOW2_DISCARD_NE=
VER)
      at block/qcow2-refcount.c:834
  #7  0x0000000010057dc8 in qcow2_alloc_clusters_at (bs=3D0x2e886f60, offse=
t=3D1048576, nb_clusters=3D1) at block/qcow2-refcount.c:1032
  #8  0x00000000100636d8 in do_alloc_cluster_offset (bs=3D0x2e886f60, guest=
_offset=3D2097152, host_offset=3D0x3fff80cff9e0, nb_clusters=3D0x3fff80cff9=
d8)
      at block/qcow2-cluster.c:1221
  #9  0x0000000010063afc in handle_alloc (bs=3D0x2e886f60, guest_offset=3D2=
097152, host_offset=3D0x3fff80cffab0, bytes=3D0x3fff80cffab8, m=3D0x3fff80c=
ffb60)
      at block/qcow2-cluster.c:1324
  #10 0x0000000010064178 in qcow2_alloc_cluster_offset (bs=3D0x2e886f60, of=
fset=3D1572864, bytes=3D0x3fff80cffb4c, host_offset=3D0x3fff80cffb58, m=3D0=
x3fff80cffb60)
      at block/qcow2-cluster.c:1511
  #11 0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x2e886f60, offset=3D157=
2864, bytes=3D1486848, qiov=3D0x3fffc85f0bf0, flags=3D0) at block/qcow2.c:1=
919
  #12 0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x2e886f60, offset=3D=
1352192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3D16) at block/io.c:=
898
  #13 0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x2e8927f0, req=
=3D0x3fff80cffdd8, offset=3D1352192, bytes=3D1707520, align=3D1, qiov=3D0x3=
fffc85f0bf0, flags=3D16)
      at block/io.c:1440
  #14 0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x2e8927f0, offset=3D1=
352192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at bl=
ock/io.c:1691
  #15 0x000000001008da0c in blk_co_pwritev (blk=3D0x2e879410, offset=3D1352=
192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at block=
/block-backend.c:1085
  #16 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffc85f0c08) at bl=
ock/block-backend.c:1110
  #17 0x00000000101aa444 in coroutine_trampoline (i0=3D780753552, i1=3D0) a=
t util/coroutine-ucontext.c:79
  #18 0x00003fff83402b9c in makecontext () from /lib64/libc.so.6
  #19 0x0000000000000000 in ?? ()
  (gdb) bt full
  #0  0x00003fff833eeff0 in raise () from /lib64/libc.so.6
  No symbol table info available.
  #1  0x00003fff833f136c in abort () from /lib64/libc.so.6
  No symbol table info available.
  #2  0x00003fff833e4c44 in __assert_fail_base () from /lib64/libc.so.6
  No symbol table info available.
  #3  0x00003fff833e4d34 in __assert_fail () from /lib64/libc.so.6
  No symbol table info available.
  #4  0x000000001006a594 in qcow2_cache_entry_mark_dirty (bs=3D0x2e886f60, =
c=3D0x2e879700, table=3D0x3fff81200000) at block/qcow2-cache.c:411
          i =3D 0
          __PRETTY_FUNCTION__ =3D "qcow2_cache_entry_mark_dirty"
  #5  0x0000000010056154 in alloc_refcount_block (bs=3D0x2e886f60, cluster_=
index=3D2, refcount_block=3D0x3fff80cff808) at block/qcow2-refcount.c:417
          s =3D 0x2e893210
          refcount_table_index =3D 0
          ret =3D 0
          new_block =3D 0
          blocks_used =3D 72057594818669408
          meta_offset =3D 1572863
  #6  0x0000000010057520 in update_refcount (bs=3D0x2e886f60, offset=3D1048=
576, length=3D524288, addend=3D1, decrease=3Dfalse, type=3DQCOW2_DISCARD_NE=
VER)
      at block/qcow2-refcount.c:834
          block_index =3D 268870408
          refcount =3D 780741808
          cluster_index =3D 2
          table_index =3D 0
          s =3D 0x2e893210
          start =3D 1048576
          last =3D 1048576
          cluster_offset =3D 1048576
          refcount_block =3D 0x3fff81200000
          old_table_index =3D -1
          ret =3D 16383
  #7  0x0000000010057dc8 in qcow2_alloc_clusters_at (bs=3D0x2e886f60, offse=
t=3D1048576, nb_clusters=3D1) at block/qcow2-refcount.c:1032
          s =3D 0x2e893210
          cluster_index =3D 3
          refcount =3D 0
          i =3D 1
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "qcow2_alloc_clusters_at"
  #8  0x00000000100636d8 in do_alloc_cluster_offset (bs=3D0x2e886f60, guest=
_offset=3D2097152, host_offset=3D0x3fff80cff9e0, nb_clusters=3D0x3fff80cff9=
d8)
      at block/qcow2-cluster.c:1221
          ret =3D 780743184
          s =3D 0x2e893210
  #9  0x0000000010063afc in handle_alloc (bs=3D0x2e886f60, guest_offset=3D2=
097152, host_offset=3D0x3fff80cffab0, bytes=3D0x3fff80cffab8, m=3D0x3fff80c=
ffb60)
      at block/qcow2-cluster.c:1324
          s =3D 0x2e893210
          l2_index =3D 4
          l2_table =3D 0x0
          entry =3D 0
          nb_clusters =3D 1
          ret =3D 0
  ---Type <return> to continue, or q <return> to quit---
          keep_old_clusters =3D false
          alloc_cluster_offset =3D 1048576
          __PRETTY_FUNCTION__ =3D "handle_alloc"
          requested_bytes =3D 17960562528
          avail_bytes =3D -2133853344
          nb_bytes =3D 16383
          old_m =3D 0x100000000
  #10 0x0000000010064178 in qcow2_alloc_cluster_offset (bs=3D0x2e886f60, of=
fset=3D1572864, bytes=3D0x3fff80cffb4c, host_offset=3D0x3fff80cffb58, m=3D0=
x3fff80cffb60)
      at block/qcow2-cluster.c:1511
          s =3D 0x2e893210
          start =3D 2097152
          remaining =3D 962560
          cluster_offset =3D 1048576
          cur_bytes =3D 962560
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "qcow2_alloc_cluster_offset"
  #11 0x000000001004d3f4 in qcow2_co_pwritev (bs=3D0x2e886f60, offset=3D157=
2864, bytes=3D1486848, qiov=3D0x3fffc85f0bf0, flags=3D0) at block/qcow2.c:1=
919
          s =3D 0x2e893210
          offset_in_cluster =3D 0
          ret =3D 0
          cur_bytes =3D 1486848
          cluster_offset =3D 524288
          hd_qiov =3D {iov =3D 0x2e858660, niov =3D 1, nalloc =3D 1, size =
=3D 220672}
          bytes_done =3D 220672
          cluster_data =3D 0x0
          l2meta =3D 0x0
          __PRETTY_FUNCTION__ =3D "qcow2_co_pwritev"
  #12 0x00000000100a9648 in bdrv_driver_pwritev (bs=3D0x2e886f60, offset=3D=
1352192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3D16) at block/io.c:=
898
          drv =3D 0x102036f0 <bdrv_qcow2>
          sector_num =3D 780706080
          nb_sectors =3D 3069122264
          ret =3D -203160320
          __PRETTY_FUNCTION__ =3D "bdrv_driver_pwritev"
  #13 0x00000000100ab630 in bdrv_aligned_pwritev (child=3D0x2e8927f0, req=
=3D0x3fff80cffdd8, offset=3D1352192, bytes=3D1707520, align=3D1, qiov=3D0x3=
fffc85f0bf0, flags=3D16)
      at block/io.c:1440
          bs =3D 0x2e886f60
          drv =3D 0x102036f0 <bdrv_qcow2>
          waited =3D false
          ret =3D 0
          end_sector =3D 5976
          bytes_remaining =3D 1707520
          max_transfer =3D 2147483647
          __PRETTY_FUNCTION__ =3D "bdrv_aligned_pwritev"
  #14 0x00000000100ac4ac in bdrv_co_pwritev (child=3D0x2e8927f0, offset=3D1=
352192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at bl=
ock/io.c:1691
          bs =3D 0x2e886f60
          req =3D {bs =3D 0x2e886f60, offset =3D 1352192, bytes =3D 1707520=
, type =3D BDRV_TRACKED_WRITE, serialising =3D false, overlap_offset =3D 13=
52192,
            overlap_bytes =3D 1707520, list =3D {le_next =3D 0x0, le_prev =
=3D 0x2e88a1d8}, co =3D 0x2e895a90, wait_queue =3D {entries =3D {sqh_first =
=3D 0x0,
                sqh_last =3D 0x3fff80cffe20}}, waiting_for =3D 0x0}
          align =3D 1
          head_buf =3D 0x0
  ---Type <return> to continue, or q <return> to quit---
          tail_buf =3D 0x0
          local_qiov =3D {iov =3D 0x3fff80cffdb0, niov =3D -2133852688, nal=
loc =3D 16383, size =3D 1352192}
          use_local_qiov =3D false
          ret =3D 0
          __PRETTY_FUNCTION__ =3D "bdrv_co_pwritev"
  #15 0x000000001008da0c in blk_co_pwritev (blk=3D0x2e879410, offset=3D1352=
192, bytes=3D1707520, qiov=3D0x3fffc85f0bf0, flags=3DBDRV_REQ_FUA) at block=
/block-backend.c:1085
          ret =3D 0
          bs =3D 0x2e886f60
  #16 0x000000001008db68 in blk_write_entry (opaque=3D0x3fffc85f0c08) at bl=
ock/block-backend.c:1110
          rwco =3D 0x3fffc85f0c08
  #17 0x00000000101aa444 in coroutine_trampoline (i0=3D780753552, i1=3D0) a=
t util/coroutine-ucontext.c:79
          arg =3D {p =3D 0x2e895a90, i =3D {780753552, 0}}
          self =3D 0x2e895a90
          co =3D 0x2e895a90
  #18 0x00003fff83402b9c in makecontext () from /lib64/libc.so.6
  No symbol table info available.
  #19 0x0000000000000000 in ?? ()
  No symbol table info available.

  Will attach the 'image_fuzzer' images.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1728615/+subscriptions
