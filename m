Received: from eggs.gnu.org ([2001:4830:134:3::10]:51013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6oD-0003no-Pr
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1gC6oA-000453-Cv
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:37 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51660)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1gC6oA-0003vg-3E
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 13:37:34 -0400
From: Alex Williamson <alex.williamson@redhat.com>
Date: Mon, 15 Oct 2018 11:37:16 -0600
Message-ID: <153962503644.21502.13381960215508087271.stgit@gimli.home>
In-Reply-To: <153962488126.21502.17134983449941187881.stgit@gimli.home>
References: <153962488126.21502.17134983449941187881.stgit@gimli.home>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PULL 4/6] hw/arm/sysbus-fdt: Allow device matching
 with DT compatible value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Geert Uytterhoeven <geert+renesas@glider.be>Eric Auger <eric.auger@redhat.com>Eric Auger <eric.auger@redhat.com>

From: Eric Auger <eric.auger@redhat.com>

Up to now we have relied on the device type to identify a device tree
node creation function.  Since we would like the vfio-platform device to
be instantiable with different compatible strings we introduce the
capability to specialize the node creation depending on actual
compatible value.

NodeCreationPair is renamed into BindingEntry. The struct is enhanced
with compat and match_fn() fields.  We introduce a new matching function
adapted to the vfio-platform generic device.

Soon, the AMD XGBE can be instantiated with either manner, i.e.:

    -device vfio-amd-xgbe,host=e0900000.xgmac

or using the new option line:

    -device vfio-platform,host=e0900000.xgmac

Signed-off-by: Eric Auger <eric.auger@redhat.com>
[geert: Match using compatible values in sysfs instead of user-supplied
	manufacturer/model options, reword]
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Tested-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 hw/arm/sysbus-fdt.c |   61 +++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 14 deletions(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 43d6a7bb48dd..0e24c803a1c2 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -50,11 +50,13 @@ typedef struct PlatformBusFDTData {
     PlatformBusDevice *pbus;
 } PlatformBusFDTData;
 
-/* struct that associates a device type name and a node creation function */
-typedef struct NodeCreationPair {
+/* struct that allows to match a device and create its FDT node */
+typedef struct BindingEntry {
     const char *typename;
-    int (*add_fdt_node_fn)(SysBusDevice *sbdev, void *opaque);
-} NodeCreationPair;
+    const char *compat;
+    int  (*add_fn)(SysBusDevice *sbdev, void *opaque);
+    bool (*match_fn)(SysBusDevice *sbdev, const struct BindingEntry *combo);
+} BindingEntry;
 
 /* helpers */
 
@@ -413,6 +415,27 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
+/* DT compatible matching */
+static bool vfio_platform_match(SysBusDevice *sbdev,
+                                const BindingEntry *entry)
+{
+    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
+    const char *compat;
+    unsigned int n;
+
+    for (n = vdev->num_compat, compat = vdev->compat; n > 0;
+         n--, compat += strlen(compat) + 1) {
+        if (!strcmp(entry->compat, compat)) {
+            return true;
+        }
+    }
+
+    return false;
+}
+
+#define VFIO_PLATFORM_BINDING(compat, add_fn) \
+    {TYPE_VFIO_PLATFORM, (compat), (add_fn), vfio_platform_match}
+
 #endif /* CONFIG_LINUX */
 
 static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
@@ -420,14 +443,23 @@ static int no_fdt_node(SysBusDevice *sbdev, void *opaque)
     return 0;
 }
 
-/* list of supported dynamic sysbus devices */
-static const NodeCreationPair add_fdt_node_functions[] = {
+/* Device type based matching */
+static bool type_match(SysBusDevice *sbdev, const BindingEntry *entry)
+{
+    return !strcmp(object_get_typename(OBJECT(sbdev)), entry->typename);
+}
+
+#define TYPE_BINDING(type, add_fn) {(type), NULL, (add_fn), type_match}
+
+/* list of supported dynamic sysbus bindings */
+static const BindingEntry bindings[] = {
 #ifdef CONFIG_LINUX
-    {TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node},
-    {TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node},
+    TYPE_BINDING(TYPE_VFIO_CALXEDA_XGMAC, add_calxeda_midway_xgmac_fdt_node),
+    TYPE_BINDING(TYPE_VFIO_AMD_XGBE, add_amd_xgbe_fdt_node),
+    VFIO_PLATFORM_BINDING("amd,xgbe-seattle-v1a", add_amd_xgbe_fdt_node),
 #endif
-    {TYPE_RAMFB_DEVICE, no_fdt_node},
-    {"", NULL}, /* last element */
+    TYPE_BINDING(TYPE_RAMFB_DEVICE, no_fdt_node),
+    TYPE_BINDING("", NULL), /* last element */
 };
 
 /* Generic Code */
@@ -446,10 +478,11 @@ static void add_fdt_node(SysBusDevice *sbdev, void *opaque)
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
