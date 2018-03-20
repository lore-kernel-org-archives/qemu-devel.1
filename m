Received: from eggs.gnu.org ([2001:4830:134:3::10]:36283)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eyCfl-00015o-0w
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 04:31:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eyCfh-0007cv-28
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 04:31:09 -0400
Received: from indium.canonical.com ([91.189.90.7]:55820)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eyCfg-0007bu-Qm
	for qemu-devel@nongnu.org; Tue, 20 Mar 2018 04:31:04 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eyCfd-0007MD-Nr
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 08:31:01 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 597E22E8181
	for <qemu-devel@nongnu.org>; Tue, 20 Mar 2018 08:31:00 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Mar 2018 08:17:53 -0000
From: Alistair Buxton <a.j.buxton@gmail.com>
Reply-To: Bug 1756807 <1756807@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152144414128.31022.3971379528979064267.malonedeb@wampee.canonical.com>
Message-Id: <152153387358.12267.12306090066710580654.malone@wampee.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1756807] Re: performance regression in qemu-user
 + proot
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

I just tested the patch from
https://bugs.launchpad.net/qemu/+bug/1740219 and it fixes the problem
for me. Specifically I only tried the final patch of the series.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1756807

Title:
  performance regression in qemu-user + proot

Status in QEMU:
  New
Status in qemu package in Ubuntu:
  New

Bug description:
  To reproduce:

  1. Install qemu-user-static and proot
  2. Enter some arm chroot using them:

      proot -0 -q qemu-arm-static -w / -r chroot/ /bin/bash

  3. Run a command which normally takes a short but measurable amount of
  time:

      cd /usr/share/doc && time grep -R hello

  Result:

  This is over 100 times slower on 18.04 than it was on 16.04. I am not
  sure if proot or qemu is causing the problem, but proot version has
  not changed. Also note that on 16.04 I am using the cloud repo version
  of qemu, which is newer than 16.04 stock, but still older than 18.04.

  Although system 2 is lower spec than system 1, it should not be this
  much slower. No other software seems to be affected.

  If required I can supply a chroot tarball. It is essentially just a
  Debian bootstrap though.

  Logs:


  System 1: i7-6700 3.4GHz, 32GB RAM, 512GB Crucial MX100 SSD, Ubuntu 16.04
  qemu-arm version 2.10.1(Debian 1:2.10+dfsg-0ubuntu3.4~cloud0)
  proot 5.1.0

  al@al-desktop:~/rpi-ramdisk/raspbian$ proot -0 -q qemu-arm-static -w / -r=
 root/ /bin/bash
  root@al-desktop:/# cd /usr/share/doc
  root@al-desktop:/usr/share/doc# time grep -R hello
  dash/copyright:Debian GNU/Linux hello source package as the file COPYING.=
  If not,

  real	0m0.066s
  user	0m0.040s
  sys	0m0.008s



  System 2: i5-5300U 2.30GHz, 8GB RAM, 256GB Crucial MX300 SSD, Ubuntu 18.04
  qemu-arm version 2.11.1(Debian 1:2.11+dfsg-1ubuntu4)
  proot 5.1.0

  al@al-thinkpad:~/rpi-ramdisk/raspbian$ proot -0 -q qemu-arm-static -w / -=
r root/ /bin/bash
  root@al-thinkpad:/# cd /usr/share/doc
  root@al-thinkpad:/usr/share/doc# time grep -R hello
  dash/copyright:Debian GNU/Linux hello source package as the file COPYING.=
  If not,

  real	0m24.176s
  user	0m0.366s
  sys	0m11.352s

  ProblemType: Bug
  DistroRelease: Ubuntu 18.04
  Package: qemu (not installed)
  ProcVersionSignature: Ubuntu 4.15.0-12.13-generic 4.15.7
  Uname: Linux 4.15.0-12-generic x86_64
  ApportVersion: 2.20.8-0ubuntu10
  Architecture: amd64
  Date: Mon Mar 19 07:13:25 2018
  InstallationDate: Installed on 2018-03-18 (0 days ago)
  InstallationMedia: Xubuntu 18.04 LTS "Bionic Beaver" - Alpha amd64 (20180=
318)
  SourcePackage: qemu
  UpgradeStatus: No upgrade log present (probably fresh install)

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1756807/+subscriptions
