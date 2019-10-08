Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A559C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA0CC2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Sw+8Rwp+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA0CC2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59310 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtRS-0000Ek-GM
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49065)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7e-0006oP-IW
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7d-0002Oi-1s
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:06 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:36850)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7c-0002N1-OF
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:04 -0400
Received: by mail-wr1-x443.google.com with SMTP id y19so20349777wrd.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=PYOd0vFS/gYS2A8DyTJAHBtn1FfEmdBSCZ1qScpfiwA=;
 b=Sw+8Rwp+JVvkoGA81kds513BxAOtOGzaAYuqHSmvsuztgpfgmpNCOn0rsBjvQel+Ha
 QfDWKdx6SgqNzO2TRtPGXIdSAp3RmtGda+Q9zK5Nny6b6YzE2ELsQ2WZyVEh92yz6Qso
 whK8ZlzCIhKJX9I+mrynZ9/0eoMcm3zFcNq4hYmxXTbYCa5GMSVZlbj8hl7ZeLtQC+Nl
 WybL2bsTPMCrYVDoz8buGXfd1qgo3Aw8nJTDha5T7hJVlquEC/JyOpwGBOB1Kq4mMDZf
 q9Bhc7Ad9v85DCyZqjtokVwZZF2EQqcv0D91GLjkzcsT9BlGZb7gblDTSkVcxpznQKrj
 QVTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=PYOd0vFS/gYS2A8DyTJAHBtn1FfEmdBSCZ1qScpfiwA=;
 b=BcYzr5XhxkYzTAlv/be9ozcUN1XcxzwzPXfCPiOT71pRSoMK/N5Hi5/SJfA7pnnnC/
 3BESZSc6VsoS4C4peIo3EI5UWu1rYUyZlaR9Yjr8hwDEdg4vRNAgxSYYdySis2aRtL4+
 ByhQXy1vjDWv/DfvGwGNAyXksKmKwVFLpJBT51crp2+4MLwpF0fOcmicoOq5VXEsNyTa
 mK1Omn8cOCfwz8vPW7gjSN0Nz8yeL1XjvWHepmMsICykEH0gO/n/kJf/GGCsNtsRpkRN
 zvgirO6vac6zmEw1bXyNW+zE9QvttPxw4mhWfOOJyl4yCrxUivKnSGgFMJaXF8VVeKpQ
 RimQ==
X-Gm-Message-State: APjAAAWnJEoKjKJzbfeJ0Itz1AjobWn7wYcri+WSK+/3tBrNhU43kIRb
 oeG4kerYe+Hq6qZPqbq9cIdLFg==
X-Google-Smtp-Source: APXvYqwW/OSAYdKmjJ9sWUoSRGtcCnrSipKaUhWEPl66SaEj0TS/25mfQVgMDb9+TqB41naucRKldQ==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr3844941wrq.165.1570555082655; 
 Tue, 08 Oct 2019 10:18:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.18.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:18:02 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 15/21] hw/timer/exynos4210_rtc.c: Switch 1Hz ptimer to
 transaction-based API
Date: Tue,  8 Oct 2019 18:17:34 +0100
Message-Id: <20191008171740.9679-16-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the exynos41210_rtc 1Hz ptimer over to the transaction-based
API. (We will switch the other ptimer used by this device in a
separate commit.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_rtc.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/hw/timer/exynos4210_rtc.c b/hw/timer/exynos4210_rtc.c
index d5d7c91fb15..b7ae99e9aa7 100644
--- a/hw/timer/exynos4210_rtc.c
+++ b/hw/timer/exynos4210_rtc.c
@@ -401,6 +401,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
         }
         break;
     case RTCCON:
+        ptimer_transaction_begin(s->ptimer_1Hz);
         if (value & RTC_ENABLE) {
             exynos4210_rtc_update_freq(s, value);
         }
@@ -430,6 +431,7 @@ static void exynos4210_rtc_write(void *opaque, hwaddr offset,
                 ptimer_stop(s->ptimer);
             }
         }
+        ptimer_transaction_commit(s->ptimer_1Hz);
         s->reg_rtccon = value;
         break;
     case TICCNT:
@@ -539,7 +541,9 @@ static void exynos4210_rtc_reset(DeviceState *d)
 
     exynos4210_rtc_update_freq(s, s->reg_rtccon);
     ptimer_stop(s->ptimer);
+    ptimer_transaction_begin(s->ptimer_1Hz);
     ptimer_stop(s->ptimer_1Hz);
+    ptimer_transaction_commit(s->ptimer_1Hz);
 }
 
 static const MemoryRegionOps exynos4210_rtc_ops = {
@@ -562,9 +566,11 @@ static void exynos4210_rtc_init(Object *obj)
     ptimer_set_freq(s->ptimer, RTC_BASE_FREQ);
     exynos4210_rtc_update_freq(s, 0);
 
-    bh = qemu_bh_new(exynos4210_rtc_1Hz_tick, s);
-    s->ptimer_1Hz = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer_1Hz = ptimer_init(exynos4210_rtc_1Hz_tick,
+                                s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->ptimer_1Hz);
     ptimer_set_freq(s->ptimer_1Hz, RTC_BASE_FREQ);
+    ptimer_transaction_commit(s->ptimer_1Hz);
 
     sysbus_init_irq(dev, &s->alm_irq);
     sysbus_init_irq(dev, &s->tick_irq);
-- 
2.20.1


