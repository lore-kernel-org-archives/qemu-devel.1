Received: from eggs.gnu.org ([2001:4830:134:3::10]:34151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgE4-0004GV-QK
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgE0-0003pL-PY
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:16 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 26 Jan 2017 10:19:37 +0100
Message-Id: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 0/4] vITS save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org, shannon.zhao@linaro.org
Cc: christoffer.dall@linaro.org, drjones@redhat.com, vijay.kilari@gmail.com, Vijaya.Kumar@cavium.com, peterx@redhat.com, quintela@redhat.com, dgilbert@redhat.com

This series allows ITS save/restore and migration use cases.
It relies on not upstreamed kernel series ([1] & [2]) and
QEMU not upstreamed series [3].

ITS tables are flushed into guest RAM on VM stop while registers
are save on pre_save() callback. Tables and registers are restored
on ITS post_load().

The code is based on Vijaya's "GICv3 live migration support"
series [3], based on v2.8.0-rc4.

The series also uses one patch from Peter Xu that aims at allowing
the explicit ordering of save/restore handlers [4], now upstreamed.

That work was tested on Cavium ThunderX using virsh save/restore and
virt-manager live migration.

Best Regards

Eric

Host Kernel dependencies:
- [1] [RFC 00/13] vITS save/restore
  (https://www.spinics.net/lists/arm-kernel/msg553854.html)
- [2] [PATCH v10 0/8] arm/arm64: vgic: Implement API for vGICv3 live
  migration
  http://www.spinics.net/lists/arm-kernel/msg546383.html

QEMU dependencies:
- [3] [PATCH v6 0/2] GICv3 live migration support
- [4] migration: allow to prioritize save state entries

This QEMU series can be found at:
https://github.com/eauger/qemu/tree/mig-gicv3-v6-its-rfc

Eric Auger (4):
  linux-headers: Partial update for vITS save/restore
  hw/intc/arm_gicv3_kvm: Rename KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS
  hw/intc/arm_gicv3_its: Implement state save/restore
  hw/intc/arm_gicv3_its: Allow save/restore

 hw/intc/arm_gicv3_common.c             |  1 +
 hw/intc/arm_gicv3_its_common.c         | 11 +++-
 hw/intc/arm_gicv3_its_kvm.c            | 94 +++++++++++++++++++++++++++++++++-
 hw/intc/arm_gicv3_kvm.c                |  2 +-
 include/hw/intc/arm_gicv3_its_common.h |  6 +++
 include/migration/vmstate.h            |  2 +
 linux-headers/asm-arm/kvm.h            | 25 ++++++---
 linux-headers/asm-arm64/kvm.h          | 14 +++--
 8 files changed, 140 insertions(+), 15 deletions(-)

-- 
2.5.5
