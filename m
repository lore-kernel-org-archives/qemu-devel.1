Received: from eggs.gnu.org ([209.51.188.92]:37161)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjqI7-0008C4-M1
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gjqGs-0006gQ-7e
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:50:40 -0500
Received: from indium.canonical.com ([91.189.90.7]:45968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gjqGs-0006es-1c
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 13:50:38 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gjqGq-0005wp-72
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 18:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id EAC662E807D
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 18:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Jan 2019 18:41:03 -0000
From: Thomas Roth <1812091@bugs.launchpad.net>
Reply-To: Bug 1812091 <1812091@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154766268387.1937.11188043264522807203.malonedeb@wampee.canonical.com>
Message-Id: <154766406369.1450.8881205815132033479.launchpad@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1812091] Re: ARMv8-M boots in wrong security mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Information type changed from Public to Public Security

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1812091

Title:
  ARMv8-M boots in wrong security mode

Status in QEMU:
  New

Bug description:
  Qemu-commit: b2f7c27f56bf1116ebb7848c75914aa7c5d6a040

  =

  The ARMv8-M architecture (with security extensions) contains a SAU, the S=
ecurity Attribution Unit. After booting the mps2-an505 and immediately halt=
ing (`-S`), I attempt to read the SAU_TYPE register, located at 0xE000EDD4,=
 using gdb (x 0xE000EDD4). The returned value is 0, while the expected valu=
e is 8 (number of regions).

  On further investigation, it seems that `attrs.secure` is set to false
  (armv7m_nvic.c - nvic_readl, line 1167). Commenting out the check will
  return the correct value.

  As the CPU should be in 'secure' mode after reset, I think this
  behavior is wrong.

  Steps to reproduce:
  Example code that loads an endless loop into the beginning of secure memo=
ry: https://github.com/ajblane/armv8m-hello

  Commandline: qemu-system-arm -machine mps2-an505 -cpu cortex-m33 \
  	                    -m 4096 \
  			    -nographic -serial mon:stdio \
  	                    -kernel $(IMAGE) -s -S

  Attach with arm-none-eabi-gdb, and run x 0xE000EDD4.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1812091/+subscriptions
