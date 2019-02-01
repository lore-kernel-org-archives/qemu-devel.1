Received: from eggs.gnu.org ([209.51.188.92]:59019)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMD-0008Gp-SC
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMA-0003iy-Kf
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:57 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:38172)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMA-0003dh-8r
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:54 -0500
Received: by mail-wm1-x32b.google.com with SMTP id m22so6782427wml.3
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:46 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.43
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:44 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:45 +0000
Message-Id: <20190201160653.13829-40-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 39/47] target/arm: Always enable pac keys for
 user-only
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Drop the pac properties.  This approach cannot work as written
because the properties are applied before arm_cpu_reset, which
zeros SCTLR_EL1 (amongst everything else).

We can re-introduce the properties if they turn out to be useful.
But since linux 5.0 enables all of the keys, they may not be.

Fixes: 1ae9cfbd470
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c   |  3 +++
 target/arm/cpu64.c | 60 ----------------------------------------------
 2 files changed, 3 insertions(+), 60 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index f00d450d0bd..3874dc98754 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -185,6 +185,9 @@ static void arm_cpu_reset(CPUState *s)
         env->pstate = PSTATE_MODE_EL0t;
         /* Userspace expects access to DC ZVA, CTL_EL0 and the cache ops */
         env->cp15.sctlr_el[1] |= SCTLR_UCT | SCTLR_UCI | SCTLR_DZE;
+        /* Enable all PAC keys.  */
+        env->cp15.sctlr_el[1] |= (SCTLR_EnIA | SCTLR_EnIB |
+                                  SCTLR_EnDA | SCTLR_EnDB);
         /* Enable all PAC instructions */
         env->cp15.hcr_el2 |= HCR_API;
         env->cp15.scr_el3 |= SCR_API;
diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 8653cecd032..7107ec8d7eb 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -281,38 +281,6 @@ static void cpu_max_set_sve_vq(Object *obj, Visitor *v, const char *name,
     error_propagate(errp, err);
 }
 
-#ifdef CONFIG_USER_ONLY
-static void cpu_max_get_packey(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-    const uint64_t *bit = opaque;
-    bool enabled = (cpu->env.cp15.sctlr_el[1] & *bit) != 0;
-
-    visit_type_bool(v, name, &enabled, errp);
-}
-
-static void cpu_max_set_packey(Object *obj, Visitor *v, const char *name,
-                               void *opaque, Error **errp)
-{
-    ARMCPU *cpu = ARM_CPU(obj);
-    Error *err = NULL;
-    const uint64_t *bit = opaque;
-    bool enabled;
-
-    visit_type_bool(v, name, &enabled, errp);
-
-    if (!err) {
-        if (enabled) {
-            cpu->env.cp15.sctlr_el[1] |= *bit;
-        } else {
-            cpu->env.cp15.sctlr_el[1] &= ~*bit;
-        }
-    }
-    error_propagate(errp, err);
-}
-#endif
-
 /* -cpu max: if KVM is enabled, like -cpu host (best possible with this host);
  * otherwise, a CPU with as many features enabled as our emulation supports.
  * The version of '-cpu max' for qemu-system-arm is defined in cpu.c;
@@ -388,34 +356,6 @@ static void aarch64_max_initfn(Object *obj)
          */
         cpu->ctr = 0x80038003; /* 32 byte I and D cacheline size, VIPT icache */
         cpu->dcz_blocksize = 7; /*  512 bytes */
-
-        /*
-         * Note that Linux will enable enable all of the keys at once.
-         * But doing it this way will allow experimentation beyond that.
-         */
-        {
-            static const uint64_t apia_bit = SCTLR_EnIA;
-            static const uint64_t apib_bit = SCTLR_EnIB;
-            static const uint64_t apda_bit = SCTLR_EnDA;
-            static const uint64_t apdb_bit = SCTLR_EnDB;
-
-            object_property_add(obj, "apia", "bool", cpu_max_get_packey,
-                                cpu_max_set_packey, NULL,
-                                (void *)&apia_bit, &error_fatal);
-            object_property_add(obj, "apib", "bool", cpu_max_get_packey,
-                                cpu_max_set_packey, NULL,
-                                (void *)&apib_bit, &error_fatal);
-            object_property_add(obj, "apda", "bool", cpu_max_get_packey,
-                                cpu_max_set_packey, NULL,
-                                (void *)&apda_bit, &error_fatal);
-            object_property_add(obj, "apdb", "bool", cpu_max_get_packey,
-                                cpu_max_set_packey, NULL,
-                                (void *)&apdb_bit, &error_fatal);
-
-            /* Enable all PAC keys by default.  */
-            cpu->env.cp15.sctlr_el[1] |= SCTLR_EnIA | SCTLR_EnIB;
-            cpu->env.cp15.sctlr_el[1] |= SCTLR_EnDA | SCTLR_EnDB;
-        }
 #endif
 
         cpu->sve_max_vq = ARM_MAX_VQ;
-- 
2.20.1
