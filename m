Received: from eggs.gnu.org ([2001:4830:134:3::10]:47090)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsR-00047y-RV
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsQ-00053F-NY
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58792)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsQ-00052s-FF
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:22 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 920B861963
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:22 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:15 +0000
Message-Id: <20170106155543.12827-20-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 19/47] trace: switch hw/timer/ directory to
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

Switch files in the hw/timer/ directory to include the
hw/timer/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs               | 2 +-
 hw/timer/Makefile.objs      | 2 ++
 hw/timer/aspeed_timer.c     | 2 +-
 hw/timer/grlib_gptimer.c    | 2 +-
 hw/timer/lm32_timer.c       | 2 +-
 hw/timer/milkymist-sysctl.c | 2 +-
 hw/timer/slavio_timer.c     | 2 +-
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 3ae5085..2c35b95 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -137,7 +137,7 @@ trace-events-subdirs += hw/scsi
 trace-events-subdirs += hw/nvram
 trace-events-subdirs += hw/display
 trace-events-subdirs += hw/input
-trace-events-y += hw/timer/trace-events
+trace-events-subdirs += hw/timer
 trace-events-y += hw/dma/trace-events
 trace-events-y += hw/sparc/trace-events
 trace-events-y += hw/sd/trace-events
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 7ba8c23..e764fc1 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -34,3 +34,5 @@ obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/timer/aspeed_timer.c b/hw/timer/aspeed_timer.c
index 9b70ee0..081e160 100644
--- a/hw/timer/aspeed_timer.c
+++ b/hw/timer/aspeed_timer.c
@@ -16,7 +16,7 @@
 #include "qemu/bitops.h"
 #include "qemu/timer.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "hw/timer/trace.h"
 
 #define TIMER_NR_REGS 4
 
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index 4ed96e9..fbd81d4 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -28,7 +28,7 @@
 #include "hw/ptimer.h"
 #include "qemu/main-loop.h"
 
-#include "trace.h"
+#include "hw/timer/trace.h"
 
 #define UNIT_REG_SIZE    16     /* Size of memory mapped regs for the unit */
 #define GPTIMER_REG_SIZE 16     /* Size of memory mapped regs for a GPTimer */
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 2a07b59..003c68c 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/timer/trace.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index 4488590..635b179 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -25,7 +25,7 @@
 #include "hw/hw.h"
 #include "hw/sysbus.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/timer/trace.h"
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "qemu/error-report.h"
diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
index bfee1f3..d9ac437 100644
--- a/hw/timer/slavio_timer.c
+++ b/hw/timer/slavio_timer.c
@@ -27,7 +27,7 @@
 #include "qemu/timer.h"
 #include "hw/ptimer.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/timer/trace.h"
 #include "qemu/main-loop.h"
 
 /*
-- 
2.9.3
