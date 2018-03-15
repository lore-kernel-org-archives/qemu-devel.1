Received: from eggs.gnu.org ([2001:4830:134:3::10]:60890)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewTg3-0004dH-QP
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ewTfy-0000dc-SD
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:16:19 -0400
Received: from indium.canonical.com ([91.189.90.7]:55980)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ewTfy-0000bF-LH
	for qemu-devel@nongnu.org; Thu, 15 Mar 2018 10:16:14 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ewTfv-0003OQ-KC
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:16:11 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6A6A62E81AB
	for <qemu-devel@nongnu.org>; Thu, 15 Mar 2018 14:16:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Mar 2018 14:05:49 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1753314 <1753314@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152019468379.20188.16040439279180777761.malonedeb@chaenomeles.canonical.com>
Message-Id: <152112274963.3187.18343012763755327878.malone@gac.canonical.com>
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

Hi. Thanks for this patch. I've had a quick look at it against the imx
datasheet, and here are my comments:

* Firstly, we can't do anything with this patch without a Signed-off-by:
line from you. In QEMU's process this is how people submitting code
state that you're legally OK to contribute the code under QEMU's license
and for it to go into QEMU.

 * Secondly, it would be very helpful if you could send patches as a
simple patch format, rather than as a zipfile, and to the QEMU mailing
list. https://wiki.qemu.org/Contribute/SubmitAPatch has our guidelines
on this.

 * Simply adding a new VMSTATE_UINT32() field will break migration. It's
better to put the new field into its own vmstate subsection so that this
doesn't happen; see docs/devel/migration.rst. If we don't care about
cross-version migration we could just bump the
version_id/minimum_version_id fields.

 * If you run scripts/checkpatch.pl over your patch it should warn you
about minor coding style issues. For instance we prefer all if()
statements to use {}, even if there's only one line in them.

 * Your change to imx_update() does this:
+    if (s->ucr4 & UCR4_TXEN)
+        flags |=3D USR1_TRDY;

but that isn't what the spec says UCR4_TXEN does; it says we raise an
interrupt only if UCR4_TXEN and USR2_TXDC are both high.

 * the imx_update() function is already rather confused in how it
handles the 'flags' variable, and this change extends that confusion.
The function is trying to treat 'flags' as a single set of interrupt
flag bits, but the device doesn't actually have a single unified set of
interrupt flags like that, they're spread over UTS and USR1 and USR2.
The code as it is looks odd -- should USR1.TXMPTYEN =3D=3D 0 really suppress
USR1_TRDY interrupts ? I suspect this is a bug, and we should also clean
things up to make 'flags' be a bool.

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
