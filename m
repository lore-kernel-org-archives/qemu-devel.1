Received: from eggs.gnu.org ([2001:4830:134:3::10]:55508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUK-00083P-70
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1eQzUI-0001pM-6x
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:04 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1eQzUH-0001oV-V8
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 12:46:02 -0500
Received: by mail-pf0-x241.google.com with SMTP id p84so9976341pfd.3
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 09:46:01 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Mon, 18 Dec 2017 09:45:33 -0800
Message-Id: <20171218174552.18871-5-richard.henderson@linaro.org>
In-Reply-To: <20171218174552.18871-1-richard.henderson@linaro.org>
References: <20171218174552.18871-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 04/23] target/arm: Implement PTRUE, PFALSE,
 SETFFR
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-sve.c | 117 +++++++++++++++++++++++++++++++++++++++++++++
 target/arm/sve.def         |  12 +++++
 2 files changed, 129 insertions(+)

diff --git a/target/arm/translate-sve.c b/target/arm/translate-sve.c
index 43420fa124..fabf6f0a67 100644
--- a/target/arm/translate-sve.c
+++ b/target/arm/translate-sve.c
@@ -99,3 +99,120 @@ void trans_BIC_zzz(DisasContext *s, arg_BIC_zzz *a, uint32_t insn)
 {
     do_zzz_genfn(s, a, tcg_gen_gvec_andc);
 }
+
+static uint64_t pred_esz_mask[4] = {
+    0xffffffffffffffffull, 0x5555555555555555ull,
+    0x1111111111111111ull, 0x0101010101010101ull
+};
+
+/* See the ARM pseudocode DecodePredCount.  */
+static unsigned decode_pred_count(unsigned fullsz, int pattern, int esz)
+{
+    unsigned elements = fullsz >> esz;
+
+    switch (pattern) {
+    case 0x0: /* POW2 */
+        return pow2floor(elements);
+    case 0x1: /* VL1 */
+    case 0x2: /* VL2 */
+    case 0x3: /* VL3 */
+    case 0x4: /* VL4 */
+    case 0x5: /* VL5 */
+    case 0x6: /* VL6 */
+    case 0x7: /* VL7 */
+    case 0x8: /* VL8 */
+        return MIN(pattern, elements);
+    case 0x9: /* VL16 */
+    case 0xa: /* VL32 */
+    case 0xb: /* VL64 */
+    case 0xc: /* VL128 */
+    case 0xd: /* VL256 */
+        return MIN(16 << (pattern - 9), elements);
+    case 0x1d: /* MUL4 */
+        return elements - elements % 4;
+    case 0x1e: /* MUL3 */
+        return elements - elements % 3;
+    case 0x1f: /* ALL */
+        return elements;
+    default:   /* #uimm5 */
+        return 0;
+    }
+}
+
+/* For PTRUE, PTRUES, PFALSE, SETFFR.  */
+void trans_pred_set(DisasContext *s, arg_pred_set *a, uint32_t insn)
+{
+    unsigned fullsz = vec_full_reg_size(s);
+    unsigned numelem, setsz, setalign, allalign, ofs;
+    uint64_t word, lastword;
+    TCGv_i64 t;
+
+    numelem = decode_pred_count(fullsz, a->pat, a->esz);
+
+    /* Determine what we must store into each bit, and how many.  */
+    if (numelem == 0 || a->i == 0) {
+        lastword = word = 0;
+        setsz = fullsz;
+    } else {
+        setsz = numelem << a->esz;
+        lastword = word = pred_esz_mask[a->esz];
+        if (setsz % 64) {
+            lastword &= ~(-1ull << (setsz % 64));
+        }
+    }
+
+    /* Rescale from bits to bytes.  */
+    fullsz /= 8;
+    setsz /= 8;
+
+    ofs = pred_full_reg_offset(s, a->rd);
+    setalign = QEMU_ALIGN_DOWN(setsz, 8);
+    allalign = QEMU_ALIGN_UP(fullsz, 16);
+
+    /* Perform the stores.  Use the vector infrastructure if the sizes
+       are large enough.  */
+    if (fullsz > 8) {
+        if (setsz >= 16 && setsz % 16 == 0) {
+            tcg_gen_gvec_dup64i(ofs, setsz, allalign, word);
+        } else if (setsz <= 8 && fullsz > 16) {
+            tcg_gen_gvec_dup64i(ofs, allalign, allalign, 0);
+        } else if (fullsz - setsz <= 8 && fullsz > 16) {
+            tcg_gen_gvec_dup64i(ofs, allalign, allalign, word);
+        } else {
+            unsigned i = 0;
+
+            t = tcg_temp_new_i64();
+            if (setalign > 0) {
+                tcg_gen_movi_i64(t, word);
+                for (; i < setalign; i += 8) {
+                    tcg_gen_st_i64(t, cpu_env, ofs + i);
+                }
+            }
+            if (lastword != word) {
+                tcg_gen_movi_i64(t, lastword);
+                tcg_gen_st_i64(t, cpu_env, ofs + i);
+                i += 8;
+            }
+            if (i < fullsz) {
+                tcg_gen_movi_i64(t, 0);
+                for (; i < fullsz; i += 8) {
+                    tcg_gen_st_i64(t, cpu_env, ofs + i);
+                }
+            }
+            tcg_temp_free_i64(t);
+            goto done;
+        }
+    }
+    t = tcg_const_i64(lastword);
+    tcg_gen_st_i64(t, cpu_env, ofs + setalign);
+    tcg_temp_free_i64(t);
+
+ done:
+    /* PTRUES */
+    if (a->s) {
+        tcg_gen_movi_i32(cpu_NF, -(lastword != 0));
+        tcg_gen_movi_i32(cpu_CF, lastword != 0);
+        tcg_gen_movi_i32(cpu_ZF, lastword == 0);
+        tcg_gen_movi_i32(cpu_VF, 0);
+    }
+}
diff --git a/target/arm/sve.def b/target/arm/sve.def
index 0f47a21ef0..f802031f51 100644
--- a/target/arm/sve.def
+++ b/target/arm/sve.def
@@ -25,6 +25,7 @@
 # instruction patterns.
 
 &rrr_esz		rd rn rm esz
+&pred_set		rd pat esz i s
 
 ###########################################################################
 # Named instruction formats.  These are generally used to
@@ -43,3 +44,14 @@ AND_zzz			00000100 00 1 ..... 001 100 ..... .....		@rd_rn_rm
 ORR_zzz			00000100 01 1 ..... 001 100 ..... .....		@rd_rn_rm
 EOR_zzz			00000100 10 1 ..... 001 100 ..... .....		@rd_rn_rm
 BIC_zzz			00000100 11 1 ..... 001 100 ..... .....		@rd_rn_rm
+
+### SVE Predicate Generation Group
+
+# SVE initialize predicate (PTRUE, PTRUES)
+pred_set		00100101 esz:2 011 00 s:1 111000 pat:5 0 rd:4	&pred_set i=1
+
+# SVE zero predicate register (PFALSE)
+pred_set		00100101 00 011 000 1110 0100 0000 rd:4		&pred_set pat=31 esz=0 i=0 s=0
+
+# SVE initialize FFR (SETFFR)
+pred_set		00100101 0010 1100 1001 0000 0000 0000		&pred_set pat=31 esz=0 rd=16 i=1 s=0
-- 
2.14.3
