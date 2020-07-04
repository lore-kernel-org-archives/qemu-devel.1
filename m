Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E07CC433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:43:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57959208D5
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 15:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AMZJx4Fw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57959208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56694 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrkKM-0007Hh-JM
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 11:43:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40100)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGL-00012j-NO
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43326)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jrkGJ-0007UQ-L1
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 11:39:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593877171;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSSg9nfJ42WhMhBqmBHSws/rdrCKvh4AMKvzensIz1k=;
 b=AMZJx4Fw6ewal2qxw2dXp1lnqAObgZt8fmLsl68cTMBtsIIXK/SoZR2V0vOSS2nyCXt3VV
 vmP84XZ9nZ3yXywAvE/7JhI6CQD5dcAToF0KbNEwTh8rk4qERJBdfDfCt5K2+HpoOtYvDI
 Jyld0QTIRhU63VrONNGdVfZymbei+Nw=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18--MAcd7w5PyqgmV7JcZVkYw-1; Sat, 04 Jul 2020 11:39:29 -0400
X-MC-Unique: -MAcd7w5PyqgmV7JcZVkYw-1
Received: by mail-wr1-f69.google.com with SMTP id v3so6245619wrq.10
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 08:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=ZSSg9nfJ42WhMhBqmBHSws/rdrCKvh4AMKvzensIz1k=;
 b=a05VHZ1O1UqLqs1stOiTONhun5bPzqDpk91vaWrmuJ0Tc55foaws31ReFkRGzIln6x
 CtcgH7UqzTW4JL60i3pjC4h+j7m4ELEBwHpLCTRbz0xbAgoRMnTCcm1ZScnsFAJpRP38
 xhsQw8J/7zH+7sfWV8ajfG8X/p68EJMbXQzc1vwQ7ZJ0e2IjNIyIrKPQsRjLpKlAwB5X
 he8uRaY7eye0rnVY7eUWK50O+PBX0QFQG62JFMDiOYcv/6kdeg0kF1Gp+nNV6cbTDP2u
 6FgkwdhmVlV7qhEcpvUFwTSLZtMElceWnxdk+UmTzlV8pP9E5nWp/uQFHKOkwSFXdgS8
 dSfg==
X-Gm-Message-State: AOAM533hAY7UDpcJBS1CLRtIBDrjQJxWrZLLEiFbqNqRipERJcCAJ9A9
 SuTuSU7EPkqxLGxjX2Am/dgQxjMm/HJJzvABFX+ZU14bacfTKu3lXJthl+L3JA3uOfuPGp8vQYI
 XwsM0BwVJdB++xg8=
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr43870356wrm.40.1593877168058; 
 Sat, 04 Jul 2020 08:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx83m2/1x22hMaJ0Whe7Lmaiks6pmpO/OOc377SxlVOT6hqyjC195vNbSLUWPE/Ac89IqVLug==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr43870340wrm.40.1593877167780; 
 Sat, 04 Jul 2020 08:39:27 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id 33sm18326425wri.16.2020.07.04.08.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 08:39:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v2 03/23] hw/arm/omap: Emit warning when old code is used
Date: Sat,  4 Jul 2020 17:38:48 +0200
Message-Id: <20200704153908.12118-4-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200704153908.12118-1-philmd@redhat.com>
References: <20200704153908.12118-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 "Michael S. Tsirkin" <mst@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 Magnus Damm <magnus.damm@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Stafford Horne <shorne@gmail.com>, David Gibson <david@gibson.dropbear.id.au>,
 qemu-riscv@nongnu.org, Thomas Huth <huth@tuxfamily.org>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
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
index 6ba0df6b6d..db4f2ee304 100644
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


