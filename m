Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B763BC35647
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:08:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 817A72073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 13:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Os/lQ0px"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 817A72073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j582z-0008AQ-Lf
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 08:08:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56393)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j581z-0006Tg-6A
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j581x-0002Rx-W4
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:47 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:52264)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j581x-0002RY-P3
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 08:07:45 -0500
Received: by mail-wm1-x331.google.com with SMTP id p9so1734402wmc.2
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 05:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nzHzFg20+dv2Qj6R5QZ1RVKcfKZ0HBelWmrraQzT7AY=;
 b=Os/lQ0pxQoLY0DtDVn92hJvBYKr2+5kiTz+XfLeqsCAgKTb7Tz3XM6rcfj2SeFoGQk
 EujgAyRRy628bC6flc3UYyDSTySFZNgQlOZYoseAsk+2p7ZCaNgGdlAT3eIWRPXFe+u7
 QdA1/ASpRxQuZRqwk7jH+JgTwVREI+jrphmiiwP5wAiMm5aUIE485z02WWNqnZiUebtf
 JjjmAcRe+8fZWjwVu65mwGf5nEX5jRD7g4DhFI3SXaymBVOe9sv+NsKCDdWxqjl3rxmo
 oj98iOQX3lr+JM8KWYLVh5TCncpeGkS1RqbgGIDjpoQkZAWaCI4i9WzrLNbTf3g6/bsV
 oykg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nzHzFg20+dv2Qj6R5QZ1RVKcfKZ0HBelWmrraQzT7AY=;
 b=HizEOG/V/iw8Kui90u5XYVAiQVxHj0Ns7/fSOtIhEOOALmuhqNj9kb0nYxlRa1DeiH
 LD4dsep7QcegUpXDLgR3h1d9Xsc5VjmZPN0x/MWVpnIuPNlM7TMYhG22qSu4YicnpojW
 U8a8ejo+f7xtYGPO1oCCdNQ9DD9Zklels5gTomFODQ3um4I/jbB7HeBPlVJykUhMG+Jq
 5WW8RYgkp2+Ow33fVHgzZV6Zckxwewa2RQHnL7BoRWda99GGjCiLPkHZ3LhlMqxK6mAM
 7RwaqIe9A/KRpFeb0U2zidAX+D9xXy7tubvuGzEdp0mtSq3fymeREzHRcfUgQJly+fTk
 T95g==
X-Gm-Message-State: APjAAAXmqQwQauZFVGqiJg85rhonCFRzJCpVBSubuuqfE98c3BEtDolZ
 q7/yn8Yku9qF0DMVxVuVUtmcbrlVzo2p9A==
X-Google-Smtp-Source: APXvYqwtuPcCf53T9ZsqGTy0Y2x7iviqx8hUf6aY4Tipe+VUPUtTv0c4lD7ool4KKFHpxO5WkpR8KQ==
X-Received: by 2002:a1c:20d6:: with SMTP id g205mr3959431wmg.38.1582290463793; 
 Fri, 21 Feb 2020 05:07:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p15sm3598892wma.40.2020.02.21.05.07.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2020 05:07:43 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 01/52] aspeed/scu: Create separate write callbacks
Date: Fri, 21 Feb 2020 13:06:49 +0000
Message-Id: <20200221130740.7583-2-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200221130740.7583-1-peter.maydell@linaro.org>
References: <20200221130740.7583-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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

From: Joel Stanley <joel@jms.id.au>

This splits the common write callback into separate ast2400 and ast2500
implementations. This makes it clearer when implementing differing
behaviour.

Signed-off-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
Reviewed-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-id: 20200121013302.43839-2-joel@jms.id.au
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/aspeed_scu.c | 80 +++++++++++++++++++++++++++++++-------------
 1 file changed, 57 insertions(+), 23 deletions(-)

diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index ce2f9562d4c..6cb388330a8 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -232,8 +232,47 @@ static uint64_t aspeed_scu_read(void *opaque, hwaddr offset, unsigned size)
     return s->regs[reg];
 }
 
-static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
-                             unsigned size)
+static void aspeed_ast2400_scu_write(void *opaque, hwaddr offset,
+                                     uint64_t data, unsigned size)
+{
+    AspeedSCUState *s = ASPEED_SCU(opaque);
+    int reg = TO_REG(offset);
+
+    if (reg >= ASPEED_SCU_NR_REGS) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Out-of-bounds write at offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    if (reg > PROT_KEY && reg < CPU2_BASE_SEG1 &&
+            !s->regs[PROT_KEY]) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SCU is locked!\n", __func__);
+    }
+
+    trace_aspeed_scu_write(offset, size, data);
+
+    switch (reg) {
+    case PROT_KEY:
+        s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
+        return;
+    case SILICON_REV:
+    case FREQ_CNTR_EVAL:
+    case VGA_SCRATCH1 ... VGA_SCRATCH8:
+    case RNG_DATA:
+    case FREE_CNTR4:
+    case FREE_CNTR4_EXT:
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
+                      __func__, offset);
+        return;
+    }
+
+    s->regs[reg] = data;
+}
+
+static void aspeed_ast2500_scu_write(void *opaque, hwaddr offset,
+                                     uint64_t data, unsigned size)
 {
     AspeedSCUState *s = ASPEED_SCU(opaque);
     int reg = TO_REG(offset);
@@ -257,25 +296,11 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
     case PROT_KEY:
         s->regs[reg] = (data == ASPEED_SCU_PROT_KEY) ? 1 : 0;
         return;
-    case CLK_SEL:
-        s->regs[reg] = data;
-        break;
     case HW_STRAP1:
-        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
-            s->regs[HW_STRAP1] |= data;
-            return;
-        }
-        /* Jump to assignment below */
-        break;
+        s->regs[HW_STRAP1] |= data;
+        return;
     case SILICON_REV:
-        if (ASPEED_IS_AST2500(s->regs[SILICON_REV])) {
-            s->regs[HW_STRAP1] &= ~data;
-        } else {
-            qemu_log_mask(LOG_GUEST_ERROR,
-                          "%s: Write to read-only offset 0x%" HWADDR_PRIx "\n",
-                          __func__, offset);
-        }
-        /* Avoid assignment below, we've handled everything */
+        s->regs[HW_STRAP1] &= ~data;
         return;
     case FREQ_CNTR_EVAL:
     case VGA_SCRATCH1 ... VGA_SCRATCH8:
@@ -291,9 +316,18 @@ static void aspeed_scu_write(void *opaque, hwaddr offset, uint64_t data,
     s->regs[reg] = data;
 }
 
-static const MemoryRegionOps aspeed_scu_ops = {
+static const MemoryRegionOps aspeed_ast2400_scu_ops = {
     .read = aspeed_scu_read,
-    .write = aspeed_scu_write,
+    .write = aspeed_ast2400_scu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid.min_access_size = 4,
+    .valid.max_access_size = 4,
+    .valid.unaligned = false,
+};
+
+static const MemoryRegionOps aspeed_ast2500_scu_ops = {
+    .read = aspeed_scu_read,
+    .write = aspeed_ast2500_scu_write,
     .endianness = DEVICE_LITTLE_ENDIAN,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
@@ -469,7 +503,7 @@ static void aspeed_2400_scu_class_init(ObjectClass *klass, void *data)
     asc->calc_hpll = aspeed_2400_scu_calc_hpll;
     asc->apb_divider = 2;
     asc->nr_regs = ASPEED_SCU_NR_REGS;
-    asc->ops = &aspeed_scu_ops;
+    asc->ops = &aspeed_ast2400_scu_ops;
 }
 
 static const TypeInfo aspeed_2400_scu_info = {
@@ -489,7 +523,7 @@ static void aspeed_2500_scu_class_init(ObjectClass *klass, void *data)
     asc->calc_hpll = aspeed_2500_scu_calc_hpll;
     asc->apb_divider = 4;
     asc->nr_regs = ASPEED_SCU_NR_REGS;
-    asc->ops = &aspeed_scu_ops;
+    asc->ops = &aspeed_ast2500_scu_ops;
 }
 
 static const TypeInfo aspeed_2500_scu_info = {
-- 
2.20.1


