Received: from eggs.gnu.org ([2001:4830:134:3::10]:58318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfoE-0003Y5-HB
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:36:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gFfo8-0000Uy-Hn
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 09:36:22 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 25 Oct 2018 10:32:41 -0300
Message-Id: <20181025133301.16578-24-ehabkost@redhat.com>
In-Reply-To: <20181025133301.16578-1-ehabkost@redhat.com>
References: <20181025133301.16578-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PULL v2 23/43] memory-device: forward errors in
 get_region_size()/get_plugged_size()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Rob Herring <robh@kernel.org>, libvir-list@redhat.com, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-arm@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Markus Armbruster <armbru@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Eduardo Habkost <ehabkost@redhat.com>, Michael Walle <michael@walle.cc>, Thomas Huth <thuth@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair@alistair23.me>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Laurent Vivier <lvivier@redhat.com>, qemu-ppc@nongnu.org, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, David Hildenbrand <david@redhat.com>

From: David Hildenbrand <david@redhat.com>

Let's properly forward the errors, so errors from get_region_size() /
get_plugged_size() can be handled.

Users right now call both functions after the device has been realized,
which is will never fail, so it is fine to continue using error_abort.

While at it, remove a leftover error check (suggested by Igor).

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20181005092024.14344-8-david@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/mem/memory-device.h | 4 ++--
 hw/mem/memory-device.c         | 9 +++------
 hw/mem/pc-dimm.c               | 5 +++--
 3 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/include/hw/mem/memory-device.h b/include/hw/mem/memory-device.h
index 2853b084b5..f02b229837 100644
--- a/include/hw/mem/memory-device.h
+++ b/include/hw/mem/memory-device.h
@@ -33,8 +33,8 @@ typedef struct MemoryDeviceClass {
     InterfaceClass parent_class;
 
     uint64_t (*get_addr)(const MemoryDeviceState *md);
-    uint64_t (*get_plugged_size)(const MemoryDeviceState *md);
-    uint64_t (*get_region_size)(const MemoryDeviceState *md);
+    uint64_t (*get_plugged_size)(const MemoryDeviceState *md, Error **errp);
+    uint64_t (*get_region_size)(const MemoryDeviceState *md, Error **errp);
     void (*fill_device_info)(const MemoryDeviceState *md,
                              MemoryDeviceInfo *info);
 } MemoryDeviceClass;
diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
index 87369ef2e1..c1e1b81cf2 100644
--- a/hw/mem/memory-device.c
+++ b/hw/mem/memory-device.c
@@ -60,7 +60,7 @@ static int memory_device_used_region_size(Object *obj, void *opaque)
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_region_size(md);
+            *size += mdc->get_region_size(md, &error_abort);
         }
     }
 
@@ -167,10 +167,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
         uint64_t md_size, md_addr;
 
         md_addr = mdc->get_addr(md);
-        md_size = mdc->get_region_size(md);
-        if (*errp) {
-            goto out;
-        }
+        md_size = mdc->get_region_size(md, &error_abort);
 
         if (ranges_overlap(md_addr, md_size, new_addr, size)) {
             if (hint) {
@@ -234,7 +231,7 @@ static int memory_device_plugged_size(Object *obj, void *opaque)
         const MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj);
 
         if (dev->realized) {
-            *size += mdc->get_plugged_size(md);
+            *size += mdc->get_plugged_size(md, &error_abort);
         }
     }
 
diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index f46fb7ada2..130f78d0de 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -234,14 +234,15 @@ static uint64_t pc_dimm_md_get_addr(const MemoryDeviceState *md)
     return dimm->addr;
 }
 
-static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md)
+static uint64_t pc_dimm_md_get_region_size(const MemoryDeviceState *md,
+                                           Error **errp)
 {
     /* dropping const here is fine as we don't touch the memory region */
     PCDIMMDevice *dimm = PC_DIMM(md);
     const PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(md);
     MemoryRegion *mr;
 
-    mr = ddc->get_memory_region(dimm, &error_abort);
+    mr = ddc->get_memory_region(dimm, errp);
     if (!mr) {
         return 0;
     }
-- 
2.18.0.rc1.1.g3f1ff2140
