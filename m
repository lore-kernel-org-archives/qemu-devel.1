Received: from eggs.gnu.org ([2001:4830:134:3::10]:41674)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvy-0006G4-9a
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1gadvx-0006Rq-GM
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:02 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:40012)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcel.apfelbaum@gmail.com>)
	id 1gadvx-0006RT-Ad
	for qemu-devel@nongnu.org; Sat, 22 Dec 2018 04:51:01 -0500
Received: by mail-wm1-x342.google.com with SMTP id f188so7860807wmf.5
	for <qemu-devel@nongnu.org>; Sat, 22 Dec 2018 01:51:01 -0800 (PST)
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Date: Sat, 22 Dec 2018 11:50:19 +0200
Message-Id: <20181222095036.29743-15-marcel.apfelbaum@gmail.com>
In-Reply-To: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
References: <20181222095036.29743-1-marcel.apfelbaum@gmail.com>
Subject: [Qemu-devel] [PATCH PULL 14/31] hw/pvrdma: Make sure PCI function 0
 is vmxnet3
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

From: Yuval Shaia <yuval.shaia@oracle.com>

Guest driver enforces it, we should also.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Signed-off-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma.h      |  2 ++
 hw/rdma/vmw/pvrdma_main.c | 12 ++++++++++++
 2 files changed, 14 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index b019cb843a..10a3c4fb7c 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -20,6 +20,7 @@
 #include "hw/pci/pci.h"
 #include "hw/pci/msix.h"
 #include "chardev/char-fe.h"
+#include "hw/net/vmxnet3_defs.h"
 
 #include "../rdma_backend_defs.h"
 #include "../rdma_rm_defs.h"
@@ -85,6 +86,7 @@ typedef struct PVRDMADev {
     RdmaBackendDev backend_dev;
     RdmaDeviceResources rdma_dev_res;
     CharBackend mad_chr;
+    VMXNET3State *func0;
 } PVRDMADev;
 #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index ac8c092db0..b35b5dc5f0 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -565,6 +565,7 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
     PVRDMADev *dev = PVRDMA_DEV(pdev);
     Object *memdev_root;
     bool ram_shared = false;
+    PCIDevice *func0;
 
     init_pr_dbg();
 
@@ -576,6 +577,17 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    func0 = pci_get_function_0(pdev);
+    /* Break if not vmxnet3 device in slot 0 */
+    if (strcmp(object_get_typename(&func0->qdev.parent_obj), TYPE_VMXNET3)) {
+        pr_dbg("func0 type is %s\n",
+               object_get_typename(&func0->qdev.parent_obj));
+        error_setg(errp, "Device on %x.0 must be %s", PCI_SLOT(pdev->devfn),
+                   TYPE_VMXNET3);
+        return;
+    }
+    dev->func0 = VMXNET3(func0);
+
     memdev_root = object_resolve_path("/objects", NULL);
     if (memdev_root) {
         object_child_foreach(memdev_root, pvrdma_check_ram_shared, &ram_shared);
-- 
2.17.1
