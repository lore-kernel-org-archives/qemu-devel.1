Received: from eggs.gnu.org ([2001:4830:134:3::10]:47461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MRe-0001qo-2O
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:30:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1g8MJr-000706-4E
	for qemu-devel@nongnu.org; Fri, 05 Oct 2018 05:22:47 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri,  5 Oct 2018 11:20:23 +0200
Message-Id: <20181005092024.14344-16-david@redhat.com>
In-Reply-To: <20181005092024.14344-1-david@redhat.com>
References: <20181005092024.14344-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 15/16] memory-device: complete factoring out
 unplug handling
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

With the new memory device functions in place, we can factor out
unplugging of memory devices completely.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/memory-device.c         | 11 +++++++++--
 hw/mem/pc-dimm.c               |  5 +----
 include/hw/mem/memory-device.h |  2 +-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 6569896b7e..30585d6148 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -290,9 +290,16 @@ void memory_device_plug(MemoryDeviceState *md, MachineState *ms)
                                 addr - ms->device_memory->base, mr);
 }
 
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr)
+void memory_device_unplug(MemoryDeviceState *md, MachineState *ms)
 {
-    /* we expect a previous call to memory_device_get_free_addr() */
+    const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(md);
+    MemoryRegion *mr;
+
+    /*
+     * We expect that a previous call to memory_device_pre_plug() succeeded, so
+     * it can't fail at this point.
+     */
+    mr = mdc->get_memory_region(md, &error_abort);
     g_assert(ms->device_memory);
 
     memory_region_del_subregion(&ms->device_memory->mr, mr);
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 647841bcd4..6c854139a7 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -73,13 +73,10 @@ void pc_dimm_plug(PCDIMMDevice *dimm, MachineState *machine, Error **errp)
 void pc_dimm_unplug(PCDIMMDevice *dimm, MachineState *machine)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(dimm);
     MemoryRegion *vmstate_mr = ddc->get_vmstate_memory_region(dimm,
                                                               &error_abort);
-    MemoryRegion *mr = mdc->get_memory_region(MEMORY_DEVICE(dimm),
-                                              &error_abort);
 
-    memory_device_unplug_region(machine, mr);
+    memory_device_unplug(MEMORY_DEVICE(dimm), machine);
     vmstate_unregister_ram(vmstate_mr, DEVICE(dimm));
 }
 
diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 53d89dac89..e904e194d5 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -102,7 +102,7 @@ uint64_t get_plugged_memory_size(void);
 void memory_device_pre_plug(MemoryDeviceState *md, MachineState *ms,
                             const uint64_t *legacy_align, Error **errp);
 void memory_device_plug(MemoryDeviceState *md, MachineState *ms);
-void memory_device_unplug_region(MachineState *ms, MemoryRegion *mr);
+void memory_device_unplug(MemoryDeviceState *md, MachineState *ms);
 uint64_t memory_device_get_region_size(const MemoryDeviceState *md,
                                        Error **errp);
 
-- 
2.17.1
