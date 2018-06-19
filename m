Received: from eggs.gnu.org ([2001:4830:134:3::10]:55299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGtj-00039k-6K
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGti-0004ME-7U
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:42:15 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 19 Jun 2018 15:41:39 +0200
Message-Id: <20180619134141.29478-11-david@redhat.com>
In-Reply-To: <20180619134141.29478-1-david@redhat.com>
References: <20180619134141.29478-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 10/12] nvdimm: convert nvdimm_mr into a
 pointer
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

This way we can easily check if the region has already been inititalized
without having to rely on the size of an uninitialized region being 0.

Free the region in nvdimm_finalize() and not in unrealize() as we will
allow to create the region before realization in following patches.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/nvdimm.c         | 17 +++++++++++++----
 include/hw/mem/nvdimm.h |  2 +-
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 7260c9c6b1..afd3912d6b 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -43,7 +43,7 @@ static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
     Error *local_err = NULL;
     uint64_t value;
 
-    if (memory_region_size(&nvdimm->nvdimm_mr)) {
+    if (nvdimm->nvdimm_mr) {
         error_setg(&local_err, "cannot change property value");
         goto out;
     }
@@ -71,11 +71,18 @@ static void nvdimm_init(Object *obj)
                         NULL, NULL);
 }
 
+static void nvdimm_finalize(Object *obj)
+{
+    NVDIMMDevice *nvdimm = NVDIMM(obj);
+
+    g_free(nvdimm->nvdimm_mr);
+}
+
 static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
 
-    return &nvdimm->nvdimm_mr;
+    return nvdimm->nvdimm_mr;
 }
 
 static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
@@ -102,9 +109,10 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
         return;
     }
 
-    memory_region_init_alias(&nvdimm->nvdimm_mr, OBJECT(dimm),
+    nvdimm->nvdimm_mr = g_new(MemoryRegion, 1);
+    memory_region_init_alias(nvdimm->nvdimm_mr, OBJECT(dimm),
                              "nvdimm-memory", mr, 0, pmem_size);
-    nvdimm->nvdimm_mr.align = align;
+    nvdimm->nvdimm_mr->align = align;
 }
 
 /*
@@ -167,6 +175,7 @@ static TypeInfo nvdimm_info = {
     .class_init    = nvdimm_class_init,
     .instance_size = sizeof(NVDIMMDevice),
     .instance_init = nvdimm_init,
+    .instance_finalize = nvdimm_finalize,
 };
 
 static void nvdimm_register_types(void)
diff --git a/include/hw/mem/nvdimm.h b/include/hw/mem/nvdimm.h
index 9340631cfc..c5c9b3c7f8 100644
--- a/include/hw/mem/nvdimm.h
+++ b/include/hw/mem/nvdimm.h
@@ -74,7 +74,7 @@ struct NVDIMMDevice {
      * it's the PMEM region in NVDIMM device, which is presented to
      * guest via ACPI NFIT and _FIT method if NVDIMM hotplug is supported.
      */
-    MemoryRegion nvdimm_mr;
+    MemoryRegion *nvdimm_mr;
 
     /*
      * The 'on' value results in the unarmed flag set in ACPI NFIT,
-- 
2.17.1
