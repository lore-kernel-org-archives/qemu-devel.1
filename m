Return-Path: <SRS0=u0tK=2G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B843DC2D0BF
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:18:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8719F2072B
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2019 11:18:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WtmWULad"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8719F2072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51472 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1igoOc-0001NV-6v
	for qemu-devel@archiver.kernel.org; Mon, 16 Dec 2019 06:18:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50788)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFY-0007Uy-Du
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1igoFX-0007d8-1Y
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:16 -0500
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:37538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1igoFW-0007aL-R8
 for qemu-devel@nongnu.org; Mon, 16 Dec 2019 06:09:14 -0500
Received: by mail-wr1-x436.google.com with SMTP id w15so6740078wru.4
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2019 03:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=CY7Ya5+IokAEVPxBUMo7NMyrxap6Uz4FpzWkrZ1uIdU=;
 b=WtmWULad0O2jr0MR63Xiy7U65WiNwiYs2nH9/sqyARf77WJ8mbVOx47XOpl0w86e7r
 M5x3R9sckPTfdWZHTnFlu+ZcyWryiHDKxaEw7NDLqTwqxaNCMV7sfUKrzHmbLtnM+6w4
 H6gMpjZjRTacX06vsUjvlqM5TEXmSYTc9dvEZzibsUtnSYQEJwH7gi2I/6BufqhV2opA
 YXlZ+xrg8COhnwjotiYKbs1/TTo76ZgUOGh/hxMs1bDWPe0HsFCrEogVaRiyL6qv71Ig
 P6cPHX43hfrX1cnwzbe4Z+EDnt+EZT/UFimeezYeOHKpUL4b1D4pxAAnE7KYCrmv85W1
 DwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=CY7Ya5+IokAEVPxBUMo7NMyrxap6Uz4FpzWkrZ1uIdU=;
 b=lQwann22kxkZWI9aw5gOUDBnp4WJnDvof6sFilZo6eCH8Tt6qbBqzsSJH9Rx2y49Ls
 w4Z76e33ZaLEI6WaHp8XQ7BwmddxTsmmKKTGLPHeek/0XARUoqGQE4qKKpbFkqiJIQii
 sUwRMto0VlA8tten/yY3Gb5GW2/B33b4z7I5bayZdJHZdOIaz7hgp2ujQDMVeo5r4O4H
 1WOI9/CVCHl6TQgzfZIR2jiqlzqq+VvBrWfOS98zefwCS9kQc+r2ITIILsN6uTQbrDec
 WqeAxP7fxQeP7xY7vEm5qn8vxPARjwwZGtoGSVQ9IUTv6l7C8eENFfifr1Hurtdt74K9
 KH6A==
X-Gm-Message-State: APjAAAXRObGuFsqdRXUH08Q2ifszZCamHVo7i2Y5mMzBBb2Px+ciZOFF
 y69kzBe5fXk/wOF73rE+nAbwoyN1kz0XTg==
X-Google-Smtp-Source: APXvYqyvOD1ZmSyY+ktShTKfID+hMv9XkQ/3AyVJgvYaCGdtw+0G/gpS3i9fnrn7c+scShf1k04Pmg==
X-Received: by 2002:a5d:6211:: with SMTP id y17mr29407112wru.344.1576494552520; 
 Mon, 16 Dec 2019 03:09:12 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id x10sm20976131wrp.58.2019.12.16.03.09.11
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Dec 2019 03:09:11 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 04/34] aspeed/i2c: Check SRAM enablement on AST2500
Date: Mon, 16 Dec 2019 11:08:34 +0000
Message-Id: <20191216110904.30815-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191216110904.30815-1-peter.maydell@linaro.org>
References: <20191216110904.30815-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
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

The SRAM must be enabled before using the Buffer Pool mode or the DMA
mode. This is not required on other SoCs.

Signed-off-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Tested-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Signed-off-by: Cédric Le Goater <clg@kaod.org>
Message-id: 20191119141211.25716-3-clg@kaod.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/i2c/aspeed_i2c.h |  3 +++
 hw/i2c/aspeed_i2c.c         | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff --git a/include/hw/i2c/aspeed_i2c.h b/include/hw/i2c/aspeed_i2c.h
index 5313d07aa72..7a555072dfb 100644
--- a/include/hw/i2c/aspeed_i2c.h
+++ b/include/hw/i2c/aspeed_i2c.h
@@ -61,6 +61,7 @@ typedef struct AspeedI2CState {
     qemu_irq irq;
 
     uint32_t intr_status;
+    uint32_t ctrl_global;
     MemoryRegion pool_iomem;
     uint8_t pool[ASPEED_I2C_MAX_POOL_SIZE];
 
@@ -83,6 +84,8 @@ typedef struct AspeedI2CClass {
     uint64_t pool_size;
     hwaddr pool_base;
     uint8_t *(*bus_pool_base)(AspeedI2CBus *);
+    bool check_sram;
+
 } AspeedI2CClass;
 
 I2CBus *aspeed_i2c_get_bus(DeviceState *dev, int busnr);
diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
index e21f45d9686..c7929aa2850 100644
--- a/hw/i2c/aspeed_i2c.c
+++ b/hw/i2c/aspeed_i2c.c
@@ -31,6 +31,8 @@
 #define I2C_CTRL_STATUS         0x00        /* Device Interrupt Status */
 #define I2C_CTRL_ASSIGN         0x08        /* Device Interrupt Target
                                                Assignment */
+#define I2C_CTRL_GLOBAL         0x0C        /* Global Control Register */
+#define   I2C_CTRL_SRAM_EN                 BIT(0)
 
 /* I2C Device (Bus) Register */
 
@@ -271,6 +273,29 @@ static uint8_t aspeed_i2c_get_addr(AspeedI2CBus *bus)
     }
 }
 
+static bool aspeed_i2c_check_sram(AspeedI2CBus *bus)
+{
+    AspeedI2CState *s = bus->controller;
+    AspeedI2CClass *aic = ASPEED_I2C_GET_CLASS(s);
+
+    if (!aic->check_sram) {
+        return true;
+    }
+
+    /*
+     * AST2500: SRAM must be enabled before using the Buffer Pool or
+     * DMA mode.
+     */
+    if (!(s->ctrl_global & I2C_CTRL_SRAM_EN) &&
+        (bus->cmd & (I2CD_RX_DMA_ENABLE | I2CD_TX_DMA_ENABLE |
+                     I2CD_RX_BUFF_ENABLE | I2CD_TX_BUFF_ENABLE))) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: SRAM is not enabled\n", __func__);
+        return false;
+    }
+
+    return true;
+}
+
 /*
  * The state machine needs some refinement. It is only used to track
  * invalid STOP commands for the moment.
@@ -282,6 +307,10 @@ static void aspeed_i2c_bus_handle_cmd(AspeedI2CBus *bus, uint64_t value)
     bus->cmd &= ~0xFFFF;
     bus->cmd |= value & 0xFFFF;
 
+    if (!aspeed_i2c_check_sram(bus)) {
+        return;
+    }
+
     if (bus->cmd & I2CD_M_START_CMD) {
         uint8_t state = aspeed_i2c_get_state(bus) & I2CD_MACTIVE ?
             I2CD_MSTARTR : I2CD_MSTART;
@@ -436,6 +465,8 @@ static uint64_t aspeed_i2c_ctrl_read(void *opaque, hwaddr offset,
     switch (offset) {
     case I2C_CTRL_STATUS:
         return s->intr_status;
+    case I2C_CTRL_GLOBAL:
+        return s->ctrl_global;
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
                       __func__, offset);
@@ -448,7 +479,12 @@ static uint64_t aspeed_i2c_ctrl_read(void *opaque, hwaddr offset,
 static void aspeed_i2c_ctrl_write(void *opaque, hwaddr offset,
                                   uint64_t value, unsigned size)
 {
+    AspeedI2CState *s = opaque;
+
     switch (offset) {
+    case I2C_CTRL_GLOBAL:
+        s->ctrl_global = value;
+        break;
     case I2C_CTRL_STATUS:
     default:
         qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIx "\n",
@@ -684,6 +720,7 @@ static void aspeed_2500_i2c_class_init(ObjectClass *klass, void *data)
     aic->pool_size = 0x100;
     aic->pool_base = 0x200;
     aic->bus_pool_base = aspeed_2500_i2c_bus_pool_base;
+    aic->check_sram = true;
 }
 
 static const TypeInfo aspeed_2500_i2c_info = {
-- 
2.20.1


