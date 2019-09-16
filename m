Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C96E3C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56B1120678
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 16:08:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56B1120678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9tYE-0001Ey-1M
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 12:08:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35256)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1i9tGD-0008HD-UF
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:49:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1i9tGC-0001jD-60
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 11:49:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48544)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1i9tG8-0001hT-4z; Mon, 16 Sep 2019 11:49:48 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2A0333084037;
 Mon, 16 Sep 2019 15:49:47 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-115.brq.redhat.com [10.40.204.115])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 466D5194BB;
 Mon, 16 Sep 2019 15:49:27 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Mon, 16 Sep 2019 17:48:36 +0200
Message-Id: <20190916154847.28936-3-philmd@redhat.com>
In-Reply-To: <20190916154847.28936-1-philmd@redhat.com>
References: <20190916154847.28936-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.40]); Mon, 16 Sep 2019 15:49:47 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 02/13] hw: Move PL031 device from hw/timer/ to
 hw/rtc/ subdirectory
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

The PL031 is a Real Time Clock, not a timer.
Move it under the hw/rtc/ subdirectory.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 MAINTAINERS                       | 4 ++--
 Makefile.objs                     | 1 +
 hw/Kconfig                        | 1 +
 hw/Makefile.objs                  | 1 +
 hw/arm/musca.c                    | 2 +-
 hw/rtc/Kconfig                    | 2 ++
 hw/rtc/Makefile.objs              | 1 +
 hw/{timer =3D> rtc}/pl031.c         | 2 +-
 hw/rtc/trace-events               | 8 ++++++++
 hw/timer/Kconfig                  | 3 ---
 hw/timer/Makefile.objs            | 1 -
 hw/timer/trace-events             | 7 -------
 include/hw/{timer =3D> rtc}/pl031.h | 5 +++--
 13 files changed, 21 insertions(+), 17 deletions(-)
 create mode 100644 hw/rtc/Kconfig
 create mode 100644 hw/rtc/Makefile.objs
 rename hw/{timer =3D> rtc}/pl031.c (99%)
 create mode 100644 hw/rtc/trace-events
 rename include/hw/{timer =3D> rtc}/pl031.h (93%)

diff --git a/MAINTAINERS b/MAINTAINERS
index f0e30b5248..5562d2c6d0 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -495,8 +495,8 @@ F: hw/intc/pl190.c
 F: hw/sd/pl181.c
 F: hw/ssi/pl022.c
 F: include/hw/ssi/pl022.h
-F: hw/timer/pl031.c
-F: include/hw/timer/pl031.h
+F: hw/rtc/pl031.c
+F: include/hw/rtc/pl031.h
 F: include/hw/arm/primecell.h
 F: hw/timer/cmsdk-apb-timer.c
 F: include/hw/timer/cmsdk-apb-timer.h
diff --git a/Makefile.objs b/Makefile.objs
index 6a143dcd57..1bcde315f7 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -173,6 +173,7 @@ trace-events-subdirs +=3D hw/pci-host
 trace-events-subdirs +=3D hw/ppc
 trace-events-subdirs +=3D hw/rdma
 trace-events-subdirs +=3D hw/rdma/vmw
+trace-events-subdirs +=3D hw/rtc
 trace-events-subdirs +=3D hw/s390x
 trace-events-subdirs +=3D hw/scsi
 trace-events-subdirs +=3D hw/sd
diff --git a/hw/Kconfig b/hw/Kconfig
index b45db3c813..4b53fee4d0 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -27,6 +27,7 @@ source pci-host/Kconfig
 source pcmcia/Kconfig
 source pci/Kconfig
 source rdma/Kconfig
+source rtc/Kconfig
 source scsi/Kconfig
 source sd/Kconfig
 source semihosting/Kconfig
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index ece6cc3755..fd9750e5f2 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -26,6 +26,7 @@ devices-dirs-y +=3D nvram/
 devices-dirs-y +=3D pci/
 devices-dirs-$(CONFIG_PCI) +=3D pci-bridge/ pci-host/
 devices-dirs-y +=3D pcmcia/
+devices-dirs-y +=3D rtc/
 devices-dirs-$(CONFIG_SCSI) +=3D scsi/
 devices-dirs-y +=3D sd/
 devices-dirs-y +=3D ssi/
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index 68db4b5b38..ba99dd1941 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -32,7 +32,7 @@
 #include "hw/misc/tz-mpc.h"
 #include "hw/misc/tz-ppc.h"
 #include "hw/misc/unimp.h"
-#include "hw/timer/pl031.h"
+#include "hw/rtc/pl031.h"
=20
 #define MUSCA_NUMIRQ_MAX 96
 #define MUSCA_PPC_MAX 3
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
new file mode 100644
index 0000000000..8a4383bca9
--- /dev/null
+++ b/hw/rtc/Kconfig
@@ -0,0 +1,2 @@
+config PL031
+    bool
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
new file mode 100644
index 0000000000..3e1eb42563
--- /dev/null
+++ b/hw/rtc/Makefile.objs
@@ -0,0 +1 @@
+common-obj-$(CONFIG_PL031) +=3D pl031.o
diff --git a/hw/timer/pl031.c b/hw/rtc/pl031.c
similarity index 99%
rename from hw/timer/pl031.c
rename to hw/rtc/pl031.c
index 2b3e261006..3a982752a2 100644
--- a/hw/timer/pl031.c
+++ b/hw/rtc/pl031.c
@@ -13,7 +13,7 @@
=20
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "hw/timer/pl031.h"
+#include "hw/rtc/pl031.h"
 #include "migration/vmstate.h"
 #include "hw/irq.h"
 #include "hw/qdev-properties.h"
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
new file mode 100644
index 0000000000..54c94ac557
--- /dev/null
+++ b/hw/rtc/trace-events
@@ -0,0 +1,8 @@
+# See docs/devel/tracing.txt for syntax documentation.
+
+# pl031.c
+pl031_irq_state(int level) "irq state %d"
+pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
+pl031_alarm_raised(void) "alarm raised"
+pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index eefc95f35e..27c5dce09e 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -27,9 +27,6 @@ config M41T80
 config M48T59
     bool
=20
-config PL031
-    bool
-
 config TWL92230
     bool
     depends on I2C
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index f407523aa4..9f64f6e11e 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -11,7 +11,6 @@ common-obj-$(CONFIG_M48T59) +=3D m48t59.o
 ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) +=3D m48t59-isa.o
 endif
-common-obj-$(CONFIG_PL031) +=3D pl031.o
 common-obj-$(CONFIG_PUV3) +=3D puv3_ost.o
 common-obj-$(CONFIG_TWL92230) +=3D twl92230.o
 common-obj-$(CONFIG_XILINX) +=3D xilinx_timer.o
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index db02a9142c..6936fe8573 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -80,10 +80,3 @@ xlnx_zynqmp_rtc_gettime(int year, int month, int day, =
int hour, int min, int sec
 # nrf51_timer.c
 nrf51_timer_read(uint64_t addr, uint32_t value, unsigned size) "read add=
r 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
 nrf51_timer_write(uint64_t addr, uint32_t value, unsigned size) "write a=
ddr 0x%" PRIx64 " data 0x%" PRIx32 " size %u"
-
-# pl031.c
-pl031_irq_state(int level) "irq state %d"
-pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
-pl031_alarm_raised(void) "alarm raised"
-pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
diff --git a/include/hw/timer/pl031.h b/include/hw/rtc/pl031.h
similarity index 93%
rename from include/hw/timer/pl031.h
rename to include/hw/rtc/pl031.h
index 8c3f555ee2..e3cb1d646f 100644
--- a/include/hw/timer/pl031.h
+++ b/include/hw/rtc/pl031.h
@@ -11,10 +11,11 @@
  * GNU GPL, version 2 or (at your option) any later version.
  */
=20
-#ifndef HW_TIMER_PL031_H
-#define HW_TIMER_PL031_H
+#ifndef HW_RTC_PL031_H
+#define HW_RTC_PL031_H
=20
 #include "hw/sysbus.h"
+#include "qemu/timer.h"
=20
 #define TYPE_PL031 "pl031"
 #define PL031(obj) OBJECT_CHECK(PL031State, (obj), TYPE_PL031)
--=20
2.20.1


