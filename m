Received: from eggs.gnu.org ([209.51.188.92]:35863)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk3YM-0001Y2-2m
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:01:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gk3Y2-0001dZ-2T
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:01:26 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Jan 2019 10:00:49 +0100
Message-Id: <1547715649-27868-1-git-send-email-thuth@redhat.com>
In-Reply-To: <2e726e3f-048d-f9ce-4884-1cdebf7f0997@kaod.org>
References: <2e726e3f-048d-f9ce-4884-1cdebf7f0997@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6] ppc: Fix duplicated typedefs to be able to
 compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

When compiling the ppc code with clang and -std=3Dgnu99, there are a
couple of warnings/errors like this one:

  CC      ppc64-softmmu/hw/intc/xics.o
In file included from hw/intc/xics.c:35:
include/hw/ppc/xics.h:43:25: error: redefinition of typedef 'ICPState' is=
 a C11 feature
      [-Werror,-Wtypedef-redefinition]
typedef struct ICPState ICPState;
                        ^
target/ppc/cpu.h:1181:25: note: previous definition is here
typedef struct ICPState ICPState;
                        ^
Work around the problems by including the proper headers in spapr.h
and by using struct forward declarations in cpu.h.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 As discussed on IRC, C=C3=A9dric's patches likely should go via David's =
ppc-
 tree, so I'll go with this version here for my gnu99-PULL request.
 (v6: Don't use #includes in cpu.h, use forward struct definitions instea=
d)

 include/hw/ppc/spapr.h      | 5 +++--
 include/hw/ppc/spapr_xive.h | 2 --
 target/ppc/cpu.h            | 9 +++++----
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9e01a5a..a947a0a 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -8,15 +8,16 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
 #include "hw/ppc/spapr_irq.h"
+#include "hw/ppc/spapr_xive.h"  /* For sPAPRXive */
+#include "hw/ppc/xics.h"        /* For ICSState */
=20
 struct VIOsPAPRBus;
 struct sPAPRPHBState;
 struct sPAPRNVRAM;
+
 typedef struct sPAPREventLogEntry sPAPREventLogEntry;
 typedef struct sPAPREventSource sPAPREventSource;
 typedef struct sPAPRPendingHPT sPAPRPendingHPT;
-typedef struct ICSState ICSState;
-typedef struct sPAPRXive sPAPRXive;
=20
 #define HPTE64_V_HPTE_DIRTY     0x0000000000000040ULL
 #define SPAPR_ENTRY_POINT       0x100
diff --git a/include/hw/ppc/spapr_xive.h b/include/hw/ppc/spapr_xive.h
index 7fdc250..9bec919 100644
--- a/include/hw/ppc/spapr_xive.h
+++ b/include/hw/ppc/spapr_xive.h
@@ -41,8 +41,6 @@ bool spapr_xive_irq_claim(sPAPRXive *xive, uint32_t lis=
n, bool lsi);
 bool spapr_xive_irq_free(sPAPRXive *xive, uint32_t lisn);
 void spapr_xive_pic_print_info(sPAPRXive *xive, Monitor *mon);
=20
-typedef struct sPAPRMachineState sPAPRMachineState;
-
 void spapr_xive_hcall_init(sPAPRMachineState *spapr);
 void spapr_dt_xive(sPAPRMachineState *spapr, uint32_t nr_servers, void *=
fdt,
                    uint32_t phandle);
diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
index 486abaf..a62ff60 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -1177,8 +1177,9 @@ do {                                            \
=20
 typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
 typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
-typedef struct XiveTCTX XiveTCTX;
-typedef struct ICPState ICPState;
+
+struct XiveTCTX;
+struct ICPState;
=20
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
--=20
1.8.3.1
