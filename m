Received: from eggs.gnu.org ([209.51.188.92]:59594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gyzrq-0008Fn-Fq
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:07:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gyzrn-0003vo-Fi
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:07:24 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:43740)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gyzrl-0003mY-BS
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 09:07:21 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Wed, 27 Feb 2019 16:06:29 +0200
Message-Id: <20190227140629.1569-10-yuval.shaia@oracle.com>
In-Reply-To: <20190227140629.1569-1-yuval.shaia@oracle.com>
References: <20190227140629.1569-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v3 9/9] hw/pvrdma: Unregister from shutdown
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
index 7727b8ddda..a9efcbfe70 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -359,6 +359,8 @@ static void pvrdma_fini(PCIDevice *pdev)
 {
     PVRDMADev *dev = PVRDMA_DEV(pdev);
 
+    notifier_remove(&dev->shutdown_notifier);
+
     pvrdma_qp_ops_fini();
 
     rdma_backend_stop(&dev->backend_dev);
-- 
2.17.2
