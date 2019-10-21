Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDF47CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:50:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B8FD6214AE
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 13:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z0cPzV6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B8FD6214AE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMY50-0006EW-Mq
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 09:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41527)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXyh-0007wf-2Q
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMXyf-0000mb-Qz
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:06 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:36249)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMXyf-0000mB-K9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 09:44:05 -0400
Received: by mail-wr1-x444.google.com with SMTP id w18so13522587wrt.3
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 06:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pPyjiLHcXCm2RhqBb6tCDKheW+xM8aFwIwX0Fdcw04Y=;
 b=Z0cPzV6aXQz8jV+2+sVoBNTXSuMK+P8IwBt/vq84+IqAqOjUNAa7MOyZx8N9/Z9oh1
 8eGqFqQBLG6Dd6wD1gScJ3wK9ru+k88hJFlrSJeRqG0U804Nd1suTNKwERF1ZXjCqaU6
 Y68w7wXS9I2QyJ6eDlzCsgM8h8sb6ATPgx9a/8+7Cl9n45TEowEEj6sTnX+ftra+IqjW
 fVVyzn7zD1SGJ4CtwPagavaveNjhe25GjnXfu8Kzbz3Dbz1kzftI8fInKaVY918BcbQC
 zwZBNdw1kVYWZ8qnTQx/77CLHb++z3tloj+mZdPGbDzI7bHoqnq1u963m+qGlO0Z5O9S
 PVpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pPyjiLHcXCm2RhqBb6tCDKheW+xM8aFwIwX0Fdcw04Y=;
 b=EaGj/90b0pDYodzcL8Ruo8RqGeZvqXmFopLJYn3D6TngNJkjiD+nnwzsT9rDlAnM/7
 39qSLkT/WtxD4d7klCToVhqUNwqmGcMpQlH8wnvvTiYVY8h7kEFGwqvMkFZRVWZSUKBa
 1jVvPmv0QNz6ls6JnBP/sNMHenGhKy+LXgJvFsN17yUQ2fQ3+ZmUdJLweFi8a3/YbB2v
 K8l5BnNae+WY81qyczFEFCzEiz4Ej5VnVCKUkXs3EMsyN7lxQ8irzM47UhmBB/UmWrmx
 CSfdGocvlDl3FegcOA+gHQFPPFpaIy90dCw1fikQl1d1B4ft+zCyihbl2Lm1ntbzs091
 Q2cA==
X-Gm-Message-State: APjAAAVK9+/JE3YCRDZmHOTc9qXSGj8cdiDVzrWPnWq+ECBAEihuOOFy
 21QxAcIrsKv7djhz+Cckp2b7ob2w3Qw=
X-Google-Smtp-Source: APXvYqyKmJruj7Gnrsjxo/vxQ9Dpcv2YUIEjXhdNqorKOCgJIvyykoJcvD0ucZTSvOiP/NAX0NRVhA==
X-Received: by 2002:a5d:6585:: with SMTP id q5mr19821855wru.74.1571665444339; 
 Mon, 21 Oct 2019 06:44:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q196sm10443689wme.23.2019.10.21.06.44.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 06:44:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 3/3] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
Date: Mon, 21 Oct 2019 14:43:57 +0100
Message-Id: <20191021134357.14266-4-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191021134357.14266-1-peter.maydell@linaro.org>
References: <20191021134357.14266-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Richard Henderson <richard.henderson@linaro.org>,
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
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 hw/timer/slavio_timer.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index 890dd53f8d8..c55e8d0bf42 100644
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
 
@@ -234,6 +234,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                 ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 1);
             }
         }
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_COUNTER:
         if (slavio_timer_is_user(tc)) {
@@ -245,7 +246,9 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             t->reached = 0;
             count = ((uint64_t)t->counthigh) << 32 | t->count;
             trace_slavio_timer_mem_writel_limit(timer_index, count);
+            ptimer_transaction_begin(t->timer);
             ptimer_set_count(t->timer, LIMIT_TO_PERIODS(t->limit - count));
+            ptimer_transaction_commit(t->timer);
         } else {
             trace_slavio_timer_mem_writel_counter_invalid();
         }
@@ -253,13 +256,16 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
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
@@ -271,6 +277,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
             }
         }
         t->run = val & 1;
+        ptimer_transaction_commit(t->timer);
         break;
     case TIMER_MODE:
         if (timer_index == 0) {
@@ -280,6 +287,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                 unsigned int processor = 1 << i;
                 CPUTimerState *curr_timer = &s->cputimer[i + 1];
 
+                ptimer_transaction_begin(curr_timer->timer);
                 // check for a change in timer mode for this processor
                 if ((val & processor) != (s->cputimer_mode & processor)) {
                     if (val & processor) { // counter -> user timer
@@ -306,6 +314,7 @@ static void slavio_timer_mem_writel(void *opaque, hwaddr addr,
                         trace_slavio_timer_mem_writel_mode_counter(timer_index);
                     }
                 }
+                ptimer_transaction_commit(curr_timer->timer);
             }
         } else {
             trace_slavio_timer_mem_writel_mode_invalid();
@@ -365,10 +374,12 @@ static void slavio_timer_reset(DeviceState *d)
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
@@ -378,7 +389,6 @@ static void slavio_timer_init(Object *obj)
 {
     SLAVIO_TIMERState *s = SLAVIO_TIMER(obj);
     SysBusDevice *dev = SYS_BUS_DEVICE(obj);
-    QEMUBH *bh;
     unsigned int i;
     TimerContext *tc;
 
@@ -390,9 +400,11 @@ static void slavio_timer_init(Object *obj)
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


