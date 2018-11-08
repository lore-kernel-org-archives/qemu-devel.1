Received: from eggs.gnu.org ([2001:4830:134:3::10]:59401)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmsN-0005Qz-GC
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gKmsJ-0000r7-01
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:47 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:54652)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gKms6-0000kY-Iy
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 11:09:35 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Thu,  8 Nov 2018 18:08:09 +0200
Message-Id: <20181108160818.5485-14-yuval.shaia@oracle.com>
In-Reply-To: <20181108160818.5485-1-yuval.shaia@oracle.com>
References: <20181108160818.5485-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v2 13/22] hw/pvrdma: Make sure PCI function 0
 is vmxnet3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com

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
index ac8c092db0..fa6468d221 100644
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
