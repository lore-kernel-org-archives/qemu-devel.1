Received: from eggs.gnu.org ([2001:4830:134:3::10]:32936)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fS4xJ-00079U-7X
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 14:20:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fS4xE-00009p-41
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 14:20:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:50166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fS4xD-00009A-Qo
	for qemu-devel@nongnu.org; Sun, 10 Jun 2018 14:20:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fS4xC-0003ko-Mf
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 18:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id A7D0F2E8031
	for <qemu-devel@nongnu.org>; Sun, 10 Jun 2018 18:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 10 Jun 2018 18:09:34 -0000
From: Cameron Kaiser <1776096@bugs.launchpad.net>
Reply-To: Bug 1776096 <1776096@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152865417474.22286.1843162139663853612.malonedeb@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1776096] [NEW] qemu 2.12.0 qemu-system-ppc
 illegal instruction on ppc64le, crashes emulator
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

% uname -a
Linux tim.floodgap.com 4.16.14-300.fc28.ppc64le #1 SMP Tue Jun 5 15:59:48 U=
TC 2018 ppc64le ppc64le ppc64le GNU/Linux

STR:
Start QEMU and boot Mac OS X 10.4.11.
Download the current version of TenFourFox (I used G3 so that AltiVec was n=
ot a confounder).
Try to start TenFourFox in safe mode (hold down Option as you double-click =
while the icon bounces in the Dock).

Expected:
TenFourFox starts.

Actual:
The entire emulator exits with an illegal instruction error.

Trace of session (including some disassembly so you can see where TCG
went wrong):

tim:/home/spectre/src/qemu-2.12.0/ppc-softmmu/% gdb --args ./qemu-
system-ppc -M mac99,accel=3Dtcg -m 2048 -prom-env boot-args=3D-v -boot c
-drive file=3Dtigerhd.img,format=3Draw,cache=3Dnone -netdev user,id=3Dmynet0
-device usb-net,netdev=3Dmynet0 -usb -device usb-tablet

GNU gdb (GDB) Fedora 8.1-15.fc28
[...]
Reading symbols from ./qemu-system-ppc...done.
(gdb) run
[...]

Thread 6 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
[Switching to Thread 0x7ffff242ea30 (LWP 7017)]
0xfffffffffffffffc in ?? ()
#0  0xfffffffffffffffc in  ()
#1  0x00007fffd4edec00 in code_gen_buffer ()
#2  0x00000000100c9e20 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D<optimi=
zed out>) at /home/spectre/src/qemu-2.12.0/accel/tcg/cpu-exec.c:169
#3  0x00000000100c9e20 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>, =
last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D<optimized out>)
    at /home/spectre/src/qemu-2.12.0/accel/tcg/cpu-exec.c:626
#4  0x00000000100c9e20 in cpu_exec (cpu=3D<optimized out>)
    at /home/spectre/src/qemu-2.12.0/accel/tcg/cpu-exec.c:734
#5  0x000000001007decc in tcg_cpu_exec (cpu=3D0x11774e10)
    at /home/spectre/src/qemu-2.12.0/cpus.c:1362
(gdb) disas 0x00007fffd4edebf0, 0x00007fffd4edec10
Dump of assembler code from 0x7fffd4edebf0 to 0x7fffd4edec10:
   0x00007fffd4edebf0 <code_gen_buffer+284027700>:	addi    r0,r4,3
   0x00007fffd4edebf4 <code_gen_buffer+284027704>:	rlwinm  r0,r0,0,0,19
   0x00007fffd4edebf8 <code_gen_buffer+284027708>:	cmplw   cr7,r0,r12
   0x00007fffd4edebfc <code_gen_buffer+284027712>:	bnel    cr7,0x7fffd4ed8b=
64 <code_gen_buffer+284002984>
   0x00007fffd4edec00 <code_gen_buffer+284027716>:	lwbrx   r14,r3,r4
   0x00007fffd4edec04 <code_gen_buffer+284027720>:	stw     r14,40(r27)
   0x00007fffd4edec08 <code_gen_buffer+284027724>:	clrldi  r4,r14,32
   0x00007fffd4edec0c <code_gen_buffer+284027728>:	rlwinm  r3,r4,25,19,26
End of assembler dump.
(gdb) disas 0x7fffd4ed8b60, 0x7fffd4ed8b70
Dump of assembler code from 0x7fffd4ed8b60 to 0x7fffd4ed8b70:
   0x00007fffd4ed8b60 <code_gen_buffer+284002980>:	bctrl
   0x00007fffd4ed8b64 <code_gen_buffer+284002984>:	mtctr   r3
   0x00007fffd4ed8b68 <code_gen_buffer+284002988>:	mr      r31,r3
   0x00007fffd4ed8b6c <code_gen_buffer+284002992>:	li      r3,0
End of assembler dump.
(gdb) i reg ctr
ctr            0xffffffffffffffff	18446744073709551615

It appears that the branch at 0x00007fffd4edebfc caused a jump back (a
return?) through CTR, but CTR has -1 in it, hence setting PC to
0xfffffffffffffffc. I am not sure how to debug this further.

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1776096

Title:
  qemu 2.12.0 qemu-system-ppc illegal instruction on ppc64le, crashes
  emulator

Status in QEMU:
  New

Bug description:
  % uname -a
  Linux tim.floodgap.com 4.16.14-300.fc28.ppc64le #1 SMP Tue Jun 5 15:59:48=
 UTC 2018 ppc64le ppc64le ppc64le GNU/Linux

  STR:
  Start QEMU and boot Mac OS X 10.4.11.
  Download the current version of TenFourFox (I used G3 so that AltiVec was=
 not a confounder).
  Try to start TenFourFox in safe mode (hold down Option as you double-clic=
k while the icon bounces in the Dock).

  Expected:
  TenFourFox starts.

  Actual:
  The entire emulator exits with an illegal instruction error.

  Trace of session (including some disassembly so you can see where TCG
  went wrong):

  tim:/home/spectre/src/qemu-2.12.0/ppc-softmmu/% gdb --args ./qemu-
  system-ppc -M mac99,accel=3Dtcg -m 2048 -prom-env boot-args=3D-v -boot c
  -drive file=3Dtigerhd.img,format=3Draw,cache=3Dnone -netdev user,id=3Dmyn=
et0
  -device usb-net,netdev=3Dmynet0 -usb -device usb-tablet

  GNU gdb (GDB) Fedora 8.1-15.fc28
  [...]
  Reading symbols from ./qemu-system-ppc...done.
  (gdb) run
  [...]

  Thread 6 "qemu-system-ppc" received signal SIGSEGV, Segmentation fault.
  [Switching to Thread 0x7ffff242ea30 (LWP 7017)]
  0xfffffffffffffffc in ?? ()
  #0  0xfffffffffffffffc in  ()
  #1  0x00007fffd4edec00 in code_gen_buffer ()
  #2  0x00000000100c9e20 in cpu_tb_exec (itb=3D<optimized out>, cpu=3D<opti=
mized out>) at /home/spectre/src/qemu-2.12.0/accel/tcg/cpu-exec.c:169
  #3  0x00000000100c9e20 in cpu_loop_exec_tb (tb_exit=3D<synthetic pointer>=
, last_tb=3D<synthetic pointer>, tb=3D<optimized out>, cpu=3D<optimized out=
>)
      at /home/spectre/src/qemu-2.12.0/accel/tcg/cpu-exec.c:626
  #4  0x00000000100c9e20 in cpu_exec (cpu=3D<optimized out>)
      at /home/spectre/src/qemu-2.12.0/accel/tcg/cpu-exec.c:734
  #5  0x000000001007decc in tcg_cpu_exec (cpu=3D0x11774e10)
      at /home/spectre/src/qemu-2.12.0/cpus.c:1362
  (gdb) disas 0x00007fffd4edebf0, 0x00007fffd4edec10
  Dump of assembler code from 0x7fffd4edebf0 to 0x7fffd4edec10:
     0x00007fffd4edebf0 <code_gen_buffer+284027700>:	addi    r0,r4,3
     0x00007fffd4edebf4 <code_gen_buffer+284027704>:	rlwinm  r0,r0,0,0,19
     0x00007fffd4edebf8 <code_gen_buffer+284027708>:	cmplw   cr7,r0,r12
     0x00007fffd4edebfc <code_gen_buffer+284027712>:	bnel    cr7,0x7fffd4ed=
8b64 <code_gen_buffer+284002984>
     0x00007fffd4edec00 <code_gen_buffer+284027716>:	lwbrx   r14,r3,r4
     0x00007fffd4edec04 <code_gen_buffer+284027720>:	stw     r14,40(r27)
     0x00007fffd4edec08 <code_gen_buffer+284027724>:	clrldi  r4,r14,32
     0x00007fffd4edec0c <code_gen_buffer+284027728>:	rlwinm  r3,r4,25,19,26
  End of assembler dump.
  (gdb) disas 0x7fffd4ed8b60, 0x7fffd4ed8b70
  Dump of assembler code from 0x7fffd4ed8b60 to 0x7fffd4ed8b70:
     0x00007fffd4ed8b60 <code_gen_buffer+284002980>:	bctrl
     0x00007fffd4ed8b64 <code_gen_buffer+284002984>:	mtctr   r3
     0x00007fffd4ed8b68 <code_gen_buffer+284002988>:	mr      r31,r3
     0x00007fffd4ed8b6c <code_gen_buffer+284002992>:	li      r3,0
  End of assembler dump.
  (gdb) i reg ctr
  ctr            0xffffffffffffffff	18446744073709551615

  It appears that the branch at 0x00007fffd4edebfc caused a jump back (a
  return?) through CTR, but CTR has -1 in it, hence setting PC to
  0xfffffffffffffffc. I am not sure how to debug this further.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1776096/+subscriptions
