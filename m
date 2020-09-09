Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C57F5C43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:26:37 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F81E2145D
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 00:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fV1LqSRE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F81E2145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50938 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFnwa-0004Y0-JH
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 20:26:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37544)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnna-0008QJ-Gv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:18 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:39475)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kFnnY-0002Ff-FU
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 20:17:18 -0400
Received: by mail-pj1-x1042.google.com with SMTP id s2so426078pjr.4
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2020 17:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=1NhNPEIDsGzd2+XZQVnWFC0k3zKAB+Awk5/hTm4NEwE=;
 b=fV1LqSREgOEiUJmb7AH6Z7MTZwMsxQ0vHK0Bm0EDMeCsIMI6nZNa2SNCh9rrgYVTi6
 nT+Dya25DqJG+W14bXeZ/a9U6h7o+4n18YvO+iQlaHHQW5GUD+/+vamKMlMiyQfmjhhM
 BS578KPqLPxEPgjbJU5MN8RXkbFSzD/3Lt5F9vrWntiAJt3hs0N+v8swRpW7r6+N90Qm
 jy5oviYkldsy+mYtVqJV2Tg5FDsEizta8wGFQ9RXMKJrJHCg49Aq6jBJ6wlk69bhZN4v
 MKw9BOu0T+5+uK4zR5x1hTvoIILIcK5gIg2wrreYCmBg3+2S8/+C36hUul6qgE6Ps0NS
 M5Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1NhNPEIDsGzd2+XZQVnWFC0k3zKAB+Awk5/hTm4NEwE=;
 b=lKPWTY6MdDpBp/ikbaNFltn92YZoc4RduzSuUQ6KFV/Ii/5Inb+37e22c6Z3F2mmwW
 chjbbVGMMzv6vgREdDm94EHsUmvQqaJNeqUrKlUXIbt7Nqb3sEdFH2RZPTc98uDtSDLQ
 xwiOPXYn/3ptdM1ykzyJtBjb3Benu5+D8zXDwZxQGTcLr15HYmx/2AolRsO+x+aOo0ze
 /NE8Sx/3izPOsQfllEOaMoahiLGFW2B6yAPyrR46E1WDcbQ01UeA5Af8c+j2qwPuAVlq
 mhKDLT/xQToY0D6FYDIvEbocdA0wUcGSVe7SliZXHLpzMh5DKeG0v95eFrIPyY0QrAeh
 f0og==
X-Gm-Message-State: AOAM532QZLd3fYdFDLU81YHBsHFF2c4Y6BouWeqI5WQMoKF20hN1vAED
 p7whDjLNJzJkFTdYb/Jc9Pqp2FcIO08eAg==
X-Google-Smtp-Source: ABdhPJz0nA4HjC/sXvhFZOW0Bppsi5Shisd+eICAMCahDqBaMfLN77ctiRa91RC+M9uOiHUE6Gg+Gg==
X-Received: by 2002:a17:90a:5609:: with SMTP id
 r9mr1186624pjf.217.1599610634646; 
 Tue, 08 Sep 2020 17:17:14 -0700 (PDT)
Received: from localhost.localdomain ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id 137sm505437pfu.149.2020.09.08.17.17.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2020 17:17:13 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 20/43] tcg/optimize: Adjust TempOptInfo allocation
Date: Tue,  8 Sep 2020 17:16:24 -0700
Message-Id: <20200909001647.532249-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200909001647.532249-1-richard.henderson@linaro.org>
References: <20200909001647.532249-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Do not allocate a large block for indexing.  Instead, allocate
for each temporary as they are seen.

In general, this will use less memory, if we consider that most
TBs do not touch every target register.  This also allows us to
allocate TempOptInfo for new temps created during optimization.

Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 tcg/optimize.c | 60 ++++++++++++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 26 deletions(-)

diff --git a/tcg/optimize.c b/tcg/optimize.c
index bf2c2a3ce5..e269962932 100644
--- a/tcg/optimize.c
+++ b/tcg/optimize.c
@@ -89,35 +89,41 @@ static void reset_temp(TCGArg arg)
 }
 
 /* Initialize and activate a temporary.  */
-static void init_ts_info(TempOptInfo *infos,
-                         TCGTempSet *temps_used, TCGTemp *ts)
+static void init_ts_info(TCGTempSet *temps_used, TCGTemp *ts)
 {
     size_t idx = temp_idx(ts);
-    if (!test_bit(idx, temps_used->l)) {
-        TempOptInfo *ti = &infos[idx];
+    TempOptInfo *ti;
 
+    if (test_bit(idx, temps_used->l)) {
+        return;
+    }
+    set_bit(idx, temps_used->l);
+
+    ti = ts->state_ptr;
+    if (ti == NULL) {
+        ti = tcg_malloc(sizeof(TempOptInfo));
         ts->state_ptr = ti;
-        ti->next_copy = ts;
-        ti->prev_copy = ts;
-        if (ts->kind == TEMP_CONST) {
-            ti->is_const = true;
-            ti->val = ti->mask = ts->val;
-            if (TCG_TARGET_REG_BITS > 32 && ts->type == TCG_TYPE_I32) {
-                /* High bits of a 32-bit quantity are garbage.  */
-                ti->mask |= ~0xffffffffull;
-            }
-        } else {
-            ti->is_const = false;
-            ti->mask = -1;
+    }
+
+    ti->next_copy = ts;
+    ti->prev_copy = ts;
+    if (ts->kind == TEMP_CONST) {
+        ti->is_const = true;
+        ti->val = ts->val;
+        ti->mask = ts->val;
+        if (TCG_TARGET_REG_BITS > 32 && ts->type == TCG_TYPE_I32) {
+            /* High bits of a 32-bit quantity are garbage.  */
+            ti->mask |= ~0xffffffffull;
         }
-        set_bit(idx, temps_used->l);
+    } else {
+        ti->is_const = false;
+        ti->mask = -1;
     }
 }
 
-static void init_arg_info(TempOptInfo *infos,
-                          TCGTempSet *temps_used, TCGArg arg)
+static void init_arg_info(TCGTempSet *temps_used, TCGArg arg)
 {
-    init_ts_info(infos, temps_used, arg_temp(arg));
+    init_ts_info(temps_used, arg_temp(arg));
 }
 
 static TCGTemp *find_better_copy(TCGContext *s, TCGTemp *ts)
@@ -604,9 +610,8 @@ static bool swap_commutative2(TCGArg *p1, TCGArg *p2)
 /* Propagate constants and copies, fold constant expressions. */
 void tcg_optimize(TCGContext *s)
 {
-    int nb_temps, nb_globals;
+    int nb_temps, nb_globals, i;
     TCGOp *op, *op_next, *prev_mb = NULL;
-    TempOptInfo *infos;
     TCGTempSet temps_used;
 
     /* Array VALS has an element for each temp.
@@ -616,12 +621,15 @@ void tcg_optimize(TCGContext *s)
 
     nb_temps = s->nb_temps;
     nb_globals = s->nb_globals;
+
     bitmap_zero(temps_used.l, nb_temps);
-    infos = tcg_malloc(sizeof(TempOptInfo) * nb_temps);
+    for (i = 0; i < nb_temps; ++i) {
+        s->temps[i].state_ptr = NULL;
+    }
 
     QTAILQ_FOREACH_SAFE(op, &s->ops, link, op_next) {
         uint64_t mask, partmask, affected, tmp;
-        int nb_oargs, nb_iargs, i;
+        int nb_oargs, nb_iargs;
         TCGOpcode opc = op->opc;
         const TCGOpDef *def = &tcg_op_defs[opc];
 
@@ -633,14 +641,14 @@ void tcg_optimize(TCGContext *s)
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
                 TCGTemp *ts = arg_temp(op->args[i]);
                 if (ts) {
-                    init_ts_info(infos, &temps_used, ts);
+                    init_ts_info(&temps_used, ts);
                 }
             }
         } else {
             nb_oargs = def->nb_oargs;
             nb_iargs = def->nb_iargs;
             for (i = 0; i < nb_oargs + nb_iargs; i++) {
-                init_arg_info(infos, &temps_used, op->args[i]);
+                init_arg_info(&temps_used, op->args[i]);
             }
         }
 
-- 
2.25.1


