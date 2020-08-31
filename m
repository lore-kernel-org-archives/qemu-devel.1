Return-Path: <SRS0=j6Zk=CJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853BCC433E6
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:16:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D7462073A
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2020 16:16:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KgVxiYAY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D7462073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kCmUK-0008Vu-FZ
	for qemu-devel@archiver.kernel.org; Mon, 31 Aug 2020 12:16:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKM-0004P6-Ly
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:38 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:52129)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kCmKK-0005zr-Le
 for qemu-devel@nongnu.org; Mon, 31 Aug 2020 12:06:38 -0400
Received: by mail-pj1-x102f.google.com with SMTP id ds1so30978pjb.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2020 09:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=FX8jCFtFLdRyMWFPeEfLBpL1wb+Y9mzpfQMTMdMGMF0=;
 b=KgVxiYAYms5Bm+0AO5QmdJBkrrvxr4mMnEND1O8pGSCT8+o+zGc+U+u87mgrHFkqDD
 cN6Nb7Aoz4zQ6kagrAeZKA+g9ROvYz4wzsRSM0BkaxFWZownw215lX2xdzjuMA9kBvv6
 8/vfie/MgXKJpSZKEvLKJc/cK1XtWpX0W6ra3/bnvuGPgRAjGfXsU5bOGY3c1D5WW+c4
 zrSGEjfIcs1FwPxSTnmW9NCu6er1Eq/up+rqzWpnbmOls8ICjtKiZ3jXVW6pM5durCU9
 ysO2nS4E5QgSbMn1wlaXTXAipOsEkAOcZ9sOjo/AGhAeOvsPROnSMLz0gsgJfDwB8iFV
 AUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=FX8jCFtFLdRyMWFPeEfLBpL1wb+Y9mzpfQMTMdMGMF0=;
 b=RZr4XfsZ2j6HINXRdUlzWPeGhHEwj5bj60zUTh1bJtap903c/v56gqeu+k1S4qMOQx
 7NaaQv7q+minjfjfBf4j4Mc0TtSVu7W5NajTbxGvjh6bnYITj49B2wp1fry+gHJDHCUr
 TpQwWy0Q3NUiwuqjDo4NDXcpWOUhbHfa7WINoEQNpB24NLWm9oZPHRy8zp3EGAKC1Vmv
 RDGZVWZ0a3snP2KRvu22mnjBkoFUCyR8iK2FVcWLC6CerObmUssvZ7om6/O4UJF7sV14
 fjAbqM21i9pGIXTlChYiKcsGpsJcYb0uKue34boWYhdVaJ30G5Iu6Lpr3ZCcBFKsTwhB
 n44Q==
X-Gm-Message-State: AOAM530kZfOtUrKA5ANYrB+OnAQjkabfJmJ+WL4s68OYr3o2Yjuz8oEl
 R4PF0Cy0E6KfFRz7p2V586GLVU/4HX1kFw==
X-Google-Smtp-Source: ABdhPJx4Y39cnAddSz4Xr51Quwi524MByjzY8q85GabOgDrcwEArQsNF66KprOmNGagLvZs3uxf9Mw==
X-Received: by 2002:a17:902:b193:: with SMTP id
 s19mr1620051plr.72.1598889994875; 
 Mon, 31 Aug 2020 09:06:34 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id gt13sm17218pjb.43.2020.08.31.09.06.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2020 09:06:34 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 23/76] target/microblaze: Rename env_* tcg variables to cpu_*
Date: Mon, 31 Aug 2020 09:05:08 -0700
Message-Id: <20200831160601.833692-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831160601.833692-1-richard.henderson@linaro.org>
References: <20200831160601.833692-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cpu_imm, cpu_btaken, cpu_iflags, cpu_res_addr and cpu_res_val.
It is standard for these file-scope globals to begin with cpu_*.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 54 +++++++++++++++++------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ecfa6b86a4..9aa63ddcc5 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -56,12 +56,12 @@
 static TCGv_i32 cpu_R[32];
 static TCGv_i32 cpu_pc;
 static TCGv_i32 cpu_msr;
-static TCGv_i32 env_imm;
-static TCGv_i32 env_btaken;
+static TCGv_i32 cpu_imm;
+static TCGv_i32 cpu_btaken;
 static TCGv_i32 cpu_btarget;
-static TCGv_i32 env_iflags;
-static TCGv env_res_addr;
-static TCGv_i32 env_res_val;
+static TCGv_i32 cpu_iflags;
+static TCGv cpu_res_addr;
+static TCGv_i32 cpu_res_val;
 
 #include "exec/gen-icount.h"
 
@@ -107,7 +107,7 @@ static inline void t_sync_flags(DisasContext *dc)
 {
     /* Synch the tb dependent flags between translator and runtime.  */
     if (dc->tb_flags != dc->synced_flags) {
-        tcg_gen_movi_i32(env_iflags, dc->tb_flags);
+        tcg_gen_movi_i32(cpu_iflags, dc->tb_flags);
         dc->synced_flags = dc->tb_flags;
     }
 }
@@ -222,10 +222,10 @@ static inline TCGv_i32 *dec_alu_op_b(DisasContext *dc)
 {
     if (dc->type_b) {
         if (dc->tb_flags & IMM_FLAG)
-            tcg_gen_ori_i32(env_imm, env_imm, dc->imm);
+            tcg_gen_ori_i32(cpu_imm, cpu_imm, dc->imm);
         else
-            tcg_gen_movi_i32(env_imm, (int32_t)((int16_t)dc->imm));
-        return &env_imm;
+            tcg_gen_movi_i32(cpu_imm, (int32_t)((int16_t)dc->imm));
+        return &cpu_imm;
     } else
         return &cpu_R[dc->rb];
 }
@@ -859,7 +859,7 @@ static inline void sync_jmpstate(DisasContext *dc)
 {
     if (dc->jmp == JMP_DIRECT || dc->jmp == JMP_DIRECT_CC) {
         if (dc->jmp == JMP_DIRECT) {
-            tcg_gen_movi_i32(env_btaken, 1);
+            tcg_gen_movi_i32(cpu_btaken, 1);
         }
         dc->jmp = JMP_INDIRECT;
         tcg_gen_movi_i32(cpu_btarget, dc->jmp_pc);
@@ -869,7 +869,7 @@ static inline void sync_jmpstate(DisasContext *dc)
 static void dec_imm(DisasContext *dc)
 {
     LOG_DIS("imm %x\n", dc->imm << 16);
-    tcg_gen_movi_i32(env_imm, (dc->imm << 16));
+    tcg_gen_movi_i32(cpu_imm, (dc->imm << 16));
     dc->tb_flags |= IMM_FLAG;
     dc->clear_imm = 0;
 }
@@ -1040,8 +1040,8 @@ static void dec_load(DisasContext *dc)
     }
 
     if (ex) {
-        tcg_gen_mov_tl(env_res_addr, addr);
-        tcg_gen_mov_i32(env_res_val, v);
+        tcg_gen_mov_tl(cpu_res_addr, addr);
+        tcg_gen_mov_i32(cpu_res_val, v);
     }
     if (dc->rd) {
         tcg_gen_mov_i32(cpu_R[dc->rd], v);
@@ -1103,7 +1103,7 @@ static void dec_store(DisasContext *dc)
 
         write_carryi(dc, 1);
         swx_skip = gen_new_label();
-        tcg_gen_brcond_tl(TCG_COND_NE, env_res_addr, addr, swx_skip);
+        tcg_gen_brcond_tl(TCG_COND_NE, cpu_res_addr, addr, swx_skip);
 
         /*
          * Compare the value loaded at lwx with current contents of
@@ -1111,11 +1111,11 @@ static void dec_store(DisasContext *dc)
          */
         tval = tcg_temp_new_i32();
 
-        tcg_gen_atomic_cmpxchg_i32(tval, addr, env_res_val,
+        tcg_gen_atomic_cmpxchg_i32(tval, addr, cpu_res_val,
                                    cpu_R[dc->rd], mem_index,
                                    mop);
 
-        tcg_gen_brcond_i32(TCG_COND_NE, env_res_val, tval, swx_skip);
+        tcg_gen_brcond_i32(TCG_COND_NE, cpu_res_val, tval, swx_skip);
         write_carryi(dc, 0);
         tcg_temp_free_i32(tval);
     }
@@ -1204,7 +1204,7 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
     TCGv_i32 zero = tcg_const_i32(0);
 
     tcg_gen_movcond_i32(TCG_COND_NE, cpu_pc,
-                        env_btaken, zero,
+                        cpu_btaken, zero,
                         pc_true, pc_false);
 
     tcg_temp_free_i32(zero);
@@ -1245,7 +1245,7 @@ static void dec_bcc(DisasContext *dc)
         dc->jmp = JMP_INDIRECT;
         tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
     }
-    eval_cc(dc, cc, env_btaken, cpu_R[dc->ra]);
+    eval_cc(dc, cc, cpu_btaken, cpu_R[dc->ra]);
 }
 
 static void dec_br(DisasContext *dc)
@@ -1311,7 +1311,7 @@ static void dec_br(DisasContext *dc)
 
     dc->jmp = JMP_INDIRECT;
     if (abs) {
-        tcg_gen_movi_i32(env_btaken, 1);
+        tcg_gen_movi_i32(cpu_btaken, 1);
         tcg_gen_mov_i32(cpu_btarget, *(dec_alu_op_b(dc)));
         if (link && !dslot) {
             if (!(dc->tb_flags & IMM_FLAG) &&
@@ -1330,7 +1330,7 @@ static void dec_br(DisasContext *dc)
             dc->jmp = JMP_DIRECT;
             dc->jmp_pc = dc->pc + (int32_t)((int16_t)dc->imm);
         } else {
-            tcg_gen_movi_i32(env_btaken, 1);
+            tcg_gen_movi_i32(cpu_btaken, 1);
             tcg_gen_addi_i32(cpu_btarget, *dec_alu_op_b(dc), dc->pc);
         }
     }
@@ -1419,7 +1419,7 @@ static void dec_rts(DisasContext *dc)
         LOG_DIS("rts ir=%x\n", dc->ir);
 
     dc->jmp = JMP_INDIRECT;
-    tcg_gen_movi_i32(env_btaken, 1);
+    tcg_gen_movi_i32(cpu_btaken, 1);
     tcg_gen_add_i32(cpu_btarget, cpu_R[dc->ra], *dec_alu_op_b(dc));
 }
 
@@ -1722,7 +1722,7 @@ void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_insns)
                     TCGLabel *l1 = gen_new_label();
                     t_sync_flags(dc);
                     /* Conditional jmp.  */
-                    tcg_gen_brcondi_i32(TCG_COND_NE, env_btaken, 0, l1);
+                    tcg_gen_brcondi_i32(TCG_COND_NE, cpu_btaken, 0, l1);
                     gen_goto_tb(dc, 1, dc->pc);
                     gen_set_label(l1);
                     gen_goto_tb(dc, 0, dc->jmp_pc);
@@ -1848,22 +1848,22 @@ void mb_tcg_init(void)
 {
     int i;
 
-    env_iflags = tcg_global_mem_new_i32(cpu_env,
+    cpu_iflags = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, iflags),
                     "iflags");
-    env_imm = tcg_global_mem_new_i32(cpu_env,
+    cpu_imm = tcg_global_mem_new_i32(cpu_env,
                     offsetof(CPUMBState, imm),
                     "imm");
     cpu_btarget = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, btarget),
                      "btarget");
-    env_btaken = tcg_global_mem_new_i32(cpu_env,
+    cpu_btaken = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, btaken),
                      "btaken");
-    env_res_addr = tcg_global_mem_new(cpu_env,
+    cpu_res_addr = tcg_global_mem_new(cpu_env,
                      offsetof(CPUMBState, res_addr),
                      "res_addr");
-    env_res_val = tcg_global_mem_new_i32(cpu_env,
+    cpu_res_val = tcg_global_mem_new_i32(cpu_env,
                      offsetof(CPUMBState, res_val),
                      "res_val");
     for (i = 0; i < ARRAY_SIZE(cpu_R); i++) {
-- 
2.25.1


