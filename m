Return-Path: <SRS0=zEF8=7V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE38C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59B622063A
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2020 16:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e8NN9Pp9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59B622063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41340 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jiKLn-000069-Cg
	for qemu-devel@archiver.kernel.org; Mon, 08 Jun 2020 12:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37694)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDF-00068t-Sn
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:26 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26205
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jiKDD-0007cS-RJ
 for qemu-devel@nongnu.org; Mon, 08 Jun 2020 12:01:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591632082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zOI5VHRwzcrGr66pZ7m4z1ZrN3YJ34eLW3YDU+fnGv0=;
 b=e8NN9Pp9FL6qNPJlJA+nTvNNKbAd0iIofbDtRX8XTSB4dql4SBLZ+Q5foHJF+VVcdn4mXC
 bphf0u7jfPDj2DwXZhYk9ut/0k4oYmHMctDVRuBuy6O4k9HJgeBNl6oJSFSnwcVOh15Zmu
 eUWZpFz4OgBjV/94ct++srHMKxguJhY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-phweewcPMsa0DZJK4HwEXA-1; Mon, 08 Jun 2020 12:01:07 -0400
X-MC-Unique: phweewcPMsa0DZJK4HwEXA-1
Received: by mail-wr1-f70.google.com with SMTP id w16so7325429wru.18
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2020 09:01:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zOI5VHRwzcrGr66pZ7m4z1ZrN3YJ34eLW3YDU+fnGv0=;
 b=tA1EcLJ4QKX/6av9vvC/rZsMQzLqhTZBb6U2ViPbb3DVoQKIQbqkGWSxfiTSdoJeWV
 Gr/a0t20D0SzoxYjkQmzYmi3qrsuCNaRW0dE0lDmb6EytJNyhHIvUAXrcTQD2SteiDiX
 5O4cYRNCEFdp9GU/YwUb+CvFuz/jil5PUlRmEmdD4uuuEJzqXg/F/16JaWndWkl3Ob9p
 IsDjwsr+IKV0HCf1HTXMA9jn7KeaO9cAc+hcrEgl90LDyK5o9JxEC/0qdEEezYkS+xoI
 LQi6/NlYDJAJhahkdZ23Y+LjKQtSBBIIp0QqkAOuFgJ+45b/k3Q9A9+PFn2cQksjURZT
 /asg==
X-Gm-Message-State: AOAM532PnzsE79LhjjiE5dvLP4qHGQAMPqDNDS9hbAAEoJ/TWbECUivB
 hDQzsSWw1umnVkZZG60meRwEAvOKJIsPss/VfGjFSQiyyNMSKBOwnfnN0P6wN4ml3ejF/D9WKIZ
 HSzZY9NtxdMARz1M=
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr32549wmf.69.1591632065215;
 Mon, 08 Jun 2020 09:01:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJziXMXpu2PAmMIx7aoFkuYgVgPaKI7cmN6JuMa+/KlQ6vvO4eQND3agEj8WsVM887NYLfsrYQ==
X-Received: by 2002:a1c:c3d7:: with SMTP id t206mr32465wmf.69.1591632064493;
 Mon, 08 Jun 2020 09:01:04 -0700 (PDT)
Received: from localhost.localdomain
 (181.red-88-10-103.dynamicip.rima-tde.net. [88.10.103.181])
 by smtp.gmail.com with ESMTPSA id y5sm160041wrs.63.2020.06.08.09.01.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2020 09:01:03 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH 03/35] hw/arm/omap: Emit warning when old code is used
Date: Mon,  8 Jun 2020 18:00:12 +0200
Message-Id: <20200608160044.15531-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200608160044.15531-1-philmd@redhat.com>
References: <20200608160044.15531-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/08 05:40:56
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Max Filippov <jcmvbkbc@gmail.com>, Alistair Francis <Alistair.Francis@wdc.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>,
 Magnus Damm <magnus.damm@gmail.com>, Markus Armbruster <armbru@redhat.com>,
 Anthony Perard <anthony.perard@citrix.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Stafford Horne <shorne@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <rth@twiddle.net>,
 "Daniel P . Berrange" <berrange@redhat.com>, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This code hasn't been QOM'ified yet. Warn the user.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/arm/omap1.c            | 6 ++++++
 hw/char/omap_uart.c       | 5 +++++
 hw/misc/omap_gpmc.c       | 3 +++
 hw/misc/omap_l4.c         | 3 +++
 hw/misc/omap_sdrc.c       | 3 +++
 hw/sd/omap_mmc.c          | 5 +++++
 hw/ssi/omap_spi.c         | 3 +++
 hw/timer/omap_synctimer.c | 4 ++++
 8 files changed, 32 insertions(+)

diff --git a/hw/arm/omap1.c b/hw/arm/omap1.c
index 761cc17ea9..d7d6253be0 100644
--- a/hw/arm/omap1.c
+++ b/hw/arm/omap1.c
@@ -40,6 +40,7 @@
 #include "hw/sysbus.h"
 #include "qemu/cutils.h"
 #include "qemu/bcd.h"
+#include "hw/qdev-deprecated.h"
 
 static inline void omap_log_badwidth(const char *funcname, hwaddr addr, int sz)
 {
@@ -1451,6 +1452,7 @@ static struct dpll_ctl_s  *omap_dpll_init(MemoryRegion *memory,
                            hwaddr base, omap_clk clk)
 {
     struct dpll_ctl_s *s = g_malloc0(sizeof(*s));
+    qdev_warn_deprecated_function_used();
     memory_region_init_io(&s->iomem, NULL, &omap_dpll_ops, s, "omap-dpll", 0x100);
 
     s->dpll = clk;
@@ -2427,6 +2429,8 @@ static struct omap_pwl_s *omap_pwl_init(MemoryRegion *system_memory,
 {
     struct omap_pwl_s *s = g_malloc0(sizeof(*s));
 
+    qdev_warn_deprecated_function_used();
+
     omap_pwl_reset(s);
 
     memory_region_init_io(&s->iomem, NULL, &omap_pwl_ops, s,
@@ -2534,6 +2538,8 @@ static struct omap_pwt_s *omap_pwt_init(MemoryRegion *system_memory,
                                         omap_clk clk)
 {
     struct omap_pwt_s *s = g_malloc0(sizeof(*s));
+
+    qdev_warn_deprecated_function_used();
     s->clk = clk;
     omap_pwt_reset(s);
 
diff --git a/hw/char/omap_uart.c b/hw/char/omap_uart.c
index e8da933378..7e106772ce 100644
--- a/hw/char/omap_uart.c
+++ b/hw/char/omap_uart.c
@@ -22,6 +22,7 @@
 #include "hw/arm/omap.h"
 #include "hw/char/serial.h"
 #include "exec/address-spaces.h"
+#include "hw/qdev-deprecated.h"
 
 /* UARTs */
 struct omap_uart_s {
@@ -57,6 +58,8 @@ struct omap_uart_s *omap_uart_init(hwaddr base,
 {
     struct omap_uart_s *s = g_new0(struct omap_uart_s, 1);
 
+    qdev_warn_deprecated_function_used();
+
     s->base = base;
     s->fclk = fclk;
     s->irq = irq;
@@ -168,6 +171,8 @@ struct omap_uart_s *omap2_uart_init(MemoryRegion *sysmem,
     struct omap_uart_s *s = omap_uart_init(base, irq,
                     fclk, iclk, txdma, rxdma, label, chr);
 
+    qdev_warn_deprecated_function_used();
+
     memory_region_init_io(&s->iomem, NULL, &omap_uart_ops, s, "omap.uart", 0x100);
 
     s->ta = ta;
diff --git a/hw/misc/omap_gpmc.c b/hw/misc/omap_gpmc.c
index 10de7a5523..9e29d7a8bd 100644
--- a/hw/misc/omap_gpmc.c
+++ b/hw/misc/omap_gpmc.c
@@ -25,6 +25,7 @@
 #include "hw/arm/omap.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
+#include "hw/qdev-deprecated.h"
 
 /* General-Purpose Memory Controller */
 struct omap_gpmc_s {
@@ -830,6 +831,8 @@ struct omap_gpmc_s *omap_gpmc_init(struct omap_mpu_state_s *mpu,
     int cs;
     struct omap_gpmc_s *s = g_new0(struct omap_gpmc_s, 1);
 
+    qdev_warn_deprecated_function_used();
+
     memory_region_init_io(&s->iomem, NULL, &omap_gpmc_ops, s, "omap-gpmc", 0x1000);
     memory_region_add_subregion(get_system_memory(), base, &s->iomem);
 
diff --git a/hw/misc/omap_l4.c b/hw/misc/omap_l4.c
index 54aeaecd69..b412790c19 100644
--- a/hw/misc/omap_l4.c
+++ b/hw/misc/omap_l4.c
@@ -19,6 +19,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/arm/omap.h"
+#include "hw/qdev-deprecated.h"
 
 struct omap_l4_s {
     MemoryRegion *address_space;
@@ -33,6 +34,8 @@ struct omap_l4_s *omap_l4_init(MemoryRegion *address_space,
     struct omap_l4_s *bus = g_malloc0(
                     sizeof(*bus) + ta_num * sizeof(*bus->ta));
 
+    qdev_warn_deprecated_function_used();
+
     bus->address_space = address_space;
     bus->ta_num = ta_num;
     bus->base = base;
diff --git a/hw/misc/omap_sdrc.c b/hw/misc/omap_sdrc.c
index f2f72f6810..4f8440ea56 100644
--- a/hw/misc/omap_sdrc.c
+++ b/hw/misc/omap_sdrc.c
@@ -19,6 +19,7 @@
  */
 #include "qemu/osdep.h"
 #include "hw/arm/omap.h"
+#include "hw/qdev-deprecated.h"
 
 /* SDRAM Controller Subsystem */
 struct omap_sdrc_s {
@@ -159,6 +160,8 @@ struct omap_sdrc_s *omap_sdrc_init(MemoryRegion *sysmem,
 {
     struct omap_sdrc_s *s = g_new0(struct omap_sdrc_s, 1);
 
+    qdev_warn_deprecated_function_used();
+
     omap_sdrc_reset(s);
 
     memory_region_init_io(&s->iomem, NULL, &omap_sdrc_ops, s, "omap.sdrc", 0x1000);
diff --git a/hw/sd/omap_mmc.c b/hw/sd/omap_mmc.c
index 4088a8a80b..88fd20e17a 100644
--- a/hw/sd/omap_mmc.c
+++ b/hw/sd/omap_mmc.c
@@ -24,6 +24,7 @@
 #include "hw/irq.h"
 #include "hw/arm/omap.h"
 #include "hw/sd/sd.h"
+#include "hw/qdev-deprecated.h"
 
 struct omap_mmc_s {
     qemu_irq irq;
@@ -599,6 +600,8 @@ struct omap_mmc_s *omap_mmc_init(hwaddr base,
 {
     struct omap_mmc_s *s = g_new0(struct omap_mmc_s, 1);
 
+    qdev_warn_deprecated_function_used();
+
     s->irq = irq;
     s->dma = dma;
     s->clk = clk;
@@ -625,6 +628,8 @@ struct omap_mmc_s *omap2_mmc_init(struct omap_target_agent_s *ta,
 {
     struct omap_mmc_s *s = g_new0(struct omap_mmc_s, 1);
 
+    qdev_warn_deprecated_function_used();
+
     s->irq = irq;
     s->dma = dma;
     s->clk = fclk;
diff --git a/hw/ssi/omap_spi.c b/hw/ssi/omap_spi.c
index 7c7e689707..276f963ae2 100644
--- a/hw/ssi/omap_spi.c
+++ b/hw/ssi/omap_spi.c
@@ -25,6 +25,7 @@
 #include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/arm/omap.h"
+#include "hw/qdev-deprecated.h"
 
 /* Multichannel SPI */
 struct omap_mcspi_s {
@@ -353,6 +354,8 @@ struct omap_mcspi_s *omap_mcspi_init(struct omap_target_agent_s *ta, int chnum,
     struct omap_mcspi_s *s = g_new0(struct omap_mcspi_s, 1);
     struct omap_mcspi_ch_s *ch = s->ch;
 
+    qdev_warn_deprecated_function_used();
+
     s->irq = irq;
     s->chnum = chnum;
     while (chnum --) {
diff --git a/hw/timer/omap_synctimer.c b/hw/timer/omap_synctimer.c
index 72b997939b..4be24e970e 100644
--- a/hw/timer/omap_synctimer.c
+++ b/hw/timer/omap_synctimer.c
@@ -20,6 +20,8 @@
 #include "qemu/osdep.h"
 #include "qemu/timer.h"
 #include "hw/arm/omap.h"
+#include "hw/qdev-deprecated.h"
+
 struct omap_synctimer_s {
     MemoryRegion iomem;
     uint32_t val;
@@ -101,6 +103,8 @@ struct omap_synctimer_s *omap_synctimer_init(struct omap_target_agent_s *ta,
 {
     struct omap_synctimer_s *s = g_malloc0(sizeof(*s));
 
+    qdev_warn_deprecated_function_used();
+
     omap_synctimer_reset(s);
     memory_region_init_io(&s->iomem, NULL, &omap_synctimer_ops, s, "omap.synctimer",
                           omap_l4_region_size(ta, 0));
-- 
2.21.3


