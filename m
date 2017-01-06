Received: from eggs.gnu.org ([2001:4830:134:3::10]:47224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsh-0004cl-H4
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWse-0005BO-PQ
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55926)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWse-0005Aq-Gq
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:36 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 915D3C04B941
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:36 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:23 +0000
Message-Id: <20170106155543.12827-28-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 27/47] trace: switch hw/ppc/ directory to
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

Switch files in the hw/ppc/ directory to include the
hw/ppc/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs           | 2 +-
 hw/ppc/Makefile.objs    | 3 +++
 hw/ppc/ppc.c            | 2 +-
 hw/ppc/prep.c           | 2 +-
 hw/ppc/spapr.c          | 2 +-
 hw/ppc/spapr_hcall.c    | 2 +-
 hw/ppc/spapr_iommu.c    | 2 +-
 hw/ppc/spapr_pci.c      | 2 +-
 hw/ppc/spapr_rtas_ddw.c | 2 +-
 9 files changed, 11 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index 83906e5..42cd94e 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -145,7 +145,7 @@ trace-events-subdirs += hw/isa
 trace-events-subdirs += hw/mem
 trace-events-subdirs += hw/i386
 trace-events-subdirs += hw/9pfs
-trace-events-y += hw/ppc/trace-events
+trace-events-subdirs += hw/ppc
 trace-events-y += hw/pci/trace-events
 trace-events-y += hw/s390x/trace-events
 trace-events-y += hw/vfio/trace-events
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
index 8025129..071428c 100644
--- a/hw/ppc/Makefile.objs
+++ b/hw/ppc/Makefile.objs
@@ -25,3 +25,6 @@ obj-$(CONFIG_E500) += e500.o mpc8544ds.o e500plat.o
 obj-$(CONFIG_E500) += mpc8544_guts.o ppce500_spin.o
 # PowerPC 440 Xilinx ML507 reference board.
 obj-$(CONFIG_XILINX) += virtex_ml507.o
+
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8945869..53302e8 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -37,7 +37,7 @@
 #include "hw/loader.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
-#include "trace.h"
+#include "hw/ppc/trace.h"
 
 //#define PPC_DEBUG_IRQ
 //#define PPC_DEBUG_TB
diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
index 054af1e..c5c97b1 100644
--- a/hw/ppc/prep.c
+++ b/hw/ppc/prep.c
@@ -45,7 +45,7 @@
 #include "sysemu/arch_init.h"
 #include "sysemu/qtest.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "hw/ppc/trace.h"
 #include "elf.h"
 #include "qemu/cutils.h"
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 208ef7b..ebdcf6f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -61,7 +61,7 @@
 #include "hw/usb.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "hw/ppc/trace.h"
 #include "hw/nmi.h"
 
 #include "hw/compat.h"
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 9a9bedf..332a49a 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -8,7 +8,7 @@
 #include "hw/ppc/spapr.h"
 #include "mmu-hash64.h"
 #include "cpu-models.h"
-#include "trace.h"
+#include "hw/ppc/trace.h"
 #include "sysemu/kvm.h"
 #include "kvm_ppc.h"
 #include "hw/ppc/spapr_ovec.h"
diff --git a/hw/ppc/spapr_iommu.c b/hw/ppc/spapr_iommu.c
index ae30bbe..125682d 100644
--- a/hw/ppc/spapr_iommu.c
+++ b/hw/ppc/spapr_iommu.c
@@ -25,7 +25,7 @@
 #include "kvm_ppc.h"
 #include "sysemu/dma.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "hw/ppc/trace.h"
 
 #include "hw/ppc/spapr.h"
 #include "hw/ppc/spapr_vio.h"
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index fd6fc1d..1acb5b4 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -37,7 +37,7 @@
 #include "exec/address-spaces.h"
 #include "exec/ram_addr.h"
 #include <libfdt.h>
-#include "trace.h"
+#include "hw/ppc/trace.h"
 #include "qemu/error-report.h"
 #include "qapi/qmp/qerror.h"
 
diff --git a/hw/ppc/spapr_rtas_ddw.c b/hw/ppc/spapr_rtas_ddw.c
index 177dcff..3dad98c 100644
--- a/hw/ppc/spapr_rtas_ddw.c
+++ b/hw/ppc/spapr_rtas_ddw.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "hw/ppc/spapr.h"
 #include "hw/pci-host/spapr.h"
-#include "trace.h"
+#include "hw/ppc/trace.h"
 
 static int spapr_phb_get_active_win_num_cb(Object *child, void *opaque)
 {
-- 
2.9.3
