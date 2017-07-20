Received: from eggs.gnu.org ([2001:4830:134:3::10]:53646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0c-0004Yy-6V
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dYD0X-0007xn-3g
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:58 -0400
Received: from mail-wm0-x22e.google.com ([2a00:1450:400c:c09::22e]:34399)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dYD0W-0007wn-OO
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 11:04:52 -0400
Received: by mail-wm0-x22e.google.com with SMTP id l81so7948994wmg.1
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 08:04:52 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 20 Jul 2017 16:04:15 +0100
Message-Id: <20170720150426.12393-13-alex.bennee@linaro.org>
In-Reply-To: <20170720150426.12393-1-alex.bennee@linaro.org>
References: <20170720150426.12393-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH for 2.11 12/23] target/arm/translate-a64.c:
 add FP16 FAGCT to AdvSIMD 3 Same
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: rth@twiddle.net, qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

This adds the first of the softfloat3c helpers for handling FP16
operations. To interwork with the existing SoftFloat2a code we need to
copy the exceptions conditions across before each operation and
restore them afterwards.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/Makefile.objs    |  1 +
 target/arm/advsimd_helper.c | 85 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/helper-a64.h     |  3 ++
 target/arm/translate-a64.c  |  3 ++
 4 files changed, 92 insertions(+)
 create mode 100644 target/arm/advsimd_helper.c

diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index 847fb52ee0..d4e81b13f0 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -6,6 +6,7 @@ obj-$(call land,$(CONFIG_KVM),$(TARGET_AARCH64)) += kvm64.o
 obj-$(call lnot,$(CONFIG_KVM)) += kvm-stub.o
 obj-y += translate.o op_helper.o helper.o cpu.o
 obj-y += neon_helper.o iwmmxt_helper.o
+obj-$(TARGET_AARCH64) += advsimd_helper.o
 obj-y += gdbstub.o
 obj-$(TARGET_AARCH64) += cpu64.o translate-a64.o helper-a64.o gdbstub64.o
 obj-y += crypto_helper.o
diff --git a/target/arm/advsimd_helper.c b/target/arm/advsimd_helper.c
new file mode 100644
index 0000000000..ec875a83bb
--- /dev/null
+++ b/target/arm/advsimd_helper.c
@@ -0,0 +1,85 @@
+/*
+ * ARM AdvancedSIMD helper functions
+ *
+ * Copyright (c) 2017 Linaro.
+ * Author: Alex Bennée <alex.bennee@linaro.org>
+ *
+ * This code is licensed under the GNU GPL v2.
+ *
+ * This code is specifically for AdvancedSIMD helpers rather than
+ * shared NEON helpers which are re-purposed for ARMv8. In practice
+ * these are helpers for newer features not found in older ARMs,
+ * currently half-precision float support.
+ *
+ * As such these helpers use the SoftFloat3c code. As we currently use
+ * both SoftFloat cores we copy the SoftFloat2a status bits to 3c
+ * before the operation and copy back at the end.
+ */
+#include "qemu/osdep.h"
+
+#include "cpu.h"
+#include "exec/exec-all.h"
+#include "exec/helper-proto.h"
+
+#include "fpu/softfloat3c/platform.h"
+#include "fpu/softfloat3c/softfloat.h"
+#include "fpu/softfloat3c/softfloat-internals.h"
+
+typedef struct softfloat_flags {
+    uint8_t float2a_flag;
+    uint8_t float3c_flag;
+} softfloat_flags;
+
+static softfloat_flags softfloat_mapping_table[] = {
+    { float_flag_inexact  , softfloat_flag_inexact },
+    { float_flag_underflow, softfloat_flag_underflow },
+    { float_flag_overflow , softfloat_flag_overflow },
+    { float_flag_invalid  , softfloat_flag_invalid },
+};
+/* FIXME: 2a has no infinite flag */
+
+static uint8_t sync_softfloat_flags_from_2a(float_status *flags2a)
+{
+    uint8_t flags = flags2a->float_exception_flags;
+    int i;
+    if (flags) {
+        for (i = 0; i < ARRAY_SIZE(softfloat_mapping_table); i++) {
+            struct softfloat_flags *map = &softfloat_mapping_table[i];
+            if (flags & map->float2a_flag) {
+                softfloat_raiseFlags(map->float3c_flag);
+            }
+        }
+    } else {
+        softfloat_exceptionFlags = 0;
+    }
+
+    return softfloat_exceptionFlags;
+}
+
+static void sync_softfloat_flags_to_2a(float_status *flags2a)
+{
+    int i;
+    if (softfloat_exceptionFlags) {
+        for (i = 0; i < ARRAY_SIZE(softfloat_mapping_table); i++) {
+            struct softfloat_flags *map = &softfloat_mapping_table[i];
+            if (softfloat_exceptionFlags & map->float3c_flag) {
+                float_raise(map->float2a_flag, flags2a);
+            }
+        }
+    } else {
+        flags2a->float_exception_flags = 0;
+    }
+}
+
+
+uint32_t HELPER(advsimd_acgt_f16)(uint32_t a, uint32_t b, void *fpstp)
+{
+    union ui16_f16 uA = { .ui = (a & 0x7fff) };
+    union ui16_f16 uB = { .ui = (b & 0x7fff) };
+    uint32_t r;
+
+    sync_softfloat_flags_from_2a(fpstp);
+    r = -f16_lt(uB.f, uA.f);
+    sync_softfloat_flags_to_2a(fpstp);
+    return r;
+}
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 6f9eaba533..48b400ca8e 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -44,3 +44,6 @@ DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_le, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
+
+/* helper_advsimd.c */
+DEF_HELPER_3(advsimd_acgt_f16, i32, i32, i32, ptr)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c766829ff9..06da8408f6 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -9764,6 +9764,9 @@ static void disas_simd_three_reg_same_fp16(DisasContext *s, uint32_t insn)
         read_vec_element_i32(s, tcg_op2, rm, pass, MO_16);
 
         switch (fpopcode) {
+        case 0x35: /* FACGT */
+            gen_helper_advsimd_acgt_f16(tcg_res, tcg_op1, tcg_op2, fpst);
+            break;
         default:
             fprintf(stderr,"%s: insn %#04x fpop %#2x\n", __func__, insn, fpopcode);
             unsupported_encoding(s, insn);
-- 
2.13.0
