Received: from eggs.gnu.org ([209.51.188.92]:56128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHi-0004dl-H1
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ghZHh-0007j5-O9
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:06 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:35700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ghZHh-0007iZ-8u
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:18:05 -0500
Received: by mail-pf1-x442.google.com with SMTP id z9so5240333pfi.2
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 04:18:04 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 10 Jan 2019 23:17:33 +1100
Message-Id: <20190110121736.23448-9-richard.henderson@linaro.org>
In-Reply-To: <20190110121736.23448-1-richard.henderson@linaro.org>
References: <20190110121736.23448-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 08/11] target/arm: Add guarded_pages cpu
 property for user-only
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

While waiting for a proper userland ABI, allow static test
cases to be written assuming that GP is set for all pages.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.h           |  4 ++++
 target/arm/cpu64.c         | 18 ++++++++++++++++++
 target/arm/translate-a64.c |  8 +++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 506c490a16..929f16dd6b 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -882,6 +882,10 @@ struct ARMCPU {
      */
     bool cfgend;
 
+#ifdef CONFIG_USER_ONLY
+    bool guarded_pages;
+#endif
+
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index d0de0d5dcf..713d2d5579 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -315,6 +315,18 @@ static void cpu_max_set_packey(Object *obj, Visitor *v, const char *name,
     }
     error_propagate(errp, err);
 }
+
+static bool aarch64_cpu_get_guarded_pages(Object *obj, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    return cpu->guarded_pages;
+}
+
+static void aarch64_cpu_set_guarded_pages(Object *obj, bool val, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    cpu->guarded_pages = val;
+}
 #endif
 
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
@@ -420,6 +432,12 @@ static void aarch64_max_initfn(Object *obj)
             cpu->env.cp15.sctlr_el[1] |= SCTLR_EnIA | SCTLR_EnIB;
             cpu->env.cp15.sctlr_el[1] |= SCTLR_EnDA | SCTLR_EnDB;
         }
+
+        object_property_add_bool(obj, "guarded_pages",
+                                 aarch64_cpu_get_guarded_pages,
+                                 aarch64_cpu_set_guarded_pages, NULL);
+        object_property_set_description(obj, "guarded_pages",
+            "Set on/off GuardPage bit for all pages", NULL);
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5f0ecb297f..f225517077 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13780,7 +13780,13 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
 static bool is_guarded_page(CPUARMState *env, DisasContext *s)
 {
 #ifdef CONFIG_USER_ONLY
-    return false;  /* FIXME */
+    /*
+     * FIXME: What is the userland ABI for this?
+     * For the moment this is controlled by an attribute:
+     *   -cpu max,guarded_pages=on.
+     */
+    ARMCPU *cpu = arm_env_get_cpu(env);
+    return cpu->guarded_pages;
 #else
     uint64_t addr = s->base.pc_first;
     int mmu_idx = arm_to_core_mmu_idx(s->mmu_idx);
-- 
2.17.2
