Received: from eggs.gnu.org ([2001:4830:134:3::10]:41684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cYawg-0002VM-Rk
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vijay.kilari@gmail.com>) id 1cYawf-0005SW-LV
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 11:06:14 -0500
From: vijay.kilari@gmail.com
Date: Tue, 31 Jan 2017 21:35:45 +0530
Message-Id: <1485878749-5641-1-git-send-email-vijay.kilari@gmail.com>
Subject: [Qemu-devel] [PATCH v7 0/4] GICv3 live migration support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, peter.maydell@linaro.org, christoffer.dall@linaro.org, eric.auger@redhat.com
Cc: p.fedin@samsung.com, marc.zyngier@arm.com, qemu-devel@nongnu.org, Vijaya Kumar K <Vijaya.Kumar@cavium.com>

From: Vijaya Kumar K <Vijaya.Kumar@cavium.com>

This series introduces support for GICv3 live migration with
new VGIC implementation in 4.7-rc3 kernel.
In this series, patch 1 of the previous implementation
are ported.
https://lists.nongnu.org/archive/html/qemu-devel/2015-10/msg05284.html

Patch 2, is based on below implementation.
http://patchwork.ozlabs.org/patch/626746/

Latest kernel patches
https://www.spinics.net/lists/arm-kernel/msg558046.html

This API definition is as per version of VGICv3 specification
in linux kernel Documentation/virtual/kvm/devices/arm-vgic-v3.txt

Tested Live migration of Idle VM running with 4 VCPUs and 8GB RAM.

v6 => v7:
 - Added patch to add icc_ctrl_el1 to vmstruct before live migration
   patch
 - Added patch to add gicv3state variable to CPUARMState struct to
   store GICv3CPUState pointer.
 - Added patch to register ARMCPRegInfo[] struct and reset on CPU reset.

v5 => v6:
 - Added separate patch for Reseting ICC* register
 - Added seperate patch for save and restore of ICC_CTLR_EL1
 - Dropped translate_fn mechanism and coded open functions
   for edge_trigger and priority save and restore.
 - Save and Restore APnR registers based on ICC_CTLR_EL1.PRIBITS

v4 => v5:
 - Initialized ICC registers before reset.

v3 => v4:
 - Reintroduced offset GICR_SGI_OFFSET
 - Implement save and restore of ICC_SRE_EL1
 - Updated kvm.h header file in sync with KVM v4 patches

v2 => v3:
 - Dropped offset GICR_SGI_OFFSET
 - Implement save/restore of irq line level using
   KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO
 - Fixed bug with save/restore of edge_trigger

Vijaya Kumar K (4):
  hw/intc/arm_gicv3_kvm: Add ICC_SRE_EL1 register to vmstate
  hw/intc/arm_gicv3_kvm: Implement get/put functions
  target-arm: Add GICv3CPUState in CPUARMState struct
  hw/intc/arm_gicv3_kvm: Reset GICv3 cpu interface registers

 hw/intc/arm_gicv3_common.c         |   1 +
 hw/intc/arm_gicv3_kvm.c            | 640 ++++++++++++++++++++++++++++++++++++-
 hw/intc/gicv3_internal.h           |   1 +
 include/hw/intc/arm_gicv3_common.h |   1 +
 target-arm/cpu.h                   |   2 +
 5 files changed, 634 insertions(+), 11 deletions(-)

-- 
1.9.1
