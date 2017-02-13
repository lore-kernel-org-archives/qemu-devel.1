Received: from eggs.gnu.org ([2001:4830:134:3::10]:45351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8e-0004pR-Ah
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cdO8c-0001Q2-Iy
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:24 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33855)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cdO8c-0001Pl-Du
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 16:26:22 -0500
Received: by mail-qt0-x243.google.com with SMTP id w20so14930601qtb.1
	for <qemu-devel@nongnu.org>; Mon, 13 Feb 2017 13:26:22 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Tue, 14 Feb 2017 08:25:23 +1100
Message-Id: <20170213212536.31871-12-rth@twiddle.net>
In-Reply-To: <20170213212536.31871-1-rth@twiddle.net>
References: <20170213212536.31871-1-rth@twiddle.net>
Subject: [Qemu-devel] [PULL 11/24] target/openrisc: Invert the decoding in
 dec_calc
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

Decoding the opcodes in the right order reduces by 100+ lines.
Also, it happens to put the opcodes in the same order as Chapter 17.

Reviewed-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/openrisc/translate.c | 302 ++++++++++++++------------------------------
 1 file changed, 95 insertions(+), 207 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index b8116ba..1f3f22c 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -465,133 +465,95 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
     rb = extract32(insn, 11, 5);
     rd = extract32(insn, 21, 5);
 
-    switch (op0) {
-    case 0x0000:
-        switch (op1) {
-        case 0x00:    /* l.add */
+    switch (op1) {
+    case 0:
+        switch (op0) {
+        case 0x0: /* l.add */
             LOG_DIS("l.add r%d, r%d, r%d\n", rd, ra, rb);
             gen_add(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+            return;
 
-    case 0x0001:    /* l.addc */
-        switch (op1) {
-        case 0x00:
+        case 0x1: /* l.addc */
             LOG_DIS("l.addc r%d, r%d, r%d\n", rd, ra, rb);
             gen_addc(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+            return;
 
-    case 0x0002:    /* l.sub */
-        switch (op1) {
-        case 0x00:
+        case 0x2: /* l.sub */
             LOG_DIS("l.sub r%d, r%d, r%d\n", rd, ra, rb);
             gen_sub(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+            return;
 
-    case 0x0003:    /* l.and */
-        switch (op1) {
-        case 0x00:
+        case 0x3: /* l.and */
             LOG_DIS("l.and r%d, r%d, r%d\n", rd, ra, rb);
             tcg_gen_and_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+            return;
 
-    case 0x0004:    /* l.or */
-        switch (op1) {
-        case 0x00:
+        case 0x4: /* l.or */
             LOG_DIS("l.or r%d, r%d, r%d\n", rd, ra, rb);
             tcg_gen_or_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+            return;
 
-    case 0x0005:
-        switch (op1) {
-        case 0x00:    /* l.xor */
+        case 0x5: /* l.xor */
             LOG_DIS("l.xor r%d, r%d, r%d\n", rd, ra, rb);
             tcg_gen_xor_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
-
-    case 0x0006:
-        switch (op1) {
-        case 0x03:    /* l.mul */
-            LOG_DIS("l.mul r%d, r%d, r%d\n", rd, ra, rb);
-            gen_mul(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
-
-    case 0x0009:
-        switch (op1) {
-        case 0x03:    /* l.div */
-            LOG_DIS("l.div r%d, r%d, r%d\n", rd, ra, rb);
-            gen_div(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
-
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
-
-    case 0x000a:
-        switch (op1) {
-        case 0x03:    /* l.divu */
-            LOG_DIS("l.divu r%d, r%d, r%d\n", rd, ra, rb);
-            gen_divu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-            break;
+            return;
 
-        default:
-            gen_illegal_exception(dc);
+        case 0x8:
+            switch (op2) {
+            case 0: /* l.sll */
+                LOG_DIS("l.sll r%d, r%d, r%d\n", rd, ra, rb);
+                tcg_gen_shl_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+                return;
+            case 1: /* l.srl */
+                LOG_DIS("l.srl r%d, r%d, r%d\n", rd, ra, rb);
+                tcg_gen_shr_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+                return;
+            case 2: /* l.sra */
+                LOG_DIS("l.sra r%d, r%d, r%d\n", rd, ra, rb);
+                tcg_gen_sar_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+                return;
+            case 3: /* l.ror */
+                LOG_DIS("l.ror r%d, r%d, r%d\n", rd, ra, rb);
+                tcg_gen_rotr_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+                return;
+            }
             break;
-        }
-        break;
 
-    case 0x000b:
-        switch (op1) {
-        case 0x03:    /* l.mulu */
-            LOG_DIS("l.mulu r%d, r%d, r%d\n", rd, ra, rb);
-            gen_mulu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+        case 0xc:
+            switch (op2) {
+            case 0: /* l.exths */
+                LOG_DIS("l.exths r%d, r%d\n", rd, ra);
+                tcg_gen_ext16s_tl(cpu_R[rd], cpu_R[ra]);
+                return;
+            case 1: /* l.extbs */
+                LOG_DIS("l.extbs r%d, r%d\n", rd, ra);
+                tcg_gen_ext8s_tl(cpu_R[rd], cpu_R[ra]);
+                return;
+            case 2: /* l.exthz */
+                LOG_DIS("l.exthz r%d, r%d\n", rd, ra);
+                tcg_gen_ext16u_tl(cpu_R[rd], cpu_R[ra]);
+                return;
+            case 3: /* l.extbz */
+                LOG_DIS("l.extbz r%d, r%d\n", rd, ra);
+                tcg_gen_ext8u_tl(cpu_R[rd], cpu_R[ra]);
+                return;
+            }
             break;
 
-        default:
-            gen_illegal_exception(dc);
+        case 0xd:
+            switch (op2) {
+            case 0: /* l.extws */
+                LOG_DIS("l.extws r%d, r%d\n", rd, ra);
+                tcg_gen_ext32s_tl(cpu_R[rd], cpu_R[ra]);
+                return;
+            case 1: /* l.extwz */
+                LOG_DIS("l.extwz r%d, r%d\n", rd, ra);
+                tcg_gen_ext32u_tl(cpu_R[rd], cpu_R[ra]);
+                return;
+            }
             break;
-        }
-        break;
 
-    case 0x000e:
-        switch (op1) {
-        case 0x00:    /* l.cmov */
+        case 0xe: /* l.cmov */
             LOG_DIS("l.cmov r%d, r%d, r%d\n", rd, ra, rb);
             {
                 TCGLabel *lab = gen_new_label();
@@ -606,128 +568,54 @@ static void dec_calc(DisasContext *dc, uint32_t insn)
                 tcg_temp_free(sr_f);
                 tcg_temp_free(res);
             }
-            break;
-
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+            return;
 
-    case 0x000f:
-        switch (op1) {
-        case 0x00:    /* l.ff1 */
+        case 0xf: /* l.ff1 */
             LOG_DIS("l.ff1 r%d, r%d, r%d\n", rd, ra, rb);
             tcg_gen_ctzi_tl(cpu_R[rd], cpu_R[ra], -1);
             tcg_gen_addi_tl(cpu_R[rd], cpu_R[rd], 1);
-            break;
-        case 0x01:    /* l.fl1 */
+            return;
+        }
+        break;
+
+    case 1:
+        switch (op0) {
+        case 0xf: /* l.fl1 */
             LOG_DIS("l.fl1 r%d, r%d, r%d\n", rd, ra, rb);
             tcg_gen_clzi_tl(cpu_R[rd], cpu_R[ra], TARGET_LONG_BITS);
             tcg_gen_subfi_tl(cpu_R[rd], TARGET_LONG_BITS, cpu_R[rd]);
-            break;
-
-        default:
-            gen_illegal_exception(dc);
-            break;
+            return;
         }
         break;
 
-    case 0x0008:
-        switch (op1) {
-        case 0x00:
-            switch (op2) {
-            case 0x00:    /* l.sll */
-                LOG_DIS("l.sll r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_shl_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                break;
-            case 0x01:    /* l.srl */
-                LOG_DIS("l.srl r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_shr_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                break;
-            case 0x02:    /* l.sra */
-                LOG_DIS("l.sra r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_sar_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                break;
-            case 0x03:    /* l.ror */
-                LOG_DIS("l.ror r%d, r%d, r%d\n", rd, ra, rb);
-                tcg_gen_rotr_tl(cpu_R[rd], cpu_R[ra], cpu_R[rb]);
-                break;
-
-            default:
-                gen_illegal_exception(dc);
-                break;
-            }
-            break;
-
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
+    case 2:
         break;
 
-    case 0x000c:
-        switch (op1) {
-        case 0x00:
-            switch (op2) {
-            case 0x00:    /* l.exths */
-                LOG_DIS("l.exths r%d, r%d\n", rd, ra);
-                tcg_gen_ext16s_tl(cpu_R[rd], cpu_R[ra]);
-                break;
-            case 0x01:    /* l.extbs */
-                LOG_DIS("l.extbs r%d, r%d\n", rd, ra);
-                tcg_gen_ext8s_tl(cpu_R[rd], cpu_R[ra]);
-                break;
-            case 0x02:    /* l.exthz */
-                LOG_DIS("l.exthz r%d, r%d\n", rd, ra);
-                tcg_gen_ext16u_tl(cpu_R[rd], cpu_R[ra]);
-                break;
-            case 0x03:    /* l.extbz */
-                LOG_DIS("l.extbz r%d, r%d\n", rd, ra);
-                tcg_gen_ext8u_tl(cpu_R[rd], cpu_R[ra]);
-                break;
-
-            default:
-                gen_illegal_exception(dc);
-                break;
-            }
-            break;
-
-        default:
-            gen_illegal_exception(dc);
-            break;
-        }
-        break;
+    case 3:
+        switch (op0) {
+        case 0x6: /* l.mul */
+            LOG_DIS("l.mul r%d, r%d, r%d\n", rd, ra, rb);
+            gen_mul(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+            return;
 
-    case 0x000d:
-        switch (op1) {
-        case 0x00:
-            switch (op2) {
-            case 0x00:    /* l.extws */
-                LOG_DIS("l.extws r%d, r%d\n", rd, ra);
-                tcg_gen_ext32s_tl(cpu_R[rd], cpu_R[ra]);
-                break;
-            case 0x01:    /* l.extwz */
-                LOG_DIS("l.extwz r%d, r%d\n", rd, ra);
-                tcg_gen_ext32u_tl(cpu_R[rd], cpu_R[ra]);
-                break;
+        case 0x9: /* l.div */
+            LOG_DIS("l.div r%d, r%d, r%d\n", rd, ra, rb);
+            gen_div(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+            return;
 
-            default:
-                gen_illegal_exception(dc);
-                break;
-            }
-            break;
+        case 0xa: /* l.divu */
+            LOG_DIS("l.divu r%d, r%d, r%d\n", rd, ra, rb);
+            gen_divu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+            return;
 
-        default:
-            gen_illegal_exception(dc);
-            break;
+        case 0xb: /* l.mulu */
+            LOG_DIS("l.mulu r%d, r%d, r%d\n", rd, ra, rb);
+            gen_mulu(dc, cpu_R[rd], cpu_R[ra], cpu_R[rb]);
+            return;
         }
         break;
-
-    default:
-        gen_illegal_exception(dc);
-        break;
     }
+    gen_illegal_exception(dc);
 }
 
 static void dec_misc(DisasContext *dc, uint32_t insn)
-- 
2.9.3
