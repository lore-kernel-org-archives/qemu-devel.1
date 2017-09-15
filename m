Received: from eggs.gnu.org ([2001:4830:134:3::10]:54105)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfK-0006bQ-40
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dshfH-0003Js-14
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 23:51:42 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 15 Sep 2017 13:51:14 +1000
Message-Id: <20170915035130.8354-3-david@gibson.dropbear.id.au>
In-Reply-To: <20170915035130.8354-1-david@gibson.dropbear.id.au>
References: <20170915035130.8354-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 02/18] hw/ppc/spapr.c: cleaning up
 qdev_get_machine() calls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, gkurz@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>

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
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index caffa12763..06a008b43c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -391,10 +391,8 @@ static int spapr_fixup_cpu_dt(void *fdt, sPAPRMachineState *spapr)
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
@@ -1052,7 +1050,7 @@ static void *spapr_build_fdt(sPAPRMachineState *spapr,
                              hwaddr rtas_addr,
                              hwaddr rtas_size)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineState *machine = MACHINE(spapr);
     MachineClass *mc = MACHINE_GET_CLASS(machine);
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     int ret;
@@ -1372,7 +1370,7 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
     spapr_reallocate_hpt(spapr, hpt_shift, &error_fatal);
 
     if (spapr->vrma_adjust) {
-        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(),
+        spapr->rma_size = kvmppc_rma_size(spapr_node0_size(MACHINE(spapr)),
                                           spapr->htab_shift);
     }
     /* We're setting up a hash table, so that means we're not radix */
@@ -2033,7 +2031,7 @@ static SaveVMHandlers savevm_htab_handlers = {
 static void spapr_boot_set(void *opaque, const char *boot_device,
                            Error **errp)
 {
-    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineState *machine = MACHINE(opaque);
     machine->boot_order = g_strdup(boot_device);
 }
 
@@ -2235,7 +2233,7 @@ static void ppc_spapr_init(MachineState *machine)
     MemoryRegion *rma_region;
     void *rma = NULL;
     hwaddr rma_alloc_size;
-    hwaddr node0_size = spapr_node0_size();
+    hwaddr node0_size = spapr_node0_size(machine);
     long load_limit, fw_size;
     char *filename;
     Error *resize_hpt_err = NULL;
@@ -3298,7 +3296,8 @@ out:
 static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
                                       DeviceState *dev, Error **errp)
 {
-    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(qdev_get_machine());
+    MachineState *ms = MACHINE(hotplug_dev);
+    sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(ms);
 
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM)) {
         int node;
@@ -3347,8 +3346,8 @@ static void spapr_machine_device_plug(HotplugHandler *hotplug_dev,
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
2.13.5
