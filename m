Received: from eggs.gnu.org ([2001:4830:134:3::10]:55309)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey8F-0001SH-3v
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1fey8C-0007DH-11
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:19 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1fey8B-0007Cu-Nk
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 03:41:15 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 16 Jul 2018 10:40:38 +0300
Message-Id: <20180716074038.3364-14-yuval.shaia@oracle.com>
In-Reply-To: <20180716074038.3364-1-yuval.shaia@oracle.com>
References: <20180716074038.3364-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel]  [PATCH 13/13] hw/rdma: Save pci dev in backend_dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com

This field is not initialized - fix it.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/rdma_backend.c    | 6 +++++-
 hw/rdma/rdma_backend.h    | 2 +-
 hw/rdma/vmw/pvrdma_main.c | 2 +-
 3 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/hw/rdma/rdma_backend.c b/hw/rdma/rdma_backend.c
index d29acc505b..d7a4bbd91f 100644
--- a/hw/rdma/rdma_backend.c
+++ b/hw/rdma/rdma_backend.c
@@ -744,7 +744,7 @@ static int init_device_caps(RdmaBackendDev *backend_dev,
     return 0;
 }
 
-int rdma_backend_init(RdmaBackendDev *backend_dev,
+int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
                       RdmaDeviceResources *rdma_dev_res,
                       const char *backend_device_name, uint8_t port_num,
                       uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
@@ -756,6 +756,10 @@ int rdma_backend_init(RdmaBackendDev *backend_dev,
     struct ibv_device **dev_list;
     struct ibv_port_attr port_attr;
 
+    memset(backend_dev, 0, sizeof(*backend_dev));
+
+    backend_dev->dev = pdev;
+
     backend_dev->backend_gid_idx = backend_gid_idx;
     backend_dev->port_num = port_num;
     backend_dev->rdma_dev_res = rdma_dev_res;
diff --git a/hw/rdma/rdma_backend.h b/hw/rdma/rdma_backend.h
index 3049a73962..86e8fe8ab6 100644
--- a/hw/rdma/rdma_backend.h
+++ b/hw/rdma/rdma_backend.h
@@ -46,7 +46,7 @@ static inline uint32_t rdma_backend_mr_rkey(const RdmaBackendMR *mr)
     return mr->ibmr ? mr->ibmr->rkey : 0;
 }
 
-int rdma_backend_init(RdmaBackendDev *backend_dev,
+int rdma_backend_init(RdmaBackendDev *backend_dev, PCIDevice *pdev,
                       RdmaDeviceResources *rdma_dev_res,
                       const char *backend_device_name, uint8_t port_num,
                       uint8_t backend_gid_idx, struct ibv_device_attr *dev_attr,
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 3d448bffc4..ca5fa8d981 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -611,7 +611,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         goto out;
     }
 
-    rc = rdma_backend_init(&dev->backend_dev, &dev->rdma_dev_res,
+    rc = rdma_backend_init(&dev->backend_dev, pdev, &dev->rdma_dev_res,
                            dev->backend_device_name, dev->backend_port_num,
                            dev->backend_gid_idx, &dev->dev_attr, errp);
     if (rc) {
-- 
2.17.1
