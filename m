Received: from eggs.gnu.org ([209.51.188.92]:52957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zc-0007p4-8f
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zZ-0004Hq-Qq
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:47 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39986)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gr5zZ-00043T-Ir
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:45 -0500
Received: by mail-wm1-x344.google.com with SMTP id q21so38671wmc.5
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:02:27 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Feb 2019 19:02:20 +0000
Message-Id: <20190205190224.2198-3-alex.bennee@linaro.org>
In-Reply-To: <20190205190224.2198-1-alex.bennee@linaro.org>
References: <20190205190224.2198-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 2/6] target/arm: expose CPUID registers to
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
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

A number of CPUID registers are exposed to userspace by modern Linux
kernels thanks to the "ARM64 CPU Feature Registers" ABI. For QEMU's
user-mode emulation we don't need to emulate the kernels trap but just
return the value the trap would have done. To avoid too much #ifdef
hackery we process ARMCPRegInfo with a new helper (modify_arm_cp_regs)
before defining the registers. The modify routine is driven by a
simple data structure which describes which bits are exported and
which are fixed.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v4
  - tweak commit message
  - use PL0U_R instead of PL1U_R to be less confusing
  - more CONFIG_USER logic for special cases
  - mask a bunch of bits for some registers
v5
  - use data driven modify_arm_cp_regs
---
 target/arm/cpu.h    | 21 ++++++++++++++++
 target/arm/helper.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 80 insertions(+)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1616632dcb..354df22102 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2449,6 +2449,27 @@ static inline void define_one_arm_cp_reg(ARMCPU *cpu, const ARMCPRegInfo *regs)
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
index 5857c0ba96..f90754cc11 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -6103,6 +6103,30 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -6379,6 +6403,15 @@ void register_cp_regs_for_features(ARMCPU *cpu)
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
@@ -6960,6 +6993,32 @@ void define_arm_cp_regs_with_opaque(ARMCPU *cpu,
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
