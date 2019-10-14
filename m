Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30D3C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8E18E217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:28:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JeKjaw9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8E18E217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53264 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Cc-0000Hp-54
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:28:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36843)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pw-0003xg-0d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2pq-0007CG-OJ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:43 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e]:54046)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pq-0007AR-I5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:38 -0400
Received: by mail-wm1-x32e.google.com with SMTP id i16so17853342wmd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jTmeC9fsNiMpPjbvhf5TS5+W4xCHxtvz7UPSHxJb4Z4=;
 b=JeKjaw9+M/YsItBnjcbCAp/pV/wuARXfNGr6Mkbf4CWjFxT4RKEoW2me5k6ADPjy2O
 F75BuuMaPsHMB/y3bMIIxtdmp8UwUg/4kuB93k5pmpKzF5qqW8gvfWPMCrLrZpLougbD
 Yo0wZ9jChJYAiQI/itKGmKSyVhKNQElXFV1zZRRqoyorZ2PA147zT02OLel9qRuidBxu
 +YfxLpI+Ha/NYKAY6aiEbHD1C6PTeGQMhL2calGh1XM7gnLsZv9LXwV/q3LjlhiEMKY/
 9A4u/q07l4ZLxwAVNniSXluycp/9leO+933jSR6Vl7+WeigExWHhcvgC0lckvmossWq2
 MLjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jTmeC9fsNiMpPjbvhf5TS5+W4xCHxtvz7UPSHxJb4Z4=;
 b=eyrLtk2MyrhyfsLkbaDPPSirBgqUL7s0RZggCIQ/GrYv6hJkwsShvOL5uNpiJc5jtf
 vt5lgr8LEofSaRAMZ7ZSsP+q5UjIfKFAwMPqHNB8wPv7n/pMQkma10reDhP1bQZZEmhe
 ZtuYMrAb4HIHeaVMkXoPqqAx+Rdio6doQcogqBEr6fOTHD/s5YY+jeH7o9uwu35iZlDi
 5j0k+SQbrjMvdApDogMaOAf/tTOtyQGWbQK31fm8SnSfy1ivIjXgjO6KejUxfhPKtCwU
 547TgxrdhRMVEmiFDJ+nUpwhgGFwtGVrAjzRvCIRwm3J0pmfJ4BxWIh0yHKywh412NlZ
 a4Rw==
X-Gm-Message-State: APjAAAVleNl5xAD6wh1Dgf0LuZYW7fEDVtPgwh0bl7eaIahrEC8IV3cc
 zugGC3v0hQvInBgiECFv/qjyp911C20GfQ==
X-Google-Smtp-Source: APXvYqwEpaTu7D4Zdp+DkMEWKLoz72F0rSaMEcKtrd9lpu2cuqUQLE+Fj/UkJzy5V0iMKs+2e8nX7Q==
X-Received: by 2002:a7b:c006:: with SMTP id c6mr16047082wmb.45.1571069077039; 
 Mon, 14 Oct 2019 09:04:37 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.35
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:36 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/68] hw/timer/exynos4210_mct.c: Switch GFRC to
 transaction-based ptimer API
Date: Mon, 14 Oct 2019 17:03:10 +0100
Message-Id: <20191014160404.19553-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32e
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

We want to switch the exynos MCT code away from bottom-half based ptimers to
the new transaction-based ptimer API. The MCT is complicated
and uses multiple different ptimers, so it's clearer to switch
it a piece at a time. Here we change over only the GFRC.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-12-peter.maydell@linaro.org
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


