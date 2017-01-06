Received: from eggs.gnu.org ([2001:4830:134:3::10]:47059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsO-00044J-37
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsN-00051R-13
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36234)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsM-000514-P8
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:18 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D3DCF8F02B
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:18 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:13 +0000
Message-Id: <20170106155543.12827-18-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 17/47] trace: switch hw/display/ directory
 to modular trace.h file
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

Switch files in the hw/display/ directory to include the
hw/display/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs                | 2 +-
 hw/display/Makefile.objs     | 3 +++
 hw/display/g364fb.c          | 2 +-
 hw/display/jazz_led.c        | 2 +-
 hw/display/milkymist-tmu2.c  | 2 +-
 hw/display/milkymist-vgafb.c | 2 +-
 hw/display/qxl-render.c      | 2 +-
 hw/display/qxl.c             | 2 +-
 hw/display/vga.c             | 2 +-
 hw/display/virtio-gpu-3d.c   | 2 +-
 hw/display/virtio-gpu.c      | 2 +-
 hw/display/vmware_vga.c      | 2 +-
 hw/display/xenfb.c           | 2 +-
 13 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index a08e1f9..11f7b0d 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -135,7 +135,7 @@ trace-events-subdirs += hw/misc
 trace-events-subdirs += hw/usb
 trace-events-subdirs += hw/scsi
 trace-events-subdirs += hw/nvram
-trace-events-y += hw/display/trace-events
+trace-events-subdirs += hw/display
 trace-events-y += hw/input/trace-events
 trace-events-y += hw/timer/trace-events
 trace-events-y += hw/dma/trace-events
diff --git a/hw/display/Makefile.objs b/hw/display/Makefile.objs
index 063889b..8279083 100644
--- a/hw/display/Makefile.objs
+++ b/hw/display/Makefile.objs
@@ -45,3 +45,6 @@ virtio-gpu-3d.o-cflags := $(VIRGL_CFLAGS)
 virtio-gpu-3d.o-libs += $(VIRGL_LIBS)
 obj-$(CONFIG_DPCD) += dpcd.o
 obj-$(CONFIG_XLNX_ZYNQMP) += xlnx_dp.o
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/display/g364fb.c b/hw/display/g364fb.c
index 70ef2c7..5342e07 100644
--- a/hw/display/g364fb.c
+++ b/hw/display/g364fb.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 #include "hw/sysbus.h"
 
 typedef struct G364State {
diff --git a/hw/display/jazz_led.c b/hw/display/jazz_led.c
index b72fdb1..a11125c 100644
--- a/hw/display/jazz_led.c
+++ b/hw/display/jazz_led.c
@@ -26,7 +26,7 @@
 #include "qemu-common.h"
 #include "ui/console.h"
 #include "ui/pixel_ops.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 #include "hw/sysbus.h"
 
 typedef enum {
diff --git a/hw/display/milkymist-tmu2.c b/hw/display/milkymist-tmu2.c
index 5c666f9..bb7016a 100644
--- a/hw/display/milkymist-tmu2.c
+++ b/hw/display/milkymist-tmu2.c
@@ -27,7 +27,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 #include "qemu/error-report.h"
 #include "qapi/error.h"
 
diff --git a/hw/display/milkymist-vgafb.c b/hw/display/milkymist-vgafb.c
index 177fdac..2180e6d 100644
--- a/hw/display/milkymist-vgafb.c
+++ b/hw/display/milkymist-vgafb.c
@@ -25,7 +25,7 @@
 #include "qemu/osdep.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 #include "ui/console.h"
 #include "framebuffer.h"
 #include "ui/pixel_ops.h"
diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index 9ad9d9e..d1f0db3 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -21,7 +21,7 @@
 
 #include "qemu/osdep.h"
 #include "qxl.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 
 static void qxl_blit(PCIQXLDevice *qxl, QXLRect *rect)
 {
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index 62d0c80..50f12ae 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -26,7 +26,7 @@
 #include "qemu/queue.h"
 #include "qemu/atomic.h"
 #include "sysemu/sysemu.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 
 #include "qxl.h"
 
diff --git a/hw/display/vga.c b/hw/display/vga.c
index 2a88b3c..8dafd26 100644
--- a/hw/display/vga.c
+++ b/hw/display/vga.c
@@ -32,7 +32,7 @@
 #include "ui/pixel_ops.h"
 #include "qemu/timer.h"
 #include "hw/xen/xen.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 
 //#define DEBUG_VGA
 //#define DEBUG_VGA_MEM
diff --git a/hw/display/virtio-gpu-3d.c b/hw/display/virtio-gpu-3d.c
index b13ced3..ba98d1f 100644
--- a/hw/display/virtio-gpu-3d.c
+++ b/hw/display/virtio-gpu-3d.c
@@ -14,7 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu-common.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "qapi/error.h"
diff --git a/hw/display/virtio-gpu.c b/hw/display/virtio-gpu.c
index ca88cf4..8aff8a9 100644
--- a/hw/display/virtio-gpu.c
+++ b/hw/display/virtio-gpu.c
@@ -15,7 +15,7 @@
 #include "qemu-common.h"
 #include "qemu/iov.h"
 #include "ui/console.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/virtio-gpu.h"
 #include "hw/virtio/virtio-bus.h"
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 6599cf0..8974181 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/loader.h"
-#include "trace.h"
+#include "hw/display/trace.h"
 #include "ui/console.h"
 #include "ui/vnc.h"
 #include "hw/pci/pci.h"
diff --git a/hw/display/xenfb.c b/hw/display/xenfb.c
index 7a8727a..7c1f93f 100644
--- a/hw/display/xenfb.c
+++ b/hw/display/xenfb.c
@@ -36,7 +36,7 @@
 #include <xen/io/kbdif.h>
 #include <xen/io/protocols.h>
 
-#include "trace.h"
+#include "hw/display/trace.h"
 
 #ifndef BTN_LEFT
 #define BTN_LEFT 0x110 /* from <linux/input.h> */
-- 
2.9.3
