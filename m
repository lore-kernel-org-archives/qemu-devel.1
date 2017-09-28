Received: from eggs.gnu.org ([2001:4830:134:3::10]:34738)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxYiF-0000GC-7A
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dxYi8-0006aO-Lw
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:18:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53842
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dxYi8-0006Zw-D7
	for qemu-devel@nongnu.org; Thu, 28 Sep 2017 09:18:40 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v8SDEfa0078985
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:18:37 -0400
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2d8vvqs6a5-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 28 Sep 2017 09:18:37 -0400
Received: from localhost
	by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 28 Sep 2017 14:18:35 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 28 Sep 2017 15:18:31 +0200
Message-Id: <20170928131831.81393-1-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH] Revert "s390x/ccw: create s390 phb
 conditionally"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>

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
---
 hw/s390x/s390-virtio-ccw.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index b6aa2da..a77336f 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -275,6 +275,7 @@ static void ccw_init(MachineState *machine)
 {
     int ret;
     VirtualCssBus *css_bus;
+    DeviceState *dev;
 
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
@@ -290,13 +291,14 @@ static void ccw_init(MachineState *machine)
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
+     * always created it. Doing so would break migration across QEMU versions
+     */
+    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
+    object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
+                              OBJECT(dev), NULL);
+    qdev_init_nofail(dev);
 
     /* register hypercalls */
     virtio_ccw_register_hcalls();
-- 
2.9.4
