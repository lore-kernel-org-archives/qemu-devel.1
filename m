Received: from eggs.gnu.org ([2001:4830:134:3::10]:39590)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYf-0000W9-SN
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYe-0002tI-Tv
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42990)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cUPYe-0002t7-OS
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:08 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jan 2017 11:07:49 +0800
Message-Id: <1484881670-24237-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
References: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 5/6] hw/pci: use-after-free in
 pci_nic_init_nofail when nic device fails to initialize
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Alex Kompel <barbos@gmail.com>, Jason Wang <jasowang@redhat.com>

From: Alex Kompel <barbos@gmail.com>

object_property_set_bool(OBJECT(dev), true, "realized", &err) in
pci_nic_init_nofail may release the object if device fails to
initialize which leads to use-after-free in error handling block.
qdev_init_nofail does the same thing while holding the reference.

(gdb) run -net nic
qemu-system-x86_64: failed to find romfile "efi-e1000.rom"

Program received signal SIGSEGV, Segmentation fault.
object_unparent (obj=0x7fffe96a0010) at qom/object.c:440
440     in qom/object.c
(gdb) bt
<nd_table>, rootbus=0x5555567ed990, default_model=<optimized out>,
default_devaddr=<optimized out>) at hw/pci/pci.c:1812
pci_bus=0x5555567ed990) at hw/i386/pc.c:1634
pci_type=0x555555c1a523 "i440FX", host_type=0x555555ba564e
"i440FX-pcihost") at hw/i386/pc_piix.c:241
out>, envp=<optimized out>) at vl.c:4481

Signed-off-by: Alex Kompel <barbos@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/pci/pci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 637d545..fe9acec 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -1779,7 +1779,6 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
                                const char *default_devaddr)
 {
     const char *devaddr = nd->devaddr ? nd->devaddr : default_devaddr;
-    Error *err = NULL;
     PCIBus *bus;
     PCIDevice *pci_dev;
     DeviceState *dev;
@@ -1805,13 +1804,7 @@ PCIDevice *pci_nic_init_nofail(NICInfo *nd, PCIBus *rootbus,
     pci_dev = pci_create(bus, devfn, pci_nic_names[i]);
     dev = &pci_dev->qdev;
     qdev_set_nic_properties(dev, nd);
-
-    object_property_set_bool(OBJECT(dev), true, "realized", &err);
-    if (err) {
-        error_report_err(err);
-        object_unparent(OBJECT(dev));
-        exit(1);
-    }
+    qdev_init_nofail(dev);
 
     return pci_dev;
 }
-- 
2.7.4
