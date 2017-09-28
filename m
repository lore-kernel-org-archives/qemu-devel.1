Received: from eggs.gnu.org ([2001:4830:134:3::10]:50418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxWCc-0003c5-Rp
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:37:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dxWCZ-0007bx-09
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:37:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55558)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dxWCY-0007bc-Nf
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 06:37:54 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SAXukE055708
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:37:49 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2d8vf09taq-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 06:37:49 -0400
Received: from localhost
	by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Thu, 28 Sep 2017 04:37:47 -0600
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Thu, 28 Sep 2017 16:07:38 +0530
In-Reply-To: <150659494872.25889.2069124544245723984.stgit@aravinda>
References: <150659494872.25889.2069124544245723984.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150659505839.25889.2018054058894535368.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v5 1/6] ppc: spapr: Register and handle HCALL
 to receive updated RTAS region
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

Receive updates from SLOF about the updated rtas-base.
A separate patch for SLOF [1] (commit f9a60de3) adds
functionality to invoke a private HCALL whenever OS
issues instantiate-rtas with a new rtas-base.

This is required as QEMU needs to know the updated rtas-base
as it allocates error reporting structure in RTAS space upon
a machine check exception.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-August/120386.html

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c         |   11 +++++++++++
 hw/ppc/spapr_hcall.c   |    8 ++++++++
 include/hw/ppc/spapr.h |    4 +++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ff87f15..5deae30 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1675,6 +1675,16 @@ static const VMStateDescription vmstate_spapr_patb_entry = {
     },
 };
 
+static const VMStateDescription vmstate_spapr_rtas_addr = {
+    .name = "spapr_rtas_addr",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields = (VMStateField[]) {
+        VMSTATE_UINT64(rtas_addr, sPAPRMachineState),
+        VMSTATE_END_OF_LIST()
+    },
+};
+
 static const VMStateDescription vmstate_spapr = {
     .name = "spapr",
     .version_id = 3,
@@ -1694,6 +1704,7 @@ static const VMStateDescription vmstate_spapr = {
         &vmstate_spapr_ov5_cas,
         &vmstate_spapr_patb_entry,
         &vmstate_spapr_pending_events,
+        &vmstate_spapr_rtas_addr,
         NULL
     }
 };
diff --git a/hw/ppc/spapr_hcall.c b/hw/ppc/spapr_hcall.c
index 8d72bb7..c15a93c 100644
--- a/hw/ppc/spapr_hcall.c
+++ b/hw/ppc/spapr_hcall.c
@@ -1088,6 +1088,13 @@ static target_ulong h_rtas(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                            nret, rtas_r3 + 12 + 4*nargs);
 }
 
+static target_ulong h_rtas_update(PowerPCCPU *cpu, sPAPRMachineState *spapr,
+                                  target_ulong opcode, target_ulong *args)
+{
+    spapr->rtas_addr = args[0];
+    return 0;
+}
+
 static target_ulong h_logical_load(PowerPCCPU *cpu, sPAPRMachineState *spapr,
                                    target_ulong opcode, target_ulong *args)
 {
@@ -1750,6 +1757,7 @@ static void hypercall_register_types(void)
 
     /* qemu/KVM-PPC specific hcalls */
     spapr_register_hypercall(KVMPPC_H_RTAS, h_rtas);
+    spapr_register_hypercall(KVMPPC_H_RTAS_UPDATE, h_rtas_update);
 
     /* ibm,client-architecture-support support */
     spapr_register_hypercall(KVMPPC_H_CAS, h_client_architecture_support);
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index c1b365f..b395aa7 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -90,6 +90,7 @@ struct sPAPRMachineState {
 
     hwaddr rma_size;
     int vrma_adjust;
+    hwaddr rtas_addr;
     ssize_t rtas_size;
     void *rtas_blob;
     long kernel_size;
@@ -400,7 +401,8 @@ struct sPAPRMachineState {
 #define KVMPPC_H_LOGICAL_MEMOP  (KVMPPC_HCALL_BASE + 0x1)
 /* Client Architecture support */
 #define KVMPPC_H_CAS            (KVMPPC_HCALL_BASE + 0x2)
-#define KVMPPC_HCALL_MAX        KVMPPC_H_CAS
+#define KVMPPC_H_RTAS_UPDATE    (KVMPPC_HCALL_BASE + 0x3)
+#define KVMPPC_HCALL_MAX        KVMPPC_H_RTAS_UPDATE
 
 typedef struct sPAPRDeviceTreeUpdateHeader {
     uint32_t version_id;
