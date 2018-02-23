Received: from eggs.gnu.org ([2001:4830:134:3::10]:57004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epCyF-0005BW-UN
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:01:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1epCyA-0003aV-E3
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:01:04 -0500
Received: from indium.canonical.com ([91.189.90.7]:36506)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1epCyA-0003Z5-6e
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 08:00:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1epCy4-0007kq-UV
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 13:00:53 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 4DCC32E80E1
	for <qemu-devel@nongnu.org>; Fri, 23 Feb 2018 13:00:51 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Feb 2018 12:50:48 -0000
From: Teddy VALETTE <1751264@bugs.launchpad.net>
Reply-To: Bug 1751264 <1751264@bugs.launchpad.net>
Sender: bounces@canonical.com
Message-Id: <151939024836.30479.4933664010119224710.malonedeb@gac.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1751264] [NEW] qemu-img convert issue in a tmpfs
 partition
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

qemu-img convert command is slow when the file to convert is located in
a tmpfs formatted partition.

v2.1.0 on debian/jessie x64, ext4: 10m14s
v2.1.0 on debian/jessie x64, tmpfs: 10m15s

v2.1.0 on debian/stretch x64, ext4: 11m9s
v2.1.0 on debian/stretch x64, tmpfs: 10m21.362s

v2.8.0 on debian/jessie x64, ext4: 10m21s
v2.8.0 on debian/jessie x64, tmpfs: Too long

v2.8.0 on debian/stretch x64, ext4: 10m42s
v2.8.0 on debian/stretch x64, tmpfs: Too long

It seems that the issue is caused by this commit :
https://github.com/qemu/qemu/commit/690c7301600162421b928c7f26fd488fd8fa464e

In order to reproduce this bug :

1/ mount a tmpfs partition : mount -t tmpfs tmpfs /tmp
2/ get a vmdk file (we used a 15GB image) and put it on /tmp
3/ run the 'qemu-img convert -O qcow2 /tmp/file.vmdk /path/to/destination' =
command

When we trace the process, we can see that there's a lseek loop which is
very slow (compare to outside a tmpfs partition).

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: qemu-img

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1751264

Title:
  qemu-img convert issue in a tmpfs partition

Status in QEMU:
  New

Bug description:
  qemu-img convert command is slow when the file to convert is located
  in a tmpfs formatted partition.

  v2.1.0 on debian/jessie x64, ext4: 10m14s
  v2.1.0 on debian/jessie x64, tmpfs: 10m15s

  v2.1.0 on debian/stretch x64, ext4: 11m9s
  v2.1.0 on debian/stretch x64, tmpfs: 10m21.362s

  v2.8.0 on debian/jessie x64, ext4: 10m21s
  v2.8.0 on debian/jessie x64, tmpfs: Too long

  v2.8.0 on debian/stretch x64, ext4: 10m42s
  v2.8.0 on debian/stretch x64, tmpfs: Too long

  It seems that the issue is caused by this commit :
  https://github.com/qemu/qemu/commit/690c7301600162421b928c7f26fd488fd8fa4=
64e

  In order to reproduce this bug :

  1/ mount a tmpfs partition : mount -t tmpfs tmpfs /tmp
  2/ get a vmdk file (we used a 15GB image) and put it on /tmp
  3/ run the 'qemu-img convert -O qcow2 /tmp/file.vmdk /path/to/destination=
' command

  When we trace the process, we can see that there's a lseek loop which
  is very slow (compare to outside a tmpfs partition).

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1751264/+subscriptions
