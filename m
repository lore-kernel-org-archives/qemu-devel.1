Received: from eggs.gnu.org ([209.51.188.92]:33746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkS7n-00057E-Jc
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1gkS7l-0007W0-Ld
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:15:47 -0500
Received: from indium.canonical.com ([91.189.90.7]:47646)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1gkS7l-0007T7-Ed
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 06:15:45 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1gkS7h-0005qg-BI
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 11:15:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 3833F2E80CB
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 11:15:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Jan 2019 11:01:38 -0000
From: Lenny Helpline <1810603@bugs.launchpad.net>
Reply-To: Bug 1810603 <1810603@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
Message-Id: <154780929811.1643.739833226437221236.malone@gac.canonical.com>
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

We have played a bit around with external snapshots (as suggested by
Eric Blake in post #3), however, it appears that external snapshots are
not fully supported yet. While I can create external snapshots, I'm
unable to revert to them using virt-manager (which we use for managing
our VM farm):

Error running snapshot 'test': unsupported configuration: revert to
external snapshot not supported yet

Traceback (most recent call last):
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 89, in cb_wr=
apper
    callback(asyncjob, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/asyncjob.py", line 125, in tmpcb
    callback(*args, **kwargs)
  File "/usr/share/virt-manager/virtManager/libvirtobject.py", line 82, in =
newfn
    ret =3D fn(self, *args, **kwargs)
  File "/usr/share/virt-manager/virtManager/domain.py", line 1225, in rever=
t_to_snapshot
    self._backend.revertToSnapshot(snap.get_backend())
  File "/usr/lib/python2.7/dist-packages/libvirt.py", line 1945, in revertT=
oSnapshot
    if ret =3D=3D -1: raise libvirtError ('virDomainRevertToSnapshot() fail=
ed', dom=3Dself)
libvirtError: unsupported configuration: revert to external snapshot not su=
pported yet

.... which means that using external snapshots is not an option for us.

Kevin Wolf, over which time period did you run the VMs? Have you made
any kind of i/o intensive stuff in the guest itself? e.g. user logon /
logoff, serving the web, installing updates

We continue to have big problems with the described issue, here's
another example (23GB Vs. 41GB on disk):

# ls -lah
-rw-r--r-- 1 root root  41G Jan 18 10:57 W10-ROUTER-0.img

# qemu-img info W10-ROUTER-0.img
image: W10-ROUTER-0.img
file format: qcow2
virtual size: 320G (343597383680 bytes)
disk size: 23G
cluster_size: 65536
backing file: /var/lib/libvirt/images/W10-MASTER-IMG.qcow2
Snapshot list:
ID        TAG                 VM SIZE                DATE       VM CLOCK
1         1                      6.0G 2019-01-04 14:51:49   01:09:32.118
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
