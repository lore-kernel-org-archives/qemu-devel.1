Received: from eggs.gnu.org ([2001:4830:134:3::10]:34135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgE3-0004FV-4z
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cWgE1-0003qf-Up
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 04:20:15 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Thu, 26 Jan 2017 10:19:38 +0100
Message-Id: <1485422381-29019-2-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
References: <1485422381-29019-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [RFC 1/4] linux-headers: Partial update for vITS
 save/restore
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

This is a partial update aiming at enhancing the KVM user
API with vITS save/restore capability. This consists in two
new groups for the ARM_VGIC_ITS KVM device, named:
KVM_DEV_ARM_VGIC_GRP_ITS_REGS, KVM_DEV_ARM_VGIC_GRP_ITS_TABLES.

Signed-off-by: Eric Auger <eric.auger@redhat.com>

---
The goal is to import KVM_DEV_ARM_VGIC_GRP_ITS_REGS. Applying
scripts/update-linux-headers.sh pulls other diffs and especially
a rename of KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS into
KVM_DEV_ARM_VGIC_CPU_SYSREGS.

Conflicts:
	linux-headers/asm-arm/kvm.h
---
 linux-headers/asm-arm/kvm.h   | 25 +++++++++++++++++++------
 linux-headers/asm-arm64/kvm.h | 14 +++++++++-----
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/linux-headers/asm-arm/kvm.h b/linux-headers/asm-arm/kvm.h
index e3dd0e1..84fdfb0 100644
--- a/linux-headers/asm-arm/kvm.h
+++ b/linux-headers/asm-arm/kvm.h
@@ -84,6 +84,15 @@ struct kvm_regs {
 #define KVM_VGIC_V2_DIST_SIZE		0x1000
 #define KVM_VGIC_V2_CPU_SIZE		0x2000
 
+/* Supported VGICv3 address types  */
+#define KVM_VGIC_V3_ADDR_TYPE_DIST	2
+#define KVM_VGIC_V3_ADDR_TYPE_REDIST	3
+#define KVM_VGIC_ITS_ADDR_TYPE		4
+
+#define KVM_VGIC_V3_DIST_SIZE		SZ_64K
+#define KVM_VGIC_V3_REDIST_SIZE		(2 * SZ_64K)
+#define KVM_VGIC_V3_ITS_SIZE		(2 * SZ_64K)
+
 #define KVM_ARM_VCPU_POWER_OFF		0 /* CPU is started in OFF state */
 #define KVM_ARM_VCPU_PSCI_0_2		1 /* CPU uses PSCI v0.2 */
 
@@ -174,20 +183,22 @@ struct kvm_arch_memory_slot {
 #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
 #define   KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT 32
 #define   KVM_DEV_ARM_VGIC_V3_MPIDR_MASK \
-                       (0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
+			(0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
 #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
 #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
 #define   KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK (0xffff)
 #define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
 #define KVM_DEV_ARM_VGIC_GRP_CTRL       4
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
-#define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
+#define KVM_DEV_ARM_VGIC_CPU_SYSREGS    6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO 7
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT 10
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS	8
+#define KVM_DEV_ARM_VGIC_GRP_ITS_TABLES	9
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
-                       (0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
-#define VGIC_LEVEL_INFO_LINE_LEVEL     0
+			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK	0x3ff
+#define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
 #define   KVM_DEV_ARM_VGIC_CTRL_INIT    0
 
@@ -213,7 +224,9 @@ struct kvm_arch_memory_slot {
  * and only here to provide source code level compatibility with older
  * userland. The highest SPI number can be set via KVM_DEV_ARM_VGIC_GRP_NR_IRQS.
  */
+#ifndef __KERNEL__
 #define KVM_ARM_IRQ_GIC_MAX		127
+#endif
 
 /* One single KVM irqchip, ie. the VGIC */
 #define KVM_NR_IRQCHIPS          1
diff --git a/linux-headers/asm-arm64/kvm.h b/linux-headers/asm-arm64/kvm.h
index 6698bdd..31e1137 100644
--- a/linux-headers/asm-arm64/kvm.h
+++ b/linux-headers/asm-arm64/kvm.h
@@ -203,19 +203,21 @@ struct kvm_arch_memory_slot {
 #define   KVM_DEV_ARM_VGIC_CPUID_MASK	(0xffULL << KVM_DEV_ARM_VGIC_CPUID_SHIFT)
 #define   KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT 32
 #define   KVM_DEV_ARM_VGIC_V3_MPIDR_MASK \
-                       (0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
+			(0xffffffffULL << KVM_DEV_ARM_VGIC_V3_MPIDR_SHIFT)
 #define   KVM_DEV_ARM_VGIC_OFFSET_SHIFT	0
 #define   KVM_DEV_ARM_VGIC_OFFSET_MASK	(0xffffffffULL << KVM_DEV_ARM_VGIC_OFFSET_SHIFT)
 #define   KVM_DEV_ARM_VGIC_SYSREG_INSTR_MASK (0xffff)
 #define KVM_DEV_ARM_VGIC_GRP_NR_IRQS	3
 #define KVM_DEV_ARM_VGIC_GRP_CTRL	4
 #define KVM_DEV_ARM_VGIC_GRP_REDIST_REGS 5
-#define KVM_DEV_ARM_VGIC_GRP_CPU_SYSREGS 6
+#define KVM_DEV_ARM_VGIC_CPU_SYSREGS    6
 #define KVM_DEV_ARM_VGIC_GRP_LEVEL_INFO 7
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT 10
+#define KVM_DEV_ARM_VGIC_GRP_ITS_REGS 8
+#define KVM_DEV_ARM_VGIC_GRP_ITS_TABLES 9
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT	10
 #define KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_MASK \
-                       (0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
-#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK 0x3ff
+			(0x3fffffULL << KVM_DEV_ARM_VGIC_LINE_LEVEL_INFO_SHIFT)
+#define KVM_DEV_ARM_VGIC_LINE_LEVEL_INTID_MASK	0x3ff
 #define VGIC_LEVEL_INFO_LINE_LEVEL	0
 
 #define   KVM_DEV_ARM_VGIC_CTRL_INIT	0
@@ -247,7 +249,9 @@ struct kvm_arch_memory_slot {
  * and only here to provide source code level compatibility with older
  * userland. The highest SPI number can be set via KVM_DEV_ARM_VGIC_GRP_NR_IRQS.
  */
+#ifndef __KERNEL__
 #define KVM_ARM_IRQ_GIC_MAX		127
+#endif
 
 /* One single KVM irqchip, ie. the VGIC */
 #define KVM_NR_IRQCHIPS          1
-- 
2.5.5
