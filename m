Received: from eggs.gnu.org ([2001:4830:134:3::10]:55723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangweiping@didichuxing.com>) id 1fXd2b-0001Ht-7f
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 21:45:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangweiping@didichuxing.com>) id 1fXd2W-0001jI-NB
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 21:45:09 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:22630
	helo=bsf01.didichuxing.com) by eggs.gnu.org with smtp (Exim 4.71)
	(envelope-from <zhangweiping@didichuxing.com>) id 1fXd2W-0001ha-8X
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 21:45:04 -0400
Date: Tue, 26 Jun 2018 09:44:56 +0800
From: Weiping Zhang <zhangweiping@didichuxing.com>
Message-ID: <20180626014452.GA1858@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
Subject: [Qemu-devel] [Qemu-block][RFC PATCH] hw/block/nvme: add optional
 parameter num_queues for nvme device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: keith.busch@intel.com
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org

Add an optional paramter num_queues for device, and set it
to 64 by default.

Signed-off-by: Weiping Zhang <zhangweiping@didichuxing.com>
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
2.14.1
