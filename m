Received: from eggs.gnu.org ([2001:4830:134:3::10]:46952)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsC-0003tF-AJ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsB-0004un-8Y
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsA-0004uA-W9
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:07 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 224198E240
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:07 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:06 +0000
Message-Id: <20170106155543.12827-11-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/47] trace: switch hw/net/ directory to
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

Switch files in the hw/net/ directory to include the
hw/net/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs               | 2 +-
 hw/net/Makefile.objs        | 3 +++
 hw/net/e1000e.c             | 2 +-
 hw/net/e1000e_core.c        | 2 +-
 hw/net/e1000x_common.c      | 2 +-
 hw/net/lance.c              | 2 +-
 hw/net/milkymist-minimac2.c | 2 +-
 hw/net/mipsnet.c            | 2 +-
 hw/net/net_rx_pkt.c         | 2 +-
 hw/net/opencores_eth.c      | 2 +-
 hw/net/pcnet-pci.c          | 2 +-
 hw/net/pcnet.c              | 2 +-
 12 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 6d30b53..9c0aefa 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -128,7 +128,7 @@ trace-events-subdirs += block
 trace-events-subdirs += hw/block
 trace-events-subdirs += hw/char
 trace-events-subdirs += hw/intc
-trace-events-y += hw/net/trace-events
+trace-events-subdirs += hw/net
 trace-events-y += hw/virtio/trace-events
 trace-events-y += hw/audio/trace-events
 trace-events-y += hw/misc/trace-events
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 610ed3e..da244c2 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -43,3 +43,6 @@ common-obj-$(CONFIG_ROCKER) += rocker/rocker.o rocker/rocker_fp.o \
                                rocker/rocker_desc.o rocker/rocker_world.o \
                                rocker/rocker_of_dpa.o
 obj-$(call lnot,$(CONFIG_ROCKER)) += rocker/qmp-norocker.o
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/net/e1000e.c b/hw/net/e1000e.c
index 4994e1c..9e68bdb 100644
--- a/hw/net/e1000e.c
+++ b/hw/net/e1000e.c
@@ -46,7 +46,7 @@
 #include "e1000x_common.h"
 #include "e1000e_core.h"
 
-#include "trace.h"
+#include "hw/net/trace.h"
 
 #define TYPE_E1000E "e1000e"
 #define E1000E(obj) OBJECT_CHECK(E1000EState, (obj), TYPE_E1000E)
diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index 2b11499..4304b6a 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -46,7 +46,7 @@
 #include "e1000x_common.h"
 #include "e1000e_core.h"
 
-#include "trace.h"
+#include "hw/net/trace.h"
 
 #define E1000E_MIN_XITR     (500) /* No more then 7813 interrupts per
                                      second according to spec 10.2.4.2 */
diff --git a/hw/net/e1000x_common.c b/hw/net/e1000x_common.c
index eb0e097..7b6cfa8 100644
--- a/hw/net/e1000x_common.c
+++ b/hw/net/e1000x_common.c
@@ -29,7 +29,7 @@
 
 #include "e1000x_common.h"
 
-#include "trace.h"
+#include "hw/net/trace.h"
 
 bool e1000x_rx_ready(PCIDevice *d, uint32_t *mac)
 {
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 573d724..6e36f9f 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -42,7 +42,7 @@
 #include "qemu/sockets.h"
 #include "hw/sparc/sun4m.h"
 #include "pcnet.h"
-#include "trace.h"
+#include "hw/net/trace.h"
 #include "sysemu/sysemu.h"
 
 #define TYPE_LANCE "lance"
diff --git a/hw/net/milkymist-minimac2.c b/hw/net/milkymist-minimac2.c
index c3a12e1..0a0d43f 100644
--- a/hw/net/milkymist-minimac2.c
+++ b/hw/net/milkymist-minimac2.c
@@ -28,7 +28,7 @@
 #include "cpu.h" /* FIXME: why does this use TARGET_PAGE_ALIGN? */
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/net/trace.h"
 #include "net/net.h"
 #include "qemu/error-report.h"
 
diff --git a/hw/net/mipsnet.c b/hw/net/mipsnet.c
index 5a63df7..5f8fd6a 100644
--- a/hw/net/mipsnet.c
+++ b/hw/net/mipsnet.c
@@ -1,7 +1,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "net/net.h"
-#include "trace.h"
+#include "hw/net/trace.h"
 #include "hw/sysbus.h"
 
 /* MIPSnet register offsets */
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 1019b50..9ec6e61 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -16,7 +16,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "hw/net/trace.h"
 #include "net_rx_pkt.h"
 #include "net/checksum.h"
 #include "net/tap.h"
diff --git a/hw/net/opencores_eth.c b/hw/net/opencores_eth.c
index 268d6a7..2a38c05 100644
--- a/hw/net/opencores_eth.c
+++ b/hw/net/opencores_eth.c
@@ -37,7 +37,7 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/net/trace.h"
 
 /* RECSMALL is not used because it breaks tap networking in linux:
  * incoming ARP responses are too short
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0acf8a4..6cfc121 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -34,7 +34,7 @@
 #include "qemu/timer.h"
 #include "sysemu/dma.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/net/trace.h"
 
 #include "pcnet.h"
 
diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
index 6544553..edba914 100644
--- a/hw/net/pcnet.c
+++ b/hw/net/pcnet.c
@@ -41,7 +41,7 @@
 #include "qemu/timer.h"
 #include "qemu/sockets.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/net/trace.h"
 
 #include "pcnet.h"
 
-- 
2.9.3
