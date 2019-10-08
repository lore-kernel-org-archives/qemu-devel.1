Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 210E5ECE58C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:25:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E54D7218AC
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:25:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TCDKiM1W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E54D7218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtEY-0004dC-Fr
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:25:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48820)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7T-0006fP-Hs
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7R-0002Fc-5x
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43025)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7Q-0002ER-Qs
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id j18so19527935wrq.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jKb9Rbp8gXPT0bACEbKBu5D4v0cg+tsMxucN4ICfYFw=;
 b=TCDKiM1WzJoK/uWnKEXcIpAJL+L1HRBXg6r2xaCO9DHH1ZI6jwgu7N4cSrLpUM9WjL
 QGayGO5T+uEYCBDBmnanaHTbtwUMUvj0zI3XCwk5LL2RCD8SIUmUxwX6LB6hF6suj7dN
 VeN0yyoruDnREAEJPQrhDm9I2QJMm1T7cCn8ooQ5WrJdo+tsGp2iSXUkbX2E/sLd0bQZ
 HAtXImvtEDj/aeNQAplB3HXugKhnnU3mQh3Vu+maHsBXuya0scq/c8wISi3O+bHy7L6S
 6uxQWppua6ROF7pgf/v8fRhoC7jvdCRMlU4RlJ5NesSUJq0NFcqkWPOpOXl2cWKfl7kY
 DtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jKb9Rbp8gXPT0bACEbKBu5D4v0cg+tsMxucN4ICfYFw=;
 b=leL5P9NVR4BdieSqDHNRb7cwo5L13iYw8I2bD3f11os5pKvQAY8F6bYGpuYAMWqrz8
 3rc6Y7rMSn24aAfLKNSe5QzVjWTDVErPvn1huWIvqRwJRoPSAIhOoR8QhZmLGP9F/DxE
 uSxvemOUx8oCplJgNbQlpqezgEXsdKMG6bVoZM90kpLNHuP5ICBM0abWpaZUME4XAK5m
 iebfAlKWoGZd9A8H6fqPMw0n4WhynjP99NTCiHXnIZ33TQppNJEpXC1z3QlhbzNsGiM0
 rhOyre+5dQxgBNJZhM2WcoL5ZF7/qfI5gTOX2R9MAZieYoJCILbPaV7fasB7D+oLq9Q3
 psmQ==
X-Gm-Message-State: APjAAAVKmfGkLTwYSsPk1F3iXAzP8M3AfsY2YeHLqFrXQv64sD/9tnX4
 sk6o+M8Ed5HeU2JTp/n8PgS/Mw5jvNj2Cw==
X-Google-Smtp-Source: APXvYqxE3Ei06SIYcvafrTXFVmwNL+phMsbf/asXBt06uk8D4Tb3RreH/lfYr7YMc6SwcG1SWtB3ag==
X-Received: by 2002:a5d:49cb:: with SMTP id t11mr25862841wrs.366.1570555071679; 
 Tue, 08 Oct 2019 10:17:51 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:51 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 06/21] hw/timer/allwinner-a10-pit.c: Switch to
 transaction-based ptimer API
Date: Tue,  8 Oct 2019 18:17:25 +0100
Message-Id: <20191008171740.9679-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Switch the allwinner-a10-pit code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/allwinner-a10-pit.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 28d055e42f3..aae880f5b35 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -22,7 +22,6 @@
 #include "hw/timer/allwinner-a10-pit.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 static void a10_pit_update_irq(AwA10PITState *s)
@@ -80,6 +79,7 @@ static uint64_t a10_pit_read(void *opaque, hwaddr offset, unsigned size)
     return 0;
 }
 
+/* Must be called inside a ptimer transaction block for s->timer[index] */
 static void a10_pit_set_freq(AwA10PITState *s, int index)
 {
     uint32_t prescaler, source, source_freq;
@@ -118,6 +118,7 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
         switch (offset & 0x0f) {
         case AW_A10_PIT_TIMER_CONTROL:
             s->control[index] = value;
+            ptimer_transaction_begin(s->timer[index]);
             a10_pit_set_freq(s, index);
             if (s->control[index] & AW_A10_PIT_TIMER_RELOAD) {
                 ptimer_set_count(s->timer[index], s->interval[index]);
@@ -131,10 +132,13 @@ static void a10_pit_write(void *opaque, hwaddr offset, uint64_t value,
             } else {
                 ptimer_stop(s->timer[index]);
             }
+            ptimer_transaction_commit(s->timer[index]);
             break;
         case AW_A10_PIT_TIMER_INTERVAL:
             s->interval[index] = value;
+            ptimer_transaction_begin(s->timer[index]);
             ptimer_set_limit(s->timer[index], s->interval[index], 1);
+            ptimer_transaction_commit(s->timer[index]);
             break;
         case AW_A10_PIT_TIMER_COUNT:
             s->count[index] = value;
@@ -225,8 +229,10 @@ static void a10_pit_reset(DeviceState *dev)
         s->control[i] = AW_A10_PIT_DEFAULT_CLOCK;
         s->interval[i] = 0;
         s->count[i] = 0;
+        ptimer_transaction_begin(s->timer[i]);
         ptimer_stop(s->timer[i]);
         a10_pit_set_freq(s, i);
+        ptimer_transaction_commit(s->timer[i]);
     }
     s->watch_dog_mode = 0;
     s->watch_dog_control = 0;
@@ -255,7 +261,6 @@ static void a10_pit_init(Object *obj)
 {
     AwA10PITState *s = AW_A10_PIT(obj);
     SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
-    QEMUBH * bh[AW_A10_PIT_TIMER_NR];
     uint8_t i;
 
     for (i = 0; i < AW_A10_PIT_TIMER_NR; i++) {
@@ -270,8 +275,7 @@ static void a10_pit_init(Object *obj)
 
         tc->container = s;
         tc->index = i;
-        bh[i] = qemu_bh_new(a10_pit_timer_cb, tc);
-        s->timer[i] = ptimer_init_with_bh(bh[i], PTIMER_POLICY_DEFAULT);
+        s->timer[i] = ptimer_init(a10_pit_timer_cb, tc, PTIMER_POLICY_DEFAULT);
     }
 }
 
-- 
2.20.1


