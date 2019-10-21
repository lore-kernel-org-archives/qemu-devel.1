Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E54CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:07:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB6122053B
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 14:07:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NDxWbbgP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB6122053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42830 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMYLP-00043u-PS
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 10:07:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44895)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMYK1-0002Ng-GC
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:06:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMYJw-0002k7-J0
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:06:09 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36335)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMYJw-0002jo-Cy
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 10:06:04 -0400
Received: by mail-wm1-x343.google.com with SMTP id c22so3841453wmd.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 07:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fqGnGtGXPzSspGHHfg6dHLcHdySYDwMWUaEctU2c4eU=;
 b=NDxWbbgPwYzIm4F5xDtNoQ5jloOfsPpqDHZh1O+k259lq0o0WxnwYRpyK8fPRcqCjn
 IS+cEi+sEv2dt+YNjKTKtnRki82mbMsWEsyz66zwRP9DWILxpvSu5bx1AzFaHeH6ydbJ
 myQaJ6cygiA5arB6JdDOcEEvAqMwvfmIjC3GoUUFDYVtba94ozTEC+wTnPwjrdycmTr9
 uA/PQ5KDWlqL+MhBNxl4yY+15UPG33v7Qf6YuIf6Im8GQVZBKhbFVcRp9m+X76OxkLLl
 QsZ9z1zIMEadyWo6Is8TDe7F1nulGj5Z7032UEm/QW77cxmSaqB25yLqkrednwbZnoPu
 LMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=fqGnGtGXPzSspGHHfg6dHLcHdySYDwMWUaEctU2c4eU=;
 b=BuDnG7+gKDMH9cw3FvMvI74W0DdlfT2aMrNiJNZ3SILwaTBwFRMr+7TFiwyrVoUJSt
 Ns2tQgqLD14wxvvWoIrei+tzH8TF/wGVx9QUdjQm8K9AwlOXt1ObFixCVlCW9IY8ZSXD
 3IG17DYMC+hUEUrBBbEYwiPUAIXiwOnTneJGnW8wpc/jJmhgi1yYxPKZ+iHd43ymXThr
 EzXdud2afn9/XonduzgrPxReS/M/TPDY8OtQSzPIWSuSZ23V7xqEScSTNxsj+MKiZmNh
 IalEV26EBFIgXdreGP+3LgkxS2B1UvbrPxH40OQVUc1Tm/q2i4Cl3HopYQ5V+ttY1chp
 6hqA==
X-Gm-Message-State: APjAAAXucWnyLOMYRIs3cpRyv5n5kZWw5Gr082c2fhPNoX4SDN9Y9+3h
 dAfbWy3ZNL608Vr0uA9Bs4s9th0DgJY=
X-Google-Smtp-Source: APXvYqzUsfNzd6US4mhplPBJt6lEei3nkwGeUxlk+0S13njsVx/HPk2aps/dH5eZYKKfjE1RNiK54Q==
X-Received: by 2002:a7b:cf0d:: with SMTP id l13mr18622802wmg.47.1571666762722; 
 Mon, 21 Oct 2019 07:06:02 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id y5sm4673851wmi.10.2019.10.21.07.06.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Oct 2019 07:06:01 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] hw/m68k/mcf5206.c: Switch to transaction-based ptimer API
Date: Mon, 21 Oct 2019 15:06:00 +0100
Message-Id: <20191021140600.10725-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
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
Cc: Thomas Huth <huth@tuxfamily.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Switch the mcf5206 code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
Changes v1->v2:
 * turn the early-exit in m5206_timer_recalibrate() into a goto-exit
   so we can end the ptimer transaction

I'm not resending the whole v1 patchset, since this patch is
independent of the others in the series and I'm planning to
take them through my tree anyway.
---
 hw/m68k/mcf5206.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a49096367cb..b155dd81705 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -57,10 +56,12 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
     int prescale;
     int mode;
 
+    ptimer_transaction_begin(s->timer);
     ptimer_stop(s->timer);
 
-    if ((s->tmr & TMR_RST) == 0)
-        return;
+    if ((s->tmr & TMR_RST) == 0) {
+        goto exit;
+    }
 
     prescale = (s->tmr >> 8) + 1;
     mode = (s->tmr >> 1) & 3;
@@ -78,6 +79,8 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
     ptimer_set_limit(s->timer, s->trr, 0);
 
     ptimer_run(s->timer, 0);
+exit:
+    ptimer_transaction_commit(s->timer);
 }
 
 static void m5206_timer_trigger(void *opaque)
@@ -123,7 +126,9 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
         s->tcr = val;
         break;
     case 0xc:
+        ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, val);
+        ptimer_transaction_commit(s->timer);
         break;
     case 0x11:
         s->ter &= ~val;
@@ -137,11 +142,9 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
 static m5206_timer_state *m5206_timer_init(qemu_irq irq)
 {
     m5206_timer_state *s;
-    QEMUBH *bh;
 
     s = g_new0(m5206_timer_state, 1);
-    bh = qemu_bh_new(m5206_timer_trigger, s);
-    s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+    s->timer = ptimer_init(m5206_timer_trigger, s, PTIMER_POLICY_DEFAULT);
     s->irq = irq;
     m5206_timer_reset(s);
     return s;
-- 
2.20.1


