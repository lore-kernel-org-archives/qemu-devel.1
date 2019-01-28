Received: from eggs.gnu.org ([209.51.188.92]:42340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1go3is-00077c-6K
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:01:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1go3ir-0006iO-0h
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:00:58 -0500
Received: from indium.canonical.com ([91.189.90.7]:54680)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1go3iq-0006gQ-QV
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 05:00:56 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1go3io-0000nT-EP
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:00:54 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 6BD132E80C9
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 10:00:54 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 28 Jan 2019 09:46:39 -0000
From: Lenny Helpline <1810603@bugs.launchpad.net>
Reply-To: Bug 1810603 <1810603@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
Message-Id: <154866879946.29740.13554399095004528872.malone@soybean.canonical.com>
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

> Looking at the file size isn't helpful. The 23 GB
> are the space that is actually used. You can use 'du -h'
> to confirm this, but I think it gets the number in the exact same way as =
qemu-img.

Are you sure about that? My OS complains that the disk is full. I can't
even start any VM anymore. That's the reason why I've opened this
ticket. Otherwise I wouldn't care....

$ df -h
Filesystem                                                Size  Used Avail =
Use% Mounted on
udev                                                       63G     0   63G =
  0% /dev
tmpfs                                                      13G  164M   13G =
  2% /run
/dev/md1                                                  455G  455G     0 =
100% /



# du -sh W10-CLIENT01-0.img
115G	 W10-CLIENT01-0.img


Vs original file size:
8GB	 W10-CLIENT01-0.img

How's that possible?


# qemu-img info W10-CLIENT01-0.img
image: W10-CLIENT01-0.img
file format: qcow2
virtual size: 320G (343597383680 bytes)
disk size: 114G
cluster_size: 65536
backing file: /var/lib/libvirt/images/W10-MASTER-IMG.qcow2
Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         1                      6.4G 2019-01-04 14:33:47   01:14:37.729
Format specific information:
    compat: 1.1
    lazy refcounts: false
    refcount bits: 16
    corrupt: false

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
