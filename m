Received: from eggs.gnu.org ([2001:4830:134:3::10]:43353)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fXMQg-00051H-Je
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:00:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fXMQb-00005T-Em
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:00:54 -0400
Received: from indium.canonical.com ([91.189.90.7]:33016)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fXMQb-0008W2-3Y
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 04:00:49 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fXMQZ-0006wQ-6Q
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 2EE222E80C7
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 08:00:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 25 Jun 2018 07:53:47 -0000
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Reply-To: Bug 1778473 <1778473@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <152991322806.7059.5607302246363918755.malonedeb@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1778473] [NEW] [Crash] qemu-system-x86_64:
 mov_ss_trap_64 PANIC: double fault, error_code: 0x0
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

Kselftest test case mov_ss_trap_64 is causing kernel panic on
qemu-system-x86_64 and PASS on real x86_64 hardware.

qemu-system-x86_64 version is 2.12.0
host architecture: amd64

Test failed on recent stable rc kernel,
4.17.3-rc1, 4.16.18-rc1 and 4.14.52-rc1.


Test code snippet,
main() {
<>
      printf("[RUN]\tMOV SS; CS CS INT3\n");
      asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m" (=
ss));
<>
}

Kerel crash log,
# cd /opt/kselftests/mainline/x86
# ./mov_ss_trap_64
	SS =3D 0x2b, &SS =3D 0x0x604188
	Set up a watchpoint
	DR0 =3D 604188, DR1 =3D 400a19, DR7 =3D 7000a
[RUN]	Read from watched memory (should get SIGTRAP)
	Got SIGTRAP with RIP=3D4008ea, EFLAGS.RF=3D0
[RUN]	MOV SS; INT3
	Got SIGTRAP with RIP=3D4008fb, EFLAGS.RF=3D0
[RUN]	MOV SS; INT 3
	Got SIGTRAP with RIP=3D40090d, EFLAGS.RF=3D0
[RUN]	M[   20.305426] PANIC: double fault, error_code: 0x0
OV SS; CS CS INT3
	Got SIGTRAP with RIP=3D400920,[   20.308317] CPU: 3 PID: 2471 Comm: mov_ss=
_trap_64 Not tainted 4.17.3-rc1 #1
 EFLAGS.RF=3D0
[RUN]	MOV SS; CSx14 INT3
[   20.311664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   20.314738] RIP: 0010:error_entry+0x32/0x100
[   20.316198] RSP: 0000:fffffe0000086000 EFLAGS: 00010046
[   20.317911] RAX: 0000000092400a87 RBX: 0000000000000000 RCX: 00000000000=
00000
[   20.320168] RDX: 0000000000000000 RSI: ffffffff92400f18 RDI: ffffffff924=
01146
[   20.322405] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[   20.324320] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   20.326073] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   20.327869] FS:  00007f3174aefe80(0000) GS:ffff9f447fd80000(0000) knlGS:=
0000000000000000
[   20.329850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.331343] CR2: fffffe0000085ff8 CR3: 0000000136d2e000 CR4: 00000000000=
006e0
[   20.333150] DR0: 0000000000604188 DR1: 0000000000400a19 DR2: 00000000000=
00000
[   20.334893] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000000000=
7060a
[   20.336649] Call Trace:
[   20.337523]  <ENTRY_TRAMPOLINE>
[   20.338507]  ? native_iret+0x7/0x7
[   20.339611]  ? page_fault+0x8/0x30
[   20.340693]  ? error_entry+0x86/0x100
[   20.341871]  ? trace_hardirqs_off_caller+0x7/0xa0
[   20.343212]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   20.344554]  ? native_iret+0x7/0x7
[   20.345647]  ? page_fault+0x8/0x30
[   20.346716]  ? error_entry+0x86/0x100
[   20.347853]  ? page_fault+0x8/0x30
[   20.348920]  ? ist_enter+0x6/0xa0
[   20.349961]  ? do_int3+0x34/0x120
[   20.351095]  ? int3+0x14/0x20
[   20.352047]  </ENTRY_TRAMPOLINE>
[   20.353060] Code: 48 89 7c 24 08 52 31 d2 51 31 c9 50 41 50 45 31 c0 41 =
51 45 31 c9 41 52 45 31 d2 41 53 45 31 db 53 31 db 55 31 ed 41 54 45 31 e4 =
<41> 55 45 31 ed 41 56 45 31 f6 41 57 45 31 ff 56 48 8d 6c 24 09 =

[   20.357895] Kernel panic - not syncing: Machine halted.
[   20.359385] CPU: 3 PID: 2471 Comm: mov_ss_trap_64 Not tainted 4.17.3-rc1=
 #1
[   20.361271] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS =
1.10.2-1 04/01/2014
[   20.363513] Call Trace:
[   20.364367]  <#DF>
[   20.365109]  dump_stack+0x68/0x95
[   20.366131]  panic+0xe3/0x22a
[   20.367207]  df_debug+0x2d/0x30
[   20.368254]  do_double_fault+0x9f/0x120
[   20.369387]  double_fault+0x23/0x30
[   20.370444] RIP: 0010:error_entry+0x32/0x100
[   20.371791] RSP: 0000:fffffe0000086000 EFLAGS: 00010046
[   20.373246] RAX: 0000000092400a87 RBX: 0000000000000000 RCX: 00000000000=
00000
[   20.375250] RDX: 0000000000000000 RSI: ffffffff92400f18 RDI: ffffffff924=
01146
[   20.377103] RBP: 0000000000000000 R08: 0000000000000000 R09: 00000000000=
00000
[   20.378958] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000000=
00000
[   20.380808] R13: 0000000000000000 R14: 0000000000000000 R15: 00000000000=
00000
[   20.382744]  ? page_fault+0x8/0x30
[   20.383925]  ? error_entry+0x86/0x100
[   20.385037]  </#DF>
[   20.385793]  <ENTRY_TRAMPOLINE>
[   20.386774]  ? native_iret+0x7/0x7
[   20.387839]  ? page_fault+0x8/0x30
[   20.388901]  ? error_entry+0x86/0x100
[   20.389997]  ? trace_hardirqs_off_caller+0x7/0xa0
[   20.391464]  ? trace_hardirqs_off_thunk+0x1a/0x1c
[   20.392850]  ? native_iret+0x7/0x7
[   20.393886]  ? page_fault+0x8/0x30
[   20.394984]  ? error_entry+0x86/0x100
[   20.396092]  ? page_fault+0x8/0x30
[   20.397145]  ? ist_enter+0x6/0xa0
[   20.398167]  ? do_int3+0x34/0x120
[   20.399213]  ? int3+0x14/0x20
[   20.400226]  </ENTRY_TRAMPOLINE>
[   20.401574] Kernel Offset: 0x10800000 from 0xffffffff81000000 (relocatio=
n range: 0xffffffff80000000-0xffffffffbfffffff)
[   20.404788] ---[ end Kernel panic - not syncing: Machine halted. ]---

Full crash log can be found at,
https://lkft.validation.linaro.org/scheduler/job/303760

Download this image.
http://snapshots.linaro.org/openembedded/lkft/morty/intel-core2-32/rpb/linu=
x-stable-rc-4.17/7/rpb-console-image-intel-core2-32-20180624171508-7.hddimg=
.xz =


Boot command:
qemu-system-x86_64
 -cpu host
 -enable-kvm
 -nographic
 -net nic,model=3Dvirtio,macaddr=3DDE:AD:BE:EF:66:01
 -net tap -m 1024
 -monitor none
 -drive format=3Draw,file=3Drpb-console-image-intel-core2-32-20180624171508=
-7.hddimg,if=3Dvirtio
 -m 4096
 -smp 4
 -drive format=3Dqcow2,file=3D/lava-guest.qcow2,media=3Ddisk,if=3Dvirtio


After successfull boot,
login as root

Run the in-built test,
cd /opt/kselftests/mainline/x86
./mov_ss_trap_64

Test case link,
https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/tre=
e/tools/testing/selftests/x86/mov_ss_trap.c?h=3Dlinux-4.17.y

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1778473

Title:
  [Crash] qemu-system-x86_64: mov_ss_trap_64 PANIC: double fault,
  error_code: 0x0

Status in QEMU:
  New

Bug description:
  Kselftest test case mov_ss_trap_64 is causing kernel panic on
  qemu-system-x86_64 and PASS on real x86_64 hardware.

  qemu-system-x86_64 version is 2.12.0
  host architecture: amd64

  Test failed on recent stable rc kernel,
  4.17.3-rc1, 4.16.18-rc1 and 4.14.52-rc1.

  =

  Test code snippet,
  main() {
  <>
        printf("[RUN]\tMOV SS; CS CS INT3\n");
        asm volatile ("mov %[ss], %%ss; .byte 0x2e, 0x2e; int3" :: [ss] "m"=
 (ss));
  <>
  }

  Kerel crash log,
  # cd /opt/kselftests/mainline/x86
  # ./mov_ss_trap_64
  	SS =3D 0x2b, &SS =3D 0x0x604188
  	Set up a watchpoint
  	DR0 =3D 604188, DR1 =3D 400a19, DR7 =3D 7000a
  [RUN]	Read from watched memory (should get SIGTRAP)
  	Got SIGTRAP with RIP=3D4008ea, EFLAGS.RF=3D0
  [RUN]	MOV SS; INT3
  	Got SIGTRAP with RIP=3D4008fb, EFLAGS.RF=3D0
  [RUN]	MOV SS; INT 3
  	Got SIGTRAP with RIP=3D40090d, EFLAGS.RF=3D0
  [RUN]	M[   20.305426] PANIC: double fault, error_code: 0x0
  OV SS; CS CS INT3
  	Got SIGTRAP with RIP=3D400920,[   20.308317] CPU: 3 PID: 2471 Comm: mov_=
ss_trap_64 Not tainted 4.17.3-rc1 #1
   EFLAGS.RF=3D0
  [RUN]	MOV SS; CSx14 INT3
  [   20.311664] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
  [   20.314738] RIP: 0010:error_entry+0x32/0x100
  [   20.316198] RSP: 0000:fffffe0000086000 EFLAGS: 00010046
  [   20.317911] RAX: 0000000092400a87 RBX: 0000000000000000 RCX: 000000000=
0000000
  [   20.320168] RDX: 0000000000000000 RSI: ffffffff92400f18 RDI: ffffffff9=
2401146
  [   20.322405] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
  [   20.324320] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
  [   20.326073] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
  [   20.327869] FS:  00007f3174aefe80(0000) GS:ffff9f447fd80000(0000) knlG=
S:0000000000000000
  [   20.329850] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  [   20.331343] CR2: fffffe0000085ff8 CR3: 0000000136d2e000 CR4: 000000000=
00006e0
  [   20.333150] DR0: 0000000000604188 DR1: 0000000000400a19 DR2: 000000000=
0000000
  [   20.334893] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000000000=
007060a
  [   20.336649] Call Trace:
  [   20.337523]  <ENTRY_TRAMPOLINE>
  [   20.338507]  ? native_iret+0x7/0x7
  [   20.339611]  ? page_fault+0x8/0x30
  [   20.340693]  ? error_entry+0x86/0x100
  [   20.341871]  ? trace_hardirqs_off_caller+0x7/0xa0
  [   20.343212]  ? trace_hardirqs_off_thunk+0x1a/0x1c
  [   20.344554]  ? native_iret+0x7/0x7
  [   20.345647]  ? page_fault+0x8/0x30
  [   20.346716]  ? error_entry+0x86/0x100
  [   20.347853]  ? page_fault+0x8/0x30
  [   20.348920]  ? ist_enter+0x6/0xa0
  [   20.349961]  ? do_int3+0x34/0x120
  [   20.351095]  ? int3+0x14/0x20
  [   20.352047]  </ENTRY_TRAMPOLINE>
  [   20.353060] Code: 48 89 7c 24 08 52 31 d2 51 31 c9 50 41 50 45 31 c0 4=
1 51 45 31 c9 41 52 45 31 d2 41 53 45 31 db 53 31 db 55 31 ed 41 54 45 31 e=
4 <41> 55 45 31 ed 41 56 45 31 f6 41 57 45 31 ff 56 48 8d 6c 24 09 =

  [   20.357895] Kernel panic - not syncing: Machine halted.
  [   20.359385] CPU: 3 PID: 2471 Comm: mov_ss_trap_64 Not tainted 4.17.3-r=
c1 #1
  [   20.361271] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIO=
S 1.10.2-1 04/01/2014
  [   20.363513] Call Trace:
  [   20.364367]  <#DF>
  [   20.365109]  dump_stack+0x68/0x95
  [   20.366131]  panic+0xe3/0x22a
  [   20.367207]  df_debug+0x2d/0x30
  [   20.368254]  do_double_fault+0x9f/0x120
  [   20.369387]  double_fault+0x23/0x30
  [   20.370444] RIP: 0010:error_entry+0x32/0x100
  [   20.371791] RSP: 0000:fffffe0000086000 EFLAGS: 00010046
  [   20.373246] RAX: 0000000092400a87 RBX: 0000000000000000 RCX: 000000000=
0000000
  [   20.375250] RDX: 0000000000000000 RSI: ffffffff92400f18 RDI: ffffffff9=
2401146
  [   20.377103] RBP: 0000000000000000 R08: 0000000000000000 R09: 000000000=
0000000
  [   20.378958] R10: 0000000000000000 R11: 0000000000000000 R12: 000000000=
0000000
  [   20.380808] R13: 0000000000000000 R14: 0000000000000000 R15: 000000000=
0000000
  [   20.382744]  ? page_fault+0x8/0x30
  [   20.383925]  ? error_entry+0x86/0x100
  [   20.385037]  </#DF>
  [   20.385793]  <ENTRY_TRAMPOLINE>
  [   20.386774]  ? native_iret+0x7/0x7
  [   20.387839]  ? page_fault+0x8/0x30
  [   20.388901]  ? error_entry+0x86/0x100
  [   20.389997]  ? trace_hardirqs_off_caller+0x7/0xa0
  [   20.391464]  ? trace_hardirqs_off_thunk+0x1a/0x1c
  [   20.392850]  ? native_iret+0x7/0x7
  [   20.393886]  ? page_fault+0x8/0x30
  [   20.394984]  ? error_entry+0x86/0x100
  [   20.396092]  ? page_fault+0x8/0x30
  [   20.397145]  ? ist_enter+0x6/0xa0
  [   20.398167]  ? do_int3+0x34/0x120
  [   20.399213]  ? int3+0x14/0x20
  [   20.400226]  </ENTRY_TRAMPOLINE>
  [   20.401574] Kernel Offset: 0x10800000 from 0xffffffff81000000 (relocat=
ion range: 0xffffffff80000000-0xffffffffbfffffff)
  [   20.404788] ---[ end Kernel panic - not syncing: Machine halted. ]---

  Full crash log can be found at,
  https://lkft.validation.linaro.org/scheduler/job/303760

  Download this image.
  http://snapshots.linaro.org/openembedded/lkft/morty/intel-core2-32/rpb/li=
nux-stable-rc-4.17/7/rpb-console-image-intel-core2-32-20180624171508-7.hddi=
mg.xz =


  Boot command:
  qemu-system-x86_64
   -cpu host
   -enable-kvm
   -nographic
   -net nic,model=3Dvirtio,macaddr=3DDE:AD:BE:EF:66:01
   -net tap -m 1024
   -monitor none
   -drive format=3Draw,file=3Drpb-console-image-intel-core2-32-201806241715=
08-7.hddimg,if=3Dvirtio
   -m 4096
   -smp 4
   -drive format=3Dqcow2,file=3D/lava-guest.qcow2,media=3Ddisk,if=3Dvirtio

  =

  After successfull boot,
  login as root

  Run the in-built test,
  cd /opt/kselftests/mainline/x86
  ./mov_ss_trap_64

  Test case link,
  https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/t=
ree/tools/testing/selftests/x86/mov_ss_trap.c?h=3Dlinux-4.17.y

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1778473/+subscriptions
