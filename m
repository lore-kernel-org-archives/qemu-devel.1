Received: from eggs.gnu.org ([209.51.188.92]:52695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv5-00009q-B0
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1ggzv4-0004lD-D8
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:23 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:34528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1ggzv3-0004b3-Gs
	for qemu-devel@nongnu.org; Tue, 08 Jan 2019 17:32:21 -0500
Received: by mail-pf1-x442.google.com with SMTP id h3so2625655pfg.1
	for <qemu-devel@nongnu.org>; Tue, 08 Jan 2019 14:32:11 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Wed,  9 Jan 2019 08:31:11 +1000
Message-Id: <20190108223129.5570-14-richard.henderson@linaro.org>
In-Reply-To: <20190108223129.5570-1-richard.henderson@linaro.org>
References: <20190108223129.5570-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v3 13/31] target/arm: Decode PAuth within
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
Cc: peter.maydell@linaro.org

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate-a64.c | 82 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 81 insertions(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index e601753032..fa50003f0b 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1982,6 +1982,7 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 {
     unsigned int opc, op2, op3, rn, op4;
     TCGv_i64 dst;
+    TCGv_i64 modifier;
 
     opc = extract32(insn, 21, 4);
     op2 = extract32(insn, 16, 5);
@@ -1999,12 +2000,44 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
     case 2: /* RET */
         switch (op3) {
         case 0:
+            /* BR, BLR, RET */
             if (op4 != 0) {
                 goto do_unallocated;
             }
             dst = cpu_reg(s, rn);
             break;
 
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
         default:
             goto do_unallocated;
         }
@@ -2016,12 +2049,38 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
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
         }
         switch (op3) {
-        case 0:
+        case 0: /* ERET */
             if (op4 != 0) {
                 goto do_unallocated;
             }
@@ -2030,6 +2089,27 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
                            offsetof(CPUARMState, elr_el[s->current_el]));
             break;
 
+        case 2: /* ERETAA */
+        case 3: /* ERETAB */
+            if (!dc_isar_feature(aa64_pauth, s)) {
+                goto do_unallocated;
+            }
+            if (rn != 0x1f || op4 != 0x1f) {
+                goto do_unallocated;
+            }
+            dst = tcg_temp_new_i64();
+            tcg_gen_ld_i64(dst, cpu_env,
+                           offsetof(CPUARMState, elr_el[s->current_el]));
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
         default:
             goto do_unallocated;
         }
-- 
2.17.2
