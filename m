Received: from eggs.gnu.org ([2001:4830:134:3::10]:57920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqUc-0004v3-3G
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:45:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1fpqUW-0007ha-W6
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:45:21 -0400
Received: from indium.canonical.com ([91.189.90.7]:53338)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1fpqUW-0007hA-LG
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 03:45:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1fpqUV-0007CH-SL
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:45:15 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id D25922E800F
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 07:45:15 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Aug 2018 07:25:45 -0000
From: Thomas Huth <1407813@bugs.launchpad.net>
Reply-To: Bug 1407813 <1407813@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20150105223623.22315.6307.malonedeb@gac.canonical.com>
Message-Id: <153431794702.8562.18336630446601945847.launchpad@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1407813] Re: QEMU wrongly translates newlines on
 serial output
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
https://bugs.launchpad.net/bugs/1407813

Title:
  QEMU wrongly translates newlines on serial output

Status in QEMU:
  Fix Released

Bug description:
  When using "-serial stdio", QEMU shows the guest serial port's output
  on the tty running qemu. As it should, QEMU sets the tty to raw mode.
  Or almost... Strangely, it neglects to remove one output-translation
  bit, ONLCR (see termios(3)) enabled on the tty. And it should have
  removed this output translation!

  The problem is that with this ONLCR, the guest has no way of
  outputting a bare linefeed ('\n') - every time the guest tries to
  output a bare linefeed to the serial port, the host tty will translate
  it to \r\n which will be sent to the underlying terminal (e.g.,
  xterm).

  In most cases, this issue doesn't cause a problem: When the guest is
  running a Unix-like operating system which is itself in cooked mode,
  the guest itself will always output \r\n, and the hosts second
  translation (to \r\r\n) does no harm. But in certain cases, the guest
  can *really* want to output just \n, and have this \n reach the
  terminal emulator and do what a linefeed is supposed to do without a
  carriage-return - namely - just go one line down in the same column.

  As an illustration of this bug, consider a guest running a Unix-like
  operating system running a curses-based application (e.g., "vi"). If
  you look at the output of "infocmp xterm", you'll notice that cud1=3D^J.
  This means that if the curses library decides to move one line down
  (it can happen in some cursor movement situations) it might decide to
  print a linefeed (\n) to move one line down. The guest's operating
  system will not mess with this linefeed (because the guest is in raw
  mode), but then qemu's tty, because it was wrongly left in ONLCR mode,
  will change this \n to \r\n before it reaches the terminal - causing
  wrong cursor movement (instead the cursor going straight down, it
  moves to the first column of the next line).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1407813/+subscriptions
