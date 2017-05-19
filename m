Received: from eggs.gnu.org ([2001:4830:134:3::10]:35374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYT0-0006uL-Ub
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dBYSr-0005XL-7m
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36354)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dBYSq-0005X5-VN
	for qemu-devel@nongnu.org; Thu, 18 May 2017 23:20:29 -0400
From: Peter Xu <peterx@redhat.com>
Date: Fri, 19 May 2017 11:19:42 +0800
Message-Id: <1495163989-9994-4-git-send-email-peterx@redhat.com>
In-Reply-To: <1495163989-9994-1-git-send-email-peterx@redhat.com>
References: <1495163989-9994-1-git-send-email-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v4 03/10] x86-iommu: use DeviceClass properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, peterx@redhat.com, Jason Wang <jasowang@redhat.com>

No reason to keep tens of lines if we can do it actually far shorter.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 hw/i386/x86-iommu.c | 47 +++++++----------------------------------------
 1 file changed, 7 insertions(+), 40 deletions(-)

diff --git a/hw/i386/x86-iommu.c b/hw/i386/x86-iommu.c
index 23dcd3f..02b8825 100644
--- a/hw/i386/x86-iommu.c
+++ b/hw/i386/x86-iommu.c
@@ -88,55 +88,22 @@ static void x86_iommu_realize(DeviceState *dev, Error **errp)
     x86_iommu_set_default(X86_IOMMU_DEVICE(dev));
 }
 
+static Property x86_iommu_properties[] = {
+    DEFINE_PROP_BOOL("intremap", X86IOMMUState, intr_supported, false),
+    DEFINE_PROP_BOOL("device-iotlb", X86IOMMUState, dt_supported, false),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void x86_iommu_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
     dc->realize = x86_iommu_realize;
-}
-
-static bool x86_iommu_intremap_prop_get(Object *o, Error **errp)
-{
-    X86IOMMUState *s = X86_IOMMU_DEVICE(o);
-    return s->intr_supported;
-}
-
-static void x86_iommu_intremap_prop_set(Object *o, bool value, Error **errp)
-{
-    X86IOMMUState *s = X86_IOMMU_DEVICE(o);
-    s->intr_supported = value;
-}
-
-static bool x86_iommu_device_iotlb_prop_get(Object *o, Error **errp)
-{
-    X86IOMMUState *s = X86_IOMMU_DEVICE(o);
-    return s->dt_supported;
-}
-
-static void x86_iommu_device_iotlb_prop_set(Object *o, bool value, Error **errp)
-{
-    X86IOMMUState *s = X86_IOMMU_DEVICE(o);
-    s->dt_supported = value;
-}
-
-static void x86_iommu_instance_init(Object *o)
-{
-    X86IOMMUState *s = X86_IOMMU_DEVICE(o);
-
-    /* By default, do not support IR */
-    s->intr_supported = false;
-    object_property_add_bool(o, "intremap", x86_iommu_intremap_prop_get,
-                             x86_iommu_intremap_prop_set, NULL);
-    s->dt_supported = false;
-    object_property_add_bool(o, "device-iotlb",
-                             x86_iommu_device_iotlb_prop_get,
-                             x86_iommu_device_iotlb_prop_set,
-                             NULL);
+    dc->props = x86_iommu_properties;
 }
 
 static const TypeInfo x86_iommu_info = {
     .name          = TYPE_X86_IOMMU_DEVICE,
     .parent        = TYPE_SYS_BUS_DEVICE,
-    .instance_init = x86_iommu_instance_init,
     .instance_size = sizeof(X86IOMMUState),
     .class_init    = x86_iommu_class_init,
     .class_size    = sizeof(X86IOMMUClass),
-- 
2.7.4
