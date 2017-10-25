Received: from eggs.gnu.org ([2001:4830:134:3::10]:45632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6a-0008KV-07
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1e7I6W-0008AX-0S
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:07 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:52547)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1e7I6V-00089Z-OL
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 05:36:03 -0400
Received: by mail-wr0-x242.google.com with SMTP id k62so23307179wrc.9
	for <qemu-devel@nongnu.org>; Wed, 25 Oct 2017 02:36:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed, 25 Oct 2017 11:35:03 +0200
Message-Id: <20171025093535.10175-20-richard.henderson@linaro.org>
In-Reply-To: <20171025093535.10175-1-richard.henderson@linaro.org>
References: <20171025093535.10175-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 19/51] tcg: Remove TCGV_EQUAL*
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

When we used structures for TCGv_*, we needed a macro in order to
perform a comparison.  Now that we use pointers, this is just clutter.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/tcg-op.h            | 6 ++----
 tcg/tcg.h               | 4 ----
 target/cris/translate.c | 6 +++---
 target/i386/translate.c | 6 +++---
 target/m68k/translate.c | 2 +-
 target/ppc/translate.c  | 4 ++--
 6 files changed, 11 insertions(+), 17 deletions(-)

diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
index ab2f3c6cee..3129159907 100644
--- a/tcg/tcg-op.h
+++ b/tcg/tcg-op.h
@@ -328,7 +328,7 @@ static inline void tcg_gen_discard_i32(TCGv_i32 arg)
 
 static inline void tcg_gen_mov_i32(TCGv_i32 ret, TCGv_i32 arg)
 {
-    if (!TCGV_EQUAL_I32(ret, arg)) {
+    if (ret != arg) {
         tcg_gen_op2_i32(INDEX_op_mov_i32, ret, arg);
     }
 }
@@ -522,7 +522,7 @@ static inline void tcg_gen_discard_i64(TCGv_i64 arg)
 
 static inline void tcg_gen_mov_i64(TCGv_i64 ret, TCGv_i64 arg)
 {
-    if (!TCGV_EQUAL_I64(ret, arg)) {
+    if (ret != arg) {
         tcg_gen_op2_i64(INDEX_op_mov_i64, ret, arg);
     }
 }
@@ -809,7 +809,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 #define tcg_temp_free tcg_temp_free_i32
 #define TCGV_UNUSED(x) TCGV_UNUSED_I32(x)
 #define TCGV_IS_UNUSED(x) TCGV_IS_UNUSED_I32(x)
-#define TCGV_EQUAL(a, b) TCGV_EQUAL_I32(a, b)
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i32
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i32
 #else
@@ -820,7 +819,6 @@ void tcg_gen_lookup_and_goto_ptr(void);
 #define tcg_temp_free tcg_temp_free_i64
 #define TCGV_UNUSED(x) TCGV_UNUSED_I64(x)
 #define TCGV_IS_UNUSED(x) TCGV_IS_UNUSED_I64(x)
-#define TCGV_EQUAL(a, b) TCGV_EQUAL_I64(a, b)
 #define tcg_gen_qemu_ld_tl tcg_gen_qemu_ld_i64
 #define tcg_gen_qemu_st_tl tcg_gen_qemu_st_i64
 #endif
diff --git a/tcg/tcg.h b/tcg/tcg.h
index b7fac0db8a..8f692bc6cf 100644
--- a/tcg/tcg.h
+++ b/tcg/tcg.h
@@ -428,10 +428,6 @@ typedef TCGv_ptr TCGv_env;
 #error Unhandled TARGET_LONG_BITS value
 #endif
 
-#define TCGV_EQUAL_I32(a, b) ((a) == (b))
-#define TCGV_EQUAL_I64(a, b) ((a) == (b))
-#define TCGV_EQUAL_PTR(a, b) ((a) == (b))
-
 /* Dummy definition to avoid compiler warnings.  */
 #define TCGV_UNUSED_I32(x) (x = (TCGv_i32)-1)
 #define TCGV_UNUSED_I64(x) (x = (TCGv_i64)-1)
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 38a999e6f1..55a9202777 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -839,7 +839,7 @@ static void cris_alu(DisasContext *dc, int op,
         }
         tcg_gen_or_tl(d, d, tmp);
     }
-    if (!TCGV_EQUAL(tmp, d)) {
+    if (tmp != d) {
         tcg_temp_free(tmp);
     }
 }
@@ -1162,7 +1162,7 @@ static inline void t_gen_sext(TCGv d, TCGv s, int size)
         tcg_gen_ext8s_i32(d, s);
     } else if (size == 2) {
         tcg_gen_ext16s_i32(d, s);
-    } else if (!TCGV_EQUAL(d, s)) {
+    } else {
         tcg_gen_mov_tl(d, s);
     }
 }
@@ -1173,7 +1173,7 @@ static inline void t_gen_zext(TCGv d, TCGv s, int size)
         tcg_gen_ext8u_i32(d, s);
     } else if (size == 2) {
         tcg_gen_ext16u_i32(d, s);
-    } else if (!TCGV_EQUAL(d, s)) {
+    } else {
         tcg_gen_mov_tl(d, s);
     }
 }
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 5f24a2de3c..d6697f721c 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -742,7 +742,7 @@ static CCPrepare gen_prepare_eflags_c(DisasContext *s, TCGv reg)
         size = s->cc_op - CC_OP_SUBB;
         t1 = gen_ext_tl(cpu_tmp0, cpu_cc_src, size, false);
         /* If no temporary was used, be careful not to alias t1 and t0.  */
-        t0 = TCGV_EQUAL(t1, cpu_cc_src) ? cpu_tmp0 : reg;
+        t0 = t1 == cpu_cc_src ? cpu_tmp0 : reg;
         tcg_gen_mov_tl(t0, cpu_cc_srcT);
         gen_extu(size, t0);
         goto add_sub;
@@ -951,7 +951,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
             break;
         case JCC_L:
             gen_compute_eflags(s);
-            if (TCGV_EQUAL(reg, cpu_cc_src)) {
+            if (reg == cpu_cc_src) {
                 reg = cpu_tmp0;
             }
             tcg_gen_shri_tl(reg, cpu_cc_src, 4); /* CC_O -> CC_S */
@@ -962,7 +962,7 @@ static CCPrepare gen_prepare_cc(DisasContext *s, int b, TCGv reg)
         default:
         case JCC_LE:
             gen_compute_eflags(s);
-            if (TCGV_EQUAL(reg, cpu_cc_src)) {
+            if (reg == cpu_cc_src) {
                 reg = cpu_tmp0;
             }
             tcg_gen_shri_tl(reg, cpu_cc_src, 4); /* CC_O -> CC_S */
diff --git a/target/m68k/translate.c b/target/m68k/translate.c
index d738f32f9c..63b1552669 100644
--- a/target/m68k/translate.c
+++ b/target/m68k/translate.c
@@ -58,7 +58,7 @@ static TCGv_i64 cpu_macc[4];
 #define QREG_SP         get_areg(s, 7)
 
 static TCGv NULL_QREG;
-#define IS_NULL_QREG(t) (TCGV_EQUAL(t, NULL_QREG))
+#define IS_NULL_QREG(t) (t == NULL_QREG)
 /* Used to distinguish stores from bad addressing modes.  */
 static TCGv store_dummy;
 
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index a81ff69d75..616cf8f50e 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -902,7 +902,7 @@ static inline void gen_op_arith_add(DisasContext *ctx, TCGv ret, TCGv arg1,
         gen_set_Rc0(ctx, t0);
     }
 
-    if (!TCGV_EQUAL(t0, ret)) {
+    if (t0 != ret) {
         tcg_gen_mov_tl(ret, t0);
         tcg_temp_free(t0);
     }
@@ -1438,7 +1438,7 @@ static inline void gen_op_arith_subf(DisasContext *ctx, TCGv ret, TCGv arg1,
         gen_set_Rc0(ctx, t0);
     }
 
-    if (!TCGV_EQUAL(t0, ret)) {
+    if (t0 != ret) {
         tcg_gen_mov_tl(ret, t0);
         tcg_temp_free(t0);
     }
-- 
2.13.6
