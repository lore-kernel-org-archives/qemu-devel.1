Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0467C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:49:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 824E0206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:49:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uu3mMPxn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 824E0206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59484 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtby-000149-6Q
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49180)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7j-0006uE-02
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7h-0002SE-N6
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:10 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42932)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7h-0002Rp-HH
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:09 -0400
Received: by mail-wr1-x441.google.com with SMTP id n14so20286386wrw.9
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=w9v8i3Z8RpP3GEkRyZK5PY2Ra4/gXWlier/tTCtR2T0=;
 b=uu3mMPxnTsZkR066RpXGGzyAATRaGZCoNsy5bswUmDUQ18p7+G/h/T/1XD6U7pDbH9
 HKfp1HQx/56U00GWWh8BdVx2L5zSuJ7HynrD0/geTmsoAKWpzIoOjDhJH4/Ws72EAQVV
 rObpKPgnqmEInsrRy+B60k7+pRQODWZ8WYVlH2FEaMQ/e4yWNlbmK92TQZNj6G1fazHc
 ZPm4WQzRI5uKkytYpgJsBTKedj7wFWgERhaqDCinEf+Zhkf99/BcSkeQ6Xri9axIPulL
 sW+UQhinO9uIOTwS0oR1enCeos3A8nQfUH1cxSqscjAoaynTpCXPGQ3EUQnkSZAAKAF2
 Eb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=w9v8i3Z8RpP3GEkRyZK5PY2Ra4/gXWlier/tTCtR2T0=;
 b=LKYysoyi0TTbP56sdfcy6B6OL31AbukjK73LKffR6XpA0ilI1NypTrCb4xeAt4Unsr
 DAto/0D8ZRsA+VkymMwvtsZar1tCuCDXz6FPKZy5OtFkLai1ftljZaT3ATtB/qtkdL1A
 ZJvEJ378fIymV6ySkvSlzPdEN5+5l8h/idcpq2ox15XDqBhLuii4CJch/Y6pcklRJEjI
 YQtskr/lKQ2r0yN/LrvqobbSAk57lYljwvvP9+BhZmoRUOPvMXwbH7saTnUIsvI2HLZL
 cdRK3KpexXAwDk5nNZeWmhc+gxv2GFn83T/4AYBAxPz+FzNRoEm1Bid7twJCmL0imlEM
 8weA==
X-Gm-Message-State: APjAAAWWCtZMdzuNFHuxYgPIc4iv/SLAjXK6OEhHygWhSKPBN8aEhUGz
 VGLk/k+0PmvKmkyKeaOeKT2w6A==
X-Google-Smtp-Source: APXvYqyU7FJIusM6SbN9sPKdDx0W4GA3Kb31qFguRiTGVUk01/WLc0aQtwogHjE4QJaTosyNxgI+Aw==
X-Received: by 2002:adf:b3d2:: with SMTP id x18mr29381135wrd.264.1570555088581; 
 Tue, 08 Oct 2019 10:18:08 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:18:08 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 20/21] hw/watchdog/cmsdk-apb-watchdog.c: Switch to
 transaction-based ptimer API
Date: Tue,  8 Oct 2019 18:17:39 +0100
Message-Id: <20191008171740.9679-21-peter.maydell@linaro.org>
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

Switch the cmsdk-apb-watchdog code away from bottom-half based
ptimers to the new transaction-based ptimer API.  This just requires
adding begin/commit calls around the various places that modify the
ptimer state, and using the new ptimer_init() function to create the
timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/watchdog/cmsdk-apb-watchdog.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
index e42c3ebd29d..e6f3b93c44e 100644
--- a/hw/watchdog/cmsdk-apb-watchdog.c
+++ b/hw/watchdog/cmsdk-apb-watchdog.c
@@ -24,7 +24,6 @@
 #include "qemu/log.h"
 #include "trace.h"
 #include "qapi/error.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "sysemu/watchdog.h"
 #include "hw/sysbus.h"
@@ -200,8 +199,10 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
          * Reset the load value and the current count, and make sure
          * we're counting.
          */
+        ptimer_transaction_begin(s->timer);
         ptimer_set_limit(s->timer, value, 1);
         ptimer_run(s->timer, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     case A_WDOGCONTROL:
         if (s->is_luminary && 0 != (R_WDOGCONTROL_INTEN_MASK & s->control)) {
@@ -217,7 +218,9 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
         break;
     case A_WDOGINTCLR:
         s->intstatus = 0;
+        ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, ptimer_get_limit(s->timer));
+        ptimer_transaction_commit(s->timer);
         cmsdk_apb_watchdog_update(s);
         break;
     case A_WDOGLOCK:
@@ -299,8 +302,10 @@ static void cmsdk_apb_watchdog_reset(DeviceState *dev)
     s->itop = 0;
     s->resetstatus = 0;
     /* Set the limit and the count */
+    ptimer_transaction_begin(s->timer);
     ptimer_set_limit(s->timer, 0xffffffff, 1);
     ptimer_run(s->timer, 0);
+    ptimer_transaction_commit(s->timer);
 }
 
 static void cmsdk_apb_watchdog_init(Object *obj)
@@ -320,7 +325,6 @@ static void cmsdk_apb_watchdog_init(Object *obj)
 static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
 {
     CMSDKAPBWatchdog *s = CMSDK_APB_WATCHDOG(dev);
-    QEMUBH *bh;
 
     if (s->wdogclk_frq == 0) {
         error_setg(errp,
@@ -328,14 +332,15 @@ static void cmsdk_apb_watchdog_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    bh = qemu_bh_new(cmsdk_apb_watchdog_tick, s);
-    s->timer = ptimer_init_with_bh(bh,
+    s->timer = ptimer_init(cmsdk_apb_watchdog_tick, s,
                            PTIMER_POLICY_WRAP_AFTER_ONE_PERIOD |
                            PTIMER_POLICY_TRIGGER_ONLY_ON_DECREMENT |
                            PTIMER_POLICY_NO_IMMEDIATE_RELOAD |
                            PTIMER_POLICY_NO_COUNTER_ROUND_DOWN);
 
+    ptimer_transaction_begin(s->timer);
     ptimer_set_freq(s->timer, s->wdogclk_frq);
+    ptimer_transaction_commit(s->timer);
 }
 
 static const VMStateDescription cmsdk_apb_watchdog_vmstate = {
-- 
2.20.1


