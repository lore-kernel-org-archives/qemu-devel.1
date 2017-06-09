Received: from eggs.gnu.org ([2001:4830:134:3::10]:44829)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDX-00033k-GJ
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:52:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1dJMDW-0004tX-HV
	for qemu-devel@nongnu.org; Fri, 09 Jun 2017 11:52:55 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Fri,  9 Jun 2017 17:52:29 +0200
Message-Id: <1497023553-18411-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH v6 0/4] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com, christoffer.dall@linaro.org, zhaoshenglong@huawei.com, wei@redhat.com

This series allows ITS save/restore and migration use cases.

ITS tables are flushed into guest RAM on VM stop while registers
are save on pre_save() callback. Tables and registers are restored
on ITS post_load().

Redistributor pending tables also are flushed on VM stop, independently
on ITS tables.

That work was tested on Cavium ThunderX using virsh save/restore and
virt-manager live migration.

Best Regards

Eric

This series can be found at:
https://github.com/eauger/qemu/tree/v2.9.0-its_mig-v6

History:
v5 -> v6:
- RFC -> PATCH as the kernel associated series was pulled for 4.12
- remove linux header update patch file
- added "kvm-all: Pass an error object to kvm_device_access" to avoid
  aborting if table save fails with -EFAULT
- fix the migration_blocker message (s/vGICv3/vITS)
- use &s->ctlr directly when writing GITS_CTLR
- s->iidr reset in gicv3_its_common_reset

v4 -> v5:
- adapt to the new user API
- new patch "hw/intc/arm_gicv3_kvm: Implement pending table save"
  as the pending table save now is handled on GICV3 side.

v3 -> v4:
- oversight in v3, missed a last minute correction related to
  reg useless declaration in kvm_arm_its_pre_save

v2 -> v3:
- GITS_IIDR is now saved and restored to check ABI revision.
- get/put functions renamed into pre_save/post_load
- unmigratable = false removed
- changed the migration blocker message
- remove the extract64 round s->ctlr
- reword some comments

v1 -> v2:
- rebase on 2.9 soft release code
- handle case where migrate_add_blocker fails
- add comments along with ITS and GICv3 migration priorities

Eric Auger (4):
  kvm-all: Pass an error object to kvm_device_access
  hw/intc/arm_gicv3_its: Implement state save/restore
  hw/intc/arm_gicv3_kvm: Implement pending table save
  hw/intc/arm_gicv3_its: Allow save/restore

 hw/intc/arm_gic_kvm.c                  |   9 ++-
 hw/intc/arm_gicv3_common.c             |   1 +
 hw/intc/arm_gicv3_its_common.c         |  12 ++-
 hw/intc/arm_gicv3_its_kvm.c            | 131 +++++++++++++++++++++++++++++----
 hw/intc/arm_gicv3_kvm.c                |  48 ++++++++++--
 include/hw/intc/arm_gicv3_its_common.h |   8 ++
 include/migration/vmstate.h            |   2 +
 include/sysemu/kvm.h                   |  11 ++-
 kvm-all.c                              |  13 ++--
 9 files changed, 200 insertions(+), 35 deletions(-)

-- 
2.5.5
