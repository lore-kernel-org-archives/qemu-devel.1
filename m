Received: from eggs.gnu.org ([2001:4830:134:3::10]:47127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsW-0004BL-Qx
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsS-00054O-Ow
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51754)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsS-00053y-Jf
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:24 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id AF29BC05678F
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:24 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:16 +0000
Message-Id: <20170106155543.12827-21-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 20/47] trace: switch hw/dma/ directory to
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

Switch files in the hw/dma/ directory to include the
hw/dma/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs        | 2 +-
 hw/dma/Makefile.objs | 2 ++
 hw/dma/i8257.c       | 2 +-
 hw/dma/rc4030.c      | 2 +-
 hw/dma/sparc32_dma.c | 2 +-
 hw/dma/sun4m_iommu.c | 2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 2c35b95..2d56890 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -138,7 +138,7 @@ trace-events-subdirs += hw/nvram
 trace-events-subdirs += hw/display
 trace-events-subdirs += hw/input
 trace-events-subdirs += hw/timer
-trace-events-y += hw/dma/trace-events
+trace-events-subdirs += hw/dma
 trace-events-y += hw/sparc/trace-events
 trace-events-y += hw/sd/trace-events
 trace-events-y += hw/isa/trace-events
diff --git a/hw/dma/Makefile.objs b/hw/dma/Makefile.objs
index 087c8e6..c3f6aae 100644
--- a/hw/dma/Makefile.objs
+++ b/hw/dma/Makefile.objs
@@ -14,3 +14,5 @@ obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dpdma.o
 obj-$(CONFIG_OMAP) += omap_dma.o soc_dma.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_dma.o
 obj-$(CONFIG_RASPI) += bcm2835_dma.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/dma/i8257.c b/hw/dma/i8257.c
index 8bd82e8..cfc58aa 100644
--- a/hw/dma/i8257.c
+++ b/hw/dma/i8257.c
@@ -26,7 +26,7 @@
 #include "hw/isa/isa.h"
 #include "hw/isa/i8257.h"
 #include "qemu/main-loop.h"
-#include "trace.h"
+#include "hw/dma/trace.h"
 
 #define I8257(obj) \
     OBJECT_CHECK(I8257State, (obj), TYPE_I8257)
diff --git a/hw/dma/rc4030.c b/hw/dma/rc4030.c
index 17c8518..d4ec853 100644
--- a/hw/dma/rc4030.c
+++ b/hw/dma/rc4030.c
@@ -29,7 +29,7 @@
 #include "qemu/timer.h"
 #include "qemu/log.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "hw/dma/trace.h"
 
 /********************************************************/
 /* rc4030 emulation                                     */
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index 9d545e4..fc2cc94 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -30,7 +30,7 @@
 #include "hw/sparc/sparc32_dma.h"
 #include "hw/sparc/sun4m.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/dma/trace.h"
 
 /*
  * This is the DMA controller part of chip STP2000 (Master I/O), also
diff --git a/hw/dma/sun4m_iommu.c b/hw/dma/sun4m_iommu.c
index b3cbc54..b7bd15e 100644
--- a/hw/dma/sun4m_iommu.c
+++ b/hw/dma/sun4m_iommu.c
@@ -26,7 +26,7 @@
 #include "hw/sparc/sun4m.h"
 #include "hw/sysbus.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "hw/dma/trace.h"
 
 /*
  * I/O MMU used by Sun4m systems
-- 
2.9.3
