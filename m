Received: from eggs.gnu.org ([2001:4830:134:3::10]:54127)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZUyN-00033M-TV
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 00:00:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eZUyM-0000Nr-I4
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 00:00:15 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Thu, 11 Jan 2018 15:59:36 +1100
Message-Id: <20180111045937.2119-11-david@gibson.dropbear.id.au>
In-Reply-To: <20180111045937.2119-1-david@gibson.dropbear.id.au>
References: <20180111045937.2119-1-david@gibson.dropbear.id.au>
Subject: [Qemu-devel] [PULL 10/11] hw/ppc: Remove the deprecated
 spapr-pci-vfio-host-bridge device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org, groug@kaod.org, mdroth@linux.vnet.ibm.com, surajjs@au1.ibm.com, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

It's a deprecated dummy device since QEMU v2.6.0. That should have
been enough time to allow the users to update their scripts in case
they still use it, so let's remove this legacy code now.

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr_pci_vfio.c   | 47 -----------------------------------------------
 qemu-doc.texi             |  5 -----
 scripts/device-crash-test |  1 -
 3 files changed, 53 deletions(-)

diff --git a/hw/ppc/spapr_pci_vfio.c b/hw/ppc/spapr_pci_vfio.c
index 1f775ea93d..053efb03bd 100644
--- a/hw/ppc/spapr_pci_vfio.c
+++ b/hw/ppc/spapr_pci_vfio.c
@@ -29,31 +29,6 @@
 #include "qemu/error-report.h"
 #include "sysemu/qtest.h"
 
-#define TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE "spapr-pci-vfio-host-bridge"
-
-#define SPAPR_PCI_VFIO_HOST_BRIDGE(obj) \
-    OBJECT_CHECK(sPAPRPHBVFIOState, (obj), TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE)
-
-typedef struct sPAPRPHBVFIOState sPAPRPHBVFIOState;
-
-struct sPAPRPHBVFIOState {
-    sPAPRPHBState phb;
-
-    int32_t iommugroupid;
-};
-
-static Property spapr_phb_vfio_properties[] = {
-    DEFINE_PROP_INT32("iommu", sPAPRPHBVFIOState, iommugroupid, -1),
-    DEFINE_PROP_END_OF_LIST(),
-};
-
-static void spapr_phb_vfio_instance_init(Object *obj)
-{
-    if (!qtest_enabled()) {
-        warn_report("spapr-pci-vfio-host-bridge is deprecated");
-    }
-}
-
 bool spapr_phb_eeh_available(sPAPRPHBState *sphb)
 {
     return vfio_eeh_as_ok(&sphb->iommu_as);
@@ -218,25 +193,3 @@ int spapr_phb_vfio_eeh_configure(sPAPRPHBState *sphb)
 
     return RTAS_OUT_SUCCESS;
 }
-
-static void spapr_phb_vfio_class_init(ObjectClass *klass, void *data)
-{
-    DeviceClass *dc = DEVICE_CLASS(klass);
-
-    dc->props = spapr_phb_vfio_properties;
-}
-
-static const TypeInfo spapr_phb_vfio_info = {
-    .name          = TYPE_SPAPR_PCI_VFIO_HOST_BRIDGE,
-    .parent        = TYPE_SPAPR_PCI_HOST_BRIDGE,
-    .instance_size = sizeof(sPAPRPHBVFIOState),
-    .instance_init = spapr_phb_vfio_instance_init,
-    .class_init    = spapr_phb_vfio_class_init,
-};
-
-static void spapr_pci_vfio_register_types(void)
-{
-    type_register_static(&spapr_phb_vfio_info);
-}
-
-type_init(spapr_pci_vfio_register_types)
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 9d0159832e..a3d2054c90 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -2757,11 +2757,6 @@ The ``host_net_remove'' command is replaced by the ``netdev_del'' command.
 The ``ivshmem'' device type is replaced by either the ``ivshmem-plain''
 or ``ivshmem-doorbell`` device types.
 
-@subsection spapr-pci-vfio-host-bridge (since 2.6.0)
-
-The ``spapr-pci-vfio-host-bridge'' device type is replaced by
-the ``spapr-pci-host-bridge'' device type.
-
 @section System emulator machines
 
 @subsection Xilinx EP108 (since 2.11.0)
diff --git a/scripts/device-crash-test b/scripts/device-crash-test
index c11fd81c52..827d8ec2af 100755
--- a/scripts/device-crash-test
+++ b/scripts/device-crash-test
@@ -119,7 +119,6 @@ ERROR_WHITELIST = [
     {'device':'scsi-generic', 'expected':True},            # drive property not set
     {'device':'scsi-hd', 'expected':True},                 # drive property not set
     {'device':'spapr-pci-host-bridge', 'expected':True},   # BUID not specified for PHB
-    {'device':'spapr-pci-vfio-host-bridge', 'expected':True}, # BUID not specified for PHB
     {'device':'spapr-rng', 'expected':True},               # spapr-rng needs an RNG backend!
     {'device':'spapr-vty', 'expected':True},               # chardev property not set
     {'device':'tpm-tis', 'expected':True},                 # tpm_tis: backend driver with id (null) could not be found
-- 
2.14.3
