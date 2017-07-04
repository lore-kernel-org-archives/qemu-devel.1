Received: from eggs.gnu.org ([2001:4830:134:3::10]:37931)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dST8V-0002Am-WA
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:05:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dST8R-0000CM-1A
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:05:23 -0400
Received: from indium.canonical.com ([91.189.90.7]:57049)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dST8Q-0000C4-S8
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 15:05:18 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dST8O-0007RA-WC
	for <qemu-devel@nongnu.org>; Tue, 04 Jul 2017 19:05:17 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id ECD7A2E8195
	for <qemu-devel@nongnu.org>; Tue,  4 Jul 2017 19:05:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Jul 2017 18:54:34 -0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Reply-To: Bug 1545052 <1545052@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160212155533.799.47364.malonedeb@gac.canonical.com>
Message-Id: <149919447432.6647.17217422969355748450.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1545052] Re: RDMA migration will hang forever if
 target QEMU fails to load vmstate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Fix series posted upstream:
0001-migration-rdma-Fix-race-on-source.patch
0002-migration-Close-file-on-failed-migration-load.patch
0003-migration-rdma-Allow-cancelling-while-waiting-for-wr.patch
0004-migration-rdma-Safely-convert-control-types.patch
0005-migration-rdma-Send-error-during-cancelling.patch


** Changed in: qemu
       Status: Confirmed =3D> In Progress

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1545052

Title:
  RDMA migration will hang forever if target QEMU fails to load vmstate

Status in QEMU:
  In Progress

Bug description:
  Get a pair of machines with infiniband support. On one host run

  $ qemu-system-x86_64 -monitor stdio -incoming rdma:ibme:4444 -vnc :1
  -m 1000

  To start an incoming migration.

  =

  Now on the other host, run QEMU with an intentionally different configura=
tion (ie different RAM size)

  $ qemu-system-x86_64 -monitor stdio -vnc :1 -m 2000

  Now trigger a migration on this source host

  (qemu) migrate rdma:ibpair:4444

  =

  You will see on the target host, that it failed to load migration:

  dest_init RDMA Device opened: kernel name mlx4_0 uverbs device name uverb=
s0, infiniband_verbs class device path /sys/class/infiniband_verbs/uverbs0,=
 infiniband class device path /sys/class/infiniband/mlx4_0, transport: (2) =
Ethernet
  qemu-system-x86_64: Length mismatch: pc.ram: 0x7d000000 in !=3D 0x3e80000=
0: Invalid argument
  qemu-system-x86_64: error while loading state for instance 0x0 of device =
'ram'

  This is to be expected, however, at this point QEMU has hung and no
  longer responds to the monitor

  GDB shows the target host is stuck in this callpath

  #0  0x00007ffff39141cd in write () at ../sysdeps/unix/syscall-template.S:=
81
  #1  0x00007ffff27fe795 in rdma_get_cm_event.part.15 () from /lib64/librdm=
acm.so.1
  #2  0x000055555593e445 in qemu_rdma_cleanup (rdma=3D0x7fff9647e010) at mi=
gration/rdma.c:2210
  #3  0x000055555593ea45 in qemu_rdma_close (opaque=3D0x555557796770) at mi=
gration/rdma.c:2652
  #4  0x00005555559397cc in qemu_fclose (f=3Df@entry=3D0x5555564b1450) at m=
igration/qemu-file.c:270
  #5  0x0000555555936b88 in process_incoming_migration_co (opaque=3D0x55555=
64b1450) at migration/migration.c:361
  #6  0x0000555555a25a1a in coroutine_trampoline (i0=3D<optimized out>, i1=
=3D<optimized out>) at util/coroutine-ucontext.c:79
  #7  0x00007fffef5b3110 in ?? () from /lib64/libc.so.6


  Now, back on the source host again, you would expect to see that the
  migrate command failed. Instead, this QEMU is hung too.

  GDB shows the source host, migrate thread, is stuck in this callpath:

  #0  0x00007ffff391522d in read#1  0x00007ffff00efd93 in ibv_get_cq_event =
() at /lib64/libibverbs.so.1
  #2  0x00005555559403f2 in qemu_rdma_block_for_wrid (rdma=3Drdma@entry=3D0=
x7fff3d07e010, wrid_requested=3Dwrid_requested@entry=3D4000, byte_len=3Dbyt=
e_len@entry=3D0x7fff39de370c) at migration/rdma.c:1511
  #3  0x000055555594058a in qemu_rdma_exchange_get_response (rdma=3D0x7fff3=
d07e010, head=3Dhead@entry=3D0x7fff39de3780, expecting=3Dexpecting@entry=3D=
2, idx=3Didx@entry=3D0)
      at migration/rdma.c:1648
  #4  0x0000555555941e71 in qemu_rdma_exchange_send (rdma=3D0x7fff3d07e010,=
 head=3D0x7fff39de3840, data=3D0x0, resp=3D0x7fff39de3870, resp_idx=3D0x7ff=
f39de3880, callback=3D0x0) at migration/rdma.c:1725
  #5  0x00005555559447e4 in qemu_rdma_registration_stop (f=3D<optimized out=
>, opaque=3D<optimized out>, flags=3D0, data=3D<optimized out>) at migratio=
n/rdma.c:3302
  #6  0x000055555593bc4b in ram_control_after_iterate (f=3Df@entry=3D0x5555=
564c20f0, flags=3Dflags@entry=3D0) at migration/qemu-file.c:157
  #7  0x0000555555740b59 in ram_save_setup (f=3D0x5555564c20f0, opaque=3D<o=
ptimized out>) at /home/berrange/src/virt/qemu/migration/ram.c:1959
  #8  0x00005555557451c1 in qemu_savevm_state_begin (f=3D0x5555564c20f0, pa=
rams=3Dparams@entry=3D0x555555f6f048 <current_migration.37991+72>)
      at /home/berrange/src/virt/qemu/migration/savevm.c:919
  #9  0x00005555559381a5 in migration_thread (opaque=3D0x555555f6f000 <curr=
ent_migration.37991>) at migration/migration.c:1633
  #10 0x00007ffff390edc5 in start_thread (arg=3D0x7fff39de4700) at pthread_=
create.c:308

  =

  It should have aborted migrate and set the status to failed.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1545052/+subscriptions
