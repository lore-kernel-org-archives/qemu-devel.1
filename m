Received: from eggs.gnu.org ([209.51.188.92]:59193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wTQ-0007RG-6b
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:06:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1h1wTK-0006K4-Ta
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:06:21 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:33218)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1h1wTF-0004bC-Lh
	for qemu-devel@nongnu.org; Thu, 07 Mar 2019 12:06:15 -0500
Received: by mail-pg1-x543.google.com with SMTP id h11so11749897pgl.0
	for <qemu-devel@nongnu.org>; Thu, 07 Mar 2019 09:05:03 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu,  7 Mar 2019 09:04:34 -0800
Message-Id: <20190307170440.3113-17-richard.henderson@linaro.org>
In-Reply-To: <20190307170440.3113-1-richard.henderson@linaro.org>
References: <20190307170440.3113-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v4 16/22] target/arm: Implement data cache set
 allocation tags
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

This is DC GVA and DC GZVA.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
v2: Use allocation_tag_mem + memset.
v3: Require pre-cleaned addresses.
---
 target/arm/cpu.h           |  4 +++-
 target/arm/helper-a64.h    |  1 +
 target/arm/helper.c        | 16 ++++++++++++++++
 target/arm/mte_helper.c    | 28 ++++++++++++++++++++++++++++
 target/arm/translate-a64.c |  9 +++++++++
 5 files changed, 57 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index b9b33bc285..e24d1e082c 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -2178,7 +2178,9 @@ static inline uint64_t cpreg_to_kvm_id(uint32_t cpregid)
 #define ARM_CP_NZCV              (ARM_CP_SPECIAL | 0x0300)
 #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
 #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
-#define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
+#define ARM_CP_DC_GVA            (ARM_CP_SPECIAL | 0x0600)
+#define ARM_CP_DC_GZVA           (ARM_CP_SPECIAL | 0x0700)
+#define ARM_LAST_SPECIAL         ARM_CP_DC_GZVA
 #define ARM_CP_FPU               0x1000
 #define ARM_CP_SVE               0x2000
 #define ARM_CP_NO_GDB            0x4000
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 5bcdfcf81b..ec4e7f7cf5 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -117,3 +117,4 @@ DEF_HELPER_FLAGS_3(st2g_parallel, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_2(ldgm, TCG_CALL_NO_WG, i64, env, i64)
 DEF_HELPER_FLAGS_3(stgm, TCG_CALL_NO_WG, void, env, i64, i64)
 DEF_HELPER_FLAGS_3(stzgm, TCG_CALL_NO_WG, void, env, i64, i64)
+DEF_HELPER_FLAGS_2(dc_gva, TCG_CALL_NO_RWG, void, env, i64)
diff --git a/target/arm/helper.c b/target/arm/helper.c
index a16c87d0d9..c8773a5528 100644
--- a/target/arm/helper.c
+++ b/target/arm/helper.c
@@ -5841,6 +5841,22 @@ static const ARMCPRegInfo mte_reginfo[] = {
     { .name = "CIGDVAC", .state = ARM_CP_STATE_AA64,
       .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 14, .opc2 = 5,
       .type = ARM_CP_NOP, .access = PL1_W },
+    { .name = "GVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 3,
+      .access = PL0_W, .type = ARM_CP_DC_GVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
+    { .name = "GZVA", .state = ARM_CP_STATE_AA64,
+      .opc0 = 1, .opc1 = 3, .crn = 7, .crm = 4, .opc2 = 4,
+      .access = PL0_W, .type = ARM_CP_DC_GZVA,
+#ifndef CONFIG_USER_ONLY
+      /* Avoid overhead of an access check that always passes in user-mode */
+      .accessfn = aa64_zva_access,
+#endif
+    },
     REGINFO_SENTINEL
 };
 #endif
diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
index afa4c26535..6d0f82eb99 100644
--- a/target/arm/mte_helper.c
+++ b/target/arm/mte_helper.c
@@ -473,3 +473,31 @@ void HELPER(stzgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
         }
     }
 }
+
+void HELPER(dc_gva)(CPUARMState *env, uint64_t ptr)
+{
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    size_t blocklen = 4 << cpu->dcz_blocksize;
+    int el;
+    uint64_t sctlr;
+    uint8_t *mem;
+    int rtag;
+
+    ptr = QEMU_ALIGN_DOWN(ptr, blocklen);
+
+    /* Trap if accessing an invalid page.  */
+    mem = allocation_tag_mem(env, ptr, true, GETPC());
+
+    /* No action if page does not support tags, or if access is disabled.  */
+    el = arm_current_el(env);
+    sctlr = arm_sctlr(env, el);
+    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
+        return;
+    }
+
+    rtag = allocation_tag_from_addr(ptr);
+    rtag |= rtag << 4;
+
+    assert(QEMU_IS_ALIGNED(blocklen, 2 * TAG_GRANULE));
+    memset(mem, rtag, blocklen / (2 * TAG_GRANULE));
+}
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index a02c829db2..74ef1cd9c1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1897,6 +1897,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
+    case ARM_CP_DC_GVA:
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
+        gen_helper_dc_gva(cpu_env, tcg_rt);
+        return;
+    case ARM_CP_DC_GZVA:
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
+        gen_helper_dc_zva(cpu_env, tcg_rt);
+        gen_helper_dc_gva(cpu_env, tcg_rt);
+        return;
     default:
         break;
     }
-- 
2.17.2
