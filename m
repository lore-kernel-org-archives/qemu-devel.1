Received: from eggs.gnu.org ([2001:4830:134:3::10]:51360)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eekk7-0003e9-3k
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eekk3-0004s9-Ok
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:15 -0500
Received: from indium.canonical.com ([91.189.90.7]:44242)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eekk3-0004rR-Gr
	for qemu-devel@nongnu.org; Thu, 25 Jan 2018 11:51:11 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eekk1-00039u-7X
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 16:51:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 36DC72E8557
	for <qemu-devel@nongnu.org>; Thu, 25 Jan 2018 16:51:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jan 2018 16:37:14 -0000
From: John Arbuckle <programmingkidx@gmail.com>
Reply-To: Bug 1737194 <1737194@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <151274735709.11243.12332071284435970530.malonedeb@soybean.canonical.com>
	<151686682161.4861.8851702267220024380.malone@wampee.canonical.com>
Message-Id: <A6E37FF7-FB5F-4263-8BB0-8E1CCF2A3691@gmail.com>
Errors-To: bounces@canonical.com
Subject: Re: [Qemu-devel] [Bug 1737194] Re: Windows NT 4.0 fails to boot
 from qcow2 installation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

> # WinNT 4 Terminal Server
> =

> Most of the time, NTLDR will fire up normally. But every so often...
> =

>   SeaBIOS (version rel-1.7.3-117-g31b8b4e-20131206_080705-nilsson.home.kr=
axel.org)
> =

>   Booting from Hard Disk...
>   A disk read error occurred.
>   Insert a system diskette and restart
>   the system.
> =

> (NB. You're seeing the old SeaBIOS version included with e689f7c, which w=
as the first buggy commit.)
> =

> If NT gets past this point without erroring out (ie, it makes it to the b=
oot menu), the rest of the system is 100% fine and there are no other disk =
I/O issues whatsoever. For example, on QEMU 2.9.0 I was able to enable disk=
 compression, answer "Yes" to "Compress entire disk now?" and have the proc=
ess fully complete. No hitches.
> =


I tried adding -M isapc to my Windows NT 4.0 VM's arguments and I saw
the same error message at first. Then I tried it again by making a few
changes. I played with the network card settings and removed the "-M
isapc" argument to make things work again. Then I went back and added
the "-M isapc" option again and Windows booted. I restarted several
times and didn't see the error message. I am using qemu-system-i386
version 2.10.1. Just to see if I could see any of the disk errors you
saw I ran in the command prompt "chkdsk c:" a couple of times. It came
back with no errors every time.

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
