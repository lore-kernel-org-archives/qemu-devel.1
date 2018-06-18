Received: from eggs.gnu.org ([2001:4830:134:3::10]:44148)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEM-0002RT-PU
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fUyEL-0004oi-CK
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:18 -0400
Received: from chuckie.co.uk ([82.165.15.123]:45025
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fUyEL-0004i3-26
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 13:46:17 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Mon, 18 Jun 2018 18:45:38 +0100
Message-Id: <20180618174538.30092-4-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
References: <20180618174538.30092-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [PULL 3/3] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org

This patch adds gen_io_start()/gen_io_end() to various instructions as required
in order to boot my OpenBIOS test images on qemu-system-sparc64 with icount
enabled.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 111 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 110 insertions(+), 1 deletion(-)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f3d430c1b2..74315cdf09 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -41,6 +41,8 @@
 #define JUMP_PC     2 /* dynamic pc value which takes only two values
                          according to jump_pc[T2] */
 
+#define DISAS_EXIT  DISAS_TARGET_0
+
 /* global register indexes */
 static TCGv_ptr cpu_regwptr;
 static TCGv cpu_cc_src, cpu_cc_src2, cpu_cc_dst;
@@ -3400,11 +3402,17 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
+                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
+                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 0x5: /* V9 rdpc */
@@ -3447,11 +3455,17 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, stick));
+                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
+                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 0x19: /* System tick compare */
@@ -3576,10 +3590,16 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
+                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_tmp0, cpu_env,
                                                   r_tickptr, r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
+                        if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 5: // tba
@@ -4385,9 +4405,19 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_tick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                    }
+                                    /* End TB to handle timer interrupt */
+                                    dc->base.is_jmp = DISAS_EXIT;
                                 }
                                 break;
                             case 0x18: /* System tick */
@@ -4403,9 +4433,19 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                    }
+                                    /* End TB to handle timer interrupt */
+                                    dc->base.is_jmp = DISAS_EXIT;
                                 }
                                 break;
                             case 0x19: /* System tick compare */
@@ -4421,9 +4461,19 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_stick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                    }
+                                    /* End TB to handle timer interrupt */
+                                    dc->base.is_jmp = DISAS_EXIT;
                                 }
                                 break;
 
@@ -4531,9 +4581,19 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                    }
+                                    /* End TB to handle timer interrupt */
+                                    dc->base.is_jmp = DISAS_EXIT;
                                 }
                                 break;
                             case 5: // tba
@@ -4541,7 +4601,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 break;
                             case 6: // pstate
                                 save_state(dc);
+                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                    gen_io_start();
+                                }
                                 gen_helper_wrpstate(cpu_env, cpu_tmp0);
+                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                    gen_io_end();
+                                }
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 7: // tl
@@ -4551,7 +4617,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 8: // pil
+                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                    gen_io_start();
+                                }
                                 gen_helper_wrpil(cpu_env, cpu_tmp0);
+                                if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                    gen_io_end();
+                                }
                                 break;
                             case 9: // cwp
                                 gen_helper_wrcwp(cpu_env, cpu_tmp0);
@@ -4642,9 +4714,19 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, hstick));
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_hstick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (tb_cflags(dc->base.tb) &
+                                           CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                    }
+                                    /* End TB to handle timer interrupt */
+                                    dc->base.is_jmp = DISAS_EXIT;
                                 }
                                 break;
                             case 6: // hver readonly
@@ -5265,14 +5347,26 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
+                            if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                gen_io_start();
+                            }
                             gen_helper_done(cpu_env);
+                            if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                gen_io_end();
+                            }
                             goto jmp_insn;
                         case 1:
                             if (!supervisor(dc))
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
+                            if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                gen_io_start();
+                            }
                             gen_helper_retry(cpu_env);
+                            if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
+                                gen_io_end();
+                            }
                             goto jmp_insn;
                         default:
                             goto illegal_insn;
@@ -5822,7 +5916,9 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
 {
     DisasContext *dc = container_of(dcbase, DisasContext, base);
 
-    if (dc->base.is_jmp != DISAS_NORETURN) {
+    switch (dc->base.is_jmp) {
+    case DISAS_NEXT:
+    case DISAS_TOO_MANY:
         if (dc->pc != DYNAMIC_PC &&
             (dc->npc != DYNAMIC_PC && dc->npc != JUMP_PC)) {
             /* static PC and NPC: we can use direct chaining */
@@ -5834,6 +5930,19 @@ static void sparc_tr_tb_stop(DisasContextBase *dcbase, CPUState *cs)
             save_npc(dc);
             tcg_gen_exit_tb(NULL, 0);
         }
+        break;
+
+    case DISAS_NORETURN:
+       break;
+
+    case DISAS_EXIT:
+        /* Exit TB */
+        save_state(dc);
+        tcg_gen_exit_tb(NULL, 0);
+        break;
+
+    default:
+        g_assert_not_reached();
     }
 }
 
-- 
2.11.0
