Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3706EC4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 004D620663
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:38:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Oey6RFtF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 004D620663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3Mg-0005O8-Nl
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36928)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q1-00047i-Pt
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2q0-0007NL-5y
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:49 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431]:34722)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2pz-0007MO-VW
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:04:48 -0400
Received: by mail-wr1-x431.google.com with SMTP id j11so20404588wrp.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=jAF6ZWfldn5/rZTsepRanmp6npkmWuRVFTomDvB6zXk=;
 b=Oey6RFtF1vGMOFR475kY0RlBieEGnYM9bWbVRKkaXyMv2OpzNBttxNITHy5doifK2z
 LeYWJPFZbrSmUAeBIkXQYvXMEARGbeUsPZYyq3Lu7hba/ZDNC6V7LNcrCbRhBcV71j4x
 hkaYlTVtaeD46amfEAdQlzo9IddGRmy+ygpamsSaNeKCz5Qm7Iiww82ggg3qC/PLQSMO
 9UPcCfO87M3BevUk4MrqnUPXMr7Nhja/s5hdnp1NLlF9yndBh24CBdaudR31lPda+CzZ
 Vh+qD7zxxQQ13ezketa6sxd5J1bvzDR27rU0T7bdvoaoLbzze/isyizzJ18YBKGun1nE
 CkCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jAF6ZWfldn5/rZTsepRanmp6npkmWuRVFTomDvB6zXk=;
 b=rZXXcwhXhDxjkABstqBEAKj8vmxKeqEcvpr0znaSFeFdt4HVZqAoxP2LzqN+cs/njK
 zKdURmsQLvoFaklXvP6vT+8bUHF88w1/d7EaGv95eIizQ060kLUqmknoIxV6nQsDm8V/
 WiYHFJRLNkRNAOq54H9l/Bp5Z9hxdrausirhzlzqCj8bMVdhJ8cVnYcb+0zO+6gSFh7O
 4bnQsZ6BpgCalC6dnk6Tu0rxNmcPvyWwGaVLcy0CIsuu0z+rW3I5nk9ps5JC9RbubWdJ
 zanDa0L7CzBAdiL8VCzlmKz6yRVIKN9bYZ6m7ngoulh+icIjlAZvQYwF6w6SS+iEtZXb
 6Fxw==
X-Gm-Message-State: APjAAAV2wekLvs91wvsWJGYd0GgtxufJJ5/K1Qh8yYrQF0RIXgI1vSh1
 4xZuk0ECxcAzg703gsg3+m0LObFHDqv1Eg==
X-Google-Smtp-Source: APXvYqzngEPBdf6PmMaSnqmKBuJRHrFriMu3S2q9HVcu4MuI7fV1YCVX2iKZ3vBfGvkfsrzrtZAPZg==
X-Received: by 2002:a5d:540d:: with SMTP id g13mr22580481wrv.8.1571069086489; 
 Mon, 14 Oct 2019 09:04:46 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.04.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:04:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 20/68] hw/timer/imx_epit.c: Switch to transaction-based ptimer
 API
Date: Mon, 14 Oct 2019 17:03:16 +0100
Message-Id: <20191014160404.19553-21-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::431
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

Switch the imx_epit.c code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20191008171740.9679-18-peter.maydell@linaro.org
---
 hw/timer/imx_epit.c | 32 +++++++++++++++++++++++++++-----
 1 file changed, 27 insertions(+), 5 deletions(-)

diff --git a/hw/timer/imx_epit.c b/hw/timer/imx_epit.c
index 39810ac8b03..baf6338e1a6 100644
--- a/hw/timer/imx_epit.c
+++ b/hw/timer/imx_epit.c
@@ -17,7 +17,6 @@
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/misc/imx_ccm.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 #include "qemu/log.h"
 
@@ -74,6 +73,10 @@ static void imx_epit_update_int(IMXEPITState *s)
     }
 }
 
+/*
+ * Must be called from within a ptimer_transaction_begin/commit block
+ * for both s->timer_cmp and s->timer_reload.
+ */
 static void imx_epit_set_freq(IMXEPITState *s)
 {
     uint32_t clksrc;
@@ -105,6 +108,8 @@ static void imx_epit_reset(DeviceState *dev)
     s->lr = EPIT_TIMER_MAX;
     s->cmp = 0;
     s->cnt = 0;
+    ptimer_transaction_begin(s->timer_cmp);
+    ptimer_transaction_begin(s->timer_reload);
     /* stop both timers */
     ptimer_stop(s->timer_cmp);
     ptimer_stop(s->timer_reload);
@@ -117,6 +122,8 @@ static void imx_epit_reset(DeviceState *dev)
         /* if the timer is still enabled, restart it */
         ptimer_run(s->timer_reload, 0);
     }
+    ptimer_transaction_commit(s->timer_cmp);
+    ptimer_transaction_commit(s->timer_reload);
 }
 
 static uint32_t imx_epit_update_count(IMXEPITState *s)
@@ -164,6 +171,7 @@ static uint64_t imx_epit_read(void *opaque, hwaddr offset, unsigned size)
     return reg_value;
 }
 
+/* Must be called from ptimer_transaction_begin/commit block for s->timer_cmp */
 static void imx_epit_reload_compare_timer(IMXEPITState *s)
 {
     if ((s->cr & (CR_EN | CR_OCIEN)) == (CR_EN | CR_OCIEN))  {
@@ -191,6 +199,8 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
 
     switch (offset >> 2) {
     case 0: /* CR */
+        ptimer_transaction_begin(s->timer_cmp);
+        ptimer_transaction_begin(s->timer_reload);
 
         oldcr = s->cr;
         s->cr = value & 0x03ffffff;
@@ -231,6 +241,9 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
         } else {
             ptimer_stop(s->timer_cmp);
         }
+
+        ptimer_transaction_commit(s->timer_cmp);
+        ptimer_transaction_commit(s->timer_reload);
         break;
 
     case 1: /* SR - ACK*/
@@ -244,6 +257,8 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
     case 2: /* LR - set ticks */
         s->lr = value;
 
+        ptimer_transaction_begin(s->timer_cmp);
+        ptimer_transaction_begin(s->timer_reload);
         if (s->cr & CR_RLD) {
             /* Also set the limit if the LRD bit is set */
             /* If IOVW bit is set then set the timer value */
@@ -255,12 +270,16 @@ static void imx_epit_write(void *opaque, hwaddr offset, uint64_t value,
         }
 
         imx_epit_reload_compare_timer(s);
+        ptimer_transaction_commit(s->timer_cmp);
+        ptimer_transaction_commit(s->timer_reload);
         break;
 
     case 3: /* CMP */
         s->cmp = value;
 
+        ptimer_transaction_begin(s->timer_cmp);
         imx_epit_reload_compare_timer(s);
+        ptimer_transaction_commit(s->timer_cmp);
 
         break;
 
@@ -281,6 +300,11 @@ static void imx_epit_cmp(void *opaque)
     imx_epit_update_int(s);
 }
 
+static void imx_epit_reload(void *opaque)
+{
+    /* No action required on rollover of timer_reload */
+}
+
 static const MemoryRegionOps imx_epit_ops = {
     .read = imx_epit_read,
     .write = imx_epit_write,
@@ -308,7 +332,6 @@ static void imx_epit_realize(DeviceState *dev, Error **errp)
 {
     IMXEPITState *s = IMX_EPIT(dev);
     SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
-    QEMUBH *bh;
 
     DPRINTF("\n");
 
@@ -317,10 +340,9 @@ static void imx_epit_realize(DeviceState *dev, Error **errp)
                           0x00001000);
     sysbus_init_mmio(sbd, &s->iomem);
 
-    s->timer_reload = ptimer_init_with_bh(NULL, PTIMER_POLICY_DEFAULT);
+    s->timer_reload = ptimer_init(imx_epit_reload, s, PTIMER_POLICY_DEFAULT);
 
-    bh = qemu_bh_new(imx_epit_cmp, s);
-    s->timer_cmp = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer_cmp = ptimer_init(imx_epit_cmp, s, PTIMER_POLICY_DEFAULT);
 }
 
 static void imx_epit_class_init(ObjectClass *klass, void *data)
-- 
2.20.1


