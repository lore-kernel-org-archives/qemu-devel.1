Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00D22C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:23:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5F7F2082F
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 07:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5F7F2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyTv-0007zh-T2
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:23:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42807)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8s-0005wI-DK
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hzy8k-0003cY-1x
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45484)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hzy8j-0003Yk-Mp
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:01:09 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id C77DB3061421;
 Tue, 20 Aug 2019 07:01:06 +0000 (UTC)
Received: from 640k.localdomain.com (ovpn-112-20.ams2.redhat.com
 [10.36.112.20])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 838B260BE2;
 Tue, 20 Aug 2019 07:01:05 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 08:59:47 +0200
Message-Id: <1566284395-30287-29-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
References: <1566284395-30287-1-git-send-email-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Tue, 20 Aug 2019 07:01:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 28/36] icount: remove unnecessary gen_io_end
 calls
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>,
 Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>

Prior patch resets can_do_io flag at the TB entry. Therefore there is no
need in resetting this flag at the end of the block.
This patch removes redundant gen_io_end calls.

Signed-off-by: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>
Message-Id: <156404429499.18669.13404064982854123855.stgit@pasha-Precision-3630-Tower>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
---
 accel/tcg/translator.c                  |  1 -
 include/exec/gen-icount.h               |  8 +++++++-
 target/alpha/translate.c                |  2 --
 target/arm/translate-a64.c              |  4 ----
 target/arm/translate.c                  |  7 -------
 target/cris/translate.c                 |  2 --
 target/hppa/translate.c                 |  1 -
 target/i386/translate.c                 | 10 ----------
 target/lm32/translate.c                 |  9 ---------
 target/microblaze/translate.c           |  2 --
 target/mips/translate.c                 | 11 -----------
 target/nios2/translate.c                |  4 ----
 target/ppc/translate.c                  | 13 -------------
 target/ppc/translate_init.inc.c         |  2 --
 target/riscv/insn_trans/trans_rvi.inc.c |  1 -
 target/sparc/translate.c                | 16 ----------------
 target/unicore32/translate.c            |  1 -
 target/xtensa/translate.c               | 15 ---------------
 18 files changed, 7 insertions(+), 102 deletions(-)

diff --git a/accel/tcg/translator.c b/accel/tcg/translator.c
index 9226a34..70c66c5 100644
--- a/accel/tcg/translator.c
+++ b/accel/tcg/translator.c
@@ -90,7 +90,6 @@ void translator_loop(const TranslatorOps *ops, DisasContextBase *db,
             /* Accept I/O on the last instruction.  */
             gen_io_start();
             ops->translate_insn(db, cpu);
-            gen_io_end();
         } else {
             ops->translate_insn(db, cpu);
         }
diff --git a/include/exec/gen-icount.h b/include/exec/gen-icount.h
index 4004e6c..822c43c 100644
--- a/include/exec/gen-icount.h
+++ b/include/exec/gen-icount.h
@@ -16,6 +16,13 @@ static inline void gen_io_start(void)
     tcg_temp_free_i32(tmp);
 }
 
+/*
+ * cpu->can_do_io is cleared automatically at the beginning of
+ * each translation block.  The cost is minimal and only paid
+ * for -icount, plus it would be very easy to forget doing it
+ * in the translator.  Therefore, backends only need to call
+ * gen_io_start.
+ */
 static inline void gen_io_end(void)
 {
     TCGv_i32 tmp = tcg_const_i32(0);
@@ -58,7 +65,6 @@ static inline void gen_tb_start(TranslationBlock *tb)
         tcg_gen_st16_i32(count, cpu_env,
                          offsetof(ArchCPU, neg.icount_decr.u16.low) -
                          offsetof(ArchCPU, env));
-        /* Disable I/O by default */
         gen_io_end();
     }
 
diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 2c9cccf..1e29653 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1332,7 +1332,6 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
         if (use_icount) {
             gen_io_start();
             helper(va);
-            gen_io_end();
             return DISAS_PC_STALE;
         } else {
             helper(va);
@@ -2398,7 +2397,6 @@ static DisasJumpType translate_one(DisasContext *ctx, uint32_t insn)
             if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
                 gen_io_start();
                 gen_helper_load_pcc(va, cpu_env);
-                gen_io_end();
                 ret = DISAS_PC_STALE;
             } else {
                 gen_helper_load_pcc(va, cpu_env);
diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index d323147..079b5f4 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1797,7 +1797,6 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
 
     if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
         /* I/O operations must end the TB here (whether read or write) */
-        gen_io_end();
         s->base.is_jmp = DISAS_UPDATE;
     } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
         /* We default to ending the TB on a coprocessor register write,
@@ -2104,9 +2103,6 @@ static void disas_uncond_b_reg(DisasContext *s, uint32_t insn)
 
         gen_helper_exception_return(cpu_env, dst);
         tcg_temp_free_i64(dst);
-        if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
         /* Must exit loop to check un-masked IRQs */
         s->base.is_jmp = DISAS_EXIT;
         return;
diff --git a/target/arm/translate.c b/target/arm/translate.c
index 7853462..d9dbe03 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -3245,9 +3245,6 @@ static void gen_rfe(DisasContext *s, TCGv_i32 pc, TCGv_i32 cpsr)
         gen_io_start();
     }
     gen_helper_cpsr_write_eret(cpu_env, cpsr);
-    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
     tcg_temp_free_i32(cpsr);
     /* Must exit loop to check un-masked IRQs */
     s->base.is_jmp = DISAS_EXIT;
@@ -7338,7 +7335,6 @@ static int disas_coproc_insn(DisasContext *s, uint32_t insn)
 
         if ((tb_cflags(s->base.tb) & CF_USE_ICOUNT) && (ri->type & ARM_CP_IO)) {
             /* I/O operations must end the TB here (whether read or write) */
-            gen_io_end();
             gen_lookup_tb(s);
         } else if (!isread && !(ri->type & ARM_CP_SUPPRESS_TB_END)) {
             /* We default to ending the TB on a coprocessor register write,
@@ -9207,9 +9203,6 @@ static void disas_arm_insn(DisasContext *s, unsigned int insn)
                         gen_io_start();
                     }
                     gen_helper_cpsr_write_eret(cpu_env, tmp);
-                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                        gen_io_end();
-                    }
                     tcg_temp_free_i32(tmp);
                     /* Must exit loop to check un-masked IRQs */
                     s->base.is_jmp = DISAS_EXIT;
diff --git a/target/cris/translate.c b/target/cris/translate.c
index 3429a3b..e752bd0 100644
--- a/target/cris/translate.c
+++ b/target/cris/translate.c
@@ -3225,8 +3225,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
 
     npc = dc->pc;
 
-        if (tb_cflags(tb) & CF_LAST_IO)
-            gen_io_end();
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || !dc->flagx_known
diff --git a/target/hppa/translate.c b/target/hppa/translate.c
index 188fe68..8c61895 100644
--- a/target/hppa/translate.c
+++ b/target/hppa/translate.c
@@ -2161,7 +2161,6 @@ static bool trans_mfctl(DisasContext *ctx, arg_mfctl *a)
         if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
             gen_helper_read_interval_timer(tmp);
-            gen_io_end();
             ctx->base.is_jmp = DISAS_IAQ_N_STALE;
         } else {
             gen_helper_read_interval_timer(tmp);
diff --git a/target/i386/translate.c b/target/i386/translate.c
index 03150a8..5cd74ad 100644
--- a/target/i386/translate.c
+++ b/target/i386/translate.c
@@ -5381,7 +5381,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             gen_op_mov_reg_v(s, dflag, rm, s->T0);
             set_cc_op(s, CC_OP_EFLAGS);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
                 gen_jmp(s, s->pc - s->cs_base);
             }
             break;
@@ -6443,7 +6442,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6464,7 +6462,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6482,7 +6479,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_op_mov_reg_v(s, ot, R_EAX, s->T1);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -6502,7 +6498,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         gen_helper_out_func(ot, s->tmp2_i32, s->tmp3_i32);
         gen_bpt_io(s, s->tmp2_i32, ot);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7206,7 +7201,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
         }
         gen_helper_rdtsc(cpu_env);
         if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
             gen_jmp(s, s->pc - s->cs_base);
         }
         break;
@@ -7666,7 +7660,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
             }
             gen_helper_rdtscp(cpu_env);
             if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
                 gen_jmp(s, s->pc - s->cs_base);
             }
             break;
@@ -8036,9 +8029,6 @@ static target_ulong disas_insn(DisasContext *s, CPUState *cpu)
                     gen_op_mov_v_reg(s, ot, s->T0, rm);
                     gen_helper_write_crN(cpu_env, tcg_const_i32(reg),
                                          s->T0);
-                    if (tb_cflags(s->base.tb) & CF_USE_ICOUNT) {
-                        gen_io_end();
-                    }
                     gen_jmp_im(s, s->pc - s->cs_base);
                     gen_eob(s);
                 } else {
diff --git a/target/lm32/translate.c b/target/lm32/translate.c
index b9f2f2c..778cae1 100644
--- a/target/lm32/translate.c
+++ b/target/lm32/translate.c
@@ -885,9 +885,6 @@ static void dec_wcsr(DisasContext *dc)
         }
         gen_helper_wcsr_im(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
-        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
         dc->is_jmp = DISAS_UPDATE;
         break;
     case CSR_IP:
@@ -897,9 +894,6 @@ static void dec_wcsr(DisasContext *dc)
         }
         gen_helper_wcsr_ip(cpu_env, cpu_R[dc->r1]);
         tcg_gen_movi_tl(cpu_pc, dc->pc + 4);
-        if (tb_cflags(dc->tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
         dc->is_jmp = DISAS_UPDATE;
         break;
     case CSR_ICC:
@@ -1111,9 +1105,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
          && (dc->pc - page_start < TARGET_PAGE_SIZE)
          && num_insns < max_insns);
 
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
-    }
 
     if (unlikely(cs->singlestep_enabled)) {
         if (dc->is_jmp == DISAS_NEXT) {
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 9ce65f3..95ff663 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1724,8 +1724,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
             npc = dc->jmp_pc;
     }
 
-    if (tb_cflags(tb) & CF_LAST_IO)
-        gen_io_end();
     /* Force an update if the per-tb cpu state has changed.  */
     if (dc->is_jmp == DISAS_NEXT
         && (dc->cpustate_changed || org_flags != dc->tb_flags)) {
diff --git a/target/mips/translate.c b/target/mips/translate.c
index ca62800..8aba9dd 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -7126,9 +7126,6 @@ static void gen_mfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_io_start();
             }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
-            }
             /*
              * Break the TB to be able to take timer interrupts immediately
              * after reading count. DISAS_STOP isn't sufficient, we need to
@@ -8293,7 +8290,6 @@ static void gen_mtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
         /*
          * DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.
@@ -8604,9 +8600,6 @@ static void gen_dmfc0(DisasContext *ctx, TCGv arg, int reg, int sel)
                 gen_io_start();
             }
             gen_helper_mfc0_count(arg, cpu_env);
-            if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-                gen_io_end();
-            }
             /*
              * Break the TB to be able to take timer interrupts immediately
              * after reading count. DISAS_STOP isn't sufficient, we need to
@@ -9745,7 +9738,6 @@ static void gen_dmtc0(DisasContext *ctx, TCGv arg, int reg, int sel)
 
     /* For simplicity assume that all writes can cause interrupts.  */
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
         /*
          * DISAS_STOP isn't sufficient, we need to ensure we break out of
          * translated code to check for pending interrupts.
@@ -12810,9 +12802,6 @@ static void gen_rdhwr(DisasContext *ctx, int rt, int rd, int sel)
             gen_io_start();
         }
         gen_helper_rdhwr_cc(t0, cpu_env);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
         gen_store_gpr(t0, rt);
         /*
          * Break the TB to be able to take timer interrupts immediately
diff --git a/target/nios2/translate.c b/target/nios2/translate.c
index 17d8f18..e17656e 100644
--- a/target/nios2/translate.c
+++ b/target/nios2/translate.c
@@ -862,10 +862,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
              !tcg_op_buf_full() &&
              num_insns < max_insns);
 
-    if (tb_cflags(tb) & CF_LAST_IO) {
-        gen_io_end();
-    }
-
     /* Indicate where the next block should start */
     switch (dc->is_jmp) {
     case DISAS_NEXT:
diff --git a/target/ppc/translate.c b/target/ppc/translate.c
index 4a5de28..ca5a916 100644
--- a/target/ppc/translate.c
+++ b/target/ppc/translate.c
@@ -1860,7 +1860,6 @@ static void gen_darn(DisasContext *ctx)
             gen_helper_darn64(cpu_gpr[rD(ctx->opcode)]);
         }
         if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
             gen_stop_exception(ctx);
         }
     }
@@ -3990,9 +3989,6 @@ static void gen_rfi(DisasContext *ctx)
     gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfi(cpu_env);
     gen_sync_exception(ctx);
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 #endif
 }
 
@@ -4010,9 +4006,6 @@ static void gen_rfid(DisasContext *ctx)
     gen_update_cfar(ctx, ctx->base.pc_next - 4);
     gen_helper_rfid(cpu_env);
     gen_sync_exception(ctx);
-    if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 #endif
 }
 
@@ -4388,9 +4381,6 @@ static void gen_mtmsrd(DisasContext *ctx)
         /* Must stop the translation as machine state (may have) changed */
         /* Note that mtmsr is not always defined as context-synchronizing */
         gen_stop_exception(ctx);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
     }
 #endif /* !defined(CONFIG_USER_ONLY) */
 }
@@ -4428,9 +4418,6 @@ static void gen_mtmsr(DisasContext *ctx)
         tcg_gen_mov_tl(msr, cpu_gpr[rS(ctx->opcode)]);
 #endif
         gen_helper_store_msr(cpu_env, msr);
-        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-            gen_io_end();
-        }
         tcg_temp_free(msr);
         /* Must stop the translation as machine state (may have) changed */
         /* Note that mtmsr is not always defined as context-synchronizing */
diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.inc.c
index 86fc8f2..66d9a73 100644
--- a/target/ppc/translate_init.inc.c
+++ b/target/ppc/translate_init.inc.c
@@ -189,7 +189,6 @@ static void spr_read_decr(DisasContext *ctx, int gprn, int sprn)
     }
     gen_helper_load_decr(cpu_gpr[gprn], cpu_env);
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
         gen_stop_exception(ctx);
     }
 }
@@ -201,7 +200,6 @@ static void spr_write_decr(DisasContext *ctx, int sprn, int gprn)
     }
     gen_helper_store_decr(cpu_env, cpu_gpr[gprn]);
     if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
         gen_stop_exception(ctx);
     }
 }
diff --git a/target/riscv/insn_trans/trans_rvi.inc.c b/target/riscv/insn_trans/trans_rvi.inc.c
index ea64731..1af795e 100644
--- a/target/riscv/insn_trans/trans_rvi.inc.c
+++ b/target/riscv/insn_trans/trans_rvi.inc.c
@@ -511,7 +511,6 @@ static bool trans_fence_i(DisasContext *ctx, arg_fence_i *a)
 } while (0)
 
 #define RISCV_OP_CSR_POST do {\
-    gen_io_end(); \
     gen_set_gpr(a->rd, dest); \
     tcg_gen_movi_tl(cpu_pc, ctx->pc_succ_insn); \
     exit_tb(ctx); \
diff --git a/target/sparc/translate.c b/target/sparc/translate.c
index 091bab5..02c1612 100644
--- a/target/sparc/translate.c
+++ b/target/sparc/translate.c
@@ -4412,10 +4412,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_tick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
@@ -4440,10 +4436,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
@@ -4468,10 +4460,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_limit(r_tickptr,
                                                               cpu_stick_cmpr);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
@@ -4588,10 +4576,6 @@ static void disas_sparc_insn(DisasContext * dc, unsigned int insn)
                                     gen_helper_tick_set_count(r_tickptr,
                                                               cpu_tmp0);
                                     tcg_temp_free_ptr(r_tickptr);
-                                    if (tb_cflags(dc->base.tb) &
-                                           CF_USE_ICOUNT) {
-                                        gen_io_end();
-                                    }
                                     /* End TB to handle timer interrupt */
                                     dc->base.is_jmp = DISAS_EXIT;
                                 }
diff --git a/target/unicore32/translate.c b/target/unicore32/translate.c
index d27451e..0e01f35 100644
--- a/target/unicore32/translate.c
+++ b/target/unicore32/translate.c
@@ -1931,7 +1931,6 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                code.  */
             cpu_abort(cs, "IO on conditional branch instruction");
         }
-        gen_io_end();
     }
 
     /* At this stage dc->condjmp will only be set when the skipped
diff --git a/target/xtensa/translate.c b/target/xtensa/translate.c
index 6f1da87..54b770b 100644
--- a/target/xtensa/translate.c
+++ b/target/xtensa/translate.c
@@ -540,9 +540,6 @@ static void gen_waiti(DisasContext *dc, uint32_t imm4)
         gen_io_start();
     }
     gen_helper_waiti(cpu_env, pc, intlevel);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
     tcg_temp_free(pc);
     tcg_temp_free(intlevel);
 }
@@ -2216,9 +2213,6 @@ static void translate_rsr_ccount(DisasContext *dc, const OpcodeArg arg[],
     }
     gen_helper_update_ccount(cpu_env);
     tcg_gen_mov_i32(arg[0].out, cpu_SR[par[0]]);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 #endif
 }
 
@@ -2608,9 +2602,6 @@ static void translate_wsr_ccompare(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(cpu_SR[par[0]], arg[0].in);
     gen_helper_update_ccompare(cpu_env, tmp);
     tcg_temp_free(tmp);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 #endif
 }
 
@@ -2622,9 +2613,6 @@ static void translate_wsr_ccount(DisasContext *dc, const OpcodeArg arg[],
         gen_io_start();
     }
     gen_helper_wsr_ccount(cpu_env, arg[0].in);
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 #endif
 }
 
@@ -2831,9 +2819,6 @@ static void translate_xsr_ccount(DisasContext *dc, const OpcodeArg arg[],
     tcg_gen_mov_i32(arg[0].out, tmp);
     tcg_temp_free(tmp);
 
-    if (tb_cflags(dc->base.tb) & CF_USE_ICOUNT) {
-        gen_io_end();
-    }
 #endif
 }
 
-- 
1.8.3.1



