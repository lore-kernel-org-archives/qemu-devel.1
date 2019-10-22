Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E13CECA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:37:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6FBC2064B
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:37:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RPmklUmD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6FBC2064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57450 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuLg-00009L-I2
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:37:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36625)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGS-0002I4-Bx
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGR-0001BG-4j
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:56 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:41516)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGQ-0001Aw-Uk
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:31:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id p4so18096654wrm.8
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:31:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=JUEy3Kpo6e4fixjUzNZTRmi2uqnm25sL1IZPSuv+MZM=;
 b=RPmklUmDm/FKCimO6Ua1GQtUPMmyPwHDrSwHE9dW5foijSqFPwq8CZ7nS/kLB1KIcF
 1V9uKijjPWP1mSCwnQhZQh9SvEoRehLrqeTSSlBT/DwwM/sR8oo2IKl6piRGW0HowC4E
 jYAQn5Vw1jkvp8DrxKgN3WjfUvhoVDq/SyVh2cLGVbxq7uSIgul0zMybFB2ocgOtKoeT
 7x2wvEv8SZFnGldBBqNXhvD5+XhY5itOiw4rUsU5z4BgzR3HZ2GzgjAo4RQEVGzyeSBj
 7ESR9S6h41/jLT+R3CNugFG3LoDoBsmGZ2qL45tbGrTZt2SoMkUt3tvQdoAm2VWGg4cI
 oh3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=JUEy3Kpo6e4fixjUzNZTRmi2uqnm25sL1IZPSuv+MZM=;
 b=jdHDpl3f6zJevGHcDxNb2zoCF47mO+jAC4QWPWiXM8qDfRtsymdISS2GBmQ5aOVLTH
 e4kF/LjFwUhxnsRfYdHMCxpN6txN/U+GCnV6tS/J1yhVD5E2094kvRdcgsBmBQFvsOeV
 vQNUmLbecni3GcJb5mztEBeXmKhw3mNblvAMhQsdnqN78X5/5epKJ6XDQA9b/3auchq8
 fAXAprP31UmFtErL7nPbBWfv+pAQ5JtDYQzlR+FLGv4vslq3FSbjEIptSBX97kNK8aea
 MpMAptIpwJHQtK5+WCygulLHIHdqxViUb39uFYXPLf0M9sFl7PFeWjfc0outL82fHGVW
 ZoMw==
X-Gm-Message-State: APjAAAUeI2NUouHk9ktx834I++9NHfCX6Z6ZoljLYD8iMEMD9idIh08v
 X+WrMxPjaV+xjikp4sU00yrl7nFVr98=
X-Google-Smtp-Source: APXvYqxXWZDjGo/YdLHMAwdR98FfSIhL8a3oNsim/wN+aEoooGLpsNDt/tr5tuREAkOyjQfIjypBKA==
X-Received: by 2002:a5d:6787:: with SMTP id v7mr3697002wru.392.1571751112471; 
 Tue, 22 Oct 2019 06:31:52 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.31.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:31:50 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 05/41] hw/timer/puv3_ost.c: Switch to transaction-based ptimer
 API
Date: Tue, 22 Oct 2019 14:30:58 +0100
Message-Id: <20191022133134.14487-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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

Switch the puv3_ost code away from bottom-half based ptimers to the
new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20191017132905.5604-2-peter.maydell@linaro.org
---
 hw/timer/puv3_ost.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/timer/puv3_ost.c b/hw/timer/puv3_ost.c
index 0898da5ce97..697519593bb 100644
--- a/hw/timer/puv3_ost.c
+++ b/hw/timer/puv3_ost.c
@@ -13,7 +13,6 @@
 #include "hw/sysbus.h"
 #include "hw/irq.h"
 #include "hw/ptimer.h"
-#include "qemu/main-loop.h"
 #include "qemu/module.h"
 
 #undef DEBUG_PUV3
@@ -27,7 +26,6 @@ typedef struct PUV3OSTState {
     SysBusDevice parent_obj;
 
     MemoryRegion iomem;
-    QEMUBH *bh;
     qemu_irq irq;
     ptimer_state *ptimer;
 
@@ -68,6 +66,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
     DPRINTF("offset 0x%x, value 0x%x\n", offset, value);
     switch (offset) {
     case 0x00: /* Match Register 0 */
+        ptimer_transaction_begin(s->ptimer);
         s->reg_OSMR0 = value;
         if (s->reg_OSMR0 > s->reg_OSCR) {
             ptimer_set_count(s->ptimer, s->reg_OSMR0 - s->reg_OSCR);
@@ -76,6 +75,7 @@ static void puv3_ost_write(void *opaque, hwaddr offset,
                     (0xffffffff - s->reg_OSCR));
         }
         ptimer_run(s->ptimer, 2);
+        ptimer_transaction_commit(s->ptimer);
         break;
     case 0x14: /* Status Register */
         assert(value == 0);
@@ -128,9 +128,10 @@ static void puv3_ost_realize(DeviceState *dev, Error **errp)
 
     sysbus_init_irq(sbd, &s->irq);
 
-    s->bh = qemu_bh_new(puv3_ost_tick, s);
-    s->ptimer = ptimer_init_with_bh(s->bh, PTIMER_POLICY_DEFAULT);
+    s->ptimer = ptimer_init(puv3_ost_tick, s, PTIMER_POLICY_DEFAULT);
+    ptimer_transaction_begin(s->ptimer);
     ptimer_set_freq(s->ptimer, 50 * 1000 * 1000);
+    ptimer_transaction_commit(s->ptimer);
 
     memory_region_init_io(&s->iomem, OBJECT(s), &puv3_ost_ops, s, "puv3_ost",
             PUV3_REGS_OFFSET);
-- 
2.20.1


