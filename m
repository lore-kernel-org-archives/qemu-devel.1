Received: from eggs.gnu.org ([208.118.235.92]:47219)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf2p6-0004hR-HO
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:14:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf2p2-0004qW-KI
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:14:08 -0500
Received: from m12-14.163.com ([220.181.12.14]:43493)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@163.com>) id 1gf2p1-0004oR-T2
	for qemu-devel@nongnu.org; Thu, 03 Jan 2019 08:14:04 -0500
From: Li Qiang <liq3ea@163.com>
Date: Thu,  3 Jan 2019 05:12:51 -0800
Message-Id: <20190103131251.49271-1-liq3ea@163.com>
Subject: [Qemu-devel] [PATCH] hw: rdma: fix an off-by-one issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, Li Qiang <liq3ea@163.com>

In rdma_rm_get_backend_gid_index(), the 'sgid_idx' is used
to index the array 'dev_res->port.gid_tbl' which size is
MAX_PORT_GIDS. Current the 'sgid_idx' may be MAX_PORT_GIDS
thus cause an off-by-one issue.

Spotted by Coverity: CID 1398594

Signed-off-by: Li Qiang <liq3ea@163.com>
---
 hw/rdma/rdma_rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index f5b1295890..1bbc5f128f 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -576,7 +576,7 @@ int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
 int rdma_rm_get_backend_gid_index(RdmaDeviceResources *dev_res,
                                   RdmaBackendDev *backend_dev, int sgid_idx)
 {
-    if (unlikely(sgid_idx < 0 || sgid_idx > MAX_PORT_GIDS)) {
+    if (unlikely(sgid_idx < 0 || sgid_idx >= MAX_PORT_GIDS)) {
         pr_dbg("Got invalid sgid_idx %d\n", sgid_idx);
         return -EINVAL;
     }
-- 
2.17.1
