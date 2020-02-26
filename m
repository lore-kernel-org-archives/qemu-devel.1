Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 687DBC4BA0B
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:46:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3729821D7E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 07:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g4LOowcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3729821D7E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39424 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6rP4-0004F7-99
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 02:46:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIM-0000xK-9X
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1j6rIL-0002s9-6K
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:50 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d]:51840)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1j6rIL-0002qP-0j
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 02:39:49 -0500
Received: by mail-wm1-x32d.google.com with SMTP id t23so1811752wmi.1
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 23:39:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YUICng/XsgVIxJigIpZDRDnzqFeTq4FmjK3Sam+uM00=;
 b=g4LOowcF3+yx5kanbykngFbGMizZQv+IxYHK7QsVofWqlr/OqRvyNVSBKmE5CYb6dp
 tuXHpollutYhQ4u1YwsGpKXj4mQ9dVYAWyVm7q1CNmkHdShhY/YUaeI/tw5c/YSPxYb3
 AQtxXK//w72b16MJfoaw56PWv785lmBCEyxpDmLvEX+veMsC1K9gRGbRjWnpZ1PrGq+1
 F04Zt+vlg0O/6zEwsBQrg3HQwFWf8sbZPyua4cyopxiUKxu790Mmc8Hv8aPRIDmavl/c
 t0gm8+nixYyZGqR0Y6GCCid1OhPf5e/pHfJN6u1sPfXBN6E5ZYRjfXrFXO9Q19EYbyJY
 ACGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YUICng/XsgVIxJigIpZDRDnzqFeTq4FmjK3Sam+uM00=;
 b=RIbV+gJxdm5nU64kIeGKSqWVNTYh0JWiWIFeztyIW12ju6DCN8cj/y0B48+LomLqdo
 MnE+6akeiWLqaKBTtLWS1Nxwz0f+8OXnQhM3DKus2trW0Pu/rZVHZGzwDLTMe70Byq4S
 YuOE4X74G28sSkf7JP1JRxe2afXfqVCZuVnuW0R52OmfD48xDJ26DwCEaQraOADkzp4F
 pJulthnq3OzoZUr6k2VvlWq4HtbbCDbN8yO6WoEX78xE1mZMI3LlgYTkoGaQJHa+2rMf
 dIbmeNwhEuWRRYKuwdoS8RhkhzJZZAjOVFfKKWY2cucyK8IV17Ffn1NLyLYP3vdJgUEA
 HevA==
X-Gm-Message-State: APjAAAVAhdFnkn8XnerFtETfV1XYx+mQF8Bh58yavTsDH9pVfpefB+kP
 BI6zxWJvdDf0fo1CE4sF0IQ33Q==
X-Google-Smtp-Source: APXvYqxCnCwN1J/qxo1BNlyisaPcjN7umxtB8IM3P997deXLrDp8X2eOdfVOsUfCoi3Iwy+Iz3U4ng==
X-Received: by 2002:a1c:4c10:: with SMTP id z16mr3770927wmf.136.1582702787983; 
 Tue, 25 Feb 2020 23:39:47 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m3sm2048284wrs.53.2020.02.25.23.39.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Feb 2020 23:39:41 -0800 (PST)
Received: from zen.home.arpa (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3A6FA1FF9B;
 Wed, 26 Feb 2020 07:39:30 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: peter.maydell@linaro.org
Subject: [PULL 11/19] plugins/core: add missing break in cb_to_tcg_flags
Date: Wed, 26 Feb 2020 07:39:21 +0000
Message-Id: <20200226073929.28237-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200226073929.28237-1-alex.bennee@linaro.org>
References: <20200226073929.28237-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32d
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
Cc: qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 qemu-devel@nongnu.org, Robert Henry <robhenry@microsoft.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Emilio G. Cota" <cota@braap.org>

Fixes: 54cb65d8588
Reported-by: Robert Henry <robhenry@microsoft.com>
Signed-off-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200105072940.32204-1-cota@braap.org>
Cc: qemu-stable@nongnu.org
Message-Id: <20200225124710.14152-12-alex.bennee@linaro.org>

diff --git a/plugins/core.c b/plugins/core.c
index 9e1b9e7a915..ed863011baf 100644
--- a/plugins/core.c
+++ b/plugins/core.c
@@ -286,6 +286,7 @@ static inline uint32_t cb_to_tcg_flags(enum qemu_plugin_cb_flags flags)
     switch (flags) {
     case QEMU_PLUGIN_CB_RW_REGS:
         ret = 0;
+        break;
     case QEMU_PLUGIN_CB_R_REGS:
         ret = TCG_CALL_NO_WG;
         break;
-- 
2.20.1


