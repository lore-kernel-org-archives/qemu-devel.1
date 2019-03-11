Received: from eggs.gnu.org ([209.51.188.92]:36354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBR-0007Xp-Ut
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1h3IBQ-0000vF-G1
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:25 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1h3IBQ-0000u5-47
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:29:24 -0400
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 11 Mar 2019 03:29:14 -0700
Message-Id: <1552300155-25216-11-git-send-email-yuval.shaia@oracle.com>
In-Reply-To: <1552300155-25216-1-git-send-email-yuval.shaia@oracle.com>
References: <1552300155-25216-1-git-send-email-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v6 10/11] hw/pvrdma: Unregister from shutdown
 notifier when device goes down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, qemu-devel@nongnu.org, armbru@redhat.com

This hook was installed to close the device when VM is going down.
After the device is closed there is no need to be informed on VM
shutdown.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index a4afced..49bfbd6 100644
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
1.8.3.1
