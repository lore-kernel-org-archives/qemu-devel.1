Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3182C4CECE
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:12:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90EF821835
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 17:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JUNgnE/b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90EF821835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK3tx-0007U8-Gl
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 13:12:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37291)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qZ-0004xc-Cr
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iK2qY-000825-2A
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:23 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:36561)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iK2qX-00081K-SB
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:05:22 -0400
Received: by mail-wm1-x32b.google.com with SMTP id m18so17318442wmc.1
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=MkJTDzl7sqFJssCYKDYW4CGvMgjxfSmS7ViVzWLm0o8=;
 b=JUNgnE/bqju8rqO8SpOZ7cUgrdZ3cqzY2xfCy7XmcFjjqTszr3qFN6S8Ly8aXTMbj7
 TQlFyy8PQqB/ne4QHhtCELg4vCe+ngGZ3Wpz1FRPwNMhdXlXrjEYvhIWbaDks1G2HIwl
 AiRTLvRjRRh3ReGlApKGko+ZGsSBebWgRUg6OEnkA9npqb7cDRkP7Dw6PFAs6rnsrYpZ
 8xGT8q7DU7OyRNj9ErffUjcPRHkBzkQlkNW3RVQZdVB+itGdbriDdJaWQdqpI89iOBV9
 FySPLRvJOkklg9QXGNRl+2Ro9+wUBh8j5inq5cwQvPkWFxQBuodCWDd+e6toTc5g0tXo
 8/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MkJTDzl7sqFJssCYKDYW4CGvMgjxfSmS7ViVzWLm0o8=;
 b=NuK737meFxHGm/YZrO8/+wG9cxFS8zmME/Wqh/IbhiWPo2BEh3pZuuVCSxa8nR+UNT
 5ydgpG2M7eLEA1HAmOsvEusLLLGE9dpEXF/25er7VK8sevTDZdyvi4n4y7tw+rC+Pn46
 wR21/vyOG0SAtG0Wz6zo66SVDuTOFoePvlo7MFKo/JNc2jesJslshT6DK3t8UGTAOYQ3
 7NHcNm5SFdzpG/8Lf1+8/JsQ+IXDvbbbUtYK8CaVSXRpQ0uzX6NQVHxLb93ObztFw3UK
 PzivwmcP4MLOyJlPkxGqBprbHL/zO6Y4OnbugqahCMMqjgPiP3kcB/le+IB3xwyHJ4en
 PRqg==
X-Gm-Message-State: APjAAAUXOXx2yr32BeDeDNNmkbul+5gYcrHA68DffoFWG9gf7IiP/QTT
 EAWS+oeGMdxo25Mg1s2EksoZAPuXpE0bQQ==
X-Google-Smtp-Source: APXvYqwBpCI8npXsq/6TUjtE62alZK4W9npKXo7TqTkSwWB2gO8ks6ve7oFq6GkoQ2xHlT516P1C0Q==
X-Received: by 2002:a1c:4386:: with SMTP id q128mr16484533wma.39.1571069120530; 
 Mon, 14 Oct 2019 09:05:20 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id 5sm18029779wrk.86.2019.10.14.09.05.19
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:05:19 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 45/68] aspeed/timer: Add AST2600 support
Date: Mon, 14 Oct 2019 17:03:41 +0100
Message-Id: <20191014160404.19553-46-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191014160404.19553-1-peter.maydell@linaro.org>
References: <20191014160404.19553-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::32b
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

From: Cédric Le Goater <clg@kaod.org>

The AST2600 timer has a third control register that is used to
implement a set-to-clear feature for the main control register.

On the AST2600, it is not configurable via 0x38 (control register 3)
as it is on the AST2500.

Based on previous work from Joel Stanley.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Message-id: 20190925143248.10000-7-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/timer/aspeed_timer.h |  1 +
 hw/timer/aspeed_timer.c         | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)

diff --git a/include/hw/timer/aspeed_timer.h b/include/hw/timer/aspeed_timer.h
index 1e0288ebc49..69b1377af01 100644
--- a/include/hw/timer/aspeed_timer.h
+++ b/include/hw/timer/aspeed_timer.h
@@ -30,6 +30,7 @@
 #define TYPE_ASPEED_TIMER "aspeed.timer"
 #define TYPE_ASPEED_2400_TIMER TYPE_ASPEED_TIMER "-ast2400"
 #define TYPE_ASPEED_2500_TIMER TYPE_ASPEED_TIMER "-ast2500"
+#define TYPE_ASPEED_2600_TIMER TYPE_ASPEED_TIMER "-ast2600"
 
 #define ASPEED_TIMER_NR_TIMERS 8
 
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index d70e78a0293..7f73d0c7533 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -538,6 +538,40 @@ static void aspeed_2500_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
     }
 }
 
+static uint64_t aspeed_2600_timer_read(AspeedTimerCtrlState *s, hwaddr offset)
+{
+    uint64_t value;
+
+    switch (offset) {
+    case 0x38:
+    case 0x3C:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                __func__, offset);
+        value = 0;
+        break;
+    }
+    return value;
+}
+
+static void aspeed_2600_timer_write(AspeedTimerCtrlState *s, hwaddr offset,
+                                    uint64_t value)
+{
+    const uint32_t tv = (uint32_t)(value & 0xFFFFFFFF);
+
+    switch (offset) {
+    case 0x3C:
+        aspeed_timer_set_ctrl(s, s->ctrl & ~tv);
+        break;
+
+    case 0x38:
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
+                __func__, offset);
+        break;
+    }
+}
+
 static void aspeed_init_one_timer(AspeedTimerCtrlState *s, uint8_t id)
 {
     AspeedTimer *t = &s->timers[id];
@@ -674,11 +708,28 @@ static const TypeInfo aspeed_2500_timer_info = {
     .class_init = aspeed_2500_timer_class_init,
 };
 
+static void aspeed_2600_timer_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+    AspeedTimerClass *awc = ASPEED_TIMER_CLASS(klass);
+
+    dc->desc = "ASPEED 2600 Timer";
+    awc->read = aspeed_2600_timer_read;
+    awc->write = aspeed_2600_timer_write;
+}
+
+static const TypeInfo aspeed_2600_timer_info = {
+    .name = TYPE_ASPEED_2600_TIMER,
+    .parent = TYPE_ASPEED_TIMER,
+    .class_init = aspeed_2600_timer_class_init,
+};
+
 static void aspeed_timer_register_types(void)
 {
     type_register_static(&aspeed_timer_info);
     type_register_static(&aspeed_2400_timer_info);
     type_register_static(&aspeed_2500_timer_info);
+    type_register_static(&aspeed_2600_timer_info);
 }
 
 type_init(aspeed_timer_register_types)
-- 
2.20.1


