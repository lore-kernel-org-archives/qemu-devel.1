Received: from eggs.gnu.org ([2001:4830:134:3::10]:34962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvT-0005oo-Qt
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYxvQ-0002H9-GD
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:35 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:33732)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYxvQ-0002Fa-7D
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 13:47:32 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 20:45:30 +0200
Message-Id: <20181217184540.4571-14-yuval.shaia@oracle.com>
In-Reply-To: <20181217184540.4571-1-yuval.shaia@oracle.com>
References: <20181217184540.4571-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v8 13/23] hw/pvrdma: Make sure PCI function 0
 is vmxnet3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

Guest driver enforces it, we should also.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
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
2.17.2
