Received: from eggs.gnu.org ([2001:4830:134:3::10]:46921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsA-0003rT-Dd
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs7-0004sq-LW
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWs7-0004sT-CW
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:03 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7BE6F63E0A
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:03 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:04 +0000
Message-Id: <20170106155543.12827-9-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 08/47] trace: switch hw/char/ directory to
 modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the hw/char/ directory to include the
hw/char/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs               | 2 +-
 hw/char/Makefile.objs       | 2 ++
 hw/char/escc.c              | 2 +-
 hw/char/grlib_apbuart.c     | 2 +-
 hw/char/lm32_juart.c        | 2 +-
 hw/char/lm32_uart.c         | 2 +-
 hw/char/milkymist-uart.c    | 2 +-
 hw/char/virtio-console.c    | 2 +-
 hw/char/virtio-serial-bus.c | 2 +-
 9 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 90979b0..6cbee00 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -126,7 +126,7 @@ trace-events-subdirs += io
 trace-events-subdirs += migration
 trace-events-subdirs += block
 trace-events-subdirs += hw/block
-trace-events-y += hw/char/trace-events
+trace-events-subdirs += hw/char
 trace-events-y += hw/intc/trace-events
 trace-events-y += hw/net/trace-events
 trace-events-y += hw/virtio/trace-events
diff --git a/hw/char/Makefile.objs b/hw/char/Makefile.objs
index 69a553c..13db97f 100644
--- a/hw/char/Makefile.objs
+++ b/hw/char/Makefile.objs
@@ -26,5 +26,7 @@ common-obj-$(CONFIG_LM32) += lm32_juart.o
 common-obj-$(CONFIG_LM32) += lm32_uart.o
 common-obj-$(CONFIG_MILKYMIST) += milkymist-uart.o
 common-obj-$(CONFIG_SCLPCONSOLE) += sclpconsole.o sclpconsole-lm.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 obj-$(CONFIG_VIRTIO) += virtio-serial-bus.o
diff --git a/hw/char/escc.c b/hw/char/escc.c
index d6662dc..c3b203f 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -29,7 +29,7 @@
 #include "sysemu/char.h"
 #include "ui/console.h"
 #include "ui/input.h"
-#include "trace.h"
+#include "hw/char/trace.h"
 
 /*
  * Chipset docs:
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index db686e6..6a1f253 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -26,7 +26,7 @@
 #include "hw/sysbus.h"
 #include "sysemu/char.h"
 
-#include "trace.h"
+#include "hw/char/trace.h"
 
 #define UART_REG_SIZE 20     /* Size of memory mapped registers */
 
diff --git a/hw/char/lm32_juart.c b/hw/char/lm32_juart.c
index f8c1e0d..ec60f66 100644
--- a/hw/char/lm32_juart.c
+++ b/hw/char/lm32_juart.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/char/trace.h"
 #include "sysemu/char.h"
 
 #include "hw/char/lm32_juart.h"
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 7f3597c..9304715 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/char/trace.h"
 #include "sysemu/char.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index ae8e2f3..b13504f 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/char/trace.h"
 #include "sysemu/char.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 776205b..4267861 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -13,7 +13,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/char.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "hw/char/trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "qapi-event.h"
 
diff --git a/hw/char/virtio-serial-bus.c b/hw/char/virtio-serial-bus.c
index 7975c2c..bd6396f 100644
--- a/hw/char/virtio-serial-bus.c
+++ b/hw/char/virtio-serial-bus.c
@@ -25,7 +25,7 @@
 #include "qemu/error-report.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/char/trace.h"
 #include "hw/virtio/virtio-serial.h"
 #include "hw/virtio/virtio-access.h"
 
-- 
2.9.3
