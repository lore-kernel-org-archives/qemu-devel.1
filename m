Received: from eggs.gnu.org ([2001:4830:134:3::10]:58183)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEEm1-0003RJ-RE
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:23:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cEElx-0006mh-JT
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:23:05 -0500
Received: from indium.canonical.com ([91.189.90.7]:45925)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cEElx-0006mZ-Dn
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 07:23:01 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cEElt-0003YE-3m
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:22:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C1B4E2E9C38
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 12:01:18 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Dec 2016 11:46:37 -0000
From: Julian Brown <1647683@bugs.launchpad.net>
Reply-To: Bug 1647683 <1647683@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20161206113915.26308.72810.malonedeb@wampee.canonical.com>
Message-Id: <20161206114637.26046.68333.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1647683] Re: Bad interaction between tb flushing
 & gdb stub
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

(FAOD, the crashes happen without Valgrind too, and the above backtrace
may be a red herring.)

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1647683

Title:
  Bad interaction between tb flushing & gdb stub

Status in QEMU:
  New

Bug description:
  I have been working on a series of patches for ARM big-endian system
  mode support, using QEMU as a bare-metal simulator for the GDB test
  suite. At some point I realised that these tests were not running
  reliably on the QEMU master branch, even without my patches applied.
  (I.e., in little-endian mode.)

  Running QEMU under GDB in the test harness via Valgrind, using
  something akin to:

  (gdb) target remote | valgrind --tool=3Dmemcheck qemu-arm-system [...]

  leads to intermittent (and quite hard-to-reproduce) segfaults in QEMU
  of the form:

  =3D=3D52333=3D=3D Process terminating with default action of signal 11 (S=
IGSEGV)
  =3D=3D52333=3D=3D  Access not within mapped region at address 0x24
  =3D=3D52333=3D=3D    at 0x1D55F2: tb_page_remove (translate-all.c:1026)
  =3D=3D52333=3D=3D    by 0x1D58B4: tb_phys_invalidate (translate-all.c:111=
9)
  =3D=3D52333=3D=3D    by 0x1D63AA: tb_invalidate_phys_page_range (translat=
e-all.c:1519)
  =3D=3D52333=3D=3D    by 0x1D66D7: tb_invalidate_phys_addr (translate-all.=
c:1714)
  =3D=3D52333=3D=3D    by 0x1CBA7F: breakpoint_invalidate (exec.c:704)
  =3D=3D52333=3D=3D    by 0x1CC01F: cpu_breakpoint_remove_by_ref (exec.c:86=
9)
  =3D=3D52333=3D=3D    by 0x1CBF97: cpu_breakpoint_remove (exec.c:857)
  =3D=3D52333=3D=3D    by 0x218FAA: gdb_breakpoint_remove (gdbstub.c:717)
  =3D=3D52333=3D=3D    by 0x219E35: gdb_handle_packet (gdbstub.c:1035)
  =3D=3D52333=3D=3D    by 0x21AF62: gdb_read_byte (gdbstub.c:1459)
  =3D=3D52333=3D=3D    by 0x21B096: gdb_chr_receive (gdbstub.c:1672)
  =3D=3D52333=3D=3D    by 0x3AF2BC: qemu_chr_be_write_impl (qemu-char.c:419)

  These crashes didn't happen on a 2.6-era QEMU, so I bisected and
  discovered the commit 3359baad36889b83df40b637ed993a4b816c4906 ("tcg:
  Make tb_flush() thread safe") appears to be the thing that triggers
  this intermittent failure. Reverting the patch on the branch tip makes
  the crashes go away.

  Unfortunately I don't currently have a way to trigger the segfaults
  outside of Mentor Graphics's test infrastructure, which I can't share.

  Does anyone know a reason that this might be happening, or suggestions
  of how I might further debug this? Maybe a missed tb flush in the gdb
  stub code, somewhere?

  Thanks!

  Julian

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1647683/+subscriptions
