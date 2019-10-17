Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DFBECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9283B2054F
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NHrxN4io"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9283B2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6Se-0003H7-D0
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:09:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36208)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5qB-0006wt-00
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5q9-0002bJ-JY
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:18 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:54154)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5q9-0002b2-DT
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:17 -0400
Received: by mail-wm1-x342.google.com with SMTP id i16so2578195wmd.3
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=2N8pR3XdK7iKpoiyLDAZ/80MgScv3T2YbJfwoAS7T38=;
 b=NHrxN4ioR+UGwIodzrq4Q4bE5jd3WLM9j/tFdWUn7w7jSSGGOhRTIi+KB+M9NfV0TK
 VUX4n4uDJx0gN2RJLqd/f/avEYfmAsfUZUHPf8HV8H02nkkeMQFTDO4w4D8hwLOYLBM1
 PTcMMcetfvPiKah0vYctn5+jt7l+TR07iI4U2JYjtYBq9JG8mNEwrFFfNCXoh6aR1zs6
 LeNvDApEGTJ2pD5oi4B//IDRgQhfmdRQi0fG6O+RG3nA1VEVOjPEMG1U9UX/knowXAoZ
 iq/+EanqLW7Xwz7eH6jmhsVf5uuPGc1Ttd3k+etUG16wLKpUpzkM5gpqzWA3i30UMV+U
 rhsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=2N8pR3XdK7iKpoiyLDAZ/80MgScv3T2YbJfwoAS7T38=;
 b=O4DZzZ9EYmx6zGWD0kA7HM8DcLiGHMfqihF7PRxGDYYVdgHFcol4X+SXLfjOT/lxtk
 3XIo/vDJ13TkpVGlsGCHP4msOSlJE20n7XUs5/mteVDJnMnN1NIlywoy7NTbVC2IPo0p
 pekAPbYROPgR2cgJz9r2c20rLVoE5OeUPDUOS4RH0QY0FqymygO0hw82APedTPA0Oh6N
 t5CqO24nOvwiUKumZW3CQVxSVa38zdJEUkuCnsynWQ3KVpcSJPTgjZz62gaZCK7jFJW1
 sTmSQLu+K73RGK50+H4TuvwYpqtwbbDuyWY58v6ALRGIEGxVG2Q1c4cCmTT1hWjvauIS
 1M9Q==
X-Gm-Message-State: APjAAAUVRItTlHHCgw8PitkK3HKmMT6IDNV/IcV3aqUv3Vg9NEaMccZ9
 OgjPosLLpI9Tkn7oyAbm5rG4W60M90q0ew==
X-Google-Smtp-Source: APXvYqzg1Ju/Mu4oFYfopvv3nG8pPgQyOkVTlx7/vfzrmYOZL208SgGQy3VnEuS2XZqtS8CsYVqqkg==
X-Received: by 2002:a1c:41c1:: with SMTP id o184mr2875500wma.57.1571318956178; 
 Thu, 17 Oct 2019 06:29:16 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n15sm2703392wrw.47.2019.10.17.06.29.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:29:15 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/8] hw/watchdog/etraxfs_timer.c: Switch to transaction-based
 ptimer API
Date: Thu, 17 Oct 2019 14:29:03 +0100
Message-Id: <20191017132905.5604-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132905.5604-1-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Michael Walle <michael@walle.cc>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
 Magnus Damm <magnus.damm@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the etraxfs_timer code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/timer/etraxfs_timer.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/hw/timer/etraxfs_timer.c b/hw/timer/etraxfs_timer.c
index ab27fe1895b..afe3d30a8ea 100644
--- a/hw/timer/etraxfs_timer.c
+++ b/hw/timer/etraxfs_timer.c
@@ -26,7 +26,6 @@
 #include "hw/sysbus.h"
 #include "sysemu/reset.h"
 #include "sysemu/runstate.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/timer.h"
 #include "hw/irq.h"
@@ -59,9 +58,6 @@ typedef struct ETRAXTimerState {
     qemu_irq irq;
     qemu_irq nmi;
 
-    QEMUBH *bh_t0;
-    QEMUBH *bh_t1;
-    QEMUBH *bh_wd;
     ptimer_state *ptimer_t0;
     ptimer_state *ptimer_t1;
     ptimer_state *ptimer_wd;
@@ -155,6 +151,7 @@ static void update_ctrl(ETRAXTimerState *t, int tnum)
     }
 
     D(printf ("freq_hz=%d div=%d\n", freq_hz, div));
+    ptimer_transaction_begin(timer);
     ptimer_set_freq(timer, freq_hz);
     ptimer_set_limit(timer, div, 0);
 
@@ -176,6 +173,7 @@ static void update_ctrl(ETRAXTimerState *t, int tnum)
             abort();
             break;
     }
+    ptimer_transaction_commit(timer);
 }
 
 static void timer_update_irq(ETRAXTimerState *t)
@@ -240,6 +238,7 @@ static inline void timer_watchdog_update(ETRAXTimerState *t, uint32_t value)
 
     t->wd_hits = 0;
 
+    ptimer_transaction_begin(t->ptimer_wd);
     ptimer_set_freq(t->ptimer_wd, 760);
     if (wd_cnt == 0)
         wd_cnt = 256;
@@ -250,6 +249,7 @@ static inline void timer_watchdog_update(ETRAXTimerState *t, uint32_t value)
         ptimer_stop(t->ptimer_wd);
 
     t->rw_wd_ctrl = value;
+    ptimer_transaction_commit(t->ptimer_wd);
 }
 
 static void
@@ -311,9 +311,15 @@ static void etraxfs_timer_reset(void *opaque)
 {
     ETRAXTimerState *t = opaque;
 
+    ptimer_transaction_begin(t->ptimer_t0);
     ptimer_stop(t->ptimer_t0);
+    ptimer_transaction_commit(t->ptimer_t0);
+    ptimer_transaction_begin(t->ptimer_t1);
     ptimer_stop(t->ptimer_t1);
+    ptimer_transaction_commit(t->ptimer_t1);
+    ptimer_transaction_begin(t->ptimer_wd);
     ptimer_stop(t->ptimer_wd);
+    ptimer_transaction_commit(t->ptimer_wd);
     t->rw_wd_ctrl = 0;
     t->r_intr = 0;
     t->rw_intr_mask = 0;
@@ -325,12 +331,9 @@ static void etraxfs_timer_realize(DeviceState *dev, Error **errp)
     ETRAXTimerState *t = ETRAX_TIMER(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
 
-    t->bh_t0 = qemu_bh_new(timer0_hit, t);
-    t->bh_t1 = qemu_bh_new(timer1_hit, t);
-    t->bh_wd = qemu_bh_new(watchdog_hit, t);
-    t->ptimer_t0 = ptimer_init_with_bh(t->bh_t0, PTIMER_POLICY_DEFAULT);
-    t->ptimer_t1 = ptimer_init_with_bh(t->bh_t1, PTIMER_POLICY_DEFAULT);
-    t->ptimer_wd = ptimer_init_with_bh(t->bh_wd, PTIMER_POLICY_DEFAULT);
+    t->ptimer_t0 = ptimer_init(timer0_hit, t, PTIMER_POLICY_DEFAULT);
+    t->ptimer_t1 = ptimer_init(timer1_hit, t, PTIMER_POLICY_DEFAULT);
+    t->ptimer_wd = ptimer_init(watchdog_hit, t, PTIMER_POLICY_DEFAULT);
 
     sysbus_init_irq(sbd, &t->irq);
     sysbus_init_irq(sbd, &t->nmi);
-- 
2.20.1


