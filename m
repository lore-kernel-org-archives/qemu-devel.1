Received: from eggs.gnu.org ([2001:4830:134:3::10]:57077)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Fx-0002KA-8p
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6Fw-0005PR-EO
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53954)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6Fw-0005P4-7p
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:54:20 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:26 +0200
Message-Id: <20170830165252.13421-19-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 18/44] s390x/ccw: create s390 phb conditionally
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

Don't create the s390 pci host bridge if we do not provide the zpci
facility.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index d3d67b8d77..8331c0a275 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -118,12 +118,11 @@ static void ccw_init(MachineState *machine)
 {
     int ret;
     VirtualCssBus *css_bus;
-    DeviceState *dev;
 
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
 
-    /* init CPUs */
+    /* init CPUs (incl. CPU model) early so s390_has_feature() works */
     s390_init_cpus(machine);
 
     s390_flic_init();
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
2.13.5
