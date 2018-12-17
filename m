Received: from eggs.gnu.org ([2001:4830:134:3::10]:55256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYo0L-0002jd-KX
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yuval.shaia@oracle.com>) id 1gYo0H-0007zt-Mz
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:57 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:51638)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yuval.shaia@oracle.com>)
	id 1gYo0F-0007yw-RW
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 03:11:52 -0500
From: Yuval Shaia <yuval.shaia@oracle.com>
Date: Mon, 17 Dec 2018 10:10:44 +0200
Message-Id: <20181217081047.2039-21-yuval.shaia@oracle.com>
In-Reply-To: <20181217081047.2039-1-yuval.shaia@oracle.com>
References: <20181217081047.2039-1-yuval.shaia@oracle.com>
Subject: [Qemu-devel] [PATCH v7 20/23] hw/pvrdma: Clean device's resource
 when system is shutdown
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yuval.shaia@oracle.com, marcel.apfelbaum@gmail.com, dmitry.fleytman@gmail.com, jasowang@redhat.com, eblake@redhat.com, armbru@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, shamir.rabinovitch@oracle.com, cohuck@redhat.com

In order to clean some external resources such as GIDs, QPs etc,
register to receive notification when VM is shutdown.

Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
Reviewed-by: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
---
 hw/rdma/vmw/pvrdma.h      |  2 ++
 hw/rdma/vmw/pvrdma_main.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+)

diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
index 10a3c4fb7c..ffae36986e 100644
--- a/hw/rdma/vmw/pvrdma.h
+++ b/hw/rdma/vmw/pvrdma.h
@@ -17,6 +17,7 @@
 #define PVRDMA_PVRDMA_H
 
 #include "qemu/units.h"
+#include "qemu/notify.h"
 #include "hw/pci/pci.h"
 #include "hw/pci/msix.h"
 #include "chardev/char-fe.h"
@@ -87,6 +88,7 @@ typedef struct PVRDMADev {
     RdmaDeviceResources rdma_dev_res;
     CharBackend mad_chr;
     VMXNET3State *func0;
+    Notifier shutdown_notifier;
 } PVRDMADev;
 #define PVRDMA_DEV(dev) OBJECT_CHECK(PVRDMADev, (dev), PVRDMA_HW_NAME)
 
diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
index 150404dfa6..23dc9926e3 100644
--- a/hw/rdma/vmw/pvrdma_main.c
+++ b/hw/rdma/vmw/pvrdma_main.c
@@ -24,6 +24,7 @@
 #include "hw/qdev-properties.h"
 #include "cpu.h"
 #include "trace.h"
+#include "sysemu/sysemu.h"
 
 #include "../rdma_rm.h"
 #include "../rdma_backend.h"
@@ -334,6 +335,9 @@ static void pvrdma_fini(PCIDevice *pdev)
     if (msix_enabled(pdev)) {
         uninit_msix(pdev, RDMA_MAX_INTRS);
     }
+
+    pr_dbg("Device %s %x.%x is down\n", pdev->name, PCI_SLOT(pdev->devfn),
+           PCI_FUNC(pdev->devfn));
 }
 
 static void pvrdma_stop(PVRDMADev *dev)
@@ -559,6 +563,14 @@ static int pvrdma_check_ram_shared(Object *obj, void *opaque)
     return 0;
 }
 
+static void pvrdma_shutdown_notifier(Notifier *n, void *opaque)
+{
+    PVRDMADev *dev = container_of(n, PVRDMADev, shutdown_notifier);
+    PCIDevice *pci_dev = PCI_DEVICE(dev);
+
+    pvrdma_fini(pci_dev);
+}
+
 static void pvrdma_realize(PCIDevice *pdev, Error **errp)
 {
     int rc;
@@ -632,6 +644,9 @@ static void pvrdma_realize(PCIDevice *pdev, Error **errp)
         goto out;
     }
 
+    dev->shutdown_notifier.notify = pvrdma_shutdown_notifier;
+    qemu_register_shutdown_notifier(&dev->shutdown_notifier);
+
 out:
     if (rc) {
         error_append_hint(errp, "Device fail to load\n");
-- 
2.17.2
