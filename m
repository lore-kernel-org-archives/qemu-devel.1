Received: from eggs.gnu.org ([2001:4830:134:3::10]:43685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejuFQ-0000JV-O3
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:00:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ejuFN-0005GI-M8
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:00:52 -0500
Received: from indium.canonical.com ([91.189.90.7]:38390)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ejuFN-0005G4-Fz
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 17:00:49 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ejuFL-0005yf-Aa
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 22:00:47 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id DF9792E80D2
	for <qemu-devel@nongnu.org>; Thu,  8 Feb 2018 22:00:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Feb 2018 21:50:56 -0000
From: Doug Gale <doug16k@gmail.com>
Reply-To: Bug 1748296 <1748296@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151812332204.10331.17425660234309724521.malonedeb@wampee.canonical.com>
Message-Id: <151812665669.9868.12149661875211242307.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1748296] Re: TCG throws Invalid Opcode when
 executing x86 BMI shlx instruction
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Description changed:

  I am unable to use BMI in my project when running under TCG. I narrowed
  the problem down to incorrect instruction decoding for BMI instructions
  (which have a 2 byte VEX prefix). The gen_sse function in translate.c
  reaches the goto label do_0f_38_fx, but b does not equal 0x1f7, 0x2f7,
  or 0x3f7, so the switch takes the default path and raises an invalid
  opcode exception.
  =

  The code executes correctly and passes the test under KVM.
  =

  I have created a complete repro here: https://github.com/doug65536/qemu-
  bmibug
  =

  The makefile has the following utility targets:
  =

  debug-kvm: Build and run the VM using KVM and wait for gdbstub attach
  =

  run: Run the test case with TCG, make fails if the test fails. (It will
  fail)
  =

  run-kvm: Run the test case with KVM, make fails if the test fails. (It
  will succeed)
  =

  debug: Build and run the VM with TCG and wait for GDB attach
  =

- attach-gdb: Run GDB and attach to KVM gdbstub
+ attach-gdb: Run GDB and attach to QEMU gdbstub
  =

  The VM runs with -cpu max. CPUID reports support for BMI, BMI2, and ABM.
  =

  You can quickly verify the issue by executing `make run-kvm` to confirm
  that KVM passes, then `make run` to confirm that TCG fails.
  =

  I believe the bug affects other BMI, BMI2, and ABM instructions, but I
  have only completely verified incorrect execution of SHLX.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1748296

Title:
  TCG throws Invalid Opcode when executing x86 BMI shlx instruction

Status in QEMU:
  New

Bug description:
  I am unable to use BMI in my project when running under TCG. I
  narrowed the problem down to incorrect instruction decoding for BMI
  instructions (which have a 2 byte VEX prefix). The gen_sse function in
  translate.c reaches the goto label do_0f_38_fx, but b does not equal
  0x1f7, 0x2f7, or 0x3f7, so the switch takes the default path and
  raises an invalid opcode exception.

  The code executes correctly and passes the test under KVM.

  I have created a complete repro here: https://github.com/doug65536
  /qemu-bmibug

  The makefile has the following utility targets:

  debug-kvm: Build and run the VM using KVM and wait for gdbstub attach

  run: Run the test case with TCG, make fails if the test fails. (It
  will fail)

  run-kvm: Run the test case with KVM, make fails if the test fails. (It
  will succeed)

  debug: Build and run the VM with TCG and wait for GDB attach

  attach-gdb: Run GDB and attach to QEMU gdbstub

  The VM runs with -cpu max. CPUID reports support for BMI, BMI2, and
  ABM.

  You can quickly verify the issue by executing `make run-kvm` to
  confirm that KVM passes, then `make run` to confirm that TCG fails.

  I believe the bug affects other BMI, BMI2, and ABM instructions, but I
  have only completely verified incorrect execution of SHLX.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1748296/+subscriptions
