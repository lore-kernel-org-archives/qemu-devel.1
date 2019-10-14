Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 272C9C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:47:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E573920854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:47:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GCIDQ9bU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E573920854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3VZ-0008DK-JH
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:47:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36983)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q6-0004G7-K6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q5-0007TF-B3
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:54 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:33026)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2q5-0007SR-4n
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:53 -0400
Received: by mail-wr1-x443.google.com with SMTP id b9so20411748wrs.0
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=eX98tShlaGosGwXWI3AYl+CKzaAZcJwin0vuso2eEqw=;
 b=GCIDQ9bUDATqUyy8JB8e0XHbqhoyjCiPpxZvB+J1lG26vJMvC0q/YJ83P2ftVkJ8Nu
 cfHjwQeUr/U+N5JMVd7YxctCEiLamGmYpJHkaTkeKU5LOSKHjCOXVNarvu/qCneUOF/1
 OnKDENRx1yBzLIZ2MF+t05kps3yp95VYErECktx+ZCD7AzT5lwwWP7+HKyrp2jz9Aeqg
 v/IRn2Ll5Yj65BQDDYBKWaz8YI9mMIflr5akIY6l4HhvM1IjT8yfi5kMagpjDGHnfd2m
 PGwqcrQqvb0g/qMmXVO8WwYARlkuiM3Qv7scF5fESF5KdG91Ff1FWgbaBaA6lcIOwcK5
 0diw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eX98tShlaGosGwXWI3AYl+CKzaAZcJwin0vuso2eEqw=;
 b=lyPGnj0nGJTFz4SflAM+Ly91kW57qcatTSznVrsp0fjSPJa/NGPwkwERgxLt2I4r34
 GFqsSEyZQIC3I03OkcVF7fMvI8IGNBUOHTFvpr6VPqvWAAMn0n/6i1ht8zM4EzeTECXE
 dBXMFP7MSY+QqIz/IL1xD92ncn/XlhWzjM3q2G4yX9+FVY6XO9f8Q6JeBOnKV3fV83zo
 RlYgbIeMlUuEP5CifaVNhPFB7UvbCWX8q/xMelTZ/3eXpRlH2ow1iB4fguCkni/3oSlP
 4vL9VvuUq6DXs4vgf4iwO6B8xYTlUrKDyGNWAZwPjujbRGrtlDcyCIGqYb5I5pFINGts
 jUcA==
X-Gm-Message-State: APjAAAWnDQ6GawRQmg5k7QbyzEHE41tocGBZoaavsQcnqmzNUsmUl1/p
 YOG64B1Yhpa4E5MSM0Du331IDdxErXc6WQ==
X-Google-Smtp-Source: APXvYqz5jAxy2M9b3C/16TKvWnMFPMkQXRgGCgA7LmnoX4FdKh2IKCleTqT4Dw8oAeU24xiDsGjyAw==
X-Received: by 2002:adf:e688:: with SMTP id r8mr28619127wrm.342.1571069091899; 
 Mon, 14 Oct 2019 09:04:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 24/68] hw/net/lan9118.c: Switch to transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:20 +0100
Message-Id: <20191014160404.19553-25-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the cmsdk-apb-watchdog code away from bottom-half based
ptimers to the new transaction-based ptimer API.  This just requires
adding begin/commit calls around the various places that modify the
ptimer state, and using the new ptimer_init() function to create the
timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-22-peter.maydell@linaro.org
---
 hw/net/lan9118.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/lan9118.c b/hw/net/lan9118.c
index 0ea51433dca..ed551f2178b 100644
--- a/hw/net/lan9118.c
+++ b/hw/net/lan9118.c
@@ -21,7 +21,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 /* For crc32 */
 #include <zlib.h>
@@ -450,8 +449,10 @@ static void lan9118_reset(DeviceState *d)
     s->e2p_data = 0;
     s->free_timer_start = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) / 40;
 
+    ptimer_transaction_begin(s->timer);
     ptimer_stop(s->timer);
     ptimer_set_count(s->timer, 0xffff);
+    ptimer_transaction_commit(s->timer);
     s->gpt_cfg = 0xffff;
 
     s->mac_cr = MAC_CR_PRMS;
@@ -1100,6 +1101,7 @@ static void lan9118_writel(void *opaque, hwaddr offset,
         break;
     case CSR_GPT_CFG:
         if ((s->gpt_cfg ^ val) & GPT_TIMER_EN) {
+            ptimer_transaction_begin(s->timer);
             if (val & GPT_TIMER_EN) {
                 ptimer_set_count(s->timer, val & 0xffff);
                 ptimer_run(s->timer, 0);
@@ -1107,6 +1109,7 @@ static void lan9118_writel(void *opaque, hwaddr offset,
                 ptimer_stop(s->timer);
                 ptimer_set_count(s->timer, 0xffff);
             }
+            ptimer_transaction_commit(s->timer);
         }
         s->gpt_cfg = val & (GPT_TIMER_EN | 0xffff);
         break;
@@ -1328,7 +1331,6 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
 {
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
     lan9118_state *s = LAN9118(dev);
-    QEMUBH *bh;
     int i;
     const MemoryRegionOps *mem_ops =
             s->mode_16bit ? &lan9118_16bit_mem_ops : &lan9118_mem_ops;
@@ -1349,10 +1351,11 @@ static void lan9118_realize(DeviceState *dev, Error **errp)
     s->pmt_ctrl = 1;
     s->txp = &s->tx_packet;
 
-    bh = qemu_bh_new(lan9118_tick, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(lan9118_tick, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->timer);
     ptimer_set_freq(s->timer, 10000);
     ptimer_set_limit(s->timer, 0xffff, 1);
+    ptimer_transaction_commit(s->timer);
 }
 
 static Property lan9118_properties[] = {
-- 
2.20.1


