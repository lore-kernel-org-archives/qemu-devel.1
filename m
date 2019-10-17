Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A6B2ECE58E
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8D542082C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 14:09:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LTVhSUmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8D542082C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL6TL-0004Nn-Ju
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 10:09:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5qC-0006yj-0y
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iL5qA-0002bf-Rr
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:19 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40220)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iL5qA-0002bR-Lp
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 09:29:18 -0400
Received: by mail-wr1-x444.google.com with SMTP id o28so2360387wro.7
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 06:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=e4PVQeNvPwVNwMTizB+ixtPW1GcJ8H+hxCE9Nf1uwZo=;
 b=LTVhSUmrGS1xl2gvrwdHQT+Vc74+4ZtJZ2uW6PT0tio9svC/AvljbsMEgxUigWt5xo
 hEfOogmKO6LHQHk1b8IusKuQAlPuxgGODuzODc0bmt2fO69+UhUdbTEx7zsUA0Zq04R1
 P+D+TEMxAHp23GA1h7nL/XWbVXWVCvrS0FQjMSFavGnG0a9ga13SuMerFJ6b4IUGIVmh
 iTEu4n/mdWHuKRbzhTbzffXfb75ghkqtmvNV1WdhwP6dNVaDUuFomYmZK/aE2xYB5w78
 767FbU220DPKaeR7PPgSjj343ED5/4mOxbvV9hbE2buZrOA2WMX7e4wE/AO0U3vBUbzs
 8tlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e4PVQeNvPwVNwMTizB+ixtPW1GcJ8H+hxCE9Nf1uwZo=;
 b=NcusD80xm4rFqWZgisvJdgTMMOQX+wa3IAfN6PljNHx/j2rWG2vATK177E27AFWGOj
 YjAvUbgJHQTCl28AWU3D9JbhOydjAUx+ThUh8q+aW9VYso0Ss+Hw6+6/GdhH9qgSsZSi
 O9SGO7dLAza+aEk08hBOl3t43byndEWiYZe0lrfHYgJoTqmw+5U/lqUJCX1WAkETeHag
 5yCvUSDN9FXwlqgcFAUjqgBlXWUjKRtoceAVTxjmzAtUn4JZKI/I8vywNGC6ZSc91L7s
 Ffd+NDLJ8nTwKYCoasQzhnw/NoougyLFzE9QTP6zgD1xjgV9qH/chuzxQgQ+Vsu5HIEE
 68sA==
X-Gm-Message-State: APjAAAW7UMOaYGue6BZXolUW6NCvRqmeI9DTcQdhe5DxXx+3/TlfQ8G2
 Qbesd1AxjdW1rJ9DTVAnEdtt62ScjoqFkA==
X-Google-Smtp-Source: APXvYqySbyErgi/VC+oOJh5Xvc69EdqLxup8G4GDDjm51/4bU3jUxj9vdGVFZORPhPU4EA6Q8mrryw==
X-Received: by 2002:adf:e7c9:: with SMTP id e9mr2996023wrn.261.1571318957465; 
 Thu, 17 Oct 2019 06:29:17 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id n15sm2703392wrw.47.2019.10.17.06.29.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Oct 2019 06:29:16 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH 7/8] hw/m68k/mcf5206.c: Switch to transaction-based ptimer API
Date: Thu, 17 Oct 2019 14:29:04 +0100
Message-Id: <20191017132905.5604-8-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191017132905.5604-1-peter.maydell@linaro.org>
References: <20191017132905.5604-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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

Switch the mcf5206 code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/m68k/mcf5206.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index a49096367cb..c05401e0e50 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -8,7 +8,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -57,6 +56,7 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
     int prescale;
     int mode;
 
+    ptimer_transaction_begin(s->timer);
     ptimer_stop(s->timer);
 
     if ((s->tmr & TMR_RST) == 0)
@@ -78,6 +78,7 @@ static void m5206_timer_recalibrate(m5206_timer_state *s)
     ptimer_set_limit(s->timer, s->trr, 0);
 
     ptimer_run(s->timer, 0);
+    ptimer_transaction_commit(s->timer);
 }
 
 static void m5206_timer_trigger(void *opaque)
@@ -123,7 +124,9 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
         s->tcr = val;
         break;
     case 0xc:
+        ptimer_transaction_begin(s->timer);
         ptimer_set_count(s->timer, val);
+        ptimer_transaction_commit(s->timer);
         break;
     case 0x11:
         s->ter &= ~val;
@@ -137,11 +140,9 @@ static void m5206_timer_write(m5206_timer_state *s, uint32_t addr, uint32_t val)
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


