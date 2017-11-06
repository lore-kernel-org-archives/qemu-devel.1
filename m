Received: from eggs.gnu.org ([2001:4830:134:3::10]:48345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBgKd-00053X-Q3
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:16:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eBgKa-0003pi-LR
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:16:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:43534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eBgKa-0003pK-FD
	for qemu-devel@nongnu.org; Mon, 06 Nov 2017 07:16:44 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eBgKZ-0004cU-CO
	for <qemu-devel@nongnu.org>; Mon, 06 Nov 2017 12:16:43 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 59D672E8058
	for <qemu-devel@nongnu.org>; Mon,  6 Nov 2017 12:16:43 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Nov 2017 12:02:38 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1188991 <1188991@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130608182041.13525.18729.malonedeb@soybean.canonical.com>
Message-Id: <150996975848.8971.5132208450709596358.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1188991] Re: Unable to do serial communication
 using -chardev tty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Hi. The beaglexm model isn't part of upstream QEMU (it was in a set of
downstream patches for OMAP3 which were never merged upstream and which
are now essentially abandoned.) The root cause of this bug is that
support for pass-through of a host serial port requires specific support
in the device model for the UART to pass through the serial parameters
(baud rate etc); this is implemented in some UART models but not all and
apparently not in the OMAP3 UART code.

Since this isn't a bug in upstream QEMU, I'm going to close this (now
four year old) bug report; sorry we can't be more helpful here :-(


** Changed in: qemu
       Status: New =3D> Invalid

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1188991

Title:
  Unable to do serial communication using -chardev tty

Status in QEMU:
  Invalid

Bug description:

  Im running an Linux Image (kernel 3.2.8) for beagleboard-xm on QEMU's
  1.4.0 emulator.

  =

  What I want to do is to have a communication between guest and host acros=
s serial the 4 differents ttyO present on the guest. QEMU offer facilities =
to redirect the trafic to some device in the host side.

  The command that I use to lauch QEMU is :

      sudo qemu-system-arm -M beaglexm -m 1024 -sd ./test.img -clock
  unix -see -device usb-kbd -chardev tty,id=3Dmytty,path=3D/dev/ttyS0

  As it says in the QEMU's manual -chardev is suppose to connect to a
  local tty device at the path given

  My problem goes like this:

  At the guest kernel boot I'm able to see that my UART where enabled

      [    2.682040] Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
      [    2.777947] omap_uart.0: ttyO0 at MMIO 0x4806a000 (irq =3D 72) is =
a OMAP UART0
      [    2.794967] omap_uart.1: ttyO1 at MMIO 0x4806c000 (irq =3D 73) is =
a OMAP UART1
      [    2.814942] omap_uart.2: ttyO2 at MMIO 0x49020000 (irq =3D 74) is =
a OMAP UART2
      [    2.966825] console [ttyO2] enabled
      [    2.984777] omap_uart.3: ttyO3 at MMIO 0x49042000 (irq =3D 80) is =
a OMAP UART3

  In fact, when I go see in to /proc/tty/driver and I do a cat on OMAP-
  SERIAL Im able to see this serinfo:1.0 driver revision:

      0: uart:OMAP UART0 mmio:0x4806A000 irq:72 tx:0 rx:0 CTS|DSR|CD
      1: uart:OMAP UART1 mmio:0x4806C000 irq:73 tx:0 rx:0 CTS|DSR|CD
      2: uart:OMAP UART2 mmio:0x49020000 irq:74 tx:268 rx:37 RTS|CTS|DTR|DS=
R|CD
      3: uart:OMAP UART3 mmio:0x49042000 irq:80 tx:0 rx:0 CTS|DSR|CD

  I know that ttyO2 is working because my console is been redirected to
  it. The thing is that doing a set serial on any of the ttyO I get the
  following message:

       [root@enu driver]# setserial -a /dev/ttyO0
      /dev/ttyO0, Line 0, UART: undefined, Port: 0x0000, IRQ: 72
          Baud_base: 3000000, close_delay: 50, divisor: 0
          closing_wait: 3000
          Flags: spd_normal

  The same goes with ttyO2. I tryed to set some sethings to any of the
  ttyO with setserial but I always get the same message:

      [root@enu ~]# setserial /dev/ttyO0 uart 8250                         =
     =

      setserial: can't set serial info: Invalid argument
      [root@enu ~]# setserial /dev/ttyO0 port 0x4806a000
      setserial: can't set serial info: Invalid argument

  basicly I want to establish a serial communication between a guest and
  a host, but the serial ports on the guest side aren't well configured.

  When I open ttyS0 with minicom on the host side and do on the guest
  side

      echo "test" > /dev/ttyO0

  The host recives nothing.

  Anyone can tell me how I could remove tty modules on the guest side
  and try to insert it again to see if the setup resets properly or give
  me any advice on how to solve this problem. Plus if anyone has already
  tryed doing this kind on serial communication I would like to here
  from you.

  Thank,
  Francisco

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1188991/+subscriptions
