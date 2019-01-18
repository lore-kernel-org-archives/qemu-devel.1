Received: from eggs.gnu.org ([209.51.188.92]:43141)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbZ-0002pM-4e
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gkVbT-0007Od-DY
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:45 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d]:44103)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gkVbR-00078r-Vi
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 09:58:39 -0500
Received: by mail-wr1-x42d.google.com with SMTP id z5so15374933wrt.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 06:58:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	e27sm92094561wra.67.2019.01.18.06.58.16 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
	Fri, 18 Jan 2019 06:58:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Jan 2019 14:57:25 +0000
Message-Id: <20190118145805.6852-10-peter.maydell@linaro.org>
In-Reply-To: <20190118145805.6852-1-peter.maydell@linaro.org>
References: <20190118145805.6852-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 09/49] target/arm: Add PAuth helpers
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

The cryptographic internals are stubbed out for now,
but the enable and trap bits are checked.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 20190108223129.5570-6-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/Makefile.objs  |   1 +
 target/arm/helper-a64.h   |  12 +++
 target/arm/internals.h    |   6 ++
 target/arm/pauth_helper.c | 186 ++++++++++++++++++++++++++++++++++++++
 4 files changed, 205 insertions(+)
 create mode 100644 target/arm/pauth_helper.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 11c7baf8a31..1a4fc06448d 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -8,6 +8,7 @@ obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += neon_helper.o iwmmxt_helper.o vec_helper.o
 obj-y += gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
+obj-$(TARGET_AARCH64) += pauth_helper.o
 obj-y += crypto_helper.o
 obj-$(CONFIG_SOFTMMU) += arm-powerctl.o
 
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 9d3a9070497..28aa0af69dd 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -85,3 +85,15 @@ DEF_HELPER_2(advsimd_rinth, f16, f16, ptr)
 DEF_HELPER_2(advsimd_f16tosinth, i32, f16, ptr)
 DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
 DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
+
+DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacda, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacdb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(pacga, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autia, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autib, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autda, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_3(autdb, TCG_CALL_NO_WG, i64, env, i64, i64)
+DEF_HELPER_FLAGS_2(xpaci, TCG_CALL_NO_RWG_SE, i64, env, i64)
+DEF_HELPER_FLAGS_2(xpacd, TCG_CALL_NO_RWG_SE, i64, env, i64)
diff --git a/target/arm/internals.h b/target/arm/internals.h
index c01a3f8c968..0ed20c03cc8 100644
--- a/target/arm/internals.h
+++ b/target/arm/internals.h
@@ -266,6 +266,7 @@ enum arm_exception_class {
     EC_CP14DTTRAP             = 0x06,
     EC_ADVSIMDFPACCESSTRAP    = 0x07,
     EC_FPIDTRAP               = 0x08,
+    EC_PACTRAP                = 0x09,
     EC_CP14RRTTRAP            = 0x0c,
     EC_ILLEGALSTATE           = 0x0e,
     EC_AA32_SVC               = 0x11,
@@ -433,6 +434,11 @@ static inline uint32_t syn_sve_access_trap(void)
     return EC_SVEACCESSTRAP << ARM_EL_EC_SHIFT;
 }
 
+static inline uint32_t syn_pactrap(void)
+{
+    return EC_PACTRAP << ARM_EL_EC_SHIFT;
+}
+
 static inline uint32_t syn_insn_abort(int same_el, int ea, int s1ptw, int fsc)
 {
     return (EC_INSNABORT << ARM_EL_EC_SHIFT) | (same_el << ARM_EL_EC_SHIFT)
diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
new file mode 100644
index 00000000000..902f68a24cc
--- /dev/null
+++ b/target/arm/pauth_helper.c
@@ -0,0 +1,186 @@
+/*
+ * ARM v8.3-PAuth Operations
+ *
+ * Copyright (c) 2019 Linaro, Ltd.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#include "qemu/osdep.h"
+#include "cpu.h"
+#include "internals.h"
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
+
+
+static uint64_t pauth_computepac(uint64_t data, uint64_t modifier,
+                                 ARMPACKey key)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static uint64_t pauth_addpac(CPUARMState *env, uint64_t ptr, uint64_t modifier,
+                             ARMPACKey *key, bool data)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static uint64_t pauth_auth(CPUARMState *env, uint64_t ptr, uint64_t modifier,
+                           ARMPACKey *key, bool data, int keynumber)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static uint64_t pauth_strip(CPUARMState *env, uint64_t ptr, bool data)
+{
+    g_assert_not_reached(); /* FIXME */
+}
+
+static void QEMU_NORETURN pauth_trap(CPUARMState *env, int target_el,
+                                     uintptr_t ra)
+{
+    raise_exception_ra(env, EXCP_UDEF, syn_pactrap(), target_el, ra);
+}
+
+static void pauth_check_trap(CPUARMState *env, int el, uintptr_t ra)
+{
+    if (el < 2 && arm_feature(env, ARM_FEATURE_EL2)) {
+        uint64_t hcr = arm_hcr_el2_eff(env);
+        bool trap = !(hcr & HCR_API);
+        /* FIXME: ARMv8.1-VHE: trap only applies to EL1&0 regime.  */
+        /* FIXME: ARMv8.3-NV: HCR_NV trap takes precedence for ERETA[AB].  */
+        if (trap) {
+            pauth_trap(env, 2, ra);
+        }
+    }
+    if (el < 3 && arm_feature(env, ARM_FEATURE_EL3)) {
+        if (!(env->cp15.scr_el3 & SCR_API)) {
+            pauth_trap(env, 3, ra);
+        }
+    }
+}
+
+static bool pauth_key_enabled(CPUARMState *env, int el, uint32_t bit)
+{
+    uint32_t sctlr;
+    if (el == 0) {
+        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
+        sctlr = env->cp15.sctlr_el[1];
+    } else {
+        sctlr = env->cp15.sctlr_el[el];
+    }
+    return (sctlr & bit) != 0;
+}
+
+uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, &env->apia_key, false);
+}
+
+uint64_t HELPER(pacib)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, &env->apib_key, false);
+}
+
+uint64_t HELPER(pacda)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, &env->apda_key, true);
+}
+
+uint64_t HELPER(pacdb)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_addpac(env, x, y, &env->apdb_key, true);
+}
+
+uint64_t HELPER(pacga)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    uint64_t pac;
+
+    pauth_check_trap(env, arm_current_el(env), GETPC());
+    pac = pauth_computepac(x, y, env->apga_key);
+
+    return pac & 0xffffffff00000000ull;
+}
+
+uint64_t HELPER(autia)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, &env->apia_key, false, 0);
+}
+
+uint64_t HELPER(autib)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnIB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, &env->apib_key, false, 1);
+}
+
+uint64_t HELPER(autda)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDA)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, &env->apda_key, true, 0);
+}
+
+uint64_t HELPER(autdb)(CPUARMState *env, uint64_t x, uint64_t y)
+{
+    int el = arm_current_el(env);
+    if (!pauth_key_enabled(env, el, SCTLR_EnDB)) {
+        return x;
+    }
+    pauth_check_trap(env, el, GETPC());
+    return pauth_auth(env, x, y, &env->apdb_key, true, 1);
+}
+
+uint64_t HELPER(xpaci)(CPUARMState *env, uint64_t a)
+{
+    return pauth_strip(env, a, false);
+}
+
+uint64_t HELPER(xpacd)(CPUARMState *env, uint64_t a)
+{
+    return pauth_strip(env, a, true);
+}
-- 
2.20.1
