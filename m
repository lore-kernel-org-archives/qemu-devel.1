Received: from eggs.gnu.org ([2001:4830:134:3::10]:47036)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsL-000425-LN
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsH-0004yl-FA
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsH-0004yE-6w
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:13 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4CDC38F02B
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:13 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:10 +0000
Message-Id: <20170106155543.12827-15-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 14/47] trace: switch hw/usb/ directory to
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

Switch files in the hw/usb/ directory to include the
hw/usb/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs            | 2 +-
 hw/usb/Makefile.objs     | 3 +++
 hw/usb/bus.c             | 2 +-
 hw/usb/combined-packet.c | 2 +-
 hw/usb/core.c            | 2 +-
 hw/usb/desc.c            | 2 +-
 hw/usb/dev-hub.c         | 2 +-
 hw/usb/dev-mtp.c         | 2 +-
 hw/usb/dev-uas.c         | 2 +-
 hw/usb/hcd-ehci.c        | 2 +-
 hw/usb/hcd-ohci.c        | 2 +-
 hw/usb/hcd-uhci.c        | 2 +-
 hw/usb/hcd-xhci.c        | 2 +-
 hw/usb/host-libusb.c     | 2 +-
 14 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 85c412a..a71e25b 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -132,7 +132,7 @@ trace-events-subdirs += hw/net
 trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/misc
-trace-events-y += hw/usb/trace-events
+trace-events-subdirs += hw/usb
 trace-events-y += hw/scsi/trace-events
 trace-events-y += hw/nvram/trace-events
 trace-events-y += hw/display/trace-events
diff --git a/hw/usb/Makefile.objs b/hw/usb/Makefile.objs
index 98b5c9d..c7b85c4 100644
--- a/hw/usb/Makefile.objs
+++ b/hw/usb/Makefile.objs
@@ -42,3 +42,6 @@ common-obj-y += $(patsubst %,host-%.o,$(HOST_USB))
 ifeq ($(CONFIG_USB_LIBUSB),y)
 common-obj-$(CONFIG_XEN_BACKEND) += xen-usb.o
 endif
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/usb/bus.c b/hw/usb/bus.c
index 25913ad..e41cf29 100644
--- a/hw/usb/bus.c
+++ b/hw/usb/bus.c
@@ -6,7 +6,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "monitor/monitor.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 #include "qemu/cutils.h"
 
 static void usb_bus_dev_print(Monitor *mon, DeviceState *qdev, int indent);
diff --git a/hw/usb/combined-packet.c b/hw/usb/combined-packet.c
index 48cac87..fb5b87f 100644
--- a/hw/usb/combined-packet.c
+++ b/hw/usb/combined-packet.c
@@ -23,7 +23,7 @@
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 
 static void usb_combined_packet_add(USBCombinedPacket *combined, USBPacket *p)
 {
diff --git a/hw/usb/core.c b/hw/usb/core.c
index 45fa00c..68668c3 100644
--- a/hw/usb/core.c
+++ b/hw/usb/core.c
@@ -27,7 +27,7 @@
 #include "qemu-common.h"
 #include "hw/usb.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 
 void usb_pick_speed(USBPort *port)
 {
diff --git a/hw/usb/desc.c b/hw/usb/desc.c
index 7828e52..64341c6 100644
--- a/hw/usb/desc.c
+++ b/hw/usb/desc.c
@@ -2,7 +2,7 @@
 
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 
 /* ------------------------------------------------------------------ */
 
diff --git a/hw/usb/dev-hub.c b/hw/usb/dev-hub.c
index a33f21c..5359688 100644
--- a/hw/usb/dev-hub.c
+++ b/hw/usb/dev-hub.c
@@ -24,7 +24,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 #include "qemu/error-report.h"
diff --git a/hw/usb/dev-mtp.c b/hw/usb/dev-mtp.c
index 9cb0f50..d11f0fc 100644
--- a/hw/usb/dev-mtp.c
+++ b/hw/usb/dev-mtp.c
@@ -22,7 +22,7 @@
 
 #include "qemu-common.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 #include "hw/usb.h"
 #include "hw/usb/desc.h"
 
diff --git a/hw/usb/dev-uas.c b/hw/usb/dev-uas.c
index 3a8ff18..46efc5a 100644
--- a/hw/usb/dev-uas.c
+++ b/hw/usb/dev-uas.c
@@ -13,7 +13,7 @@
 #include "qemu-common.h"
 #include "qemu/option.h"
 #include "qemu/config-file.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 #include "qemu/error-report.h"
 
 #include "hw/usb.h"
diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
index 7622a3a..67c17c9 100644
--- a/hw/usb/hcd-ehci.c
+++ b/hw/usb/hcd-ehci.c
@@ -31,7 +31,7 @@
 #include "qapi/error.h"
 #include "hw/usb/ehci-regs.h"
 #include "hw/usb/hcd-ehci.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 
 #define FRAME_TIMER_FREQ 1000
 #define FRAME_TIMER_NS   (NANOSECONDS_PER_SECOND / FRAME_TIMER_FREQ)
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index c82a92f..864b711 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -33,7 +33,7 @@
 #include "hw/pci/pci.h"
 #include "hw/sysbus.h"
 #include "hw/qdev-dma.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 
 /* This causes frames to occur 1000x slower */
 //#define OHCI_TIME_WARP 1
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index ca72a80..ee7de68 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -34,7 +34,7 @@
 #include "qemu/timer.h"
 #include "qemu/iov.h"
 #include "sysemu/dma.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 #include "qemu/main-loop.h"
 
 #define FRAME_TIMER_FREQ 1000
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4acf0c6..671e2b2 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -26,7 +26,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/msi.h"
 #include "hw/pci/msix.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 #include "qapi/error.h"
 
 //#define DEBUG_XHCI
diff --git a/hw/usb/host-libusb.c b/hw/usb/host-libusb.c
index bd81d71..131fbb3 100644
--- a/hw/usb/host-libusb.c
+++ b/hw/usb/host-libusb.c
@@ -44,7 +44,7 @@
 #include "monitor/monitor.h"
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/usb/trace.h"
 
 #include "hw/usb.h"
 
-- 
2.9.3
