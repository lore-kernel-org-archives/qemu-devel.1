Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B29E3C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:26:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E3C6217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:26:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R7eTfrLJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E3C6217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtFT-0005cF-2w
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:26:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48896)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7W-0006jD-VL
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7U-0002IF-Pz
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:58 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:36847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7U-0002HK-Ea
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:56 -0400
Received: by mail-wr1-x441.google.com with SMTP id y19so20349395wrd.3
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vTblCPBR00kWBDdHJQrBVtK3r4jiWKjQ3PNlDp1BYo0=;
 b=R7eTfrLJsXKYaoZP/Ro3jCeyCKMIJz02XWUM7n8bl4bP6tExa0XVBl6wGgan+T7hyW
 nCBvggFHbDwbBpWcI19VC7G2ZnKv/M9d+FnJYD6cMunO3UMXLkmw7O3zldCR4dLoZU4q
 PbPmlCQKJ4G7OwIv/BtUWdSdEqwMxXaeI2Z2C65I6R+sabQVLmXJb/P2NGRWfCJK6vzt
 xOKtDDE/d0rEEDm1mNa9+NMfLODpDahoD0EP9DBsEJ2gSFXRyIutjSs4TdGbLjt9Fs+q
 1M+LIZnXrnF9co7ehxMmRVaef9pdJlAPJklbJCQKX3MYCvpuuYgmRS721brE94haTEwm
 h6qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vTblCPBR00kWBDdHJQrBVtK3r4jiWKjQ3PNlDp1BYo0=;
 b=Zi2KMBUBB5BJOeWamkDpIxtzRtByyNVapDKlQ/Z/Q340w7413mlCT7xeTGGHCnNcr+
 qscU4a3OzExqeN56JMJGTpAOqCQP9E7cg0gf8BX+W6D0ANFZjEb7NPxYz3kN57V3aewN
 W+9oItMDzk6/JhD8AqpCk7PlUq9U2CfGhCgsPKJyPdkEZlq7/ihPf4U9xJ4nj6VMamsW
 D8il1YjaILuYgRneVX60+rpn0bMOs8La3bHzPp+GviP4cEsenUBoJ3SPeCwQRrdj9HZ0
 VI9LX60p0P2agyekznLM1lUQn2tQe5jV+jpjpKPkQbvXxikW1vbIUgsYZKHD92QUHbXo
 WnSQ==
X-Gm-Message-State: APjAAAXvWHXsOpLNsOFLerz9daBQFql+oRRBAgsuciWtULg2+dh3Tfxv
 iuIalbo+6LPByu9+PxtpF7CWwRFAeGbR0g==
X-Google-Smtp-Source: APXvYqzKMDEpEVwehuoUPK1bnre3enMh5zFqI+CnNhxSu/cvvChPqARLTgOM4DudF/17xhGUtiHfYw==
X-Received: by 2002:a5d:5381:: with SMTP id d1mr11391673wrv.396.1570555075246; 
 Tue, 08 Oct 2019 10:17:55 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:54 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 09/21] hw/timer/cmsdk-apb-timer.c: Switch to
 transaction-based ptimer API
Date: Tue,  8 Oct 2019 18:17:28 +0100
Message-Id: <20191008171740.9679-10-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Switch the cmsdk-apb-timer code away from bottom-half based ptimers
to the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


