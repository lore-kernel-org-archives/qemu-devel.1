Received: from eggs.gnu.org ([209.51.188.92]:58523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gk7lV-0000K2-NV
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:31:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gk7bB-0003cC-BL
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:20:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:37954)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gk7b9-0003V5-Lc
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:20:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gk7b3-0007ES-7n
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 13:20:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 39FCC2E80CC
	for <qemu-devel@nongnu.org>; Thu, 17 Jan 2019 13:20:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 17 Jan 2019 13:11:08 -0000
From: Thomas Roth <1812091@bugs.launchpad.net>
Reply-To: Bug 1812091 <1812091@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154766268387.1937.11188043264522807203.malonedeb@wampee.canonical.com>
Message-Id: <154773066883.31698.14128397425342597853.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1812091] Re: gdbstub memory accesses performed
 with wrong attributes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hello Peter and thanks a lot for your quick response.

I have tested the patch and it seems to work! Looks like my testing code
was buggy, apologies for the inaccurate bug description.

Thanks,
Thomas

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1812091

Title:
  gdbstub memory accesses performed with wrong attributes

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
