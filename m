Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0F46C433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89763206E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 16:37:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="waxq6lfR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89763206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58818 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDVlI-00026C-Ml
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 12:37:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38712)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk5-0000HG-T0
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:13 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:37727)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDVk3-00057T-Qj
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 12:36:13 -0400
Received: by mail-pj1-x1041.google.com with SMTP id mw10so65052pjb.2
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 09:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AznOkEhgwnpFD0CoJMa5eW4WC9cEkYpl0tgCHuHjypk=;
 b=waxq6lfR5yrHx7mfggibCz3XlTcVGBHmEzh9SkXbcE4QG6kNpQTHLW+/IFPIy5jUmG
 LsMhPkW/UzJA/U7H/zZao/ZtL9G7jFOsmpkDlt9FLbEu9luLb9LMmAglFD4UpH7OZM7n
 STXZpGMo9/QxppIofckJmdxm7DHoNN3X1LgSepL9xmUh60iTSaDLGKozHnXXwyBXeUcs
 p6o4FYpCPwTcNSkkBC4jvDtcbWgpppd5XLCe0XPIwO7E4vnRRNIi0jzrz/qoRHboL/YL
 gMVPLvKTI5j/9fssIfQk5ukHHbKwORVsviIaozExJCU7WA1hCcPfAetDp6PcEwgpv6sB
 9x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AznOkEhgwnpFD0CoJMa5eW4WC9cEkYpl0tgCHuHjypk=;
 b=qksJiAAsMmekeAfxI/k9e9fg3+Z+WkYmWdokpyqBUesdqKbR/FtCEvQAVetuHuERTe
 0eJk26xMeXdlcLdUqhVpxkCPMoxojzr7xImha5bqb1cLQvw9q17/8txdWsvnv3hc25VP
 VeQ3XqqVX3ryhTNMrpWtM8+DxgcyXn3Kv1rbcGacgeeP/ghV4G4qAR59vGn/BS3DQqFQ
 +jsZXsGluQ8Aww1n5YjAaGPenKe6z42hk1z3c2QauOLuEHZ4owZHcElcsFP9fQuD+s0m
 UhjquMF65Cr3za4r8twW0lnV/rv01y7wXbpClmot41RtI1SIZdIyRF5Ei6+e4DJpnI4m
 KtcA==
X-Gm-Message-State: AOAM533gUNlgZWAgUSa5Zh9UA2dZL37LQZUq8bPPI1Q7AKvwRtZ0dTsQ
 0DFuRfivStCuLymmS45ojqgdWJh1VL9c8A==
X-Google-Smtp-Source: ABdhPJxjrGRECr6AzstGdZOTEGTPSrnvjcmF7pWUXL6fy9ORlJkFPzMueyDXMcSb9NELfIVS5azPmQ==
X-Received: by 2002:a17:902:7790:: with SMTP id
 o16mr2584815pll.299.1599064570142; 
 Wed, 02 Sep 2020 09:36:10 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b6sm4955441pjz.33.2020.09.02.09.36.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2020 09:36:09 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/7] target/microblaze: Diagnose invalid insns in delay slots
Date: Wed,  2 Sep 2020 09:35:59 -0700
Message-Id: <20200902163559.1077728-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200902163559.1077728-1-richard.henderson@linaro.org>
References: <20200902163559.1077728-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
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

These cases result in undefined and undocumented behaviour but the
behaviour is deterministic, i.e cores will not lock-up or expose
security issues.  However, RTL will not raise exceptions either.

Therefore, log a GUEST_ERROR and treat these cases as nops, to
avoid corner cases which could put qemu into an invalid state.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 47 +++++++++++++++++++++++++++++------
 1 file changed, 40 insertions(+), 7 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 4416361d08..caa4831aed 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -179,6 +179,20 @@ static bool trap_userspace(DisasContext *dc, bool cond)
     return cond_user;
 }
 
+/*
+ * Return true, and log an error, if the current insn is
+ * within a delay slot.
+ */
+static bool invalid_delay_slot(DisasContext *dc, const char *insn_type)
+{
+    if (dc->tb_flags & D_FLAG) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "Invalid insn in delay slot: %s\n", insn_type);
+        return true;
+    }
+    return false;
+}
+
 static TCGv_i32 reg_for_read(DisasContext *dc, int reg)
 {
     if (likely(reg != 0)) {
@@ -500,6 +514,9 @@ DO_TYPEA_CFG(idivu, use_div, true, gen_idivu)
 
 static bool trans_imm(DisasContext *dc, arg_imm *arg)
 {
+    if (invalid_delay_slot(dc, "imm")) {
+        return true;
+    }
     dc->ext_imm = arg->imm << 16;
     tcg_gen_movi_i32(cpu_imm, dc->ext_imm);
     dc->tb_flags_to_set = IMM_FLAG;
@@ -1067,6 +1084,9 @@ static bool do_branch(DisasContext *dc, int dest_rb, int dest_imm,
 {
     uint32_t add_pc;
 
+    if (invalid_delay_slot(dc, "branch")) {
+        return true;
+    }
     if (delay) {
         setup_dslot(dc, dest_rb < 0);
     }
@@ -1106,6 +1126,9 @@ static bool do_bcc(DisasContext *dc, int dest_rb, int dest_imm,
 {
     TCGv_i32 zero, next;
 
+    if (invalid_delay_slot(dc, "bcc")) {
+        return true;
+    }
     if (delay) {
         setup_dslot(dc, dest_rb < 0);
     }
@@ -1158,6 +1181,10 @@ static bool trans_brk(DisasContext *dc, arg_typea_br *arg)
     if (trap_userspace(dc, true)) {
         return true;
     }
+    if (invalid_delay_slot(dc, "brk")) {
+        return true;
+    }
+
     tcg_gen_mov_i32(cpu_pc, reg_for_read(dc, arg->rb));
     if (arg->rd) {
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
@@ -1176,6 +1203,10 @@ static bool trans_brki(DisasContext *dc, arg_typeb_br *arg)
     if (trap_userspace(dc, imm != 0x8 && imm != 0x18)) {
         return true;
     }
+    if (invalid_delay_slot(dc, "brki")) {
+        return true;
+    }
+
     tcg_gen_movi_i32(cpu_pc, imm);
     if (arg->rd) {
         tcg_gen_movi_i32(cpu_R[arg->rd], dc->base.pc_next);
@@ -1216,6 +1247,11 @@ static bool trans_mbar(DisasContext *dc, arg_mbar *arg)
 {
     int mbar_imm = arg->imm;
 
+    /* Note that mbar is a specialized branch instruction. */
+    if (invalid_delay_slot(dc, "mbar")) {
+        return true;
+    }
+
     /* Data access memory barrier.  */
     if ((mbar_imm & 2) == 0) {
         tcg_gen_mb(TCG_BAR_SC | TCG_MO_ALL);
@@ -1263,6 +1299,10 @@ static bool do_rts(DisasContext *dc, arg_typeb_bc *arg, int to_set)
     if (trap_userspace(dc, to_set)) {
         return true;
     }
+    if (invalid_delay_slot(dc, "rts")) {
+        return true;
+    }
+
     dc->tb_flags_to_set |= to_set;
     setup_dslot(dc, true);
 
@@ -1695,7 +1735,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
     if (dc->jmp_cond != TCG_COND_NEVER && !(dc->tb_flags & D_FLAG)) {
         /*
          * Finish any return-from branch.
-         * TODO: Diagnose rtXd in delay slot of rtYd earlier.
          */
         uint32_t rt_ibe = dc->tb_flags & (DRTI_FLAG | DRTB_FLAG | DRTE_FLAG);
         if (unlikely(rt_ibe != 0)) {
@@ -1717,12 +1756,6 @@ static void mb_tr_translate_insn(DisasContextBase *dcb, CPUState *cs)
              * and will handle D_FLAG in mb_cpu_do_interrupt.
              */
             break;
-        case DISAS_EXIT:
-            /*
-             * TODO: diagnose brk/brki in delay slot earlier.
-             * This would then fold into the illegal insn case above.
-             */
-            break;
         case DISAS_NEXT:
             /*
              * Normal insn a delay slot.
-- 
2.25.1


