Received: from eggs.gnu.org ([209.51.188.92]:51245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqeC2-0000pZ-4E
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gqe3P-0002bM-C5
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:12:52 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:33833)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gqe3P-00025a-2Y
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:12:51 -0500
Received: by mail-wm1-x341.google.com with SMTP id y185so10057755wmd.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 05:12:39 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon,  4 Feb 2019 13:12:26 +0000
Message-Id: <20190204131228.25949-3-richard.henderson@linaro.org>
In-Reply-To: <20190204131228.25949-1-richard.henderson@linaro.org>
References: <20190204131228.25949-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 2/4] target/arm: Add x-guarded-pages cpu
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
 target/arm/cpu64.c         | 20 ++++++++++++++++++++
 target/arm/translate-a64.c |  8 +++++++-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.h b/target/arm/cpu.h
index 1ff7197efd..366ab97db3 100644
--- a/target/arm/cpu.h
+++ b/target/arm/cpu.h
@@ -900,6 +900,10 @@ struct ARMCPU {
      */
     bool cfgend;
 
+#ifdef CONFIG_USER_ONLY
+    bool guarded_pages;
+#endif
+
     QLIST_HEAD(, ARMELChangeHook) pre_el_change_hooks;
     QLIST_HEAD(, ARMELChangeHook) el_change_hooks;
 
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index eff0f164dd..c5675fe7d1 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -281,6 +281,20 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
     error_propagate(errp, err);
 }
 
+#ifdef CONFIG_USER_ONLY
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
+#endif
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -360,6 +374,12 @@ static void aarch64_max_initfn(Object *obj)
          */
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
+
+        object_property_add_bool(obj, "x-guarded-pages",
+                                 aarch64_cpu_get_guarded_pages,
+                                 aarch64_cpu_set_guarded_pages, NULL);
+        object_property_set_description(obj, "x-guarded-pages",
+            "Set on/off GuardPage bit for all pages", NULL);
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 7375ebf7a9..37077138e3 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -13817,7 +13817,13 @@ static void disas_data_proc_simd_fp(DisasContext *s, uint32_t insn)
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
