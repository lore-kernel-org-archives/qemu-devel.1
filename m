Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EFEAC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 296FB20757
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 14:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vNrH2eFf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 296FB20757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41718 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBfU7-0006fa-Aj
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 10:36:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51184)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEc-0000Wb-9L
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:06 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:45974)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBfEa-000575-4T
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 10:20:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id 67so513929pgd.12
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 07:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Xvkn3g2mPXtRTX9S6LWMZSG9zfZ6Smrj8vu/NEKgNeA=;
 b=vNrH2eFfG0xnxHGSAHwkS1jU7HQO9adPDRN2KBexbp1hpW5ttkko6xY7Moha8B2GVJ
 3QCmlpFRD3QzRt8qgON5qncMOD7ZIIP8WfkZ0OQgeyZHqmN8JXGFg9eXXgoytT5dAfPe
 dasd6EsmhYCnC11BqGUawRqi3hXWOzeccQyBInbdftpABi58PhTk3TRwzPCJU73d/QjC
 7t6SyA2jT7T2xYmZMNQ0ueeslIH5jVelLXYFDhGUaYTq+coP9GGOFt9GQ/+F7nezdmlV
 5BkcJ5Kgi347S9JSvwzdJEPuyhZv/R+WJxnVeJYTIgX0qT68CEs4cIdi4xiJ/12ptUvY
 9e1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Xvkn3g2mPXtRTX9S6LWMZSG9zfZ6Smrj8vu/NEKgNeA=;
 b=dM4yzLqf1uO321XwNzMNhfDTxmENEtzJVumCoOnMGB08Uh9OfEfM9rDtgx0CFD+ErS
 XxsxxZjb4cbXnA8Bbgum9BYBZk58ZcquYpV2RfGlRIu8jWKjx7pvzN+uymS4nq7UjKib
 nBynhgUYXDGa3XGbeoeLAIrX5C+eiTa2PdmIl8KEmtGL5g9Gh7pRqYkBTtkz4d1dmwzq
 er8O9BuX3Dn5fz7UZGeqLZzV5H1uR43fgJp73jjEaBJBfCm20b7jN7JnrieVom2lhPFI
 BWyHmtaAWYyXNaxQYvCMIoDf/IY+oDJrd71L6y2+/GqUVR5+3dMx1h0XuGhGuMRkrLsf
 hiBQ==
X-Gm-Message-State: AOAM533tk2OBHcsu4zxF0bZqo/ne6MGW78YtoDHW46l8gZb/L03g4B9O
 W5gLBmB5FBY1/C0N9AxXri43JTTQJ4zGZw==
X-Google-Smtp-Source: ABdhPJyGADJZotwgpQmE+C7oinLt5YUngHQcls/GVcthwgkUWMQ2DVUNo7WHguggm6ByEX8u0fzdZA==
X-Received: by 2002:a63:ec18:: with SMTP id j24mr1394647pgh.74.1598624401962; 
 Fri, 28 Aug 2020 07:20:01 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j3sm1403080pjw.23.2020.08.28.07.20.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2020 07:20:01 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 23/76] target/microblaze: Rename env_* tcg variables to
 cpu_*
Date: Fri, 28 Aug 2020 07:18:36 -0700
Message-Id: <20200828141929.77854-24-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200828141929.77854-1-richard.henderson@linaro.org>
References: <20200828141929.77854-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
Cc: edgar.iglesias@xilinx.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is cpu_imm, cpu_btaken, cpu_iflags, cpu_res_addr and cpu_res_val.
It is standard for these file-scope globals to begin with cpu_*.

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


