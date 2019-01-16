Received: from eggs.gnu.org ([209.51.188.92]:54249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjhbq-000725-3u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:35:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjhbo-0002EY-LC
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:35:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:52246)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjhbo-00026D-DD
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 04:35:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjhbn-00037I-1Y
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 09:35:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 071642E8029
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 09:35:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jan 2019 09:20:43 -0000
From: Jakub Jermar <1811244@bugs.launchpad.net>
Reply-To: Bug 1811244 <1811244@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154712887375.19548.13853640095079074628.malonedeb@soybean.canonical.com>
Message-Id: <154763044338.20983.14638452321498014921.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1811244] Re: qemu 3.1/i386 crashes/guest hangs
 when MTTCG is enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As for the other outcome, when the guest hangs (instead of QEMU
crashing), the guest CPUs that block forward progress are halted in an
idle loop, have interrupts enabled and have a queued timer IRQ 248 and a
pending software IPI IRQ 250. It appears another timer IRQ is currently
being serviced (but the CPU is idling).

(qemu) cpu 1
(qemu) info registers
EAX=3Dff8b7000 EBX=3Dff8b7000 ECX=3D00000003 EDX=3D00000003
ESI=3D00000001 EDI=3Dff8b5240 EBP=3Dff8b7000 ESP=3Dff8b7fac
EIP=3Df0029707 EFL=3D00000202 [-------] CPL=3D0 II=3D0 A20=3D1 SMM=3D0 HLT=
=3D1
ES =3D0023 00000000 ffffffff 00cff300 DPL=3D3 DS   [-WA]
CS =3D0008 00000000 ffffffff 00cf9b00 DPL=3D0 CS32 [-RA]
SS =3D0010 00000000 ffffffff 00cf9300 DPL=3D0 DS   [-WA]
DS =3D0023 00000000 ffffffff 00cff300 DPL=3D3 DS   [-WA]
FS =3D0023 00000000 ffffffff 00cff300 DPL=3D3 DS   [-WA]
GS =3D0023 00000000 ffffffff 00cff300 DPL=3D3 DS   [-WA]
LDT=3D0000 00000000 00000000 00008200 DPL=3D0 LDT
TR =3D0068 efbfe280 00003d80 00008900 DPL=3D0 TSS32-avl
GDT=3D     ffbd8400 00000077
IDT=3D     eacfe000 000007ff
CR0=3D8001003b CR2=3D00000000 CR3=3D03fde000 CR4=3D00000690
DR0=3D00000000 DR1=3D00000000 DR2=3D00000000 DR3=3D00000000 =

DR6=3Dffff0ff0 DR7=3D00000400
EFER=3D0000000000000000
FCW=3D037f FSW=3D0000 [ST=3D0] FTW=3D00 MXCSR=3D00001f80
FPR0=3D0000000000000000 0000 FPR1=3D0000000000000000 0000
FPR2=3D0000000000000000 0000 FPR3=3D0000000000000000 0000
FPR4=3D0000000000000000 0000 FPR5=3D0000000000000000 0000
FPR6=3D0000000000000000 0000 FPR7=3D0000000000000000 0000
XMM00=3D00000000000000000000000000000000 XMM01=3D00000000000000000000000000=
000000
XMM02=3D00000000000000000000000000000000 XMM03=3D00000000000000000000000000=
000000
XMM04=3D00000000000000000000000000000000 XMM05=3D00000000000000000000000000=
000000
XMM06=3D00000000000000000000000000000000 XMM07=3D00000000000000000000000000=
000000
(qemu) info lapic
dumping local APIC state for CPU 1 =


LVT0	 0x0001003f active-hi edge  masked                      Fixed  (vec 63)
LVT1	 0x0001003f active-hi edge  masked                      Fixed  (vec 63)
LVTPC	 0x000100ff active-hi edge  masked                      Fixed  (vec 2=
55)
LVTERR	 0x000000fb active-hi edge                              Fixed  (vec =
251)
LVTTHMR	 0x000100ff active-hi edge  masked                      Fixed  (vec=
 255)
LVTT	 0x000200f8 active-hi edge                 periodic     Fixed  (vec 24=
8)
Timer	 DCR=3D0xb (divide by 1) initial_count =3D 997376
SPIV	 0x00000107 APIC enabled, focus=3Doff, spurious vec 7
ICR	 0x00000000 physical edge de-assert no-shorthand
ICR2	 0x00000000 cpu 0 (APIC ID)
ESR	 0x00000000
ISR	 248 =

IRR	 248 250 =


APR 0x00 TPR 0x00 DFR 0x0f LDR 0x00 PPR 0xf0

(gdb) set $eip=3Df0029707
(gdb) set $esp=3Dff8b7fac
(gdb) bt
#0  0xf0029707 in Proc::halt () at /home/jermar/Kernkonzept/software/l4/fia=
sco/src/drivers/ia32/processor-ia32.cpp:47
#1  0xf00193b8 in Kernel_thread::idle_op (this=3Dthis@entry=3D0xffb66da4) a=
t /home/jermar/Kernkonzept/software/l4/fiasco/src/kern/kernel_thread.cpp:134
#2  0xf001bc11 in call_ap_bootstrap (this=3D0xffb66da4, resume=3D0xf001bc11=
) at /home/jermar/Kernkonzept/software/l4/fiasco/src/kern/app_cpu_thread.cp=
p:111
#3  0x00000001 in ?? ()

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1811244

Title:
  qemu 3.1/i386 crashes/guest hangs when MTTCG is enabled

Status in QEMU:
  New

Bug description:
  When MTTCG is enabled, QEMU 3.1.0 sometimes crashes when running the
  following command line:

  qemu-system-i386 -kernel
  /home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen/bootstrap
  -append bootstrap -initrd
  "/home/jermar/work/software/l4/fiasco/.build-i386/fiasco
  -serial_esc,/home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen/=
l4f/sigma0
  ,/home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen/l4f/moe
  rom/ahci.cfg,/home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen=
/l4f/ned
  ,test_env.lua ,/home/jermar/Kernkonzept/software/l4/pkg/ahci-
  driver/examples/md5sum/ahci.cfg
  ,/home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen/l4f/l4re
  ,/home/jermar/Kernkonzept/software/l4/pkg/ahci-
  driver/examples/md5sum/ahci.io
  ,/home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen/l4f/io
  ,/home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen/l4f
  /ahci-drv
  ,/home/jermar/Kernkonzept/software/l4/.build-i386/bin/x86_gen/l4f
  /ahci-md5-sync" -smp 4 -accel tcg,thread=3Dmulti -device ahci,id=3Dahci0
  -drive
  if=3Dnone,file=3D/home/jermar/Kernkonzept/software/l4/.build-i386/pkg
  /ahci-driver/test/examples/test_ahci.img,format=3Draw,id=3Ddrive-sata0-0-0
  -device ide-drive,bus=3Dahci0.0,drive=3Ddrive-sata0-0-0,id=3Dsata0-0-0
  -serial stdio -nographic -monitor none

  The host is x86_64.

  The stack at the time of the crash (core dump and debug binary
  attached to the bug):

  Core was generated by `qemu-system-i386 -kernel /home/jermar/Kernkonzept/=
software/l4/.build-i386/bin/x'.
  Program terminated with signal SIGSEGV, Segmentation fault.
  #0  io_writex (env=3Denv@entry=3D0x565355ca0140, iotlbentry=3Diotlbentry@=
entry=3D0x565355ca9120, mmu_idx=3D2, val=3Dval@entry=3D0, addr=3Daddr@entry=
=3D3938451632, retaddr=3Dretaddr@entry=3D140487132809203, recheck=3Dfalse, =
size=3D4)
  =C2=A0=C2=A0=C2=A0=C2=A0at /home/jermar/software/HelenOS/helenos.git/cont=
rib/qemu/qemu-3.1.0/accel/tcg/cputlb.c:791
  791	    if (mr->global_locking && !qemu_mutex_iothread_locked()) {
  [Current thread is 1 (Thread 0x7fc5af7fe700 (LWP 3625719))]
  Missing separate debuginfos, use: dnf debuginfo-install SDL2-2.0.9-1.fc29=
.x86_64 at-spi2-atk-2.30.0-1.fc29.x86_64 at-spi2-core-2.30.0-2.fc29.x86_64 =
atk-2.30.0-1.fc29.x86_64 bzip2-libs-1.0.6-28.fc29.x86_64 cairo4
  (gdb) bt
  #0  0x0000565354f5f365 in io_writex
  =C2=A0=C2=A0=C2=A0=C2=A0(env=3Denv@entry=3D0x565355ca0140, iotlbentry=3Di=
otlbentry@entry=3D0x565355ca9120, mmu_idx=3D2, val=3Dval@entry=3D0, addr=3D=
addr@entry=3D3938451632, retaddr=3Dretaddr@entry=3D140487132809203, recheck=
=3Dfalse, size=3D4)
  =C2=A0=C2=A0=C2=A0=C2=A0at /home/jermar/software/HelenOS/helenos.git/cont=
rib/qemu/qemu-3.1.0/accel/tcg/cputlb.c:791
  #1  0x0000565354f621b2 in io_writel (recheck=3D<optimized out>, retaddr=
=3D140487132809203, addr=3D3938451632, val=3D0, index=3D0, mmu_idx=3D2, env=
=3D0x565355ca0140)
  =C2=A0=C2=A0=C2=A0=C2=A0at /home/jermar/software/HelenOS/helenos.git/cont=
rib/qemu/qemu-3.1.0/accel/tcg/softmmu_template.h:310
  #2  0x0000565354f621b2 in helper_le_stl_mmu (env=3D0x565355ca0140, addr=
=3D<optimized out>, val=3D0, oi=3D34, retaddr=3D140487132809203)
  =C2=A0=C2=A0=C2=A0=C2=A0at /home/jermar/software/HelenOS/helenos.git/cont=
rib/qemu/qemu-3.1.0/accel/tcg/softmmu_template.h:310
  #3  0x00007fc5b5a587f3 in code_gen_buffer ()
  #4  0x0000565354f75fd0 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D0x7fc=
5b5a5aa40 <code_gen_buffer+12266006>) at /home/jermar/software/HelenOS/hele=
nos.git/contrib/qemu/qemu-3.1.0/accel/tcg/cpu-exec.c:171
  #5  0x0000565354f75fd0 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>=
, last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D0x7fc5b5a5aa40=
 <code_gen_buffer+12266006>)
  =C2=A0=C2=A0=C2=A0=C2=A0at /home/jermar/software/HelenOS/helenos.git/cont=
rib/qemu/qemu-3.1.0/accel/tcg/cpu-exec.c:615
  #6  0x0000565354f75fd0 in cpu_exec (cpu=3Dcpu@entry=3D0x565355c97e90) at =
/home/jermar/software/HelenOS/helenos.git/contrib/qemu/qemu-3.1.0/accel/tcg=
/cpu-exec.c:725
  #7  0x0000565354f33b1f in tcg_cpu_exec (cpu=3D0x565355c97e90) at /home/je=
rmar/software/HelenOS/helenos.git/contrib/qemu/qemu-3.1.0/cpus.c:1429
  #8  0x0000565354f35e83 in qemu_tcg_cpu_thread_fn (arg=3D0x565355c97e90) a=
t /home/jermar/software/HelenOS/helenos.git/contrib/qemu/qemu-3.1.0/cpus.c:=
1733
  #9  0x0000565354f35e83 in qemu_tcg_cpu_thread_fn (arg=3Darg@entry=3D0x565=
355c97e90) at /home/jermar/software/HelenOS/helenos.git/contrib/qemu/qemu-3=
.1.0/cpus.c:1707
  #10 0x00005653552ec5da in qemu_thread_start (args=3D<optimized out>) at u=
til/qemu-thread-posix.c:498
  #11 0x00007fc5b858a58e in start_thread () at /lib64/libpthread.so.0
  #12 0x00007fc5b84b96a3 in clone () at /lib64/libc.so.6

  Another symptom that occurs more often than this crash is that the
  guest hangs while waiting for another CPU to complete a cross-CPU
  call. Disabling MTTCG makes both symptoms go away.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1811244/+subscriptions
