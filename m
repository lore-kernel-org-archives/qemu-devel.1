Received: from eggs.gnu.org ([2001:4830:134:3::10]:51927)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJn2R-0000Rr-BM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:35:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fJn2M-0003gE-8p
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:35:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:38766)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fJn2M-0003fo-2R
	for qemu-devel@nongnu.org; Fri, 18 May 2018 17:35:42 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fJn2J-0006c0-Qn
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 21:35:39 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C86AA2E8F3A
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 21:35:39 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 May 2018 21:27:18 -0000
From: Patto <1772086@bugs.launchpad.net>
Reply-To: Bug 1772086 <1772086@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152666797097.2555.6897470014572103765.malonedeb@gac.canonical.com>
Message-Id: <152667883851.16020.12107650861550981725.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1772086] Re: malformed serial data being sent
 from guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

After doing a bit of research I think line 142 in file chardev/char-
serial.c is problematic.
https://github.com/qemu/qemu/blob/master/chardev/char-serial.c#L142

It enables output processing, which is something unwanted here. With a
simple test program I found out that by default, besides OPOST, ONLCR
flag is set in c_oflag. I guess fix would be removing OPOST flag, which
would disable any output processing, or setting c_oflag to 0 just to be
sure.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1772086

Title:
  malformed serial data being sent from guest

Status in QEMU:
  New

Bug description:
  When sending data through serial from guest each time 0x0A byte is
  sent 0x0D is sent before it. For example, when sending {0x29, 0x0A} on
  the other end I receive {0x29, 0x0D, 0x0A}.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1772086/+subscriptions
