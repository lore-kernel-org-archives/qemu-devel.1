Received: from eggs.gnu.org ([2001:4830:134:3::10]:58249)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTR3-0006w5-Ao
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dXTR2-0004ph-9u
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dXTR2-0004pB-3P
	for qemu-devel@nongnu.org; Tue, 18 Jul 2017 10:25:12 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 18 Jul 2017 16:24:51 +0200
Message-Id: <20170718142455.32676-6-cohuck@redhat.com>
In-Reply-To: <20170718142455.32676-1-cohuck@redhat.com>
References: <20170718142455.32676-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC v2 5/9] s390x/ccw: create s390 phb
 conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Don't create the s390 pci host bridge if we do not provide the zpci
facility.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index ce3921e4de..bd3ba30c27 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -118,7 +118,6 @@ static void ccw_init(MachineState *machine)
 {
     int ret;
     VirtualCssBus *css_bus;
-    DeviceState *dev;
 
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
@@ -134,10 +133,13 @@ static void ccw_init(MachineState *machine)
                       machine->initrd_filename, "s390-ccw.img",
                       "s390-netboot.img", true);
 
-    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
-    object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
-                              OBJECT(dev), NULL);
-    qdev_init_nofail(dev);
+    if (s390_has_feat(S390_FEAT_ZPCI)) {
+        DeviceState *dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
+        object_property_add_child(qdev_get_machine(),
+                                  TYPE_S390_PCI_HOST_BRIDGE,
+                                  OBJECT(dev), NULL);
+        qdev_init_nofail(dev);
+    }
 
     /* register hypercalls */
     virtio_ccw_register_hcalls();
-- 
2.13.3
