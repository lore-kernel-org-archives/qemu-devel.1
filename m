Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4515CFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:48:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FB3D214E0
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:48:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZuyvpQ1h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FB3D214E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL68g-00033g-3Z
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5l2-00009G-GU
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:24:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5l1-0000wT-8q
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:24:00 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40169)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5l1-0000wB-2K
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:23:59 -0400
Received: by mail-wr1-x443.google.com with SMTP id o28so2338618wro.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=ubzqTky8oXQWHb54LycWqoQN2mw2t/0StAg0pETjdLY=;
 b=ZuyvpQ1hTrRZAMvlys+wfq5OXOBcOObZwbCwFYv0rkDnqE6Ntag9SCmiisciiJKqUT
 w0C7qAPuo3OiLPtBtI3eRn6xGIj7fD3OKqN2PnNRzPEgr6UX67f09lnG+PGLTHzKMdHA
 XlcxZGkidzGBycEALG0uixAkQyCBiFGs5nJAAt6fBTWlCwqSZlyY1WGvDErJgBlQ4BB+
 WRRbaEr686VOUAGWHp3yuDV4NEAyHQRRzdUC68LQftybKm66el1tHwlNahNC0Y06kX2Z
 xUaizJx0CHo89yTjeJ/Q26VgNyvAZCyI39LsduZkdob38tEUxj1xqFgYu2mH/apxJaTC
 sOeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ubzqTky8oXQWHb54LycWqoQN2mw2t/0StAg0pETjdLY=;
 b=GJ4gq38t/Jq4d/kgKsjfkJyx33kQGclMkm6VH0vDB7/LYysg5mDVETvDmy46oc7d2D
 3VBh4/oSR/dYxSh5AnSqH2QoKNHWybcsh1YyCVnez5C1BS5aXGSPpfylWdQ3kdPb4XQ3
 eqaipd16ha7CyS9VK8c0+AsuyL4hGXRbbRucJNCfmOQoaRSfolul4Zqiwi4uJKksuXWw
 ILUZ051MffnCRcsOnKUnDFsM1egbyKX0/AAjHqKwE1rA+8uCdtLfRIkz2+N27MYAIbQJ
 7EV1DxACPZP4zbupjCj7jRPWkB+01Dy2o39j0hWHuUQZsReDFJ6PxwD9QkRqH+DiqhE3
 Hinw==
X-Gm-Message-State: APjAAAWDM0aQv0pAWenrS34ls3DpfRiFDQRGguKyTtZmxOZ9pyVlCOMC
 zczoHd/QmM+I6FJKjrINNcI4DTyGpL/9Ag==
X-Google-Smtp-Source: APXvYqy57JUqLxTr/bl80CQbDzP9FGIBDAdtW2s7C0GBngdK1APk+6cS9VoTJq+8g0pjRQJSyrKmhA==
X-Received: by 2002:adf:92a5:: with SMTP id 34mr2863485wrn.337.1571318637031; 
 Thu, 17 Oct 2019 06:23:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm2270302wrp.26.2019.10.17.06.23.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:23:56 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 2/2] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
Date: Thu, 17 Oct 2019 14:23:51 +0100
Message-Id: <20191017132351.4762-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132351.4762-1-peter.maydell@linaro.org>
References: <20191017132351.4762-1-peter.maydell@linaro.org>
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the slavio_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/slavio_timer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 692d213897d..0e2efe6fe89 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -30,7 +30,6 @@
 #include "hw/sysbus.h"
 #include "migration/vmstate.h"
 #include "trace.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 /*
@@ -213,6 +212,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
     saddr = addr >> 2;
     switch (saddr) {
     case TIMER_LIMIT:
+        ptimer_transaction_begin(t->timer);
         if (slavio_timer_is_user(tc)) {
             uint64_t count;
 
@@ -236,6 +236,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                 }
             }
         }
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_COUNTER:
         if (slavio_timer_is_user(tc)) {
@@ -247,7 +248,9 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             t->reached = 0;
             count = ((uint64_t)t->counthigh) << 32 | t->count;
             trace_slavio_timer_mem_writel_limit(timer_index, count);
+            ptimer_transaction_begin(t->timer);
             ptimer_set_count(t->timer, LIMIT_TO_PERIODS(t->limit - count));
+            ptimer_transaction_commit(t->timer);
         } else {
             trace_slavio_timer_mem_writel_counter_invalid();
         }
@@ -255,13 +258,16 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
     case TIMER_COUNTER_NORST:
         // set limit without resetting counter
         t->limit = val & TIMER_MAX_COUNT32;
+        ptimer_transaction_begin(t->timer);
         if (t->limit == 0) { /* free-run */
             ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 0);
         } else {
             ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 0);
         }
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_STATUS:
+        ptimer_transaction_begin(t->timer);
         if (slavio_timer_is_user(tc)) {
             // start/stop user counter
             if (val & 1) {
@@ -273,6 +279,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             }
         }
         t->run = val & 1;
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_MODE:
         if (timer_index == 0) {
@@ -282,6 +289,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                 unsigned int processor = 1 << i;
                 CPUTimerState *curr_timer = &s->cputimer[i + 1];
 
+                ptimer_transaction_begin(curr_timer->timer);
                 // check for a change in timer mode for this processor
                 if ((val & processor) != (s->cputimer_mode & processor)) {
                     if (val & processor) { // counter -> user timer
@@ -308,6 +316,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                         trace_slavio_timer_mem_writel_mode_counter(timer_index);
                     }
                 }
+                ptimer_transaction_commit(curr_timer->timer);
             }
         } else {
             trace_slavio_timer_mem_writel_mode_invalid();
@@ -367,10 +376,12 @@ static void slavio_timer_reset(DeviceState *d)
         curr_timer->count = 0;
         curr_timer->reached = 0;
         if (i <= s->num_cpus) {
+            ptimer_transaction_begin(curr_timer->timer);
             ptimer_set_limit(curr_timer->timer,
                              LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
             ptimer_run(curr_timer->timer, 0);
             curr_timer->run = 1;
+            ptimer_transaction_commit(curr_timer->timer);
         }
     }
     s->cputimer_mode = 0;
@@ -380,7 +391,6 @@ static void slavio_timer_init(Object *obj)
 {
     SLAVIO_TIMERState *s = SLAVIO_TIMER(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    QEMUBH *bh;
     unsigned int i;
     TimerContext *tc;
 
@@ -392,9 +402,11 @@ static void slavio_timer_init(Object *obj)
         tc->s = s;
         tc->timer_index = i;
 
-        bh = qemu_bh_new(slavio_timer_irq, tc);
-        s->cputimer[i].timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+        s->cputimer[i].timer = ptimer_init(slavio_timer_irq, tc,
+                                           PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(s->cputimer[i].timer);
         ptimer_set_period(s->cputimer[i].timer, TIMER_PERIOD);
+        ptimer_transaction_commit(s->cputimer[i].timer);
 
         size = i == 0 ? SYS_TIMER_SIZE : CPU_TIMER_SIZE;
         snprintf(timer_name, sizeof(timer_name), "timer-%i", i);
-- 
2.20.1


