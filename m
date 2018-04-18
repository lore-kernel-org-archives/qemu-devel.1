Received: from eggs.gnu.org ([2001:4830:134:3::10]:46736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8o5A-0006lU-Ql
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:29:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8o59-0003wB-QT
	for qemu-devel@nongnu.org; Wed, 18 Apr 2018 10:29:12 -0400
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed, 18 Apr 2018 16:28:03 +0200
Message-Id: <1524061685-83305-4-git-send-email-imammedo@redhat.com>
In-Reply-To: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
References: <1524061685-83305-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v2 3/5] pc: simplify
 MachineClass::get_hotplug_handler handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, peter.maydell@linaro.org, eric.auger@redhat.com, mst@redhat.com, ehabkost@redhat.com

By default MachineClass::get_hotplug_handler is NULL and concrete board
should set it to it's own handler.
Considering there isn't any default handler, drop saving empty
MachineClass::get_hotplug_handler in child class and make PC code
consistent with spapr/s390x boards.

We can bring this back when actual usecase surfaces and do it
consistently across boards that use get_hotplug_handler().

Suggested-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: mst@redhat.com
CC: ehabkost@redhat.com
---
 include/hw/i386/pc.h | 8 --------
 hw/i386/pc.c         | 6 +-----
 2 files changed, 1 insertion(+), 13 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffee841..fac6689 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -84,10 +84,6 @@ struct PCMachineState {
 /**
  * PCMachineClass:
  *
- * Methods:
- *
- * @get_hotplug_handler: pointer to parent class callback @get_hotplug_handler
- *
  * Compat fields:
  *
  * @enforce_aligned_dimm: check that DIMM's address/size is aligned by
@@ -107,10 +103,6 @@ struct PCMachineClass {
 
     /*< public >*/
 
-    /* Methods: */
-    HotplugHandler *(*get_hotplug_handler)(MachineState *machine,
-                                           DeviceState *dev);
-
     /* Device configuration: */
     bool pci_enabled;
     bool kvmclock_enabled;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index d36bac8..bc144d2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -2056,15 +2056,12 @@ static void pc_machine_device_unplug_cb(HotplugHandler *hotplug_dev,
 static HotplugHandler *pc_get_hotpug_handler(MachineState *machine,
                                              DeviceState *dev)
 {
-    PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(machine);
-
     if (object_dynamic_cast(OBJECT(dev), TYPE_PC_DIMM) ||
         object_dynamic_cast(OBJECT(dev), TYPE_CPU)) {
         return HOTPLUG_HANDLER(machine);
     }
 
-    return pcmc->get_hotplug_handler ?
-        pcmc->get_hotplug_handler(machine, dev) : NULL;
+    return NULL;
 }
 
 static void
@@ -2344,7 +2341,6 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     HotplugHandlerClass *hc = HOTPLUG_HANDLER_CLASS(oc);
     NMIClass *nc = NMI_CLASS(oc);
 
-    pcmc->get_hotplug_handler = mc->get_hotplug_handler;
     pcmc->pci_enabled = true;
     pcmc->has_acpi_build = true;
     pcmc->rsdp_in_ram = true;
-- 
2.7.4
