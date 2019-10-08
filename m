Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7BE7C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:35:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B5592070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:35:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ohhpWqFF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B5592070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59258 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtO6-0005G8-NX
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7c-0006ll-RE
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7Z-0002Lr-4W
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:02 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:35829)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7Y-0002Kl-TN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:01 -0400
Received: by mail-wr1-x441.google.com with SMTP id v8so20344932wrt.2
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=AQvT9vDwvMSeUbPbD+uEtZfbrPLTNxo2MaS4CXHbEVw=;
 b=ohhpWqFFQHiMPwr97FA20nrcPzPIFqpzJQCRvfq+vE/j6/3P2V2Uo3p6Boe6Hx1XqF
 2D7B4fwzZEuaoAF5c4DQl+ZUrPmDVBVHEQlYMXvj9am4n3vDfMRCbmDrBXdm/YLflYR4
 xudVSZ3HCJIl/DubdNsUMZGEpab3rRrxqHH30RUzQ5STZgNnD/m0oQd52sicnkpBk7fn
 rt/NDlxwRBiKa+1jTsy8vEqjIBqzi5Rb6Gpa8zLXcz15RVrzd0x0lud5J4aEXv5mPTEQ
 oUEIis7FsepQWO/cpdU0Fb+9jaSKY27oXX7GDOHPQO44syRoS4kcetQp7FL4B89kcm6G
 mmxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=AQvT9vDwvMSeUbPbD+uEtZfbrPLTNxo2MaS4CXHbEVw=;
 b=uasN2YjLlhNueLBK99RcS6QHfP+5lduTMMlFDiZJ+x00mvrs+NtbWmdiLw1/0q7ij0
 6LTRv7OrXBiOkmDwQKdZlu8itiqnxFByXuVrm9aqCtXcKCBBajjohi4b02w3SE6i98/J
 VjRzbN9HCuOk80i/r1KSl8iPjdjYD/hqKa7cji/lAOiCTUk4IYqlXjPg6uKMs6+EyhMX
 9iwIjh3mYo/O0rKlTNT6ZzLVUI+WfBOYQSyXjy1G8nt22uvNnO2RvyPW08q0TyoL0nVq
 N4wA+QGYAlE9fiO4K1mhtN9S03VzJ3tM7dWAuJq2BywNiVw3vRXj3SVX/u2ekLbIcsgF
 o/fg==
X-Gm-Message-State: APjAAAXMgtMoUhGzIPs8YAXuiBV+AYqzL4KoCM5QNu9ry1k0oVibFtXI
 VFi7/l7pBX0WthjVBUfPF44Low==
X-Google-Smtp-Source: APXvYqwLnQqxUnwXDUy7VLBYztYblW/2977UIocdAMkjdLY97bBYDKTYBDyRa52JEvwcfbc/yqzoJg==
X-Received: by 2002:a5d:574f:: with SMTP id q15mr16258203wrw.362.1570555079030; 
 Tue, 08 Oct 2019 10:17:59 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:58 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/21] hw/timer/exynos4210_mct.c: Switch LFRC to
 transaction-based ptimer API
Date: Tue,  8 Oct 2019 18:17:31 +0100
Message-Id: <20191008171740.9679-13-peter.maydell@linaro.org>
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

Switch the exynos MCT LFRC timers over to the ptimer transaction API.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index fcf91c75cc5..82803ef9a02 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -608,6 +608,7 @@ static uint64_t exynos4210_lfrc_get_count(Exynos4210MCTLT *s)
 
 /*
  * Set counter of FRC local timer.
+ * Must be called from within exynos4210_lfrc_tx_begin/commit block.
  */
 static void exynos4210_lfrc_update_count(Exynos4210MCTLT *s)
 {
@@ -620,6 +621,7 @@ static void exynos4210_lfrc_update_count(Exynos4210MCTLT *s)
 
 /*
  * Start local FRC timer
+ * Must be called from within exynos4210_lfrc_tx_begin/commit block.
  */
 static void exynos4210_lfrc_start(Exynos4210MCTLT *s)
 {
@@ -628,12 +630,25 @@ static void exynos4210_lfrc_start(Exynos4210MCTLT *s)
 
 /*
  * Stop local FRC timer
+ * Must be called from within exynos4210_lfrc_tx_begin/commit block.
  */
 static void exynos4210_lfrc_stop(Exynos4210MCTLT *s)
 {
     ptimer_stop(s->ptimer_frc);
 }
 
+/* Start ptimer transaction for local FRC timer */
+static void exynos4210_lfrc_tx_begin(Exynos4210MCTLT *s)
+{
+    ptimer_transaction_begin(s->ptimer_frc);
+}
+
+/* Commit ptimer transaction for local FRC timer */
+static void exynos4210_lfrc_tx_commit(Exynos4210MCTLT *s)
+{
+    ptimer_transaction_commit(s->ptimer_frc);
+}
+
 /*
  * Local timer free running counter tick handler
  */
@@ -981,9 +996,9 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
 
         /* local timer */
         ptimer_set_freq(s->l_timer[0].tick_timer.ptimer_tick, s->freq);
-        ptimer_set_freq(s->l_timer[0].ptimer_frc, s->freq);
+        tx_ptimer_set_freq(s->l_timer[0].ptimer_frc, s->freq);
         ptimer_set_freq(s->l_timer[1].tick_timer.ptimer_tick, s->freq);
-        ptimer_set_freq(s->l_timer[1].ptimer_frc, s->freq);
+        tx_ptimer_set_freq(s->l_timer[1].ptimer_frc, s->freq);
     }
 }
 
@@ -1012,7 +1027,9 @@ static void exynos4210_mct_reset(DeviceState *d)
         s->l_timer[i].tick_timer.count = 0;
         s->l_timer[i].tick_timer.distance = 0;
         s->l_timer[i].tick_timer.progress = 0;
+        exynos4210_lfrc_tx_begin(&s->l_timer[i]);
         ptimer_stop(s->l_timer[i].ptimer_frc);
+        exynos4210_lfrc_tx_commit(&s->l_timer[i]);
 
         exynos4210_ltick_timer_init(&s->l_timer[i].tick_timer);
     }
@@ -1316,6 +1333,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         }
 
         /* Start or Stop local FRC if TCON changed */
+        exynos4210_lfrc_tx_begin(&s->l_timer[lt_i]);
         if ((value & L_TCON_FRC_START) >
         (s->l_timer[lt_i].reg.tcon & L_TCON_FRC_START)) {
             DPRINTF("local timer[%d] start frc\n", lt_i);
@@ -1326,6 +1344,7 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
             DPRINTF("local timer[%d] stop frc\n", lt_i);
             exynos4210_lfrc_stop(&s->l_timer[lt_i]);
         }
+        exynos4210_lfrc_tx_commit(&s->l_timer[lt_i]);
         break;
 
     case L0_TCNTB: case L1_TCNTB:
@@ -1477,11 +1496,11 @@ static void exynos4210_mct_init(Object *obj)
     /* Local timers */
     for (i = 0; i < 2; i++) {
         bh[0] = qemu_bh_new(exynos4210_ltick_event, &s->l_timer[i]);
-        bh[1] = qemu_bh_new(exynos4210_lfrc_event, &s->l_timer[i]);
         s->l_timer[i].tick_timer.ptimer_tick =
             ptimer_init_with_bh(bh[0], PTIMER_POLICY_DEFAULT);
         s->l_timer[i].ptimer_frc =
-            ptimer_init_with_bh(bh[1], PTIMER_POLICY_DEFAULT);
+            ptimer_init(exynos4210_lfrc_event, &s->l_timer[i],
+                        PTIMER_POLICY_DEFAULT);
         s->l_timer[i].id = i;
     }
 
-- 
2.20.1


