Received: from eggs.gnu.org ([2001:4830:134:3::10]:51194)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f9yWv-0008OF-DI
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:50:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f9yWs-0004Yb-8A
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:50:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:48650)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f9yWr-0004Xh-G5
	for qemu-devel@nongnu.org; Sat, 21 Apr 2018 15:50:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f9yWq-0000f9-Dc
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 19:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 64F262E80C8
	for <qemu-devel@nongnu.org>; Sat, 21 Apr 2018 19:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 21 Apr 2018 19:37:00 -0000
From: diddly <dflogeras2@gmail.com>
Reply-To: Bug 1765970 <1765970@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152432626539.12479.15065213360151643512.malonedeb@chaenomeles.canonical.com>
Message-Id: <152433942069.12613.6156917996015371488.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1765970] Re: qemu-arm (user mode) segfaults in
 uclibc-ng chroot after upgrade to 2.11.x
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Unfortunately, no dice

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1765970

Title:
  qemu-arm (user mode) segfaults in uclibc-ng chroot after upgrade to
  2.11.x

Status in QEMU:
  New

Bug description:
  I use a qemu-user chroot + binfmt to build software targetting a
  raspberry pi.  After upgrading from qemu-2.10.1 to 2.11.1 (Gentoo
  host), I noticed that on my uclibc-ng chroot qemu-arm will segfault
  when running python and importing the portage module.

  I have bisected qemu down to this commit:

  https://github.com/qemu/qemu/commit/18e80c55bb6ec17c05ec0ba717ec83933c2bf=
c07

  If I recompile and change MAX_RESERVED_VA (from the above commit) back
  to 0x77000000 the problem goes away.  NB I have no idea what that
  does, I just thought I'd see.

  =

  Other arm chroots (glibc, musl) do not segfault with qemu-2.11, only the =
uclibc-ng one.  Not sure why.

  =

  The following backtrace was generated from running qemu-arm in gdb and re=
creating the segfault:

  (gdb) where
  #0  0x0000000060726046 in static_code_gen_buffer ()
  #1  0x0000000060048789 in cpu_tb_exec (cpu=3D0x6278e310, =

      itb=3D0x60725f80 <static_code_gen_buffer+314624>)
      at /usr/src/debug/app-emulation/qemu-2.11.1-r2/qemu-2.11.1/accel/tcg/=
cpu-exec.c:167
  #2  0x000000006004937f in cpu_loop_exec_tb (cpu=3D0x6278e310, =

      tb=3D0x60725f80 <static_code_gen_buffer+314624>, last_tb=3D0x7fffffff=
d138, =

      tb_exit=3D0x7fffffffd130)
      at /usr/src/debug/app-emulation/qemu-2.11.1-r2/qemu-2.11.1/accel/tcg/=
cpu-exec.c:627
  #3  0x0000000060049600 in cpu_exec (cpu=3D0x6278e310)
      at /usr/src/debug/app-emulation/qemu-2.11.1-r2/qemu-2.11.1/accel/tcg/=
cpu-exec.c:736
  #4  0x00000000600511c3 in cpu_loop (env=3D0x627965b0)
      at /usr/src/debug/app-emulation/qemu-2.11.1-r2/qemu-2.11.1/linux-user=
/main.c:585
  #5  0x00000000600534eb in main (argc=3D4, argv=3D0x7fffffffd9b8, =

      envp=3D0x7fffffffd9e0)
      at /usr/src/debug/app-emulation/qemu-2.11.1-r2/qemu-2.11.1/linux-user=
/main.c:4882


  (gdb) info reg
  rax            0x627965b0       1652123056
  rbx            0x62717870       1651603568
  rcx            0x606da000       1617797120
  rdx            0x60726000       1618108416
  rsi            0x60726000       1618108416
  rdi            0x627965b0       1652123056
  rbp            0x7fffffffd0c0   0x7fffffffd0c0
  rsp            0x7fffffffd080   0x7fffffffd080
  r8             0x0      0
  r9             0x2      2
  r10            0x0      0
  r11            0x629280a0       1653768352
  r12            0x60260e40       1613106752
  r13            0x0      0
  r14            0x606a5018       1617580056
  r15            0x0      0
  rip            0x60048789       0x60048789 <cpu_tb_exec+266>
  eflags         0x10282  [ SF IF RF ]
  cs             0x33     51
  ss             0x2b     43
  ds             0x0      0
  es             0x0      0
  fs             0x0      0
  gs             0x0      0
  (gdb)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1765970/+subscriptions
