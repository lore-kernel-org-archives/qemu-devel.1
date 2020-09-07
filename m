Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF23FC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77B3F2080A
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FXKclDuR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77B3F2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLM5-0004QC-CL
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 13:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIT-0004xc-Vn
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:18 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLIR-0000lU-TX
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 13:51:17 -0400
Received: by mail-pg1-x541.google.com with SMTP id 31so8298286pgy.13
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 10:51:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Lzoy3rQTW8RpzNKU3s0YRAjNrkjr7LKa4OsZvtm8Vk0=;
 b=FXKclDuRErCsGJCxtLXBHvHIyRfpReqKcePsLnFqVbmRceh/K6EsEcD3OX7wbJ5Ns/
 6F5jD11Oze0ckYBxyNF+UuL0Ugw9plDynhLt1zFzjQxPiFWDp4Q1R6O1JuxlwLBWdC9P
 PNJZ9FmLymIPTL8wv27RVoAf7r/eRgkX5sC/hE8xkWA7Kbd8DZ0QX2//mpuCMqYrunXc
 Labq5tvhclb5lPBN7gMmPvxaP25lc1j+sWt0+ye+lH30TrN13Xx0/a9zylYPk2d4IfBc
 Q7uVDM3klUzvZVNmx9dO8QLn/ug0hEaqOEk/J7Q+bK4tY2DWl9PxsTYFjsW8ZZbukbrm
 d97w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Lzoy3rQTW8RpzNKU3s0YRAjNrkjr7LKa4OsZvtm8Vk0=;
 b=DB7bA00NgyZTJxXle26PUxAdbFVBbpien71IJhQ2wlGzoXshpLi0aNL8FP0/G/0xgJ
 K0V1HpcqJcX1U6wt0cftSu970W1zT5niIxHwiAQ/zGUoRwEBsUbLEERoW+51GwW67SFq
 J2TyYdAcec7f75jU5TkkMYRVmvmNHqk3jiGRuXXUnQJDg9NzesQrgHmAP4VjI04uU2HX
 7ewZvNoCMNuJAAS/n90/cwlzsHM+TJjYFobL4BLrxAz0xVzb+y4h2n4NwRRetQ+JmDby
 6Kx9QOe5MnWpDOgUGB55mqiQ9iCUrm+U73c3ZuolnGkRsOkn63YGkVR+ITogt994J9/1
 KRiw==
X-Gm-Message-State: AOAM531HYiq2aBSFttnsTlwStJObTzywf6n1IKAbDsNyE1sjxo0t0Oo/
 vmacdEnsgawyAaZPe9t335+/v3EIHJ5dJg==
X-Google-Smtp-Source: ABdhPJx0uEzRSdgobIaBLdhi/JYv4q0hVWgfjVmKGitHf5f/mQkSwP074CTeo768DdjcbYCbN8WcWw==
X-Received: by 2002:aa7:9574:: with SMTP id x20mr20661024pfq.191.1599501073966; 
 Mon, 07 Sep 2020 10:51:13 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id ga3sm1651496pjb.18.2020.09.07.10.51.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 10:51:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 07/19] target/microblaze: Replace cpustate_changed with
 DISAS_EXIT_NEXT
Date: Mon,  7 Sep 2020 10:50:50 -0700
Message-Id: <20200907175102.28027-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907175102.28027-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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

Rather than look for the combination of DISAS_NEXT with a separate
variable, go ahead and set is_jmp to the desired state.

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 34 ++++++++++------------------------
 1 file changed, 10 insertions(+), 24 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 2abef328a3..6bf299a826 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -70,7 +70,6 @@ typedef struct DisasContext {
 
     /* Decoder.  */
     uint32_t ext_imm;
-    unsigned int cpustate_changed;
     unsigned int tb_flags;
     unsigned int tb_flags_to_set;
     int mem_index;
@@ -1255,7 +1254,7 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
      *
      * Therefore, choose to end the TB always.
      */
-    dc->cpustate_changed = 1;
+    dc->base.is_jmp = DISAS_EXIT_NEXT;
     return true;
 }
 
@@ -1307,19 +1306,6 @@ static void msr_read(DisasContext *dc, TCGv_i32 d)
     tcg_temp_free_i32(t);
 }
 
-#ifndef CONFIG_USER_ONLY
-static void msr_write(DisasContext *dc, TCGv_i32 v)
-{
-    dc->cpustate_changed = 1;
-
-    /* Install MSR_C.  */
-    tcg_gen_extract_i32(cpu_msr_c, v, 2, 1);
-
-    /* Clear MSR_C and MSR_CC; MSR_PVR is not writable, and is always clear. */
-    tcg_gen_andi_i32(cpu_msr, v, ~(MSR_C | MSR_CC | MSR_PVR));
-}
-#endif
-
 static bool do_msrclrset(DisasContext *dc, arg_type_msr *arg, bool set)
 {
     uint32_t imm = arg->imm;
@@ -1352,7 +1338,7 @@ static bool do_msrclrset(DisasContext *dc, arg_type_msr *arg, bool set)
         } else {
             tcg_gen_andi_i32(cpu_msr, cpu_msr, ~imm);
         }
-        dc->cpustate_changed = 1;
+        dc->base.is_jmp = DISAS_EXIT_NEXT;
     }
     return true;
 }
@@ -1385,7 +1371,13 @@ static bool trans_mts(DisasContext *dc, arg_mts *arg)
     TCGv_i32 src = reg_for_read(dc, arg->ra);
     switch (arg->rs) {
     case SR_MSR:
-        msr_write(dc, src);
+        /* Install MSR_C.  */
+        tcg_gen_extract_i32(cpu_msr_c, src, 2, 1);
+        /*
+         * Clear MSR_C and MSR_CC;
+         * MSR_PVR is not writable, and is always clear.
+         */
+        tcg_gen_andi_i32(cpu_msr, src, ~(MSR_C | MSR_CC | MSR_PVR));
         break;
     case SR_FSR:
         tcg_gen_st_i32(src, cpu_env, offsetof(CPUMBState, fsr));
@@ -1417,7 +1409,7 @@ static bool trans_mts(DisasContext *dc, arg_mts *arg)
         qemu_log_mask(LOG_GUEST_ERROR, "Invalid mts reg 0x%x\n", arg->rs);
         return true;
     }
-    dc->cpustate_changed = 1;
+    dc->base.is_jmp = DISAS_EXIT_NEXT;
     return true;
 #endif
 }
@@ -1629,7 +1621,6 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
 
     dc->cpu = cpu;
     dc->tb_flags = dc->base.tb->flags;
-    dc->cpustate_changed = 0;
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
     dc->r0_set = false;
@@ -1714,11 +1705,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
         }
         dc->base.is_jmp = DISAS_JUMP;
     }
-
-    /* Force an exit if the per-tb cpu state has changed.  */
-    if (dc->base.is_jmp == DISAS_NEXT && dc->cpustate_changed) {
-        dc->base.is_jmp = DISAS_EXIT_NEXT;
-    }
 }
 
 static void mb_tr_tb_stop(DisasContextBase *dcb, CPUState *cs)
-- 
2.25.1


