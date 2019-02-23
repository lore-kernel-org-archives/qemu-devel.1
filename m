Received: from eggs.gnu.org ([209.51.188.92]:42586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY74-0006cf-GD
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gxY73-0002RB-FB
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:10 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41410)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gxY73-0002Q6-8Q
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 09:17:09 -0500
Received: by mail-wr1-x442.google.com with SMTP id n2so5281264wrw.8
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 06:17:07 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 23 Feb 2019 16:16:43 +0200
Message-Id: <20190223141644.6609-11-marcel.apfelbaum@gmail.com>
In-Reply-To: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
References: <20190223141644.6609-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 10/11] hw/pvrdma: Unregister from shutdown
 notifier when device goes down
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, kamalheib1@gmail.com, philmd@redhat.com, dgilbert@redhat.com

From: Yuval Shaia <yuval.shaia@oracle.com>

This hook was installed to close the device when VM is going down.
After the device is closed there is no need to be informed on VM
shutdown.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-Id: <20190213065357.16076-11-yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 8b379c6435..1177c0822f 100644
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
2.17.1
