Received: from eggs.gnu.org ([2001:4830:134:3::10]:35793)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHK-0007aB-Kx
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gJeHJ-0003Kh-11
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:50 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:39828)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gJeHI-0003Gm-IO
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 07:46:48 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon,  5 Nov 2018 14:45:54 +0200
Message-Id: <20181105124559.21561-14-yuval.shaia@oracle.com>
In-Reply-To: <20181105124559.21561-1-yuval.shaia@oracle.com>
References: <20181105124559.21561-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH 13/18] hw/pvrdma: Make sure PCI function 0 is
 vmxnet3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, shamir.rabinovitch@oracle.com, qemu-devel@nongnu.org

Guest driver enforces it, we should also.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
---
 hw/rdma/vmw/pvrdma.h      | 2 ++
 hw/rdma/vmw/pvrdma_main.c | 3 +++
 2 files changed, 5 insertions(+)

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
index f9784d1bd7..68efcdb812 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -576,6 +576,9 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         return;
     }
 
+    /* Break if not vmxnet3 device in slot 0 */
+    dev->func0 = VMXNET3(pci_get_function_0(pdev));
+
     memdev_root = object_resolve_path("/objects", NULL);
     if (memdev_root) {
         object_child_foreach(memdev_root, pvrdma_check_ram_shared, &ram_shared);
-- 
2.17.2
