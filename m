Received: from eggs.gnu.org ([2001:4830:134:3::10]:50305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfxEj-00041U-Qd
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:51:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dfxEf-0004uL-S2
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:51:33 -0400
Received: from indium.canonical.com ([91.189.90.7]:35916)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dfxEf-0004tk-Lz
	for qemu-devel@nongnu.org; Thu, 10 Aug 2017 19:51:29 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dfxEd-0007an-CS
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 23:51:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 5010A2E80CB
	for <qemu-devel@nongnu.org>; Thu, 10 Aug 2017 23:51:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Aug 2017 23:42:55 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1706296 <1706296@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150097502966.6397.351311629210845503.malonedeb@gac.canonical.com>
Message-Id: <150240857521.18943.1371547756430353016.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1706296] Re: Booting NT 4 disk causes
 /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion failed:
 (!qemu_mutex_iothread_locked())
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Using '-cpu 486' gets past the assertion error. I guess Windows NT 4.0
is not compatible with newer Intel processors.

Currently I can install Windows NT 4.0, but booting from the
installation has its problems. It won't boot unless you use the NTFS
file system. Even with this file system I still see a BSOD that states
INACCESSIBLE_BOOT_DEVICE. Not sure what is wrong. Switching to a SCSI
controller didn't help.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1706296

Title:
  Booting NT 4 disk causes
  /home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion
  failed: (!qemu_mutex_iothread_locked())

Status in QEMU:
  New

Bug description:
  Grab the NT 4 disk from
  https://archive.org/details/Microsoft_Windows_NT_Server_Version_4.0_227-0=
75
  -385_CD-KEY_419-1343253_1996

  Try to boot it as follows:

  qemu-system-x86_64 -hda disk.img -cdrom Microsoft_Windows_NT_Server_Versi=
on_4.0_227-075-385_CD-KEY_419-1343253_1996.iso -m 2048 -boot d -machine pc,=
accel=3Dtcg
  WARNING: Image format was not specified for 'disk.img' and probing guesse=
d raw.
           Automatically detecting the format is dangerous for raw images, =
write operations on block 0 will be restricted.
           Specify the 'raw' format explicitly to remove the restrictions.
  **
  ERROR:/home/rjones/d/qemu/cpus.c:1580:qemu_mutex_lock_iothread: assertion=
 failed: (!qemu_mutex_iothread_locked())
  Aborted (core dumped)

  The stack trace in the failing thread is:

  Thread 4 (Thread 0x7fffb0418700 (LWP 21979)):
  #0  0x00007fffdd89b64b in raise () at /lib64/libc.so.6
  #1  0x00007fffdd89d450 in abort () at /lib64/libc.so.6
  #2  0x00007fffdff8c75d in g_assertion_message () at /lib64/libglib-2.0.so=
.0
  #3  0x00007fffdff8c7ea in g_assertion_message_expr ()
      at /lib64/libglib-2.0.so.0
  #4  0x00005555557a7d00 in qemu_mutex_lock_iothread ()
      at /home/rjones/d/qemu/cpus.c:1580
  #5  0x00005555557cb429 in io_writex (env=3Denv@entry=3D0x555556751400, io=
tlbentry=3D0x55555675b678, =

      iotlbentry@entry=3D0x5aaaaae40c918, val=3Dval@entry=3D8, addr=3Daddr@=
entry=3D2148532220, retaddr=3D0, retaddr@entry=3D93825011136120, size=3Dsiz=
e@entry=3D4)
      at /home/rjones/d/qemu/accel/tcg/cputlb.c:795
  #6  0x00005555557ce0f7 in io_writel (retaddr=3D93825011136120, addr=3D214=
8532220, val=3D8, index=3D255, mmu_idx=3D21845, env=3D0x555556751400)
      at /home/rjones/d/qemu/softmmu_template.h:265
  #7  0x00005555557ce0f7 in helper_le_stl_mmu (env=3Denv@entry=3D0x55555675=
1400, addr=3Daddr@entry=3D2148532220, val=3Dval@entry=3D8, oi=3D<optimized =
out>, retaddr=3D93825011136120, retaddr@entry=3D0) at /home/rjones/d/qemu/s=
oftmmu_template.h:300
  #8  0x000055555587c0a4 in cpu_stl_kernel_ra (env=3D0x555556751400, ptr=3D=
2148532220, v=3D8, retaddr=3D0) at /home/rjones/d/qemu/include/exec/cpu_lds=
t_template.h:182
  #9  0x0000555555882610 in do_interrupt_protected (is_hw=3D<optimized out>=
, next_eip=3D<optimized out>, error_code=3D2, is_int=3D<optimized out>, int=
no=3D<optimized out>, env=3D0x555556751400) at /home/rjones/d/qemu/target/i=
386/seg_helper.c:758
  #10 0x0000555555882610 in do_interrupt_all (cpu=3Dcpu@entry=3D0x555556749=
170, intno=3D<optimized out>, is_int=3D<optimized out>, error_code=3D2, nex=
t_eip=3D<optimized out>, is_hw=3Dis_hw@entry=3D0) at /home/rjones/d/qemu/ta=
rget/i386/seg_helper.c:1252
  #11 0x00005555558839d3 in x86_cpu_do_interrupt (cs=3D0x555556749170)
      at /home/rjones/d/qemu/target/i386/seg_helper.c:1298
  #12 0x00005555557d2ccb in cpu_handle_exception (ret=3D<synthetic pointer>=
, cpu=3D0x5555566a4590) at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:465
  #13 0x00005555557d2ccb in cpu_exec (cpu=3Dcpu@entry=3D0x555556749170)
      at /home/rjones/d/qemu/accel/tcg/cpu-exec.c:670
  #14 0x00005555557a855a in tcg_cpu_exec (cpu=3D0x555556749170)
      at /home/rjones/d/qemu/cpus.c:1270
  #15 0x00005555557a855a in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>)
      at /home/rjones/d/qemu/cpus.c:1365
  #16 0x00007fffddc3d36d in start_thread () at /lib64/libpthread.so.0
  #17 0x00007fffdd975b9f in clone () at /lib64/libc.so.6

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1706296/+subscriptions
