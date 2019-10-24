Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5088FCA9EBD
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F7D021925
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 17:05:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ObZ5vpZH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F7D021925
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNgXu-0006j4-Eu
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 13:05:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58074)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfy1-0007n9-6h
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iNfxz-0000uI-W5
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:05 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:38091)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iNfxz-0000u0-Pq
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 12:28:03 -0400
Received: by mail-wr1-x441.google.com with SMTP id v9so15524429wrq.5
 for <qemu-devel@nongnu.org>; Thu, 24 Oct 2019 09:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=WzfboK1OQbmWS+2qtK+sgT8HKfmWZJQr5eBbFKdwmAk=;
 b=ObZ5vpZH5jMOI0+is0hPadcaqMnr26G26JDvyQcxOHxwmG15qFm6GWPTy3nrDbxMkY
 FSLXY9bDlNm5G0f7Y8A//tRejZyeEt9Xaw6Qd6dOwkb1eZNVO8/jJpPucwrM1dSnbx2x
 KfPV+mPVMHNSjykh7Zlcts3eiHma9Lb5VZwqjCD/4TEsPelYb60o4gmgJ5OZtfAFDbWt
 IezzWLRTzXpESJmJrLx6U94/Yls/Zvc7Cznm3wMCXXMe8qAtzk+cIwRNyLQGBz58jr/A
 Amfc7QLl7wM9p9f5MY+UHS10pwmH03WShDXyyx2SrlXZ2pcuDtVEDgTWaLgK182CnRu0
 HH3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=WzfboK1OQbmWS+2qtK+sgT8HKfmWZJQr5eBbFKdwmAk=;
 b=A4itcjiIDLWes3/daVFT+J5L/UTgr5JdjAuB9jChQtUYfB042OOAl5p4u3fHii/w9I
 pM3vWYu83ieDP4eaGYVNnKnhLdQ32W0PLvLTtXOwMf4jTk3rgikQ4/BXdOTQzDJjps5N
 3HW3ikbCKSzKGgqmtNuAv7SCeXZla833guaucxBtaGCsPR0VK3wjH7LBOnCOiplRFQWg
 npNjb9uqsfsxLHIbMKFxQdZPY0BF3v4trhNi2L6UKOCbUZXkX+43Cx7vShhyg7aAi5OY
 uFmDgxuMUjP7jMBEQ2OMg1iSAs6vu+wUk60BfWPjhVPGLsLFgdAYOt2EiWDisRvqxisk
 tqyw==
X-Gm-Message-State: APjAAAXQq9MWsCuq0MbK9MM+bkljelSlSqbftHuPJPeWv74OMHthLQPp
 NkEG9dkY1QCY/e05PjiFtfSUF6CLmvo=
X-Google-Smtp-Source: APXvYqwT3Up8IOLkoitfPxxPsYknULgbOQS0O30IeseBO4A3m4lUKnhSx3yLQiqKNoxH2cdrBX9A6w==
X-Received: by 2002:adf:ee4f:: with SMTP id w15mr4817276wro.378.1571934482385; 
 Thu, 24 Oct 2019 09:28:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r27sm42606124wrc.55.2019.10.24.09.28.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Oct 2019 09:28:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 29/51] hw/dma/xilinx_axidma.c: Switch to transaction-based
 ptimer API
Date: Thu, 24 Oct 2019 17:27:02 +0100
Message-Id: <20191024162724.31675-30-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191024162724.31675-1-peter.maydell@linaro.org>
References: <20191024162724.31675-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the xilinx_axidma code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20191017132122.4402-4-peter.maydell@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/dma/xilinx_axidma.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
index e035d1f7504..fb3a978e282 100644
--- a/hw/dma/xilinx_axidma.c
+++ b/hw/dma/xilinx_axidma.c
@@ -31,7 +31,6 @@
 #include "hw/ptimer.h"
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #include "hw/stream.h"
@@ -104,7 +103,6 @@ enum {
 };
 
 struct Stream {
-    QEMUBH *bh;
     ptimer_state *ptimer;
     qemu_irq irq;
 
@@ -242,6 +240,7 @@ static void stream_complete(struct Stream *s)
     unsigned int comp_delay;
 
     /* Start the delayed timer.  */
+    ptimer_transaction_begin(s->ptimer);
     comp_delay = s->regs[R_DMACR] >> 24;
     if (comp_delay) {
         ptimer_stop(s->ptimer);
@@ -255,6 +254,7 @@ static void stream_complete(struct Stream *s)
         s->regs[R_DMASR] |= DMASR_IOC_IRQ;
         stream_reload_complete_cnt(s);
     }
+    ptimer_transaction_commit(s->ptimer);
 }
 
 static void stream_process_mem2s(struct Stream *s, StreamSlave *tx_data_dev,
@@ -551,9 +551,10 @@ static void xilinx_axidma_realize(DeviceState *dev, Error **errp)
         struct Stream *st = &s->streams[i];
 
         st->nr = i;
-        st->bh = qemu_bh_new(timer_hit, st);
-        st->ptimer = ptimer_init_with_bh(st->bh, PTIMER_POLICY_DEFAULT);
+        st->ptimer = ptimer_init(timer_hit, st, PTIMER_POLICY_DEFAULT);
+        ptimer_transaction_begin(st->ptimer);
         ptimer_set_freq(st->ptimer, s->freqhz);
+        ptimer_transaction_commit(st->ptimer);
     }
     return;
 
-- 
2.20.1


