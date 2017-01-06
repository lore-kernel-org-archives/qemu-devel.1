Received: from eggs.gnu.org ([2001:4830:134:3::10]:47261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsk-0004it-A2
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsj-0005ET-D6
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51906)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsj-0005Ds-5I
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:41 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44349C0092A6
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:41 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:26 +0000
Message-Id: <20170106155543.12827-31-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 30/47] trace: switch hw/vfio/ directory to
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

Switch files in the hw/vfio/ directory to include the
hw/vfio/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs         | 2 +-
 hw/vfio/Makefile.objs | 2 ++
 hw/vfio/common.c      | 2 +-
 hw/vfio/pci-quirks.c  | 2 +-
 hw/vfio/pci.c         | 2 +-
 hw/vfio/platform.c    | 2 +-
 hw/vfio/spapr.c       | 2 +-
 7 files changed, 8 insertions(+), 6 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 8f44164..cea70ce 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -148,7 +148,7 @@ trace-events-subdirs += hw/9pfs
 trace-events-subdirs += hw/ppc
 trace-events-subdirs += hw/pci
 trace-events-subdirs += hw/s390x
-trace-events-y += hw/vfio/trace-events
+trace-events-subdirs += hw/vfio
 trace-events-y += hw/acpi/trace-events
 trace-events-y += hw/arm/trace-events
 trace-events-y += hw/alpha/trace-events
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index c25e32b..33f7d4f 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -5,4 +5,6 @@ obj-$(CONFIG_SOFTMMU) += platform.o
 obj-$(CONFIG_SOFTMMU) += calxeda-xgmac.o
 obj-$(CONFIG_SOFTMMU) += amd-xgbe.o
 obj-$(CONFIG_SOFTMMU) += spapr.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
 endif
diff --git a/hw/vfio/common.c b/hw/vfio/common.c
index 801578b..0e28500 100644
--- a/hw/vfio/common.c
+++ b/hw/vfio/common.c
@@ -33,7 +33,7 @@
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/kvm.h"
-#include "trace.h"
+#include "hw/vfio/trace.h"
 #include "qapi/error.h"
 
 struct vfio_group_head vfio_group_list =
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 811eecd..b470ba2 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -16,7 +16,7 @@
 #include "qapi/error.h"
 #include "hw/nvram/fw_cfg.h"
 #include "pci.h"
-#include "trace.h"
+#include "hw/vfio/trace.h"
 
 /* Use uin32_t for vendor & device so PCI_ANY_ID expands and cannot match hw */
 static bool vfio_pci_is(VFIOPCIDevice *vdev, uint32_t vendor, uint32_t device)
diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index d7dbe0e..e2d3e7b 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -30,7 +30,7 @@
 #include "sysemu/kvm.h"
 #include "sysemu/sysemu.h"
 #include "pci.h"
-#include "trace.h"
+#include "hw/vfio/trace.h"
 #include "qapi/error.h"
 
 #define MSIX_CAP_LENGTH 12
diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
index a4663c9..ab9f19d 100644
--- a/hw/vfio/platform.c
+++ b/hw/vfio/platform.c
@@ -26,7 +26,7 @@
 #include "exec/memory.h"
 #include "qemu/queue.h"
 #include "hw/sysbus.h"
-#include "trace.h"
+#include "hw/vfio/trace.h"
 #include "hw/platform-bus.h"
 #include "sysemu/kvm.h"
 
diff --git a/hw/vfio/spapr.c b/hw/vfio/spapr.c
index 4409bcc..5899f6d 100644
--- a/hw/vfio/spapr.c
+++ b/hw/vfio/spapr.c
@@ -16,7 +16,7 @@
 #include "hw/vfio/vfio-common.h"
 #include "hw/hw.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "hw/vfio/trace.h"
 
 static bool vfio_prereg_listener_skipped_section(MemoryRegionSection *section)
 {
-- 
2.9.3
