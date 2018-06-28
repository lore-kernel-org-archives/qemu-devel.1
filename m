Received: from eggs.gnu.org ([2001:4830:134:3::10]:38026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAe-0007FZ-Aq
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1fYdAc-0000UR-9U
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:36 -0400
Received: from mail-wr0-x22f.google.com ([2a00:1450:400c:c0c::22f]:37251)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1fYdAc-0000T8-0f
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:05:34 -0400
Received: by mail-wr0-x22f.google.com with SMTP id k6-v6so6687640wrp.4
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 13:05:33 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 28 Jun 2018 22:04:29 +0200
Message-Id: <1530216310-52873-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/60] pc-dimm: rename pc_dimm_memory_* to
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
Cc: David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's rename it to make it look more consistent.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20180619134141.29478-4-david@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/pc.c             | 4 ++--
 hw/mem/pc-dimm.c         | 6 +++---
 hw/ppc/spapr.c           | 6 +++---
 include/hw/mem/pc-dimm.h | 6 +++---
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f9250ff..f23133f 100644
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
index 62b34a9..9e0c83e 100644
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
index 0d032a1..3a1bd73 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -3160,7 +3160,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     align = memory_region_get_alignment(mr);
     size = memory_region_size(mr);
 
-    pc_dimm_memory_plug(dev, MACHINE(ms), align, &local_err);
+    pc_dimm_plug(dev, MACHINE(ms), align, &local_err);
     if (local_err) {
         goto out;
     }
@@ -3183,7 +3183,7 @@ static void spapr_memory_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
     return;
 
 out_unplug:
-    pc_dimm_memory_unplug(dev, MACHINE(ms));
+    pc_dimm_unplug(dev, MACHINE(ms));
 out:
     error_propagate(errp, local_err);
 }
@@ -3332,7 +3332,7 @@ static void spapr_memory_unplug(HotplugHandler *hotplug_dev, DeviceState *dev)
     sPAPRMachineState *spapr = SPAPR_MACHINE(hotplug_dev);
     sPAPRDIMMState *ds = spapr_pending_dimm_unplugs_find(spapr, PC_DIMM(dev));
 
-    pc_dimm_memory_unplug(dev, MACHINE(hotplug_dev));
+    pc_dimm_unplug(dev, MACHINE(hotplug_dev));
     object_unparent(OBJECT(dev));
     spapr_pending_dimm_unplugs_remove(spapr, ds);
 }
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index 627c860..860343d 100644
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
1.8.3.1
