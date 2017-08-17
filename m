Received: from eggs.gnu.org ([2001:4830:134:3::10]:37577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9W-00049O-VY
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1diP9V-0005Of-TD
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:18 -0400
Received: from mail-wr0-x22e.google.com ([2a00:1450:400c:c0c::22e]:34032)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1diP9V-0005Nu-Gh
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:04:17 -0400
Received: by mail-wr0-x22e.google.com with SMTP id y96so47731454wrc.1
	for <qemu-devel@nongnu.org>; Thu, 17 Aug 2017 11:04:17 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Thu, 17 Aug 2017 19:04:04 +0100
Message-Id: <20170817180404.29334-10-alex.bennee@linaro.org>
In-Reply-To: <20170817180404.29334-1-alex.bennee@linaro.org>
References: <20170817180404.29334-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 9/9] target/arm/translate-a64: vectorise
 smull vD.4s, vN.[48]s, vM.h[]
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: rth@twiddle.net, cota@braap.org, batuzovk@ispras.ru
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

These instructions show up in the ffmpeg profile from the
ff_simple_idct_put_neon function.

WARNING: this is experimental and essentially shortcuts to the
vectorised helper for the one instruction that shows up a lot in the
ffmpeg trace. Otherwise it falls through to the normal code
generation. We also skip where rd == rn to avoid having to explicitly
deal with the aliasing in the helper.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 target/arm/helper-a64.c    | 17 +++++++++++
 target/arm/helper-a64.h    |  2 ++
 target/arm/translate-a64.c | 72 ++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
index 17b1edfb5f..ae0f8da5c4 100644
--- a/target/arm/helper-a64.c
+++ b/target/arm/helper-a64.c
@@ -538,3 +538,20 @@ uint64_t HELPER(paired_cmpxchg64_be)(CPUARMState *env, uint64_t addr,
 
     return !success;
 }
+
+/* Multiply Long (vector, by element) */
+void HELPER(advsimd_smull_idx_s32)(void *d, void *n, uint32_t m,
+                                   uint32_t simd_data)
+{
+    int opr_elt = GET_SIMD_DATA(OPR_ELT, simd_data);
+    int doff_elt = GET_SIMD_DATA(DOFF_ELT, simd_data);
+    int32_t *rd = (int32_t *) d;
+    int16_t *rn = (int16_t *) n;
+    int16_t rm = (int16_t) m;
+    int i;
+
+    #pragma GCC ivdep
+    for (i = 0; i < opr_elt; ++i) {
+        rd[i] = rn[i + doff_elt] * rm;
+    }
+}
diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
index 6f9eaba533..0bd7942cec 100644
--- a/target/arm/helper-a64.h
+++ b/target/arm/helper-a64.h
@@ -44,3 +44,5 @@ DEF_HELPER_FLAGS_3(crc32_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_3(crc32c_64, TCG_CALL_NO_RWG_SE, i64, i64, i64, i32)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_le, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
 DEF_HELPER_FLAGS_4(paired_cmpxchg64_be, TCG_CALL_NO_WG, i64, env, i64, i64, i64)
+
+DEF_HELPER_4(advsimd_smull_idx_s32, void, vec, vec, i32, i32)
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f474c5008b..3a609e571c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -10466,6 +10466,74 @@ static void disas_simd_two_reg_misc(DisasContext *s, uint32_t insn)
     }
 }
 
+typedef void AdvSIMDGenTwoPlusOneVectorFn(TCGv_vec, TCGv_vec, TCGv_i32, TCGv_i32);
+
+/* Handle [U/S]ML[S/A]L instructions
+ *
+ * This splits off from bellow only to aid experimentation.
+ */
+static bool handle_vec_simd_mul_addsub(DisasContext *s, uint32_t insn, int opcode, int size, bool is_q, bool u, int rn, int rm, int rd)
+{
+    /* fprintf(stderr, "%s: %#04x op:%x sz:%d rn:%d rm:%d rd:%d\n", __func__, */
+    /*         insn, opcode, size, rn, rm, rd); */
+
+    if (size == 1) {
+        AdvSIMDGenTwoPlusOneVectorFn *fn = NULL;
+        uint32_t simd_info = 0;
+
+        switch (opcode) {
+        case 0x2: /* SMLAL, SMLAL2, UMLAL, UMLAL2 */
+            break;
+        case 0x6: /* SMLSL, SMLSL2, UMLSL, UMLSL2 */
+            break;
+        case 0xa: /* SMULL, SMULL2, UMULL, UMULL2 */
+            if (!u)
+            {
+                /* helper assumes no aliasing */
+                if (rd == rn) {
+                    return false;
+                }
+
+                fn = gen_helper_advsimd_smull_idx_s32;
+                simd_info = deposit32(simd_info,
+                                      ADVSIMD_OPR_ELT_SHIFT, ADVSIMD_OPR_ELT_BITS, 4);
+
+                if (is_q) {
+                    simd_info = deposit32(simd_info,
+                                          ADVSIMD_DOFF_ELT_SHIFT, ADVSIMD_DOFF_ELT_BITS, 4);
+                }
+            };
+            break;
+        default:
+            break;
+        }
+
+        /* assert(fn); */
+
+        if (fn) {
+            TCGv_i32 tcg_idx = tcg_temp_new_i32();
+            TCGv_i32 tcg_simd_info = tcg_const_i32(simd_info);
+            int h = extract32(insn, 11, 1);
+            int lm = extract32(insn, 20, 2);
+            int index = h << 2 | lm;
+
+            if (!fp_access_check(s)) {
+                return false;
+            }
+
+            read_vec_element_i32(s, tcg_idx, rm, index, size);
+
+            fn(cpu_V[rd], cpu_V[rn], tcg_idx, tcg_simd_info);
+
+            tcg_temp_free_i32(tcg_simd_info);
+            tcg_temp_free_i32(tcg_idx);
+            return true;
+        }
+    }
+
+    return false;
+}
+
 /* C3.6.13 AdvSIMD scalar x indexed element
  *  31 30  29 28       24 23  22 21  20  19  16 15 12  11  10 9    5 4    0
  * +-----+---+-----------+------+---+---+------+-----+---+---+------+------+
@@ -10518,6 +10586,10 @@ static void disas_simd_indexed(DisasContext *s, uint32_t insn)
             unallocated_encoding(s);
             return;
         }
+        /* Shortcut if we have a vectorised helper */
+        if (handle_vec_simd_mul_addsub(s, insn, opcode, size, is_q, u, rn, rm, rd)) {
+            return;
+        }
         is_long = true;
         break;
     case 0x3: /* SQDMLAL, SQDMLAL2 */
-- 
2.13.0
