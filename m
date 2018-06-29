Received: from eggs.gnu.org ([2001:4830:134:3::10]:49427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6M-0003oY-Mi
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1fYu6J-0003iL-IT
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 10:10:18 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri, 29 Jun 2018 16:09:35 +0200
Message-Id: <20180629140959.6690-6-kwolf@redhat.com>
In-Reply-To: <20180629140959.6690-1-kwolf@redhat.com>
References: <20180629140959.6690-1-kwolf@redhat.com>
Subject: [Qemu-devel] [PULL 05/29] hw/block/nvme: add optional parameter
 num_queues for nvme device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Weiping Zhang <zhangweiping@didichuxing.com>

Add an optional paramter num_queues for device, and set it
to 64 by default.

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
Acked-by: Keith Busch <keith.busch@intel.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 hw/block/nvme.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index d5bf95b79b..156ecf3c41 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -18,7 +18,8 @@
  * Usage: add options:
  *      -drive file=<file>,if=none,id=<drive_id>
  *      -device nvme,drive=<drive_id>,serial=<serial>,id=<id[optional]>, \
- *              cmb_size_mb=<cmb_size_mb[optional]>
+ *              cmb_size_mb=<cmb_size_mb[optional]>, \
+ *              num_queues=<N[optional]>
  *
  * Note cmb_size_mb denotes size of CMB in MB. CMB is assumed to be at
  * offset 0 in BAR2 and supports only WDS, RDS and SQS for now.
@@ -1232,7 +1233,6 @@ static void nvme_realize(PCIDevice *pci_dev, Error **errp)
     pcie_endpoint_cap_init(&n->parent_obj, 0x80);
 
     n->num_namespaces = 1;
-    n->num_queues = 64;
     n->reg_size = pow2ceil(0x1004 + 2 * (n->num_queues + 1) * 4);
     n->ns_size = bs_size / (uint64_t)n->num_namespaces;
 
@@ -1341,6 +1341,7 @@ static Property nvme_props[] = {
     DEFINE_BLOCK_PROPERTIES(NvmeCtrl, conf),
     DEFINE_PROP_STRING("serial", NvmeCtrl, serial),
     DEFINE_PROP_UINT32("cmb_size_mb", NvmeCtrl, cmb_size_mb, 0),
+    DEFINE_PROP_UINT32("num_queues", NvmeCtrl, num_queues, 64),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.13.6
