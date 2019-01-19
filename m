Received: from eggs.gnu.org ([209.51.188.92]:55303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTa-0001Mg-Pt
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gknTZ-00083Q-Nt
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:42 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33739)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gknTZ-0007tZ-Ge
	for qemu-devel@nongnu.org; Sat, 19 Jan 2019 05:03:41 -0500
Received: by mail-wr1-x444.google.com with SMTP id c14so17960877wrr.0
	for <qemu-devel@nongnu.org>; Sat, 19 Jan 2019 02:03:26 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 19 Jan 2019 12:03:09 +0200
Message-Id: <20190119100315.23985-5-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
References: <20190119100315.23985-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 04/10] hw/pvrdma: Post CQE when receive
 invalid gid index
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

From: Yuval Shaia <yuval.shaia@oracle.com>

This error should propagate back to guest.

Spotted by Coverity: CID 1398595

Fixes: 2b05705dc8

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/rdma_backend.h      | 1 +
 hw/rdma/vmw/pvrdma_qp_ops.c | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index a9ba40ae48..5114c90e67 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -32,6 +32,7 @@
 #define VENDOR_ERR_INVLKEY          0x207
 #define VENDOR_ERR_MR_SMALL         0x208
 #define VENDOR_ERR_INV_MAD_BUFF     0x209
+#define VENDOR_ERR_INV_GID_IDX      0x210
 
 /* Add definition for QP0 and QP1 as there is no userspace enums for them */
 enum ibv_special_qp_type {
diff --git a/hw/rdma/vmw/pvrdma_qp_ops.c b/hw/rdma/vmw/pvrdma_qp_ops.c
index 465bee8641..0565eba981 100644
--- a/hw/rdma/vmw/pvrdma_qp_ops.c
+++ b/hw/rdma/vmw/pvrdma_qp_ops.c
@@ -178,7 +178,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         sgid = rdma_rm_get_gid(&dev->rdma_dev_res, wqe->hdr.wr.ud.av.gid_index);
         if (!sgid) {
             pr_dbg("Fail to get gid for idx %d\n", wqe->hdr.wr.ud.av.gid_index);
-            return -EIO;
+            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
+            continue;
         }
         pr_dbg("sgid_id=%d, sgid=0x%llx\n", wqe->hdr.wr.ud.av.gid_index,
                sgid->global.interface_id);
@@ -189,7 +190,8 @@ int pvrdma_qp_send(PVRDMADev *dev, uint32_t qp_handle)
         if (sgid_idx <= 0) {
             pr_dbg("Fail to get bk sgid_idx for sgid_idx %d\n",
                    wqe->hdr.wr.ud.av.gid_index);
-            return -EIO;
+            complete_with_error(VENDOR_ERR_INV_GID_IDX, comp_ctx);
+            continue;
         }
 
         if (wqe->hdr.num_sge > dev->dev_attr.max_sge) {
-- 
2.17.1
