Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C1DC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:58:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 263C9214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 15:58:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 263C9214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tOI-0000Rz-AJ
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 11:58:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35778)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9tIE-0002hm-Jj
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:52:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9tIC-0002Ri-UN
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:51:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i9tI9-0002QF-6D; Mon, 16 Sep 2019 11:51:53 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4E631307CB3F;
 Mon, 16 Sep 2019 15:51:52 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 55C4E196AE;
 Mon, 16 Sep 2019 15:51:30 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 17:48:43 +0200
Message-Id: <20190916154847.28936-10-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-1-philmd@redhat.com>
References: <20190916154847.28936-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Mon, 16 Sep 2019 15:51:52 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 09/13] hw: Move Xilinx ZynqMP RTC from
 hw/timer/ to hw/rtc/ subdirectory
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
 Andrew Jeffery <andrew@aj.id.au>, qemu-ppc@nongnu.org,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Igor Mammedov <imammedo@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move RTC devices under the hw/rtc/ subdirectory.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/rtc/Makefile.objs                        | 1 +
 hw/rtc/trace-events                         | 3 +++
 hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.c         | 2 +-
 hw/timer/Makefile.objs                      | 1 -
 hw/timer/trace-events                       | 3 ---
 include/hw/arm/xlnx-zynqmp.h                | 2 +-
 include/hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.h | 6 +++---
 7 files changed, 9 insertions(+), 9 deletions(-)
 rename hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.c (99%)
 rename include/hw/{timer =3D> rtc}/xlnx-zynqmp-rtc.h (95%)

diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index b195863291..543a550a0f 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -6,5 +6,6 @@ common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
 endif
 common-obj-$(CONFIG_PL031) +=3D pl031.o
 common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
+common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
 obj-$(CONFIG_MC146818RTC) +=3D mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) +=3D sun4v-rtc.o
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index ac9e0e0fba..7f1945ad4c 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -4,6 +4,9 @@
 sun4v_rtc_read(uint64_t addr, uint64_t value) "read: addr 0x%" PRIx64 " =
value 0x%" PRIx64
 sun4v_rtc_write(uint64_t addr, uint64_t value) "write: addr 0x%" PRIx64 =
" value 0x%" PRIx64
=20
+# xlnx-zynqmp-rtc.c
+xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
+
 # pl031.c
 pl031_irq_state(int level) "irq state %d"
 pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
diff --git a/hw/timer/xlnx-zynqmp-rtc.c b/hw/rtc/xlnx-zynqmp-rtc.c
similarity index 99%
rename from hw/timer/xlnx-zynqmp-rtc.c
rename to hw/rtc/xlnx-zynqmp-rtc.c
index 5692db98c2..f9f09b7296 100644
--- a/hw/timer/xlnx-zynqmp-rtc.c
+++ b/hw/rtc/xlnx-zynqmp-rtc.c
@@ -36,7 +36,7 @@
 #include "qemu/cutils.h"
 #include "sysemu/sysemu.h"
 #include "trace.h"
-#include "hw/timer/xlnx-zynqmp-rtc.h"
+#include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "migration/vmstate.h"
=20
 #ifndef XLNX_ZYNQMP_RTC_ERR_DEBUG
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 70b61b69c7..294465ef47 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -14,7 +14,6 @@ common-obj-$(CONFIG_IMX) +=3D imx_epit.o
 common-obj-$(CONFIG_IMX) +=3D imx_gpt.o
 common-obj-$(CONFIG_LM32) +=3D lm32_timer.o
 common-obj-$(CONFIG_MILKYMIST) +=3D milkymist-sysctl.o
-common-obj-$(CONFIG_XLNX_ZYNQMP) +=3D xlnx-zynqmp-rtc.o
 common-obj-$(CONFIG_NRF51_SOC) +=3D nrf51_timer.o
=20
 common-obj-$(CONFIG_ALTERA_TIMER) +=3D altera_timer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index ce34b967db..1459d07237 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -70,9 +70,6 @@ cmsdk_apb_dualtimer_reset(void) "CMSDK APB dualtimer: r=
eset"
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " val=
ue 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " va=
lue 0x%08" PRIx64
=20
-# xlnx-zynqmp-rtc.c
-xlnx_zynqmp_rtc_gettime(int year, int month, int day, int hour, int min,=
 int sec) "Get time from host: %d-%d-%d %2d:%02d:%02d"
-
 # nrf51_timer.c
 nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read add=
r 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write a=
ddr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
diff --git a/include/hw/arm/xlnx-zynqmp.h b/include/hw/arm/xlnx-zynqmp.h
index d7483c3b42..53076fa29a 100644
--- a/include/hw/arm/xlnx-zynqmp.h
+++ b/include/hw/arm/xlnx-zynqmp.h
@@ -29,7 +29,7 @@
 #include "hw/dma/xlnx-zdma.h"
 #include "hw/display/xlnx_dp.h"
 #include "hw/intc/xlnx-zynqmp-ipi.h"
-#include "hw/timer/xlnx-zynqmp-rtc.h"
+#include "hw/rtc/xlnx-zynqmp-rtc.h"
 #include "hw/cpu/cluster.h"
 #include "target/arm/cpu.h"
=20
diff --git a/include/hw/timer/xlnx-zynqmp-rtc.h b/include/hw/rtc/xlnx-zyn=
qmp-rtc.h
similarity index 95%
rename from include/hw/timer/xlnx-zynqmp-rtc.h
rename to include/hw/rtc/xlnx-zynqmp-rtc.h
index 97e32322ed..6fa1cb2f43 100644
--- a/include/hw/timer/xlnx-zynqmp-rtc.h
+++ b/include/hw/rtc/xlnx-zynqmp-rtc.h
@@ -3,7 +3,7 @@
  *
  * Copyright (c) 2017 Xilinx Inc.
  *
- * Written-by: Alistair Francis <alistair.francis@xilinx.com>
+ * Written-by: Alistair Francis
  *
  * Permission is hereby granted, free of charge, to any person obtaining=
 a copy
  * of this software and associated documentation files (the "Software"),=
 to deal
@@ -24,8 +24,8 @@
  * THE SOFTWARE.
  */
=20
-#ifndef HW_TIMER_XLNX_ZYNQMP_RTC_H
-#define HW_TIMER_XLNX_ZYNQMP_RTC_H
+#ifndef HW_RTC_XLNX_ZYNQMP_H
+#define HW_RTC_XLNX_ZYNQMP_H
=20
 #include "hw/register.h"
 #include "hw/sysbus.h"
--=20
2.20.1


