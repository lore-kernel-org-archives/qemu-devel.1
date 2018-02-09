Received: from eggs.gnu.org ([2001:4830:134:3::10]:48370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekAyP-0001XS-8Z
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:52:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geert@linux-m68k.org>) id 1ekAyM-0007he-5X
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:52:25 -0500
Received: from newton.telenet-ops.be ([195.130.132.45]:48752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <geert@linux-m68k.org>)
	id 1ekAyL-0007gw-U1
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 10:52:22 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be
	[IPv6:2a02:1800:110:4::f00:19])
	by newton.telenet-ops.be (Postfix) with ESMTPS id 3zdJwl22mVzMqw1W
	for <qemu-devel@nongnu.org>; Fri,  9 Feb 2018 16:32:55 +0100 (CET)
From: Geert Uytterhoeven <geert+renesas@glider.be>
Date: Fri,  9 Feb 2018 16:17:33 +0100
Message-Id: <1518189456-2873-3-git-send-email-geert+renesas@glider.be>
In-Reply-To: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
References: <1518189456-2873-1-git-send-email-geert+renesas@glider.be>
Subject: [Qemu-devel] [PATCH/RFC 2/5] hw/arm/sysbus-fdt: Allow device
 matching with compat string
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Alex Williamson <alex.williamson@redhat.com>
Cc: Auger Eric <eric.auger@redhat.com>, Xiao Feng Ren <renxiaof@linux.vnet.ibm.com>, Arnd Bergmann <arnd@arndb.de>, Alexander Graf <agraf@suse.de>, Magnus Damm <magnus.damm@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Wolfram Sang <wsa+renesas@sang-engineering.com>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, linux-renesas-soc@vger.kernel.org, Geert Uytterhoeven <geert+renesas@glider.be>

From: Auger Eric <eric.auger@redhat.com>

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
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 hw/arm/sysbus-fdt.c | 61 +++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 48 insertions(+), 13 deletions(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index d68e3dcdbd260895..c5d4fd5604c28118 100644
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
 
@@ -413,15 +416,46 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
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
+#define VFIO_PLATFORM_BINDING(manuf, model, add_fn) \
+    {TYPE_VFIO_PLATFORM, (manuf), (model), (add_fn), vfio_platform_match}
+
 #endif /* CONFIG_LINUX */
 
-/* list of supported dynamic sysbus devices */
-static const NodeCreationPair add_fdt_node_functions[] = {
+/* Device type based matching */
+static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
+{
+    return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
+}
+
+#define TYPE_BINDING(type, add_fn) {(type), NULL, NULL, (add_fn), type_match}
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
+    TYPE_BINDING("", NULL), /* last element */
 };
 
 /* Generic Code */
@@ -440,10 +474,11 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
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
2.7.4
