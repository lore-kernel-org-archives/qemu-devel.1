Return-Path: <SRS0=3xBk=XV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3894DC4360C
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:47:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 045F921A4A
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Sep 2019 18:47:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efeJzI1D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 045F921A4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDYnT-0002qN-7H
	for qemu-devel@archiver.kernel.org; Thu, 26 Sep 2019 14:47:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41972)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcT-0007sV-JE
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iDYcR-0006OB-HN
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:36:01 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:44826)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iDYcR-0006NC-76
 for qemu-devel@nongnu.org; Thu, 26 Sep 2019 14:35:59 -0400
Received: by mail-wr1-x435.google.com with SMTP id i18so3579650wru.11
 for <qemu-devel@nongnu.org>; Thu, 26 Sep 2019 11:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=M49TMOJnQfsDs7atiPQonLRDkNfoRnUwiw00uQvlOPM=;
 b=efeJzI1Dvn7Rcm92dTV9bBV0pBabTB2+QU5xe8QgDjKpJ4OIMWItVvSok8rVg7FDqT
 wF5oZLrxmJgsNns1sSAV76Qwz5fVZdWqc0/mxCf/5mXeX2Sj5XJjixtX3PbY+oLTcufh
 xOwnnGj8q4rOgwm/xhy7Q8OuEpq+JHXjgsHiQtAnupGTO5AWEl65qZyO/SkYi8rIeIsx
 52yN1vurMB3Oyv2R/Q/fE1h98kzbK5ZUuX5WxQQZV9jrpx5tjjTQOkO8u9BWrg2RRCyM
 /iuHPRH/3419ZH2SfKiJbZpbCchzT5EHoEIRYW8mcGtVnqaL5SnsDxA2gRENni1A68/b
 1fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=M49TMOJnQfsDs7atiPQonLRDkNfoRnUwiw00uQvlOPM=;
 b=COPcoPWo21dH2HkiCrItecOxsr5kh41/uYCpngnGs9q6K3f48h2O2b3D5yZMXzKX+G
 dAPYcbe7+N0H0XMBt0QH1531PprdK0qn6Gyz5yKrTdvzoOZDQgIivEi1JJHFe68gBSS6
 DZxbrQbDC8OqV1VN3Fik/0oE+HZi4noWPAZ5yOEtjIVtlXwIx7pJNqeItahQWl1jzzwT
 JkTXGSydifS6lApiWOi88lwICf47xYLIlW/efewcTZxAY/aJ7OOxmkxH3vC5mNol0fCf
 4H+znTnsdAnV4jnN9pIHLnvFIYGzCbbV1r65RYE4x3BIliO4Fii1oKpNgc+JU1yq9ohK
 +PJA==
X-Gm-Message-State: APjAAAWWGqnerOqzW1nKpUAFoGNQDp9m6RF8bo3K0wMStrOHiM4oxDQ2
 hVwTpjT8CBegW2KBaUcWoNZ6iw==
X-Google-Smtp-Source: APXvYqyYC23/Fhiog27VkgEQkPtJRdig6rZAugLXA0qSi3msCcr+Tkjwc0pZg6+Q2kBMTVZzmExUrA==
X-Received: by 2002:adf:f790:: with SMTP id q16mr3997482wrp.164.1569522957983; 
 Thu, 26 Sep 2019 11:35:57 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id s12sm20909wra.82.2019.09.26.11.35.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Sep 2019 11:35:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8DEF21FF91;
 Thu, 26 Sep 2019 19:35:53 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 04/28] target/alpha: Handle SWCR_MAP_DMZ earlier
Date: Thu, 26 Sep 2019 19:35:29 +0100
Message-Id: <20190926183553.13895-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190926183553.13895-1-alex.bennee@linaro.org>
References: <20190926183553.13895-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::435
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
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

Since we're converting the swcr to fpcr format for exceptions,
it's trivial to add FPCR_DNZ to the set of fpcr bits overriden.
No functional change.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Message-Id: <20190921043256.4575-5-richard.henderson@linaro.org>

diff --git a/target/alpha/helper.c b/target/alpha/helper.c
index e21c488aa3..2f959c65ef 100644
--- a/target/alpha/helper.c
+++ b/target/alpha/helper.c
@@ -57,7 +57,7 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
      * the software exception mask.
      */
     uint32_t soft_fpcr = alpha_ieee_swcr_to_fpcr(env->swcr) >> 32;
-    fpcr |= soft_fpcr & FPCR_STATUS_MASK;
+    fpcr |= soft_fpcr & (FPCR_STATUS_MASK | FPCR_DNZ);
 #endif
 
     t |= CONVERT_BIT(fpcr, FPCR_INED, FPCR_INE);
@@ -73,9 +73,6 @@ void cpu_alpha_store_fpcr(CPUAlphaState *env, uint64_t val)
     env->fpcr_flush_to_zero = (fpcr & FPCR_UNFD) && (fpcr & FPCR_UNDZ);
     env->fp_status.flush_inputs_to_zero = (fpcr & FPCR_DNZ) != 0;
 #ifdef CONFIG_USER_ONLY
-    if (env->swcr & SWCR_MAP_DMZ) {
-        env->fp_status.flush_inputs_to_zero = 1;
-    }
     if (env->swcr & SWCR_MAP_UMZ) {
         env->fpcr_flush_to_zero = 1;
     }
-- 
2.20.1


