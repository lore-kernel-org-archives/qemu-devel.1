Return-Path: <SRS0=KBml=XB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5BEC43331
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:29:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A515B2081B
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2019 20:29:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBASGjen"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A515B2081B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60092 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i6Kqw-0004vB-PZ
	for qemu-devel@archiver.kernel.org; Fri, 06 Sep 2019 16:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Kob-00036d-Iu
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i6Koa-0002RO-Ce
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:41 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44093)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i6Koa-0002Qa-6G
 for qemu-devel@nongnu.org; Fri, 06 Sep 2019 16:26:40 -0400
Received: by mail-wr1-x444.google.com with SMTP id 30so7798107wrk.11
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2019 13:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ZOU2dawRnEbn8gBP7FThkgEA/iC2qfVj+g99luazd38=;
 b=eBASGjen2ZL2L4llBMfB43XePTKBBldIO3FhxmCpbQvf3xIyLMRS4WtGA4alGa+1VY
 kDhGv4vp95je7khBoW/IJDzfrMqxKIW2Bwfw9vheq21wM+tI638mdXs4x1oPubw0GLk0
 jlb8/w3Unh6BKMn35MeTxTuEfkPchcuLN/EALq2g4J6mHksqIT8ZygBb4va6ElwKlqIc
 GMzE5jUeUQ3WIFaBHz3GfLJC6vimStaJxUEiN/emmK214PDWHr75FL3fHJsNzmd16Ko8
 qCbUv/Kw1SD5in9G+PMwWHHOn2zCCamLPfJ6TSFJIBrlq/pQ5hsqLQ9OcIPxPNw/C3vt
 Aiqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZOU2dawRnEbn8gBP7FThkgEA/iC2qfVj+g99luazd38=;
 b=GyAbLKYguuSBWL0C/eCVh54IcuG+n+H8ZizDzwzutiAXKItWLt44jAp+1Dl4TrGHwq
 A4HOxiEy0uzNtibwoUwhmIXVwXnQEa3fFKF6k3anzSg297cEYQ4Gn1th4v/VWJMD5ibs
 2nTZ/TSlRHKUhyLkjzPjyMVUWaGAKtei8u1i+QYlo4x3b39TN8n50PJb8Yg2jyxaARZb
 fSzE9rrPqxPSwzd0jyvkfIyqAV0o1sZOoIRrZwwsYbvitlbE0gqu3fQbP9P7wwkeCJZz
 DUOndMVcWf+emJG2AlFRaLyBhN56XwFAjKnpimu3SImJo4GY4dyAsifZp+ejRYakWrmo
 BTng==
X-Gm-Message-State: APjAAAUwfsAJugUx2DdNKoAOcfDUTjrckxtE3Chg8k94zdkNbCkZglVH
 pAPVy2vSiC0SqHu7CGokAVgW6MDr7jM=
X-Google-Smtp-Source: APXvYqzPBQ8TabioMmNKXdLwUtekqAgsZ1zrxwN2vTlWSxPOasiB5n4mAFoelpznvIp6oAiwF62GiQ==
X-Received: by 2002:a5d:49c3:: with SMTP id t3mr9007638wrs.151.1567801599051; 
 Fri, 06 Sep 2019 13:26:39 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e3sm9315586wrh.12.2019.09.06.13.26.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Sep 2019 13:26:38 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8CC581FF8F;
 Fri,  6 Sep 2019 21:26:36 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Date: Fri,  6 Sep 2019 21:26:33 +0100
Message-Id: <20190906202636.28642-3-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190906202636.28642-1-alex.bennee@linaro.org>
References: <20190906202636.28642-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
Subject: [Qemu-devel] [PATCH v4 2/4] target/arm: handle A-profile
 semihosting at translate time
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
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

As for the other semihosting calls we can resolve this at translate
time.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>

---
v2
  - update for change to gen_exception_internal_insn API
v3
  - update for decode tree, merge T32 & A32 commits
  - dropped r-b due to changes
v4
  - !IS_USER and !arm_dc_feature(s, ARM_FEATURE_M)
---
 target/arm/translate.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 6689acc911e..d7ee4f88ace 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -10219,14 +10219,22 @@ static bool trans_CBZ(DisasContext *s, arg_CBZ *a)
 }
 
 /*
- * Supervisor call
+ * Supervisor call - both T32 & A32 come here so we need to check
+ * which mode we are in when checking for semihosting.
  */
 
 static bool trans_SVC(DisasContext *s, arg_SVC *a)
 {
-    gen_set_pc_im(s, s->base.pc_next);
-    s->svc_imm = a->imm;
-    s->base.is_jmp = DISAS_SWI;
+    const uint32_t semihost_imm = s->thumb ? 0xab : 0x123456;
+
+    if (!arm_dc_feature(s, ARM_FEATURE_M) && semihosting_enabled()
+        && !IS_USER(s) && (a->imm == semihost_imm)) {
+        gen_exception_internal_insn(s, s->base.pc_next, EXCP_SEMIHOST);
+    } else {
+        gen_set_pc_im(s, s->base.pc_next);
+        s->svc_imm = a->imm;
+        s->base.is_jmp = DISAS_SWI;
+    }
     return true;
 }
 
-- 
2.20.1


