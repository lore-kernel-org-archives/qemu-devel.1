Return-Path: <SRS0=7f1Q=CT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D65AC43461
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:02:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A942078E
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Sep 2020 07:02:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kna6C9SL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95A942078E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49646 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGGbT-0006JV-Ja
	for qemu-devel@archiver.kernel.org; Thu, 10 Sep 2020 03:02:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59568)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGab-0004kd-8r
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:01:49 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:23375
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kGGaV-0001j9-L0
 for qemu-devel@nongnu.org; Thu, 10 Sep 2020 03:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599721303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3LVq3GBMxvuW5ThC5No6G6me9ou9dAQJhQkLuf9vMHg=;
 b=Kna6C9SLL8kP0KHVgat50x7ub/fWQYKQ6eXubxX8H9gmiCYuKwEDqaGCQqn/mRCikX3/rl
 vsnTFv8tS4jLA5wsRFxW9wZhcU4iokm7Yy/uc3L72AERIoGJ7/bCC/YzMAPoBxbyQa6rkU
 bu72t5IjBlltwdrR4b2ZAXUhQWMUZ8o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-SHkuyu87MsiX1NbRnlA06g-1; Thu, 10 Sep 2020 03:01:41 -0400
X-MC-Unique: SHkuyu87MsiX1NbRnlA06g-1
Received: by mail-wm1-f72.google.com with SMTP id s24so1767571wmh.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2020 00:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=3LVq3GBMxvuW5ThC5No6G6me9ou9dAQJhQkLuf9vMHg=;
 b=Pg7LJX8ycY9eKpnpHT9Cx/8tCkRmiWGWpML72ucBdIL6EVSrVNBM4CthIWda5/e5zp
 Yq3AyRPrG4f0Riegr4FP30kuql9ZWTwlAANErHCZav5q6O2zU3+9rMMlr5eMPnAZeNDc
 nHY2sbOUXTJs4L8QdKahyUHbd5d/DZ3Xgiedl3vlymPQGqnqIZHrpxNZKFSFz37ScXbM
 RVbGJyC3EPDOSRrZitXiGH5pq4O2DI84H3ahtT7IM49Bof7RU/zn0o6MhvnS6maZ/SxH
 MhvkbDC1qe7VhUM3Bem9MNsvWhLIOBA9P1UzRsvrNQeOS0rEMSx4xkiyCK8qSGMmh+AQ
 rRmA==
X-Gm-Message-State: AOAM531KcTWKEzeSslRcq6RdFBjYzgM4enA/WDkWaowl+BfPWiw24GWJ
 O5XShFU+JPZIE17YfenNpoiSxu44y/bR4eUeoMSaLG8cgMwzOakL7Cpm1m5q2EWbJrKO4RqgsMx
 s/sh16zs4JH35jjA=
X-Received: by 2002:a7b:c182:: with SMTP id y2mr6733473wmi.21.1599721299940;
 Thu, 10 Sep 2020 00:01:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgp6jskt+jFoWEu9oClQRannFnMaW2ju14kuX/HT2/8P8+6b5Zro3I2ovA3LneRaIpwyvZzA==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr6733445wmi.21.1599721299694;
 Thu, 10 Sep 2020 00:01:39 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id o124sm2127336wmb.2.2020.09.10.00.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2020 00:01:39 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 1/6] hw/ssi/aspeed_smc: Rename max_slaves as max_devices
Date: Thu, 10 Sep 2020 09:01:26 +0200
Message-Id: <20200910070131.435543-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200910070131.435543-1-philmd@redhat.com>
References: <20200910070131.435543-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/10 00:49:43
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Eduardo Habkost <ehabkost@redhat.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Joel Stanley <joel@jms.id.au>, qemu-trivial@nongnu.org, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In order to use inclusive terminology, rename max_slaves
as max_devices.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/hw/ssi/aspeed_smc.h |  2 +-
 hw/ssi/aspeed_smc.c         | 40 ++++++++++++++++++-------------------
 2 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index 6fbbb238f15..52ae34e38d1 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -42,7 +42,7 @@ typedef struct AspeedSMCController {
     uint8_t r_timings;
     uint8_t nregs_timings;
     uint8_t conf_enable_w0;
-    uint8_t max_slaves;
+    uint8_t max_devices;
     const AspeedSegments *segments;
     hwaddr flash_window_base;
     uint32_t flash_window_size;
diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 795784e5f36..8219272016c 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -259,7 +259,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 1,
+        .max_devices       = 1,
         .segments          = aspeed_segments_legacy,
         .flash_window_base = ASPEED_SOC_SMC_FLASH_BASE,
         .flash_window_size = 0x6000000,
@@ -275,7 +275,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 5,
+        .max_devices       = 5,
         .segments          = aspeed_segments_fmc,
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -293,7 +293,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_SPI_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = SPI_CONF_ENABLE_W0,
-        .max_slaves        = 1,
+        .max_devices       = 1,
         .segments          = aspeed_segments_spi,
         .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -309,7 +309,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 3,
+        .max_devices       = 3,
         .segments          = aspeed_segments_ast2500_fmc,
         .flash_window_base = ASPEED_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -327,7 +327,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 2,
+        .max_devices       = 2,
         .segments          = aspeed_segments_ast2500_spi1,
         .flash_window_base = ASPEED_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x8000000,
@@ -343,7 +343,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 2,
+        .max_devices       = 2,
         .segments          = aspeed_segments_ast2500_spi2,
         .flash_window_base = ASPEED_SOC_SPI2_FLASH_BASE,
         .flash_window_size = 0x8000000,
@@ -359,7 +359,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 1,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 3,
+        .max_devices       = 3,
         .segments          = aspeed_segments_ast2600_fmc,
         .flash_window_base = ASPEED26_SOC_FMC_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -377,7 +377,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 2,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 2,
+        .max_devices       = 2,
         .segments          = aspeed_segments_ast2600_spi1,
         .flash_window_base = ASPEED26_SOC_SPI_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -395,7 +395,7 @@ static const AspeedSMCController controllers[] = {
         .r_timings         = R_TIMINGS,
         .nregs_timings     = 3,
         .conf_enable_w0    = CONF_ENABLE_W0,
-        .max_slaves        = 3,
+        .max_devices       = 3,
         .segments          = aspeed_segments_ast2600_spi2,
         .flash_window_base = ASPEED26_SOC_SPI2_FLASH_BASE,
         .flash_window_size = 0x10000000,
@@ -476,7 +476,7 @@ static bool aspeed_smc_flash_overlap(const AspeedSMCState *s,
     AspeedSegments seg;
     int i;
 
-    for (i = 0; i < s->ctrl->max_slaves; i++) {
+    for (i = 0; i < s->ctrl->max_devices; i++) {
         if (i == cs) {
             continue;
         }
@@ -537,7 +537,7 @@ static void aspeed_smc_flash_set_segment(AspeedSMCState *s, int cs,
      */
     if ((s->ctrl->segments == aspeed_segments_ast2500_spi1 ||
          s->ctrl->segments == aspeed_segments_ast2500_spi2) &&
-        cs == s->ctrl->max_slaves &&
+        cs == s->ctrl->max_devices &&
         seg.addr + seg.size != s->ctrl->segments[cs].addr +
         s->ctrl->segments[cs].size) {
         qemu_log_mask(LOG_GUEST_ERROR,
@@ -948,7 +948,7 @@ static void aspeed_smc_reset(DeviceState *d)
     }
 
     /* setup the default segment register values and regions for all */
-    for (i = 0; i < s->ctrl->max_slaves; ++i) {
+    for (i = 0; i < s->ctrl->max_devices; ++i) {
         aspeed_smc_flash_set_segment_region(s, i,
                     s->ctrl->segment_to_reg(s, &s->ctrl->segments[i]));
     }
@@ -995,8 +995,8 @@ static uint64_t aspeed_smc_read(void *opaque, hwaddr addr, unsigned int size)
         (s->ctrl->has_dma && addr == R_DMA_DRAM_ADDR) ||
         (s->ctrl->has_dma && addr == R_DMA_LEN) ||
         (s->ctrl->has_dma && addr == R_DMA_CHECKSUM) ||
-        (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_slaves) ||
-        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_slaves)) {
+        (addr >= R_SEG_ADDR0 && addr < R_SEG_ADDR0 + s->ctrl->max_devices) ||
+        (addr >= s->r_ctrl0 && addr < s->r_ctrl0 + s->ctrl->max_devices)) {
 
         trace_aspeed_smc_read(addr, size, s->regs[addr]);
 
@@ -1270,7 +1270,7 @@ static void aspeed_smc_write(void *opaque, hwaddr addr, uint64_t data,
         int cs = addr - s->r_ctrl0;
         aspeed_smc_flash_update_ctrl(&s->flashes[cs], value);
     } else if (addr >= R_SEG_ADDR0 &&
-               addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
+               addr < R_SEG_ADDR0 + s->ctrl->max_devices) {
         int cs = addr - R_SEG_ADDR0;
 
         if (value != s->regs[R_SEG_ADDR0 + cs]) {
@@ -1341,10 +1341,10 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
     s->conf_enable_w0 = s->ctrl->conf_enable_w0;
 
     /* Enforce some real HW limits */
-    if (s->num_cs > s->ctrl->max_slaves) {
+    if (s->num_cs > s->ctrl->max_devices) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: num_cs cannot exceed: %d\n",
-                      __func__, s->ctrl->max_slaves);
-        s->num_cs = s->ctrl->max_slaves;
+                      __func__, s->ctrl->max_devices);
+        s->num_cs = s->ctrl->max_devices;
     }
 
     /* DMA irq. Keep it first for the initialization in the SoC */
@@ -1376,7 +1376,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
                           s->ctrl->flash_window_size);
     sysbus_init_mmio(sbd, &s->mmio_flash);
 
-    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_slaves);
+    s->flashes = g_new0(AspeedSMCFlash, s->ctrl->max_devices);
 
     /*
      * Let's create a sub memory region for each possible slave. All
@@ -1385,7 +1385,7 @@ static void aspeed_smc_realize(DeviceState *dev, Error **errp)
      * module behind to handle the memory accesses. This depends on
      * the board configuration.
      */
-    for (i = 0; i < s->ctrl->max_slaves; ++i) {
+    for (i = 0; i < s->ctrl->max_devices; ++i) {
         AspeedSMCFlash *fl = &s->flashes[i];
 
         snprintf(name, sizeof(name), "%s.%d", s->ctrl->name, i);
-- 
2.26.2


