Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C788C3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33F8520820
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 21:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JW+pzhK4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33F8520820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5cxE-0002TN-G7
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 17:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9U-00063v-Qk
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5c9S-0006i0-Ri
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:16 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a]:38889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5c9S-0006hF-KN
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 16:45:14 -0400
Received: by mail-pf1-x42a.google.com with SMTP id h195so36805pfe.5
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 13:45:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=l5xF9L8hbrVx8UtpucRjuAJTrSqlDemzuCm3zQWWOUA=;
 b=JW+pzhK42qd7ZaM/De0bYUfVsqrtMjydtLu+17e6vIm9sCVJ67WhqV6xjeWbHBJfru
 oAfF+N9qgd07TYsTJYos9VWhofoiK3sTV6/acDN/DqEz4gTS2m0tVzkrG15c3x1uj5ca
 uKjQYvJE8EvzOVo4LOc8ZhNxTBUOy+FhI5hhrLhSfajeeFNqQQ5iTu4k5PrBwrhCwPtF
 zTV/uF0Z6+3yx963+O+TDNvVEM79qOVOnP+VnHyQ+U4Q7F0ULcSZb52BQ1MlORv0cYuQ
 6syqOTTV7MeXyURbkSbrbquDxT8wpKZIZ/pY/uCOF6Ftr9Tn3p6rsHTC+tggIZssccmg
 Mclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=l5xF9L8hbrVx8UtpucRjuAJTrSqlDemzuCm3zQWWOUA=;
 b=JOwZlD3M3qob65ojoq3cFS2TrH51fiu23PuC1Ya74gvNNnp79wtOL+XZK7yFIPzSjp
 NcbTwsi4/aRS+61U5bUuSHa0aThcs9nrxJwQoJUaaiSQyKAQ3shoQG11Qo1l+4K8DZ0u
 GSg/u6RmJmdWVFy6o+GkoK7fA6NDMIloZIdEMPNahE/xuj/nqmy4gaScpi/9wDnCUu77
 po3qCiqKVVl2bU/uv69HICF8EYmAr3vYNNmZQrgImqvw41AUn2uLqPPLuP6kyJ6HMxcr
 lCpna9s+tG3RFJCrcRx6X0oXUblVl56+YmFzFz/qaWMYpATa6OUSHqJ7S+fN4JktySsU
 ysGA==
X-Gm-Message-State: APjAAAX6KD7rgIYfNBYdYIuEazsc16Ky5UeVWmyuFiqXgl2dP6M5/Clr
 nnMqZadu7JlnM2Y2XmJdjm/I+RNVGUY=
X-Google-Smtp-Source: APXvYqxa2ffNY0VInWY4UjXYWJpvSMMlCir5V6CJhZV2ypydJqhz+dyVTkK8gpzuDt+1+kW7zg+Swg==
X-Received: by 2002:a63:484d:: with SMTP id x13mr71294pgk.122.1567629913011;
 Wed, 04 Sep 2019 13:45:13 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id n66sm8104610pfn.90.2019.09.04.13.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 13:45:12 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 13:44:57 -0700
Message-Id: <20190904204507.32457-4-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904204507.32457-1-richard.henderson@linaro.org>
References: <20190904204507.32457-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::42a
Subject: [Qemu-devel] [PULL 03/13] target/openrisc: Cache R0 in DisasContext
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Finish the race condition fix from the previous patch.

Reviewed-by: Stafford Horne <shorne@gmail.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/openrisc/translate.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/target/openrisc/translate.c b/target/openrisc/translate.c
index d635a46f7e..341f923864 100644
--- a/target/openrisc/translate.c
+++ b/target/openrisc/translate.c
@@ -48,6 +48,9 @@ typedef struct DisasContext {
 
     /* If not -1, jmp_pc contains this value and so is a direct jump.  */
     target_ulong jmp_pc_imm;
+
+    /* The temporary corresponding to register 0 for this compilation.  */
+    TCGv R0;
 } DisasContext;
 
 static inline bool is_user(DisasContext *dc)
@@ -64,7 +67,6 @@ static inline bool is_user(DisasContext *dc)
 
 static TCGv cpu_sr;
 static TCGv cpu_regs[32];
-static TCGv cpu_R0;
 static TCGv cpu_pc;
 static TCGv jmp_pc;            /* l.jr/l.jalr temp pc */
 static TCGv cpu_ppc;
@@ -122,7 +124,6 @@ void openrisc_translate_init(void)
                                                   shadow_gpr[0][i]),
                                          regnames[i]);
     }
-    cpu_R0 = cpu_regs[0];
 }
 
 static void gen_exception(DisasContext *dc, unsigned int excp)
@@ -165,7 +166,11 @@ static void check_ov64s(DisasContext *dc)
 
 static TCGv cpu_R(DisasContext *dc, int reg)
 {
-    return cpu_regs[reg];
+    if (reg == 0) {
+        return dc->R0;
+    } else {
+        return cpu_regs[reg];
+    }
 }
 
 /*
@@ -175,7 +180,7 @@ static TCGv cpu_R(DisasContext *dc, int reg)
 static void check_r0_write(DisasContext *dc, int reg)
 {
     if (unlikely(reg == 0)) {
-        cpu_regs[0] = cpu_R0;
+        dc->R0 = cpu_regs[0];
     }
 }
 
@@ -747,7 +752,7 @@ static bool trans_l_swa(DisasContext *dc, arg_store *a)
        to cpu_regs[0].  Since l.swa is quite often immediately followed by a
        branch, don't bother reallocating; finish the TB using the "real" R0.
        This also takes care of RB input across the branch.  */
-    cpu_regs[0] = cpu_R0;
+    dc->R0 = cpu_regs[0];
 
     lab_fail = gen_new_label();
     lab_done = gen_new_label();
@@ -1292,9 +1297,9 @@ static void openrisc_tr_tb_start(DisasContextBase *db, CPUState *cs)
     /* Allow the TCG optimizer to see that R0 == 0,
        when it's true, which is the common case.  */
     if (dc->tb_flags & TB_FLAGS_R0_0) {
-        cpu_regs[0] = tcg_const_tl(0);
+        dc->R0 = tcg_const_tl(0);
     } else {
-        cpu_regs[0] = cpu_R0;
+        dc->R0 = cpu_regs[0];
     }
 }
 
-- 
2.17.1


