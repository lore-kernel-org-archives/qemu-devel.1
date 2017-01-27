Received: from eggs.gnu.org ([2001:4830:134:3::10]:49604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX40M-0007f3-IL
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cX40K-0004gR-7r
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:42 -0500
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:35326)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cX40J-0004fG-V5
	for qemu-devel@nongnu.org; Fri, 27 Jan 2017 05:43:40 -0500
Received: by mail-wm0-x236.google.com with SMTP id r126so111092589wmr.0
	for <qemu-devel@nongnu.org>; Fri, 27 Jan 2017 02:43:39 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Fri, 27 Jan 2017 10:35:04 +0000
Message-Id: <20170127103505.18606-25-alex.bennee@linaro.org>
In-Reply-To: <20170127103505.18606-1-alex.bennee@linaro.org>
References: <20170127103505.18606-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 24/25] target-arm: ensure all cross vCPUs
 TLB flushes complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>, "open list:All patches CC here" <qemu-devel@nongnu.org>

Previously flushes on other vCPUs would only get serviced when they
exited their TranslationBlocks. While this isn't overly problematic it
violates the semantics of TLB flush from the point of view of source
vCPU.

To solve this we call the cputlb *_all_cpus() functions to do the
flushes and ask it to ensure all flushes are completed before we start
the next instruction. As this involves exiting the cpu_loop we need to
ensure the PC is saved before the tlb helper functions are called.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v8
  - fixup merge for bitmap based API
  - fixup new _synced API
---
 target/arm/helper.c | 194 +++++++++++++++++++++++-----------------------------
 1 file changed, 84 insertions(+), 110 deletions(-)

diff --git a/target/arm/helper.c b/target/arm/helper.c
index 0c6fb4add7..b3eb4d7430 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -536,41 +536,33 @@ static void tlbimvaa_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush(other_cs);
-    }
+    tlb_flush_all_cpus_synced(cs);
 }
 
 static void tlbiasid_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush(other_cs);
-    }
+    tlb_flush_all_cpus_synced(cs);
 }
 
 static void tlbimva_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_page(other_cs, value & TARGET_PAGE_MASK);
-    }
+    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
 }
 
 static void tlbimvaa_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                              uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_page(other_cs, value & TARGET_PAGE_MASK);
-    }
+    tlb_flush_page_all_cpus_synced(cs, value & TARGET_PAGE_MASK);
 }
 
 static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -585,12 +577,10 @@ static void tlbiall_nsnh_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_nsnh_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                   uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S12NSE1 |
                             ARMMMUBit_S12NSE0 | ARMMMUBit_S2NS);
-    }
 }
 
 static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -617,7 +607,7 @@ static void tlbiipas2_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
     uint64_t pageaddr;
 
     if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
@@ -626,9 +616,7 @@ static void tlbiipas2_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 40);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S2NS);
-    }
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUBit_S2NS);
 }
 
 static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -642,11 +630,9 @@ static void tlbiall_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbiall_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1E2);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S1E2);
 }
 
 static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -661,12 +647,10 @@ static void tlbimva_hyp_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbimva_hyp_is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                  uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
     uint64_t pageaddr = value & ~MAKE_64BIT_MASK(0, 12);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1E2);
-    }
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUBit_S1E2);
 }
 
 static const ARMCPRegInfo cp_reginfo[] = {
@@ -1335,14 +1319,16 @@ static const ARMCPRegInfo v7_cp_reginfo[] = {
 static const ARMCPRegInfo v7mp_cp_reginfo[] = {
     /* 32 bit TLB invalidates, Inner Shareable */
     { .name = "TLBIALLIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbiall_is_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL1_W,
+      .writefn = tlbiall_is_write },
     { .name = "TLBIMVAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_is_write },
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL1_W,
+      .writefn = tlbimva_is_write },
     { .name = "TLBIASIDIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
-      .type = ARM_CP_NO_RAW, .access = PL1_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL1_W,
       .writefn = tlbiasid_is_write },
     { .name = "TLBIMVAAIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .type = ARM_CP_NO_RAW, .access = PL1_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL1_W,
       .writefn = tlbimvaa_is_write },
     REGINFO_SENTINEL
 };
@@ -2856,8 +2842,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMState *env,
 static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    ARMCPU *cpu = arm_env_get_cpu(env);
-    CPUState *cs = CPU(cpu);
+    CPUState *cs = ENV_GET_CPU(env);
 
     if (arm_is_secure_below_el3(env)) {
         tlb_flush_by_mmuidx(cs, ARMMMUBit_S1SE1 | ARMMMUBit_S1SE0);
@@ -2869,16 +2854,15 @@ static void tlbi_aa64_vmalle1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vmalle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
+    CPUState *cs = ENV_GET_CPU(env);
     bool sec = arm_is_secure_below_el3(env);
-    CPUState *other_cs;
 
-    CPU_FOREACH(other_cs) {
-        if (sec) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1SE1 | ARMMMUBit_S1SE0);
-        } else {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
-                                ARMMMUBit_S12NSE0);
-        }
+    if (sec) {
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S1SE1
+                                     | ARMMMUBit_S1SE0);
+    } else {
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S12NSE1
+                                     | ARMMMUBit_S12NSE0);
     }
 }
 
@@ -2931,39 +2915,34 @@ static void tlbi_aa64_alle1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
      */
     bool sec = arm_is_secure_below_el3(env);
     bool has_el2 = arm_feature(env, ARM_FEATURE_EL2);
-    CPUState *other_cs;
-
-    CPU_FOREACH(other_cs) {
-        if (sec) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1SE1 | ARMMMUBit_S1SE0);
-        } else if (has_el2) {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
-                                ARMMMUBit_S12NSE0 | ARMMMUBit_S2NS);
-        } else {
-            tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S12NSE1 |
-                                ARMMMUBit_S12NSE0);
-        }
+    CPUState *cs = ENV_GET_CPU(env);
+
+    if (sec) {
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S1SE1
+                                     | ARMMMUBit_S1SE0);
+    } else if (has_el2) {
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S12NSE1
+                                     | ARMMMUBit_S12NSE0 | ARMMMUBit_S2NS);
+    } else {
+        tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S12NSE1
+                                     | ARMMMUBit_S12NSE0);
     }
 }
 
 static void tlbi_aa64_alle2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1E2);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S1E2);
 }
 
 static void tlbi_aa64_alle3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                     uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_by_mmuidx(other_cs, ARMMMUBit_S1E3);
-    }
+    tlb_flush_by_mmuidx_all_cpus_synced(cs, ARMMMUBit_S1E3);
 }
 
 static void tlbi_aa64_vae1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3018,41 +2997,38 @@ static void tlbi_aa64_vae3_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_vae1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    CPUState *cs = CPU(cpu);
     bool sec = arm_is_secure_below_el3(env);
-    CPUState *other_cs;
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    CPU_FOREACH(other_cs) {
-        if (sec) {
-            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1SE1 |
-                                     ARMMMUBit_S1SE0);
-        } else {
-            tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S12NSE1 |
-                                     ARMMMUBit_S12NSE0);
-        }
+    if (sec) {
+        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
+                                                 ARMMMUBit_S1SE1 |
+                                                 ARMMMUBit_S1SE0);
+    } else {
+        tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr,
+                                                 ARMMMUBit_S12NSE1 |
+                                                 ARMMMUBit_S12NSE0);
     }
 }
 
 static void tlbi_aa64_vae2is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1E2);
-    }
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUBit_S1E2);
 }
 
 static void tlbi_aa64_vae3is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                    uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
     uint64_t pageaddr = sextract64(value << 12, 0, 56);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S1E3);
-    }
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUBit_S1E3);
 }
 
 static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3080,7 +3056,7 @@ static void tlbi_aa64_ipas2e1_write(CPUARMState *env, const ARMCPRegInfo *ri,
 static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
                                       uint64_t value)
 {
-    CPUState *other_cs;
+    CPUState *cs = ENV_GET_CPU(env);
     uint64_t pageaddr;
 
     if (!arm_feature(env, ARM_FEATURE_EL2) || !(env->cp15.scr_el3 & SCR_NS)) {
@@ -3089,9 +3065,7 @@ static void tlbi_aa64_ipas2e1is_write(CPUARMState *env, const ARMCPRegInfo *ri,
 
     pageaddr = sextract64(value << 12, 0, 48);
 
-    CPU_FOREACH(other_cs) {
-        tlb_flush_page_by_mmuidx(other_cs, pageaddr, ARMMMUBit_S2NS);
-    }
+    tlb_flush_page_by_mmuidx_all_cpus_synced(cs, pageaddr, ARMMMUBit_S2NS);
 }
 
 static CPAccessResult aa64_zva_access(CPUARMState *env, const ARMCPRegInfo *ri,
@@ -3248,27 +3222,27 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     /* TLBI operations */
     { .name = "TLBI_VMALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_ASIDE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 2,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vmalle1is_write },
     { .name = "TLBI_VAAE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 3,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VAALE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
-      .access = PL1_W, .type = ARM_CP_NO_RAW,
+      .access = PL1_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vae1is_write },
     { .name = "TLBI_VMALLE1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 0,
@@ -3296,19 +3270,19 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae1_write },
     { .name = "TLBI_IPAS2E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_ipas2e1is_write },
     { .name = "TLBI_IPAS2LE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_ipas2e1is_write },
     { .name = "TLBI_ALLE1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_VMALLS12E1IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_alle1is_write },
     { .name = "TLBI_IPAS2E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
@@ -3324,7 +3298,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbi_aa64_alle1_write },
     { .name = "TLBI_VMALLS12E1", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 6,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_alle1is_write },
 #ifndef CONFIG_USER_ONLY
     /* 64 bit address translation operations */
@@ -3370,7 +3344,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
     { .name = "TLBIMVALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_is_write },
     { .name = "TLBIMVAALIS", .cp = 15, .opc1 = 0, .crn = 8, .crm = 3, .opc2 = 7,
-      .type = ARM_CP_NO_RAW, .access = PL1_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL1_W,
       .writefn = tlbimvaa_is_write },
     { .name = "TLBIMVAL", .cp = 15, .opc1 = 0, .crn = 8, .crm = 7, .opc2 = 5,
       .type = ARM_CP_NO_RAW, .access = PL1_W, .writefn = tlbimva_write },
@@ -3381,7 +3355,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbimva_hyp_write },
     { .name = "TLBIMVALHIS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL2_W,
       .writefn = tlbimva_hyp_is_write },
     { .name = "TLBIIPAS2",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 1,
@@ -3389,7 +3363,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbiipas2_write },
     { .name = "TLBIIPAS2IS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL2_W,
       .writefn = tlbiipas2_is_write },
     { .name = "TLBIIPAS2L",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 4, .opc2 = 5,
@@ -3397,7 +3371,7 @@ static const ARMCPRegInfo v8_cp_reginfo[] = {
       .writefn = tlbiipas2_write },
     { .name = "TLBIIPAS2LIS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 0, .opc2 = 5,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL2_W,
       .writefn = tlbiipas2_is_write },
     /* 32 bit cache operations */
     { .name = "ICIALLUIS", .cp = 15, .opc1 = 0, .crn = 7, .crm = 1, .opc2 = 0,
@@ -3737,7 +3711,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .writefn = tlbiall_nsnh_write },
     { .name = "TLBIALLNSNHIS",
       .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 4,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL2_W,
       .writefn = tlbiall_nsnh_is_write },
     { .name = "TLBIALLH", .cp = 15, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
       .type = ARM_CP_NO_RAW, .access = PL2_W,
@@ -3749,7 +3723,7 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .type = ARM_CP_NO_RAW, .access = PL2_W,
       .writefn = tlbimva_hyp_write },
     { .name = "TLBIMVAHIS", .cp = 15, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL2_W,
       .writefn = tlbimva_hyp_is_write },
     { .name = "TLBI_ALLE2", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 7, .opc2 = 0,
@@ -3765,15 +3739,15 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
       .writefn = tlbi_aa64_vae2_write },
     { .name = "TLBI_ALLE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_alle2is_write },
     { .name = "TLBI_VAE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 1,
-      .type = ARM_CP_NO_RAW, .access = PL2_W,
+      .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC, .access = PL2_W,
       .writefn = tlbi_aa64_vae2is_write },
     { .name = "TLBI_VALE2IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 4, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL2_W, .type = ARM_CP_NO_RAW,
+      .access = PL2_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vae2is_write },
 #ifndef CONFIG_USER_ONLY
     /* Unlike the other EL2-related AT operations, these must
@@ -3960,15 +3934,15 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
       .resetvalue = 0 },
     { .name = "TLBI_ALLE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 0,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_alle3is_write },
     { .name = "TLBI_VAE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 1,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vae3is_write },
     { .name = "TLBI_VALE3IS", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 3, .opc2 = 5,
-      .access = PL3_W, .type = ARM_CP_NO_RAW,
+      .access = PL3_W, .type = ARM_CP_NO_RAW | ARM_CP_EXIT_PC,
       .writefn = tlbi_aa64_vae3is_write },
     { .name = "TLBI_ALLE3", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 6, .crn = 8, .crm = 7, .opc2 = 0,
-- 
2.11.0
