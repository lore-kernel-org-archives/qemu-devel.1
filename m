Received: from eggs.gnu.org ([2001:4830:134:3::10]:57101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG7F-0005pL-M6
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG7E-00052P-M0
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:12385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dFG7E-0004sQ-DI
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:28 -0400
From: Zhi Wang <zhi.a.wang@intel.com>
Date: Tue, 30 May 2017 01:30:39 +0800
Message-Id: <1496079043-26694-10-git-send-email-zhi.a.wang@intel.com>
In-Reply-To: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
Subject: [Qemu-devel] [RFC 2/6] vfio: Setup IGD quirks earlier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: chuanxiao.dong@intel.com, daniel.vetter@ffwll.ch, xiong.y.zhang@intel.com, joonas.lahtinen@linux.intel.com, zhiyuan.lv@intel.com, zhenyuw@linux.intel.com, kevin.tian@intel.com, Zhi Wang <zhi.a.wang@intel.com>

Initialize IGD quirks a bit earlier since we're going to support IGD
stolen memory under both primary mode (legacy mode) and secondary mode
and we need one extra memory region from IGD quirks.

Suggested-by: Xiong Zhang <xiong.y.zhang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 hw/vfio/pci-quirks.c | 30 +++++++++++++++++-------------
 1 file changed, 17 insertions(+), 13 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 71360ef..e0a0c13 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1395,6 +1395,14 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
 
     gen = info->gen;
 
+    /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
+    quirk = g_malloc0(sizeof(*quirk));
+    igd = quirk->data = g_malloc0(sizeof(*igd));
+    igd->vdev = vdev;
+    igd->index = ~0;
+    igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
+    igd->bdsm &= ~((1 << 20) - 1); /* 1MB aligned */
+
     /*
      * We need to create an LPC/ISA bridge at PCI bus address 00:1f.0 that we
      * can stuff host values into, so if there's already one there and it's not
@@ -1502,23 +1510,19 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
         goto out;
     }
 
-    /* Setup our quirk to munge GTT addresses to the VM allocated buffer */
-    quirk = g_malloc0(sizeof(*quirk));
-    quirk->mem = g_new0(MemoryRegion, 2);
-    quirk->nr_mem = 2;
-    igd = quirk->data = g_malloc0(sizeof(*igd));
-    igd->vdev = vdev;
-    igd->index = ~0;
-    igd->bdsm = vfio_pci_read_config(&vdev->pdev, IGD_BDSM, 4);
-    igd->bdsm &= ~((1 << 20) - 1); /* 1MB aligned */
+    quirk->mem = g_renew(MemoryRegion, quirk->mem, 2);
+
+    memory_region_init_io(&quirk->mem[quirk->nr_mem++], OBJECT(vdev),
+                          &vfio_igd_index_quirk, igd, "vfio-igd-index-quirk",
+                          4);
 
-    memory_region_init_io(&quirk->mem[0], OBJECT(vdev), &vfio_igd_index_quirk,
-                          igd, "vfio-igd-index-quirk", 4);
     memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
                                         0, &quirk->mem[0], 1);
 
-    memory_region_init_io(&quirk->mem[1], OBJECT(vdev), &vfio_igd_data_quirk,
-                          igd, "vfio-igd-data-quirk", 4);
+    memory_region_init_io(&quirk->mem[quirk->nr_mem++], OBJECT(vdev),
+                          &vfio_igd_data_quirk, igd, "vfio-igd-data-quirk",
+                          4);
+
     memory_region_add_subregion_overlap(vdev->bars[nr].region.mem,
                                         4, &quirk->mem[1], 1);
 
-- 
2.7.4
