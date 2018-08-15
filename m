Received: from eggs.gnu.org ([2001:4830:134:3::10]:57321)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQK-0001Q8-4W
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqQI-0007Eb-29
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:55 -0400
Received: from indium.canonical.com ([91.189.90.7]:52316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqQH-0007CU-IM
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:40:53 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqQG-0006e2-OG
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:52 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B64442E851C
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:40:52 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:25:56 -0000
From: Thomas Huth <1715296@bugs.launchpad.net>
Reply-To: Bug 1715296 <1715296@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <150467634266.16715.896859689385742459.malonedeb@gac.canonical.com>
Message-Id: <153431795739.24290.3119134289218560401.launchpad@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1715296] Re: qemu: invalid serial port
 configuration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1715296

Title:
  qemu: invalid serial port configuration

Status in QEMU:
  Fix Released

Bug description:
  The tty_serial_init() function sets the port c_oflags as follows:
  tty.c_oflag |=3D OPOST not clearing ONLCR, ONLRET and others.
  The result is that the postprocess output is enabled and host translates =
0xa (LF) to 0xd 0xa (CR LF) which breaks the binary transmissions on serial=
 port even if you set the port to raw mode (no matters if on host and/or gu=
est).
  The issue has been reported 11 years ago on qemu-devel mailing list:
  https://lists.nongnu.org/archive/html/qemu-devel/2006-06/msg00196.html
  There was also a FreeBSD patch including the fix:
  https://lists.freebsd.org/pipermail/freebsd-ports/2006-October/036390.html

  I think the correct port configuration is:
  tty.c_iflag &=3D ~(IGNBRK|BRKINT|PARMRK|ISTRIP|INLCR|IGNCR|ICRNL|IXON|IMA=
XBEL);
  tty.c_oflag &=3D ~OPOST;

  In such case the host will perform no output processing and will pass the=
 data as is.
  And the guest will be able to configure input/output processing exactly a=
s it wants.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1715296/+subscriptions
