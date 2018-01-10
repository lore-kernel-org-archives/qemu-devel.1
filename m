Received: from eggs.gnu.org ([2001:4830:134:3::10]:42811)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOQc-0002pB-3q
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eZOQZ-0001H3-TJ
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:39072)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eZOQZ-0001G4-2v
	for qemu-devel@nongnu.org; Wed, 10 Jan 2018 17:00:55 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eZOQY-0004TH-3x
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 1C3D42E80CB
	for <qemu-devel@nongnu.org>; Wed, 10 Jan 2018 22:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jan 2018 21:43:22 -0000
From: Thomas Huth <1122492@bugs.launchpad.net>
Reply-To: Bug 1122492 <1122492@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130211224141.1853.40494.malonedeb@gac.canonical.com>
Message-Id: <151562060288.23877.1808325209666880083.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1122492] Re: qemu and grub2 rescue floppy don't
 get along
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Triaging old bug tickets... can you still reproduce this issue with the
latest version of QEMU? Or could we close this ticket nowadays?

** Changed in: qemu
       Status: New =3D> Incomplete

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1122492

Title:
  qemu and grub2 rescue floppy don't get along

Status in QEMU:
  Incomplete

Bug description:
  With qemu.git as of Feb 11 2013:

  # grub2-mkrescue -o test.img
  # ./x86_64-softmmu/qemu-system-x86_64 -fda test.img -curses

  SeaBIOS (version ?-20130206_051134-ccnode4)

  iPXE v1.0.0-591-g7aee315
  iPXE (http://ipxe.org) 00:03.0 C900 PCI2.10 PnP PMM+07FC7EC0+07F87EC0 C900

  =

  Booting from Hard Disk...
  Boot failed: could not read the boot disk

  Booting from Floppy...
  GRUB loading....
  Welcome to GRUB!

  error: attempt to read or write outside of disk `fd0'.
  Entering rescue mode...
  grub rescue> =


  =

  Expected results: grub header and a normal usable grub prompt like 'grub>'

  =

  This was originally reported against qemu 0.15 in Fedora 16 at:

  https://bugzilla.redhat.com/show_bug.cgi?id=3D784537

  Some more info from that bug:

  0) The images that grub2-mkrescue creates are odd mixtures of ISO images =
and disk images:
      file -r -k test.img
      test.img: # ISO 9660 CD-ROM filesystem data 'ISOIMAGE                =
        ' (bootable)
      - x86 boot sector; partition 1: ID=3D0xcd, active, starthead 0, start=
sector 1, 4455 sectors, code offset 0x63 DOS executable (COM), boot code

  1) The test image I use has a 2281472 byte size. If I append that with
  zeroes to 2880 KB (2949120 bytes) then I get the expected results. So
  there's a workaround. But I don't think it's an obvious workaround.

  2) It's debatable whether this is a bug. If it's considered a bug, I'm
  not sure whether qemu and/or grub2 is to blame. Should qemu (silently)
  handle (floppy) disk image between 1440 KB and 2880 KB as if they
  actually were 2880 KB in size? Or should grub2, if possible, zero pad
  the images it creates to (in this case) a 2880 KB size?

  3) Please note that there seems to be little one can do to leave "grub re=
scue" mode. Ie, "insmod normal" will fail too:
      grub rescue> insmod normal
      error: attempt to read or write outside of disk `fd0'.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1122492/+subscriptions
