Received: from eggs.gnu.org ([2001:4830:134:3::10]:48808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzv-0003q4-67
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fDEzs-0005w0-2j
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:07 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:46807)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fDEzr-0005vd-Sn
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 16:02:04 -0400
Received: by mail-wr0-x242.google.com with SMTP id o2-v6so6222091wrj.13
	for <qemu-devel@nongnu.org>; Mon, 30 Apr 2018 13:02:03 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Mon, 30 Apr 2018 23:02:23 +0300
Message-Id: <20180430200223.4119-8-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
References: <20180430200223.4119-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH 7/7] hw/rdma: Fix possible out of bounds access
 to port GID index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org

Make sure the backend GID index is less then port's
git table length.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index 5c7b3d8949..e9ced6f9ef 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -774,7 +774,7 @@ int rdma_backend_init(RdmaBackendDev *backend_dev,
         goto out_destroy_comm_channel;
     }
 
-    if (backend_dev->backend_gid_idx > port_attr.gid_tbl_len) {
+    if (backend_dev->backend_gid_idx >= port_attr.gid_tbl_len) {
         error_setg(errp, "Invalid backend_gid_idx, should be less than %d",
                    port_attr.gid_tbl_len);
         goto out_destroy_comm_channel;
-- 
2.14.3
