Return-Path: <SRS0=BVCf=4W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADBB0C3F2D8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:49:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7BDBD20637
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Mar 2020 16:49:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rmnnodo6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7BDBD20637
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j9tgS-0007Jx-I8
	for qemu-devel@archiver.kernel.org; Thu, 05 Mar 2020 11:49:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59610)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPU-0003za-PW
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j9tPT-0002wj-ON
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:44 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:40435)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j9tPT-0002vy-HP
 for qemu-devel@nongnu.org; Thu, 05 Mar 2020 11:31:43 -0500
Received: by mail-wm1-x32e.google.com with SMTP id e26so6424324wme.5
 for <qemu-devel@nongnu.org>; Thu, 05 Mar 2020 08:31:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=+6Wt2pwTNDCu5XTMFcnjWDpEDWtcbB8BiinZAb1YGOE=;
 b=Rmnnodo6rVibdthmjl55H5P8+W+NaTAwt4/81MJQ+gGOWPKepTW4H0FpQIEYKvsaFc
 WUyifFo00VObdWTtx+WcFB1zyWyhNiLdVQpvB6fPM08MdZo+xnSpGcapLYyT/v9TJYFY
 7of5XJCXj2zWKE/YxrFj+8LOk3iTwwveG01bn4rRk8FhtvlOEM0ro99/1qpmFIxwQifA
 fIblqe//hsEQpB1WqAfV6ImJYBu1PnY4Fc4R0mQPxppNrNA263vOzROpD7/7nV2Ufg20
 Wc1KlVKK2V9GgxtxAL+5CdOJP30CJt53+gH/o5J1B7znS3AQZl9TMcLFfs0MyTrw4oaN
 8BnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+6Wt2pwTNDCu5XTMFcnjWDpEDWtcbB8BiinZAb1YGOE=;
 b=WdVnGPbMKaDgxhawCEHbw1xYw48WkLtusaXJEdrob0Kr3F9kbpQsku6uZBA9apOtHy
 dC/rA797cq57b9hJdG4b3KvM/vHEVEknJ9QgS/WKuNsr+SCPPlcupGGFVz12+DAAqceA
 SZO0ebnaTAbyoB0h/TZutw+5TUBgPnIoPoF9ENwd7VC2ggEgFNQMcG3gtRd8aR5kRQFx
 jPh6LdkOgGYkECtgYWGd9O2j2+1KM7Jag5ugGGUF0pgXaZ1g4Q34SLwKIC23HvKI1RNZ
 lkrxDF3GCTLwwvacKctXp7uFJfzb+tTZl+yKKI9RRHKEALBfRroPkJZ+4s6ffEO/aEvb
 JxrQ==
X-Gm-Message-State: ANhLgQ2pxB9ld3kCbeIH5hYljP2zWZNEqguaskHqFvZhXbAECbRXbqSS
 6xmnITt9/qiFLVEbV8THir7z9Zl4eNxm8w==
X-Google-Smtp-Source: ADFU+vs1t19Utr016N2bRIc1sB627mT0dbfnr/G+Kmy33flvGHtV2INCQCzzjZXFT5xLB/UJTvusQw==
X-Received: by 2002:a05:600c:2255:: with SMTP id
 a21mr6284361wmm.91.1583425902364; 
 Thu, 05 Mar 2020 08:31:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id w22sm10310729wmk.34.2020.03.05.08.31.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Mar 2020 08:31:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 37/37] target/arm: Clean address for DC ZVA
Date: Thu,  5 Mar 2020 16:31:00 +0000
Message-Id: <20200305163100.22912-38-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200305163100.22912-1-peter.maydell@linaro.org>
References: <20200305163100.22912-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

This data access was forgotten when we added support for cleaning
addresses of TBI information.

Fixes: 3a471103ac1823ba
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20200302175829.2183-8-richard.henderson@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/translate-a64.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
index c910a49b4e0..fefe8af7f52 100644
--- a/target/arm/translate-a64.c
+++ b/target/arm/translate-a64.c
@@ -1784,7 +1784,7 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
         return;
     case ARM_CP_DC_ZVA:
         /* Writes clear the aligned block of memory which rt points into. */
-        tcg_rt = cpu_reg(s, rt);
+        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt));
         gen_helper_dc_zva(cpu_env, tcg_rt);
         return;
     default:
-- 
2.20.1


