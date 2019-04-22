Received: from eggs.gnu.org ([209.51.188.92]:59203)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hIT4U-0002PU-UT
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:08:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1hIT4T-00016w-Sh
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:08:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55832)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1hIT4T-000167-IX
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 03:08:57 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x3M73eP2113230
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:08:53 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2s188tsdm0-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 22 Apr 2019 03:08:53 -0400
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Mon, 22 Apr 2019 08:03:52 +0100
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Mon, 22 Apr 2019 12:33:45 +0530
In-Reply-To: <155591636364.20338.844048953355207313.stgit@aravinda>
References: <155591636364.20338.844048953355207313.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <155591662496.20338.3862565585716109724.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v8 6/6] migration: Block migration while
 handling machine check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: aik@au1.ibm.com, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: paulus@ozlabs.org, aravinda@linux.vnet.ibm.com, mahesh@linux.vnet.ibm.com

Block VM migration requests until the machine check
error handling is complete as (i) these errors are
specific to the source hardware and is irrelevant on
the target hardware, (ii) these errors cause data
corruption and should be handled before migration.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr_events.c  |   17 +++++++++++++++++
 hw/ppc/spapr_rtas.c    |    4 ++++
 include/hw/ppc/spapr.h |    3 +++
 3 files changed, 24 insertions(+)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 4032db0..45b990c 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -41,6 +41,7 @@
 #include "qemu/bcd.h"
 #include "hw/ppc/spapr_ovec.h"
 #include <libfdt.h>
+#include "migration/blocker.h"
 
 #define RTAS_LOG_VERSION_MASK                   0xff000000
 #define   RTAS_LOG_VERSION_6                    0x06000000
@@ -864,6 +865,22 @@ static void spapr_mce_dispatch_elog(PowerPCCPU *cpu, bool recovered)
 void spapr_mce_req_event(PowerPCCPU *cpu, bool recovered)
 {
     SpaprMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
+    int ret;
+    Error *local_err = NULL;
+
+    error_setg(&spapr->migration_blocker,
+            "Live migration not supported during machine check handling");
+    ret = migrate_add_blocker(spapr->migration_blocker, &local_err);
+    if (ret < 0) {
+        /*
+         * We don't want to abort and let the migration to continue. In a
+         * rare case, the machine check handler will run on the target
+         * hardware. Though this is not preferable, it is better than aborting
+         * the migration or killing the VM.
+         */
+        error_free(spapr->migration_blocker);
+        fprintf(stderr, "Warning: Machine check during VM migration\n");
+    }
 
     while (spapr->mc_status != -1) {
         /*
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 997cf19..1229a0e 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -50,6 +50,7 @@
 #include "target/ppc/mmu-hash64.h"
 #include "target/ppc/mmu-book3s-v3.h"
 #include "kvm_ppc.h"
+#include "migration/blocker.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, SpaprMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -396,6 +397,9 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
         spapr->mc_status = -1;
         qemu_cond_signal(&spapr->mc_delivery_cond);
         rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+        migrate_del_blocker(spapr->migration_blocker);
+        error_free(spapr->migration_blocker);
+        spapr->migration_blocker = NULL;
     }
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 9d16ad1..dda5fd2 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -10,6 +10,7 @@
 #include "hw/ppc/spapr_irq.h"
 #include "hw/ppc/spapr_xive.h"  /* For SpaprXive */
 #include "hw/ppc/xics.h"        /* For ICSState */
+#include "qapi/error.h"
 
 struct SpaprVioBus;
 struct SpaprPhbState;
@@ -213,6 +214,8 @@ struct SpaprMachineState {
     SpaprCapabilities def, eff, mig;
 
     unsigned gpu_numa_id;
+
+    Error *migration_blocker;
 };
 
 #define H_SUCCESS         0
