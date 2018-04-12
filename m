Received: from eggs.gnu.org ([2001:4830:134:3::10]:58298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6fI7-00046Q-9f
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f6fI6-00018z-77
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 12:41:43 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Thu, 12 Apr 2018 18:40:18 +0200
Message-Id: <1523551221-11612-2-git-send-email-imammedo@redhat.com>
In-Reply-To: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 1/4] arm: reuse
 arm_boot_address_space() in armv7m_load_kernel()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com

reduce code duplication by resusing arm_boot_address_space()

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/arm/arm.h |  2 ++
 hw/arm/armv7m.c      | 10 +---------
 hw/arm/boot.c        | 16 ++++++++--------
 3 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/include/hw/arm/arm.h b/include/hw/arm/arm.h
index ce769bd..188d18b 100644
--- a/include/hw/arm/arm.h
+++ b/include/hw/arm/arm.h
@@ -143,6 +143,8 @@ struct arm_boot_info {
  */
 void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info);
 
+AddressSpace *arm_boot_address_space(ARMCPU *cpu, bool secure_boot);
+
 /* Write a secure board setup routine with a dummy handler for SMCs */
 void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
                                             const struct arm_boot_info *info,
diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
index f123cc7..d372d9c 100644
--- a/hw/arm/armv7m.c
+++ b/hw/arm/armv7m.c
@@ -289,8 +289,6 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
     uint64_t lowaddr;
     int big_endian;
     AddressSpace *as;
-    int asidx;
-    CPUState *cs = CPU(cpu);
 
 #ifdef TARGET_WORDS_BIGENDIAN
     big_endian = 1;
@@ -303,13 +301,7 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
         exit(1);
     }
 
-    if (arm_feature(&cpu->env, ARM_FEATURE_EL3)) {
-        asidx = ARMASIdx_S;
-    } else {
-        asidx = ARMASIdx_NS;
-    }
-    as = cpu_get_address_space(cs, asidx);
-
+    as = arm_boot_address_space(cpu, true);
     if (kernel_filename) {
         image_size = load_elf_as(kernel_filename, NULL, NULL, &entry, &lowaddr,
                                  NULL, big_endian, EM_ARM, 1, 0, as);
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 26184bc..2f464ca 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -36,8 +36,7 @@
 #define ARM64_TEXT_OFFSET_OFFSET    8
 #define ARM64_MAGIC_OFFSET          56
 
-static AddressSpace *arm_boot_address_space(ARMCPU *cpu,
-                                            const struct arm_boot_info *info)
+AddressSpace *arm_boot_address_space(ARMCPU *cpu, bool secure_boot)
 {
     /* Return the address space to use for bootloader reads and writes.
      * We prefer the secure address space if the CPU has it and we're
@@ -46,7 +45,7 @@ static AddressSpace *arm_boot_address_space(ARMCPU *cpu,
     int asidx;
     CPUState *cs = CPU(cpu);
 
-    if (arm_feature(&cpu->env, ARM_FEATURE_EL3) && info->secure_boot) {
+    if (arm_feature(&cpu->env, ARM_FEATURE_EL3) && secure_boot) {
         asidx = ARMASIdx_S;
     } else {
         asidx = ARMASIdx_NS;
@@ -193,7 +192,7 @@ static void default_write_secondary(ARMCPU *cpu,
                                     const struct arm_boot_info *info)
 {
     uint32_t fixupcontext[FIXUP_MAX];
-    AddressSpace *as = arm_boot_address_space(cpu, info);
+    AddressSpace *as = arm_boot_address_space(cpu, info->secure_boot);
 
     fixupcontext[FIXUP_GIC_CPU_IF] = info->gic_cpu_if_addr;
     fixupcontext[FIXUP_BOOTREG] = info->smp_bootreg_addr;
@@ -211,7 +210,7 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
                                             const struct arm_boot_info *info,
                                             hwaddr mvbar_addr)
 {
-    AddressSpace *as = arm_boot_address_space(cpu, info);
+    AddressSpace *as = arm_boot_address_space(cpu, info->secure_boot);
     int n;
     uint32_t mvbar_blob[] = {
         /* mvbar_addr: secure monitor vectors
@@ -262,7 +261,7 @@ void arm_write_secure_board_setup_dummy_smc(ARMCPU *cpu,
 static void default_reset_secondary(ARMCPU *cpu,
                                     const struct arm_boot_info *info)
 {
-    AddressSpace *as = arm_boot_address_space(cpu, info);
+    AddressSpace *as = arm_boot_address_space(cpu, info->secure_boot);
     CPUState *cs = CPU(cpu);
 
     address_space_stl_notdirty(as, info->smp_bootreg_addr,
@@ -753,7 +752,8 @@ static void do_cpu_reset(void *opaque)
             }
 
             if (cs == first_cpu) {
-                AddressSpace *as = arm_boot_address_space(cpu, info);
+                AddressSpace *as =
+                    arm_boot_address_space(cpu, info->secure_boot);
 
                 cpu_set_pc(cs, info->loader_start);
 
@@ -950,7 +950,7 @@ static void arm_load_kernel_notify(Notifier *notifier, void *data)
     ARMCPU *cpu = n->cpu;
     struct arm_boot_info *info =
         container_of(n, struct arm_boot_info, load_kernel_notifier);
-    AddressSpace *as = arm_boot_address_space(cpu, info);
+    AddressSpace *as = arm_boot_address_space(cpu, info->secure_boot);
 
     /* The board code is not supposed to set secure_board_setup unless
      * running its code in secure mode is actually possible, and KVM
-- 
2.7.4
