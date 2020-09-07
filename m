Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C7BC43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:12:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1B8206B5
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 18:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zMVbP3oL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1B8206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42608 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFLdK-0005wZ-5g
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 14:12:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38876)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVz-0003vF-FT
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:15 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435]:38327)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFLVx-0002Ok-IM
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 14:05:15 -0400
Received: by mail-pf1-x435.google.com with SMTP id l126so1934908pfd.5
 for <qemu-devel@nongnu.org>; Mon, 07 Sep 2020 11:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=mCgjeXLmeN5hMfhXUcUPxa4AMIlfBZL76Mf1qDfxbvQ=;
 b=zMVbP3oLWWgFM30PnOzJp2LqHHxqM/KwiridqzGv5Iezku2MXp5uQGack/MQbdp8C/
 ZRmV0xJPJJHAPYFuKg6MHHZaBMv0IpFdpEeW6uzq7m03LMQCkq+1DMrGzM3BeB8+9+7+
 6YxaaYRo3k4G9K/w43SOR8odFpHEcW8WGy6U15yYF9kXvIhmvubPKZ4jSZfPjB8wjjn0
 OLBDeHijSpQjSucxuTY0tQXAwuAcuPuOmtitV8IrWJGJ751rk3UxvOxGE5zf0GzC/cvd
 202hTyOdpF7V50ng2NrZeIiEZWLMfSVUexL4t3e1a7WfnKVb5hozmhSrQk8UZVxRIQHF
 fjKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=mCgjeXLmeN5hMfhXUcUPxa4AMIlfBZL76Mf1qDfxbvQ=;
 b=IGQIRiTPhXs7EZXLFwyldRVoad2Uu6fgkmI49cbyGOSzzPVjPI3GTeYYPA6DcHIaxt
 5+Foj+CO7byOaVYd4XNPts/Q/CYGc0i29dM09dqT20+VtmSTUrglAfeLG71tSc6YNYRv
 UKSBgSBJusC+b1QtUmBylR3FYQW8anXyUcIxbptz0huhCMZqc6yxxXhHMrPBGv3fqkKz
 Gz9V5Sk9Gj3UdrWXklCKo5hKME7/TLVXA8oOP21sYTIQ6jnkD+5F0uUSonk91Vmi0tOv
 aWc4o/Mji2ygy+NytkuCwKatpQJsZxLO4tGeSRSilINr5K92IMqFaYAO8KVcxNVZXYuN
 +/gw==
X-Gm-Message-State: AOAM531S6DH2lQA8el9pMTcOa1yrxOVUayl08G4Q1GY2aSRMqSgnJWle
 bdx1HBuIxu5cjioLHhwp8PF5J0uePDnQ8A==
X-Google-Smtp-Source: ABdhPJyuciwgiQhEkgbRM9gsEyirQGlMKKArijn/4A2qoJMNdLyLVxHJ3dlkCp7jzTv4gRKm2susyA==
X-Received: by 2002:aa7:9aef:: with SMTP id y15mr671228pfp.119.1599501911800; 
 Mon, 07 Sep 2020 11:05:11 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v6sm11367768pfi.38.2020.09.07.11.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2020 11:05:11 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 18/19] target/microblaze: Put MicroBlazeCPUConfig into
 DisasContext
Date: Mon,  7 Sep 2020 11:04:58 -0700
Message-Id: <20200907180459.29025-9-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200907180459.29025-1-richard.henderson@linaro.org>
References: <20200907175102.28027-1-richard.henderson@linaro.org>
 <20200907180459.29025-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

The bulk of the translator should not have access to the
complete cpu state, to avoid the temptation to examine bits
that are in run time, but not translation time context.

We do need access to the constant cpu configuration, and
that is sufficient, so put that into DisasContext.

Tested-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/translate.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index eca422b3db..abfcc7e6c8 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -60,7 +60,7 @@ static TCGv_i32 cpu_res_val;
 /* This is the state at translation time.  */
 typedef struct DisasContext {
     DisasContextBase base;
-    MicroBlazeCPU *cpu;
+    const MicroBlazeCPUConfig *cfg;
 
     /* TCG op of the current insn_start.  */
     TCGOp *insn_start;
@@ -159,7 +159,7 @@ static void gen_goto_tb(DisasContext *dc, int n, target_ulong dest)
 static bool trap_illegal(DisasContext *dc, bool cond)
 {
     if (cond && (dc->tb_flags & MSR_EE)
-        && dc->cpu->cfg.illegal_opcode_exception) {
+        && dc->cfg->illegal_opcode_exception) {
         gen_raise_hw_excp(dc, ESR_EC_ILLEGAL_OP);
     }
     return cond;
@@ -291,7 +291,7 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
 
 #define DO_TYPEA_CFG(NAME, CFG, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typea *a) \
-    { return dc->cpu->cfg.CFG && do_typea(dc, a, SE, FN); }
+    { return dc->cfg->CFG && do_typea(dc, a, SE, FN); }
 
 #define DO_TYPEA0(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typea0 *a) \
@@ -299,7 +299,7 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
 
 #define DO_TYPEA0_CFG(NAME, CFG, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typea0 *a) \
-    { return dc->cpu->cfg.CFG && do_typea0(dc, a, SE, FN); }
+    { return dc->cfg->CFG && do_typea0(dc, a, SE, FN); }
 
 #define DO_TYPEBI(NAME, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
@@ -307,7 +307,7 @@ static bool do_typeb_val(DisasContext *dc, arg_typeb *arg, bool side_effects,
 
 #define DO_TYPEBI_CFG(NAME, CFG, SE, FNI) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
-    { return dc->cpu->cfg.CFG && do_typeb_imm(dc, a, SE, FNI); }
+    { return dc->cfg->CFG && do_typeb_imm(dc, a, SE, FNI); }
 
 #define DO_TYPEBV(NAME, SE, FN) \
     static bool trans_##NAME(DisasContext *dc, arg_typeb *a) \
@@ -683,7 +683,7 @@ static TCGv compute_ldst_addr_typea(DisasContext *dc, int ra, int rb)
         tcg_gen_movi_tl(ret, 0);
     }
 
-    if ((ra == 1 || rb == 1) && dc->cpu->cfg.stackprot) {
+    if ((ra == 1 || rb == 1) && dc->cfg->stackprot) {
         gen_helper_stackprot(cpu_env, ret);
     }
     return ret;
@@ -703,7 +703,7 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
         tcg_gen_movi_tl(ret, (uint32_t)imm);
     }
 
-    if (ra == 1 && dc->cpu->cfg.stackprot) {
+    if (ra == 1 && dc->cfg->stackprot) {
         gen_helper_stackprot(cpu_env, ret);
     }
     return ret;
@@ -712,7 +712,7 @@ static TCGv compute_ldst_addr_typeb(DisasContext *dc, int ra, int imm)
 #ifndef CONFIG_USER_ONLY
 static TCGv compute_ldst_addr_ea(DisasContext *dc, int ra, int rb)
 {
-    int addr_size = dc->cpu->cfg.addr_size;
+    int addr_size = dc->cfg->addr_size;
     TCGv ret = tcg_temp_new();
 
     if (addr_size == 32 || ra == 0) {
@@ -772,7 +772,7 @@ static bool do_load(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
-        dc->cpu->cfg.unaligned_exceptions) {
+        dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, rd, size, false);
         mop |= MO_ALIGN;
     }
@@ -918,7 +918,7 @@ static bool do_store(DisasContext *dc, int rd, TCGv addr, MemOp mop,
 
     if (size > MO_8 &&
         (dc->tb_flags & MSR_EE) &&
-        dc->cpu->cfg.unaligned_exceptions) {
+        dc->cfg->unaligned_exceptions) {
         record_unaligned_ess(dc, rd, size, true);
         mop |= MO_ALIGN;
     }
@@ -1325,7 +1325,7 @@ DO_RTS(rtsd, 0)
 static bool trans_zero(DisasContext *dc, arg_zero *arg)
 {
     /* If opcode_0_illegal, trap.  */
-    if (dc->cpu->cfg.opcode_0_illegal) {
+    if (dc->cfg->opcode_0_illegal) {
         trap_illegal(dc, true);
         return true;
     }
@@ -1658,7 +1658,7 @@ static void mb_tr_init_disas_context(DisasContextBase *dcb, CPUState *cs)
     MicroBlazeCPU *cpu = MICROBLAZE_CPU(cs);
     int bound;
 
-    dc->cpu = cpu;
+    dc->cfg = &cpu->cfg;
     dc->tb_flags = dc->base.tb->flags;
     dc->ext_imm = dc->base.tb->cs_base;
     dc->r0 = NULL;
-- 
2.25.1


