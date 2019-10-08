Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140B0C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:44:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D840A21721
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:44:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="N0LL/YfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D840A21721
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59406 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtXU-0005cg-Ah
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7i-0006ss-3g
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7g-0002RW-J4
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55379)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7g-0002R4-Bs
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id a6so4010539wma.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=utJl6lOKI6yGj+1Myezosvn3a88cspPU4H5F4QN8n/0=;
 b=N0LL/YfI2y+MrFGNlw4C8nWcYSF8E4lRaFlcbC1xXeGfN53mxUEDm51MRrh3FbeQu4
 HCgrGEKJrPf7epG2YubFu6Cu+rMkodILuPXLZ70QPPnCzQvWQ8pWDjujjc4BHavDpzUv
 cAJrxckKI9xEFufW0ldYdNrHDPQRn/2upzKqYO05jaxYXAXeVXI0SfOdC+8VZG34NvNs
 bFvUJfEdREDP/fQwghCEmD9A+XMfBFriR+LysSLNvCWcTp9tQ526xD2URSwurDlzDbV1
 /JptaBJGQf1NXyUzw78rYZWPweTbhsK0YKOu4tg8GkDonfza1F14w/5+/P8VylCds7HI
 Y8mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=utJl6lOKI6yGj+1Myezosvn3a88cspPU4H5F4QN8n/0=;
 b=TFxBAYt1sAX5hUQVUGpTYDfp5KoaGnaoEpQC+u8LQzbgJ9Vmzqv4wPNpHMj0zgd15t
 Umb0ZQ1a8u+9MylCZIKOTya3CXO3SZvbuQjqmUopauw3kcN4XGEHxXqF5FlkZzLXzc1O
 N4C4Ylh+tAON30THmzAf3vEAcv8G4/TsaVU6GHwCWPPws9tfnk9C3QelePMpz/ZE/FyD
 kApKPypVWTdLAMzW6LHQjGqXN9UehpnhtteADJM4BZAJISF0vDMV3AVCA3aFpiGfEHkv
 zgdLGPnCcowqD7XDIbtmAC08TFQsNAUmfi73YukkzytFRwv/VU3XSsdoQ3y4jIJJ2FsX
 Qo/A==
X-Gm-Message-State: APjAAAVf2GNsgAXz7a44ydHWsi0CzxY6Wo+8/jjh6u0KUkRQokvy8CCI
 xZKq+xAAXrUgsTFplClfoALlSg==
X-Google-Smtp-Source: APXvYqyiiEoUz1ngnhVryKkPamLiz/223hkUkg33scvKYWpYfKtNLuPa84XuMpCxKWt466ZB8Jzx/Q==
X-Received: by 2002:a7b:c94a:: with SMTP id i10mr4926860wml.40.1570555087431; 
 Tue, 08 Oct 2019 10:18:07 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.18.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:18:06 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 19/21] hw/timer/mss-timerc: Switch to transaction-based
 ptimer API
Date: Tue,  8 Oct 2019 18:17:38 +0100
Message-Id: <20191008171740.9679-20-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Switch the mss-timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


