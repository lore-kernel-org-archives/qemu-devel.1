Received: from eggs.gnu.org ([2001:4830:134:3::10]:33633)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d99At-0006lM-CU
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:56:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1d99Aq-0007Qt-5g
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:55:59 -0400
Received: from indium.canonical.com ([91.189.90.7]:59792)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1d99Ap-0007Qi-Sw
	for qemu-devel@nongnu.org; Fri, 12 May 2017 07:55:56 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1d99An-0002IQ-4i
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 11:55:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3628F2E8195
	for <qemu-devel@nongnu.org>; Fri, 12 May 2017 11:55:48 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 May 2017 11:49:57 -0000
From: =?utf-8?q?Manfred_H=C3=A4rtel?= <1689003@bugs.launchpad.net>
Reply-To: Bug 1689003 <1689003@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20170507042529.2427.25374.malonedeb@wampee.canonical.com>
Message-Id: <149458979736.9244.11319565906641586522.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1689003] Re: USB passthrough should not fail if
 SET CONFIGURATION fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The attached simple program, compiled as a library, loaded by LD_PRELOAD
before starting QEMU, avoids the problem by faking success of
libusb_set_configuration(), as a workaround.

** Attachment added: "usbnosetconf.c"
   https://bugs.launchpad.net/qemu/+bug/1689003/+attachment/4875574/+files/=
usbnosetconf.c

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1689003

Title:
  USB passthrough should not fail if SET CONFIGURATION fails

Status in QEMU:
  New

Bug description:
  QEMU's USB passthrough was not working for my new smartphone.

  While analyzing the problem, I found out that a SET CONFIGURATION
  Request was NACKed by the USB device (probably because a SET
  CONFIGURATION request was already sent from the host to the device).

  So I wrote a simple program to fake a successful call to
  libusb_set_configuration and did an LD_PRELOAD on this program before
  starting qemu, and it worked.

  Looking at QEMU's code in host-libusb.c, I can see that QEMU does not
  try to claim the interface if its call to libusb_set_configuration
  fails.

  I think QEMU should try to claim the device anyway even if
  libusb_set_configuration fails.

  I did my tests against QEMU 2.6.2, but as I can see from the source
  code, this problem should happen on all versions.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1689003/+subscriptions
