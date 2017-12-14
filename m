Received: from eggs.gnu.org ([2001:4830:134:3::10]:61000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePTb8-00022K-Id
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:30:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ePTb3-0005zk-Ku
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:30:50 -0500
Received: from indium.canonical.com ([91.189.90.7]:38382)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ePTb3-0005yV-F4
	for qemu-devel@nongnu.org; Thu, 14 Dec 2017 08:30:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ePTb1-0001ZN-E6
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 13:30:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 389FC2E80CC
	for <qemu-devel@nongnu.org>; Thu, 14 Dec 2017 13:30:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 14 Dec 2017 13:24:29 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1738202 <1738202@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151325583524.11815.276669131575779398.malonedeb@gac.canonical.com>
Message-Id: <151325786968.12570.17570329704927233099.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738202] Re: qemu 2.11 segfaults on elf file that
 worked with qemu2.7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Your command line is badly broken: "-M integratorcp" requests a model of
an integratorcp board, but "-cpu cortex-m4" tries to put an M-profile
CPU in it, which is not something that board can support. In particular
the resulting system model will have no NVIC in it. This only worked by
accident in previous versions of QEMU.

Ideally we should have better cpu-model compatibility checking in the
board models, in which case we could print a message saying "CPU type
cortex-m4 is not compatible with the integratorcp board" rather than
crashing.

If you omit -cpu you'll get the default CPU type for the board, which is
an arm926. That's a sensible board+cpu combination but presumably your
guest code is not built to run on that hardware, which will be why it
just falls over. ("QEMU prints no output" often means "guest code has
crashed or gone into an infinite loop", rather than a QEMU bug.)

If your code needs to run on an M-profile CPU then you'll need to pick
one of the M-profile board models. As of 2.11 those are lm3s6965evb,
lm3s811evb, mps2-an385, mps2-an511, netduino2.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738202

Title:
  qemu 2.11 segfaults on elf file that worked with qemu2.7

Status in QEMU:
  New

Bug description:
  running on cygwin in Windows 7

  QEMU 2.10.93 segfaults:
  $ /opt/qemu2.11/qemu-system-arm -M integratorcp -cpu cortex-m4 -semihosti=
ng -nographic -monitor null -serial null -no-reboot -kernel MFWso_Cycle_f1u=
P2_CUNIT_0.elf
  Segmentation fault

  where QEMU 2.7.0 worked:
  $ /opt/qemu2.7/qemu-system-arm -M integratorcp -cpu cortex-m4 -semihostin=
g -nographic -monitor null -serial null -no-reboot -kernel MFWso_Cycle_f1uP=
2_CUNIT_0.elf
  ------------ CUnit_MFWso_Cycle_f1 ------------

  =

       CUnit - A Unit testing framework for C - Version 2.1-0
       http://cunit.sourceforge.net/

  =

  Suite: Suite_MFWso_Cycle_f1
    Test: MFWso_Cycle_f1() ... passed
    Test: MFWso_GetPhysicalStateData() ... passed
    Test: MFWso_GetOutputData() ... passed
    Test: MFWso_GetSafeChannelOK() ... passed

  --Run Summary: Type      Total     Ran  Passed  Failed
                 suites        1       1     n/a       0
                 tests         4       4       4       0
                 asserts      54      54      54       0

  ----------------------------------------

  Omitting the -cpu parameter results (for both versions) to hang of
  qemu (no output, no end, full cpu load).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738202/+subscriptions
