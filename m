Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D9F9C47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:52:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB03920862
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 11:52:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VaahP1bJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB03920862
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGM8k-00076k-IG
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 07:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55228)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iGM4s-0003UG-Rh
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:48:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iGM4r-00013h-MY
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:48:54 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:44583)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iGM4r-00012u-GJ
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 07:48:53 -0400
Received: by mail-wr1-x444.google.com with SMTP id z9so6763897wrl.11
 for <qemu-devel@nongnu.org>; Fri, 04 Oct 2019 04:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=tWO1/w2pbq76WDihTU7NTfFwpS052NS/zIcxZUmg9Z8=;
 b=VaahP1bJi2xcdpZhg4k/R8BFCQFmrQYArrykQIiM8pk+iSZTAzNfkqW01rTKJ/HBwD
 JYTCSgpQGxFSNQdKpxx/nOjFyc3hipOiPj1vJxVBvR2hiQjisBao7pHUmBVnp7iieEeU
 zpLc3/HTMMz+k75G98FtI2+Xnv6NnSSC8TriTnLcZh0r2fd4qZm23Se5aEmeJVpzbTa0
 js5WjDUkScoDwgR9xGBNmCJjWnq2Sd19Q+vYmeFKcTCzER01OVapPnAEnAEbKRhcHwQt
 X5+foWggR9vpSoK+hPcWkk81cMVzaHbR+/tN9PgZVWn6nSEPOJ1OD7TH4Z4qPajsqL26
 n7Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=tWO1/w2pbq76WDihTU7NTfFwpS052NS/zIcxZUmg9Z8=;
 b=TzqO/gS6ryUlyjimHR9H1FKdzh5FeOqY2zob0GobxQQhg/YvEPl4uzoVUPAE1zFvLc
 Tp2LRRdn86lus/iEWx/MNk20kbIKgRgRO3kVntxrv2LvndcGOo6csSMQ7rkzcje6OVO9
 NAab/MIMclclhJejR0yqL3rwCvmOwmqhXVdtKTdpo905iDED9uTJyGYEs2r/mbkYFcRs
 WYMkPfF+wlQMq/w0HJe/yJXWfbFc2FTYDGtNrVb3Me7sr5Vu3ZBXnBQqRgg7b4phUvVo
 fYtnAwxqbeWvgjdMlEu+KnTfqt5mdTovZvYL69FnCm3F2nAxTNfFVfnUQONB4t3fEsSl
 +ayQ==
X-Gm-Message-State: APjAAAWcfrT0fYFTsbwjkbUtjsrGuxCyqtGIM47me1II1eg4fzzNfIxZ
 aiPiQo1ERs5eZ4eWUt0xQnu62A==
X-Google-Smtp-Source: APXvYqwTw9AH0FDLiRvJx65Zve+aM97SE6hg4t30FuS7+ZdCT2oAREl5HvYTNtylXed3Q9uIer9rnw==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr11092345wrs.319.1570189732496; 
 Fri, 04 Oct 2019 04:48:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id t17sm11962094wrp.72.2019.10.04.04.48.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Oct 2019 04:48:52 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [RFC 1/4] hw/timer/arm_timer: Add trace events
Date: Fri,  4 Oct 2019 12:48:45 +0100
Message-Id: <20191004114848.16831-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191004114848.16831-1-peter.maydell@linaro.org>
References: <20191004114848.16831-1-peter.maydell@linaro.org>
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

Add some basic trace events to the arm_timer device.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/arm_timer.c  | 27 +++++++++++++++++++++------
 hw/timer/trace-events |  7 +++++++
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/hw/timer/arm_timer.c b/hw/timer/arm_timer.c
index c2e6211188b..283ae1e74a9 100644
--- a/hw/timer/arm_timer.c
+++ b/hw/timer/arm_timer.c
@@ -17,6 +17,7 @@
 #include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
+#include "trace.h"
 
 /* Common timer implementation.  */
 
@@ -43,7 +44,10 @@ typedef struct {
 static void arm_timer_update(arm_timer_state *s)
 {
     /* Update interrupts.  */
-    if (s->int_level && (s->control & TIMER_CTRL_IE)) {
+    int level = s->int_level && (s->control & TIMER_CTRL_IE);
+
+    trace_sp804_arm_timer_update(level);
+    if (level) {
         qemu_irq_raise(s->irq);
     } else {
         qemu_irq_lower(s->irq);
@@ -216,17 +220,21 @@ static uint64_t sp804_read(void *opaque, hwaddr offset,
                            unsigned size)
 {
     SP804State *s = (SP804State *)opaque;
+    uint64_t res;
 
     if (offset < 0x20) {
-        return arm_timer_read(s->timer[0], offset);
+        res = arm_timer_read(s->timer[0], offset);
+        goto out;
     }
     if (offset < 0x40) {
-        return arm_timer_read(s->timer[1], offset - 0x20);
+        res = arm_timer_read(s->timer[1], offset - 0x20);
+        goto out;
     }
 
     /* TimerPeriphID */
     if (offset >= 0xfe0 && offset <= 0xffc) {
-        return sp804_ids[(offset - 0xfe0) >> 2];
+        res = sp804_ids[(offset - 0xfe0) >> 2];
+        goto out;
     }
 
     switch (offset) {
@@ -236,12 +244,17 @@ static uint64_t sp804_read(void *opaque, hwaddr offset,
         qemu_log_mask(LOG_UNIMP,
                       "%s: integration test registers unimplemented\n",
                       __func__);
-        return 0;
+        res = 0;
+        goto out;
     }
 
     qemu_log_mask(LOG_GUEST_ERROR,
                   "%s: Bad offset %x\n", __func__, (int)offset);
-    return 0;
+    res = 0;
+
+out:
+    trace_sp804_read(offset, res);
+    return res;
 }
 
 static void sp804_write(void *opaque, hwaddr offset,
@@ -249,6 +262,8 @@ static void sp804_write(void *opaque, hwaddr offset,
 {
     SP804State *s = (SP804State *)opaque;
 
+    trace_sp804_write(offset, value);
+
     if (offset < 0x20) {
         arm_timer_write(s->timer[0], offset, value);
         return;
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index db02a9142cd..600b002c7bf 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -87,3 +87,10 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_alarm_raised(void) "alarm raised"
 pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
+
+# arm_timer.c
+sp804_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+sp804_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+# Note that this trace event can't distinguish which of the two timers
+# in the sp804 is being updated
+sp804_arm_timer_update(int level) "level %d"
-- 
2.20.1


