Received: from eggs.gnu.org ([2001:4830:134:3::10]:57040)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG75-0005iT-5w
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhi.a.wang@intel.com>) id 1dFG74-0004wn-Fs
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:19 -0400
Received: from mga02.intel.com ([134.134.136.20]:12385)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <zhi.a.wang@intel.com>)
	id 1dFG74-0004sQ-6B
	for qemu-devel@nongnu.org; Mon, 29 May 2017 04:33:18 -0400
From: Zhi Wang <zhi.a.wang@intel.com>
Date: Tue, 30 May 2017 01:30:34 +0800
Message-Id: <1496079043-26694-5-git-send-email-zhi.a.wang@intel.com>
In-Reply-To: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
References: <1496079043-26694-1-git-send-email-zhi.a.wang@intel.com>
Subject: [Qemu-devel] [RFC 4/6] vfio: Refine GGTT clearing
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

Clear the whole GGTT page tables after the quirk is initialized. Obtain
the total size of GGTT and the entry size of one GGTT entry from
intel_device_info().

Suggested-by: Xiong Zhang <xiong.y.zhang@intel.com>
Signed-off-by: Zhi Wang <zhi.a.wang@intel.com>
---
 hw/vfio/pci-quirks.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 5a083c1..618c43c 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1365,7 +1365,7 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
     const struct intel_device_info *info;
     void *stolen;
     PCIDevice *lpc_bridge;
-    int i, ret;
+    int i, j, ret;
     uint64_t bdsm_size;
     uint32_t gmch;
     uint16_t cmd_orig, cmd;
@@ -1570,9 +1570,11 @@ static void vfio_probe_igd_bar4_quirk(VFIOPCIDevice *vdev, int nr)
                      vdev->vbasedev.name);
     }
 
-    for (i = 1; i < vfio_igd_gtt_max(vdev); i += 4) {
-        vfio_region_write(&vdev->bars[4].region, 0, i, 4);
-        vfio_region_write(&vdev->bars[4].region, 4, 0, 4);
+    for (i = 1; i < info->get_gtt_size(gmch); i += info->gtt_entry_size) {
+        for (j = 0; j < info->gtt_entry_size; j += 4) {
+            vfio_region_write(&vdev->bars[4].region, 0, i + j, 4);
+            vfio_region_write(&vdev->bars[4].region, 4, 0, 4);
+        }
     }
 
     if (pwrite(vdev->vbasedev.fd, &cmd_orig, sizeof(cmd_orig),
-- 
2.7.4
