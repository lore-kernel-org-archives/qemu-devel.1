Return-Path: <SRS0=VLgg=X4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F27C10F14
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAB532086A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2019 23:29:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAB532086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGAXf-0000tG-Qg
	for qemu-devel@archiver.kernel.org; Thu, 03 Oct 2019 19:29:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46767)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iGABR-00027v-9k
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:06:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iGABP-00070B-QU
 for qemu-devel@nongnu.org; Thu, 03 Oct 2019 19:06:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60304)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1iGABM-0006yG-OS; Thu, 03 Oct 2019 19:06:48 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BA33F308FE8F;
 Thu,  3 Oct 2019 23:06:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-21.brq.redhat.com [10.40.204.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5105C10013A7;
 Thu,  3 Oct 2019 23:06:38 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/14] hw: Move Aspeed RTC from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri,  4 Oct 2019 01:04:01 +0200
Message-Id: <20191003230404.19384-12-philmd@redhat.com>
In-Reply-To: <20191003230404.19384-1-philmd@redhat.com>
References: <20191003230404.19384-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.49]); Thu, 03 Oct 2019 23:06:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Aleksandar Rikalo <arikalo@wavecomp.com>, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>,
 Andrew Jeffery <andrew@aj.id.au>, qemu-trivial@nongnu.org, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move RTC devices under the hw/rtc/ subdirectory.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/rtc/Makefile.objs                   | 1 +
 hw/{timer =3D> rtc}/aspeed_rtc.c         | 2 +-
 hw/rtc/trace-events                    | 4 ++++
 hw/timer/Makefile.objs                 | 2 +-
 hw/timer/trace-events                  | 4 ----
 include/hw/arm/aspeed_soc.h            | 2 +-
 include/hw/{timer =3D> rtc}/aspeed_rtc.h | 6 +++---
 7 files changed, 11 insertions(+), 10 deletions(-)
 rename hw/{timer =3D> rtc}/aspeed_rtc.c (99%)
 rename include/hw/{timer =3D> rtc}/aspeed_rtc.h (84%)

diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 3d4763fc26..8dc9fcd3a9 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -10,3 +10,4 @@ common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
 common-obj-$(CONFIG_EXYNOS4) +=3D exynos4210_rtc.o
 obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
+common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_rtc.o
diff --git a/hw/timer/aspeed_rtc.c b/hw/rtc/aspeed_rtc.c
similarity index 99%
rename from hw/timer/aspeed_rtc.c
rename to hw/rtc/aspeed_rtc.c
index 5313017353..3ca1183558 100644
--- a/hw/timer/aspeed_rtc.c
+++ b/hw/rtc/aspeed_rtc.c
@@ -8,7 +8,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/timer/aspeed_rtc.h"
+#include "hw/rtc/aspeed_rtc.h"
 #include "migration/vmstate.h"
 #include "qemu/log.h"
 #include "qemu/timer.h"
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index 7f1945ad4c..d6749f4616 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -13,3 +13,7 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x =
value 0x%08x"
 pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_alarm_raised(void) "alarm raised"
 pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
+
+# aspeed-rtc.c
+aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
+aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 33191d74cb..83091770df 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -29,7 +29,7 @@ common-obj-$(CONFIG_MIPS_CPS) +=3D mips_gictimer.o
 common-obj-$(CONFIG_ALLWINNER_A10_PIT) +=3D allwinner-a10-pit.o
=20
 common-obj-$(CONFIG_STM32F2XX_TIMER) +=3D stm32f2xx_timer.o
-common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o aspeed_rtc.o
+common-obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_timer.o
=20
 common-obj-$(CONFIG_CMSDK_APB_TIMER) +=3D cmsdk-apb-timer.o
 common-obj-$(CONFIG_CMSDK_APB_DUALTIMER) +=3D cmsdk-apb-dualtimer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index 1459d07237..e18b87fc96 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -66,10 +66,6 @@ cmsdk_apb_dualtimer_read(uint64_t offset, uint64_t dat=
a, unsigned size) "CMSDK A
 cmsdk_apb_dualtimer_write(uint64_t offset, uint64_t data, unsigned size)=
 "CMSDK APB dualtimer write: offset 0x%" PRIx64 " data 0x%" PRIx64 " size=
 %u"
 cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: reset"
=20
-# hw/timer/aspeed-rtc.c
-aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
-aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
-
 # nrf51_timer.c
 nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read add=
r 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write a=
ddr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
diff --git a/include/hw/arm/aspeed_soc.h b/include/hw/arm/aspeed_soc.h
index ab5052b12c..5a443006ed 100644
--- a/include/hw/arm/aspeed_soc.h
+++ b/include/hw/arm/aspeed_soc.h
@@ -17,7 +17,7 @@
 #include "hw/misc/aspeed_sdmc.h"
 #include "hw/misc/aspeed_xdma.h"
 #include "hw/timer/aspeed_timer.h"
-#include "hw/timer/aspeed_rtc.h"
+#include "hw/rtc/aspeed_rtc.h"
 #include "hw/i2c/aspeed_i2c.h"
 #include "hw/ssi/aspeed_smc.h"
 #include "hw/watchdog/wdt_aspeed.h"
diff --git a/include/hw/timer/aspeed_rtc.h b/include/hw/rtc/aspeed_rtc.h
similarity index 84%
rename from include/hw/timer/aspeed_rtc.h
rename to include/hw/rtc/aspeed_rtc.h
index 15ba42912b..3fde854ad9 100644
--- a/include/hw/timer/aspeed_rtc.h
+++ b/include/hw/rtc/aspeed_rtc.h
@@ -5,8 +5,8 @@
  * Copyright 2019 IBM Corp
  * SPDX-License-Identifier: GPL-2.0-or-later
  */
-#ifndef ASPEED_RTC_H
-#define ASPEED_RTC_H
+#ifndef HW_RTC_ASPEED_RTC_H
+#define HW_RTC_ASPEED_RTC_H
=20
 #include <stdint.h>
=20
@@ -27,4 +27,4 @@ typedef struct AspeedRtcState {
 #define TYPE_ASPEED_RTC "aspeed.rtc"
 #define ASPEED_RTC(obj) OBJECT_CHECK(AspeedRtcState, (obj), TYPE_ASPEED_=
RTC)
=20
-#endif /* ASPEED_RTC_H */
+#endif /* HW_RTC_ASPEED_RTC_H */
--=20
2.20.1


