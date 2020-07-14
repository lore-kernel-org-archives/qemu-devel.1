Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BB9FC433E5
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:57:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240BC21897
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 09:57:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zbfJKwAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240BC21897
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvHgb-0003GA-CE
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 05:57:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcR-0003Sp-2S
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:59 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333]:36573)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1jvHcP-0003xF-D6
 for qemu-devel@nongnu.org; Tue, 14 Jul 2020 05:52:58 -0400
Received: by mail-wm1-x333.google.com with SMTP id 17so4414286wmo.1
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2020 02:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xbQaeg14fVG/x3mzQ+QmQQFcjpCesKxKE93ltxY94OQ=;
 b=zbfJKwAZy7C/AyGBtKFAgR7zFjWhZuw1Ifpa79cqZ5Yh1BfgYtmIZRLzz5U5GJcDKg
 1X2IWywH1TAenMff2berAcvsTIhWrCqfU0o8NHe062xa2nBXwE+nZRmEn/a9W0xfdbcO
 uhjsJLBcSpZGcJy8g2cQN0CYqhKsxTdYpto4penjQbXvhWa0GlOcgkBvPfaF4ZeV9DTf
 a5VDn4oXK4Wrcw+rUHjHh7+l8aBiOBfisNboGQJNUl2sNsqo3xhwVgoOB8Ut+wSPGT3p
 3ca/oyZ1cdO4yyt926LtYaHy37k+84PN9BGGX1mqtXDN+wOI4vHoAQQqw4nb50cYsFpo
 RzCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xbQaeg14fVG/x3mzQ+QmQQFcjpCesKxKE93ltxY94OQ=;
 b=L/ufIY/ZQDUnubu/BVbQXGSLvgTl2/Ovknz8VfEHPhcsY+icnQv/wwfAl0Ddp7gSy8
 xYfrCzF3v45nNPRUOztCjOAmkG/jpVCO7BxdZuHt0mDVkXKsxOe2GeYeshGQG+zHtEwG
 sf0j+CRhknoFwlamTeEs6kcBsSN9SrwQRu4s1p+VE34vJxGHsZyJrY02WnkLwVhYDNso
 sGP5jYEQTevbFQbuMHM8sPMnJzzCZfvqINcdAkX49BDBgZ+zFQEVl4uluu7NRxPtC+QA
 TgSwCY5Eb3v22qjIFyo954bIlTVTF0tCjsSekW5KtZ7UhKDvOw45kdsRPQUxHx+yJzQv
 3ITA==
X-Gm-Message-State: AOAM532Pjb+ocsFWsCsqS4s1HWHKzUyUJkpLV2oC+uRBj5B2beKRVLBb
 gGyNXGs+kYIwXefkhIXZoP5hUA==
X-Google-Smtp-Source: ABdhPJygdqVFvNXJK+x8/M43P07loI6yFtA6G2jq5Cd6n0jc/4AdjPfiqVd8zJjAsFjrE9wFZMWbvw==
X-Received: by 2002:a1c:9a81:: with SMTP id c123mr3341710wme.46.1594720376035; 
 Tue, 14 Jul 2020 02:52:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id t2sm3561587wma.43.2020.07.14.02.52.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jul 2020 02:52:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id D137B1FF92;
 Tue, 14 Jul 2020 10:52:47 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 6/9] fpu/softfloat: fix up float16 nan recognition
Date: Tue, 14 Jul 2020 10:52:44 +0100
Message-Id: <20200714095247.19573-7-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200714095247.19573-1-alex.bennee@linaro.org>
References: <20200714095247.19573-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x333.google.com
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: LIU Zhiwei <zhiwei_liu@c-sky.com>

Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-Id: <20200712234521.3972-2-zhiwei_liu@c-sky.com>
Message-Id: <20200713200415.26214-5-alex.bennee@linaro.org>

diff --git a/fpu/softfloat-specialize.inc.c b/fpu/softfloat-specialize.inc.c
index 44f5b661f8..034d18199c 100644
--- a/fpu/softfloat-specialize.inc.c
+++ b/fpu/softfloat-specialize.inc.c
@@ -254,7 +254,7 @@ bool float16_is_quiet_nan(float16 a_, float_status *status)
     if (snan_bit_is_one(status)) {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
     } else {
-        return ((a & ~0x8000) >= 0x7C80);
+        return ((a >> 9) & 0x3F) == 0x3F;
     }
 #endif
 }
@@ -271,7 +271,7 @@ bool float16_is_signaling_nan(float16 a_, float_status *status)
 #else
     uint16_t a = float16_val(a_);
     if (snan_bit_is_one(status)) {
-        return ((a & ~0x8000) >= 0x7C80);
+        return ((a >> 9) & 0x3F) == 0x3F;
     } else {
         return (((a >> 9) & 0x3F) == 0x3E) && (a & 0x1FF);
     }
-- 
2.20.1


