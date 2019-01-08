Received: from eggs.gnu.org ([209.51.188.92]:36875)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggteN-00027T-9r
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:50:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1ggteL-00083o-Mh
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:50:43 -0500
Received: from indium.canonical.com ([91.189.90.7]:33174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1ggteL-0007sp-Ff
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 10:50:41 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1ggteG-0004jH-7V
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 15:50:36 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 371402E8050
	for <qemu-devel@nongnu.org>; Tue,  8 Jan 2019 15:50:36 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Jan 2019 15:41:43 -0000
From: Eric Blake <1810603@bugs.launchpad.net>
Reply-To: Bug 1810603 <1810603@bugs.launchpad.net>
Sender: bounces@canonical.com
References: <154670237006.5111.1505843603378488710.malonedeb@wampee.canonical.com>
	<154693620998.25278.657579942079364570.malone@gac.canonical.com>
Message-Id: <b7d8808a-5039-8a35-d7fa-ebddeb3e4b90@redhat.com>
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

On 1/8/19 2:30 AM, Lenny Helpline wrote:
> I don't have many commands handy, as we manage almost everything through
> libvirt manager.
> =

> 3) create a snapshot of the lined clone:
> =

> virsh snapshot-create-as --domain <VMNAME> --name "test" --halt
> =

> 4) revert the snapshot every X minutes / hours:
> =

> virsh destroy <VMNAME>
> virsh snapshot-revert --snapshotname test --running --force
> =

> Does that help?

Yes. It shows that you are taking internal snapshots, rather than
external.  Note that merely reverting to an internal snapshot does not
delete that snapshot, and also note that although qemu has code for
deleting internal snapshots, I doubt that it currently reclaims the disk
space that was previously in use by that snapshot but no longer needed.
Internal snapshots do not get much attention these days, because most of
our work is focused on external snapshots.

If you were to use external snapshots, then every time you wanted to
create a point in time that you might need to roll back to, you create a
new external snapshot, turning:

image1

into

image1 <- temp_overlay

then, at the point when you are done with the work in temp_overlay2, you
reset the domain back to using image1 and throw away the old
temp_overlay (or, recreate temp_overlay to be blank, which is the same
as going back to the state in image1); thus, the size of image1 never
grows because you are doing all work in temp_overlay, and rolling back
no longer keeps the changes that were done in a previous branch of work
the way internal snapshots are doing.

In libvirt terms, you could create an external snapshot by adding
--diskspec $disk,snapshot=3Dexternal for each $disk of your domain (virsh
domblklist can be used to get the list of valid $disk names).  But
libvirt support for reverting to external snapshots is still not
completely rounded out, so you'll have to do a bit more leg work on your
end to piece things back together.

Asking on the libvirt list may give you better insights on how best to
use libvirt to drive external snapshots to accomplish your setup of
frequently reverting to older points in time.

-- =

Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org

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
