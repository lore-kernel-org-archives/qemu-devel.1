Received: from eggs.gnu.org ([2001:4830:134:3::10]:59174)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDVA-00089n-16
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:37:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gVDV9-0007ci-5Z
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:55 -0500
Received: from mail-ot1-x32d.google.com ([2607:f8b0:4864:20::32d]:43461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gVDV9-0007c4-0b
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 05:36:55 -0500
Received: by mail-ot1-x32d.google.com with SMTP id a11so3336493otr.10
	for <qemu-devel@nongnu.org>; Fri, 07 Dec 2018 02:36:54 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri,  7 Dec 2018 04:36:17 -0600
Message-Id: <20181207103631.28193-13-richard.henderson@linaro.org>
In-Reply-To: <20181207103631.28193-1-richard.henderson@linaro.org>
References: <20181207103631.28193-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 12/26] target/arm: Decode PAuth within
 disas_uncond_b_reg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, ramana.radhakrishnan@arm.com

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 100 +++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 5 deletions(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index 5fa2647771..d4df2b48b1 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1982,6 +1982,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 {
     unsigned int opc, op2, op3, rn, op4;
     TCGv_i64 dst;
+    TCGv_i64 modifier;
 
     opc = extract32(insn, 21, 4);
     op2 = extract32(insn, 16, 5);
@@ -1997,9 +1998,47 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
     case 0: /* BR */
     case 1: /* BLR */
     case 2: /* RET */
-        if (op3 == 0 && op4 == 0) {
+        switch (op3) {
+        case 0:
+            /* BR, BLR, RET */
+            if (op4 != 0) {
+                goto do_unallocated;
+            }
             dst = cpu_reg(s, rn);
-        } else {
+            break;
+
+        case 2:
+        case 3:
+            if (!dc_isar_feature(aa64_pauth, s)) {
+                goto do_unallocated;
+            }
+            if (opc == 2) {
+                /* RETAA, RETAB */
+                if (rn != 0x1f || op4 != 0x1f) {
+                    goto do_unallocated;
+                }
+                rn = 30;
+                modifier = cpu_X[31];
+            } else {
+                /* BRAAZ, BRABZ, BLRAAZ, BLRABZ */
+                if (op4 != 0x1f) {
+                    goto do_unallocated;
+                }
+                modifier = new_tmp_a64_zero(s);
+            }
+            if (s->pauth_active) {
+                dst = new_tmp_a64(s);
+                if (op3 == 2) {
+                    gen_helper_autia(dst, cpu_env, cpu_reg(s, rn), modifier);
+                } else {
+                    gen_helper_autib(dst, cpu_env, cpu_reg(s, rn), modifier);
+                }
+            } else {
+                dst = cpu_reg(s, rn);
+            }
+            break;
+
+        default:
             goto do_unallocated;
         }
         gen_a64_set_pc(s, dst);
@@ -2009,6 +2048,32 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         }
         break;
 
+    case 8: /* BRAA */
+    case 9: /* BLRAA */
+        if (!dc_isar_feature(aa64_pauth, s)) {
+            goto do_unallocated;
+        }
+        if (op3 != 2 || op3 != 3) {
+            goto do_unallocated;
+        }
+        if (s->pauth_active) {
+            dst = new_tmp_a64(s);
+            modifier = cpu_reg_sp(s, op4);
+            if (op3 == 2) {
+                gen_helper_autia(dst, cpu_env, cpu_reg(s, rn), modifier);
+            } else {
+                gen_helper_autib(dst, cpu_env, cpu_reg(s, rn), modifier);
+            }
+        } else {
+            dst = cpu_reg(s, rn);
+        }
+        gen_a64_set_pc(s, dst);
+        /* BLRAA also needs to load return address */
+        if (opc == 9) {
+            tcg_gen_movi_i64(cpu_reg(s, 30), s->pc);
+        }
+        break;
+
     case 4: /* ERET */
         if (s->current_el == 0) {
             goto do_unallocated;
@@ -2016,11 +2081,36 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
         dst = tcg_temp_new_i64();
         tcg_gen_ld_i64(dst, cpu_env,
                        offsetof(CPUARMState, elr_el[s->current_el]));
-        if (op3 == 0 && op4 == 0) {
-            ;
-        } else {
+
+        switch (op3) {
+        case 0: /* ERET */
+            if (op4 != 0) {
+                goto do_unallocated;
+            }
+            break;
+
+        case 2: /* ERETAA */
+        case 3: /* ERETAB */
+            if (!dc_isar_feature(aa64_pauth, s)) {
+                goto do_unallocated;
+            }
+            if (rn != 0x1f || op4 != 0x1f) {
+                goto do_unallocated;
+            }
+            if (s->pauth_active) {
+                modifier = cpu_X[31];
+                if (op3 == 2) {
+                    gen_helper_autia(dst, cpu_env, dst, modifier);
+                } else {
+                    gen_helper_autib(dst, cpu_env, dst, modifier);
+                }
+            }
+            break;
+
+        default:
             goto do_unallocated;
         }
+
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
         }
-- 
2.17.2
