Received: from eggs.gnu.org ([2001:4830:134:3::10]:46923)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsA-0003rW-Dv
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWs6-0004sL-Fi
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:06 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWs6-0004rv-AX
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:02 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5F428C04B311
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:02 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:03 +0000
Message-Id: <20170106155543.12827-8-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 07/47] trace: switch hw/block/ directory to
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

Switch files in the hw/block/ directory to include the
hw/block/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs                   | 2 +-
 hw/block/Makefile.objs          | 2 ++
 hw/block/dataplane/virtio-blk.c | 2 +-
 hw/block/hd-geometry.c          | 2 +-
 hw/block/virtio-blk.c           | 2 +-
 5 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 8a6dfad..90979b0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -125,7 +125,7 @@ trace-events-subdirs += crypto
 trace-events-subdirs += io
 trace-events-subdirs += migration
 trace-events-subdirs += block
-trace-events-y += hw/block/trace-events
+trace-events-subdirs += hw/block
 trace-events-y += hw/char/trace-events
 trace-events-y += hw/intc/trace-events
 trace-events-y += hw/net/trace-events
diff --git a/hw/block/Makefile.objs b/hw/block/Makefile.objs
index d4c3ab7..a2f523d 100644
--- a/hw/block/Makefile.objs
+++ b/hw/block/Makefile.objs
@@ -8,6 +8,8 @@ common-obj-$(CONFIG_XEN_BACKEND) += xen_disk.o
 common-obj-$(CONFIG_ECC) += ecc.o
 common-obj-$(CONFIG_ONENAND) += onenand.o
 common-obj-$(CONFIG_NVME_PCI) += nvme.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 
 obj-$(CONFIG_SH4) += tc58128.o
 
diff --git a/hw/block/dataplane/virtio-blk.c b/hw/block/dataplane/virtio-blk.c
index d1f9f63..70991f9 100644
--- a/hw/block/dataplane/virtio-blk.c
+++ b/hw/block/dataplane/virtio-blk.c
@@ -14,7 +14,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
-#include "trace.h"
+#include "hw/block/trace.h"
 #include "qemu/iov.h"
 #include "qemu/thread.h"
 #include "qemu/error-report.h"
diff --git a/hw/block/hd-geometry.c b/hw/block/hd-geometry.c
index 57ad501..5d3691a 100644
--- a/hw/block/hd-geometry.c
+++ b/hw/block/hd-geometry.c
@@ -34,7 +34,7 @@
 #include "sysemu/block-backend.h"
 #include "qemu/bswap.h"
 #include "hw/block/block.h"
-#include "trace.h"
+#include "hw/block/trace.h"
 
 struct partition {
         uint8_t boot_ind;           /* 0x80 - active */
diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
index 50bb0cb..69e9e2b 100644
--- a/hw/block/virtio-blk.c
+++ b/hw/block/virtio-blk.c
@@ -16,7 +16,7 @@
 #include "qemu-common.h"
 #include "qemu/iov.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "hw/block/trace.h"
 #include "hw/block/block.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/blockdev.h"
-- 
2.9.3
