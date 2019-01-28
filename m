Received: from eggs.gnu.org ([209.51.188.92]:46992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFbq-0006iZ-Dx
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:42:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1goFRP-0006HX-09
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:44 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:35289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1goFRN-0006EV-HY
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 17:31:42 -0500
Received: by mail-oi1-x241.google.com with SMTP id v6so14531168oif.2
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 14:31:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 28 Jan 2019 14:31:15 -0800
Message-Id: <20190128223118.5255-10-richard.henderson@linaro.org>
In-Reply-To: <20190128223118.5255-1-richard.henderson@linaro.org>
References: <20190128223118.5255-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v2 09/12] target/arm: Add x-guarded-pages cpu
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
v2: Renamed the property with x- prefix
---
 target/arm/cpu.h           |  4 ++++
 target/arm/cpu64.c         | 18 ++++++++++++++++++
 target/arm/translate-a64.c |  8 +++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index e18f823419..8c9eb519ef 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -895,6 +895,10 @@ struct ARMCPU {
      */
     bool cfgend;
 
+#ifdef CONFIG_USER_ONLY
+    bool guarded_pages;
+#endif
+
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index e9bc461c36..a563f7e74d 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -311,6 +311,18 @@ static void cpu_max_set_packey(Object *obj, Visitor *v, const char *name,
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
@@ -416,6 +428,12 @@ static void aarch64_max_initfn(Object *obj)
             cpu->env.cp15.sctlr_el[1] |= SCTLR_EnIA | SCTLR_EnIB;
             cpu->env.cp15.sctlr_el[1] |= SCTLR_EnDA | SCTLR_EnDB;
         }
+
+        object_property_add_bool(obj, "x-guarded-pages",
+                                 aarch64_cpu_get_guarded_pages,
+                                 aarch64_cpu_set_guarded_pages, NULL);
+        object_property_set_description(obj, "x-guarded-pages",
+            "Set on/off GuardPage bit for all pages", NULL);
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 89cc54dbed..a1adb8cde0 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13778,7 +13778,13 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
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
