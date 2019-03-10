Received: from eggs.gnu.org ([209.51.188.92]:47663)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6V-0000rW-Cd
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h2u6U-0007bN-GY
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44044)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h2u6S-0007Ya-RT
	for qemu-devel@nongnu.org; Sun, 10 Mar 2019 04:46:41 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Sun, 10 Mar 2019 10:46:10 +0200
Message-Id: <20190310084610.23077-11-yuval.shaia@oracle.com>
In-Reply-To: <20190310084610.23077-1-yuval.shaia@oracle.com>
References: <20190310084610.23077-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v5 10/10] hw/pvrdma: Unregister from shutdown
 notifier when device goes down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, armbru@redhat.com, qemu-devel@nongnu.org

This hook was installed to close the device when VM is going down.
After the device is closed there is no need to be informed on VM
shutdown.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 84df4294eb..1f7a95d596 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -311,6 +311,8 @@ static void pvrdma_fini(PCIDevice *pdev)
 {
     PVRDMADev *dev = PVRDMA_DEV(pdev);
 
+    notifier_remove(&dev->shutdown_notifier);
+
     pvrdma_qp_ops_fini();
 
     rdma_backend_stop(&dev->backend_dev);
-- 
2.17.2
