Received: from eggs.gnu.org ([209.51.188.92]:36331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ghwjp-0004A4-Rs
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:20:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ghwjn-00013o-P4
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:20:41 -0500
Received: from indium.canonical.com ([91.189.90.7]:38910)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ghwjn-00013G-Ip
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 08:20:39 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ghwjm-0006a8-Ax
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 13:20:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 506A32E8054
	for <qemu-devel@nongnu.org>; Fri, 11 Jan 2019 13:20:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Jan 2019 13:06:11 -0000
From: Kevin Wolf <1810603@bugs.launchpad.net>
Reply-To: Bug 1810603 <1810603@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
Message-Id: <154721197200.9182.11725001035057942103.malone@chaenomeles.canonical.com>
Errors-To: bounces@canonical.com
Subject: [Qemu-devel] [Bug 1810603] Re: QEMU QCow Images grow dramatically
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Regarding snapshot deletion, QEMU does punch holes into the image file
when deleting snapshots, so the space should effectively be freed, even
if this isn't visible in the file size. To get actually meaningful
numbers, you'd have to look at the allocated blocks rather than the file
size (e.g. by using 'du -h' instead of 'ls -lh').

A quick test with internal snapshots didn't show any increase of the
used space for me. So the condition to trigger the problem must be a
little more complicated than just saving, loading and deleting some
snapshots. After some random manual testing, I wrote a small script to
share the results with you:

#!/bin/bash
  =

./qemu-img create -f qcow2 /tmp/test.qcow2 64M
./qemu-io -c 'write 16M 32M' /tmp/test.qcow2
du /tmp/test.qcow2
./qemu-img snapshot -c snap0 /tmp/test.qcow2
./qemu-io -c 'write 0 32M' /tmp/test.qcow2
./qemu-img snapshot -c snap1 /tmp/test.qcow2
./qemu-io -c 'write 32M 32M' /tmp/test.qcow2
./qemu-img snapshot -a snap0 /tmp/test.qcow2
./qemu-img snapshot -d snap0 /tmp/test.qcow2
./qemu-img snapshot -d snap1 /tmp/test.qcow2
du /tmp/test.qcow2

The result of this script is that both 'du' invocations show the same
value for me, i.e. after taking two snapshots and making the image fully
allocated, reverting to the first snapshot and deleting the snapshots
gets the image back to the original 32 MB:

Formatting '/tmp/test.qcow2', fmt=3Dqcow2 size=3D67108864 cluster_size=3D65=
536 lazy_refcounts=3Doff refcount_bits=3D16
wrote 33554432/33554432 bytes at offset 16777216
32 MiB, 1 ops; 0.0088 sec (3.520 GiB/sec and 112.6380 ops/sec)
33028   /tmp/test.qcow2
wrote 33554432/33554432 bytes at offset 0
32 MiB, 1 ops; 0.0083 sec (3.739 GiB/sec and 119.6602 ops/sec)
wrote 33554432/33554432 bytes at offset 33554432
32 MiB, 1 ops; 0.0082 sec (3.785 GiB/sec and 121.1094 ops/sec)
33028   /tmp/test.qcow2

Maybe you can play a bit more with qemu-img and qemu-io and find a case
where the image grows like you see on your VM? Once we got a reproducer,
we can try and check where the growth comes from.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1810603

Title:
  QEMU QCow Images grow dramatically

Status in QEMU:
  New

Bug description:
  I've recently migrated our VM infrastructure (~200 guest on 15 hosts)
  from vbox to Qemu (using KVM / libvirt). We have a master image (QEMU
  QCow v3) from which we spawn multiple instances (linked clones). All
  guests are being revert once per hour for security reasons.

  About 2 weeks after we successfully migrated to Qemu, we noticed that
  almost all disks went full across all 15 hosts. Our investigation
  showed that the initial qcow disk images blow up from a few gigabytes
  to 100GB and more. This should not happen, as we revert all VMs back
  to the initial snapshot once per hour and hence all changes that have
  been made to disks must be reverted too.

  We did an addition test with 24 hour time frame with which we could
  reproduce this bug as documented below.

  Initial disk image size (created on Jan 04):
  -rw-r--r-- 1 root root 7.1G Jan  4 15:59 W10-TS01-0.img
  -rw-r--r-- 1 root root 7.3G Jan  4 15:59 W10-TS02-0.img
  -rw-r--r-- 1 root root 7.4G Jan  4 15:59 W10-TS03-0.img
  -rw-r--r-- 1 root root 8.3G Jan  4 16:02 W10-CLIENT01-0.img
  -rw-r--r-- 1 root root 8.6G Jan  4 16:05 W10-CLIENT02-0.img
  -rw-r--r-- 1 root root 8.0G Jan  4 16:05 W10-CLIENT03-0.img
  -rw-r--r-- 1 root root 8.3G Jan  4 16:08 W10-CLIENT04-0.img
  -rw-r--r-- 1 root root 8.1G Jan  4 16:12 W10-CLIENT05-0.img
  -rw-r--r-- 1 root root 8.0G Jan  4 16:12 W10-CLIENT06-0.img
  -rw-r--r-- 1 root root 8.1G Jan  4 16:16 W10-CLIENT07-0.img
  -rw-r--r-- 1 root root 7.6G Jan  4 16:16 W10-CLIENT08-0.img
  -rw-r--r-- 1 root root 7.6G Jan  4 16:19 W10-CLIENT09-0.img
  -rw-r--r-- 1 root root 7.5G Jan  4 16:21 W10-ROUTER-0.img
  -rw-r--r-- 1 root root  18G Jan  4 16:25 W10-MASTER-IMG.qcow2

  Disk image size after 24 hours (printed on Jan 05):
  -rw-r--r-- 1 root root  13G Jan  5 15:07 W10-TS01-0.img
  -rw-r--r-- 1 root root 8.9G Jan  5 14:20 W10-TS02-0.img
  -rw-r--r-- 1 root root 9.0G Jan  5 15:07 W10-TS03-0.img
  -rw-r--r-- 1 root root  10G Jan  5 15:08 W10-CLIENT01-0.img
  -rw-r--r-- 1 root root  11G Jan  5 15:08 W10-CLIENT02-0.img
  -rw-r--r-- 1 root root  11G Jan  5 15:08 W10-CLIENT03-0.img
  -rw-r--r-- 1 root root  11G Jan  5 15:08 W10-CLIENT04-0.img
  -rw-r--r-- 1 root root  19G Jan  5 15:07 W10-CLIENT05-0.img
  -rw-r--r-- 1 root root  14G Jan  5 15:08 W10-CLIENT06-0.img
  -rw-r--r-- 1 root root 9.7G Jan  5 15:07 W10-CLIENT07-0.img
  -rw-r--r-- 1 root root  35G Jan  5 15:08 W10-CLIENT08-0.img
  -rw-r--r-- 1 root root 9.2G Jan  5 15:07 W10-CLIENT09-0.img
  -rw-r--r-- 1 root root  41G Jan  5 15:08 W10-ROUTER-0.img
  -rw-r--r-- 1 root root  18G Jan  4 16:25 W10-MASTER-IMG.qcow2

  You can reproduce this bug as follow:
  1) create an initial disk image
  2) create a linked clone
  3) create a snapshot of the linked clone
  4) revert the snapshot every X minutes / hours

  Due the described behavior / bug, our VM farm is completely down at
  the moment (as we run out of disk space on all host systems). A quick
  fix for this bug would be much appreciated.

  Host OS: Ubuntu 18.04.01 LTS
  Kernel: 4.15.0-43-generic
  Qemu: 3.1.0
  libvirt: 4.10.0
  Guest OS: Windows 10 64bit

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1810603/+subscriptions
