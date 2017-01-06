Received: from eggs.gnu.org ([2001:4830:134:3::10]:47072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsP-00045R-98
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsO-000529-Fk
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58774)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsO-00051m-9o
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:20 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5C57963E34
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:20 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:14 +0000
Message-Id: <20170106155543.12827-19-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 18/47] trace: switch hw/input/ directory to
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

Switch files in the hw/input/ directory to include the
hw/input/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs                | 2 +-
 hw/input/Makefile.objs       | 3 +++
 hw/input/hid.c               | 2 +-
 hw/input/milkymist-softusb.c | 2 +-
 hw/input/ps2.c               | 2 +-
 hw/input/virtio-input.c      | 2 +-
 6 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 11f7b0d..3ae5085 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -136,7 +136,7 @@ trace-events-subdirs += hw/usb
 trace-events-subdirs += hw/scsi
 trace-events-subdirs += hw/nvram
 trace-events-subdirs += hw/display
-trace-events-y += hw/input/trace-events
+trace-events-subdirs += hw/input
 trace-events-y += hw/timer/trace-events
 trace-events-y += hw/dma/trace-events
 trace-events-y += hw/sparc/trace-events
diff --git a/hw/input/Makefile.objs b/hw/input/Makefile.objs
index 7715d72..fc40638 100644
--- a/hw/input/Makefile.objs
+++ b/hw/input/Makefile.objs
@@ -17,3 +17,6 @@ endif
 obj-$(CONFIG_MILKYMIST) += milkymist-softusb.o
 obj-$(CONFIG_PXA2XX) += pxa2xx_keypad.o
 obj-$(CONFIG_TSC210X) += tsc210x.o
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/input/hid.c b/hw/input/hid.c
index fa9cc4c..beb595b 100644
--- a/hw/input/hid.c
+++ b/hw/input/hid.c
@@ -27,7 +27,7 @@
 #include "ui/console.h"
 #include "qemu/timer.h"
 #include "hw/input/hid.h"
-#include "trace.h"
+#include "hw/input/trace.h"
 
 #define HID_USAGE_ERROR_ROLLOVER        0x01
 #define HID_USAGE_POSTFAIL              0x02
diff --git a/hw/input/milkymist-softusb.c b/hw/input/milkymist-softusb.c
index 40dfca1..41f2211 100644
--- a/hw/input/milkymist-softusb.c
+++ b/hw/input/milkymist-softusb.c
@@ -25,7 +25,7 @@
 #include "qapi/error.h"
 #include "hw/hw.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/input/trace.h"
 #include "ui/console.h"
 #include "hw/input/hid.h"
 #include "qemu/error-report.h"
diff --git a/hw/input/ps2.c b/hw/input/ps2.c
index 0d14de0..845a546 100644
--- a/hw/input/ps2.c
+++ b/hw/input/ps2.c
@@ -29,7 +29,7 @@
 #include "ui/input.h"
 #include "sysemu/sysemu.h"
 
-#include "trace.h"
+#include "hw/input/trace.h"
 
 /* debug PC keyboard */
 //#define DEBUG_KBD
diff --git a/hw/input/virtio-input.c b/hw/input/virtio-input.c
index b678ee9..517b583 100644
--- a/hw/input/virtio-input.c
+++ b/hw/input/virtio-input.c
@@ -7,7 +7,7 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "qemu/iov.h"
-#include "trace.h"
+#include "hw/input/trace.h"
 
 #include "hw/qdev.h"
 #include "hw/virtio/virtio.h"
-- 
2.9.3
