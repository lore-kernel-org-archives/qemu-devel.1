Received: from eggs.gnu.org ([2001:4830:134:3::10]:51257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHpDb-0005Z9-5p
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:54:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cHpDU-00035N-7q
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:54:23 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:34551)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cHpDT-00033P-UW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 04:54:16 -0500
Received: by mail-pg0-x241.google.com with SMTP id e9so9254113pgc.1
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 01:54:14 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Fri, 16 Dec 2016 15:23:40 +0530
Message-Id: <1481882024-10016-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v2 0/4] Introduce a new --only-migratable option
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

Previously posted series patches:
http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg02062.html

This series adds a new command line option "--only-migratable" which will only
allow addition of those devices to a QEMU instance which are migratable and do
not abruptly fail QEMU after migration.

Patch 1 adds the new option "-only-migratable".

Patch 2 adds compatibility for various "device adding" options for both via
command line and hotplug methods.

Patch 3 helps to fail the migration blocker if the migration is already in
progress and thus cannot be blocked.
Note: This patch was originally written by John Snow and I have only made few
changes.

Patch 4 handles the special case of devices which become unmigratable dynamically
by making call to "migrate_add_blocker". Here we fail the particular action of the
device which results in an unmigratable VM.
Eg: 9pfs fails to mount the filesystem.

Note: I have not been able to test and compile the ARM drivers for KVM. They are;
hw/intc/arm_gic_kvm.c
hw/intc/arm_gicv3_its_kvm.c
hw/intc/arm_gicv3_kvm.c

Changes in v2:
- change the documentation for the new option
- add a NULL check for ObjectClass
- break patch 3 into patch 3 and 4
- use error_append_hint
- return -EACCES for only-migratable
- fix the error messages

Ashijeet Acharya (4):
  migration: Add a new option to enable only-migratable
  migration: Allow "device add" options to only add migratable devices
  migration: disallow migrate_add_blocker during migration
  migration: Fail migration blocker for --only-migratble

 block/qcow.c                  |  9 ++++++++-
 block/vdi.c                   |  9 ++++++++-
 block/vhdx.c                  | 18 ++++++++++++------
 block/vmdk.c                  | 10 +++++++++-
 block/vpc.c                   | 13 ++++++++++---
 block/vvfat.c                 | 22 ++++++++++++++--------
 hw/9pfs/9p.c                  | 21 +++++++++++++++++----
 hw/display/virtio-gpu.c       | 34 +++++++++++++++++++++-------------
 hw/intc/arm_gic_kvm.c         | 19 +++++++++++++------
 hw/intc/arm_gicv3_its_kvm.c   | 21 ++++++++++++++-------
 hw/intc/arm_gicv3_kvm.c       | 22 +++++++++++++++-------
 hw/misc/ivshmem.c             | 17 +++++++++++++----
 hw/scsi/vhost-scsi.c          | 27 +++++++++++++++++++++------
 hw/usb/bus.c                  | 18 ++++++++++++++++++
 hw/virtio/vhost.c             | 10 +++++++++-
 include/migration/migration.h |  9 ++++++++-
 migration/migration.c         | 42 ++++++++++++++++++++++++++++++++++++++++--
 qdev-monitor.c                |  9 +++++++++
 qemu-options.hx               |  9 +++++++++
 stubs/migr-blocker.c          |  3 ++-
 target-i386/kvm.c             | 19 ++++++++++++++++---
 vl.c                          |  4 ++++
 22 files changed, 290 insertions(+), 75 deletions(-)

-- 
2.6.2
