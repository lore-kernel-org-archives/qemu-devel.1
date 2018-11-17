Received: from eggs.gnu.org ([2001:4830:134:3::10]:49220)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gNyLZ-0006dp-GG
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:01:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peng.hao2@zte.com.cn>) id 1gNyLY-0003z1-R7
	for qemu-devel@nongnu.org; Sat, 17 Nov 2018 06:01:05 -0500
From: Peng Hao <peng.hao2@zte.com.cn>
Date: Sun, 18 Nov 2018 03:22:46 +0800
Message-Id: <1542482566-91660-1-git-send-email-peng.hao2@zte.com.cn>
Subject: [Qemu-devel] [PATCH] hw/arm/sysbus-fdt: fix assert in match function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Peng Hao <peng.hao2@zte.com.cn>

In match function it should not call OBJECK_CHECK. When there is
a mismatch, we should continue to match rather than assert().

Signed-off-by: Peng Hao <peng.hao2@zte.com.cn>
---
 hw/arm/sysbus-fdt.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/arm/sysbus-fdt.c b/hw/arm/sysbus-fdt.c
index 0e24c80..41b962d 100644
--- a/hw/arm/sysbus-fdt.c
+++ b/hw/arm/sysbus-fdt.c
@@ -419,10 +419,15 @@ static int add_amd_xgbe_fdt_node(SysBusDevice *sbdev, void *opaque)
 static bool vfio_platform_match(SysBusDevice *sbdev,
                                 const BindingEntry *entry)
 {
-    VFIOPlatformDevice *vdev = VFIO_PLATFORM_DEVICE(sbdev);
+    VFIOPlatformDevice *vdev;
     const char *compat;
     unsigned int n;
 
+    vdev = (VFIOPlatformDevice *) object_dynamic_cast(OBJECT(sbdev),
+                                                TYPE_VFIO_PLATFORM);
+    if (!vdev)
+        return false;
+
     for (n = vdev->num_compat, compat = vdev->compat; n > 0;
          n--, compat += strlen(compat) + 1) {
         if (!strcmp(entry->compat, compat)) {
-- 
1.8.3.1
