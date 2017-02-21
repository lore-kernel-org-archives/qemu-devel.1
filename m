Received: from eggs.gnu.org ([2001:4830:134:3::10]:60289)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgAL0-0006cF-Vm
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:18:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cgAKz-0003Zq-St
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 08:18:39 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Tue, 21 Feb 2017 14:18:20 +0100
Message-Id: <1487683100-16013-3-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
References: <1487683100-16013-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] hw/arm/sysbus-fdt: Allow device matching
 with compat string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, peter.maydell@linaro.org, alex.williamson@redhat.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: shankerd@codeaurora.org, okaya@codeaurora.org, vikrams@codeaurora.org, agraf@suse.de, pelcan@codeaurora.org

Up to now we have relied on the device type to identify a device tree
node creation function. Since we would like the VFIO-PLATFORM
device to be instantiable with different compatibility strings
we introduce the capability to specialize the node creation depending
on a manufacturer/model combo.

NodeCreationPair is renamed into BindingEntry. The struct is enhanced
with manufacturer, model and match_fn() fields. We introduce a new
matching function adapted to vfio-platform generic device.

>From now on, the AMD XGBE can be instantiated with either manner, ie:
-device vfio-amd-xgbe,host=e0900000.xgmac
or new option line:
-device vfio-platform,host=e0900000.xgmac,manufacturer=amd,model=xgbe-seattle-v1a

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 hw/arm/sysbus-fdt.c | 59 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index d68e3dc..a0539e1 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -58,11 +58,14 @@ typedef struct PlatformBusFDTNotifierParams {
     ARMPlatformBusFDTParams *fdt_params;
 } PlatformBusFDTNotifierParams;
 
-/* struct that associates a device type name and a node creation function */
-typedef struct NodeCreationPair {
+/* struct that allows to match a device and create its FDT node */
+typedef struct BindingEntry {
     const char *typename;
-    int (*add_fdt_node_fn)(SysBusDevice *sbdev, void *opaque);
-} NodeCreationPair;
+    const char *manufacturer;
+    const char *model;
+    int  (*add_fn)(SysBusDevice *sbdev, void *opaque);
+    bool (*match_fn)(SysBusDevice *sbdev, const struct BindingEntry *combo);
+} BindingEntry;
 
 /* helpers */
 
@@ -415,13 +418,42 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
 
 #endif /* CONFIG_LINUX */
 
-/* list of supported dynamic sysbus devices */
-static const NodeCreationPair add_fdt_node_functions[] = {
+/* Device type based matching */
+static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
+{
+    return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
+}
+
+/* manufacturer/model matching */
+static bool vfio_platform_match(SysBusDevice *sbdev,
+                                const BindingEntry *entry)
+{
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
+
+    if (strcmp(entry->model, vdev->model)) {
+        return false;
+    }
+
+    if (entry->manufacturer) {
+        if (!vdev->manufacturer) {
+            return false;
+        }
+        return !strcmp(entry->manufacturer, vdev->manufacturer);
+    }
+    return true;
+}
+
+#define TYPE_BINDING(type, add_fn) {(type), NULL, NULL, (add_fn), type_match}
+#define VFIO_PLATFORM_BINDING(manuf, model, add_fn) \
+    {TYPE_VFIO_PLATFORM, (manuf), (model), (add_fn), vfio_platform_match}
+
+/* list of supported dynamic sysbus bindings */
+static const BindingEntry bindings[] = {
 #ifdef CONFIG_LINUX
-    {TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node},
-    {TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node},
+    TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
+    TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
+    VFIO_PLATFORM_BINDING("amd", "xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
-    {"", NULL}, /* last element */
 };
 
 /* Generic Code */
@@ -440,10 +472,11 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
 {
     int i, ret;
 
-    for (i = 0; i < ARRAY_SIZE(add_fdt_node_functions); i++) {
-        if (!strcmp(object_get_typename(OBJECT(sbdev)),
-                    add_fdt_node_functions[i].typename)) {
-            ret = add_fdt_node_functions[i].add_fdt_node_fn(sbdev, opaque);
+    for (i = 0; i < ARRAY_SIZE(bindings); i++) {
+        const BindingEntry *iter = &bindings[i];
+
+        if (iter->match_fn(sbdev, iter)) {
+            ret = iter->add_fn(sbdev, opaque);
             assert(!ret);
             return;
         }
-- 
2.5.5
