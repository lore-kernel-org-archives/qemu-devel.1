Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FA4FC4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:36:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 38D542070B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:36:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Csx+4V13"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 38D542070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHtPl-0006zN-DH
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:36:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7g-0006qG-47
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iHt7e-0002PX-7e
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:07 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40683)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iHt7d-0002PA-VU
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:18:06 -0400
Received: by mail-wm1-x344.google.com with SMTP id b24so3925283wmj.5
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:18:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IKaS8RTHBXtjU4umm9TxJgozBl5pnbt1z64JULe41fo=;
 b=Csx+4V13gC3qgDV0eLlT1+8TisjHqgVTeDPEunDMr3qWRh8glQcAJirAXo1X+x7f7z
 cpTFMeqhvWwonHa4xWTNFzNghuFVIgra+5m9MyEvIgJRmQF0AbpKHfPCinAao9F2X8lO
 G0f0u3bsukY0VwBRL6tFA74VHqgcwb5d8nMlmqsf7kA6PMgpZ8Ms5SCKARzAfz6gk2Nk
 MlpLKg7I9Klo5FXiJ60DR4NWMl7OUXwBlLv8avu5mjuWC1jH+EpkAy6r/8fEIX94jIAH
 m+TkvCbK8GrKQjoFu0ARnagwxZTigqZW6emqz5++4AYj9Y7aUbSe+HBFBb8jKxFyrsJn
 4ZgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IKaS8RTHBXtjU4umm9TxJgozBl5pnbt1z64JULe41fo=;
 b=JiOfzKeYIgXIeHlm9MvflVMbGcu3OPOIAvdYKSfJxTqU/KL6GOzDOA3oClIC+0UxNT
 gsLGjZhWPFFIbPQqANgyWGYR5KUYh1hnpwi8zXWjAsEFkAoOWh7Cw2O6e9WODt/RbzAm
 A8uG94zXDdC9rBfrq/URWLYnxeUoTreG5oGDf0VS4ZXShnnXIVENOG3zeEktj+3dAfWf
 rZvx5hyZVcW7ndk1/0hr9n+dMA5tan1lW6tfDojjdII3/YM+3NSkd/rZdGBFpQWEZXXO
 zfzYyet8CsEIR507ydjJiafl6UeKbtE0TehHMyikRk2ffY8xG7JeDUiCPJFGQXCmn53V
 m4AQ==
X-Gm-Message-State: APjAAAW61pGPRkWN0VT7Jl2GvvMeq7TRqNXhu670EUzoK4JGchErxkQj
 1wWdayQx0+szttNTEtwDZt8LDw==
X-Google-Smtp-Source: APXvYqzDY0CNWKdQ+bPOoT5M6JXegvoHXdiDp+oLrTgLxO5mE1g5EuZxRcnbH6AMEN4rmIhIeilX6w==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr4976166wmk.25.1570555084986; 
 Tue, 08 Oct 2019 10:18:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id z9sm19135541wrl.35.2019.10.08.10.18.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:18:04 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH v2 17/21] hw/timer/imx_epit.c: Switch to transaction-based
 ptimer API
Date: Tue,  8 Oct 2019 18:17:36 +0100
Message-Id: <20191008171740.9679-18-peter.maydell@linaro.org>
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

Switch the imx_epit.c code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
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


