Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0539CECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:29:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C5A062133F
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:29:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G3mKbYuw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C5A062133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3De-0001tv-Fd
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:29:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36773)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pp-0003mw-2C
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pn-00078E-R6
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:36 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pn-00077a-KP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:35 -0400
Received: by mail-wr1-x443.google.com with SMTP id j18so20368209wrq.10
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=9CK3JV7Hq6bflgcOK+hFl60lUrNCbR1Yaa8PaHX9yvY=;
 b=G3mKbYuwmIGqEsA4pbMctEo3OJ0im8pSTs05zGJ5UaTGUCsceJvdYPIO+seCAiLLbB
 rqDe4XUbM2PNH9lhwek28kHY0dITE1evhM/HohfqoMzKs6xJAvsgGrJJNj5RxvlG6Y84
 8pGeGNKTQRUarC961l/RXLWPLUsq59SRFFyIX+8ICQnY6vVwgZNMB45J10bwt/0rZx0A
 vq26TMYOnObstdL/WH1/uv7xaSTBW4zRScDkQI5Em0SCAQYPIcvEnddlEiy1JSoNziwz
 NwFx9b4+QSy1ju8P2f1P9NBGT07FW0HoJEvsvTcmAqty9JeLaA9LjGC4toVYD4ahe1wJ
 AVeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9CK3JV7Hq6bflgcOK+hFl60lUrNCbR1Yaa8PaHX9yvY=;
 b=rSbLnx5PhV8FmS4Ew3EE6Y/wZmk27ZlyKZ5Ao0wjej74/8jESL6LCJG/a8wpe2MPSd
 CRU7H605TyvIFkYXBJOjVtJ4/y73LxKkvWdvDz0TaJrnu+DujukQ1SyBMyCbOYo2R5OR
 PFQkzHpCeUqqs1aFj9/nR8FTrdU/0hJO1B1SiTZS659XJiFMM2HhLO/Segb0ha33deBR
 xx3qUkd3vpVzpNjuMRnXKBUq79IGIc4n5ZTRlT9NYt9ME4VczE9YNGZtYNoFURKzcif8
 B/5+F9uC+UqIAjLEDcD/sJoxKSA+u4rPigz80Z1wu4kKhoj0/XQqrp9AX/aaMUYT8IxY
 VNJQ==
X-Gm-Message-State: APjAAAWy9N/GsqgOWGK/9NshGSaemYH3TohIE8ai6Vd74X6TAq4P31bm
 nFvdPgZODXq3bGGDSEgAYNGZNIvPuRLKOg==
X-Google-Smtp-Source: APXvYqx4G9+iAUXeEQLNtPOVaAwpRpn9+R1/v0t5GPXD+O71Cr3DQ1YBKleP5XzcFen9Sje2XlBjDQ==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr22579504wrv.8.1571069074094; 
 Mon, 14 Oct 2019 09:04:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:32 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/68] hw/timer/cmsdk-apb-timer.c: Switch to transaction-based
 ptimer API
Date: Mon, 14 Oct 2019 17:03:08 +0100
Message-Id: <20191014160404.19553-13-peter.maydell@linaro.org>
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

Switch the cmsdk-apb-timer code away from bottom-half based ptimers
to the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-10-peter.maydell@linaro.org
---
 hw/timer/cmsdk-apb-timer.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/hw/timer/cmsdk-apb-timer.c b/hw/timer/cmsdk-apb-timer.c
index c9ce9770cef..40728e85e20 100644
--- a/hw/timer/cmsdk-apb-timer.c
+++ b/hw/timer/cmsdk-apb-timer.c
@@ -29,7 +29,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 #include "trace.h"
@@ -121,14 +120,17 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
                           "CMSDK APB timer: EXTIN input not supported\n");
         }
         s->ctrl = value & 0xf;
+        ptimer_transaction_begin(s->timer);
         if (s->ctrl & R_CTRL_EN_MASK) {
             ptimer_run(s->timer, ptimer_get_limit(s->timer) == 0);
         } else {
             ptimer_stop(s->timer);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case A_RELOAD:
         /* Writing to reload also sets the current timer value */
+        ptimer_transaction_begin(s->timer);
         if (!value) {
             ptimer_stop(s->timer);
         }
@@ -140,8 +142,10 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
              */
             ptimer_run(s->timer, 0);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case A_VALUE:
+        ptimer_transaction_begin(s->timer);
         if (!value && !ptimer_get_limit(s->timer)) {
             ptimer_stop(s->timer);
         }
@@ -149,6 +153,7 @@ static void cmsdk_apb_timer_write(void *opaque, hwaddr offset, uint64_t value,
         if (value && (s->ctrl & R_CTRL_EN_MASK)) {
             ptimer_run(s->timer, ptimer_get_limit(s->timer) == 0);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case A_INTSTATUS:
         /* Just one bit, which is W1C. */
@@ -191,9 +196,11 @@ static void cmsdk_apb_timer_reset(DeviceState *dev)
     trace_cmsdk_apb_timer_reset();
     s->ctrl = 0;
     s->intstatus = 0;
+    ptimer_transaction_begin(s->timer);
     ptimer_stop(s->timer);
     /* Set the limit and the count */
     ptimer_set_limit(s->timer, 0, 1);
+    ptimer_transaction_commit(s->timer);
 }
 
 static void cmsdk_apb_timer_init(Object *obj)
@@ -210,21 +217,21 @@ static void cmsdk_apb_timer_init(Object *obj)
 static void cmsdk_apb_timer_realize(DeviceState *dev, Error **errp)
 {
     CMSDKAPBTIMER *s = CMSDK_APB_TIMER(dev);
-    QEMUBH *bh;
 
     if (s->pclk_frq == 0) {
         error_setg(errp, "CMSDK APB timer: pclk-frq property must be set");
         return;
     }
 
-    bh = qemu_bh_new(cmsdk_apb_timer_tick, s);
-    s->timer = ptimer_init_with_bh(bh,
+    s->timer = ptimer_init(cmsdk_apb_timer_tick, s,
                            PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
                            PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
                            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
+    ptimer_transaction_begin(s->timer);
     ptimer_set_freq(s->timer, s->pclk_frq);
+    ptimer_transaction_commit(s->timer);
 }
 
 static const VMStateDescription cmsdk_apb_timer_vmstate = {
-- 
2.20.1


