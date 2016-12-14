Received: from eggs.gnu.org ([2001:4830:134:3::10]:34665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHEvC-0006qo-QX
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:08:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHEv9-0001fk-JL
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:08:58 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:34709)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHEv9-0001cZ-Do
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 14:08:55 -0500
Received: by mail-pf0-f196.google.com with SMTP id y68so1509381pfb.1
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 11:08:32 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 15 Dec 2016 00:36:59 +0530
Message-Id: <1481742422-15969-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH 0/3] Introduce a new --only-migratable option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com
Cc: jsnow@redhat.com, amit.shah@redhat.com, pbonzini@redhat.com, kwolf@redhat.com, armbru@redhat.com, quintela@redhat.com, mst@redhat.com, marcandre.lureau@redhat.com, groug@kaod.org, aneesh.kumar@linux.vnet.ibm.com, peter.maydell@linaro.org, qemu-devel@nongnu.org, Ashijeet Acharya <ashijeetacharya@gmail.com>

This series adds a new command line option "--only-migratable" which will only
allow addition of those devices to a QEMU instance which are migratable and do
not abruptly fail QEMU after migration.

Patch 1 adds the new option "-only-migratable".

Patch 2 adds compatibility for various "device adding" options for both via
command line and hotplug methods.

Patch 3 handles the special case of devices which become unmigratable dynamically
by making call to "migrate_add_blocker". Here we fail the particular action of the
device which results in an unmigratable VM.
Eg: 9pfs fails to mount the filesystem.

Ashijeet Acharya (3):
  migration: Add a new option to enable only-migratable
  migration: Allow "device add" options to only add migratable devices
  migration: disallow migrate_add_blocker during migration

 block/qcow.c                  | 11 ++++++++++-
 block/vdi.c                   | 11 ++++++++++-
 block/vhdx.c                  | 20 ++++++++++++++------
 block/vmdk.c                  | 12 +++++++++++-
 block/vpc.c                   | 15 ++++++++++++---
 block/vvfat.c                 | 24 ++++++++++++++++--------
 hw/9pfs/9p.c                  | 22 ++++++++++++++++++----
 hw/display/virtio-gpu.c       | 35 ++++++++++++++++++++++-------------
 hw/intc/arm_gic_kvm.c         | 20 ++++++++++++++------
 hw/intc/arm_gicv3_its_kvm.c   | 21 ++++++++++++++-------
 hw/intc/arm_gicv3_kvm.c       | 22 +++++++++++++++-------
 hw/misc/ivshmem.c             | 17 +++++++++++++----
 hw/scsi/vhost-scsi.c          | 27 +++++++++++++++++++++------
 hw/usb/bus.c                  | 15 +++++++++++++++
 hw/virtio/vhost.c             | 11 ++++++++++-
 include/migration/migration.h |  9 ++++++++-
 migration/migration.c         | 42 ++++++++++++++++++++++++++++++++++++++++--
 qdev-monitor.c                |  9 +++++++++
 qemu-options.hx               | 10 ++++++++++
 stubs/migr-blocker.c          |  3 ++-
 target-i386/kvm.c             | 19 ++++++++++++++++---
 vl.c                          |  4 ++++
 22 files changed, 304 insertions(+), 75 deletions(-)

-- 
2.6.2
