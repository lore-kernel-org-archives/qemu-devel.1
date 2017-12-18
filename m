Received: from eggs.gnu.org ([2001:4830:134:3::10]:44533)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQzFW-0002p9-Am
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1eQzFT-0004pY-05
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:46 -0500
Received: from indium.canonical.com ([91.189.90.7]:57032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1eQzFS-0004p6-N7
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:30:42 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1eQzFR-0007Wc-QV
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 17:30:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id C3ED82E8056
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 17:30:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 18 Dec 2017 17:19:23 -0000
From: Robert Marklund <1738840@bugs.launchpad.net>
Reply-To: Bug 1738840 <1738840@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151361756384.17711.11632335707632949681.malonedeb@soybean.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1738840] [NEW] qemu-img convert qcow2 to raw
 fails on OS X
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Public bug reported:

I try to convert a image from qcow2 to raw and the result is a not bootable=
 image.
I dont know if it is a bug in qemu-img convert or with the image it self.

See this error report for better readability:
https://github.com/coreos/bugs/issues/1121#issuecomment-351968518

As a reply here they use 2.9.0 version of


$ qemu-img -V
qemu-img version 2.11.0
Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

$ uname -v
Darwin Kernel Version 17.2.0

$ mount ./
/dev/disk1s1 on / (apfs, local, journaled)

$  wget https://beta.release.core-
os.net/amd64-usr/current/coreos_production_openstack_image.img.bz2

$ date
Fri Dec 14 17:15:57 CET 2017

$ bunzip2 coreos_production_openstack_image.img.bz2


$ cp -a coreos_production_openstack_image.img.org coreos_production_opensta=
ck_image.img

$ shasum coreos_production_openstack_image.img.org
ae2119c6f0390dc36f247f7016923ea85de5d8e6  coreos_production_openstack_image=
.img.org

$ qemu-img convert -f qcow2 -O raw
coreos_production_openstack_image.img.org
coreos_production_openstack_image.bin

$ qemu-system-x86_64 -m 256 -nographic -hda coreos_production_openstack_ima=
ge.img -boot c
SeaBIOS (version rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org)


iPXE (http://ipxe.org) 00:03.0 C980 PCI2.10 PnP PMM+0FF915A0+0FEF15A0 C980
                                                                           =
    =



Booting from Hard Disk...
GRUB loading....
Welcome to GRUB!
....

$ qemu-system-x86_64 -m 256 -nographic -hda
coreos_production_openstack_image.bin -boot c

SeaBIOS (version rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org)


iPXE (http://ipxe.org) 00:03.0 C980 PCI2.10 PnP PMM+0FF915A0+0FEF15A0 C980
                                                                           =
    =



Booting from Hard Disk...
Boot failed: not a bootable disk
....


$ head -c 8192 coreos_production_openstack_image.bin | hexdump -C
00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |..............=
..|
*
00002000

$ qemu-img info coreos_production_openstack_image.bin
image: coreos_production_openstack_image.bin
file format: raw
virtual size: 8.5G (9116319744 bytes)
disk size: 217M

$ qemu-img info coreos_production_openstack_image.img
image: coreos_production_openstack_image.img
file format: qcow2
virtual size: 8.5G (9116319744 bytes)
disk size: 785M
cluster_size: 65536
Format specific information:
    compat: 0.10
    refcount bits: 16

The same version works on Ubuntu so it looks like its only the Mac
version or the new APFS filesystem.

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: convert mac osx qcow2 qemu-img raw

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1738840

Title:
  qemu-img convert qcow2 to raw fails on OS X

Status in QEMU:
  New

Bug description:
  I try to convert a image from qcow2 to raw and the result is a not bootab=
le image.
  I dont know if it is a bug in qemu-img convert or with the image it self.

  See this error report for better readability:
  https://github.com/coreos/bugs/issues/1121#issuecomment-351968518

  As a reply here they use 2.9.0 version of

  =

  $ qemu-img -V
  qemu-img version 2.11.0
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  $ uname -v
  Darwin Kernel Version 17.2.0

  $ mount ./
  /dev/disk1s1 on / (apfs, local, journaled)

  $  wget https://beta.release.core-
  os.net/amd64-usr/current/coreos_production_openstack_image.img.bz2

  $ date
  Fri Dec 14 17:15:57 CET 2017

  $ bunzip2 coreos_production_openstack_image.img.bz2

  =

  $ cp -a coreos_production_openstack_image.img.org coreos_production_opens=
tack_image.img

  $ shasum coreos_production_openstack_image.img.org
  ae2119c6f0390dc36f247f7016923ea85de5d8e6  coreos_production_openstack_ima=
ge.img.org

  $ qemu-img convert -f qcow2 -O raw
  coreos_production_openstack_image.img.org
  coreos_production_openstack_image.bin

  $ qemu-system-x86_64 -m 256 -nographic -hda coreos_production_openstack_i=
mage.img -boot c
  SeaBIOS (version rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org)

  =

  iPXE (http://ipxe.org) 00:03.0 C980 PCI2.10 PnP PMM+0FF915A0+0FEF15A0 C980
                                                                           =
      =


  =

  Booting from Hard Disk...
  GRUB loading....
  Welcome to GRUB!
  ....

  $ qemu-system-x86_64 -m 256 -nographic -hda
  coreos_production_openstack_image.bin -boot c

  SeaBIOS (version rel-1.11.0-0-g63451fca13-prebuilt.qemu-project.org)

  =

  iPXE (http://ipxe.org) 00:03.0 C980 PCI2.10 PnP PMM+0FF915A0+0FEF15A0 C980
                                                                           =
      =


  =

  Booting from Hard Disk...
  Boot failed: not a bootable disk
  ....

  =

  $ head -c 8192 coreos_production_openstack_image.bin | hexdump -C
  00000000  00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00  |............=
....|
  *
  00002000

  $ qemu-img info coreos_production_openstack_image.bin
  image: coreos_production_openstack_image.bin
  file format: raw
  virtual size: 8.5G (9116319744 bytes)
  disk size: 217M

  $ qemu-img info coreos_production_openstack_image.img
  image: coreos_production_openstack_image.img
  file format: qcow2
  virtual size: 8.5G (9116319744 bytes)
  disk size: 785M
  cluster_size: 65536
  Format specific information:
      compat: 0.10
      refcount bits: 16

  The same version works on Ubuntu so it looks like its only the Mac
  version or the new APFS filesystem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1738840/+subscriptions
