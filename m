Received: from eggs.gnu.org ([209.51.188.92]:44935)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz59-0005lG-Tu
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:03:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1giz59-0007fU-0P
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52662)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1giz58-0007dh-OW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 05:02:58 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Mon, 14 Jan 2019 11:02:18 +0100
Message-Id: <1547460140-1473-24-git-send-email-thuth@redhat.com>
In-Reply-To: <1547460140-1473-1-git-send-email-thuth@redhat.com>
References: <1547460140-1473-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 23/25] ppc: Fix duplicated typedefs to be able
 to compile with Clang in gnu99 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Li Qiang <liq3ea@163.com>

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
Work around the problems by including the proper headers instead.

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/hw/ppc/spapr.h      |  5 +++--
 include/hw/ppc/spapr_xive.h |  2 --
 target/ppc/cpu.h            | 13 +++++++++----
 3 files changed, 12 insertions(+), 8 deletions(-)

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
index 486abaf..bde4dff 100644
--- a/target/ppc/cpu.h
+++ b/target/ppc/cpu.h
@@ -23,6 +23,11 @@
 #include "qemu-common.h"
 #include "qemu/int128.h"
=20
+#ifndef CONFIG_USER_ONLY
+#include "hw/ppc/xive.h" /* for XiveTCTX */
+#include "hw/ppc/xics.h" /* for ICPState */
+#endif
+
 //#define PPC_EMULATE_32BITS_HYPV
=20
 #if defined (TARGET_PPC64)
@@ -1177,8 +1182,6 @@ do {                                            \
=20
 typedef struct PPCVirtualHypervisor PPCVirtualHypervisor;
 typedef struct PPCVirtualHypervisorClass PPCVirtualHypervisorClass;
-typedef struct XiveTCTX XiveTCTX;
-typedef struct ICPState ICPState;
=20
 /**
  * PowerPCCPU:
@@ -1197,11 +1200,13 @@ struct PowerPCCPU {
     int vcpu_id;
     uint32_t compat_pvr;
     PPCVirtualHypervisor *vhyp;
-    ICPState *icp;
-    XiveTCTX *tctx;
     void *machine_data;
     int32_t node_id; /* NUMA node this CPU belongs to */
     PPCHash64Options *hash64_opts;
+#ifndef CONFIG_USER_ONLY
+    ICPState *icp;
+    XiveTCTX *tctx;
+#endif
=20
     /* Fields related to migration compatibility hacks */
     bool pre_2_8_migration;
--=20
1.8.3.1
