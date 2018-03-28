Received: from eggs.gnu.org ([2001:4830:134:3::10]:59802)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f17Kx-0003B1-6q
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:25:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1f17Kt-0003vn-Ic
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:25:43 -0400
Received: from indium.canonical.com ([91.189.90.7]:43070)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1f17Kt-0003vR-CS
	for qemu-devel@nongnu.org; Wed, 28 Mar 2018 05:25:39 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1f17Ks-0004O1-G5
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:25:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 78BB12E80C7
	for <qemu-devel@nongnu.org>; Wed, 28 Mar 2018 09:25:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Mar 2018 09:16:54 -0000
From: Zixuan Wang <1759522@bugs.launchpad.net>
Reply-To: Bug 1759522 <1759522@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <152222836105.21062.2375148895134658603.malonedeb@chaenomeles.canonical.com>
Message-Id: <152222861440.30094.16349430702104236964.malone@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1759522] Re: windows qemu-img create vpc/vhdx
 error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Also, `force_size` suboption of `vpc` doesn't work on win version of
qemu-img.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1759522

Title:
  windows qemu-img create vpc/vhdx error

Status in QEMU:
  New

Bug description:
  On windows, using qemu-img (version 2.11.90) to create vpc/vhdx
  virtual disk tends to fail. Here's the way to reproduce:

  1. Install qemu-w64-setup-20180321.exe

  2. Use `qemu-img create -f vhdx -o subformat=3Dfixed disk.vhdx 512M` to c=
reate a vhdx:
     Formatting 'disk.vhdx', fmt=3Dvhdx size=3D536870912 log_size=3D1048576=
 block_size=3D0 subformat=3Dfixed

  3. Execute `qemu-img info disk.vhdx` gives the result, (note the `disk si=
ze` is incorrect):
     image: disk.vhdx
     file format: vhdx
     virtual size: 512M (536870912 bytes)
     disk size: 1.4M
     cluster_size: 8388608

  4. On Windows 10 (V1709), double click disk.vhdx gives an error:
     Make sure the file is in an NTFS volume and isn't in a compressed fold=
er or volume.

     Using Disk Management -> Action -> Attach VHD gives an error:
     The requested operation could not be completed due to a virtual disk s=
ystem limitation. Virtual hard disk files must be uncompressed and uneccryp=
ted and must not be sparse.

  Comparison with Windows 10 created VHDX:

  1. Using Disk Management -> Action -> Create VHD:
     File name: win.vhdx
     Virtual hard disk size: 512MB
     Virtual hard disk format: VHDX
     Virtual hard disk type: Fixed size

  2. Detach VHDX

  3. Execute `qemu-img info win.vhdx` gives the result:
     image: win.vhdx
     file format: vhdx
     virtual size: 512M (536870912 bytes)
     disk size: 516M
     cluster_size: 33554432

  Comparison with qemu-img under Ubuntu:

  1. Version: qemu-img version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.16),
  Copyright (c) 2004-2008 Fabrice Bellard

  2. qemu-img create -f vhdx -o subformat=3Dfixed lin.vhdx 512M
     Formatting 'lin.vhdx', fmt=3Dvhdx size=3D536870912 log_size=3D1048576 =
block_size=3D0 subformat=3Dfixed

  3. qemu-img info lin.vhdx
     image: lin.vhdx
     file format: vhdx
     virtual size: 512M (536870912 bytes)
     disk size: 520M
     cluster_size: 8388608

  4. Load lin.vhdx under Windows 10 is ok

  The same thing happens on `vpc` format with or without
  `oformat=3Dfixed`, it seems that windows version of qemu-img has some
  incorrect operation? My guess is that windows version of qemu-img
  doesn't handle the description field of vpc/vhdx, which leads to an
  incorrect `disk size` field.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1759522/+subscriptions
