Received: from eggs.gnu.org ([2001:4830:134:3::10]:44727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cT5W0-0008CS-6E
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:31:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ashijeetacharya@gmail.com>) id 1cT5Vw-0002Zl-Tv
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:31:56 -0500
Received: from mail-pg0-x241.google.com ([2607:f8b0:400e:c05::241]:35839)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <ashijeetacharya@gmail.com>)
	id 1cT5Vw-0002Zg-O4
	for qemu-devel@nongnu.org; Mon, 16 Jan 2017 06:31:52 -0500
Received: by mail-pg0-x241.google.com with SMTP id 204so5213875pge.2
	for <qemu-devel@nongnu.org>; Mon, 16 Jan 2017 03:31:52 -0800 (PST)
From: Ashijeet Acharya <ashijeetacharya@gmail.com>
Date: Mon, 16 Jan 2017 17:01:49 +0530
Message-Id: <1484566314-3987-1-git-send-email-ashijeetacharya@gmail.com>
Subject: [Qemu-devel] [PATCH v6 0/5] Introduce a new --only-migratable option
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
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg02324.html
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg01277.html
http://lists.nongnu.org/archive/html/qemu-devel/2017-01/msg00320.html
http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg02391.html
http://lists.nongnu.org/archive/html/qemu-devel/2016-12/msg02062.html

This series adds a new command line option "--only-migratable" which will only
allow addition of those devices to a QEMU instance which are migratable and do
not abruptly fail QEMU after migration.

Patch 1 is a preparatory patch to remove an undesirable comment and make patchew
happy.

Patch 2 adds the new option "-only-migratable".

Patch 3 adds compatibility for various "device adding" options for both via
command line and hotplug methods.

Patch 4 helps to fail the migration blocker if the migration is already in
progress and thus cannot be blocked.
Note: This patch was originally written by John Snow and I have only made few
changes.

Patch 5 handles the special case of devices which become unmigratable
dynamically by making call to "migrate_add_blocker". Here we fail the
migration blocker if --only-migratable was specified.
Eg: 9pfs fails to mount the filesystem.

Note: I have not been able to test and compile the ARM drivers for KVM. They
are:
hw/intc/arm_gic_kvm.c
hw/intc/arm_gicv3_its_kvm.c
hw/intc/arm_gicv3_kvm.c

Changes in v6:
-make Error *local_err = NULL at some places
-free reason at call sites
-rebase
-pass error_copy(reason) in error_propagate()

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

Ashijeet Acharya (5):
  block/vvfat: Remove the undesirable comment
  migration: Add a new option to enable only-migratable
  migration: Allow "device add" options to only add migratable devices
  migration: disallow migrate_add_blocker during migration
  migration: Fail migration blocker for --only-migratable

 block/qcow.c                  |  8 +++++++-
 block/vdi.c                   |  8 +++++++-
 block/vhdx.c                  | 17 +++++++++++------
 block/vmdk.c                  |  9 ++++++++-
 block/vpc.c                   | 11 ++++++++---
 block/vvfat.c                 | 20 ++++++++++++--------
 hw/9pfs/9p.c                  | 33 +++++++++++++++++++++-----------
 hw/display/virtio-gpu.c       | 32 ++++++++++++++++++-------------
 hw/intc/arm_gic_kvm.c         | 17 +++++++++++------
 hw/intc/arm_gicv3_its_kvm.c   | 20 +++++++++++++-------
 hw/intc/arm_gicv3_kvm.c       | 19 ++++++++++++-------
 hw/misc/ivshmem.c             | 14 ++++++++++----
 hw/scsi/vhost-scsi.c          | 25 ++++++++++++++++++------
 hw/usb/bus.c                  | 19 +++++++++++++++++++
 hw/virtio/vhost.c             |  8 +++++++-
 include/migration/migration.h | 10 +++++++++-
 migration/migration.c         | 44 +++++++++++++++++++++++++++++++++++++++++--
 qdev-monitor.c                |  9 +++++++++
 qemu-options.hx               |  9 +++++++++
 stubs/migr-blocker.c          |  3 ++-
 target/i386/kvm.c             | 16 +++++++++++++---
 vl.c                          |  4 ++++
 22 files changed, 273 insertions(+), 82 deletions(-)

-- 
2.6.2
