Received: from eggs.gnu.org ([2001:4830:134:3::10]:58982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRR-0006K4-4F
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1e0PRL-00080P-IO
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40768)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1e0PRL-0007zV-CF
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 06:01:07 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  6 Oct 2017 11:59:40 +0200
Message-Id: <20171006095956.27534-18-cohuck@redhat.com>
In-Reply-To: <20171006095956.27534-1-cohuck@redhat.com>
References: <20171006095956.27534-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 17/33] Revert "s390x/ccw: create s390 phb
 conditionally"
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

From: Christian Borntraeger <borntraeger@de.ibm.com>

This reverts commit d32bd032d8fde41281aae34c16a4aa97e9acfeac.

Turns out that old QEMUs always created a pci host bridge
and for many CPU models the migration from old QEMUs to new
QEMUs will fail with
qemu-system-s390x: Unknown savevm section or instance 'PCIBUS' 0
qemu-system-s390x: load of migration failed: Invalid argument

As a quick fix we will revert the commit and always create the
pci host bridge.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[fixed revert to keep the comment fixup, added a comment in the code]
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Message-Id: <20170928131831.81393-1-borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 1bcb7000ab..2c689d50bc 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -251,6 +251,7 @@ static void ccw_init(MachineState *machine)
 {
     int ret;
     VirtualCssBus *css_bus;
+    DeviceState *dev;
 
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
@@ -266,13 +267,14 @@ static void ccw_init(MachineState *machine)
                       machine->initrd_filename, "s390-ccw.img",
                       "s390-netboot.img", true);
 
-    if (s390_has_feat(S390_FEAT_ZPCI)) {
-        DeviceState *dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
-        object_property_add_child(qdev_get_machine(),
-                                  TYPE_S390_PCI_HOST_BRIDGE,
-                                  OBJECT(dev), NULL);
-        qdev_init_nofail(dev);
-    }
+    /*
+     * We cannot easily make the pci host bridge conditional as older QEMUs
+     * always created it. Doing so would break migration across QEMU versions.
+     */
+    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
+    object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
 
     /* register hypercalls */
     virtio_ccw_register_hcalls();
-- 
2.13.6
