Received: from eggs.gnu.org ([2001:4830:134:3::10]:50208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUT-0000hC-UJ
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fEGUT-0003hT-3Y
	for qemu-devel@nongnu.org; Thu, 03 May 2018 11:49:53 -0400
From: David Hildenbrand <david@redhat.com>
Date: Thu,  3 May 2018 17:49:31 +0200
Message-Id: <20180503154936.18946-4-david@redhat.com>
In-Reply-To: <20180503154936.18946-1-david@redhat.com>
References: <20180503154936.18946-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v1 3/8] machine: provide default resource
 handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Most resources that can't be handled via the hotplug handler will have
to assign "system wide" resource. This is e.g. the case for memory
devices. This will allow for a quite clean implementation for such
handling.

The new functions will soon be filled with life.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/core/machine.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 2040177664..a41068410c 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -517,8 +517,31 @@ void machine_set_cpu_numa_node(MachineState *machine,
     }
 }
 
+static ResourceHandler *machine_get_resource_handler(MachineState *machine,
+                                                     const DeviceState *dev)
+{
+    return NULL;
+}
+
+static void machine_resource_handler_pre_assign(ResourceHandler *rh,
+                                                const DeviceState *dev,
+                                                Error **errp)
+{
+}
+
+static void machine_resource_handler_assign(ResourceHandler *rh,
+                                            DeviceState *dev, Error **errp)
+{
+}
+
+static void machine_resource_handler_unassign(ResourceHandler *rh,
+                                              DeviceState *dev)
+{
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
+    ResourceHandlerClass *rhc = RESOURCE_HANDLER_CLASS(oc);
     MachineClass *mc = MACHINE_CLASS(oc);
 
     /* Default 128 MB as guest ram size */
@@ -531,6 +554,12 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->numa_mem_align_shift = 23;
     mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
 
+    /* default resource handler */
+    mc->get_resource_handler = machine_get_resource_handler;
+    rhc->pre_assign = machine_resource_handler_pre_assign;
+    rhc->assign = machine_resource_handler_assign;
+    rhc->unassign = machine_resource_handler_unassign;
+
     object_class_property_add_str(oc, "accel",
         machine_get_accel, machine_set_accel, &error_abort);
     object_class_property_set_description(oc, "accel",
@@ -868,6 +897,10 @@ static const TypeInfo machine_info = {
     .instance_size = sizeof(MachineState),
     .instance_init = machine_initfn,
     .instance_finalize = machine_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_RESOURCE_HANDLER },
+        { }
+    },
 };
 
 static void machine_register_types(void)
-- 
2.14.3
