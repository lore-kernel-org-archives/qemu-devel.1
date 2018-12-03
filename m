Received: from eggs.gnu.org ([2001:4830:134:3::10]:47517)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTwob-0005sR-To
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:35:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTwoW-00081Y-LG
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:35:44 -0500
Received: from indium.canonical.com ([91.189.90.7]:60886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gTwoW-0007wz-9w
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 17:35:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gTwoU-0000Xx-Mb
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 22:35:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 95D292E80CB
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 22:35:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Dec 2018 22:24:03 -0000
From: Jacek Wieczorek <mrjjot@gmail.com>
Reply-To: Bug 1806114 <1806114@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154360750589.15722.2632161476309150045.malonedeb@soybean.canonical.com>
Message-Id: <154387584375.15484.3305409784363122007.malone@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1806114] Re: Reading sectors from floppy with
 BIOS INT 13h is broken
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Alright, I managed to compile 2.5.0, 2.5.1 and 2.6.0 by simply making
memfd_create() non-static.

It turns out that 2.6.0 is the first version causing problems. I tested
each of these with the provided SeaBIOS version and with SeaBIOS
rel-1.7.4-0-g96917a8.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1806114

Title:
  Reading sectors from floppy with BIOS INT 13h is broken

Status in QEMU:
  New

Bug description:
  I'm developing a game bootable from a floppy disk, written in i386
  assembly. I found out it doesn't work on newer QEMU versions. I
  managed to isolate the issue and it seems that there's a problem with
  handling of BIOS interrupt 13h when it comes to reading disk sectors
  (AH=3D02).

  I've written a simple test in assembly. It simply accesses four
  different floppy disk sectors and prints out the strings they contain.
  The problem is, the two latter strings don't show up at all nor the
  BIOS interrupt returns an error (CF set). I've attached the code to
  this bug report. I use following commands to compile it and run:

  $ nasm disk-test.asm -o disk-test.bin
  $ qemu-system-i386 -boot a -fda disk-test.bin

  After running, the expected output is:

      I am a test string from boot sector
      C:H:S 0:0:2 - Hello
      C:H:S 0:0:3 - there!
      C:H:S 0:1:4 - In QEMU you can't
      C:H:S 1:0:5 - see these two lines! :(

  while the actual output is:

      I am a test string from boot sector
      C:H:S 0:0:2 - Hello
      C:H:S 0:0:3 - there!

  =

  So far, I found this problem in the current QEMU version for Ubuntu 18.04=
 (Debian 1:2.11+dfsg-1ubuntu7.8), as well as in the 3.1.0-rc3 and 2.12.1 ve=
rsions, available on the www.qemu.org website. Thus, the issue doesn't seem=
 to be very recent.

  To be sure, I ran the program on my other machine with older QEMU
  version (Debian 2.0.0+dfsg-2ubuntu1.43) and on my RaspberryPi 2
  (Debian 1.1.2+dfsg-6+deb7u25) and everything works as expected there.
  It also works well in VirtualBox.

  I hope these information are useful to you, however, I feel like this
  bug may be more related to Seabios. If so, please let me know and I
  will report it somewhere else.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1806114/+subscriptions
