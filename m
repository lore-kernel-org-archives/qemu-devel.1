Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6058FC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC8D021D7B
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:22:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MbMTiyfr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC8D021D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnsk-0003AS-2M
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnS-00088u-Fa
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:10 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:32980)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnQ-0002Dz-JD
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:10 -0400
Received: by mail-pf1-x442.google.com with SMTP id c196so693553pfc.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=rTAqa+wuViRD6SzNvlxc8Defn9W1bqKKSu3gjI9aSic=;
 b=MbMTiyfrjK8FPwVTDS/SjSTwDSww11I8mRzmDL0RlwYBkS3zHgKHmAODOBO46LLdA4
 KGpbnLX97lMwLezJsxbCpAZgQBLTgOxeVsRyHDwqlFj31wC3npAIq/lxAgXRCTz3rZjZ
 igR7zEapQACVtWcUGUWd0iB13k7iX2VE0gOoOTnpBHDQMPPbNAb28noDQmNxX8UKDrZQ
 OgNxmvl72r2maDHWj+exCYMlb26VJcUHtNPjrIs9KytTEAcGNzF5XFwtEVxyEmgzFZSJ
 OPoBPLGDmaoSXQZpkxnYmea1LYODUfG5fcUdlqOwRhjrFSvmeE0eRZomu9LPJQveRl/b
 PQLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rTAqa+wuViRD6SzNvlxc8Defn9W1bqKKSu3gjI9aSic=;
 b=IIgq6kJQhkwKTj35Z/UbwyxMYY5+WD/w+oDNuR0SqW6MYR4Z/uonAmZruYxa6/xGto
 hBDsnYZOHUj5R/n8M+WHK/5dIpLIdng3a4m1x/FeuTgeD6nFDb1Yy6X6NdIRnK+iUJ42
 cFSJpes/A8sZDkC1lTrBgUnlvw0rN3y4L4QueApRzG0Q7sJ/dCj63hUVTsucKNrMa/iJ
 7bdkC+tyLsvPwn+WXvbYwHxgWeVVY0ThJw+4WhmUdsPVZFvJ6RxU8sp5lxQkBmDYzoBT
 ZkyETaY9SAk+gEGTKNlzWZS5mJ70Za+ukylG0OObHqffx2mwDqA6LWBkzpJOeveun6j3
 CfQA==
X-Gm-Message-State: AOAM530f8qow8S01YlQHnA7P+BnR3qpiSRbVigQ8d56vlrT3T43XaMZv
 DZftNXTkJcyQGfCnB+5vAjzKxjCFbw2q5g==
X-Google-Smtp-Source: ABdhPJyqumw8ZbcthNvfop29LDx8rChC7KDINvTntn9HCdLq5FcRVcpXSPEc8gDbd/uqTo2sEDIETg==
X-Received: by 2002:a17:902:a509:b029:d0:cb2d:f26e with SMTP id
 s9-20020a170902a509b02900d0cb2df26emr1455218plq.7.1599610626841; 
 Tue, 08 Sep 2020 17:17:06 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:06 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 14/43] tcg: Add temp_readonly
Date: Tue,  8 Sep 2020 17:16:18 -0700
Message-Id: <20200909001647.532249-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In most, but not all, places that we check for TEMP_FIXED,
we are really testing that we do not modify the temporary.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 include/tcg/tcg.h |  5 +++++
 tcg/tcg.c         | 21 ++++++++++-----------
 2 files changed, 15 insertions(+), 11 deletions(-)

diff --git a/include/tcg/tcg.h b/include/tcg/tcg.h
index f157092b51..44ca8845cf 100644
--- a/include/tcg/tcg.h
+++ b/include/tcg/tcg.h
@@ -681,6 +681,11 @@ struct TCGContext {
     target_ulong gen_insn_data[TCG_MAX_INSNS][TARGET_INSN_START_WORDS];
 };
 
+static inline bool temp_readonly(TCGTemp *ts)
+{
+    return ts->kind == TEMP_FIXED;
+}
+
 extern TCGContext tcg_init_ctx;
 extern __thread TCGContext *tcg_ctx;
 extern TCGv_env cpu_env;
diff --git a/tcg/tcg.c b/tcg/tcg.c
index 67e122527b..577bfec202 100644
--- a/tcg/tcg.c
+++ b/tcg/tcg.c
@@ -3172,7 +3172,7 @@ static void temp_load(TCGContext *, TCGTemp *, TCGRegSet, TCGRegSet, TCGRegSet);
    mark it free; otherwise mark it dead.  */
 static void temp_free_or_dead(TCGContext *s, TCGTemp *ts, int free_or_dead)
 {
-    if (ts->kind == TEMP_FIXED) {
+    if (temp_readonly(ts)) {
         return;
     }
     if (ts->val_type == TEMP_VAL_REG) {
@@ -3196,7 +3196,7 @@ static inline void temp_dead(TCGContext *s, TCGTemp *ts)
 static void temp_sync(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs,
                       TCGRegSet preferred_regs, int free_or_dead)
 {
-    if (ts->kind == TEMP_FIXED) {
+    if (temp_readonly(ts)) {
         return;
     }
     if (!ts->mem_coherent) {
@@ -3379,8 +3379,7 @@ static void temp_save(TCGContext *s, TCGTemp *ts, TCGRegSet allocated_regs)
 {
     /* The liveness analysis already ensures that globals are back
        in memory. Keep an tcg_debug_assert for safety. */
-    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM
-                     || ts->kind == TEMP_FIXED);
+    tcg_debug_assert(ts->val_type == TEMP_VAL_MEM || temp_readonly(ts));
 }
 
 /* save globals to their canonical location and assume they can be
@@ -3438,7 +3437,7 @@ static void tcg_reg_alloc_do_movi(TCGContext *s, TCGTemp *ots,
                                   TCGRegSet preferred_regs)
 {
     /* ENV should not be modified.  */
-    tcg_debug_assert(ots->kind != TEMP_FIXED);
+    tcg_debug_assert(!temp_readonly(ots));
 
     /* The movi is not explicitly generated here.  */
     if (ots->val_type == TEMP_VAL_REG) {
@@ -3478,7 +3477,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
     ts = arg_temp(op->args[1]);
 
     /* ENV should not be modified.  */
-    tcg_debug_assert(ots->kind != TEMP_FIXED);
+    tcg_debug_assert(!temp_readonly(ots));
 
     /* Note that otype != itype for no-op truncation.  */
     otype = ots->type;
@@ -3539,7 +3538,7 @@ static void tcg_reg_alloc_mov(TCGContext *s, const TCGOp *op)
                  * Store the source register into the destination slot
                  * and leave the destination temp as TEMP_VAL_MEM.
                  */
-                assert(ots->kind != TEMP_FIXED);
+                assert(!temp_readonly(ots));
                 if (!ts->mem_allocated) {
                     temp_allocate_frame(s, ots);
                 }
@@ -3576,7 +3575,7 @@ static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
     its = arg_temp(op->args[1]);
 
     /* ENV should not be modified.  */
-    tcg_debug_assert(ots->kind != TEMP_FIXED);
+    tcg_debug_assert(!temp_readonly(ots));
 
     itype = its->type;
     vece = TCGOP_VECE(op);
@@ -3806,7 +3805,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
             ts = arg_temp(arg);
 
             /* ENV should not be modified.  */
-            tcg_debug_assert(ts->kind != TEMP_FIXED);
+            tcg_debug_assert(!temp_readonly(ts));
 
             if (arg_ct->oalias && !const_args[arg_ct->alias_index]) {
                 reg = new_args[arg_ct->alias_index];
@@ -3847,7 +3846,7 @@ static void tcg_reg_alloc_op(TCGContext *s, const TCGOp *op)
         ts = arg_temp(op->args[i]);
 
         /* ENV should not be modified.  */
-        tcg_debug_assert(ts->kind != TEMP_FIXED);
+        tcg_debug_assert(!temp_readonly(ts));
 
         if (NEED_SYNC_ARG(i)) {
             temp_sync(s, ts, o_allocated_regs, 0, IS_DEAD_ARG(i));
@@ -3979,7 +3978,7 @@ static void tcg_reg_alloc_call(TCGContext *s, TCGOp *op)
         ts = arg_temp(arg);
 
         /* ENV should not be modified.  */
-        tcg_debug_assert(ts->kind != TEMP_FIXED);
+        tcg_debug_assert(!temp_readonly(ts));
 
         reg = tcg_target_call_oarg_regs[i];
         tcg_debug_assert(s->reg_to_temp[reg] == NULL);
-- 
2.25.1


