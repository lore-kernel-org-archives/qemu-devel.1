Received: from eggs.gnu.org ([208.118.235.92]:37902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTxzP-0004df-NB
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 18:51:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gTxz8-0001j1-9F
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 18:50:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:53196)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gTxz6-0001Ze-7U
	for qemu-devel@nongnu.org; Mon, 03 Dec 2018 18:50:40 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gTxz2-0003bv-2c
	for <qemu-devel@nongnu.org>; Mon, 03 Dec 2018 23:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CE7E22E80CC
	for <qemu-devel@nongnu.org>; Mon,  3 Dec 2018 23:50:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 03 Dec 2018 23:37:52 -0000
From: Peter Maydell <peter.maydell@linaro.org>
Reply-To: Bug 1806114 <1806114@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154360750589.15722.2632161476309150045.malonedeb@soybean.canonical.com>
Message-Id: <154388027240.10196.224859422259204532.malone@chaenomeles.canonical.com>
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

The memfd_create() compilation failure is a bug in older QEMU versions
that was only revealed by a newer glibc version (ie old QEMU built OK
with older glibc but fails with newer glibc). It's fixed in git in
commit 75e5b70e6b5dcc4f221, so backporting that to the older versions
you're trying to build is probably the correct fix there, though it
sounds like you've sufficiently worked around it anyway.

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
