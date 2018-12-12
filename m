Received: from eggs.gnu.org ([2001:4830:134:3::10]:51394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0EW-0006Ro-OX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gX0EQ-000540-V5
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:51:06 -0500
Received: from indium.canonical.com ([91.189.90.7]:42366)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gX0EQ-00052j-Fh
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 03:51:02 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gX0EN-0007FA-GA
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:50:59 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 77DEB2E80C3
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 08:50:59 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Dec 2018 08:37:47 -0000
From: Thomas Huth <1803160@bugs.launchpad.net>
Reply-To: Bug 1803160 <1803160@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154212865934.10800.13528910091420823354.malonedeb@wampee.canonical.com>
Message-Id: <154460386935.9175.3862483569756047582.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1803160] Re: qemu-3.1.0-rc0: tcg.c crash in
 temp_load
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
https://bugs.launchpad.net/bugs/1803160

Title:
  qemu-3.1.0-rc0: tcg.c crash in temp_load

Status in QEMU:
  Fix Released

Bug description:
  QEMU version:
  -------------

  qemu-3.1.0-rc0 compiled from sources (earlier versions also affected)

  Summary:
  --------

  TCG crashes in i386 and x86_64 when it tries to execute some specific
  illegal instructions. When running full OS emulation, both the guest
  system and QEMU crash.

  The issue has been reproduced in two scenarios:

  Ubuntu x64 host running Debian x86 guest with the following command
  line: qemu-system-x86_64 -m 4G debian.qcow

  When the attached ELF file is executed inside the guest, QEMU crashes.

  It can also be reproduced from the command line:

  $ qemu-i386 tcg_crash.elf
  /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg.c:2863: tcg fatal error
  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
  zsh: segmentation fault (core dumped)  ../qemu-3.1.0-rc0/build/i386-linux=
-user/qemu-i386 tcg_crash.elf

  GDB backtrace:

  (gdb) bt
  #0  0x0000000060206488 in raise ()
  #1  0x0000000060206b8a in abort ()
  #2  0x0000000060007016 in temp_load (s=3Ds@entry=3D0x607a2780 <tcg_init_c=
tx>, ts=3Dts@entry=3D0x607a3178 <tcg_init_ctx+2552>, desired_regs=3D<optimi=
zed out>, allocated_regs=3Dallocated_regs@entry=3D16400)
  =C2=A0=C2=A0=C2=A0=C2=A0at /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg=
.c:2863
  #3  0x000000006000a4d9 in tcg_reg_alloc_op (op=3D0x62808c20, s=3D<optimiz=
ed out>) at /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg.c:3070
  #4  tcg_gen_code (s=3D<optimized out>, tb=3Dtb@entry=3D0x607ac040 <static=
_code_gen_buffer+4144>) at /home/alberto/Documents/qemu-3.1.0-rc0/tcg/tcg.c=
:3598
  #5  0x000000006003ef9a in tb_gen_code (cpu=3Dcpu@entry=3D0x627e0010, pc=
=3Dpc@entry=3D134512724, cs_base=3Dcs_base@entry=3D0, flags=3Dflags@entry=
=3D4194483, cflags=3Dcflags@entry=3D0)
  =C2=A0=C2=A0=C2=A0=C2=A0at /home/alberto/Documents/qemu-3.1.0-rc0/accel/t=
cg/translate-all.c:1752
  #6  0x000000006003d979 in tb_find (cf_mask=3D0, tb_exit=3D0, last_tb=3D0x=
0, cpu=3D0x0) at /home/alberto/Documents/qemu-3.1.0-rc0/accel/tcg/cpu-exec.=
c:404
  #7  cpu_exec (cpu=3Dcpu@entry=3D0x627e0010) at /home/alberto/Documents/qe=
mu-3.1.0-rc0/accel/tcg/cpu-exec.c:724
  #8  0x000000006006e1a0 in cpu_loop (env=3Denv@entry=3D0x627e82c0) at /hom=
e/alberto/Documents/qemu-3.1.0-rc0/linux-user/i386/cpu_loop.c:93
  #9  0x00000000600037c5 in main (argc=3D2, argv=3D0x7fffffffdd28, envp=3D<=
optimized out>) at /home/alberto/Documents/qemu-3.1.0-rc0/linux-user/main.c=
:819
  (gdb)

  Testcase:
  ---------

  Find ELF file attached.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1803160/+subscriptions
