Received: from eggs.gnu.org ([2001:4830:134:3::10]:36361)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewZ3v-0002BX-Ji
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewZ3r-0005MJ-GM
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:01:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:51764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewZ3r-0005LM-80
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 16:01:15 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewZ3o-0001uU-Ih
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 20:01:12 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4A9EC2E80D1
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 20:01:12 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 19:47:01 -0000
From: Bill Paul <wpaul@windriver.com>
Reply-To: Bug 1753314 <1753314@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152019468379.20188.16040439279180777761.malonedeb@chaenomeles.canonical.com>
Message-Id: <152114322197.3890.1933594106426266962.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1753314] Re: UART in sabrelite machine simulation
 doesn't work with VxWorks 7
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

As I said before:

"I'm not submitting this as a patch to the development list as I'm not
fully certain it complies with the hardware spec and doesn't break any
other functionality."

What I'm trying to say here is that while I may have been able to cobble
together a hack to make the UART nominally compatible with VxWorks, I do
not understand the hardware or QEMU well enough to really fix this the
right way. Even with my hack, every once in a while when printing lots
of data on the console, the output from the UART will stall unless I
press a key on the serial port, and I don't know why it does that. I did
try to investigate it a little but wasn't able to make much progress.
(My suspicion is that it has something to do with the fact that the
imx_serial module doesn't implement FIFO support, but even if that's
true I don't know how to fix it.)

Even so, I figured it was still worth it to attach my changes to the bug
report so that somebody who is better at this than me could use it as a
starting point, and so that anybody else who might want to experiment
with VxWorks using the QEMU sabrelite machine model wouldn't be totally
stuck like I was.

In short, the changes I made are good enough for my own needs (the
output stalls don't happen often enough to really bother me), but
they're not a fully debugged fix. That's why I filed a bug report
instead of just submitting a patch in the first place: I wanted somebody
sexier than me to create a fully debugged fix.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1753314

Title:
  UART in sabrelite machine simulation doesn't work with VxWorks 7

Status in QEMU:
  New

Bug description:
  The imx_serial.c driver currently implements only partial support for
  the i.MX6 UART hardware. (I understand it's a work in progress and
  that's fine.) dIn particular, it does not implement support for the
  Transmit Complete Interrupt Enable bit in the UCR4 register. The
  VxWorks 7 i.MX6 serial driver depends on the behavior of this bit in
  actual hardware in order to send characters through the UART
  correctly. The result is that with the current machine model, VxWorks
  will boot and run in QEMU but it's unable to print any characters to
  the console serial port.

  I have produced a small patch for the imx_serial.c module to make it
  nominally functional with VxWorks 7. It works well enough to allow the
  boot banner to appear and for the user to interact with the target
  shell.

  I'm not submitting this as a patch to the development list as I'm not
  fully certain it complies with the hardware spec and doesn't break any
  other functionality. I would prefer if the maintainer (or someone)
  reviewed it for any issues/refinements first.

  I'm attaching the patch to this bug report. A copy can also be
  obtained from:

  http://people.freebsd.org/~wpaul/qemu/imx_serial.zip

  This patch was generated against QEMU 2.11.0 but also works with QEMU
  2.11.1.

  My host environment is FreeBSD/amd64 11.1-RELEASE with QEMU
  2.11.0/2.11.11 built from source.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1753314/+subscriptions
