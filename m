Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 637BCC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:09:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 310EB21D71
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 12:09:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y0eYyBKu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 310EB21D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGMOP-0002mG-18
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 08:09:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGM4x-0003a6-8f
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:49:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGM4v-00017c-Up
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:48:59 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42533)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGM4v-00017A-Nr
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:48:57 -0400
Received: by mail-wr1-x441.google.com with SMTP id n14so6774948wrw.9
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=vp4+p4FLQruJ614qug2AywQIur5rU9O0ZC+bqOyPTzg=;
 b=y0eYyBKuPQJhvyzvNExbbBu6LW/3Kxgz85hSt9/HVrhIy+FDQM7xSQXE+ifLU+VkOg
 FRqufp2Rnq4q7dvSYOBS1UYZKKoTvJXE1masHBdAaY9K/NuiPf6Zf/ecrY9qdDmNSACC
 BSez378zfyIJ/OT6T/XXP1rvYXtgePMRMnJXx78GhqOL7G6PfV4YfSKoCs+xRY4+0sWX
 S+8LxZUSFs2V8Exd6GyW6Zh2P/E0JFWUsglJLJt3AgUVF/0NFMEMvLEBbYwR6PDBQ6ZY
 4rNA0J5CGxorpWBcZJUgeRduBC3o3RGtkn7pslDP+svPufJr94AVAeZiO60YL84pAxgN
 Is9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=vp4+p4FLQruJ614qug2AywQIur5rU9O0ZC+bqOyPTzg=;
 b=sZRrDyS/x8+eEh2COmOcQ5Ri27p9vwYEYUD7jTmgEq6TBhfdw3Fqr2Awi/yH/3QvoC
 ve8AasIimNvk7Qpt5QFj/UAwiECYndRygjdG0jGhSSQvGtKYgTyVDqDhAGGPMFpn4TR3
 6sfjtIEUii6SEmnOTqE1yfjlvaMxvj95tuk/1bPsMzXah9sp9HFF94KaZQGLrbgwtv/y
 BIEIUZxtBKwF2f7roDLU+lBefb031Xdkb40TEB9vOL9WOv21PjQUAZm3I2ScTQ7urSzu
 1b9BdscMG7fwuQDdHAbqUsfTreHaZr0hW/XlbtC8eN516THYXix6v80EuLzejEPp1Gh1
 fdvQ==
X-Gm-Message-State: APjAAAVWQ798qugbje0YX+LLJZLgeUH8RRTKxPdJeJTBRkncPcF8l+FP
 E9XFRXO6omxigxW4dxkDwGRK8g==
X-Google-Smtp-Source: APXvYqwv9JWnYMBhQx0Vc1pSAIDY1X/CQR/N7D2n4P2SrpbAXzjanCC4sib4WEY6rUD8SF2M8FYNLw==
X-Received: by 2002:a5d:5403:: with SMTP id g3mr10640252wrv.338.1570189736840; 
 Fri, 04 Oct 2019 04:48:56 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t17sm11962094wrp.72.2019.10.04.04.48.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 04:48:55 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC 4/4] hw/timer/arm_timer.c: Switch to transaction-based ptimer API
Date: Fri,  4 Oct 2019 12:48:48 +0100
Message-Id: <20191004114848.16831-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004114848.16831-1-peter.maydell@linaro.org>
References: <20191004114848.16831-1-peter.maydell@linaro.org>
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


