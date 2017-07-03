Received: from eggs.gnu.org ([2001:4830:134:3::10]:55447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS4Wb-0003UZ-Ht
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:48:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dS4WY-0008NG-9D
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:48:37 -0400
Received: from 1.mo4.mail-out.ovh.net ([178.33.248.196]:42071)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dS4WX-0008Mg-Uu
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 12:48:34 -0400
Received: from player159.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 53CBE81349
	for <qemu-devel@nongnu.org>; Mon,  3 Jul 2017 18:48:32 +0200 (CEST)
From: Greg Kurz <groug@kaod.org>
Date: Mon, 03 Jul 2017 18:48:25 +0200
Message-ID: <149910050540.26371.12575732020425703531.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] spapr: make default PHB optionnal
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Shivaprasad G Bhat <sbhat@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Andrea Bolognani <abologna@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

The sPAPR machine always create a default PHB during initialization, even
if -nodefaults was passed on the command line. This forces the user to
rely on -global if she wants to set properties of the default PHB, such
as numa_node.

This patch introduces a new machine create-default-phb property to control
whether the default PHB must be created or not. It defaults to on in order
to preserve old setups (which is also the motivation to not alter the
current behavior of -nodefaults).

If create-default-phb is set to off, the default PHB isn't created, nor
any other device usually created with it. It is mandatory to provide
a PHB on the command line to be able to use PCI devices (otherwise QEMU
won't start). For example, the following creates a PHB with the same
mappings as the default PHB and also sets the NUMA affinity:

    -machine type=pseries,create-default-phb=off \
    -numa node,nodeid=0 -device spapr-pci-host-bridge,index=0,numa_node=0

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 hw/ppc/spapr.c         |   63 ++++++++++++++++++++++++++++++++++--------------
 include/hw/ppc/spapr.h |    2 ++
 2 files changed, 47 insertions(+), 18 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index ba8f57a5a054..3395bb3774b9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2103,7 +2103,7 @@ static void ppc_spapr_init(MachineState *machine)
     sPAPRMachineClass *smc = SPAPR_MACHINE_GET_CLASS(machine);
     const char *kernel_filename = machine->kernel_filename;
     const char *initrd_filename = machine->initrd_filename;
-    PCIHostState *phb;
+    PCIHostState *phb = NULL;
     int i;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
@@ -2294,7 +2294,9 @@ static void ppc_spapr_init(MachineState *machine)
     /* Set up PCI */
     spapr_pci_rtas_init();
 
-    phb = spapr_create_phb(spapr, 0);
+    if (spapr->create_default_phb) {
+        phb = spapr_create_phb(spapr, 0);
+    }
 
     for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
@@ -2305,7 +2307,7 @@ static void ppc_spapr_init(MachineState *machine)
 
         if (strcmp(nd->model, "ibmveth") == 0) {
             spapr_vlan_create(spapr->vio_bus, nd);
-        } else {
+        } else if (phb) {
             pci_nic_init_nofail(&nd_table[i], phb->bus, nd->model, NULL);
         }
     }
@@ -2314,24 +2316,26 @@ static void ppc_spapr_init(MachineState *machine)
         spapr_vscsi_create(spapr->vio_bus);
     }
 
-    /* Graphics */
-    if (spapr_vga_init(phb->bus, &error_fatal)) {
-        spapr->has_graphics = true;
-        machine->usb |= defaults_enabled() && !machine->usb_disabled;
-    }
-
-    if (machine->usb) {
-        if (smc->use_ohci_by_default) {
-            pci_create_simple(phb->bus, -1, "pci-ohci");
-        } else {
-            pci_create_simple(phb->bus, -1, "nec-usb-xhci");
+    if (phb) {
+        /* Graphics */
+        if (spapr_vga_init(phb->bus, &error_fatal)) {
+            spapr->has_graphics = true;
+            machine->usb |= defaults_enabled() && !machine->usb_disabled;
         }
 
-        if (spapr->has_graphics) {
-            USBBus *usb_bus = usb_bus_find(-1);
+        if (machine->usb) {
+            if (smc->use_ohci_by_default) {
+                pci_create_simple(phb->bus, -1, "pci-ohci");
+            } else {
+                pci_create_simple(phb->bus, -1, "nec-usb-xhci");
+            }
+
+            if (spapr->has_graphics) {
+                USBBus *usb_bus = usb_bus_find(-1);
 
-            usb_create_simple(usb_bus, "usb-kbd");
-            usb_create_simple(usb_bus, "usb-mouse");
+                usb_create_simple(usb_bus, "usb-kbd");
+                usb_create_simple(usb_bus, "usb-mouse");
+            }
         }
     }
 
@@ -2544,12 +2548,27 @@ static void spapr_set_modern_hotplug_events(Object *obj, bool value,
     spapr->use_hotplug_event_source = value;
 }
 
+static bool spapr_get_create_default_phb(Object *obj, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    return spapr->create_default_phb;
+}
+
+static void spapr_set_create_default_phb(Object *obj, bool value, Error **errp)
+{
+    sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
+
+    spapr->create_default_phb = value;
+}
+
 static void spapr_machine_initfn(Object *obj)
 {
     sPAPRMachineState *spapr = SPAPR_MACHINE(obj);
 
     spapr->htab_fd = -1;
     spapr->use_hotplug_event_source = true;
+    spapr->create_default_phb = true;
     object_property_add_str(obj, "kvm-type",
                             spapr_get_kvm_type, spapr_set_kvm_type, NULL);
     object_property_set_description(obj, "kvm-type",
@@ -2568,6 +2587,14 @@ static void spapr_machine_initfn(Object *obj)
     ppc_compat_add_property(obj, "max-cpu-compat", &spapr->max_compat_pvr,
                             "Maximum permitted CPU compatibility mode",
                             &error_fatal);
+
+    object_property_add_bool(obj, "create-default-phb",
+                            spapr_get_create_default_phb,
+                            spapr_set_create_default_phb,
+                            NULL);
+    object_property_set_description(obj, "create-default-phb",
+                                    "Create a default PCI Host Bridge",
+                                    NULL);
 }
 
 static void spapr_machine_finalizefn(Object *obj)
diff --git a/include/hw/ppc/spapr.h b/include/hw/ppc/spapr.h
index a184ffab0ebc..6ee914764807 100644
--- a/include/hw/ppc/spapr.h
+++ b/include/hw/ppc/spapr.h
@@ -93,6 +93,8 @@ struct sPAPRMachineState {
     bool use_hotplug_event_source;
     sPAPREventSource *event_sources;
 
+    bool create_default_phb;
+
     /* ibm,client-architecture-support option negotiation */
     bool cas_reboot;
     bool cas_legacy_guest_workaround;
