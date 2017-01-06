Received: from eggs.gnu.org ([2001:4830:134:3::10]:47184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsc-0004Ns-GK
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsb-00059W-LQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:34 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsb-000599-Fq
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:33 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 922F763E25
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:33 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:21 +0000
Message-Id: <20170106155543.12827-26-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 25/47] trace: switch hw/i386/ directory to
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

Switch files in the hw/i386/ directory to include the
hw/i386/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs              | 2 +-
 hw/i386/Makefile.objs      | 2 ++
 hw/i386/x86-iommu.c        | 2 +-
 hw/i386/xen/xen_platform.c | 1 +
 hw/i386/xen/xen_pvdevice.c | 1 +
 5 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 89953e5..14ae798 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -143,7 +143,7 @@ trace-events-subdirs += hw/sparc
 trace-events-subdirs += hw/sd
 trace-events-subdirs += hw/isa
 trace-events-subdirs += hw/mem
-trace-events-y += hw/i386/trace-events
+trace-events-subdirs += hw/i386
 trace-events-y += hw/9pfs/trace-events
 trace-events-y += hw/ppc/trace-events
 trace-events-y += hw/pci/trace-events
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 909ead6..f98d3c0 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -9,3 +9,5 @@ obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-y += kvmvapic.o
 obj-y += acpi-build.o
 obj-y += pci-assign-load-rom.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 2278af7..e2ed227 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -22,7 +22,7 @@
 #include "hw/boards.h"
 #include "hw/i386/x86-iommu.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "hw/i386/trace.h"
 
 void x86_iommu_iec_register_notifier(X86IOMMUState *iommu,
                                      iec_notify_fn fn, void *data)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 2e1e543..2ad1843 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -33,6 +33,7 @@
 #include "hw/xen/xen_common.h"
 #include "hw/xen/xen_backend.h"
 #include "trace.h"
+#include "hw/i386/trace.h"
 #include "exec/address-spaces.h"
 #include "sysemu/block-backend.h"
 #include "qemu/error-report.h"
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index c093b34..742a3d9 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -34,6 +34,7 @@
 #include "hw/hw.h"
 #include "hw/pci/pci.h"
 #include "trace.h"
+#include "hw/i386/trace.h"
 
 #define TYPE_XEN_PV_DEVICE  "xen-pvdevice"
 
-- 
2.9.3
