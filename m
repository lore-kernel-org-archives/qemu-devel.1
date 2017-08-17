Received: from eggs.gnu.org ([2001:4830:134:3::10]:45648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diPbZ-0004aj-Cl
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:33:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1diPbW-0006eX-7a
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 14:33:17 -0400
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 17 Aug 2017 20:33:10 +0200
Message-Id: <1502994790-21856-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH] hw/ppc/spapr: Fix segfault when instantiating
 a 'pc-dimm' without 'memdev'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-ppc@nongnu.org

QEMU currently crashes when trying to use a 'pc-dimm' on the pseries
machine without specifying its 'memdev' property. Let's add a sanity
check to the pre_plug handler to fix this issue.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/ppc/spapr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index f7a1972..22d400a 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2808,10 +2808,17 @@ static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceState *dev,
 {
     PCDIMMDevice *dimm = PC_DIMM(dev);
     PCDIMMDeviceClass *ddc = PC_DIMM_GET_CLASS(dimm);
-    MemoryRegion *mr = ddc->get_memory_region(dimm);
-    uint64_t size = memory_region_size(mr);
+    MemoryRegion *mr;
+    uint64_t size;
     char *mem_dev;
 
+    if (!dimm->hostmem) {
+        error_setg(errp, "'" PC_DIMM_MEMDEV_PROP "' property must be set");
+        return;
+    }
+
+    mr = ddc->get_memory_region(dimm);
+    size = memory_region_size(mr);
     if (size % SPAPR_MEMORY_BLOCK_SIZE) {
         error_setg(errp, "Hotplugged memory size must be a multiple of "
                       "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
-- 
1.8.3.1
