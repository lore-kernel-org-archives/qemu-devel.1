Received: from eggs.gnu.org ([2001:4830:134:3::10]:35876)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fGAOG-00008K-LO
	for qemu-devel@nongnu.org; Tue, 08 May 2018 17:43:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1fGAOD-0000rp-MR
	for qemu-devel@nongnu.org; Tue, 08 May 2018 17:43:20 -0400
Received: from chuckie.co.uk ([82.165.15.123]:52430
	helo=s16892447.onlinehome-server.info)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mark.cave-ayland@ilande.co.uk>)
	id 1fGAOD-0000od-C5
	for qemu-devel@nongnu.org; Tue, 08 May 2018 17:43:17 -0400
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Date: Tue,  8 May 2018 22:42:57 +0100
Message-Id: <20180508214257.23990-2-mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20180508214257.23990-1-mark.cave-ayland@ilande.co.uk>
References: <20180508214257.23990-1-mark.cave-ayland@ilande.co.uk>
Subject: [Qemu-devel] [RFC PATCH 1/1] SPARC64: add icount support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, atar4qemu@gmail.com

This patch adds gen_io_start()/gen_io_end() to various instructions as required
in order to boot my OpenBIOS test images on qemu-system-sparc64 with icount
enabled.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 target/sparc/translate.c | 97 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 5aa367a182..416197ae52 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -3401,11 +3401,17 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
+                        if (dc->tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
+                        if (dc->tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 0x5: /* V9 rdpc */
@@ -3448,11 +3454,17 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, stick));
+                        if (dc->tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_dst, cpu_env, r_tickptr,
                                                   r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
                         gen_store_gpr(dc, rd, cpu_dst);
+                        if (dc->tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 0x19: /* System tick compare */
@@ -3577,10 +3589,16 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                         r_const = tcg_const_i32(dc->mem_idx);
                         tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                        offsetof(CPUSPARCState, tick));
+                        if (dc->tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_start();
+                        }
                         gen_helper_tick_get_count(cpu_tmp0, cpu_env,
                                                   r_tickptr, r_const);
                         tcg_temp_free_ptr(r_tickptr);
                         tcg_temp_free_i32(r_const);
+                        if (dc->tb->cflags & CF_USE_ICOUNT) {
+                            gen_io_end();
+                        }
                     }
                     break;
                 case 5: // tba
@@ -4386,9 +4404,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_tick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(0);
+                                        dc->is_br = 1;
+                                    }
                                 }
                                 break;
                             case 0x18: /* System tick */
@@ -4404,9 +4433,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(0);
+                                        dc->is_br = 1;
+                                    }
                                 }
                                 break;
                             case 0x19: /* System tick compare */
@@ -4422,9 +4462,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, stick));
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_stick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(0);
+                                        dc->is_br = 1;
+                                    }
                                 }
                                 break;
 
@@ -4532,9 +4583,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, tick));
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(0);
+                                        dc->is_br = 1;
+                                    }
                                 }
                                 break;
                             case 5: // tba
@@ -4542,7 +4604,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 break;
                             case 6: // pstate
                                 save_state(dc);
+                                if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_start();
+                                }
                                 gen_helper_wrpstate(cpu_env, cpu_tmp0);
+                                if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_end();
+                                }
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 7: // tl
@@ -4552,7 +4620,13 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 dc->npc = DYNAMIC_PC;
                                 break;
                             case 8: // pil
+                                if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_start();
+                                }
                                 gen_helper_wrpil(cpu_env, cpu_tmp0);
+                                if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                    gen_io_end();
+                                }
                                 break;
                             case 9: // cwp
                                 gen_helper_wrcwp(cpu_env, cpu_tmp0);
@@ -4643,9 +4717,20 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     r_tickptr = tcg_temp_new_ptr();
                                     tcg_gen_ld_ptr(r_tickptr, cpu_env,
                                                    offsetof(CPUSPARCState, hstick));
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_start();
+                                    }
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_hstick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
+                                    if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                        gen_io_end();
+                                        /* End TB to handle timer interrupt */
+                                        save_state(dc);
+                                        gen_op_next_insn();
+                                        tcg_gen_exit_tb(0);
+                                        dc->is_br = 1;
+                                    }
                                 }
                                 break;
                             case 6: // hver readonly
@@ -5266,14 +5351,26 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
+                            if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_start();
+                            }
                             gen_helper_done(cpu_env);
+                            if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_end();
+                            }
                             goto jmp_insn;
                         case 1:
                             if (!supervisor(dc))
                                 goto priv_insn;
                             dc->npc = DYNAMIC_PC;
                             dc->pc = DYNAMIC_PC;
+                            if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_start();
+                            }
                             gen_helper_retry(cpu_env);
+                            if (dc->tb->cflags & CF_USE_ICOUNT) {
+                                gen_io_end();
+                            }
                             goto jmp_insn;
                         default:
                             goto illegal_insn;
-- 
2.11.0
