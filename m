Received: from eggs.gnu.org ([2001:4830:134:3::10]:59893)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5Tg4-0002ic-DI
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:01:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d5Tfy-0003PN-7E
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:01:00 -0400
Received: from indium.canonical.com ([91.189.90.7]:35930)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d5Tfx-0003NQ-W9
	for qemu-devel@nongnu.org; Tue, 02 May 2017 05:00:54 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d5Tfw-0000YI-Ms
	for <qemu-devel@nongnu.org>; Tue, 02 May 2017 09:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 88CB62E80CB
	for <qemu-devel@nongnu.org>; Tue,  2 May 2017 09:00:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 May 2017 08:48:09 -0000
From: Lidong Chen <jemmy858585@gmail.com>
Reply-To: Bug 1687569 <1687569@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <20170502084810.2931.3440.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1687569] [NEW] when migration cancel,
 qemu main thread hung
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

qemu version:v2.9.0-rc5 release

1.virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893 --copy-storage-=
all qemu+ssh://10.59.163.38/system
2.press Ctrl+C cancel migrate

 qemu main thread hung

(gdb) bt
#0  0x00007fca9f4574b7 in ppoll () from /lib64/libc.so.6
#1  0x0000000000944970 in qemu_poll_ns (fds=3D0x293e6e0, nfds=3D1, timeout=
=3D-1) at util/qemu-timer.c:322
#2  0x0000000000947e16 in aio_poll (ctx=3D0x291d4b0, blocking=3Dtrue) at ut=
il/aio-posix.c:622
#3  0x00000000008b6094 in nbd_teardown_connection (bs=3D0x29ccdc0) at block=
/nbd-client.c:59
#4  0x00000000008b6df1 in nbd_client_close (bs=3D0x29ccdc0) at block/nbd-cl=
ient.c:377
#5  0x00000000008b5988 in nbd_close (bs=3D0x29ccdc0) at block/nbd.c:488
#6  0x00000000008435de in bdrv_close (bs=3D0x29ccdc0) at block.c:2919
#7  0x0000000000843c86 in bdrv_delete (bs=3D0x29ccdc0) at block.c:3100
#8  0x000000000084620b in bdrv_unref (bs=3D0x29ccdc0) at block.c:4087
#9  0x00000000008411d1 in bdrv_root_unref_child (child=3D0x30e4800) at bloc=
k.c:1891
#10 0x000000000084128a in bdrv_unref_child (parent=3D0x29c0660, child=3D0x3=
0e4800) at block.c:1915
#11 0x000000000084362a in bdrv_close (bs=3D0x29c0660) at block.c:2925
#12 0x0000000000843c86 in bdrv_delete (bs=3D0x29c0660) at block.c:3100
#13 0x000000000084620b in bdrv_unref (bs=3D0x29c0660) at block.c:4087
#14 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x3013910) at bloc=
k.c:1891
#15 0x0000000000848149 in block_job_remove_all_bdrv (job=3D0x3fa7800) at bl=
ockjob.c:154
#16 0x00000000008a8dd8 in mirror_exit (job=3D0x3fa7800, opaque=3D0x7fca9000=
0bf0) at block/mirror.c:576
#17 0x0000000000849e22 in block_job_defer_to_main_loop_bh (opaque=3D0x7fca9=
0000d90) at blockjob.c:794
#18 0x00000000009420c4 in aio_bh_call (bh=3D0x7fca90000dc0) at util/async.c=
:90
#19 0x000000000094216f in aio_bh_poll (ctx=3D0x291d4b0) at util/async.c:118
#20 0x00000000009480d9 in aio_poll (ctx=3D0x291d4b0, blocking=3Dtrue) at ut=
il/aio-posix.c:682
#21 0x00000000008b6094 in nbd_teardown_connection (bs=3D0x2921350) at block=
/nbd-client.c:59
#22 0x00000000008b6df1 in nbd_client_close (bs=3D0x2921350) at block/nbd-cl=
ient.c:377
#23 0x00000000008b5988 in nbd_close (bs=3D0x2921350) at block/nbd.c:488
#24 0x00000000008435de in bdrv_close (bs=3D0x2921350) at block.c:2919
#25 0x0000000000843c86 in bdrv_delete (bs=3D0x2921350) at block.c:3100
#26 0x000000000084620b in bdrv_unref (bs=3D0x2921350) at block.c:4087
#27 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x390d180) at bloc=
k.c:1891
#28 0x000000000084128a in bdrv_unref_child (parent=3D0x4eba200, child=3D0x3=
90d180) at block.c:1915
#29 0x000000000084362a in bdrv_close (bs=3D0x4eba200) at block.c:2925
#30 0x0000000000843c86 in bdrv_delete (bs=3D0x4eba200) at block.c:3100
#31 0x000000000084620b in bdrv_unref (bs=3D0x4eba200) at block.c:4087
#32 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x4ebf990) at bloc=
k.c:1891
#33 0x0000000000848149 in block_job_remove_all_bdrv (job=3D0x4ea85b0) at bl=
ockjob.c:154
#34 0x00000000008a8dd8 in mirror_exit (job=3D0x4ea85b0, opaque=3D0x7fca9800=
0bf0) at block/mirror.c:576
#35 0x0000000000849e22 in block_job_defer_to_main_loop_bh (opaque=3D0x7fca9=
80013d0) at blockjob.c:794
#36 0x00000000009420c4 in aio_bh_call (bh=3D0x7fca9801e0c0) at util/async.c=
:90
#37 0x000000000094216f in aio_bh_poll (ctx=3D0x291d4b0) at util/async.c:118
---Type <return> to continue, or q <return> to quit---  =

#38 0x00000000009476ae in aio_dispatch (ctx=3D0x291d4b0) at util/aio-posix.=
c:429
#39 0x00000000009425e4 in aio_ctx_dispatch (source=3D0x291d4b0, callback=3D=
0, user_data=3D0x0) at util/async.c:261
#40 0x00007fcaa0101f0e in g_main_context_dispatch () from /lib64/libglib-2.=
0.so.0
#41 0x0000000000945d86 in glib_pollfds_poll () at util/main-loop.c:213
#42 0x0000000000945ea7 in os_host_main_loop_wait (timeout=3D124777230) at u=
til/main-loop.c:261
#43 0x0000000000945f72 in main_loop_wait (nonblocking=3D0) at util/main-loo=
p.c:517
#44 0x00000000005c7794 in main_loop () at vl.c:1898
#45 0x00000000005cec57 in main (argc=3D64, argv=3D0x7fffe7020c58, envp=3D0x=
7fffe7020e60) at vl.c:4709

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1687569

Title:
  when migration cancel, qemu main thread hung

Status in QEMU:
  New

Bug description:
  qemu version:v2.9.0-rc5 release

  1.virsh migrate --live 165cf436-312f-47e7-90f2-f8aa63f34893 --copy-storag=
e-all qemu+ssh://10.59.163.38/system
  2.press Ctrl+C cancel migrate

   qemu main thread hung

  (gdb) bt
  #0  0x00007fca9f4574b7 in ppoll () from /lib64/libc.so.6
  #1  0x0000000000944970 in qemu_poll_ns (fds=3D0x293e6e0, nfds=3D1, timeou=
t=3D-1) at util/qemu-timer.c:322
  #2  0x0000000000947e16 in aio_poll (ctx=3D0x291d4b0, blocking=3Dtrue) at =
util/aio-posix.c:622
  #3  0x00000000008b6094 in nbd_teardown_connection (bs=3D0x29ccdc0) at blo=
ck/nbd-client.c:59
  #4  0x00000000008b6df1 in nbd_client_close (bs=3D0x29ccdc0) at block/nbd-=
client.c:377
  #5  0x00000000008b5988 in nbd_close (bs=3D0x29ccdc0) at block/nbd.c:488
  #6  0x00000000008435de in bdrv_close (bs=3D0x29ccdc0) at block.c:2919
  #7  0x0000000000843c86 in bdrv_delete (bs=3D0x29ccdc0) at block.c:3100
  #8  0x000000000084620b in bdrv_unref (bs=3D0x29ccdc0) at block.c:4087
  #9  0x00000000008411d1 in bdrv_root_unref_child (child=3D0x30e4800) at bl=
ock.c:1891
  #10 0x000000000084128a in bdrv_unref_child (parent=3D0x29c0660, child=3D0=
x30e4800) at block.c:1915
  #11 0x000000000084362a in bdrv_close (bs=3D0x29c0660) at block.c:2925
  #12 0x0000000000843c86 in bdrv_delete (bs=3D0x29c0660) at block.c:3100
  #13 0x000000000084620b in bdrv_unref (bs=3D0x29c0660) at block.c:4087
  #14 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x3013910) at bl=
ock.c:1891
  #15 0x0000000000848149 in block_job_remove_all_bdrv (job=3D0x3fa7800) at =
blockjob.c:154
  #16 0x00000000008a8dd8 in mirror_exit (job=3D0x3fa7800, opaque=3D0x7fca90=
000bf0) at block/mirror.c:576
  #17 0x0000000000849e22 in block_job_defer_to_main_loop_bh (opaque=3D0x7fc=
a90000d90) at blockjob.c:794
  #18 0x00000000009420c4 in aio_bh_call (bh=3D0x7fca90000dc0) at util/async=
.c:90
  #19 0x000000000094216f in aio_bh_poll (ctx=3D0x291d4b0) at util/async.c:1=
18
  #20 0x00000000009480d9 in aio_poll (ctx=3D0x291d4b0, blocking=3Dtrue) at =
util/aio-posix.c:682
  #21 0x00000000008b6094 in nbd_teardown_connection (bs=3D0x2921350) at blo=
ck/nbd-client.c:59
  #22 0x00000000008b6df1 in nbd_client_close (bs=3D0x2921350) at block/nbd-=
client.c:377
  #23 0x00000000008b5988 in nbd_close (bs=3D0x2921350) at block/nbd.c:488
  #24 0x00000000008435de in bdrv_close (bs=3D0x2921350) at block.c:2919
  #25 0x0000000000843c86 in bdrv_delete (bs=3D0x2921350) at block.c:3100
  #26 0x000000000084620b in bdrv_unref (bs=3D0x2921350) at block.c:4087
  #27 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x390d180) at bl=
ock.c:1891
  #28 0x000000000084128a in bdrv_unref_child (parent=3D0x4eba200, child=3D0=
x390d180) at block.c:1915
  #29 0x000000000084362a in bdrv_close (bs=3D0x4eba200) at block.c:2925
  #30 0x0000000000843c86 in bdrv_delete (bs=3D0x4eba200) at block.c:3100
  #31 0x000000000084620b in bdrv_unref (bs=3D0x4eba200) at block.c:4087
  #32 0x00000000008411d1 in bdrv_root_unref_child (child=3D0x4ebf990) at bl=
ock.c:1891
  #33 0x0000000000848149 in block_job_remove_all_bdrv (job=3D0x4ea85b0) at =
blockjob.c:154
  #34 0x00000000008a8dd8 in mirror_exit (job=3D0x4ea85b0, opaque=3D0x7fca98=
000bf0) at block/mirror.c:576
  #35 0x0000000000849e22 in block_job_defer_to_main_loop_bh (opaque=3D0x7fc=
a980013d0) at blockjob.c:794
  #36 0x00000000009420c4 in aio_bh_call (bh=3D0x7fca9801e0c0) at util/async=
.c:90
  #37 0x000000000094216f in aio_bh_poll (ctx=3D0x291d4b0) at util/async.c:1=
18
  ---Type <return> to continue, or q <return> to quit---  =

  #38 0x00000000009476ae in aio_dispatch (ctx=3D0x291d4b0) at util/aio-posi=
x.c:429
  #39 0x00000000009425e4 in aio_ctx_dispatch (source=3D0x291d4b0, callback=
=3D0, user_data=3D0x0) at util/async.c:261
  #40 0x00007fcaa0101f0e in g_main_context_dispatch () from /lib64/libglib-=
2.0.so.0
  #41 0x0000000000945d86 in glib_pollfds_poll () at util/main-loop.c:213
  #42 0x0000000000945ea7 in os_host_main_loop_wait (timeout=3D124777230) at=
 util/main-loop.c:261
  #43 0x0000000000945f72 in main_loop_wait (nonblocking=3D0) at util/main-l=
oop.c:517
  #44 0x00000000005c7794 in main_loop () at vl.c:1898
  #45 0x00000000005cec57 in main (argc=3D64, argv=3D0x7fffe7020c58, envp=3D=
0x7fffe7020e60) at vl.c:4709

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1687569/+subscriptions
