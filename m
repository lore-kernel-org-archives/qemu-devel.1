Received: from eggs.gnu.org ([209.51.188.92]:33548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghWRH-000681-OD
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:15:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ghWRG-0006ik-Le
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 04:15:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 10 Jan 2019 10:15:35 +0100
Message-Id: <1547111736-3962-3-git-send-email-thuth@redhat.com>
In-Reply-To: <1547111736-3962-1-git-send-email-thuth@redhat.com>
References: <1547111736-3962-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/3] ppc: Drop duplicated typedefs to be
 able to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, pbonzini@redhat.com, peter.maydell@linaro.org, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>

When compiling the ppc code with clang and -std=gnu99, there are a
couple of warnings/errors like this one:

  CC      ppc64-softmmu/hw/intc/xics.o
In file included from /home/thuth/devel/qemu/hw/intc/xics.c:35:
/home/thuth/devel/qemu/include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPState' is a C11 feature
      [-Werror,-Wtypedef-redefinition]
typedef struct ICPState ICPState;
                        ^
/home/thuth/devel/qemu/target/ppc/cpu.h:1181:25: note: previous definition is here
typedef struct ICPState ICPState;
                        ^

Drop the duplicated typedefs and use normal "struct" forward declarations
like we already do it at the top of spapr.h for a couple of other definitions.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ppc/spapr.h      | 9 +++++----
 include/hw/ppc/spapr_xive.h | 3 +--
 target/ppc/cpu.h            | 9 +++++----
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9e01a5a..10d069e 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -12,11 +12,12 @@
 struct VIOsPAPRBus;
 struct sPAPRPHBState;
 struct sPAPRNVRAM;
+struct ICSState;
+struct sPAPRXive;
+
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
 typedef struct sPAPRPendingHPT sPAPRPendingHPT;
-typedef struct ICSState ICSState;
-typedef struct sPAPRXive sPAPRXive;
 
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
@@ -127,7 +128,7 @@ struct sPAPRMachineState {
     struct VIOsPAPRBus *vio_bus;
     QLIST_HEAD(, sPAPRPHBState) phbs;
     struct sPAPRNVRAM *nvram;
-    ICSState *ics;
+    struct ICSState *ics;
     sPAPRRTCState rtc;
 
     sPAPRResizeHPT resize_hpt;
@@ -180,7 +181,7 @@ struct sPAPRMachineState {
     const char *icp_type;
     int32_t irq_map_nr;
     unsigned long *irq_map;
-    sPAPRXive  *xive;
+    struct sPAPRXive  *xive;
     sPAPRIrq *irq;
     qemu_irq *qirqs;
 
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7fdc250..556b124 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -11,6 +11,7 @@
 #define PPC_SPAPR_XIVE_H
 
 #include "hw/ppc/xive.h"
+#include "hw/ppc/spapr.h"
 
 #define TYPE_SPAPR_XIVE "spapr-xive"
 #define SPAPR_XIVE(obj) OBJECT_CHECK(sPAPRXive, (obj), TYPE_SPAPR_XIVE)
@@ -41,8 +42,6 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lisn, bool lsi);
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
 
-typedef struct sPAPRMachineState sPAPRMachineState;
-
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *fdt,
                    uint32_t phandle);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 486abaf..a62ff60 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1177,8 +1177,9 @@ do {                                            \
 
 typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
 typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
-typedef struct XiveTCTX XiveTCTX;
-typedef struct ICPState ICPState;
+
+struct XiveTCTX;
+struct ICPState;
 
 /**
  * PowerPCCPU:
@@ -1197,8 +1198,8 @@ struct PowerPCCPU {
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
-    ICPState *icp;
-    XiveTCTX *tctx;
+    struct ICPState *icp;
+    struct XiveTCTX *tctx;
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
-- 
1.8.3.1
