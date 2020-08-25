Return-Path: <SRS0=2GMi=CD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B3FFC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:22:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0289B20738
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2020 21:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r2HUuPvh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0289B20738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44238 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kAgOg-0001Cj-4b
	for qemu-devel@archiver.kernel.org; Tue, 25 Aug 2020 17:22:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg43-000099-6a
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:08 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f]:56102)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kAg3z-0001zq-6t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2020 17:01:06 -0400
Received: by mail-pj1-x102f.google.com with SMTP id 2so118328pjx.5
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2020 14:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8b0bp9mk+1WbNfIATZBmVlR2NfvcC4JEryF82Ik81YY=;
 b=r2HUuPvhKirChEZkUK4KJtTJepETf/6ibKth2j7LthDaibAOMUyHDGPttbFvSVoPrm
 C0u4l7nJDt9e5WaFlon9bNzBC5mL1dBYmxYTo4zQFDo+hOIZ63CdVSMgw4+IgCqeHg8Q
 dHQ5Dwz2kgkL7sS0vviy/r/P++szwMibw0unNxk7Sev5vB168PtNMTGgiV1VBe9Upczl
 PCOpcxCmih2CZGa4451c/HsrSO6qOJE8EpaJsqs7BMvyXh/slnfTGHtBqKdjId9cOxfl
 M2bxTAdJm4JYMxuQeLpOz7fMFDf24dz3t1/auM6jX+GX2usLaw/my3g/lw6EeGeM/MHH
 nO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8b0bp9mk+1WbNfIATZBmVlR2NfvcC4JEryF82Ik81YY=;
 b=k4fApancvQgYrGJLGOOz++2EILUGM12nabdmu5MKpygOSxgPzzReQf9fah2QAe6BzA
 mTuZTy/nwDKbefPDUiij4QtAbqRRuhCEkwgRLqLErDyg3UEPalRGvVSGW91YkyFlSRxW
 6dAvsdj1qC7CrB3YHlzdwbh2QSkowdNva2BARcdFZVfbIEFvn3H+0l0NZDHyVBRCnhBi
 UHfxU4syo0ivluJF3n0b/FElzv7QLWN1sW6LKsWC+enZfS+FoHjtmdny9uwdKU3oyqCt
 3eTZjYHtnTWNtI/NYgw1roUfLjsZZPBQbo0Ubm2L3ntuycULqxpjTqsnATYFtPb+1gvP
 fasg==
X-Gm-Message-State: AOAM533ai1pF4B3UlRzCvj1JllW2UwgkrJsBdL+OqlK5R69yx5zAytr1
 DBU/Hkloe+hClpHtbFW7GzJV6XaAlkYNmA==
X-Google-Smtp-Source: ABdhPJy92C8yJUoJLSw6lQRCe3zrFRjRsaL+lsk2+yuHn9MS+isRdn0E/lV+eGfmnF5k32i78bnSNQ==
X-Received: by 2002:a17:90b:40cb:: with SMTP id
 hj11mr3227959pjb.67.1598389260896; 
 Tue, 25 Aug 2020 14:01:00 -0700 (PDT)
Received: from localhost.localdomain
 (h216-228-167-147.bendor.dedicated.static.tds.net. [216.228.167.147])
 by smtp.gmail.com with ESMTPSA id k4sm16074pgr.87.2020.08.25.14.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2020 14:01:00 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 55/77] target/microblaze: Move bimm to BIMM_FLAG
Date: Tue, 25 Aug 2020 13:59:28 -0700
Message-Id: <20200825205950.730499-56-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200825205950.730499-1-richard.henderson@linaro.org>
References: <20200825205950.730499-1-richard.henderson@linaro.org>
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
Cc: edgar.iglesias@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It makes sense to keep BIMM with D_FLAG, as they can be written
back to iflags at the same time.  BIMM_FLAG does not need to be
added to IFLAGS_TB_MASK because it does not affect the next TB,
only the exception path out of the current TB.  Renumber IMM_FLAG,
as the value 4 holds no particular significance; pack these two
flags at the bottom of the bitfield.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/microblaze/cpu.h       |  4 ++--
 target/microblaze/helper.c    |  2 +-
 target/microblaze/translate.c | 12 +++++-------
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
index 2fc7cf26f1..a5df1fa28f 100644
--- a/target/microblaze/cpu.h
+++ b/target/microblaze/cpu.h
@@ -231,7 +231,6 @@ typedef struct CPUMBState CPUMBState;
 struct CPUMBState {
     uint32_t btaken;
     uint32_t btarget;
-    uint32_t bimm;
 
     uint32_t imm;
     uint32_t regs[32];
@@ -253,7 +252,8 @@ struct CPUMBState {
     uint32_t res_val;
 
     /* Internal flags.  */
-#define IMM_FLAG	4
+#define IMM_FLAG        (1 << 0)
+#define BIMM_FLAG       (1 << 1)
 /* MSR_EE               (1 << 8)  */
 /* MSR_UM               (1 << 11) */
 /* MSR_VM               (1 << 13) */
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
index f8e2ca12a9..06f4322e09 100644
--- a/target/microblaze/helper.c
+++ b/target/microblaze/helper.c
@@ -166,7 +166,7 @@ void mb_cpu_do_interrupt(CPUState *cs)
                 /* Reexecute the branch.  */
                 env->regs[17] -= 4;
                 /* was the branch immprefixed?.  */
-                if (env->bimm) {
+                if (env->iflags & BIMM_FLAG) {
                     env->regs[17] -= 4;
                     log_cpu_state_mask(CPU_LOG_INT, cs, 0);
                 }
diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 42d6d2a593..7fd1efd3fb 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1337,13 +1337,11 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i32 pc_true, TCGv_i32 pc_false)
 
 static void dec_setup_dslot(DisasContext *dc)
 {
-        TCGv_i32 tmp = tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG));
-
-        dc->delayed_branch = 2;
-        dc->tb_flags |= D_FLAG;
-
-        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, bimm));
-        tcg_temp_free_i32(tmp);
+    dc->delayed_branch = 2;
+    dc->tb_flags |= D_FLAG;
+    if (dc->type_b && (dc->tb_flags & IMM_FLAG)) {
+        dc->tb_flags |= BIMM_FLAG;
+    }
 }
 
 static void dec_bcc(DisasContext *dc)
-- 
2.25.1


