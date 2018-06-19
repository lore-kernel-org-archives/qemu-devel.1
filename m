Received: from eggs.gnu.org ([2001:4830:134:3::10]:55245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGtg-00036I-1I
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:42:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fVGtf-0004L2-1y
	for qemu-devel@nongnu.org; Tue, 19 Jun 2018 09:42:12 -0400
From: David Hildenbrand <david@redhat.com>
Date: Tue, 19 Jun 2018 15:41:38 +0200
Message-Id: <20180619134141.29478-10-david@redhat.com>
In-Reply-To: <20180619134141.29478-1-david@redhat.com>
References: <20180619134141.29478-1-david@redhat.com>
Subject: [Qemu-devel] [PATCH v5 09/12] nvdimm: convert "unarmed" into a
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
it into a static property.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/mem/nvdimm.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/hw/mem/nvdimm.c b/hw/mem/nvdimm.c
index df9716231f..7260c9c6b1 100644
--- a/hw/mem/nvdimm.c
+++ b/hw/mem/nvdimm.c
@@ -64,36 +64,11 @@ out:
     error_propagate(errp, local_err);
 }
 
-static bool nvdimm_get_unarmed(Object *obj, Error **errp)
-{
-    NVDIMMDevice *nvdimm = NVDIMM(obj);
-
-    return nvdimm->unarmed;
-}
-
-static void nvdimm_set_unarmed(Object *obj, bool value, Error **errp)
-{
-    NVDIMMDevice *nvdimm = NVDIMM(obj);
-    Error *local_err = NULL;
-
-    if (memory_region_size(&nvdimm->nvdimm_mr)) {
-        error_setg(&local_err, "cannot change property value");
-        goto out;
-    }
-
-    nvdimm->unarmed = value;
-
- out:
-    error_propagate(errp, local_err);
-}
-
 static void nvdimm_init(Object *obj)
 {
     object_property_add(obj, NVDIMM_LABEL_SIZE_PROP, "int",
                         nvdimm_get_label_size, nvdimm_set_label_size, NULL,
                         NULL, NULL);
-    object_property_add_bool(obj, NVDIMM_UNARMED_PROP,
-                             nvdimm_get_unarmed, nvdimm_set_unarmed, NULL);
 }
 
 static MemoryRegion *nvdimm_get_memory_region(PCDIMMDevice *dimm, Error **errp)
@@ -166,13 +141,20 @@ static void nvdimm_write_label_data(NVDIMMDevice *nvdimm, const void *buf,
     memory_region_set_dirty(mr, backend_offset, size);
 }
 
+static Property nvdimm_properties[] = {
+    DEFINE_PROP_BOOL(NVDIMM_UNARMED_PROP, NVDIMMDevice, unarmed, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void nvdimm_class_init(ObjectClass *oc, void *data)
 {
     PCDIMMDeviceClass *ddc = PC_DIMM_CLASS(oc);
     NVDIMMClass *nvc = NVDIMM_CLASS(oc);
+    DeviceClass *dc = DEVICE_CLASS(oc);
 
     ddc->realize = nvdimm_realize;
     ddc->get_memory_region = nvdimm_get_memory_region;
+    dc->props = nvdimm_properties;
 
     nvc->read_label_data = nvdimm_read_label_data;
     nvc->write_label_data = nvdimm_write_label_data;
-- 
2.17.1
