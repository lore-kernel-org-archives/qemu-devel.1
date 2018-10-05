Received: from eggs.gnu.org ([2001:4830:134:3::10]:47428)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRe-0001qa-Sc
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MJZ-0006tZ-VD
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:22:33 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:21 +0200
Message-Id: <20181005092024.14344-14-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 13/16] memory-device: complete factoring out
 pre_plug handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Auger Eric <eric.auger@redhat.com>, David Hildenbrand <david@redhat.com>

With all required memory device class functions in place, we can factor
out pre_plug handling of memory devices. Take proper care of errors. We
still have to carry along legacy_align required for pc compatibility
handling.

We will factor out tracing of the address separately in a follow-up
patch.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 32 +++++++++++++++++++++++++++++---
 hw/mem/pc-dimm.c               | 15 +++------------
 include/hw/mem/memory-device.h |  5 ++---
 3 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 07749bab69..aa4ddd5918 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -93,9 +93,10 @@ static void memory_device_check_addable(MachineState *ms, uint64_t size,
 
 }
 
-uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
-                                     uint64_t align, uint64_t size,
-                                     Error **errp)
+static uint64_t memory_device_get_free_addr(MachineState *ms,
+                                            const uint64_t *hint,
+                                            uint64_t align, uint64_t size,
+                                            Error **errp)
 {
     uint64_t address_space_start, address_space_end;
     GSList *list = NULL, *item;
@@ -247,6 +248,31 @@ uint64_t get_plugged_memory_size(void)
     return size;
 }
 
+void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
+                            const uint64_t *legacy_align, Error **errp)
+{
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    Error *local_err = NULL;
+    uint64_t addr, align;
+    MemoryRegion *mr;
+
+    mr = mdc->get_memory_region(md, &local_err);
+    if (local_err) {
+        goto out;
+    }
+
+    align = legacy_align ? *legacy_align : memory_region_get_alignment(mr);
+    addr = mdc->get_addr(md);
+    addr = memory_device_get_free_addr(ms, !addr ? NULL : &addr, align,
+                                       memory_region_size(mr), &local_err);
+    if (local_err) {
+        goto out;
+    }
+    mdc->set_addr(md, addr, &local_err);
+out:
+    error_propagate(errp, local_err);
+}
+
 void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                uint64_t addr)
 {
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 4a15091734..b2959bcf0e 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -32,10 +32,8 @@ static int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp);
 void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                       const uint64_t *legacy_align, Error **errp)
 {
-    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(dimm);
     Error *local_err = NULL;
-    MemoryRegion *mr;
-    uint64_t addr, align;
+    uint64_t addr;
     int slot;
 
     slot = object_property_get_int(OBJECT(dimm), PC_DIMM_SLOT_PROP,
@@ -49,22 +47,15 @@ void pc_dimm_pre_plug(PCDIMMDevice *dimm, MachineState *machine,
                             &error_abort);
     trace_mhp_pc_dimm_assigned_slot(slot);
 
-    mr = mdc->get_memory_region(MEMORY_DEVICE(dimm), &local_err);
+    memory_device_pre_plug(MEMORY_DEVICE(dimm), machine, legacy_align,
+                           &local_err);
     if (local_err) {
         goto out;
     }
 
-    align = legacy_align ? *legacy_align : memory_region_get_alignment(mr);
     addr = object_property_get_uint(OBJECT(dimm), PC_DIMM_ADDR_PROP,
                                     &error_abort);
-    addr = memory_device_get_free_addr(machine, !addr ? NULL : &addr, align,
-                                       memory_region_size(mr), &local_err);
-    if (local_err) {
-        goto out;
-    }
     trace_mhp_pc_dimm_assigned_address(addr);
-    object_property_set_uint(OBJECT(dimm), addr, PC_DIMM_ADDR_PROP,
-                             &error_abort);
 out:
     error_propagate(errp, local_err);
 }
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index ed7cf5bf4b..d92acd2425 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -99,9 +99,8 @@ typedef struct MemoryDeviceClass {
 
 MemoryDeviceInfoList *qmp_memory_device_list(void);
 uint64_t get_plugged_memory_size(void);
-uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
-                                     uint64_t align, uint64_t size,
-                                     Error **errp);
+void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
+                            const uint64_t *legacy_align, Error **errp);
 void memory_device_plug_region(MachineState *ms, MemoryRegion *mr,
                                uint64_t addr);
 void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
-- 
2.17.1
