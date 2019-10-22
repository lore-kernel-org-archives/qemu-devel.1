Return-Path: <SRS0=tSBD=YP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E58F1CA9EA0
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:43:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF30C20700
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2019 13:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XHjSRSNb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF30C20700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMuRt-0007vo-J3
	for qemu-devel@archiver.kernel.org; Tue, 22 Oct 2019 09:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36706)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGd-0002Tu-8c
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMuGb-0001FE-Ul
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:07 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:35168)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMuGb-0001F1-OV
 for qemu-devel@nongnu.org; Tue, 22 Oct 2019 09:32:05 -0400
Received: by mail-wm1-x341.google.com with SMTP id v9so266503wml.0
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2019 06:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=Fwd2iBNusbM/OQvc1QbvND2II8QsKKZ6PUURuQhaBB0=;
 b=XHjSRSNbhRJY+4m6I3uwOrSX8IB4HQ+2R9Jwy5wfDz0Bk/vkpAAsW+RqC1KoFspqRC
 vt/PEbSbenMjJcKttgn/DYhdsMhIP4Gw2KYZxnCRaNgc8B8vaAY9Bbx/lZJ0cCPz48Mh
 gLLTuo7EIxwpVFkVu/6XhuflpMPjdx3EaYdlMvrDiBM4PleiXQMt17z99gnCZ5LdGTea
 2wR8kARrS8zA3vwwbYd/cToTGZDEiNPiWuIOP9lLX+Fldq9dIWoT5GDmI/Fm1hwkBjVy
 AY9EuEXsqlWxOA1MEPWxQUsd5W4IL/KQIy+tr7UQbukk8x4CG058l/DBbe8vm7Z0VP2z
 j0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Fwd2iBNusbM/OQvc1QbvND2II8QsKKZ6PUURuQhaBB0=;
 b=dw2CSy2VLfDwwn+eSjGByMd3ZVx8BixjH5dYpfetCSEDen8Z4SW4/8i7lbZMqXWNSH
 9k7RyXXWxyGBSHoIPaxOzGkDG3YJM3UtB4gxmcFckI6PRAIztfhCE3WeFPdhElmPvm9B
 5EPNhuM6x4KmrAwRQFeom5+HQ+0Pz2/luh1LXQBmZ3vPv3Yl8lL9crfScL8Rc3RL6a8n
 owI6icJqqhgdF5GRNKXfPeaf40eX7pQbrUOridd7zSCtIegh3bhsfLQFhBtAUunLAhLx
 kUXL09AEdqb0Yjj5AwBpIlbwdNUzdQ+X/a9PcKIgwkw90JnubpYFS4IjVLppMWEomian
 eOjg==
X-Gm-Message-State: APjAAAXzMlQlNYVZm5NgXNQmN7bwKMaIYxJFwFgNftV0WSQWiNutzDV4
 LVKvn8JRELJXJ0cTmQX+zTGtbGv4Jso=
X-Google-Smtp-Source: APXvYqxbXJBy8Wjay+8PGErsvjRy4TJe+lrg8zf4fhvP5Iu6/X8bT88nKdtsnep65UZ40mAxLkNYPg==
X-Received: by 2002:a1c:7d95:: with SMTP id y143mr3197804wmc.143.1571751124203; 
 Tue, 22 Oct 2019 06:32:04 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id r2sm20263856wma.1.2019.10.22.06.32.02
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2019 06:32:03 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 10/41] hw/m68k/mcf5208.c: Switch to transaction-based ptimer API
Date: Tue, 22 Oct 2019 14:31:03 +0100
Message-Id: <20191022133134.14487-11-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191022133134.14487-1-peter.maydell@linaro.org>
References: <20191022133134.14487-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Switch the mcf5208 code away from bottom-half based ptimers to
the new transaction-based ptimer API.  This just requires adding
begin/commit calls around the various places that modify the ptimer
state, and using the new ptimer_init() function to create the timer.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Thomas Huth <huth@tuxfamily.org>
Message-id: 20191017132905.5604-9-peter.maydell@linaro.org
---
 hw/m68k/mcf5208.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index 34d34eba17c..158c5e4be75 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -9,7 +9,6 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
-#include "qemu/main-loop.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
@@ -79,6 +78,7 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
             return;
         }
 
+        ptimer_transaction_begin(s->timer);
         if (s->pcsr & PCSR_EN)
             ptimer_stop(s->timer);
 
@@ -94,8 +94,10 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
 
         if (s->pcsr & PCSR_EN)
             ptimer_run(s->timer, 0);
+        ptimer_transaction_commit(s->timer);
         break;
     case 2:
+        ptimer_transaction_begin(s->timer);
         s->pmr = value;
         s->pcsr &= ~PCSR_PIF;
         if ((s->pcsr & PCSR_RLD) == 0) {
@@ -104,6 +106,7 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
         } else {
             ptimer_set_limit(s->timer, value, s->pcsr & PCSR_OVW);
         }
+        ptimer_transaction_commit(s->timer);
         break;
     case 4:
         break;
@@ -182,7 +185,6 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
 {
     MemoryRegion *iomem = g_new(MemoryRegion, 1);
     m5208_timer_state *s;
-    QEMUBH *bh;
     int i;
 
     /* SDRAMC.  */
@@ -191,8 +193,7 @@ static void mcf5208_sys_init(MemoryRegion *address_space, qemu_irq *pic)
     /* Timers.  */
     for (i = 0; i < 2; i++) {
         s = g_new0(m5208_timer_state, 1);
-        bh = qemu_bh_new(m5208_timer_trigger, s);
-        s->timer = ptimer_init_with_bh(bh, PTIMER_POLICY_DEFAULT);
+        s->timer = ptimer_init(m5208_timer_trigger, s, PTIMER_POLICY_DEFAULT);
         memory_region_init_io(&s->iomem, NULL, &m5208_timer_ops, s,
                               "m5208-timer", 0x00004000);
         memory_region_add_subregion(address_space, 0xfc080000 + 0x4000 * i,
-- 
2.20.1


