Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF80BC10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2C0121721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:39:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vVqr5RLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A2C0121721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtSc-00015V-06
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:39:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49131)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7g-0006r6-TE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7f-0002QZ-AR
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:08 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:33125)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7f-0002Pv-47
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:07 -0400
Received: by mail-wr1-x442.google.com with SMTP id b9so20372061wrs.0
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6nsvqi4Uzwusg0ywFGM1w0nIdrA70CDt5J8J4ZUSnF0=;
 b=vVqr5RLRSOcHUcGvlEnyp75DhJaCjBVVrtKHAyxmr3kyJ3CZNl5IdcAlpSmaTvlEkT
 baHySrNONEkgAS8XSE5OwCtw5ALHRqL7PfmO7SfwI0F0pPaYn8wzzxCzQk+IvQDsGO+Y
 ODpW5FMMrJHxXgvFgZSA6x0Ee2Ixq6/5y6a3IhbDiYwwCkIDG7MKDV1as4OabbPBW4wS
 j6rF8R8ipXjqh6Y9vnEh6Uu5g0Jp3OO8P07fv+iqGIrwIPYPwZaJJSt8oyo4S1Ix2kaX
 5wdZD0dE2D4I5ZoE50sxFECjDMRcJ6EGfjD9DMMp4e1mG+rHuCe9MPim8ersxkZvqjY+
 Gm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6nsvqi4Uzwusg0ywFGM1w0nIdrA70CDt5J8J4ZUSnF0=;
 b=hjKs730xXgb1ntyEmIGXCDNl6k3oexZBEmBz/+93DXXQGzfVT3DbQWDujQe+YdkUX5
 raf9foVDOtUtHeC6IfDuuUxz+Wzn97NFPLqIOHIh3FwfqLf3Vx7xpdrPW0FNDqViGR3y
 Q+x8wZj+tfuLuhELfV3sTuiV3rFMLldS4YWHOaATDBKzOeermOV98wkfhf5fIOXPiUJb
 1xOhE1lYuVqK3uoTtknEm/AJeRW2ViDGX486B0HxRFvSs8HffvWZHluuJOri+mmGmgvu
 GUzjBhkm3wwjoZIBHVMEOhnCPaqn5EtgYXGyGKXw8h+Xi/wKCz/LA/NuElCR82ejrdpm
 rvqA==
X-Gm-Message-State: APjAAAUPvDZdFrcU4or8Q/Cr2FmEm8oz8zak0ak7GcanDEHnNYLNWyMP
 9y5lcZJ4tPp5VH5xvov/3dCJTA==
X-Google-Smtp-Source: APXvYqyyub6rfJwPu8Dp+4ayE7S51tuHKmAISNBQBk+R9mNsKXulW3lYNoBJNs60Mk52IYVog608JQ==
X-Received: by 2002:a5d:4090:: with SMTP id o16mr10300916wrp.172.1570555086158; 
 Tue, 08 Oct 2019 10:18:06 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.18.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:18:05 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 18/21] hw/timer/imx_gpt.c: Switch to transaction-based
 ptimer API
Date: Tue,  8 Oct 2019 18:17:37 +0100
Message-Id: <20191008171740.9679-19-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the imx_epit.c code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/imx_gpt.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/hw/timer/imx_gpt.c b/hw/timer/imx_gpt.c
index c535d191292..5c0d9a269ce 100644
--- a/hw/timer/imx_gpt.c
+++ b/hw/timer/imx_gpt.c
@@ -16,7 +16,6 @@
 #include "hw/irq.h"
 #include "hw/timer/imx_gpt.h"
 #include "migration/vmstate.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 
@@ -127,6 +126,7 @@ static const IMXClk imx7_gpt_clocks[] = {
     CLK_NONE,      /* 111 not defined */
 };
 
+/* Must be called from within ptimer_transaction_begin/commit block */
 static void imx_gpt_set_freq(IMXGPTState *s)
 {
     uint32_t clksrc = extract32(s->cr, GPT_CR_CLKSRC_SHIFT, 3);
@@ -167,6 +167,7 @@ static inline uint32_t imx_gpt_find_limit(uint32_t count, uint32_t reg,
     return timeout;
 }
 
+/* Must be called from within ptimer_transaction_begin/commit block */
 static void imx_gpt_compute_next_timeout(IMXGPTState *s, bool event)
 {
     uint32_t timeout = GPT_TIMER_MAX;
@@ -313,6 +314,7 @@ static uint64_t imx_gpt_read(void *opaque, hwaddr offset, unsigned size)
 
 static void imx_gpt_reset_common(IMXGPTState *s, bool is_soft_reset)
 {
+    ptimer_transaction_begin(s->timer);
     /* stop timer */
     ptimer_stop(s->timer);
 
@@ -350,6 +352,7 @@ static void imx_gpt_reset_common(IMXGPTState *s, bool is_soft_reset)
     if (s->freq && (s->cr & GPT_CR_EN)) {
         ptimer_run(s->timer, 1);
     }
+    ptimer_transaction_commit(s->timer);
 }
 
 static void imx_gpt_soft_reset(DeviceState *dev)
@@ -382,6 +385,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
             imx_gpt_soft_reset(DEVICE(s));
         } else {
             /* set our freq, as the source might have changed */
+            ptimer_transaction_begin(s->timer);
             imx_gpt_set_freq(s);
 
             if ((oldreg ^ s->cr) & GPT_CR_EN) {
@@ -397,12 +401,15 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
                     ptimer_stop(s->timer);
                 }
             }
+            ptimer_transaction_commit(s->timer);
         }
         break;
 
     case 1: /* Prescaler */
         s->pr = value & 0xfff;
+        ptimer_transaction_begin(s->timer);
         imx_gpt_set_freq(s);
+        ptimer_transaction_commit(s->timer);
         break;
 
     case 2: /* SR */
@@ -414,13 +421,16 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
         s->ir = value & 0x3f;
         imx_gpt_update_int(s);
 
+        ptimer_transaction_begin(s->timer);
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
     case 4: /* OCR1 -- output compare register */
         s->ocr1 = value;
 
+        ptimer_transaction_begin(s->timer);
         /* In non-freerun mode, reset count when this register is written */
         if (!(s->cr & GPT_CR_FRR)) {
             s->next_timeout = GPT_TIMER_MAX;
@@ -429,6 +439,7 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
 
         /* compute the new timeout */
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
@@ -436,7 +447,9 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
         s->ocr2 = value;
 
         /* compute the new timeout */
+        ptimer_transaction_begin(s->timer);
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
@@ -444,7 +457,9 @@ static void imx_gpt_write(void *opaque, hwaddr offset, uint64_t value,
         s->ocr3 = value;
 
         /* compute the new timeout */
+        ptimer_transaction_begin(s->timer);
         imx_gpt_compute_next_timeout(s, false);
+        ptimer_transaction_commit(s->timer);
 
         break;
 
@@ -484,15 +499,13 @@ static void imx_gpt_realize(DeviceState *dev, Error **errp)
 {
     IMXGPTState *s = IMX_GPT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    QEMUBH *bh;
 
     sysbus_init_irq(sbd, &s->irq);
     memory_region_init_io(&s->iomem, OBJECT(s), &imx_gpt_ops, s, TYPE_IMX_GPT,
                           0x00001000);
     sysbus_init_mmio(sbd, &s->iomem);
 
-    bh = qemu_bh_new(imx_gpt_timeout, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(imx_gpt_timeout, s, PTIMER_POLICY_DEFAULT);
 }
 
 static void imx_gpt_class_init(ObjectClass *klass, void *data)
-- 
2.20.1


