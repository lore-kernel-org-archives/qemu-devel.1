Received: from eggs.gnu.org ([2001:4830:134:3::10]:47004)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsG-0003xi-Jz
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsF-0004xe-OL
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsF-0004wu-G1
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:11 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8EF8F46291
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:11 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:09 +0000
Message-Id: <20170106155543.12827-14-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/47] trace: switch hw/misc/ directory to
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

Switch files in the hw/misc/ directory to include the
hw/misc/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs             | 2 +-
 hw/misc/Makefile.objs     | 3 +++
 hw/misc/aspeed_scu.c      | 2 +-
 hw/misc/eccmemctl.c       | 2 +-
 hw/misc/milkymist-hpdmc.c | 2 +-
 hw/misc/milkymist-pfpu.c  | 2 +-
 hw/misc/slavio_misc.c     | 2 +-
 7 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 41ab795..85c412a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -131,7 +131,7 @@ trace-events-subdirs += hw/intc
 trace-events-subdirs += hw/net
 trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/audio
-trace-events-y += hw/misc/trace-events
+trace-events-subdirs += hw/misc
 trace-events-y += hw/usb/trace-events
 trace-events-y += hw/scsi/trace-events
 trace-events-y += hw/nvram/trace-events
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index 1a89615..ccee974 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -53,3 +53,6 @@ obj-$(CONFIG_EDU) += edu.o
 obj-$(CONFIG_HYPERV_TESTDEV) += hyperv_testdev.o
 obj-$(CONFIG_AUX) += auxbus.o
 obj-$(CONFIG_ASPEED_SOC) += aspeed_scu.o aspeed_sdmc.o
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/misc/aspeed_scu.c b/hw/misc/aspeed_scu.c
index 95022d3..36f50d1 100644
--- a/hw/misc/aspeed_scu.c
+++ b/hw/misc/aspeed_scu.c
@@ -16,7 +16,7 @@
 #include "qapi/visitor.h"
 #include "qemu/bitops.h"
 #include "qemu/log.h"
-#include "trace.h"
+#include "hw/misc/trace.h"
 
 #define TO_REG(offset) ((offset) >> 2)
 
diff --git a/hw/misc/eccmemctl.c b/hw/misc/eccmemctl.c
index a0071f3..a0424f9 100644
--- a/hw/misc/eccmemctl.c
+++ b/hw/misc/eccmemctl.c
@@ -24,7 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/misc/trace.h"
 
 /* There are 3 versions of this chip used in SMP sun4m systems:
  * MCC (version 0, implementation 0) SS-600MP
diff --git a/hw/misc/milkymist-hpdmc.c b/hw/misc/milkymist-hpdmc.c
index e6140ee..8596437 100644
--- a/hw/misc/milkymist-hpdmc.c
+++ b/hw/misc/milkymist-hpdmc.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/misc/trace.h"
 #include "qemu/error-report.h"
 
 enum {
diff --git a/hw/misc/milkymist-pfpu.c b/hw/misc/milkymist-pfpu.c
index 3ca2589..7921ab6 100644
--- a/hw/misc/milkymist-pfpu.c
+++ b/hw/misc/milkymist-pfpu.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/misc/trace.h"
 #include "qemu/log.h"
 #include "qemu/error-report.h"
 #include <math.h>
diff --git a/hw/misc/slavio_misc.c b/hw/misc/slavio_misc.c
index edd5de0..a4820c5 100644
--- a/hw/misc/slavio_misc.c
+++ b/hw/misc/slavio_misc.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/misc/trace.h"
 
 /*
  * This is the auxio port, chip control and system control part of
-- 
2.9.3
