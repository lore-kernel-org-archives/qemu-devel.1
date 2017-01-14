Received: from eggs.gnu.org ([2001:4830:134:3::10]:48071)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSJt0-00026a-C7
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:40:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cSJsx-0004Zm-6d
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:40:30 -0500
Received: from indium.canonical.com ([91.189.90.7]:51313)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cSJsx-0004Zf-18
	for qemu-devel@nongnu.org; Sat, 14 Jan 2017 03:40:27 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cSJsv-0001Lc-Rv
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 08:40:25 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D1C522E80BF
	for <qemu-devel@nongnu.org>; Sat, 14 Jan 2017 08:40:25 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Jan 2017 08:27:39 -0000
From: Thomas Huth <1596160@bugs.launchpad.net>
Reply-To: Bug 1596160 <1596160@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160625080118.2005.23896.malonedeb@wampee.canonical.com>
Message-Id: <20170114082740.13870.76561.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1596160] Re: SIGSEGV in
 memory_region_access_valid on Sabre Lite board
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1596160

Title:
  SIGSEGV in memory_region_access_valid on Sabre Lite board

Status in QEMU:
  Fix Released

Bug description:
  I'm trying to emulate a Sabre Lite board and booting U-Boot, but I'm
  encountering a SIGSEGV almost immediately after starting QEMU.

  QEMU version: 6f1d2d1c5ad20d464705b17318cb7ca495f8078a
  U-Boot version: mx6qsabrelite_defconfig 2016.05 (with http://git.denx.de/=
?p=3Du-boot.git;a=3Dcommitdiff;h=3D1f516faa45611aedc8c2e3f303b3866f615d481e=
 reverted, since it hangs the CPU)

  $ gdb --args ./arm-softmmu/qemu-system-arm -machine sabrelite -kernel ~/u=
-boot-2016.05/u-boot
  GNU gdb (Ubuntu 7.7.1-0ubuntu5~14.04.2) 7.7.1

  ...

  (gdb) r
  Starting program: /home/kota/qemu/build/arm-softmmu/qemu-system-arm -mach=
ine sabrelite -kernel /home/kota/u-boot-2016.05/u-boot
  [Thread debugging using libthread_db enabled]
  Using host libthread_db library "/lib/x86_64-linux-gnu/libthread_db.so.1".
  [New Thread 0x7fffe9074700 (LWP 18025)]
  [New Thread 0x7fffe58c0700 (LWP 18027)]

  Program received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x7fffe58c0700 (LWP 18027)]
  0x00005555557aaaa8 in memory_region_access_valid (mr=3Dmr@entry=3D0x7fffe=
594e0e0, addr=3Daddr@entry=3D0, size=3Dsize@entry=3D4, is_write=3Dis_write@=
entry=3Dtrue) at /home/kota/qemu/memory.c:1143
  1143	    if (!mr->ops->valid.unaligned && (addr & (size - 1))) {
  (gdb) print mr->ops
  $1 =3D (const MemoryRegionOps *) 0x0
  (gdb) print *mr
  $2 =3D {parent_obj =3D {class =3D 0x555556678990, free =3D 0x0, propertie=
s =3D 0x555557002d20, ref =3D 1, parent =3D 0x555556693d10}, romd_mode =3D =
true, ram =3D false, subpage =3D false, readonly =3D false, rom_device =3D =
true, =

    flush_coalesced_mmio =3D false, global_locking =3D true, dirty_log_mask=
 =3D 0 '\000', ram_block =3D 0x5555570228f0, owner =3D 0x0, iommu_ops =3D 0=
x0, ops =3D 0x0, opaque =3D 0x0, container =3D 0x555556693980, size =3D {
      lo =3D 98304, hi =3D 0}, addr =3D 0, destructor =3D 0x5555557a70b0 <m=
emory_region_destructor_rom_device>, align =3D 2097152, terminates =3D true=
, skip_dump =3D false, enabled =3D true, warning_printed =3D false, =

    vga_logging_count =3D 0 '\000', alias =3D 0x0, alias_offset =3D 0, prio=
rity =3D 0, subregions =3D {tqh_first =3D 0x0, tqh_last =3D 0x7fffe594e188}=
, subregions_link =3D {tqe_next =3D 0x7fffe594d988, tqe_prev =3D 0x7fffe594=
e290}, =

    coalesced =3D {tqh_first =3D 0x0, tqh_last =3D 0x7fffe594e1a8}, name =
=3D 0x555557022710 "imx6.rom", ioeventfd_nb =3D 0, ioeventfds =3D 0x0, iomm=
u_notify =3D {notifiers =3D {lh_first =3D 0x0}}}
  (gdb) bt
  #0  0x00005555557aaaa8 in memory_region_access_valid (mr=3Dmr@entry=3D0x7=
fffe594e0e0, addr=3Daddr@entry=3D0, size=3Dsize@entry=3D4, is_write=3Dis_wr=
ite@entry=3Dtrue) at /home/kota/qemu/memory.c:1143
  #1  0x00005555557aacbd in memory_region_dispatch_write (mr=3D0x7fffe594e0=
e0, addr=3D0, data=3D3925868734, size=3D4, attrs=3D...) at /home/kota/qemu/=
memory.c:1249
  #2  0x00007fffe645a4e4 in code_gen_buffer ()
  #3  0x0000555555778d4d in cpu_tb_exec (itb=3D<optimized out>, itb=3D<opti=
mized out>, cpu=3D0x7fffe58c92e0) at /home/kota/qemu/cpu-exec.c:166
  #4  cpu_loop_exec_tb (sc=3D0x7fffe58bfab0, tb_exit=3D<synthetic pointer>,=
 last_tb=3D0x7fffe58bfaa0, tb=3D<optimized out>, cpu=3D0x7fffe58c92e0) at /=
home/kota/qemu/cpu-exec.c:530
  #5  cpu_arm_exec (cpu=3Dcpu@entry=3D0x7fffe58c1080) at /home/kota/qemu/cp=
u-exec.c:626
  #6  0x0000555555798a20 in tcg_cpu_exec (cpu=3D0x7fffe58c1080) at /home/ko=
ta/qemu/cpus.c:1541
  #7  tcg_exec_all () at /home/kota/qemu/cpus.c:1574
  #8  qemu_tcg_cpu_thread_fn (arg=3D<optimized out>) at /home/kota/qemu/cpu=
s.c:1171
  #9  0x00007ffff27f1184 in start_thread (arg=3D0x7fffe58c0700) at pthread_=
create.c:312
  #10 0x00007ffff251e37d in clone () at ../sysdeps/unix/sysv/linux/x86_64/c=
lone.S:111

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1596160/+subscriptions
