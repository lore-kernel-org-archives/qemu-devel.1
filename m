Received: from eggs.gnu.org ([2001:4830:134:3::10]:41849)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwN-0006Zp-UN
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadwM-0006kw-S6
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:27 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:36111)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadwM-0006cq-Lj
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:26 -0500
Received: by mail-wm1-x341.google.com with SMTP id p6so7872160wmc.1
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:16 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:30 +0200
Message-Id: <20181222095036.29743-26-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 25/31] pvrdma: release device resources in
 case of an error
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, pjp@fedoraproject.org

From: Prasad J Pandit <pjp@fedoraproject.org>

If during pvrdma device initialisation an error occurs,
pvrdma_realize() does not release memory resources, leading
to memory leakage.

Reported-by: Li Qiang <liq3ea@163.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Message-Id: <20181212175817.815-1-ppandit@redhat.com>
Reviewed-by: Yuval Shaia <yuval.shaia@oracle.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 23dc9926e3..64de16fb52 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -573,7 +573,7 @@ static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
 
 static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 {
-    int rc;
+    int rc = 0;
     PVRDMADev *dev = PVRDMA_DEV(pdev);
     Object *memdev_root;
     bool ram_shared = false;
@@ -649,6 +649,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 
 out:
     if (rc) {
+        pvrdma_fini(pdev);
         error_append_hint(errp, "Device fail to load\n");
     }
 }
-- 
2.17.1
