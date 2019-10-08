Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 646D7C10F14
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3522A2070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:33:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ecS4Wcp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3522A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59226 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtMU-00044z-Gq
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7a-0006kf-Vv
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7Y-0002LX-T1
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:02 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:51540)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7W-0002K6-S0
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:00 -0400
Received: by mail-wm1-x343.google.com with SMTP id 7so4037925wme.1
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YiY1S+jBU4K+H4DP3GSn5UtNtVLHfTSyLgESh8MXV28=;
 b=ecS4Wcp0UbmnZiXwvPcoYVZvYu4tk3W01yIyxKhpa6eLqanQCDTtpF/7kR1Y7FnWIg
 bDxmKAh1R6X7g2VjwR2clVFZFll+7F9KSEoNm4Q9waF79Q7XLfvaCL5H1lhsrzdXKI7t
 IVi7puAYdpqz+9KxD/tm4knhRmw8r+ARa+xEhUTz0oAB6nNqDQJlTCos3oIm+QbSrLjF
 cRdH62Uf8skDs3NLZjmEpvsmcswfbqPQiT4exo84qE3Mp/hijJEl+ntJ3s9LQeJ1UICa
 UtUpkJfaS6/yLFgTz7Eap7WXro7Ehe1LZPCrwqa7bEachhCuCdFO7YnmceH6MnUYQ6Gf
 hypQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YiY1S+jBU4K+H4DP3GSn5UtNtVLHfTSyLgESh8MXV28=;
 b=SmYP76xe9AOfji1CnFnCSoRcm5342t4mIGmjflR6AF5dKRlrnWVkfz+yX+ZytJo1cV
 y61L9IUSwSKGCOvOwCoFzhTCftsX8kJKvIlueEUlXkuHTOVPJQ7Z9vxyznP4zxOWvOD3
 9wBrNCNMrd94yKdW/5lYuz5291jV3B2orZU05p3NyMBiH4xQaTexrYKsJ/EuvRp1UN/j
 7sr2TxqTfyg72ddo+s10hFA8M7WI+rNzNpBNPayGc/jUj5BzIlMYgV+iCROaw4w7TsTe
 19gbMdwkApUMbFlIm4U47duKj4EgTLiSHfrj2bgQVQ6yDGpkJ5aqPd41sYCO0m31j4co
 vxcQ==
X-Gm-Message-State: APjAAAUe1Cht2DMZh1HVqmbxeeM4AZ2MBwT3GgBONssTs0+dglLgNjR7
 2E3X+GhkbPAN5DJxAJe7dNXd1A==
X-Google-Smtp-Source: APXvYqwNvPtBKi8yl8ZFKOHOcrB2o4U/2n7DMv3aQWbbiaE0VcH+gfEnlRs/3rkwVXOp3gJDU+Dqpw==
X-Received: by 2002:a7b:c3cf:: with SMTP id t15mr4494880wmj.85.1570555077751; 
 Tue, 08 Oct 2019 10:17:57 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.17.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:17:57 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 11/21] hw/timer/exynos4210_mct.c: Switch GFRC to
 transaction-based ptimer API
Date: Tue,  8 Oct 2019 18:17:30 +0100
Message-Id: <20191008171740.9679-12-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191008171740.9679-1-peter.maydell@linaro.org>
References: <20191008171740.9679-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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

We want to switch the exynos MCT code away from bottom-half based ptimers to
the new transaction-based ptimer API. The MCT is complicated
and uses multiple different ptimers, so it's clearer to switch
it a piece at a time. Here we change over only the GFRC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/exynos4210_mct.c | 48 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 45 insertions(+), 3 deletions(-)

diff --git a/hw/timer/exynos4210_mct.c b/hw/timer/exynos4210_mct.c
index 9f2e8dd0a42..fcf91c75cc5 100644
--- a/hw/timer/exynos4210_mct.c
+++ b/hw/timer/exynos4210_mct.c
@@ -364,6 +364,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s);
 
 /*
  * Set counter of FRC global timer.
+ * Must be called within exynos4210_gfrc_tx_begin/commit block.
  */
 static void exynos4210_gfrc_set_count(Exynos4210MCTGT *s, uint64_t count)
 {
@@ -385,6 +386,7 @@ static uint64_t exynos4210_gfrc_get_count(Exynos4210MCTGT *s)
 
 /*
  * Stop global FRC timer
+ * Must be called within exynos4210_gfrc_tx_begin/commit block.
  */
 static void exynos4210_gfrc_stop(Exynos4210MCTGT *s)
 {
@@ -395,6 +397,7 @@ static void exynos4210_gfrc_stop(Exynos4210MCTGT *s)
 
 /*
  * Start global FRC timer
+ * Must be called within exynos4210_gfrc_tx_begin/commit block.
  */
 static void exynos4210_gfrc_start(Exynos4210MCTGT *s)
 {
@@ -403,6 +406,21 @@ static void exynos4210_gfrc_start(Exynos4210MCTGT *s)
     ptimer_run(s->ptimer_frc, 1);
 }
 
+/*
+ * Start ptimer transaction for global FRC timer; this is just for
+ * consistency with the way we wrap operations like stop and run.
+ */
+static void exynos4210_gfrc_tx_begin(Exynos4210MCTGT *s)
+{
+    ptimer_transaction_begin(s->ptimer_frc);
+}
+
+/* Commit ptimer transaction for global FRC timer. */
+static void exynos4210_gfrc_tx_commit(Exynos4210MCTGT *s)
+{
+    ptimer_transaction_commit(s->ptimer_frc);
+}
+
 /*
  * Find next nearest Comparator. If current Comparator value equals to other
  * Comparator value, skip them both
@@ -492,6 +510,7 @@ static uint64_t exynos4210_gcomp_get_distance(Exynos4210MCTState *s, int32_t id)
 
 /*
  * Restart global FRC timer
+ * Must be called within exynos4210_gfrc_tx_begin/commit block.
  */
 static void exynos4210_gfrc_restart(Exynos4210MCTState *s)
 {
@@ -933,6 +952,19 @@ static void exynos4210_ltick_event(void *opaque)
     exynos4210_ltick_int_start(&s->tick_timer);
 }
 
+static void tx_ptimer_set_freq(ptimer_state *s, uint32_t freq)
+{
+    /*
+     * callers of exynos4210_mct_update_freq() never do anything
+     * else that needs to be in the same ptimer transaction, so
+     * to avoid a lot of repetition we have a convenience function
+     * for begin/set_freq/commit.
+     */
+    ptimer_transaction_begin(s);
+    ptimer_set_freq(s, freq);
+    ptimer_transaction_commit(s);
+}
+
 /* update timer frequency */
 static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
 {
@@ -945,7 +977,7 @@ static void exynos4210_mct_update_freq(Exynos4210MCTState *s)
         DPRINTF("freq=%dHz\n", s->freq);
 
         /* global timer */
-        ptimer_set_freq(s->g_timer.ptimer_frc, s->freq);
+        tx_ptimer_set_freq(s->g_timer.ptimer_frc, s->freq);
 
         /* local timer */
         ptimer_set_freq(s->l_timer[0].tick_timer.ptimer_tick, s->freq);
@@ -965,7 +997,9 @@ static void exynos4210_mct_reset(DeviceState *d)
 
     /* global timer */
     memset(&s->g_timer.reg, 0, sizeof(s->g_timer.reg));
+    exynos4210_gfrc_tx_begin(&s->g_timer);
     exynos4210_gfrc_stop(&s->g_timer);
+    exynos4210_gfrc_tx_commit(&s->g_timer);
 
     /* local timer */
     memset(s->l_timer[0].reg.cnt, 0, sizeof(s->l_timer[0].reg.cnt));
@@ -1144,7 +1178,9 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
         }
 
         s->g_timer.reg.cnt = new_frc;
+        exynos4210_gfrc_tx_begin(&s->g_timer);
         exynos4210_gfrc_restart(s);
+        exynos4210_gfrc_tx_commit(&s->g_timer);
         break;
 
     case G_CNT_WSTAT:
@@ -1168,7 +1204,9 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
             s->g_timer.reg.wstat |= G_WSTAT_COMP_L(index);
         }
 
+        exynos4210_gfrc_tx_begin(&s->g_timer);
         exynos4210_gfrc_restart(s);
+        exynos4210_gfrc_tx_commit(&s->g_timer);
         break;
 
     case G_TCON:
@@ -1178,6 +1216,8 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
 
         DPRINTF("global timer write to reg.g_tcon %llx\n", value);
 
+        exynos4210_gfrc_tx_begin(&s->g_timer);
+
         /* Start FRC if transition from disabled to enabled */
         if ((value & G_TCON_TIMER_ENABLE) > (old_val &
                 G_TCON_TIMER_ENABLE)) {
@@ -1195,6 +1235,8 @@ static void exynos4210_mct_write(void *opaque, hwaddr offset,
                 exynos4210_gfrc_restart(s);
             }
         }
+
+        exynos4210_gfrc_tx_commit(&s->g_timer);
         break;
 
     case G_INT_CSTAT:
@@ -1428,8 +1470,8 @@ static void exynos4210_mct_init(Object *obj)
     QEMUBH *bh[2];
 
     /* Global timer */
-    bh[0] = qemu_bh_new(exynos4210_gfrc_event, s);
-    s->g_timer.ptimer_frc = ptimer_init_with_bh(bh[0], PTIMER_POLICY_DEFAULT);
+    s->g_timer.ptimer_frc = ptimer_init(exynos4210_gfrc_event, s,
+                                        PTIMER_POLICY_DEFAULT);
     memset(&s->g_timer.reg, 0, sizeof(struct gregs));
 
     /* Local timers */
-- 
2.20.1


