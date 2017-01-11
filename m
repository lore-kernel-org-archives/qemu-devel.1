Received: from eggs.gnu.org ([2001:4830:134:3::10]:35083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Um-00066g-8w
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cR8Ul-00038z-5x
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:36 -0500
Received: from mail-pf0-x241.google.com ([2607:f8b0:400e:c00::241]:35026)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cR8Uk-00038c-Tr
	for qemu-devel@nongnu.org; Tue, 10 Jan 2017 21:18:35 -0500
Received: by mail-pf0-x241.google.com with SMTP id f144so12524622pfa.2
	for <qemu-devel@nongnu.org>; Tue, 10 Jan 2017 18:18:34 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 10 Jan 2017 18:17:29 -0800
Message-Id: <20170111021820.24416-15-rth@twiddle.net>
In-Reply-To: <20170111021820.24416-1-rth@twiddle.net>
References: <20170111021820.24416-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 14/65] target-arm: Use new deposit and extract
 ops
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

Use the new primitives for UBFX and SBFX.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/arm/translate-a64.c | 81 +++++++++++++++++-----------------------------
 target/arm/translate.c     | 37 +++++----------------
 2 files changed, 37 insertions(+), 81 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index f673d93..a59c90c 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -3216,67 +3216,44 @@ static void disas_bitfield(DisasContext *s, uint32_t insn)
        low 32-bits anyway.  */
     tcg_tmp = read_cpu_reg(s, rn, 1);
 
-    /* Recognize the common aliases.  */
-    if (opc == 0) { /* SBFM */
-        if (ri == 0) {
-            if (si == 7) { /* SXTB */
-                tcg_gen_ext8s_i64(tcg_rd, tcg_tmp);
-                goto done;
-            } else if (si == 15) { /* SXTH */
-                tcg_gen_ext16s_i64(tcg_rd, tcg_tmp);
-                goto done;
-            } else if (si == 31) { /* SXTW */
-                tcg_gen_ext32s_i64(tcg_rd, tcg_tmp);
-                goto done;
-            }
-        }
-        if (si == 63 || (si == 31 && ri <= si)) { /* ASR */
-            if (si == 31) {
-                tcg_gen_ext32s_i64(tcg_tmp, tcg_tmp);
-            }
-            tcg_gen_sari_i64(tcg_rd, tcg_tmp, ri);
+    /* Recognize simple(r) extractions.  */
+    if (si <= ri) {
+        /* Wd<s-r:0> = Wn<s:r> */
+        len = (si - ri) + 1;
+        if (opc == 0) { /* SBFM: ASR, SBFX, SXTB, SXTH, SXTW */
+            tcg_gen_sextract_i64(tcg_rd, tcg_tmp, ri, len);
             goto done;
-        }
-    } else if (opc == 2) { /* UBFM */
-        if (ri == 0) { /* UXTB, UXTH, plus non-canonical AND */
-            tcg_gen_andi_i64(tcg_rd, tcg_tmp, bitmask64(si + 1));
+        } else if (opc == 2) { /* UBFM: UBFX, LSR, UXTB, UXTH */
+            tcg_gen_extract_i64(tcg_rd, tcg_tmp, ri, len);
             return;
         }
-        if (si == 63 || (si == 31 && ri <= si)) { /* LSR */
-            if (si == 31) {
-                tcg_gen_ext32u_i64(tcg_tmp, tcg_tmp);
-            }
-            tcg_gen_shri_i64(tcg_rd, tcg_tmp, ri);
-            return;
-        }
-        if (si + 1 == ri && si != bitsize - 1) { /* LSL */
-            int shift = bitsize - 1 - si;
-            tcg_gen_shli_i64(tcg_rd, tcg_tmp, shift);
-            goto done;
-        }
-    }
-
-    if (opc != 1) { /* SBFM or UBFM */
-        tcg_gen_movi_i64(tcg_rd, 0);
-    }
-
-    /* do the bit move operation */
-    if (si >= ri) {
-        /* Wd<s-r:0> = Wn<s:r> */
-        tcg_gen_shri_i64(tcg_tmp, tcg_tmp, ri);
+        /* opc == 1, BXFIL fall through to deposit */
+        tcg_gen_extract_i64(tcg_tmp, tcg_tmp, ri, len);
         pos = 0;
-        len = (si - ri) + 1;
     } else {
-        /* Wd<32+s-r,32-r> = Wn<s:0> */
-        pos = bitsize - ri;
+        /* Handle the ri > si case with a deposit
+         * Wd<32+s-r,32-r> = Wn<s:0>
+         */
         len = si + 1;
+        pos = (bitsize - ri) & (bitsize - 1);
     }
 
-    tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
+    if (opc == 0 && len < ri) {
+        /* SBFM: sign extend the destination field from len to fill
+           the balance of the word.  Let the deposit below insert all
+           of those sign bits.  */
+        tcg_gen_sextract_i64(tcg_tmp, tcg_tmp, 0, len);
+        len = ri;
+    }
 
-    if (opc == 0) { /* SBFM - sign extend the destination field */
-        tcg_gen_shli_i64(tcg_rd, tcg_rd, 64 - (pos + len));
-        tcg_gen_sari_i64(tcg_rd, tcg_rd, 64 - (pos + len));
+    if (opc == 1) { /* BFM, BXFIL */
+        tcg_gen_deposit_i64(tcg_rd, tcg_rd, tcg_tmp, pos, len);
+    } else {
+        /* SBFM or UBFM: We start with zero, and we haven't modified
+           any bits outside bitsize, therefore the zero-extension
+           below is unneeded.  */
+        tcg_gen_deposit_z_i64(tcg_rd, tcg_tmp, pos, len);
+        return;
     }
 
  done:
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 0ad9070..08da9ac 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -288,29 +288,6 @@ static void gen_revsh(TCGv_i32 var)
     tcg_gen_ext16s_i32(var, var);
 }
 
-/* Unsigned bitfield extract.  */
-static void gen_ubfx(TCGv_i32 var, int shift, uint32_t mask)
-{
-    if (shift)
-        tcg_gen_shri_i32(var, var, shift);
-    tcg_gen_andi_i32(var, var, mask);
-}
-
-/* Signed bitfield extract.  */
-static void gen_sbfx(TCGv_i32 var, int shift, int width)
-{
-    uint32_t signbit;
-
-    if (shift)
-        tcg_gen_sari_i32(var, var, shift);
-    if (shift + width < 32) {
-        signbit = 1u << (width - 1);
-        tcg_gen_andi_i32(var, var, (1u << width) - 1);
-        tcg_gen_xori_i32(var, var, signbit);
-        tcg_gen_subi_i32(var, var, signbit);
-    }
-}
-
 /* Return (b << 32) + a. Mark inputs as dead */
 static TCGv_i64 gen_addq_msw(TCGv_i64 a, TCGv_i32 b)
 {
@@ -9178,9 +9155,9 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                             goto illegal_op;
                         if (i < 32) {
                             if (op1 & 0x20) {
-                                gen_ubfx(tmp, shift, (1u << i) - 1);
+                                tcg_gen_extract_i32(tmp, tmp, shift, i);
                             } else {
-                                gen_sbfx(tmp, shift, i);
+                                tcg_gen_sextract_i32(tmp, tmp, shift, i);
                             }
                         }
                         store_reg(s, rd, tmp);
@@ -10497,15 +10474,17 @@ static int disas_thumb2_insn(CPUARMState *env, DisasContext *s, uint16_t insn_hw
                         imm++;
                         if (shift + imm > 32)
                             goto illegal_op;
-                        if (imm < 32)
-                            gen_sbfx(tmp, shift, imm);
+                        if (imm < 32) {
+                            tcg_gen_sextract_i32(tmp, tmp, shift, imm);
+                        }
                         break;
                     case 6: /* Unsigned bitfield extract.  */
                         imm++;
                         if (shift + imm > 32)
                             goto illegal_op;
-                        if (imm < 32)
-                            gen_ubfx(tmp, shift, (1u << imm) - 1);
+                        if (imm < 32) {
+                            tcg_gen_extract_i32(tmp, tmp, shift, imm);
+                        }
                         break;
                     case 3: /* Bitfield insert/clear.  */
                         if (imm < shift)
-- 
2.9.3
