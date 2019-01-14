Received: from eggs.gnu.org ([209.51.188.92]:44660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1giwzu-0006Oo-ES
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jcmvbkbc@gmail.com>) id 1giwzp-0001p3-JN
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:23 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:34660)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jcmvbkbc@gmail.com>) id 1giwzp-0001nr-8D
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 02:49:21 -0500
Received: by mail-lf1-x144.google.com with SMTP id p6so14897449lfc.1
	for <qemu-devel@nongnu.org>; Sun, 13 Jan 2019 23:49:21 -0800 (PST)
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Sun, 13 Jan 2019 23:48:49 -0800
Message-Id: <20190114074855.16891-2-jcmvbkbc@gmail.com>
In-Reply-To: <20190114074855.16891-1-jcmvbkbc@gmail.com>
References: <20190114074855.16891-1-jcmvbkbc@gmail.com>
Subject: [Qemu-devel] [PATCH 1/7] target/xtensa: extract FPU helpers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>

Move FPU-related HELPER functions from op_helper.c to fpu_helper.c
No functional changes.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 target/xtensa/Makefile.objs |   1 +
 target/xtensa/fpu_helper.c  | 166 ++++++++++++++++++++++++++++++++++++++++++++
 target/xtensa/op_helper.c   | 135 -----------------------------------
 3 files changed, 167 insertions(+), 135 deletions(-)
 create mode 100644 target/xtensa/fpu_helper.c

diff --git a/target/xtensa/Makefile.objs b/target/xtensa/Makefile.objs
index f63352cc04db..1508714c4475 100644
--- a/target/xtensa/Makefile.objs
+++ b/target/xtensa/Makefile.objs
@@ -7,4 +7,5 @@ obj-y += core-test_kc705_be.o
 obj-$(CONFIG_SOFTMMU) += monitor.o xtensa-semi.o
 obj-y += xtensa-isa.o
 obj-y += translate.o op_helper.o helper.o cpu.o
+obj-y += fpu_helper.o
 obj-y += gdbstub.o
diff --git a/target/xtensa/fpu_helper.c b/target/xtensa/fpu_helper.c
new file mode 100644
index 000000000000..f8bbb6cdd824
--- /dev/null
+++ b/target/xtensa/fpu_helper.c
@@ -0,0 +1,166 @@
+/*
+ * Copyright (c) 2011 - 2019, Max Filippov, Open Source and Linux Lab.
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ *     * Redistributions of source code must retain the above copyright
+ *       notice, this list of conditions and the following disclaimer.
+ *     * Redistributions in binary form must reproduce the above copyright
+ *       notice, this list of conditions and the following disclaimer in the
+ *       documentation and/or other materials provided with the distribution.
+ *     * Neither the name of the Open Source and Linux Lab nor the
+ *       names of its contributors may be used to endorse or promote products
+ *       derived from this software without specific prior written permission.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY
+ * DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
+ * (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
+ * LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
+ * ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
+ * SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/main-loop.h"
+#include "cpu.h"
+#include "exec/helper-proto.h"
+#include "qemu/host-utils.h"
+#include "exec/exec-all.h"
+#include "fpu/softfloat.h"
+
+void HELPER(wur_fcr)(CPUXtensaState *env, uint32_t v)
+{
+    static const int rounding_mode[] = {
+        float_round_nearest_even,
+        float_round_to_zero,
+        float_round_up,
+        float_round_down,
+    };
+
+    env->uregs[FCR] = v & 0xfffff07f;
+    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
+}
+
+float32 HELPER(abs_s)(float32 v)
+{
+    return float32_abs(v);
+}
+
+float32 HELPER(neg_s)(float32 v)
+{
+    return float32_chs(v);
+}
+
+float32 HELPER(add_s)(CPUXtensaState *env, float32 a, float32 b)
+{
+    return float32_add(a, b, &env->fp_status);
+}
+
+float32 HELPER(sub_s)(CPUXtensaState *env, float32 a, float32 b)
+{
+    return float32_sub(a, b, &env->fp_status);
+}
+
+float32 HELPER(mul_s)(CPUXtensaState *env, float32 a, float32 b)
+{
+    return float32_mul(a, b, &env->fp_status);
+}
+
+float32 HELPER(madd_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
+{
+    return float32_muladd(b, c, a, 0, &env->fp_status);
+}
+
+float32 HELPER(msub_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
+{
+    return float32_muladd(b, c, a, float_muladd_negate_product,
+                          &env->fp_status);
+}
+
+uint32_t HELPER(ftoi)(float32 v, uint32_t rounding_mode, uint32_t scale)
+{
+    float_status fp_status = {0};
+
+    set_float_rounding_mode(rounding_mode, &fp_status);
+    return float32_to_int32(float32_scalbn(v, scale, &fp_status), &fp_status);
+}
+
+uint32_t HELPER(ftoui)(float32 v, uint32_t rounding_mode, uint32_t scale)
+{
+    float_status fp_status = {0};
+    float32 res;
+
+    set_float_rounding_mode(rounding_mode, &fp_status);
+
+    res = float32_scalbn(v, scale, &fp_status);
+
+    if (float32_is_neg(v) && !float32_is_any_nan(v)) {
+        return float32_to_int32(res, &fp_status);
+    } else {
+        return float32_to_uint32(res, &fp_status);
+    }
+}
+
+float32 HELPER(itof)(CPUXtensaState *env, uint32_t v, uint32_t scale)
+{
+    return float32_scalbn(int32_to_float32(v, &env->fp_status),
+                          (int32_t)scale, &env->fp_status);
+}
+
+float32 HELPER(uitof)(CPUXtensaState *env, uint32_t v, uint32_t scale)
+{
+    return float32_scalbn(uint32_to_float32(v, &env->fp_status),
+                          (int32_t)scale, &env->fp_status);
+}
+
+static inline void set_br(CPUXtensaState *env, bool v, uint32_t br)
+{
+    if (v) {
+        env->sregs[BR] |= br;
+    } else {
+        env->sregs[BR] &= ~br;
+    }
+}
+
+void HELPER(un_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+{
+    set_br(env, float32_unordered_quiet(a, b, &env->fp_status), br);
+}
+
+void HELPER(oeq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+{
+    set_br(env, float32_eq_quiet(a, b, &env->fp_status), br);
+}
+
+void HELPER(ueq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+{
+    int v = float32_compare_quiet(a, b, &env->fp_status);
+    set_br(env, v == float_relation_equal || v == float_relation_unordered, br);
+}
+
+void HELPER(olt_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+{
+    set_br(env, float32_lt_quiet(a, b, &env->fp_status), br);
+}
+
+void HELPER(ult_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+{
+    int v = float32_compare_quiet(a, b, &env->fp_status);
+    set_br(env, v == float_relation_less || v == float_relation_unordered, br);
+}
+
+void HELPER(ole_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+{
+    set_br(env, float32_le_quiet(a, b, &env->fp_status), br);
+}
+
+void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
+{
+    int v = float32_compare_quiet(a, b, &env->fp_status);
+    set_br(env, v != float_relation_greater, br);
+}
diff --git a/target/xtensa/op_helper.c b/target/xtensa/op_helper.c
index 078aeb6c2c94..47517359ca67 100644
--- a/target/xtensa/op_helper.c
+++ b/target/xtensa/op_helper.c
@@ -34,7 +34,6 @@
 #include "exec/cpu_ldst.h"
 #include "exec/address-spaces.h"
 #include "qemu/timer.h"
-#include "fpu/softfloat.h"
 
 #ifndef CONFIG_USER_ONLY
 
@@ -890,140 +889,6 @@ void HELPER(wsr_dbreakc)(CPUXtensaState *env, uint32_t i, uint32_t v)
 }
 #endif
 
-void HELPER(wur_fcr)(CPUXtensaState *env, uint32_t v)
-{
-    static const int rounding_mode[] = {
-        float_round_nearest_even,
-        float_round_to_zero,
-        float_round_up,
-        float_round_down,
-    };
-
-    env->uregs[FCR] = v & 0xfffff07f;
-    set_float_rounding_mode(rounding_mode[v & 3], &env->fp_status);
-}
-
-float32 HELPER(abs_s)(float32 v)
-{
-    return float32_abs(v);
-}
-
-float32 HELPER(neg_s)(float32 v)
-{
-    return float32_chs(v);
-}
-
-float32 HELPER(add_s)(CPUXtensaState *env, float32 a, float32 b)
-{
-    return float32_add(a, b, &env->fp_status);
-}
-
-float32 HELPER(sub_s)(CPUXtensaState *env, float32 a, float32 b)
-{
-    return float32_sub(a, b, &env->fp_status);
-}
-
-float32 HELPER(mul_s)(CPUXtensaState *env, float32 a, float32 b)
-{
-    return float32_mul(a, b, &env->fp_status);
-}
-
-float32 HELPER(madd_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
-{
-    return float32_muladd(b, c, a, 0,
-            &env->fp_status);
-}
-
-float32 HELPER(msub_s)(CPUXtensaState *env, float32 a, float32 b, float32 c)
-{
-    return float32_muladd(b, c, a, float_muladd_negate_product,
-            &env->fp_status);
-}
-
-uint32_t HELPER(ftoi)(float32 v, uint32_t rounding_mode, uint32_t scale)
-{
-    float_status fp_status = {0};
-
-    set_float_rounding_mode(rounding_mode, &fp_status);
-    return float32_to_int32(
-            float32_scalbn(v, scale, &fp_status), &fp_status);
-}
-
-uint32_t HELPER(ftoui)(float32 v, uint32_t rounding_mode, uint32_t scale)
-{
-    float_status fp_status = {0};
-    float32 res;
-
-    set_float_rounding_mode(rounding_mode, &fp_status);
-
-    res = float32_scalbn(v, scale, &fp_status);
-
-    if (float32_is_neg(v) && !float32_is_any_nan(v)) {
-        return float32_to_int32(res, &fp_status);
-    } else {
-        return float32_to_uint32(res, &fp_status);
-    }
-}
-
-float32 HELPER(itof)(CPUXtensaState *env, uint32_t v, uint32_t scale)
-{
-    return float32_scalbn(int32_to_float32(v, &env->fp_status),
-            (int32_t)scale, &env->fp_status);
-}
-
-float32 HELPER(uitof)(CPUXtensaState *env, uint32_t v, uint32_t scale)
-{
-    return float32_scalbn(uint32_to_float32(v, &env->fp_status),
-            (int32_t)scale, &env->fp_status);
-}
-
-static inline void set_br(CPUXtensaState *env, bool v, uint32_t br)
-{
-    if (v) {
-        env->sregs[BR] |= br;
-    } else {
-        env->sregs[BR] &= ~br;
-    }
-}
-
-void HELPER(un_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    set_br(env, float32_unordered_quiet(a, b, &env->fp_status), br);
-}
-
-void HELPER(oeq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    set_br(env, float32_eq_quiet(a, b, &env->fp_status), br);
-}
-
-void HELPER(ueq_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    int v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v == float_relation_equal || v == float_relation_unordered, br);
-}
-
-void HELPER(olt_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    set_br(env, float32_lt_quiet(a, b, &env->fp_status), br);
-}
-
-void HELPER(ult_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    int v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v == float_relation_less || v == float_relation_unordered, br);
-}
-
-void HELPER(ole_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    set_br(env, float32_le_quiet(a, b, &env->fp_status), br);
-}
-
-void HELPER(ule_s)(CPUXtensaState *env, uint32_t br, float32 a, float32 b)
-{
-    int v = float32_compare_quiet(a, b, &env->fp_status);
-    set_br(env, v != float_relation_greater, br);
-}
-
 uint32_t HELPER(rer)(CPUXtensaState *env, uint32_t addr)
 {
 #ifndef CONFIG_USER_ONLY
-- 
2.11.0
