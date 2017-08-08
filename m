Received: from eggs.gnu.org ([2001:4830:134:3::10]:51732)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df4Mq-00069b-C8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:16:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1df4Ml-0004cf-5c
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:16:16 -0400
Received: from indium.canonical.com ([91.189.90.7]:41302)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1df4Mk-0004cQ-VZ
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:16:11 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.76 #1 (Debian))
	id 1df4Mj-0005Zc-RZ
	for <qemu-devel@nongnu.org>; Tue, 08 Aug 2017 13:16:09 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id CE7CE2E839C
	for <qemu-devel@nongnu.org>; Tue,  8 Aug 2017 13:16:09 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Aug 2017 13:02:02 -0000
From: Thomas Huth <1223467@bugs.launchpad.net>
Reply-To: Bug 1223467 <1223467@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <20130910170043.9057.99139.malonedeb@wampee.canonical.com>
Message-Id: <150219732324.19011.17787758199788201473.launchpad@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1223467] Re: Unable to use USB as hda in Windows
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
       Status: New =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1223467

Title:
  Unable to use USB as hda in Windows

Status in QEMU:
  Fix Released

Bug description:
  I built qemu 1.6.0 from source in MinGW (and all dependents not available=
 with mingw-get) =

  The command line:
  qemu-system-i386.exe -m 1024 -hda \\.\PhysicalDrive1 -L pc-bios
  or
  qemu-system-x86_64.exe -m 1024 -hda \\.\PhysicalDrive1 -L pc-bios
  (or the *w.exe equivalents)
  reports in stderr.txt:
  qemu-system-i386.exe: -hda \\.\PhysicalDrive1: Block protocol 'host_devic=
e' doesn't support the option 'filename'
  qemu-system-i386.exe: -hda \\.\PhysicalDrive1: could not open disk image =
\\.\PhysicalDrive1: Invalid argument

  I have also found this bug in 1.5 but not in 1.4

  Some Help:
  The code in Qemu is a bit beyond me at 1am, but I was able to determine t=
he root cause seems to be that block.c is becoming confused about referring=
 to a file but not having a file name. I have been able to work around this=
 by changing line 860 of block.c from:  "if (qdict_size(options) !=3D 0) {"=
 to "if (qdict_size(options) !=3D 0 && !is_windows_drive(filename)) {"

  But I don't think this is a good solution (it is assuming that nothing
  else could be wrong), and I can't be sure that I'm not masking some
  real issue.

  FWIW; Build is on XP, but execution is on Win7.

  Thanks.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1223467/+subscriptions
