Received: from eggs.gnu.org ([2001:4830:134:3::10]:53342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqg-0002Cd-Ay
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fEIqd-0008KW-Dw
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:58 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33076)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1fEIqd-0008KD-6Q
	for qemu-devel@nongnu.org; Thu, 03 May 2018 14:20:55 -0400
Received: by mail-wm0-x243.google.com with SMTP id x12-v6so4002739wmc.0
	for <qemu-devel@nongnu.org>; Thu, 03 May 2018 11:20:55 -0700 (PDT)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Thu,  3 May 2018 21:21:24 +0300
Message-Id: <20180503182125.20310-8-marcel.apfelbaum@gmail.com>
In-Reply-To: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
References: <20180503182125.20310-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PULL 7/8] hw/rdma: Fix possible out of bounds access
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
Cc: marcel.apfelbaum@gmail.com, yuval.shaia@oracle.com, peter.maydell@linaro.org, f4bug@amsat.org

Make sure the backend GID index is less then port's
gid table length.

Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Message-Id: <20180430200223.4119-8-marcel.apfelbaum@gmail.com>
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
