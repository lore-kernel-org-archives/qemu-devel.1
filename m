Received: from eggs.gnu.org ([2001:4830:134:3::10]:36773)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGx-0008Im-Nd
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dTSGx-0005rg-0a
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:7246)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dTSGw-0005rQ-Qt
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:22:10 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Fri,  7 Jul 2017 14:21:56 +0200
Message-Id: <20170707122159.24714-5-cohuck@redhat.com>
In-Reply-To: <20170707122159.24714-1-cohuck@redhat.com>
References: <20170707122159.24714-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH RFC 4/7] s390x/ccw: create s390 phb
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

Don't create the s390 pci host bridge for non-pci builds.

Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-virtio-ccw.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 41ca6668e2..563f7702a1 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -114,7 +114,6 @@ static void ccw_init(MachineState *machine)
 {
     int ret;
     VirtualCssBus *css_bus;
-    DeviceState *dev;
 
     s390_sclp_init();
     s390_memory_init(machine->ram_size);
@@ -126,12 +125,14 @@ static void ccw_init(MachineState *machine)
     s390_init_ipl_dev(machine->kernel_filename, machine->kernel_cmdline,
                       machine->initrd_filename, "s390-ccw.img",
                       "s390-netboot.img", true);
-
-    dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
+#ifdef CONFIG_PCI
+    {
+    DeviceState *dev = qdev_create(NULL, TYPE_S390_PCI_HOST_BRIDGE);
     object_property_add_child(qdev_get_machine(), TYPE_S390_PCI_HOST_BRIDGE,
                               OBJECT(dev), NULL);
     qdev_init_nofail(dev);
-
+    }
+#endif
     /* register hypercalls */
     virtio_ccw_register_hcalls();
 
-- 
2.13.0
