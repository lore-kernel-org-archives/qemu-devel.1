Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dpfIU-0004oO-3u
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:43:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <danielhb@linux.vnet.ibm.com>) id 1dpfIP-0002gw-9g
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:43:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <danielhb@linux.vnet.ibm.com>)
	id 1dpfIP-0002gK-1B
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:43:29 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v86Ied8J050673
	for <qemu-devel@nongnu.org>; Wed, 6 Sep 2017 14:43:27 -0400
Received: from e11.ny.us.ibm.com (e11.ny.us.ibm.com [129.33.205.201])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ctpfjgbqk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 06 Sep 2017 14:43:27 -0400
Received: from localhost
	by e11.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <danielhb@linux.vnet.ibm.com>;
	Wed, 6 Sep 2017 14:43:21 -0400
From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
Date: Wed,  6 Sep 2017 15:43:05 -0300
Message-Id: <20170906184305.2612-1-danielhb@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr.c: cleaning up qdev_get_machine()
 calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, mdroth@linux.vnet.ibm.com

This patch removes the qdev_get_machine() calls that are made in
spapr.c in situations where we can get an existing pointer for
the MachineState by either passing it as an argument to the function
or by using other already available pointers.

The following changes were made:

- spapr_node0_size: static function that is called two times:
at spapr_setup_hpt_and_vrma and ppc_spapr_init. In both cases we can
pass an existing MachineState pointer to it.

- spapr_build_fdt: MachineState pointer can be retrieved from
the existing sPAPRMachineState pointer.

- spapr_boot_set: the opaque in the first arg is a sPAPRMachineState
pointer as we can see inside ppc_spapr_init:

    qemu_register_boot_set(spapr_boot_set, spapr);

We can get a MachineState pointer from it.

- spapr_machine_device_plug and spapr_machine_device_unplug_request: the
MachineState, sPAPRMachineState, MachineClass and sPAPRMachineClass pointers
can all be retrieved from the HotplugHandler pointer.

Signed-off-by: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>
---
 hw/ppc/spapr.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index cec441c..6ac3390 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -390,10 +390,8 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
     return ret;
 }
 
-static hwaddr spapr_node0_size(void)
+static hwaddr spapr_node0_size(MachineState *machine)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
-
     if (nb_numa_nodes) {
         int i;
         for (i = 0; i < nb_numa_nodes; ++i) {
@@ -1027,7 +1025,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
                              hwaddr rtas_addr,
                              hwaddr rtas_size)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     int ret;
@@ -1347,7 +1345,7 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
     spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
 
     if (spapr->vrma_adjust) {
-        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
+        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(MACHINE(spapr)),
                                           spapr->htab_shift);
     }
     /* We're setting up a hash table, so that means we're not radix */
@@ -2007,7 +2005,7 @@ static SaveVMHandlers savevm_htab_handlers = {
 static void spapr_boot_set(void *opaque, const char *boot_device,
                            Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineState *machine = MACHINE(opaque);
     machine->boot_order = g_strdup(boot_device);
 }
 
@@ -2154,7 +2152,7 @@ static void ppc_spapr_init(MachineState *machine)
     MemoryRegion *rma_region;
     void *rma = NULL;
     hwaddr rma_alloc_size;
-    hwaddr node0_size = spapr_node0_size();
+    hwaddr node0_size = spapr_node0_size(machine);
     long load_limit, fw_size;
     char *filename;
     Error *resize_hpt_err = NULL;
@@ -3198,7 +3196,8 @@ out:
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(qdev_get_machine());
+    MachineState *ms = MACHINE(hotplug_dev);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         int node;
@@ -3247,8 +3246,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
 static void spapr_machine_device_unplug_request(HotplugHandler *hotplug_dev,
                                                 DeviceState *dev, Error **errp)
 {
-    sPAPRMachineState *sms = SPAPR_MACHINE(qdev_get_machine());
-    MachineClass *mc = MACHINE_GET_CLASS(qdev_get_machine());
+    sPAPRMachineState *sms = SPAPR_MACHINE(OBJECT(hotplug_dev));
+    MachineClass *mc = MACHINE_GET_CLASS(sms);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         if (spapr_ovec_test(sms->ov5_cas, OV5_HP_EVT)) {
-- 
2.9.4
