Received: from eggs.gnu.org ([2001:4830:134:3::10]:41217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeT-0005we-2J
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeP-00072X-A8
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:32 -0500
Received: from [59.151.112.132] (port=15022 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <caoj.fnst@cn.fujitsu.com>) id 1cNFeO-0006yx-Tg
	for qemu-devel@nongnu.org; Sat, 31 Dec 2016 04:08:29 -0500
From: Cao jin <caoj.fnst@cn.fujitsu.com>
Date: Sat, 31 Dec 2016 17:13:07 +0800
Message-ID: <1483175588-17006-4-git-send-email-caoj.fnst@cn.fujitsu.com>
In-Reply-To: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
References: <1483175588-17006-1-git-send-email-caoj.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH RFC v11 3/4] vfio-pci: pass the aer error to
 guest
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: alex.williamson@redhat.com, mst@redhat.com, izumi.taku@jp.fujitsu.com, Chen Fan <chen.fan.fnst@cn.fujitsu.com>, Dou Liyang <douly.fnst@cn.fujitsu.com>

From: Chen Fan <chen.fan.fnst@cn.fujitsu.com>

When physical device has uncorrectable error hanppened, the vfio_pci
driver will signal the uncorrectable error status register value to
corresponding QEMU's vfio-pci device via the eventfd registered by this
device, then, the vfio-pci's error eventfd handler will be invoked in
event loop.

Construct and pass the aer message to root port, root port will trigger an
interrupt to signal guest, then, the guest driver will do the recovery.

Note: Now only support non-fatal error's recovery, fatal error will
still result in vm stop.

Signed-off-by: Chen Fan <chen.fan.fnst@cn.fujitsu.com>
Signed-off-by: Dou Liyang <douly.fnst@cn.fujitsu.com>
Signed-off-by: Cao jin <caoj.fnst@cn.fujitsu.com>
---
 hw/vfio/pci.c | 50 ++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 42 insertions(+), 8 deletions(-)

diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
index 76a8ac3..9861f72 100644
--- a/hw/vfio/pci.c
+++ b/hw/vfio/pci.c
@@ -2470,21 +2470,55 @@ static void vfio_put_device(VFIOPCIDevice *vdev)
 static void vfio_err_notifier_handler(void *opaque)
 {
     VFIOPCIDevice *vdev = opaque;
+    PCIDevice *dev = &vdev->pdev;
+    PCIEAERMsg msg = {
+        .severity = 0,
+        .source_id = (pci_bus_num(dev->bus) << 8) | dev->devfn,
+    };
+    int len;
+    uint64_t uncor_status;
+
+    /* Read uncorrectable error status from driver */
+    len = read(vdev->err_notifier.rfd, &uncor_status, sizeof(uncor_status));
+    if (len != sizeof(uncor_status)) {
+        error_report("vfio-pci: uncor error status reading returns"
+                     " invalid number of bytes: %d", len);
+        return; //Or goto stop?
+    }
+
+    if (!(vdev->features & VFIO_FEATURE_ENABLE_AER)) {
+        goto stop;
+    }
+
+    /* Populate the aer msg and send it to root port */
+    if (dev->exp.aer_cap) {
+        uint8_t *aer_cap = dev->config + dev->exp.aer_cap;
+        bool isfatal = uncor_status &
+                       pci_get_long(aer_cap + PCI_ERR_UNCOR_SEVER);
+
+	if (isfatal) {
+	    goto stop;
+	}
+
+        msg.severity = isfatal ? PCI_ERR_ROOT_CMD_FATAL_EN :
+                                 PCI_ERR_ROOT_CMD_NONFATAL_EN;
 
-    if (!event_notifier_test_and_clear(&vdev->err_notifier)) {
+        error_report("vfio-pci device %d sending AER to root port. uncor"
+                     " status = 0x%"PRIx64, dev->devfn, uncor_status);
+        pcie_aer_msg(dev, &msg);
         return;
     }
 
+stop:
     /*
-     * TBD. Retrieve the error details and decide what action
-     * needs to be taken. One of the actions could be to pass
-     * the error to the guest and have the guest driver recover
-     * from the error. This requires that PCIe capabilities be
-     * exposed to the guest. For now, we just terminate the
-     * guest to contain the error.
+     * Terminate the guest in case of
+     * 1. AER capability is not exposed to guest.
+     * 2. AER capability is exposed, but error is fatal, only non-fatal
+     * error is handled now.
      */
 
-    error_report("%s(%s) Unrecoverable error detected. Please collect any data possible and then kill the guest", __func__, vdev->vbasedev.name);
+    error_report("%s(%s) fatal error detected. Please collect any data"
+            " possible and then kill the guest", __func__, vdev->vbasedev.name);
 
     vm_stop(RUN_STATE_INTERNAL_ERROR);
 }
-- 
1.8.3.1
