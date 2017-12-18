Received: from eggs.gnu.org ([2001:4830:134:3::10]:44909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWS-0006Fy-8U
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eQwWC-0006TD-25
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:36:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50536)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eQwWB-0006RJ-Rz
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 09:35:47 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Mon, 18 Dec 2017 14:35:09 +0000
Message-Id: <20171218143530.12082-3-stefanha@redhat.com>
In-Reply-To: <20171218143530.12082-1-stefanha@redhat.com>
References: <20171218143530.12082-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 02/23] hw/block/nvme: Convert to realize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Mao Zhongyi <maozy.fnst@cn.fujitsu.com>, John Snow <jsnow@redhat.com>, Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>

Convert nvme_init() to realize and rename it to nvme_realize().

Cc: John Snow <jsnow@redhat.com>
Cc: Keith Busch <keith.busch@intel.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Mao Zhongyi <maozy.fnst@cn.fujitsu.com>
Message-id: 2882e72d795e04cbe2120f569d551aef2467ac60.1511317952.git.maozy.fnst@cn.fujitsu.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 hw/block/nvme.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/hw/block/nvme.c b/hw/block/nvme.c
index 441e21ed1f..e530ba7a30 100644
--- a/hw/block/nvme.c
+++ b/hw/block/nvme.c
@@ -920,7 +920,7 @@ static const MemoryRegionOps nvme_cmb_ops = {
     },
 };
 
-static int nvme_init(PCIDevice *pci_dev)
+static void nvme_realize(PCIDevice *pci_dev, Error **errp)
 {
     NvmeCtrl *n = NVME(pci_dev);
     NvmeIdCtrl *id = &n->id_ctrl;
@@ -931,24 +931,27 @@ static int nvme_init(PCIDevice *pci_dev)
     Error *local_err = NULL;
 
     if (!n->conf.blk) {
-        return -1;
+        error_setg(errp, "drive property not set");
+        return;
     }
 
     bs_size = blk_getlength(n->conf.blk);
     if (bs_size < 0) {
-        return -1;
+        error_setg(errp, "could not get backing file size");
+        return;
     }
 
     blkconf_serial(&n->conf, &n->serial);
     if (!n->serial) {
-        return -1;
+        error_setg(errp, "serial property not set");
+        return;
     }
     blkconf_blocksizes(&n->conf);
     blkconf_apply_backend_options(&n->conf, blk_is_read_only(n->conf.blk),
                                   false, &local_err);
     if (local_err) {
-        error_report_err(local_err);
-        return -1;
+        error_propagate(errp, local_err);
+        return;
     }
 
     pci_conf = pci_dev->config;
@@ -1046,7 +1049,6 @@ static int nvme_init(PCIDevice *pci_dev)
             cpu_to_le64(n->ns_size >>
                 id_ns->lbaf[NVME_ID_NS_FLBAS_INDEX(ns->id_ns.flbas)].ds);
     }
-    return 0;
 }
 
 static void nvme_exit(PCIDevice *pci_dev)
@@ -1081,7 +1083,7 @@ static void nvme_class_init(ObjectClass *oc, void *data)
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
 
-    pc->init = nvme_init;
+    pc->realize = nvme_realize;
     pc->exit = nvme_exit;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
     pc->vendor_id = PCI_VENDOR_ID_INTEL;
-- 
2.14.3
