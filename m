Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF4FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:24:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B1BB217D7
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:24:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PtVYUBhI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B1BB217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtDN-0003xf-3E
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:24:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7Q-0006be-Kw
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7O-0002DN-JG
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:52 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40681)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7O-0002Ch-As
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:17:50 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so3924572wmj.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vp4+p4FLQruJ614qug2AywQIur5rU9O0ZC+bqOyPTzg=;
 b=PtVYUBhIWbWgg8zezYNZa6Tzzuev48iYDvlHzBz+NQDGavmE+fwArjtw6U167K/WEw
 exlh9g3JiFiDY9LU4mhivPo0bD8m1Z9Seqw7ZkZha+L12vQJk2xMHc00lORxM8gV+mHX
 BkfXxKLd//QpFiJmfWBc0Yx4inQSXPvsjKBt9YG7UQRjuC5ZUJq00ScLjMqd76FmbsUp
 SJHrX8CfJfKdYcod9fpYo0fMwj8/hkOGXE3C2lpF3Hrw4V33BWXbX50Uc4wRCXOkMK/K
 CwS5aIPMNeZshkxZj5gb5tIe9bkyCERM9Ewi0o07STsznRkBzrt5ioF/UzdLIcVKbOam
 tzGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vp4+p4FLQruJ614qug2AywQIur5rU9O0ZC+bqOyPTzg=;
 b=J2VRDrPs6xpzXIfyWPGrBo3mI9UeuqxhYiSoS+0fVAh5k9QATZaHasOPU3trkegIgF
 IPSSEhLIy/imopHQDnHQA1kDvgJgmDonmprX5MLyH5jwNrPK1wdVlN97eLXhF08te+LH
 De/KCiCjIvqF21ovGnQOd4uh7f0sE7UtThyPXMD+j1H76Hrkwi7bkMszE3TFlApeW8Oe
 peUvp55Z+Se+F7228MrR1rzXO6xZFFOAO2e/2YZT1AUMQzaxm9E3/Xk1YrmsKXjqJG1j
 vMg08Wz1b2WZY7R02vVQKBv1uCPbLo173dB+kvrMzbgO4G5kcQjY8WqyYLlRnyXCG73Z
 zrBA==
X-Gm-Message-State: APjAAAWjzMKGhhi1EfwcZgY+b1+rHGc4VyX4su3f0i3J40EZrfPCIGyJ
 WoXJ9lRXqD/eCn2MDgHxAlxQPw==
X-Google-Smtp-Source: APXvYqx/s53I5iXHlJAyVkB1Vtz/ZIT0P32aFNtEYH5QI3eNMYC94hiktNb/JUS9TBROZWKR7SmbVA==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr4958787wmb.90.1570555069072; 
 Tue, 08 Oct 2019 10:17:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 04/21] hw/timer/arm_timer.c: Switch to transaction-based
 ptimer API
Date: Tue,  8 Oct 2019 18:17:23 +0100
Message-Id: <20191008171740.9679-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Switch the arm_timer.c code away from bottom-half based ptimers
to the new transaction-based ptimer API. This just requires
adding begin/commit calls around the various arms of
arm_timer_write() that modify the ptimer state, and using the
new ptimer_init() function to create the timer.

Fixes: https://bugs.launchpad.net/qemu/+bug/1777777
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index 848fbcb0e25..255def3deec 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -14,7 +14,6 @@
 #include "hw/irq.h"
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 #include "trace.h"
@@ -79,7 +78,10 @@ static uint32_t arm_timer_read(void *opaque, hwaddr offset)
     }
 }
 
-/* Reset the timer limit after settings have changed.  */
+/*
+ * Reset the timer limit after settings have changed.
+ * May only be called from inside a ptimer transaction block.
+ */
 static void arm_timer_recalibrate(arm_timer_state *s, int reload)
 {
     uint32_t limit;
@@ -106,13 +108,16 @@ static void arm_timer_write(void *opaque, hwaddr offset,
     switch (offset >> 2) {
     case 0: /* TimerLoad */
         s->limit = value;
+        ptimer_transaction_begin(s->timer);
         arm_timer_recalibrate(s, 1);
+        ptimer_transaction_commit(s->timer);
         break;
     case 1: /* TimerValue */
         /* ??? Linux seems to want to write to this readonly register.
            Ignore it.  */
         break;
     case 2: /* TimerControl */
+        ptimer_transaction_begin(s->timer);
         if (s->control & TIMER_CTRL_ENABLE) {
             /* Pause the timer if it is running.  This may cause some
                inaccuracy dure to rounding, but avoids a whole lot of other
@@ -132,13 +137,16 @@ static void arm_timer_write(void *opaque, hwaddr offset,
             /* Restart the timer if still enabled.  */
             ptimer_run(s->timer, (s->control & TIMER_CTRL_ONESHOT) != 0);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case 3: /* TimerIntClr */
         s->int_level = 0;
         break;
     case 6: /* TimerBGLoad */
         s->limit = value;
+        ptimer_transaction_begin(s->timer);
         arm_timer_recalibrate(s, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     default:
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -170,14 +178,12 @@ static const VMStateDescription vmstate_arm_timer = {
 static arm_timer_state *arm_timer_init(uint32_t freq)
 {
     arm_timer_state *s;
-    QEMUBH *bh;
 
     s = (arm_timer_state *)g_malloc0(sizeof(arm_timer_state));
     s->freq = freq;
     s->control = TIMER_CTRL_IE;
 
-    bh = qemu_bh_new(arm_timer_tick, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(arm_timer_tick, s, PTIMER_POLICY_DEFAULT);
     vmstate_register(NULL, -1, &vmstate_arm_timer, s);
     return s;
 }
-- 
2.20.1


