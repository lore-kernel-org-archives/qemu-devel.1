Received: from eggs.gnu.org ([2001:4830:134:3::10]:40985)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4w8-0007Vw-9j
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fJ4w6-0007Nq-OU
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:20 -0400
Received: from mail-pl0-x244.google.com ([2607:f8b0:400e:c01::244]:33995)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fJ4w6-0007NQ-Gl
	for qemu-devel@nongnu.org; Wed, 16 May 2018 18:30:18 -0400
Received: by mail-pl0-x244.google.com with SMTP id ay10-v6so1254170plb.1
	for <qemu-devel@nongnu.org>; Wed, 16 May 2018 15:30:18 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 16 May 2018 15:29:45 -0700
Message-Id: <20180516223007.10256-6-richard.henderson@linaro.org>
In-Reply-To: <20180516223007.10256-1-richard.henderson@linaro.org>
References: <20180516223007.10256-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3-a 05/27] target/arm: Implement SVE predicate
 test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/helper-sve.h    | 21 ++++++++++
 target/arm/helper.h        |  1 +
 target/arm/sve_helper.c    | 78 ++++++++++++++++++++++++++++++++++++++
 target/arm/translate-sve.c | 65 +++++++++++++++++++++++++++++++
 target/arm/Makefile.objs   |  2 +-
 target/arm/sve.decode      |  5 +++
 6 files changed, 171 insertions(+), 1 deletion(-)
 create mode 100644 target/arm/helper-sve.h
 create mode 100644 target/arm/sve_helper.c

diff --git a/target/arm/helper-sve.h b/target/arm/helper-sve.h
new file mode 100644
index 0000000000..b6e91539ae
--- /dev/null
+++ b/target/arm/helper-sve.h
@@ -0,0 +1,21 @@
+/*
+ *  AArch64 SVE specific helper definitions
+ *
+ *  Copyright (c) 2018 Linaro, Ltd
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
+DEF_HELPER_FLAGS_2(sve_predtest1, TCG_CALL_NO_WG, i32, i64, i64)
+DEF_HELPER_FLAGS_3(sve_predtest, TCG_CALL_NO_WG, i32, ptr, ptr, i32)
diff --git a/target/arm/helper.h b/target/arm/helper.h
index ce89968b2d..dcb5343d7e 100644
--- a/target/arm/helper.h
+++ b/target/arm/helper.h
@@ -605,4 +605,5 @@ DEF_HELPER_FLAGS_5(gvec_fcmlad, TCG_CALL_NO_RWG,
 
 #ifdef TARGET_AARCH64
 #include "helper-a64.h"
+#include "helper-sve.h"
 #endif
diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
new file mode 100644
index 0000000000..1ebb67e1df
--- /dev/null
+++ b/target/arm/sve_helper.c
@@ -0,0 +1,78 @@
+/*
+ * ARM SVE Operations
+ *
+ * Copyright (c) 2018 Linaro, Ltd.
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
+#include "exec/exec-all.h"
+#include "exec/cpu_ldst.h"
+#include "exec/helper-proto.h"
+#include "tcg/tcg-gvec-desc.h"
+
+
+/* Return a value for NZCV as per the ARM PredTest pseudofunction.
+ *
+ * The return value has bit 31 set if N is set, bit 1 set if Z is clear,
+ * and bit 0 set if C is set.  Compare the definitions of these variables
+ * within CPUARMState.
+ */
+
+/* For no G bits set, NZCV = C.  */
+#define PREDTEST_INIT  1
+
+/* This is an iterative function, called for each Pd and Pg word
+ * moving forward.
+ */
+static uint32_t iter_predtest_fwd(uint64_t d, uint64_t g, uint32_t flags)
+{
+    if (likely(g)) {
+        /* Compute N from first D & G.
+           Use bit 2 to signal first G bit seen.  */
+        if (!(flags & 4)) {
+            flags |= ((d & (g & -g)) != 0) << 31;
+            flags |= 4;
+        }
+
+        /* Accumulate Z from each D & G.  */
+        flags |= ((d & g) != 0) << 1;
+
+        /* Compute C from last !(D & G).  Replace previous.  */
+        flags = deposit32(flags, 0, 1, (d & pow2floor(g)) == 0);
+    }
+    return flags;
+}
+
+/* The same for a single word predicate.  */
+uint32_t HELPER(sve_predtest1)(uint64_t d, uint64_t g)
+{
+    return iter_predtest_fwd(d, g, PREDTEST_INIT);
+}
+
+/* The same for a multi-word predicate.  */
+uint32_t HELPER(sve_predtest)(void *vd, void *vg, uint32_t words)
+{
+    uint32_t flags = PREDTEST_INIT;
+    uint64_t *d = vd, *g = vg;
+    uintptr_t i = 0;
+
+    do {
+        flags = iter_predtest_fwd(d[i], g[i], flags);
+    } while (++i < words);
+
+    return flags;
+}
diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 5ec18a6aac..c3f1b0bfa6 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -87,6 +87,43 @@ static bool do_mov_z(DisasContext *s, int rd, int rn)
     return do_vector2_z(s, tcg_gen_gvec_mov, 0, rd, rn);
 }
 
+/* Set the cpu flags as per a return from an SVE helper.  */
+static void do_pred_flags(TCGv_i32 t)
+{
+    tcg_gen_mov_i32(cpu_NF, t);
+    tcg_gen_andi_i32(cpu_ZF, t, 2);
+    tcg_gen_andi_i32(cpu_CF, t, 1);
+    tcg_gen_movi_i32(cpu_VF, 0);
+}
+
+/* Subroutines computing the ARM PredTest psuedofunction.  */
+static void do_predtest1(TCGv_i64 d, TCGv_i64 g)
+{
+    TCGv_i32 t = tcg_temp_new_i32();
+
+    gen_helper_sve_predtest1(t, d, g);
+    do_pred_flags(t);
+    tcg_temp_free_i32(t);
+}
+
+static void do_predtest(DisasContext *s, int dofs, int gofs, int words)
+{
+    TCGv_ptr dptr = tcg_temp_new_ptr();
+    TCGv_ptr gptr = tcg_temp_new_ptr();
+    TCGv_i32 t;
+
+    tcg_gen_addi_ptr(dptr, cpu_env, dofs);
+    tcg_gen_addi_ptr(gptr, cpu_env, gofs);
+    t = tcg_const_i32(words);
+
+    gen_helper_sve_predtest(t, dptr, gptr, t);
+    tcg_temp_free_ptr(dptr);
+    tcg_temp_free_ptr(gptr);
+
+    do_pred_flags(t);
+    tcg_temp_free_i32(t);
+}
+
 /*
  *** SVE Logical - Unpredicated Group
  */
@@ -115,6 +152,34 @@ static bool trans_BIC_zzz(DisasContext *s, arg_rrr_esz *a, uint32_t insn)
     return do_vector3_z(s, tcg_gen_gvec_andc, 0, a->rd, a->rn, a->rm);
 }
 
+/*
+ *** SVE Predicate Misc Group
+ */
+
+static bool trans_PTEST(DisasContext *s, arg_PTEST *a, uint32_t insn)
+{
+    if (sve_access_check(s)) {
+        int nofs = pred_full_reg_offset(s, a->rn);
+        int gofs = pred_full_reg_offset(s, a->pg);
+        int words = DIV_ROUND_UP(pred_full_reg_size(s), 8);
+
+        if (words == 1) {
+            TCGv_i64 pn = tcg_temp_new_i64();
+            TCGv_i64 pg = tcg_temp_new_i64();
+
+            tcg_gen_ld_i64(pn, cpu_env, nofs);
+            tcg_gen_ld_i64(pg, cpu_env, gofs);
+            do_predtest1(pn, pg);
+
+            tcg_temp_free_i64(pn);
+            tcg_temp_free_i64(pg);
+        } else {
+            do_predtest(s, nofs, gofs, words);
+        }
+    }
+    return true;
+}
+
 /*
  *** SVE Memory - 32-bit Gather and Unsized Contiguous Group
  */
diff --git a/target/arm/Makefile.objs b/target/arm/Makefile.objs
index a6f733eaa8..11c7baf8a3 100644
--- a/target/arm/Makefile.objs
+++ b/target/arm/Makefile.objs
@@ -19,4 +19,4 @@ target/arm/decode-sve.inc.c: $(SRC_PATH)/target/arm/sve.decode $(DECODETREE)
 	  "GEN", $(TARGET_DIR)$@)
 
 target/arm/translate-sve.o: target/arm/decode-sve.inc.c
-obj-$(TARGET_AARCH64) += translate-sve.o
+obj-$(TARGET_AARCH64) += translate-sve.o sve_helper.o
diff --git a/target/arm/sve.decode b/target/arm/sve.decode
index a2c4450e7c..a44ca2f551 100644
--- a/target/arm/sve.decode
+++ b/target/arm/sve.decode
@@ -56,6 +56,11 @@ ORR_zzz         00000100 01 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 EOR_zzz         00000100 10 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 BIC_zzz         00000100 11 1 ..... 001 100 ..... .....         @rd_rn_rm_e0
 
+### SVE Predicate Misc Group
+
+# SVE predicate test
+PTEST           00100101 01 010000 11 pg:4 0 rn:4 0 0000
+
 ### SVE Memory - 32-bit Gather and Unsized Contiguous Group
 
 # SVE load predicate register
-- 
2.17.0
