Return-Path: <SRS0=Z2zD=34=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B42C35254
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:10:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 751012051A
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Feb 2020 13:10:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="psKcGHON"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 751012051A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41394 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j0Pso-0007OH-NX
	for qemu-devel@archiver.kernel.org; Sat, 08 Feb 2020 08:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41578)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Ph2-00013t-38
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j0Ph1-0005JO-0n
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:40 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35127)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j0Ph0-0005HA-Qo
 for qemu-devel@nongnu.org; Sat, 08 Feb 2020 07:58:38 -0500
Received: by mail-wm1-x341.google.com with SMTP id b17so5669232wmb.0
 for <qemu-devel@nongnu.org>; Sat, 08 Feb 2020 04:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=n25wa1lNKzA3qMHXUq9DJlF06TNEvhgokWarr1Y211Q=;
 b=psKcGHONxPbVPczSPJVjt80mj8pHOVWa1UuZ9t0rLSlscGs6ASfahIYU6ZuhYSQJiN
 FprqaBdkdJG4A8BD6Z58ELF8rYPLvVUyAWKdvowbrW9p+Ydq7SUu1iMqKOSN+M/NVNdQ
 nJR/Tw+1kXNYgBg6q3vOoZAdsANhWI5lGOOI0yxXAftwzwNnQJbsCMuF+emrV7UDvl+q
 Nm7hGZ+n1P9UO4+CC49m0oQSWLpBXxX5gbcfFjGK1mn38RVqv+NmHjjmgZpMR91PngHQ
 frYXexwnlN9KaxyM/jhaIqijYx3uiTSPVeq1hFRfFWDDx5zHl8XVbyn6chTHrbLS/LBh
 1LoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=n25wa1lNKzA3qMHXUq9DJlF06TNEvhgokWarr1Y211Q=;
 b=YIlV3GHgYT9z+bkWBOnZ6g69mkRuZCd4AqGiH1YLPqJZN+xzzo3neT/rEIoj/2HU+4
 vN+t6R15o1t/qsNAiEN8p3MHRO5f5wzmDMq/e9X2l6o8zYGexkEVytjuWWc/HsSUHCvB
 GEQdlUkmL5hP9Gvcct+x7aIgPCavEh7rwbA/RJqUjMfC1oQTFMoQNIMMJ3wdRzPziBGE
 PJZ+/9X0NpvkIrcdh6qNXucvQ1NVcFRjhZ+5CKa6qhf1f/7JwXTnsT4qEs1TtzL3wZDY
 YcYrFkN4snS4iCZMKyh5Yy/ku0R5GBC8+gcuNwl2j8N0VvQY5Ermn30HU/7LeG37GN/v
 4DFQ==
X-Gm-Message-State: APjAAAWAFLrCfPS/4Oe6X+XzsIXeY6c2kSjwI9xCrFjHMvuI6x8GwogN
 kFRfG5bXmnxXxh8EpL/Iv8IGBM36v2GD5Q==
X-Google-Smtp-Source: APXvYqyXxl7WzBxLKricRy6r138rTVBHsQLtKPx5oW047eP5FOCgNUcCg5iaoNBC6B2WJHr+7HPdDA==
X-Received: by 2002:a7b:cb42:: with SMTP id v2mr4459485wmj.170.1581166717682; 
 Sat, 08 Feb 2020 04:58:37 -0800 (PST)
Received: from localhost.localdomain ([82.3.55.76])
 by smtp.gmail.com with ESMTPSA id p5sm7490534wrt.79.2020.02.08.04.58.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 04:58:37 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 20/20] target/arm: Enable ARMv8.2-UAO in -cpu max
Date: Sat,  8 Feb 2020 12:58:16 +0000
Message-Id: <20200208125816.14954-21-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200208125816.14954-1-richard.henderson@linaro.org>
References: <20200208125816.14954-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/cpu64.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 57fbc5eade..1359564c55 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -676,6 +676,10 @@ static void aarch64_max_initfn(Object *obj)
         t = FIELD_DP64(t, ID_AA64MMFR1, PAN, 2); /* ATS1E1 */
         cpu->isar.id_aa64mmfr1 = t;
 
+        t = cpu->isar.id_aa64mmfr2;
+        t = FIELD_DP64(t, ID_AA64MMFR2, UAO, 1);
+        cpu->isar.id_aa64mmfr2 = t;
+
         /* Replicate the same data to the 32-bit id registers.  */
         u = cpu->isar.id_isar5;
         u = FIELD_DP32(u, ID_ISAR5, AES, 2); /* AES + PMULL */
-- 
2.20.1


