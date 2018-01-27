Received: from eggs.gnu.org ([2001:4830:134:3::10]:50576)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1efEco-0001qq-Em
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 19:45:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1efEcl-0006Oh-4T
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 19:45:42 -0500
Received: from indium.canonical.com ([91.189.90.7]:47440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1efEck-0006Ne-Tw
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 19:45:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1efEcj-0004Xd-JA
	for <qemu-devel@nongnu.org>; Sat, 27 Jan 2018 00:45:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 8E7152E8551
	for <qemu-devel@nongnu.org>; Sat, 27 Jan 2018 00:45:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jan 2018 00:39:08 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1737194 <1737194@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
	<151697829435.7573.12786947158980567417.malone@soybean.canonical.com>
	<A7EAECCF-80AF-4075-845E-420018361DD8@gmail.com>
Message-Id: <42430D14-86E9-4F5F-AE59-DCEA2E89B84F@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1737194] Windows NT 4.0 fails to boot from
 qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I have installed Windows 95 OSR 2.5 in QEMU using the qcow2 format. So
far there hasn't been any major problems that prevent Windows from
booting.

I downloaded the ISO file from here:
https://winworldpc.com/product/windows-95/osr-3

Used this floppy boot image to boot QEMU: https://winworldpc.com/product
/microsoft-windows-boot-disk/95-osr2x

Created the hard drive image file like this: qemu-img create -f qcow2
~/windows95.qcow2 2G

I used my Windows XP VM to format this qcow2 file to the FAT format.

My first attempt to boot the hard drive image file failed probably
because the CPU was set to something Windows 95 couldn't handle
properly. Changing the cpu to a pentium removed the booting problem.

This is the command-line I used to boot Windows 95:
qemu-system-i386 -hda windows95.qcow2 -boot c -netdev user,id=3Dmynet0 -dev=
ice ne2k_isa,netdev=3Dmynet0 -soundhw sb16 -m 32 -cpu pentium -vga cirrus -=
localtime =


The version of QEMU I used is today's git version (commit
e607bbee553cfe73072870cef458cfa4e78133e2).

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1737194

Title:
  Windows NT 4.0 fails to boot from qcow2 installation

Status in QEMU:
  New

Bug description:
  Windows NT 4.0 will not boot from an installation more than once if
  installed in a qcow2 image file. A quick fix to this problem is to use
  the qcow format instead.

  Steps to reproduce this issue:

  Create the image file:
  qemu-img create -f qcow2 winnt4.qcow2 1G

  Boot from a Windows NT 4.0 Workstation CD:
  qemu-system-i386 -hda winnt4.qcow2 -cdrom /dev/cdrom -boot d -m 128 -cpu =
pentium -vga cirrus

  During the installation process you have the choise between FAT and
  NTFS. You can pick anyone.

  After finishing the installation the guest will reboot to install
  additional items. Once this is done the guest will be bootable. Eject
  any CD media from QEMU and reboot. You will then see Windows NT 4.0
  booting up to the desktop. Go to "Start->Shut down" to shut down. Then
  when Windows is ready quit QEMU.

  Now try to boot using this command:
  qemu-system-i386 -hda winnt4.qcow2 -boot c -m 128 -cpu pentium -vga cirru=
s =

   =

  The BIOS screen will display an error message:

  For NTFS: =

  Booting from Hard Disk...
  A disk read error occurred.
  Insert a system diskette and restart
  the system.

  For FAT:
  No bootable device.

  Additional information:
  qemu-system-i386 version: 2.10.1
  qemu-img version: 2.10.92 (v2.11.0-rc4-dirty)

  If you don't have a Windows NT 4.0 Workstation installation CD, you may d=
ownload one from here:
  https://winworldpc.com/product/windows-nt-40/40

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1737194/+subscriptions
