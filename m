Received: from eggs.gnu.org ([2001:4830:134:3::10]:47038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsL-000427-LQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsJ-0004zV-1O
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:17 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsI-0004zA-PI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:14 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D35D6C062CEB
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:14 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:11 +0000
Message-Id: <20170106155543.12827-16-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 15/47] trace: switch hw/scsi/ directory to
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

Switch files in the hw/scsi/ directory to include the
hw/scsi/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs         | 2 +-
 hw/scsi/Makefile.objs | 3 +++
 hw/scsi/esp-pci.c     | 2 +-
 hw/scsi/esp.c         | 2 +-
 hw/scsi/megasas.c     | 2 +-
 hw/scsi/mptconfig.c   | 2 +-
 hw/scsi/mptendian.c   | 2 +-
 hw/scsi/mptsas.c      | 2 +-
 hw/scsi/scsi-bus.c    | 2 +-
 hw/scsi/vmw_pvscsi.c  | 2 +-
 10 files changed, 12 insertions(+), 9 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index a71e25b..0d3b37a 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -133,7 +133,7 @@ trace-events-subdirs += hw/virtio
 trace-events-subdirs += hw/audio
 trace-events-subdirs += hw/misc
 trace-events-subdirs += hw/usb
-trace-events-y += hw/scsi/trace-events
+trace-events-subdirs += hw/scsi
 trace-events-y += hw/nvram/trace-events
 trace-events-y += hw/display/trace-events
 trace-events-y += hw/input/trace-events
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 5a2248b..cdf229b 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -12,3 +12,6 @@ ifeq ($(CONFIG_VIRTIO),y)
 obj-y += virtio-scsi.o virtio-scsi-dataplane.o
 obj-$(CONFIG_VHOST_SCSI) += vhost-scsi.o
 endif
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index 595f88b..1a94cb7 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -27,7 +27,7 @@
 #include "hw/pci/pci.h"
 #include "hw/nvram/eeprom93xx.h"
 #include "hw/scsi/esp.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index 5a5a4e9..297b5cf 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -26,7 +26,7 @@
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
 #include "hw/scsi/esp.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
 
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 67fc1e7..0874750 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -28,7 +28,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "block/scsi.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 #include "qapi/error.h"
 #include "mfi.h"
 
diff --git a/hw/scsi/mptconfig.c b/hw/scsi/mptconfig.c
index 87a416a..637c261 100644
--- a/hw/scsi/mptconfig.c
+++ b/hw/scsi/mptconfig.c
@@ -22,7 +22,7 @@
 
 #include "mptsas.h"
 #include "mpi.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 
 /* Generic functions for marshaling and unmarshaling.  */
 
diff --git a/hw/scsi/mptendian.c b/hw/scsi/mptendian.c
index b7fe2a2..1584246 100644
--- a/hw/scsi/mptendian.c
+++ b/hw/scsi/mptendian.c
@@ -29,7 +29,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "block/scsi.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 
 #include "mptsas.h"
 #include "mpi.h"
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index ad87e78..01f1637 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -31,7 +31,7 @@
 #include "qemu/iov.h"
 #include "hw/scsi/scsi.h"
 #include "block/scsi.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 #include "qapi/error.h"
 #include "mptsas.h"
 #include "mpi.h"
diff --git a/hw/scsi/scsi-bus.c b/hw/scsi/scsi-bus.c
index 297216d..e79721c 100644
--- a/hw/scsi/scsi-bus.c
+++ b/hw/scsi/scsi-bus.c
@@ -7,7 +7,7 @@
 #include "hw/qdev.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 #include "sysemu/dma.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/scsi/vmw_pvscsi.c b/hw/scsi/vmw_pvscsi.c
index a5ce7de..b96e4ad 100644
--- a/hw/scsi/vmw_pvscsi.c
+++ b/hw/scsi/vmw_pvscsi.c
@@ -31,7 +31,7 @@
 #include "block/scsi.h"
 #include "hw/pci/msi.h"
 #include "vmw_pvscsi.h"
-#include "trace.h"
+#include "hw/scsi/trace.h"
 
 
 #define PVSCSI_USE_64BIT         (true)
-- 
2.9.3
