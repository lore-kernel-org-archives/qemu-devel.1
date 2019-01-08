Received: from eggs.gnu.org ([209.51.188.92]:53207)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzvf-0000rS-JJ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:33:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzve-0005UP-I0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:59 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:44814)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzve-0005Og-BJ
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:58 -0500
Received: by mail-pg1-x543.google.com with SMTP id t13so2346827pgr.11
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:55 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:28 +1000
Message-Id: <20190108223129.5570-31-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 30/31] target/arm: Enable PAuth for user-only
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

Add 4 attributes that controls the EL1 enable bits, as we may not
always want to turn on pointer authentication with -cpu max.
However, by default they are enabled.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu.c   |  3 +++
 target/arm/cpu64.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 4c4e9e169e..14bc24a35a 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -162,6 +162,9 @@ static void arm_cpu_reset(CPUState *s)
         env->pstate = PSTATE_MODE_EL0t;
         /* Userspace expects access to DC ZVA, CTL_EL0 and the cache ops */
         env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
+        /* Enable all PAC instructions */
+        env->cp15.hcr_el2 |= HCR_API;
+        env->cp15.scr_el3 |= SCR_API;
         /* and to the FP/Neon instructions */
         env->cp15.cpacr_el1 = deposit64(env->cp15.cpacr_el1, 20, 2, 3);
         /* and to the SVE instructions */
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 1974f1aeb7..d0de0d5dcf 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -285,6 +285,38 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
     error_propagate(errp, err);
 }
 
+#ifdef CONFIG_USER_ONLY
+static void cpu_max_get_packey(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    const uint64_t *bit = opaque;
+    bool enabled = (cpu->env.cp15.sctlr_el[1] & *bit) != 0;
+
+    visit_type_bool(v, name, &enabled, errp);
+}
+
+static void cpu_max_set_packey(Object *obj, Visitor *v, const char *name,
+                               void *opaque, Error **errp)
+{
+    ARMCPU *cpu = ARM_CPU(obj);
+    Error *err = NULL;
+    const uint64_t *bit = opaque;
+    bool enabled;
+
+    visit_type_bool(v, name, &enabled, errp);
+
+    if (!err) {
+        if (enabled) {
+            cpu->env.cp15.sctlr_el[1] |= *bit;
+        } else {
+            cpu->env.cp15.sctlr_el[1] &= ~*bit;
+        }
+    }
+    error_propagate(errp, err);
+}
+#endif
+
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -360,6 +392,34 @@ static void aarch64_max_initfn(Object *obj)
          */
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
+
+        /*
+         * Note that Linux will enable enable all of the keys at once.
+         * But doing it this way will allow experimentation beyond that.
+         */
+        {
+            static const uint64_t apia_bit = SCTLR_EnIA;
+            static const uint64_t apib_bit = SCTLR_EnIB;
+            static const uint64_t apda_bit = SCTLR_EnDA;
+            static const uint64_t apdb_bit = SCTLR_EnDB;
+
+            object_property_add(obj, "apia", "bool", cpu_max_get_packey,
+                                cpu_max_set_packey, NULL,
+                                (void *)&apia_bit, &error_fatal);
+            object_property_add(obj, "apib", "bool", cpu_max_get_packey,
+                                cpu_max_set_packey, NULL,
+                                (void *)&apib_bit, &error_fatal);
+            object_property_add(obj, "apda", "bool", cpu_max_get_packey,
+                                cpu_max_set_packey, NULL,
+                                (void *)&apda_bit, &error_fatal);
+            object_property_add(obj, "apdb", "bool", cpu_max_get_packey,
+                                cpu_max_set_packey, NULL,
+                                (void *)&apdb_bit, &error_fatal);
+
+            /* Enable all PAC keys by default.  */
+            cpu->env.cp15.sctlr_el[1] |= SCTLR_EnIA | SCTLR_EnIB;
+            cpu->env.cp15.sctlr_el[1] |= SCTLR_EnDA | SCTLR_EnDB;
+        }
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
-- 
2.17.2
