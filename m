Return-Path: <SRS0=2niX=33=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33D4FC04EB5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:53:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC228214AF
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Feb 2020 14:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eozvNqeE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC228214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j050P-0000Mu-34
	for qemu-devel@archiver.kernel.org; Fri, 07 Feb 2020 09:53:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51902)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iG-0001NM-Fs
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j04iF-0003Ti-DU
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:32 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43483)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j04iF-0003TD-6a
 for qemu-devel@nongnu.org; Fri, 07 Feb 2020 09:34:31 -0500
Received: by mail-wr1-x442.google.com with SMTP id z9so2923771wrs.10
 for <qemu-devel@nongnu.org>; Fri, 07 Feb 2020 06:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=/9Ku8hrcSYe5XpVr6coETj3vNOy7+c1M36LS3DdbtZk=;
 b=eozvNqeEnxSNtODmCnIC42ppJH+2OXROIjlbPFPO9IGVoM7tcsNKHXIsnu462ucS1+
 q6JJTL6R52tojQOs4fKB8AefU6UtLv5Gc6jS0dEsxny+8fSVlHtZc+MSVyuj26Zp9WyG
 ElnFMfgXR9TdHpUX03mpF1yQXRiFlWJ328Sv7Z8p6qkI8mn9huKlCiBU5DyYaR2Vb2NX
 ZYNSKBIoKI0iD5H5ebyyk/AzUc4IqYbY6Dc34vx2ezXyCEe6wu3sJaQBewucVu9WG9wC
 5VejNojzi6SnxbXZy+ig7KhZYt1iECkfRpFdsKHtqLAmrtXFJJGi/gtMLbT8HouMM26u
 +2Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=/9Ku8hrcSYe5XpVr6coETj3vNOy7+c1M36LS3DdbtZk=;
 b=bG834QU5yq7jQFlR8a6CejzYN5EyX+Ydq0uVzrb2B8QHkNJkM2Evyg6KLbo7ambLJs
 JwsJAfQEcF7mG4t695hOruwbkBSq7iPzDL2E4ns+RnwiJ/HoPGIOatMEtdB+MVmBp0y4
 FziSwUu2lR42++e2W5/fAq3TE10Pcm+h8LLnZm1t4/uHHCd8AJOeo24gu2XM7mA1jBVE
 +u+ITq/+HsqXsMQLa4jV9WI18VawK/M1NqerRYprDCphQyRP0Mb5ncTRF05Xw1nXvlrT
 tmwS3kQ3zTivNLXfJ/NL8i8QI9MlHEPSbGfuCVOsK82AM465KQfhPiDVXEjoAE/N+n0B
 liDQ==
X-Gm-Message-State: APjAAAUCY06ZBz02fR5ZxnKURFX3ZO+mRHBhiW/uhFfwYtXzpwCeI5Hv
 NZwF6tqrd3SRbzG+b4I9Gnc8q5cFyxA=
X-Google-Smtp-Source: APXvYqzyJCrMcFzlNURQLrOda+KSeEMD9qRKZYqERTVIAvxyJrbA3umBvAxfyVP48sy5lTPe/aLAMw==
X-Received: by 2002:adf:cd91:: with SMTP id q17mr5095840wrj.306.1581086070031; 
 Fri, 07 Feb 2020 06:34:30 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w1sm3796430wro.72.2020.02.07.06.34.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Feb 2020 06:34:29 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 41/48] target/arm: Use bool for unmasked in arm_excp_unmasked
Date: Fri,  7 Feb 2020 14:33:36 +0000
Message-Id: <20200207143343.30322-42-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200207143343.30322-1-peter.maydell@linaro.org>
References: <20200207143343.30322-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Richard Henderson <richard.henderson@linaro.org>

The value computed is fully boolean; using int8_t is odd.

Tested-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200206105448.4726-41-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index fcee0a2dd45..4ffc09909db 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -417,7 +417,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
 {
     CPUARMState *env = cs->env_ptr;
     bool pstate_unmasked;
-    int8_t unmasked = 0;
+    bool unmasked = false;
 
     /*
      * Don't take exceptions if they target a lower EL.
@@ -468,7 +468,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
              * don't affect the masking logic, only the interrupt routing.
              */
             if (target_el == 3 || !secure) {
-                unmasked = 1;
+                unmasked = true;
             }
         } else {
             /*
@@ -514,7 +514,7 @@ static inline bool arm_excp_unmasked(CPUState *cs, unsigned int excp_idx,
             }
 
             if ((scr || hcr) && !secure) {
-                unmasked = 1;
+                unmasked = true;
             }
         }
     }
-- 
2.20.1


