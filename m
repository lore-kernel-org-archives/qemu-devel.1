Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE9A1C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:44:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7AC920663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:44:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cRXmWSLR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7AC920663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53566 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3S5-0004Fn-Or
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:44:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36950)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q4-0004Bx-9A
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q2-0007QF-U5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:51 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2q2-0007PI-NK
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:50 -0400
Received: by mail-wr1-x442.google.com with SMTP id p14so20379797wro.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=AqfOX9DanbrHqfYl2VtcpfIOP77gIYhu/52gPlZVV/I=;
 b=cRXmWSLRSUUl2Uag/YMbiBTHxMpURXzmrUSZgQyDLliu45CbNKdzC5LGr3MpfTvwxL
 GQZQwYrOiT5nMWvWYR6hVRe49JR/6udbg1vgsFoEGTrojCM2yz5cwo4LzbKOnbaziAsA
 1kGYuMeJi/ggB7jexRD1X6rLsbMjTKROiajf8xPwhv/Q0ztRp+buE4KzGn5dW0onsKei
 MLDvAt03ettAgI90YyIl01cCPXLNsLbysfqTHkngbwo7OwmfgXVckq8tR7HLSi39fKmx
 tPDUdcTA2z8PPsNeFfRBC/hWECNazkYESIHMaqFxRugkNrRCwMj7FRXyKFno2XWup/SF
 W64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AqfOX9DanbrHqfYl2VtcpfIOP77gIYhu/52gPlZVV/I=;
 b=iSFl+cS8QihyBIDAB7W3rdN1mKVsnwfI0r/KZ98VFPP5cMSvWIwkrF2XYEXBstLqoD
 BxwXKsyjzAkImRkjD3cu278IFyqvpP8PHmjZofxl9KR1MR8ETGRXA2lJht1thErNIjAD
 aMyCWXwxac7r+dEjQV7WmYmeHs2/Qs03k7QKGXZQR6+HyUHzlipRvyegvTVP4EjRwz50
 pYxj4ysDelPc6juVaCi8jD9At6xso1GrMKTvuBNrunNdfwHUN+x1DzVbbHKPg5E8phVv
 R6+HZgHtWhB8Vg7o7i/OWdTA8jfMkpnDuEBUTrVxyihoOd25Ml0NOJXPjRUMYafsdvc1
 WYxw==
X-Gm-Message-State: APjAAAXc1ZTN06pPRnN9hfOpB8ZN4x6gPnSUxNgmYNuMdfTkgmDkoiQP
 drCV4K0Odyd5cIegKqOxvsJj8gFRf8vf2Q==
X-Google-Smtp-Source: APXvYqw2U5QtnatkDf6k2+QKRrhQKFX5pOgMsmBUClRjDTsEjd54QhgJD/75rEcG3yoKTdne/fkwmg==
X-Received: by 2002:a05:6000:103:: with SMTP id
 o3mr2574464wrx.357.1571069089237; 
 Mon, 14 Oct 2019 09:04:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.47
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 22/68] hw/timer/mss-timerc: Switch to transaction-based ptimer
 API
Date: Mon, 14 Oct 2019 17:03:18 +0100
Message-Id: <20191014160404.19553-23-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the mss-timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-20-peter.maydell@linaro.org
---
 include/hw/timer/mss-timer.h |  1 -
 hw/timer/mss-timer.c         | 11 ++++++++---
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/include/hw/timer/mss-timer.h b/include/hw/timer/mss-timer.h
index d15d1732f81..e5a784b27e4 100644
--- a/include/hw/timer/mss-timer.h
+++ b/include/hw/timer/mss-timer.h
@@ -46,7 +46,6 @@
 #define R_TIM1_MAX        6
 
 struct Msf2Timer {
-    QEMUBH *bh;
     ptimer_state *ptimer;
 
     uint32_t regs[R_TIM1_MAX];
diff --git a/hw/timer/mss-timer.c b/hw/timer/mss-timer.c
index a34c2402b00..b1c9a805011 100644
--- a/hw/timer/mss-timer.c
+++ b/hw/timer/mss-timer.c
@@ -24,7 +24,6 @@
  */
 
 #include "qemu/osdep.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "hw/irq.h"
@@ -67,6 +66,7 @@ static void timer_update_irq(struct Msf2Timer *st)
     qemu_set_irq(st->irq, (ier && isr));
 }
 
+/* Must be called from within a ptimer_transaction_begin/commit block */
 static void timer_update(struct Msf2Timer *st)
 {
     uint64_t count;
@@ -159,7 +159,9 @@ timer_write(void *opaque, hwaddr offset,
     switch (addr) {
     case R_TIM_CTRL:
         st->regs[R_TIM_CTRL] = value;
+        ptimer_transaction_begin(st->ptimer);
         timer_update(st);
+        ptimer_transaction_commit(st->ptimer);
         break;
 
     case R_TIM_RIS:
@@ -171,7 +173,9 @@ timer_write(void *opaque, hwaddr offset,
     case R_TIM_LOADVAL:
         st->regs[R_TIM_LOADVAL] = value;
         if (st->regs[R_TIM_CTRL] & TIMER_CTRL_ENBL) {
+            ptimer_transaction_begin(st->ptimer);
             timer_update(st);
+            ptimer_transaction_commit(st->ptimer);
         }
         break;
 
@@ -228,9 +232,10 @@ static void mss_timer_init(Object *obj)
     for (i = 0; i < NUM_TIMERS; i++) {
         struct Msf2Timer *st = &t->timers[i];
 
-        st->bh = qemu_bh_new(timer_hit, st);
-        st->ptimer = ptimer_init_with_bh(st->bh, PTIMER_POLICY_DEFAULT);
+        st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(st->ptimer);
         ptimer_set_freq(st->ptimer, t->freq_hz);
+        ptimer_transaction_commit(st->ptimer);
         sysbus_init_irq(SYS_BUS_DEVICE(obj), &st->irq);
     }
 
-- 
2.20.1


