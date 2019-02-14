Received: from eggs.gnu.org ([209.51.188.92]:53838)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKu-0007jv-6b
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKt-0004gb-3Q
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:16 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37628)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKs-0004gA-TH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:15 -0500
Received: by mail-wr1-x441.google.com with SMTP id c8so7703693wrs.4
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:14 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.12 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:12 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:43 +0000
Message-Id: <20190214190603.25030-8-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 07/27] target/arm: expose CPUID registers to
 userspace
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alex Bennée <alex.bennee@linaro.org>

A number of CPUID registers are exposed to userspace by modern Linux
kernels thanks to the "ARM64 CPU Feature Registers" ABI. For QEMU's
user-mode emulation we don't need to emulate the kernels trap but just
return the value the trap would have done. To avoid too much #ifdef
hackery we process ARMCPRegInfo with a new helper (modify_arm_cp_regs)
before defining the registers. The modify routine is driven by a
simple data structure which describes which bits are exported and
which are fixed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20190205190224.2198-3-alex.bennee@linaro.org
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.h    | 21 ++++++++++++++++
 target/arm/helper.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index c92c097b449..7c31e5a2d10 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2464,6 +2464,27 @@ static inline void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs)
 }
 const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t encoded_cp);
 
+/*
+ * Definition of an ARM co-processor register as viewed from
+ * userspace. This is used for presenting sanitised versions of
+ * registers to userspace when emulating the Linux AArch64 CPU
+ * ID/feature ABI (advertised as HWCAP_CPUID).
+ */
+typedef struct ARMCPRegUserSpaceInfo {
+    /* Name of register */
+    const char *name;
+
+    /* Only some bits are exported to user space */
+    uint64_t exported_bits;
+
+    /* Fixed bits are applied after the mask */
+    uint64_t fixed_bits;
+} ARMCPRegUserSpaceInfo;
+
+#define REGUSERINFO_SENTINEL { .name = NULL }
+
+void modify_arm_cp_regs(ARMCPRegInfo *regs, const ARMCPRegUserSpaceInfo *mods);
+
 /* CPWriteFn that can be used to implement writes-ignored behaviour */
 void arm_cp_write_ignore(CPUARMState *env, const ARMCPRegInfo *ri,
                          uint64_t value);
diff --git a/target/arm/helper.c b/target/arm/helper.c
index 88cf4976039..b2abaf5b225 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6109,6 +6109,30 @@ void register_cp_regs_for_features(ARMCPU *cpu)
               .resetvalue = cpu->pmceid1 },
             REGINFO_SENTINEL
         };
+#ifdef CONFIG_USER_ONLY
+        ARMCPRegUserSpaceInfo v8_user_idregs[] = {
+            { .name = "ID_AA64PFR0_EL1",
+              .exported_bits = 0x000f000f00ff0000,
+              .fixed_bits    = 0x0000000000000011 },
+            { .name = "ID_AA64PFR1_EL1",
+              .exported_bits = 0x00000000000000f0 },
+            { .name = "ID_AA64ZFR0_EL1"           },
+            { .name = "ID_AA64MMFR0_EL1",
+              .fixed_bits    = 0x00000000ff000000 },
+            { .name = "ID_AA64MMFR1_EL1"          },
+            { .name = "ID_AA64DFR0_EL1",
+              .fixed_bits    = 0x0000000000000006 },
+            { .name = "ID_AA64DFR1_EL1"           },
+            { .name = "ID_AA64AFR0_EL1"           },
+            { .name = "ID_AA64AFR1_EL1"           },
+            { .name = "ID_AA64ISAR0_EL1",
+              .exported_bits = 0x00fffffff0fffff0 },
+            { .name = "ID_AA64ISAR1_EL1",
+              .exported_bits = 0x000000f0ffffffff },
+            REGUSERINFO_SENTINEL
+        };
+        modify_arm_cp_regs(v8_idregs, v8_user_idregs);
+#endif
         /* RVBAR_EL1 is only implemented if EL1 is the highest EL */
         if (!arm_feature(env, ARM_FEATURE_EL3) &&
             !arm_feature(env, ARM_FEATURE_EL2)) {
@@ -6385,6 +6409,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
             .opc1 = CP_ANY, .opc2 = CP_ANY, .access = PL1_W,
             .type = ARM_CP_NOP | ARM_CP_OVERRIDE
         };
+#ifdef CONFIG_USER_ONLY
+        ARMCPRegUserSpaceInfo id_v8_user_midr_cp_reginfo[] = {
+            { .name = "MIDR_EL1",
+              .exported_bits = 0x00000000ffffffff },
+            { .name = "REVIDR_EL1"                },
+            REGUSERINFO_SENTINEL
+        };
+        modify_arm_cp_regs(id_v8_midr_cp_reginfo, id_v8_user_midr_cp_reginfo);
+#endif
         if (arm_feature(env, ARM_FEATURE_OMAPCP) ||
             arm_feature(env, ARM_FEATURE_STRONGARM)) {
             ARMCPRegInfo *r;
@@ -6966,6 +6999,32 @@ void define_arm_cp_regs_with_opaque(ARMCPU *cpu,
     }
 }
 
+/*
+ * Modify ARMCPRegInfo for access from userspace.
+ *
+ * This is a data driven modification directed by
+ * ARMCPRegUserSpaceInfo. All registers become ARM_CP_CONST as
+ * user-space cannot alter any values and dynamic values pertaining to
+ * execution state are hidden from user space view anyway.
+ */
+void modify_arm_cp_regs(ARMCPRegInfo *regs, const ARMCPRegUserSpaceInfo *mods)
+{
+    const ARMCPRegUserSpaceInfo *m;
+    ARMCPRegInfo *r;
+
+    for (m = mods; m->name; m++) {
+        for (r = regs; r->type != ARM_CP_SENTINEL; r++) {
+            if (strcmp(r->name, m->name) == 0) {
+                r->type = ARM_CP_CONST;
+                r->access = PL0U_R;
+                r->resetvalue &= m->exported_bits;
+                r->resetvalue |= m->fixed_bits;
+                break;
+            }
+        }
+    }
+}
+
 const ARMCPRegInfo *get_arm_cp_reginfo(GHashTable *cpregs, uint32_t encoded_cp)
 {
     return g_hash_table_lookup(cpregs, &encoded_cp);
-- 
2.20.1
