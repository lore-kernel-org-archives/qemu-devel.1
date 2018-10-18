Received: from eggs.gnu.org ([2001:4830:134:3::10]:40493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbO-00038g-0R
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gDEbJ-0003BR-Ky
	for qemu-devel@nongnu.org; Thu, 18 Oct 2018 16:09:01 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 18 Oct 2018 17:04:09 -0300
Message-Id: <20181018200422.4358-33-ehabkost@redhat.com>
In-Reply-To: <20181018200422.4358-1-ehabkost@redhat.com>
References: <20181018200422.4358-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL 32/45] memory-device: complete factoring out
 unplug handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

With the new memory device functions in place, we can factor out
unplugging of memory devices completely.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-16-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/memory-device.h |  2 +-
 hw/mem/memory-device.c         | 11 +++++++++--
 hw/mem/pc-dimm.c               |  5 +----
 3 files changed, 11 insertions(+), 7 deletions(-)

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
 
-- 
2.18.0.rc1.1.g3f1ff2140
