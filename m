Received: from eggs.gnu.org ([2001:4830:134:3::10]:60059)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dieBg-0002Ms-SJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:07:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aravinda@linux.vnet.ibm.com>) id 1dieBd-0007qw-Mf
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:07:32 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54725)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aravinda@linux.vnet.ibm.com>)
	id 1dieBd-0007qd-Dy
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 06:07:29 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7IA6nZr134063
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 06:07:28 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cdwgdjatd-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 06:07:28 -0400
Received: from localhost
	by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <aravinda@linux.vnet.ibm.com>;
	Fri, 18 Aug 2017 06:07:26 -0400
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
Date: Fri, 18 Aug 2017 15:37:10 +0530
In-Reply-To: <150305073858.13788.4068645609072927349.stgit@aravinda>
References: <150305073858.13788.4068645609072927349.stgit@aravinda>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <150305083050.13788.3778100698636337373.stgit@aravinda>
Subject: [Qemu-devel] [PATCH v4 2/5] ppc: spapr: Handle "ibm,
 nmi-register" and "ibm, nmi-interlock" RTAS calls
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

This patch adds support in QEMU to handle "ibm,nmi-register"
and "ibm,nmi-interlock" RTAS calls.

The machine check notification address is saved when the
OS issues "ibm,nmi-register" RTAS call.

This patch also handles the case when multiple processors
experience machine check at or about the same time by
handling "ibm,nmi-interlock" call. In such cases, as per
PAPR, subsequent processors serialize waiting for the first
processor to issue the "ibm,nmi-interlock" call. The second
processor waits till the first processor, which also
received a machine check error, is done reading the error
log. The first processor issues "ibm,nmi-interlock" call
when the error log is consumed. This patch implements the
releasing part of the error-log while subsequent patch
(which builds error log) handles the locking part.

Signed-off-by: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c         |    8 ++++++++
 hw/ppc/spapr_rtas.c    |   35 +++++++++++++++++++++++++++++++++++
 include/hw/ppc/spapr.h |   10 +++++++++-
 3 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2a3e53d..0bb2c4a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1441,6 +1441,11 @@ static void ppc_spapr_reset(void)
     first_ppc_cpu->env.nip = SPAPR_ENTRY_POINT;
 
     spapr->cas_reboot = false;
+
+    spapr->mc_in_progress = false;
+    spapr->guest_machine_check_addr = 0;
+    qemu_cond_destroy(&spapr->mc_delivery_cond);
+    qemu_cond_init(&spapr->mc_delivery_cond);
 }
 
 static void spapr_create_nvram(sPAPRMachineState *spapr)
@@ -2491,6 +2496,9 @@ static void ppc_spapr_init(MachineState *machine)
 
         kvmppc_spapr_enable_inkernel_multitce();
     }
+
+    spapr->mc_in_progress = false;
+    qemu_cond_init(&spapr->mc_delivery_cond);
 }
 
 static int spapr_kvm_type(const char *vm_type)
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 94a2799..2f3c47b 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -348,6 +348,37 @@ static void rtas_get_power_level(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     rtas_st(rets, 1, 100);
 }
 
+static void rtas_ibm_nmi_register(PowerPCCPU *cpu,
+                                  sPAPRMachineState *spapr,
+                                  uint32_t token, uint32_t nargs,
+                                  target_ulong args,
+                                  uint32_t nret, target_ulong rets)
+{
+    spapr->guest_machine_check_addr = rtas_ld(args, 1);
+    rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+}
+
+static void rtas_ibm_nmi_interlock(PowerPCCPU *cpu,
+                                   sPAPRMachineState *spapr,
+                                   uint32_t token, uint32_t nargs,
+                                   target_ulong args,
+                                   uint32_t nret, target_ulong rets)
+{
+    if (!spapr->guest_machine_check_addr) {
+        /* NMI register not called */
+        rtas_st(rets, 0, RTAS_OUT_PARAM_ERROR);
+    } else {
+        /*
+         * VCPU issuing "ibm,nmi-interlock" is done with NMI handling,
+         * hence unset mc_in_progress.
+         */
+        spapr->mc_in_progress = false;
+        qemu_cond_signal(&spapr->mc_delivery_cond);
+        rtas_st(rets, 0, RTAS_OUT_SUCCESS);
+    }
+}
+
+
 static struct rtas_call {
     const char *name;
     spapr_rtas_fn fn;
@@ -489,6 +520,10 @@ static void core_rtas_register_types(void)
                         rtas_set_power_level);
     spapr_rtas_register(RTAS_GET_POWER_LEVEL, "get-power-level",
                         rtas_get_power_level);
+    spapr_rtas_register(RTAS_IBM_NMI_REGISTER, "ibm,nmi-register",
+                        rtas_ibm_nmi_register);
+    spapr_rtas_register(RTAS_IBM_NMI_INTERLOCK, "ibm,nmi-interlock",
+                        rtas_ibm_nmi_interlock);
 }
 
 type_init(core_rtas_register_types)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index 46012b3..eee8d33 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -123,6 +123,12 @@ struct sPAPRMachineState {
      * occurs during the unplug process. */
     QTAILQ_HEAD(, sPAPRDIMMState) pending_dimm_unplugs;
 
+    /* State related to "ibm,nmi-register" and "ibm,nmi-interlock" calls */
+    target_ulong guest_machine_check_addr;
+    bool mc_in_progress;
+    int mc_cpu;
+    QemuCond mc_delivery_cond;
+
     /*< public >*/
     char *kvm_type;
     MemoryHotplugState hotplug_memory;
@@ -519,8 +525,10 @@ target_ulong spapr_hypercall(PowerPCCPU *cpu, target_ulong opcode,
 #define RTAS_IBM_CREATE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x27)
 #define RTAS_IBM_REMOVE_PE_DMA_WINDOW           (RTAS_TOKEN_BASE + 0x28)
 #define RTAS_IBM_RESET_PE_DMA_WINDOW            (RTAS_TOKEN_BASE + 0x29)
+#define RTAS_IBM_NMI_REGISTER                   (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_IBM_NMI_INTERLOCK                  (RTAS_TOKEN_BASE + 0x2B)
 
-#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2A)
+#define RTAS_TOKEN_MAX                          (RTAS_TOKEN_BASE + 0x2C)
 
 /* RTAS ibm,get-system-parameter token values */
 #define RTAS_SYSPARM_SPLPAR_CHARACTERISTICS      20
