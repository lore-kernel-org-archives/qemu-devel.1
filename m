Received: from eggs.gnu.org ([2001:4830:134:3::10]:58424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dddKI-0005VR-E0
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 10:11:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1ddao2-0003ru-KZ
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:31:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41396)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1ddao2-0003pj-80
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 07:30:14 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  4 Aug 2017 13:29:42 +0200
Message-Id: <20170804112946.5247-6-cohuck@redhat.com>
In-Reply-To: <20170804112946.5247-1-cohuck@redhat.com>
References: <20170804112946.5247-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/9] s390x/ccw: create s390 phb conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, Cornelia Huck <cohuck@redhat.com>

Don't create the s390 pci host bridge if we do not provide the zpci
facility.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1c7af39ce6..8be4a541c1 100644
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
