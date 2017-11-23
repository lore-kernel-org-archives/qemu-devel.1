Received: from eggs.gnu.org ([2001:4830:134:3::10]:38676)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHx7t-00027o-SD
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:25:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eHx7p-0002LN-7W
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:25:33 -0500
Received: from indium.canonical.com ([91.189.90.7]:43008)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eHx7o-0002HF-U2
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 14:25:29 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eHx7n-0000Eq-Pv
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 19:25:27 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C17622E80C8
	for <qemu-devel@nongnu.org>; Thu, 23 Nov 2017 19:25:27 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Nov 2017 19:08:58 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1596204 <1596204@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160625163153.2158.13940.malonedeb@chaenomeles.canonical.com>
Message-Id: <151146413830.14516.15550293669751391012.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1596204] Re: UART problem in raspi2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

This is because you're running a binary for the raspberry pi 1 on a
model of the raspberry pi 2. The peripherals are at different locations
on the two boards, and so your program doesn't work. You can fix that by
changing all the register addresses that start 0x20..... to 0x3f...., or
more complicatedly by using the boards/cpuid/ code in that raspberrypi
repo to detect the correct PBASE value to use.

Secondly, the output goes to the second serial port, which in your
command line is not being directed anywhere. You can put the second
serial port's output on stdio with the first serial port output thrown
away using '-serial null -serial stdio'. (For more complicated
redirections, see the QEMU docs.)

If I do those two things, then the uart01 example runs fine on QEMU.


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1596204

Title:
  UART problem in raspi2

Status in QEMU:
  Invalid

Bug description:
  I was trying to run the raspberry pi uart example at
  https://github.com/dwelch67/raspberrypi/tree/master/uart01 using qemu
  2.6.0, but it didn't work.

  The steps I took were:
  * Edit uart01/memmap and change origin to 0x10000 (which is the address q=
emu starts executing),
  * make
  * /usr/local/bin/qemu-system-arm -machine raspi2 -m 512M -nographic -gdb =
tcp::26000 -S -kernel uart01.bin

  Then start arm-none-eabi-gdb and run following commands:

  target remote localhost:26000
  symbol-file ./uart01.elf

  =

  Then, when I start the program, it seems that the GET32(AUX_MU_LSR_REG)&0=
x20 condition never becomes true.

  This works on actual hardware, so I am wondering if I'm doing any
  steps incorrectly or missing.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1596204/+subscriptions
