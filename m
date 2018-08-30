Received: from eggs.gnu.org ([2001:4830:134:3::10]:58467)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvWrx-0005vJ-18
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fvWrt-0005dP-Qc
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:00:56 -0400
Received: from indium.canonical.com ([91.189.90.7]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fvWrt-0005cK-JQ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 20:00:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fvWrs-0003ZA-0P
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 00:00:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id F09EF2E80C7
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 00:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Aug 2018 23:51:53 -0000
From: "A. Wilcox" <1790018@bugs.launchpad.net>
Reply-To: Bug 1790018 <1790018@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <153567311328.6370.4245402841629873278.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1790018] [NEW] Assertion failure (or segmentation
 fault) running 32-bit x86 Linux guest on 64-bit PowerPC host
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

Qemu 2.12.1 (also tried 2.12.0)
Linux gwyn 4.14.48-mc8-easy #1 SMP Sat Jun 30 23:29:01 CDT 2018 ppc64 GNU/L=
inux
gcc (Adelie 6.4.0-r9) 6.4.0
GNU assembler (GNU Binutils) 2.30
musl libc (powerpc64) Version 1.1.19

64-bit, 64-thread (16-core) POWER9 server in Big endian mode:
processor       : 0
cpu             : POWER9, altivec supported
clock           : 3000.000000MHz
revision        : 2.2 (pvr 004e 1202)

Scenario:

Attempting to install Ad=C3=A9lie Linux 32-bit x86 guest on 64-bit PowerPC
host using qemu-system-i386.


Command line:

/usr/bin/qemu-system-i386 -cdrom adelie-live-pmmx-1.0-beta1-20180807.iso
-hda /dev/gwyn/x86 -m 512 -cpu pentium3


Environment reproduction:

CD image can be obtained at https://distfiles.adelielinux.org/adelie/1.0-be=
ta1/iso/adelie-live-pmmx-1.0-beta1-20180807.iso
/dev/gwyn/x86 is an LVM2 logical volume, 4 GB in size, on NVMe storage
Qemu was built from sources on this machine, with some distribution patches=
 applied for musl support (does not affect tcg/ppc/* code); patches and bui=
ld recipe (which was modified: https://bpaste.net/show/1bbb1d07d7f2 for rec=
ipe patch) can be found at: https://code.foxkit.us/adelie/packages/blob/mas=
ter/user/qemu/APKBUILD


Without --enable-debug-tcg:

Thread 5 "qemu-system-i38" received signal SIGSEGV, Segmentation fault.
[Switching to LWP 14090]
0x39fb04787f63db78 in ?? ()
(gdb)
(gdb) bt
#0  0x39fb04787f63db78 in  ()
#1  0x00003ffff1cdb160 in code_gen_buffer ()
#2  0x0000000100362048 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D<optimi=
zed out>) at /usr/src/packages/user/qemu/src/qemu-2.12.1/accel/tcg/cpu-exec=
.c:169
#3  0x0000000100362048 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>, =
last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D<optimized out>)=
 at /usr/src/packages/user/qemu/src/qemu-2.12.1/accel/tcg/cpu-exec.c:626
#4  0x0000000100362048 in cpu_exec (cpu=3D<optimized out>) at /usr/src/pack=
ages/user/qemu/src/qemu-2.12.1/accel/tcg/cpu-exec.c:734
#5  0x00000001003211b4 in tcg_cpu_exec (cpu=3D<optimized out>) at /usr/src/=
packages/user/qemu/src/qemu-2.12.1/cpus.c:1362
#6  0x00000001003211b4 in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out>)=
 at /usr/src/packages/user/qemu/src/qemu-2.12.1/cpus.c:1461
#7  0x00003ffff7fa275c in start (p=3D0x3fffedb6a810) at src/thread/pthread_=
create.c:147
#8  0x00003ffff7fae4c8 in __clone () at src/thread/powerpc64/clone.s:43


With --enable-debug-tcg:

Assertion failed: disp =3D=3D (int16_t) disp (/usr/src/packages/user/qemu/s=
rc/qemu-2.12.1/tcg/ppc/tcg-target.inc.c: reloc_pc14_val: 204)
zsh: abort      qemu-system-i386

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1790018

Title:
  Assertion failure (or segmentation fault) running 32-bit x86 Linux
  guest on 64-bit PowerPC host

Status in QEMU:
  New

Bug description:
  Qemu 2.12.1 (also tried 2.12.0)
  Linux gwyn 4.14.48-mc8-easy #1 SMP Sat Jun 30 23:29:01 CDT 2018 ppc64 GNU=
/Linux
  gcc (Adelie 6.4.0-r9) 6.4.0
  GNU assembler (GNU Binutils) 2.30
  musl libc (powerpc64) Version 1.1.19

  64-bit, 64-thread (16-core) POWER9 server in Big endian mode:
  processor       : 0
  cpu             : POWER9, altivec supported
  clock           : 3000.000000MHz
  revision        : 2.2 (pvr 004e 1202)

  Scenario:

  Attempting to install Ad=C3=A9lie Linux 32-bit x86 guest on 64-bit PowerPC
  host using qemu-system-i386.

  =

  Command line:

  /usr/bin/qemu-system-i386 -cdrom adelie-live-
  pmmx-1.0-beta1-20180807.iso -hda /dev/gwyn/x86 -m 512 -cpu pentium3

  =

  Environment reproduction:

  CD image can be obtained at https://distfiles.adelielinux.org/adelie/1.0-=
beta1/iso/adelie-live-pmmx-1.0-beta1-20180807.iso
  /dev/gwyn/x86 is an LVM2 logical volume, 4 GB in size, on NVMe storage
  Qemu was built from sources on this machine, with some distribution patch=
es applied for musl support (does not affect tcg/ppc/* code); patches and b=
uild recipe (which was modified: https://bpaste.net/show/1bbb1d07d7f2 for r=
ecipe patch) can be found at: https://code.foxkit.us/adelie/packages/blob/m=
aster/user/qemu/APKBUILD

  =

  Without --enable-debug-tcg:

  Thread 5 "qemu-system-i38" received signal SIGSEGV, Segmentation fault.
  [Switching to LWP 14090]
  0x39fb04787f63db78 in ?? ()
  (gdb)
  (gdb) bt
  #0  0x39fb04787f63db78 in  ()
  #1  0x00003ffff1cdb160 in code_gen_buffer ()
  #2  0x0000000100362048 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D<opti=
mized out>) at /usr/src/packages/user/qemu/src/qemu-2.12.1/accel/tcg/cpu-ex=
ec.c:169
  #3  0x0000000100362048 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>=
, last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D<optimized out=
>) at /usr/src/packages/user/qemu/src/qemu-2.12.1/accel/tcg/cpu-exec.c:626
  #4  0x0000000100362048 in cpu_exec (cpu=3D<optimized out>) at /usr/src/pa=
ckages/user/qemu/src/qemu-2.12.1/accel/tcg/cpu-exec.c:734
  #5  0x00000001003211b4 in tcg_cpu_exec (cpu=3D<optimized out>) at /usr/sr=
c/packages/user/qemu/src/qemu-2.12.1/cpus.c:1362
  #6  0x00000001003211b4 in qemu_tcg_rr_cpu_thread_fn (arg=3D<optimized out=
>) at /usr/src/packages/user/qemu/src/qemu-2.12.1/cpus.c:1461
  #7  0x00003ffff7fa275c in start (p=3D0x3fffedb6a810) at src/thread/pthrea=
d_create.c:147
  #8  0x00003ffff7fae4c8 in __clone () at src/thread/powerpc64/clone.s:43


  With --enable-debug-tcg:

  Assertion failed: disp =3D=3D (int16_t) disp (/usr/src/packages/user/qemu=
/src/qemu-2.12.1/tcg/ppc/tcg-target.inc.c: reloc_pc14_val: 204)
  zsh: abort      qemu-system-i386

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1790018/+subscriptions
