Received: from eggs.gnu.org ([2001:4830:134:3::10]:44241)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1csutp-0001AM-PN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1csuto-0005oT-R8
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 13:27:17 -0400
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 28 Mar 2017 19:26:55 +0200
Message-Id: <1490722018-13322-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC v4 0/3] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, drjones@redhat.com, christoffer.dall@linaro.org, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com

This series allows ITS save/restore and migration use cases.
It relies on not upstreamed kernel series [1].

ITS tables are flushed into guest RAM on VM stop while registers
are save on pre_save() callback. Tables and registers are restored
on ITS post_load().

That work was tested on Cavium ThunderX using virsh save/restore and
virt-manager live migration.

Best Regards

Eric

Host Kernel dependencies:
- [1] [PATCH v4 00/22] vITS save/restore

History:
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


Eric Auger (3):
  linux-headers: Partial header update for vITS save/restore
  hw/intc/arm_gicv3_its: Implement state save/restore
  hw/intc/arm_gicv3_its: Allow save/restore

 hw/intc/arm_gicv3_common.c             |   1 +
 hw/intc/arm_gicv3_its_common.c         |  11 ++-
 hw/intc/arm_gicv3_its_kvm.c            | 119 +++++++++++++++++++++++++++++----
 include/hw/intc/arm_gicv3_its_common.h |   8 +++
 include/migration/vmstate.h            |   2 +
 linux-headers/asm-arm/kvm.h            |   2 +
 linux-headers/asm-arm64/kvm.h          |   2 +
 7 files changed, 132 insertions(+), 13 deletions(-)

-- 
2.5.5
