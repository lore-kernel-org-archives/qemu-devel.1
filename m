Received: from eggs.gnu.org ([209.51.188.92]:54730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nD-0001Qw-Lu
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1gr3nB-000839-KD
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 11:41:51 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue,  5 Feb 2019 17:41:04 +0100
Message-Id: <20190205164109.25413-6-cohuck@redhat.com>
In-Reply-To: <20190205164109.25413-1-cohuck@redhat.com>
References: <20190205164109.25413-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 05/10] s390x/pci: mark zpci devices as
 unmigratable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Cornelia Huck <cohuck@redhat.com>

We currently don't migrate any state for zpci devices, which are
coupled with standard pci devices. This means funny things happen
when we e.g. try to migrate with a virtio-pci device but the s390x-
specific zpci state is not migrated (vfio-pci is not affected, as
it is not migratable anyway.)

Until this is fixed, mark zpci devices as unmigratable.

Reported-by: David Hildenbrand <david@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Collin Walling <walling@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 hw/s390x/s390-pci-bus.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/s390x/s390-pci-bus.c b/hw/s390x/s390-pci-bus.c
index c96a7cba34..96c7c18f3f 100644
--- a/hw/s390x/s390-pci-bus.c
+++ b/hw/s390x/s390-pci-bus.c
@@ -1253,6 +1253,15 @@ static Property s390_pci_device_properties[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static const VMStateDescription s390_pci_device_vmstate = {
+    .name = TYPE_S390_PCI_DEVICE,
+    /*
+     * TODO: add state handling here, so migration works at least with
+     * emulated pci devices on s390x
+     */
+    .unmigratable = 1,
+};
+
 static void s390_pci_device_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -1263,6 +1272,7 @@ static void s390_pci_device_class_init(ObjectClass *klass, void *data)
     dc->bus_type = TYPE_S390_PCI_BUS;
     dc->realize = s390_pci_device_realize;
     dc->props = s390_pci_device_properties;
+    dc->vmsd = &s390_pci_device_vmstate;
 }
 
 static const TypeInfo s390_pci_device_info = {
-- 
2.17.2
