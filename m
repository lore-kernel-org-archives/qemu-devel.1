Received: from eggs.gnu.org ([2001:4830:134:3::10]:36770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRhgM-0000qd-3o
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:52:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cRhgI-0001Lv-6u
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:52:54 -0500
Received: from mail-pf0-x242.google.com ([2607:f8b0:400e:c00::242]:33384)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cRhgI-0001LP-1F
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 10:52:50 -0500
Received: by mail-pf0-x242.google.com with SMTP id 127so4067259pfg.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 07:52:49 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Thu, 12 Jan 2017 21:22:30 +0530
Message-Id: <1484236354-9640-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v5 0/4] Introduce a new --only-migratable option
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
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg01277.html
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg00320.html
http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg02391.html
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

Patch 4 handles the special case of devices which become unmigratable
dynamically by making call to "migrate_add_blocker". Here we fail the
migration blocker if --only-migratable was specified.
Eg: 9pfs fails to mount the filesystem.

Note: I have not been able to test and compile the ARM drivers for KVM. They
are:
hw/intc/arm_gic_kvm.c
hw/intc/arm_gicv3_its_kvm.c
hw/intc/arm_gicv3_kvm.c

Changes in v5:
-drop =0 for global variable (Dave)
-print error message if klass=NULL (Dave)
-deal with migration blocker before pdu_marshal (Greg)
-call migrate_add_blocker before kvm_create_device (Dave)
-fix typo in subject line for 4/4 (Eric)
-fix error_free in migrate_add_blocker (Dave)
-make migrate_add_blocker to deal with error messages itself (Peter, Greg, Dave)

Changes in v4:
- drop diff in 9pfs for patch 4/4
- call clunk_fid() after freeing migration_blocker
- drop ret and use err directly

Changes in v3:
- set s->root_fid after migrate_add_blocker
- free migration_blocker inside v9fs_attach()
- change back ret<0 to just ret
- free local_err

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
  migration: Fail migration blocker for --only-migratable

 block/qcow.c                  |  7 ++++++-
 block/vdi.c                   |  7 ++++++-
 block/vhdx.c                  | 16 +++++++++------
 block/vmdk.c                  |  8 +++++++-
 block/vpc.c                   | 10 +++++++---
 block/vvfat.c                 | 20 +++++++++++--------
 hw/9pfs/9p.c                  | 31 ++++++++++++++++++-----------
 hw/display/virtio-gpu.c       | 31 +++++++++++++++++------------
 hw/intc/arm_gic_kvm.c         | 16 +++++++++------
 hw/intc/arm_gicv3_its_kvm.c   | 19 +++++++++++-------
 hw/intc/arm_gicv3_kvm.c       | 18 ++++++++++-------
 hw/misc/ivshmem.c             | 13 ++++++++----
 hw/scsi/vhost-scsi.c          | 24 ++++++++++++++++------
 hw/usb/bus.c                  | 19 ++++++++++++++++++
 hw/virtio/vhost.c             |  7 ++++++-
 include/migration/migration.h | 10 +++++++++-
 migration/migration.c         | 46 +++++++++++++++++++++++++++++++++++++++++--
 qdev-monitor.c                |  9 +++++++++
 qemu-options.hx               |  9 +++++++++
 stubs/migr-blocker.c          |  3 ++-
 target-i386/kvm.c             | 15 +++++++++++---
 vl.c                          |  4 ++++
 22 files changed, 260 insertions(+), 82 deletions(-)

-- 
2.6.2
