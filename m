Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 715D8FA3736
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:54:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C8E2082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hBG28tF6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C8E2082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Er-0003LY-Ow
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36192)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q9-0006uX-IC
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q8-0002aw-C3
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:17 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:46360)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5q8-0002aj-69
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id o18so2334776wrv.13
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=SpU9drP88hpdFB+pw5pxIm1RXJ3C2VinT/Xy4FHJ7Wk=;
 b=hBG28tF6LSbUmdZZuNU9YDnVufo20hCdsETDpHe62o9zlBwnKUBkOxWN4F9jM7gq/q
 j5U+7RNIUo0h909uOgb4TvjJjGWGb0YPscN3i6Vp6H78TyhKgHtO2BoMhHkrqJqR0ebv
 MRB6TsoUdIZxu94cayaRxlJmzl9SsEZCCVsfN5W9ZFV+yjcMUsC0QCuaV/jdxKcqUBkK
 03pzpLTteBQhW6xbMXogfIm1+rtYbPVw+s1Te+WUNADcl0SiXHzfAFEkoYFm4MVqeJjN
 HTwXA2GFMy4PNAQ2RW4KQ6pQKiQx/tO/NeI/Tmj5pbtrxVbwzq94g6jazxFfbtiTXVkE
 tUWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=SpU9drP88hpdFB+pw5pxIm1RXJ3C2VinT/Xy4FHJ7Wk=;
 b=F8ylH1UOR2Ss1TV8NwsbYwaY+9D+0oMFHos+9SPmA8KsKt4LwT9Heca9OBMg5baopE
 n7kxCEj/xion1nVwHXBj4itK1VhBdwcR9IjihlipVfofsixIRwc3fS1Lm+I02lQbwMmT
 V0qUWgFnjip2pk1U/hwkhohINtlcMXz18w4bMoKoZp3fnXJts7ESk0NHlXeysdLy6QTi
 bBcpz3BDvU3BGB0W44IuRa5HHHE+PxBkZVaWd+pcdl5tEHpYWyolRqO8CUG5WKumtdGD
 uOX8xR4qhRhjznipK9oK+nf+kbHhGnVmzYtcNnyT4fkGxIMBat80xj49wOA9g3MR2T8N
 RRZQ==
X-Gm-Message-State: APjAAAXVQHV6Me01sxJFNG/0frrDPJj6x40kdTD1qs1JLCUSWkln57kN
 o5wz/7z392lou83khhiln6ebifkxc66rRg==
X-Google-Smtp-Source: APXvYqwDLJ1+HjEgZRgfldmv5pCno2ASrX+uP4lLbBeHfwWjhdOm/EIeO1eK0qRDZR+Vx61+PI9b5g==
X-Received: by 2002:adf:f511:: with SMTP id q17mr2997488wro.3.1571318954893;
 Thu, 17 Oct 2019 06:29:14 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n15sm2703392wrw.47.2019.10.17.06.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:29:13 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/8] hw/timer/altera_timer.c: Switch to transaction-based
 ptimer API
Date: Thu, 17 Oct 2019 14:29:02 +0100
Message-Id: <20191017132905.5604-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132905.5604-1-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the altera_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/altera_timer.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/hw/timer/altera_timer.c b/hw/timer/altera_timer.c
index ee32e0ec1ff..79fc381252d 100644
--- a/hw/timer/altera_timer.c
+++ b/hw/timer/altera_timer.c
@@ -19,7 +19,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qapi/error.h"
 
@@ -53,7 +52,6 @@ typedef struct AlteraTimer {
     MemoryRegion  mmio;
     qemu_irq      irq;
     uint32_t      freq_hz;
-    QEMUBH       *bh;
     ptimer_state *ptimer;
     uint32_t      regs[R_MAX];
 } AlteraTimer;
@@ -105,6 +103,7 @@ static void timer_write(void *opaque, hwaddr addr,
         break;
 
     case R_CONTROL:
+        ptimer_transaction_begin(t->ptimer);
         t->regs[R_CONTROL] = value & (CONTROL_ITO | CONTROL_CONT);
         if ((value & CONTROL_START) &&
             !(t->regs[R_STATUS] & STATUS_RUN)) {
@@ -115,10 +114,12 @@ static void timer_write(void *opaque, hwaddr addr,
             ptimer_stop(t->ptimer);
             t->regs[R_STATUS] &= ~STATUS_RUN;
         }
+        ptimer_transaction_commit(t->ptimer);
         break;
 
     case R_PERIODL:
     case R_PERIODH:
+        ptimer_transaction_begin(t->ptimer);
         t->regs[addr] = value & 0xFFFF;
         if (t->regs[R_STATUS] & STATUS_RUN) {
             ptimer_stop(t->ptimer);
@@ -126,6 +127,7 @@ static void timer_write(void *opaque, hwaddr addr,
         }
         tvalue = (t->regs[R_PERIODH] << 16) | t->regs[R_PERIODL];
         ptimer_set_limit(t->ptimer, tvalue + 1, 1);
+        ptimer_transaction_commit(t->ptimer);
         break;
 
     case R_SNAPL:
@@ -183,9 +185,10 @@ static void altera_timer_realize(DeviceState *dev, Error **errp)
         return;
     }
 
-    t->bh = qemu_bh_new(timer_hit, t);
-    t->ptimer = ptimer_init_with_bh(t->bh, PTIMER_POLICY_DEFAULT);
+    t->ptimer = ptimer_init(timer_hit, t, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(t->ptimer);
     ptimer_set_freq(t->ptimer, t->freq_hz);
+    ptimer_transaction_commit(t->ptimer);
 
     memory_region_init_io(&t->mmio, OBJECT(t), &timer_ops, t,
                           TYPE_ALTERA_TIMER, R_MAX * sizeof(uint32_t));
@@ -204,8 +207,10 @@ static void altera_timer_reset(DeviceState *dev)
 {
     AlteraTimer *t = ALTERA_TIMER(dev);
 
+    ptimer_transaction_begin(t->ptimer);
     ptimer_stop(t->ptimer);
     ptimer_set_limit(t->ptimer, 0xffffffff, 1);
+    ptimer_transaction_commit(t->ptimer);
     memset(t->regs, 0, sizeof(t->regs));
 }
 
-- 
2.20.1


