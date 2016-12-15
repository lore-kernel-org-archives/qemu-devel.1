Received: from eggs.gnu.org ([2001:4830:134:3::10]:60574)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHeSt-000227-JZ
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 17:25:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1cHeSq-0005cS-Cp
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 17:25:27 -0500
Received: from indium.canonical.com ([91.189.90.7]:33668)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1cHeSq-0005be-6w
	for qemu-devel@nongnu.org; Thu, 15 Dec 2016 17:25:24 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1cHeSo-0003D3-7R
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 22:25:22 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 370062E80C1
	for <qemu-devel@nongnu.org>; Thu, 15 Dec 2016 22:25:22 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Dec 2016 22:09:23 -0000
From: Askar Safin <safinaskar@mail.ru>
Reply-To: Bug 922076 <922076@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20120126133438.17636.69999.malonedeb@soybean.canonical.com>
Message-Id: <20161215220923.29145.46844.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 922076] Re: doesn't clear screen on boot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The bug still exists in qemu 2.7 (version present in my debian stretch).
I was not able reproduce the bug with booting kernel directly with 2.7 (-ke=
rnel ...), but booting disk image causes the bug.

So, I have debian gnu/linux stretch amd64. debian package qemu-
system-x86 1:2.7+dfsg-3+b1. I run my host system in qemu (i. e. I run in
qemu same system that running on the host) using well known "-snapshot
-drive file=3D/dev/sda" trick. Precise command line is:

kdesudo -c "exec qemu-system-x86_64 -m 1024M -enable-kvm -daemonize
-snapshot -drive file=3D/dev/sda,cache=3Dnone,format=3Draw"

Qemu appears and I see usual "SeaBIOS (version
1.9.3-20161025_171302-gandalf)" as you can see at screenshot
Screenshot_20161216_005817.png .

Then qemu switches to grub.

And then qemu switches to text mode back. And fsck prints to console:
"/dev/sda2: recovering journal", but this words appears on top of that
SeaBIOS self-adver., so we have the following words mixture:

/dev/sda2: recovering journal25_171302-gandalf)

I use sdl. I don't know build option, this is qemu from debian package

** Attachment added: "Screenshot_20161216_005817.png"
   https://bugs.launchpad.net/qemu/+bug/922076/+attachment/4792204/+files/S=
creenshot_20161216_005817.png

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/922076

Title:
  doesn't clear screen on boot

Status in QEMU:
  Incomplete

Bug description:
  When I start Linux in Qemu via "qemu -kernel /vmlinuz ...", Qemu
  window appears and it shows message "Starting Seabios (version
  0.5.1-2010...)", and then Linux writes messages like "Loading, please
  wait..." on top of previous message!

  For example, I can see "Loading, please wait...on 0.5.1-2010...)"

  So, Qemu doesn't clean screan before booting OS.

  Moreover, when I start Linux via "qemu /disk-image", Qemu shows
  "Starting Seabios (version 0.5.1-2010...)", then switches to graphical
  mode, shows GRUB, then switches back to text mode and shows "Starting
  Seabios" again! And again Linux prints messages on top of Seabios
  messages, and we see a mix of symbols on screen.

  Also, I found another bug! I am learning now to write kernels. And I
  see that operator "*(char *)0xb8000 =3D 0" in C code of kernel doesn't
  clean first charaster of screen in Qemu in "-curses" mode! If I want
  to real clean this charaster, I must type "*(char *)0xb8000 =3D ' '".

  I attach a kernel (x86, multiboot) with this bug. Just type "make"
  (you need gcc) and "qemu -curses -kernel kernel". You will see that
  screen is not cleared, but kernel tries to clean it. If you change 0
  to ' ', all will work!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/922076/+subscriptions
