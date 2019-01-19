Received: from eggs.gnu.org ([209.51.188.92]:55345)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTb-0001NL-Fp
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00082m-FM
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:43 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:37957)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTZ-0007wT-2u
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: by mail-wr1-x443.google.com with SMTP id v13so17926965wrw.5
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:31 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:12 +0200
Message-Id: <20190119100315.23985-8-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 07/10] hw: rdma: fix an off-by-one issue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, liq3ea@163.com, cohuck@redhat.com, philmd@redhat.com

From: Li Qiang <liq3ea@163.com>

In rdma_rm_get_backend_gid_index(), the 'sgid_idx' is used
to index the array 'dev_res->port.gid_tbl' which size is
MAX_PORT_GIDS. Current the 'sgid_idx' may be MAX_PORT_GIDS
thus cause an off-by-one issue.

Spotted by Coverity: CID 1398594

Signed-off-by: Li Qiang <liq3ea@163.com>
Message-Id: <20190103131251.49271-1-liq3ea@163.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_rm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_rm.c b/hw/rdma/rdma_rm.c
index 8bf241e91f..268ff633a4 100644
--- a/hw/rdma/rdma_rm.c
+++ b/hw/rdma/rdma_rm.c
@@ -579,7 +579,7 @@ int rdma_rm_del_gid(RdmaDeviceResources *dev_res, RdmaBackendDev *backend_dev,
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
