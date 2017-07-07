Received: from eggs.gnu.org ([2001:4830:134:3::10]:33833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTItv-0000tg-Bf
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1dTItt-0007Yu-Vx
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:47 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:33147)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1dTItt-0007YJ-Rx
	for qemu-devel@nongnu.org; Thu, 06 Jul 2017 22:21:45 -0400
Received: by mail-qt0-x242.google.com with SMTP id c20so2720580qte.0
	for <qemu-devel@nongnu.org>; Thu, 06 Jul 2017 19:21:45 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
From: Richard Henderson <rth@twiddle.net>
Date: Thu,  6 Jul 2017 16:20:45 -1000
Message-Id: <20170707022111.21836-2-rth@twiddle.net>
In-Reply-To: <20170707022111.21836-1-rth@twiddle.net>
References: <20170707022111.21836-1-rth@twiddle.net>
Subject: [Qemu-devel] [PATCH v2 01/27] target/sh4: Use cmpxchg for movco
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, laurent@vivier.eu, bruno@clisp.org, glaubitz@debian.org

As for other targets, cmpxchg isn't quite right for ll/sc,
suffering from an ABA race, but is sufficient to implement
portable atomic operations.

Signed-off-by: Richard Henderson <rth@twiddle.net>
---
 target/sh4/cpu.h       |  3 ++-
 target/sh4/translate.c | 56 +++++++++++++++++++++++++++++++++-----------------
 2 files changed, 39 insertions(+), 20 deletions(-)

diff --git a/target/sh4/cpu.h b/target/sh4/cpu.h
index ffb9168..b15116e 100644
--- a/target/sh4/cpu.h
+++ b/target/sh4/cpu.h
@@ -169,7 +169,8 @@ typedef struct CPUSH4State {
     tlb_t itlb[ITLB_SIZE];	/* instruction translation table */
     tlb_t utlb[UTLB_SIZE];	/* unified translation table */
 
-    uint32_t ldst;
+    uint32_t lock_addr;
+    uint32_t lock_value;
 
     /* Fields up to this point are cleared by a CPU reset */
     struct {} end_reset_fields;
diff --git a/target/sh4/translate.c b/target/sh4/translate.c
index 4c3512f..82d4d69 100644
--- a/target/sh4/translate.c
+++ b/target/sh4/translate.c
@@ -68,7 +68,8 @@ static TCGv cpu_gregs[24];
 static TCGv cpu_sr, cpu_sr_m, cpu_sr_q, cpu_sr_t;
 static TCGv cpu_pc, cpu_ssr, cpu_spc, cpu_gbr;
 static TCGv cpu_vbr, cpu_sgr, cpu_dbr, cpu_mach, cpu_macl;
-static TCGv cpu_pr, cpu_fpscr, cpu_fpul, cpu_ldst;
+static TCGv cpu_pr, cpu_fpscr, cpu_fpul;
+static TCGv cpu_lock_addr, cpu_lock_value;
 static TCGv cpu_fregs[32];
 
 /* internal register indexes */
@@ -151,8 +152,12 @@ void sh4_translate_init(void)
                                               offsetof(CPUSH4State,
                                                        delayed_cond),
                                               "_delayed_cond_");
-    cpu_ldst = tcg_global_mem_new_i32(cpu_env,
-				      offsetof(CPUSH4State, ldst), "_ldst_");
+    cpu_lock_addr = tcg_global_mem_new_i32(cpu_env,
+				           offsetof(CPUSH4State, lock_addr),
+                                           "_lock_addr_");
+    cpu_lock_value = tcg_global_mem_new_i32(cpu_env,
+				            offsetof(CPUSH4State, lock_value),
+                                            "_lock_value_");
 
     for (i = 0; i < 32; i++)
         cpu_fregs[i] = tcg_global_mem_new_i32(cpu_env,
@@ -1528,20 +1533,32 @@ static void _decode_opc(DisasContext * ctx)
 	return;
     case 0x0073:
         /* MOVCO.L
-	       LDST -> T
+               LDST -> T
                If (T == 1) R0 -> (Rn)
                0 -> LDST
         */
         if (ctx->features & SH_FEATURE_SH4A) {
-            TCGLabel *label = gen_new_label();
-            tcg_gen_mov_i32(cpu_sr_t, cpu_ldst);
-	    tcg_gen_brcondi_i32(TCG_COND_EQ, cpu_ldst, 0, label);
-            tcg_gen_qemu_st_i32(REG(0), REG(B11_8), ctx->memidx, MO_TEUL);
-	    gen_set_label(label);
-	    tcg_gen_movi_i32(cpu_ldst, 0);
-	    return;
-	} else
-	    break;
+            TCGLabel *fail = gen_new_label();
+            TCGLabel *done = gen_new_label();
+            TCGv tmp;
+
+            tcg_gen_brcond_i32(TCG_COND_NE, REG(B11_8), cpu_lock_addr, fail);
+
+            tmp = tcg_temp_new();
+            tcg_gen_atomic_cmpxchg_i32(tmp, REG(B11_8), cpu_lock_value,
+                                       REG(0), ctx->memidx, MO_TEUL);
+            tcg_gen_setcond_i32(TCG_COND_EQ, cpu_sr_t, tmp, cpu_lock_value);
+            tcg_temp_free(tmp);
+            tcg_gen_br(done);
+
+            gen_set_label(fail);
+            tcg_gen_movi_i32(cpu_sr_t, 0);
+
+            gen_set_label(done);
+            return;
+        } else {
+            break;
+        }
     case 0x0063:
         /* MOVLI.L @Rm,R0
                1 -> LDST
@@ -1549,13 +1566,14 @@ static void _decode_opc(DisasContext * ctx)
                When interrupt/exception
                occurred 0 -> LDST
         */
-	if (ctx->features & SH_FEATURE_SH4A) {
-	    tcg_gen_movi_i32(cpu_ldst, 0);
+        if (ctx->features & SH_FEATURE_SH4A) {
             tcg_gen_qemu_ld_i32(REG(0), REG(B11_8), ctx->memidx, MO_TESL);
-	    tcg_gen_movi_i32(cpu_ldst, 1);
-	    return;
-	} else
-	    break;
+            tcg_gen_mov_i32(cpu_lock_addr, REG(B11_8));
+            tcg_gen_mov_i32(cpu_lock_value, REG(0));
+            return;
+        } else {
+            break;
+        }
     case 0x0093:		/* ocbi @Rn */
 	{
             gen_helper_ocbi(cpu_env, REG(B11_8));
-- 
2.9.4
