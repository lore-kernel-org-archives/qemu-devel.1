Return-Path: <SRS0=p/0J=2J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0EDC43603
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 58C54222C2
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Dec 2019 18:56:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CiqPXITD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 58C54222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ii0y4-0004KJ-6S
	for qemu-devel@archiver.kernel.org; Thu, 19 Dec 2019 13:56:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39382)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0td-00070O-BU
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0tc-0007cs-1E
 for qemu-devel@nongnu.org; Thu, 19 Dec 2019 13:51:37 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:55406)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1ii0ta-0007JT-OD; Thu, 19 Dec 2019 13:51:35 -0500
Received: by mail-wm1-x341.google.com with SMTP id q9so6525516wmj.5;
 Thu, 19 Dec 2019 10:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=fXYp8lEUsOTs8WcsQwwp+b/Rx/W+yTQjD5EmKm5HZkQ=;
 b=CiqPXITD7Q6zjfjsVt8EFYgzvZiiPThER8xHaLyNLRpa42ZGuYzQ0RWvJzRYg/v564
 wbF/PUl806Sb8yrqrkQPrnyYdmh7JEelLgNbMH/TR+EtdcL5E96Mcfh+h9OrIvrjcv8K
 IAaVUWzFVnImTSfDERTduPXzw0OZCA6y7tNs6+6A7DHnN8/d2FYiOAg6zSC553C7IVeG
 bXFIhQFAqQ747RPP93c0P+LhUOD3snmkEO81gDtzbDSmowFruBhwzqHhkj1DWMfrQyBU
 fn+OcjRJz1OKZQfxVnJRVMvtIolHAMjpq+kbdHsrXESFRDaI1o+VoY4TNy0QLXg2UjDe
 Um9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=fXYp8lEUsOTs8WcsQwwp+b/Rx/W+yTQjD5EmKm5HZkQ=;
 b=kuIDvQ5S7BkonxO0HFl/5gaztqoBEi+BVVM8p2cC2mp8+bBYStKx3S3Q9A2xKa5+Y1
 MDhHPSE1GUR+RRcIBJz4wqGLYxhOJJ2Kjhx7bYGSZx3ynuaTgVjOcJn4N71GqkqV/l/f
 K9XTpSPJ2/+OU8nJZ/n9KJRVgmErdx9rZopklCtmg+eW6C9F2oveSRKl6q7Ym2V03PI3
 VwK//mm/3WBa1CIXnx1EZ+tSZfr0GG397f6WQ7ce/84OMXjfCX1WiQs0AkB7lGHZQUKT
 orYIwjWDmBX6XvyLyMI3kXky6GIQfKK6E3wW3XGv/tA15Mt8adDMkVQNmT5LXSKnGqWe
 TQXA==
X-Gm-Message-State: APjAAAXUQzijNjMiE2FABUbqYWsUeKqUIPO2NgcnKiN9DpiTl/jpr5Ix
 Y+mKP/Bm5/aQ+1c+ej3grON0COsW
X-Google-Smtp-Source: APXvYqyBP+csHZWV31aWT9PUtc9oSAzojq4IR+0YaAAAV132U+rS7oQtg+AaY6Qgehx1lhQ+kKItYg==
X-Received: by 2002:a1c:4d03:: with SMTP id o3mr11881092wmh.164.1576781491873; 
 Thu, 19 Dec 2019 10:51:31 -0800 (PST)
Received: from x1w.redhat.com (34.red-83-42-66.dynamicip.rima-tde.net.
 [83.42.66.34])
 by smtp.gmail.com with ESMTPSA id b67sm7435494wmc.38.2019.12.19.10.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Dec 2019 10:51:31 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
To: qemu-devel@nongnu.org,
	Niek Linnenbank <nieklinnenbank@gmail.com>
Subject: [PATCH 02/13] hw/timer/allwinner: Add AW_PIT_TIMER_MAX definition
Date: Thu, 19 Dec 2019 19:51:16 +0100
Message-Id: <20191219185127.24388-3-f4bug@amsat.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191219185127.24388-1-f4bug@amsat.org>
References: <20191219185127.24388-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset="utf-8"
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
Cc: Beniamino Galvani <b.galvani@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This controller is able to use up to 6 timers.
Later we will reuse part of it to model other similar controllers
but with less timers. To simplify the VMSTATE, we'll keep a max
of 6 timers. Add a definition for that value.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 include/hw/timer/allwinner-a10-pit.h | 14 ++++++++------
 hw/timer/allwinner-a10-pit.c         |  8 ++++----
 2 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/include/hw/timer/allwinner-a10-pit.h b/include/hw/timer/allwinner-a10-pit.h
index 6aceda81ee..54c40c7db6 100644
--- a/include/hw/timer/allwinner-a10-pit.h
+++ b/include/hw/timer/allwinner-a10-pit.h
@@ -7,6 +7,8 @@
 #define TYPE_AW_A10_PIT "allwinner-A10-timer"
 #define AW_A10_PIT(obj) OBJECT_CHECK(AwA10PITState, (obj), TYPE_AW_A10_PIT)
 
+#define AW_PIT_TIMER_MAX        6
+
 #define AW_A10_PIT_TIMER_NR    6
 #define AW_A10_PIT_TIMER_IRQ   0x1
 #define AW_A10_PIT_WDOG_IRQ    0x100
@@ -47,17 +49,17 @@ struct AwA10PITState {
     /*< private >*/
     SysBusDevice parent_obj;
     /*< public >*/
-    qemu_irq irq[AW_A10_PIT_TIMER_NR];
-    ptimer_state * timer[AW_A10_PIT_TIMER_NR];
-    AwA10TimerContext timer_context[AW_A10_PIT_TIMER_NR];
+    qemu_irq irq[AW_PIT_TIMER_MAX];
+    ptimer_state * timer[AW_PIT_TIMER_MAX];
+    AwA10TimerContext timer_context[AW_PIT_TIMER_MAX];
     MemoryRegion iomem;
     uint32_t clk_freq[4];
 
     uint32_t irq_enable;
     uint32_t irq_status;
-    uint32_t control[AW_A10_PIT_TIMER_NR];
-    uint32_t interval[AW_A10_PIT_TIMER_NR];
-    uint32_t count[AW_A10_PIT_TIMER_NR];
+    uint32_t control[AW_PIT_TIMER_MAX];
+    uint32_t interval[AW_PIT_TIMER_MAX];
+    uint32_t count[AW_PIT_TIMER_MAX];
     uint32_t watch_dog_mode;
     uint32_t watch_dog_control;
     uint32_t count_lo;
diff --git a/hw/timer/allwinner-a10-pit.c b/hw/timer/allwinner-a10-pit.c
index 117e5c7bf8..b31a0bcd43 100644
--- a/hw/timer/allwinner-a10-pit.c
+++ b/hw/timer/allwinner-a10-pit.c
@@ -203,15 +203,15 @@ static const VMStateDescription vmstate_a10_pit = {
     .fields = (VMStateField[]) {
         VMSTATE_UINT32(irq_enable, AwA10PITState),
         VMSTATE_UINT32(irq_status, AwA10PITState),
-        VMSTATE_UINT32_ARRAY(control, AwA10PITState, AW_A10_PIT_TIMER_NR),
-        VMSTATE_UINT32_ARRAY(interval, AwA10PITState, AW_A10_PIT_TIMER_NR),
-        VMSTATE_UINT32_ARRAY(count, AwA10PITState, AW_A10_PIT_TIMER_NR),
+        VMSTATE_UINT32_ARRAY(control, AwA10PITState, AW_PIT_TIMER_MAX),
+        VMSTATE_UINT32_ARRAY(interval, AwA10PITState, AW_PIT_TIMER_MAX),
+        VMSTATE_UINT32_ARRAY(count, AwA10PITState, AW_PIT_TIMER_MAX),
         VMSTATE_UINT32(watch_dog_mode, AwA10PITState),
         VMSTATE_UINT32(watch_dog_control, AwA10PITState),
         VMSTATE_UINT32(count_lo, AwA10PITState),
         VMSTATE_UINT32(count_hi, AwA10PITState),
         VMSTATE_UINT32(count_ctl, AwA10PITState),
-        VMSTATE_PTIMER_ARRAY(timer, AwA10PITState, AW_A10_PIT_TIMER_NR),
+        VMSTATE_PTIMER_ARRAY(timer, AwA10PITState, AW_PIT_TIMER_MAX),
         VMSTATE_END_OF_LIST()
     }
 };
-- 
2.21.0


