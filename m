Received: from eggs.gnu.org ([2001:4830:134:3::10]:55027)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGtQ-0002qE-NZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:41:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGtP-0004DT-JZ
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:41:56 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 19 Jun 2018 15:41:32 +0200
Message-Id: <20180619134141.29478-4-david@redhat.com>
In-Reply-To: <20180619134141.29478-1-david@redhat.com>
References: <20180619134141.29478-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 03/12] pc-dimm: rename pc_dimm_memory_* to
 pc_dimm_*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, David Hildenbrand <david@redhat.com>

Let's rename it to make it look more consistent.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/i386/pc.c             | 4 ++--
 hw/mem/pc-dimm.c         | 6 +++---
 hw/ppc/spapr.c           | 6 +++---
 include/hw/mem/pc-dimm.h | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9250ffae7..f23133facc 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1713,7 +1713,7 @@ static void pc_memory_plug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_plug(dev, MACHINE(pcms), align, &local_err);
+    pc_dimm_plug(dev, MACHINE(pcms), align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -1773,7 +1773,7 @@ static void pc_memory_unplug(HotplugHandler *hotplug_dev,
         goto out;
     }
 
-    pc_dimm_memory_unplug(dev, MACHINE(pcms));
+    pc_dimm_unplug(dev, MACHINE(pcms));
     object_unparent(OBJECT(dev));
 
  out:
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 62b34a992e..9e0c83e415 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -27,8 +27,8 @@
 #include "sysemu/numa.h"
 #include "trace.h"
 
-void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
-                         uint64_t align, Error **errp)
+void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
+                  Error **errp)
 {
     int slot;
     PCDIMMDevice *dimm = PC_DIMM(dev);
@@ -84,7 +84,7 @@ out:
     error_propagate(errp, local_err);
 }
 
-void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine)
+void pc_dimm_unplug(DeviceState *dev, MachineState *machine)
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index db0fb385d4..4250a3c9b8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3159,7 +3159,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
+    pc_dimm_plug(dev, MACHINE(ms), align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -3182,7 +3182,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_memory_unplug(dev, MACHINE(ms));
+    pc_dimm_unplug(dev, MACHINE(ms));
 out:
     error_propagate(errp, local_err);
 }
@@ -3334,7 +3334,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
-    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
+    pc_dimm_unplug(dev, MACHINE(hotplug_dev));
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 627c8601d9..860343d64f 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -78,7 +78,7 @@ typedef struct PCDIMMDeviceClass {
 
 int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 
-void pc_dimm_memory_plug(DeviceState *dev, MachineState *machine,
-                         uint64_t align, Error **errp);
-void pc_dimm_memory_unplug(DeviceState *dev, MachineState *machine);
+void pc_dimm_plug(DeviceState *dev, MachineState *machine, uint64_t align,
+                  Error **errp);
+void pc_dimm_unplug(DeviceState *dev, MachineState *machine);
 #endif
-- 
2.17.1
