Received: from eggs.gnu.org ([2001:4830:134:3::10]:39975)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTPsv-0005wK-LB
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:53:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fTPst-00086J-2j
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:53:45 -0400
Received: from chuckie.co.uk ([82.165.15.123]:34366
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fTPss-000800-Oh
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 06:53:43 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Thu, 14 Jun 2018 11:53:23 +0100
Message-Id: <20180614105323.22524-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180614105323.22524-1-mark.cave-ayland@ilande.co.uk>
References: <20180614105323.22524-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFCv2 PATCH 1/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com, cota@braap.org, richard.henderson@linaro.org

This patch adds gen_io_start()/gen_io_end() to various instructions as required
in order to boot my OpenBIOS test images on qemu-system-sparc64 with icount
enabled.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index f3d430c1b2..56101387a8 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3400,11 +3400,17 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
+                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
+                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 0x5: /* V9 rdpc */
@@ -3447,11 +3453,17 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, stick));
+                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
+                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 0x19: /* System tick compare */
@@ -3576,10 +3588,16 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
+                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_tmp0, cpu_env,
                                                   r_tickptr, r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
+                        if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 5: // tba
@@ -4385,9 +4403,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_tick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(NULL, 0);
+                                        dc->base.is_jmp = DISAS_NORETURN;
+                                    }
                                 }
                                 break;
                             case 0x18: /* System tick */
@@ -4403,9 +4432,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(NULL, 0);
+                                        dc->base.is_jmp = DISAS_NORETURN;
+                                    }
                                 }
                                 break;
                             case 0x19: /* System tick compare */
@@ -4421,9 +4461,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_stick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(NULL, 0);
+                                        dc->base.is_jmp = DISAS_NORETURN;
+                                    }
                                 }
                                 break;
 
@@ -4531,9 +4582,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(NULL, 0);
+                                        dc->base.is_jmp = DISAS_NORETURN;
+                                    }
                                 }
                                 break;
                             case 5: // tba
@@ -4541,7 +4603,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 break;
                             case 6: // pstate
                                 save_state(dc);
+                                if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_start();
+                                }
                                 gen_helper_wrpstate(cpu_env, cpu_tmp0);
+                                if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_end();
+                                }
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 7: // tl
@@ -4551,7 +4619,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 8: // pil
+                                if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_start();
+                                }
                                 gen_helper_wrpil(cpu_env, cpu_tmp0);
+                                if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_end();
+                                }
                                 break;
                             case 9: // cwp
                                 gen_helper_wrcwp(cpu_env, cpu_tmp0);
@@ -4642,9 +4716,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, hstick));
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_hstick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(NULL, 0);
+                                        dc->base.is_jmp = DISAS_NORETURN;
+                                    }
                                 }
                                 break;
                             case 6: // hver readonly
@@ -5265,14 +5350,26 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
+                            if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_start();
+                            }
                             gen_helper_done(cpu_env);
+                            if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_end();
+                            }
                             goto jmp_insn;
                         case 1:
                             if (!supervisor(dc))
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
+                            if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_start();
+                            }
                             gen_helper_retry(cpu_env);
+                            if (dc->base.tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_end();
+                            }
                             goto jmp_insn;
                         default:
                             goto illegal_insn;
-- 
2.11.0
