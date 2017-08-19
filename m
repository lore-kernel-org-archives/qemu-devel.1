Received: from eggs.gnu.org ([2001:4830:134:3::10]:32769)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dj5Xr-0004K4-2S
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 11:20:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1dj5Xn-00027i-Tg
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 11:20:15 -0400
Received: from indium.canonical.com ([91.189.90.7]:37325)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1dj5Xn-00026x-Hr
	for qemu-devel@nongnu.org; Sat, 19 Aug 2017 11:20:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1dj5Xl-0007Jm-Mt
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 15:20:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 91F942E80C3
	for <qemu-devel@nongnu.org>; Sat, 19 Aug 2017 15:20:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 19 Aug 2017 15:01:37 -0000
From: felix <1599539@bugs.launchpad.net>
Reply-To: Bug 1599539 <1599539@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20160706143209.31209.31307.malonedeb@chaenomeles.canonical.com>
Message-Id: <150315489805.19611.16722873966829075886.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1599539] Re: 2.6.0: vvfat driver generates bad
 FAT entries
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I believe commits f82d92bb028a1d674bab4ccc7e6cde6c04956230 and
6817efea3a0d1bf87be815970cdb014c5a64b628 have fixed this particular bug;
although I've since noticed the vvfat driver remains quite fragile,
especially FAT32 and writing support. I've got some patches for it of my
own, which I might submit someday (they aren't quite ready yet).

Also, after some testing, it turns one can simply grow the fixed-size
root directory table above 512 entries, and it doesn't seem to actually
cause any problems after all; although I haven't tested any extreme
cases or obscure implementations. Shrinking it (entry-wise) should be
fine in any case: 1440 KiB floppy disks typically allow 224 root
directory entries, which is 14 clusters =3D 14 sectors.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1599539

Title:
  2.6.0: vvfat driver generates bad FAT entries

Status in QEMU:
  New

Bug description:
  The vvfat driver sometimes generates entries about which file system
  checking utilities generate complaints.

  For example, dosfsck will complain that the volume label entry has
  non-zero size. ScanDisk from Windows 9x complains about invalid dot
  (".") and dot-dot ("..") entries in directories and also about invalid
  long file name entries. MS-DOS ScanDisk also often manages to find
  "lost clusters" on the drive.

  Tangentially: qemu-img convert fat:test test.img doesn't seem to work
  -- it generates an 504MiB of zero bytes and hangs. qemu-img map
  fat:test generates an assertion failure. Having qemu-img working might
  have helped with debugging the above issue.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1599539/+subscriptions
