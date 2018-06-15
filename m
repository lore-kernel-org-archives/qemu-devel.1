Received: from eggs.gnu.org ([2001:4830:134:3::10]:45835)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmrI-0008Ba-TX
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fTmrH-0000z2-OX
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 07:25:36 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 15 Jun 2018 13:24:58 +0200
Message-Id: <20180615112500.19854-11-david@redhat.com>
In-Reply-To: <20180615112500.19854-1-david@redhat.com>
References: <20180615112500.19854-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v2 10/12] nvdimm: convert "label-size" into a
 static property
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

We don't allow to modify it after realization. So we can simply turn
it into a static property. The value is now validated during realize().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/nvdimm.c | 53 ++++++++-----------------------------------------
 1 file changed, 8 insertions(+), 45 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index 7260c9c6b1..d3e8a5bcbb 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -27,50 +27,6 @@
 #include "qapi/visitor.h"
 #include "hw/mem/nvdimm.h"
 
-static void nvdimm_get_label_size(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
-{
-    NVDIMMDevice *nvdimm = NVDIMM(obj);
-    uint64_t value = nvdimm->label_size;
-
-    visit_type_size(v, name, &value, errp);
-}
-
-static void nvdimm_set_label_size(Object *obj, Visitor *v, const char *name,
-                                  void *opaque, Error **errp)
-{
-    NVDIMMDevice *nvdimm = NVDIMM(obj);
-    Error *local_err = NULL;
-    uint64_t value;
-
-    if (memory_region_size(&nvdimm->nvdimm_mr)) {
-        error_setg(&local_err, "cannot change property value");
-        goto out;
-    }
-
-    visit_type_size(v, name, &value, &local_err);
-    if (local_err) {
-        goto out;
-    }
-    if (value < MIN_NAMESPACE_LABEL_SIZE) {
-        error_setg(&local_err, "Property '%s.%s' (0x%" PRIx64 ") is required"
-                   " at least 0x%lx", object_get_typename(obj),
-                   name, value, MIN_NAMESPACE_LABEL_SIZE);
-        goto out;
-    }
-
-    nvdimm->label_size = value;
-out:
-    error_propagate(errp, local_err);
-}
-
-static void nvdimm_init(Object *obj)
-{
-    object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
-                        nvdimm_get_label_size, nvdimm_set_label_size, NULL,
-                        NULL, NULL);
-}
-
 static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
 {
     NVDIMMDevice *nvdimm = NVDIMM(dimm);
@@ -86,6 +42,13 @@ static void nvdimm_realize(PCDIMMDevice *dimm, Error **errp)
 
     align = memory_region_get_alignment(mr);
 
+    if (nvdimm->label_size && nvdimm->label_size < MIN_NAMESPACE_LABEL_SIZE) {
+        error_setg(errp, "the label-size (0x%" PRIx64 ") has to be "
+                   "either 0 or at least 0x%lx",
+                   nvdimm->label_size, MIN_NAMESPACE_LABEL_SIZE);
+        return;
+    }
+
     pmem_size = size - nvdimm->label_size;
     nvdimm->label_data = memory_region_get_ram_ptr(mr) + pmem_size;
     pmem_size = QEMU_ALIGN_DOWN(pmem_size, align);
@@ -143,6 +106,7 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
 
 static Property nvdimm_properties[] = {
     DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
+    DEFINE_PROP_UINT64(NVDIMM_LABEL_SIZE_PROP, NVDIMMDevice, label_size, 0),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -166,7 +130,6 @@ static TypeInfo nvdimm_info = {
     .class_size    = sizeof(NVDIMMClass),
     .class_init    = nvdimm_class_init,
     .instance_size = sizeof(NVDIMMDevice),
-    .instance_init = nvdimm_init,
 };
 
 static void nvdimm_register_types(void)
-- 
2.17.1
