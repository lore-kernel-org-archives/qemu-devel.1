Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A79DFA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CBB2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 13:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sm1p9J+U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CBB2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL63x-0007GQ-5i
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 09:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34919)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5ib-0004z3-0s
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5iZ-0000Mj-R5
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:28 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5iZ-0000M0-Kh
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:21:27 -0400
Received: by mail-wm1-x343.google.com with SMTP id r19so2561941wmh.2
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=We+bFOtG4HDLIryRINVpil47T9Rtk94/5StL1YZ+S34=;
 b=sm1p9J+UWdsFztZfvPafIqHp2g6sBQ3CVtW5d4OPtsJq308+fAxTstwTvA4uuqnsLC
 aQ1LmsWEwBfrG3VMCwn2/thu2B6190edOQFAB1sVWUBsjGo2asNeHPFx0EFCwq8Ney4g
 XGoDtiR6bfs0rNWHJXcV/vJukRmlgq2NSKyZMH/8z/V1Ph8G4V+maAwPDniB+iDivv1k
 LpuXMKskq/LnWcxPWQ4TXS1/UzOQtXTduyWlNX3EPADLkS/NWaB0pp7So4Mt1DlIxw2C
 +QZBdTlZeDo7oKeB48B/jXV46K3tJ34qx9I4FprX2Zrfqa/i5RBaEybb3hnRtE/pZqOP
 Pggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=We+bFOtG4HDLIryRINVpil47T9Rtk94/5StL1YZ+S34=;
 b=Xvf4AvdvBaUlvFuljEla3NLzUWqMV7jUhwIWaNQ6NVRdR5a/suFNqiuxYWZ806ovRx
 9EqTBDVQyIy7Ow4yGpt5nZHqqtPqpj5YHTXcLTjBLPByZa2yOZBdoHK30gyoaKvgX9Vm
 Pg680cNkKIm3qA8+eQS4LsKFK97VaGoY5dVd98NEVN1B5/gNkgXiELStp1pyXzMP90W6
 wmuEa4bne/lnQNnpko5aNLRT+PlMM3aJwyjYlSVu5U6mo0x8LfHO2BK9UOlhv+qFla1B
 V4i1mhMVhrZWKjJxBZ/te7pZ0kaPqskDNL17kKcGFNSiMr4xEhAvYLlZEQpE22qicgNR
 0J9Q==
X-Gm-Message-State: APjAAAXk52MrqoqNNomh/AHBDnz1vR+OXa6MZj9sa90+vI7Rn0bf7dlw
 lsu/X+ajpQSsUKfw9v4SHz3KISse3KsQbQ==
X-Google-Smtp-Source: APXvYqwEI0440tYtGdgGBI9YcKj1Qvj1PCUIVxCQpQ6XRG5iY3PFrVJZcSx5cEIA4veWpBJDnPenYw==
X-Received: by 2002:a7b:c3d2:: with SMTP id t18mr3069113wmj.66.1571318486414; 
 Thu, 17 Oct 2019 06:21:26 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id e9sm11543164wme.3.2019.10.17.06.21.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:21:25 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/3] hw/net/fsl_etsec/etsec.c: Switch to transaction-based
 ptimer API
Date: Thu, 17 Oct 2019 14:21:20 +0100
Message-Id: <20191017132122.4402-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132122.4402-1-peter.maydell@linaro.org>
References: <20191017132122.4402-1-peter.maydell@linaro.org>
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
Cc: Jason Wang <jasowang@redhat.com>, Alistair Francis <alistair@alistair23.me>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the fsl_etsec code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/net/fsl_etsec/etsec.h | 1 -
 hw/net/fsl_etsec/etsec.c | 9 +++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/hw/net/fsl_etsec/etsec.h b/hw/net/fsl_etsec/etsec.h
index 09d05c21338..7951c3ad65f 100644
--- a/hw/net/fsl_etsec/etsec.h
+++ b/hw/net/fsl_etsec/etsec.h
@@ -141,7 +141,6 @@ typedef struct eTSEC {
     uint16_t phy_control;
 
     /* Polling */
-    QEMUBH *bh;
     struct ptimer_state *ptimer;
 
     /* Whether we should flush the rx queue when buffer becomes available. */
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index d9b3e8c691e..717de76569a 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -34,7 +34,6 @@
 #include "etsec.h"
 #include "registers.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 /* #define HEX_DUMP */
@@ -195,9 +194,11 @@ static void write_dmactrl(eTSEC          *etsec,
 
     if (!(value & DMACTRL_WOP)) {
         /* Start polling */
+        ptimer_transaction_begin(etsec->ptimer);
         ptimer_stop(etsec->ptimer);
         ptimer_set_count(etsec->ptimer, 1);
         ptimer_run(etsec->ptimer, 1);
+        ptimer_transaction_commit(etsec->ptimer);
     }
 }
 
@@ -391,10 +392,10 @@ static void etsec_realize(DeviceState *dev, Error **errp)
                               object_get_typename(OBJECT(dev)), dev->id, etsec);
     qemu_format_nic_info_str(qemu_get_queue(etsec->nic), etsec->conf.macaddr.a);
 
-
-    etsec->bh     = qemu_bh_new(etsec_timer_hit, etsec);
-    etsec->ptimer = ptimer_init_with_bh(etsec->bh, PTIMER_POLICY_DEFAULT);
+    etsec->ptimer = ptimer_init(etsec_timer_hit, etsec, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(etsec->ptimer);
     ptimer_set_freq(etsec->ptimer, 100);
+    ptimer_transaction_commit(etsec->ptimer);
 }
 
 static void etsec_instance_init(Object *obj)
-- 
2.20.1


