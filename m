Received: from eggs.gnu.org ([2001:4830:134:3::10]:50799)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxWDX-0004KA-I5
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:38:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxWDT-0007wz-Kw
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:38:55 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37564)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dxWDT-0007wi-B9
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:38:51 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SAcobB081710
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:38:50 -0400
Received: from e14.ny.us.ibm.com (e14.ny.us.ibm.com [129.33.205.204])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d8v752tcn-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:38:50 -0400
Received: from localhost
	by e14.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Thu, 28 Sep 2017 06:38:40 -0400
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 28 Sep 2017 16:08:31 +0530
In-Reply-To: <150659494872.25889.2069124544245723984.stgit@aravinda>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150659511184.25889.10868411111377268218.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v5 6/6] migration: Block migration while
 handling machine check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, david@gibson.dropbear.id.au
Cc: aik@ozlabs.ru, mahesh@linux.vnet.ibm.com, benh@au1.ibm.com, paulus@samba.org, sam.bobroff@au1.ibm.com

Block VM migration requests until the machine check
error handling is complete as (i) these errors are
specific to the source hardware and is irrelevant on
the target hardware, (ii) these errors cause data
corruption and should be handled before migration.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr_rtas.c    |    3 +++
 include/hw/ppc/spapr.h |    2 ++
 target/ppc/kvm.c       |   17 +++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index d017a67..17f6567 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -47,6 +47,7 @@
 #include "trace.h"
 #include "hw/ppc/fdt.h"
 #include "kvm_ppc.h"
+#include "migration/blocker.h"
 
 static void rtas_display_character(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                    uint32_t token, uint32_t nargs,
@@ -390,6 +391,8 @@ static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
         spapr->mc_status = -1;
         qemu_cond_signal(&spapr->mc_delivery_cond);
         rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+        migrate_del_blocker(spapr->migration_blocker);
+        error_free(spapr->migration_blocker);
     }
 }
 
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a75e9cf..0890a44 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -7,6 +7,7 @@
 #include "hw/ppc/spapr_drc.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/ppc/spapr_ovec.h"
+#include "qapi/error.h"
 
 struct VIOsPAPRBus;
 struct sPAPRPHBState;
@@ -136,6 +137,7 @@ struct sPAPRMachineState {
     MemoryHotplugState hotplug_memory;
 
     const char *icp_type;
+    Error *migration_blocker;
 };
 
 #define H_SUCCESS         0
diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 59b3322..58de7ea 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -52,6 +52,7 @@
 #endif
 #include "elf.h"
 #include "sysemu/kvm_int.h"
+#include "migration/blocker.h"
 
 //#define DEBUG_KVM
 
@@ -2770,10 +2771,26 @@ int kvm_handle_nmi(PowerPCCPU *cpu, struct kvm_run *run)
     sPAPRMachineState *spapr = SPAPR_MACHINE(qdev_get_machine());
     PowerPCCPUClass *pcc = POWERPC_CPU_GET_CLASS(cpu);
     target_ulong msr = 0;
+    Error *local_err = NULL;
+    int ret;
     bool type, le;
 
     cpu_synchronize_state(CPU(cpu));
 
+    error_setg(&spapr->migration_blocker,
+            "Live migration not supported during machine check error handling");
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
+
     /*
      * Properly set bits in MSR before we invoke the handler.
      * SRR0/1, DAR and DSISR are properly set by KVM
