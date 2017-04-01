Received: from eggs.gnu.org ([2001:4830:134:3::10]:51652)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7C6-0004lW-62
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cu7C2-0006Bp-Es
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 20:47:05 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Fri, 31 Mar 2017 21:46:08 -0300
Message-Id: <20170401004624.30886-4-ehabkost@redhat.com>
In-Reply-To: <20170401004624.30886-1-ehabkost@redhat.com>
References: <20170401004624.30886-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [RFC 03/19] sysbus: Set user_creatable=false by
 default on TYPE_SYS_BUS_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laszlo Ersek <lersek@redhat.com>, Alexander Graf <agraf@suse.de>, Marcel Apfelbaum <marcel@redhat.com>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>, John Snow <jsnow@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Scott Wood <scottwood@freescale.com>, Jason Wang <jasowang@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Gerd Hoffmann <kraxel@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org, Alistair Francis <alistair.francis@xilinx.com>, Beniamino Galvani <b.galvani@gmail.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "Gabriel L . Somlo" <somlo@cmu.edu>, Igor Mammedov <imammedo@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>, qemu-arm@nongnu.org, Shannon Zhao <zhaoshenglong@huawei.com>

commit 33cd52b5d7b9adfd009e95f07e6c64dd88ae2a31 unset
cannot_instantiate_with_device_add_yet in TYPE_SYSBUS, making
all kinds of untested devices available to -device and
device_add.

The problem with that is: setting has_dynamic_sysbus on a
machine-type lets it accept all the 288 sysbus device types we
have in QEMU, and most of them were never meant to be used with
-device. That's a lot of untested code.

Fortunately today we have just a few has_dynamic_sysbus=1
machines: virt, pc-q35-*, ppce500, and spapr.

virt, ppce500, and spapr have extra checks to ensure just a few
device types can be instantiated:

* virt supports only TYPE_VFIO_CALXEDA_XGMAC, TYPE_VFIO_AMD_XGBE.
* ppce500 supports only TYPE_ETSEC_COMMON.
* spapr supports only TYPE_SPAPR_PCI_HOST_BRIDGE.

q35 has no code to block unsupported sysbus devices, however, and
accepts all device types. Fortunately, only the following 20
device types are compiled into the qemu-system-x86_64 and
qemu-system-i386 binaries:

* allwinner-ahci
* amd-iommu
* cfi.pflash01
* esp
* fw_cfg_io
* fw_cfg_mem
* generic-sdhci
* hpet
* intel-iommu
* ioapic
* isabus-bridge
* kvmclock
* kvm-ioapic
* kvmvapic
* SUNW,fdtwo
* sysbus-ahci
* sysbus-fdc
* sysbus-ohci
* unimplemented-device
* virtio-mmio

Instead of requiring each machine-type with has_dynamic_sysbus=1
to implement its own mechanism to block unsupported devices, we
can use the user_creatable flag to ensure we won't let the user
plug anything that will never work.

This patch adds user_creatable=true explicitly to the
24 device types mentioned above, to keep compatibility, and set
user_creatable=false on TYPE_SYS_BUS_DEVICE.

Subsequent patches will remove user_creatable=true from the
devices that were not meant to be creatable using -device
despite being currently accepted by q35.

Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Alexander Graf <agraf@suse.de>
Cc: John Snow <jsnow@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>
Cc: Max Reitz <mreitz@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Scott Wood <scottwood@freescale.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-block@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: Alistair Francis <alistair.francis@xilinx.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: Gabriel L. Somlo <somlo@cmu.edu>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Prasad J Pandit <pjp@fedoraproject.org>
Cc: qemu-arm@nongnu.org
Cc: Shannon Zhao <zhaoshenglong@huawei.com>
Cc: Thomas Huth <thuth@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/block/fdc.c           | 10 ++++++++++
 hw/block/pflash_cfi01.c  |  5 +++++
 hw/core/sysbus.c         | 11 +++++++++++
 hw/i386/amd_iommu.c      |  5 +++++
 hw/i386/intel_iommu.c    |  5 +++++
 hw/i386/kvm/clock.c      |  5 +++++
 hw/i386/kvm/ioapic.c     |  5 +++++
 hw/i386/kvmvapic.c       |  5 +++++
 hw/ide/ahci.c            | 10 ++++++++++
 hw/intc/ioapic.c         |  5 +++++
 hw/isa/isa-bus.c         |  5 +++++
 hw/misc/unimp.c          |  5 +++++
 hw/net/fsl_etsec/etsec.c |  1 +
 hw/nvram/fw_cfg.c        | 10 ++++++++++
 hw/ppc/spapr_pci.c       |  1 +
 hw/scsi/esp.c            |  5 +++++
 hw/sd/sdhci.c            |  5 +++++
 hw/timer/hpet.c          |  5 +++++
 hw/usb/hcd-ohci.c        |  5 +++++
 hw/vfio/amd-xgbe.c       |  1 +
 hw/vfio/calxeda-xgmac.c  |  1 +
 hw/virtio/virtio-mmio.c  |  5 +++++
 22 files changed, 115 insertions(+)

diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index a328693d15..a06c8e358c 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2880,6 +2880,11 @@ static void sysbus_fdc_class_init(ObjectClass *klass, void *data)
 
     dc->props = sysbus_fdc_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_fdc_info = {
@@ -2906,6 +2911,11 @@ static void sun4m_fdc_class_init(ObjectClass *klass, void *data)
 
     dc->props = sun4m_fdc_properties;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo sun4m_fdc_info = {
diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 594d4cf6fe..f48dc20035 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -927,6 +927,11 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
     dc->props = pflash_cfi01_properties;
     dc->vmsd = &vmstate_pflash;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 
diff --git a/hw/core/sysbus.c b/hw/core/sysbus.c
index c0f560b289..2d4121dd67 100644
--- a/hw/core/sysbus.c
+++ b/hw/core/sysbus.c
@@ -326,6 +326,17 @@ static void sysbus_device_class_init(ObjectClass *klass, void *data)
     DeviceClass *k = DEVICE_CLASS(klass);
     k->init = sysbus_device_init;
     k->bus_type = TYPE_SYSTEM_BUS;
+    /*
+     * device_add plugs devices into suitable bus.  For "real" buses,
+     * that actually connects the device.  For sysbus, the connections
+     * need to be made separately, and device_add can't do that.  The
+     * device would be left unconnected, and will probably not work
+     *
+     * However, a few machines and a few devices can handle a few sysbus
+     * devices, if the device subclass overrides user_creatable=true and
+     * the machine has has_dynamic_sysbus=1.
+     */
+    k->user_creatable = false;
 }
 
 static const TypeInfo sysbus_device_type_info = {
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index f86a40aa30..1d139f3f6a 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1186,6 +1186,11 @@ static void amdvi_class_init(ObjectClass *klass, void* data)
     dc->vmsd = &vmstate_amdvi;
     dc->hotpluggable = false;
     dc_class->realize = amdvi_realize;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo amdvi = {
diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
index 22d8226e43..5e5125f34b 100644
--- a/hw/i386/intel_iommu.c
+++ b/hw/i386/intel_iommu.c
@@ -2601,6 +2601,11 @@ static void vtd_class_init(ObjectClass *klass, void *data)
     dc->hotpluggable = false;
     x86_class->realize = vtd_realize;
     x86_class->int_remap = vtd_int_remap;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vtd_info = {
diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 13eca374cd..0dbf083b17 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -286,6 +286,11 @@ static void kvmclock_class_init(ObjectClass *klass, void *data)
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
     dc->props = kvmclock_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo kvmclock_info = {
diff --git a/hw/i386/kvm/ioapic.c b/hw/i386/kvm/ioapic.c
index 98ca480792..cdc35de661 100644
--- a/hw/i386/kvm/ioapic.c
+++ b/hw/i386/kvm/ioapic.c
@@ -167,6 +167,11 @@ static void kvm_ioapic_class_init(ObjectClass *klass, void *data)
     k->post_load = kvm_ioapic_put;
     dc->reset    = kvm_ioapic_reset;
     dc->props    = kvm_ioapic_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo kvm_ioapic_info = {
diff --git a/hw/i386/kvmvapic.c b/hw/i386/kvmvapic.c
index 82a49556af..fbada19253 100644
--- a/hw/i386/kvmvapic.c
+++ b/hw/i386/kvmvapic.c
@@ -856,6 +856,11 @@ static void vapic_class_init(ObjectClass *klass, void *data)
     dc->reset   = vapic_reset;
     dc->vmsd    = &vmstate_vapic;
     dc->realize = vapic_realize;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vapic_type = {
diff --git a/hw/ide/ahci.c b/hw/ide/ahci.c
index f60826d6e0..b1b7780d56 100644
--- a/hw/ide/ahci.c
+++ b/hw/ide/ahci.c
@@ -1721,6 +1721,11 @@ static void sysbus_ahci_class_init(ObjectClass *klass, void *data)
     dc->props = sysbus_ahci_properties;
     dc->reset = sysbus_ahci_reset;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_ahci_info = {
@@ -1815,6 +1820,11 @@ static void allwinner_ahci_class_init(ObjectClass *klass, void *data)
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->vmsd = &vmstate_allwinner_ahci;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo allwinner_ahci_info = {
diff --git a/hw/intc/ioapic.c b/hw/intc/ioapic.c
index 37c4386ae3..38af393538 100644
--- a/hw/intc/ioapic.c
+++ b/hw/intc/ioapic.c
@@ -448,6 +448,11 @@ static void ioapic_class_init(ObjectClass *klass, void *data)
     k->post_load = ioapic_update_kvm_routes;
     dc->reset = ioapic_reset_common;
     dc->props = ioapic_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo ioapic_info = {
diff --git a/hw/isa/isa-bus.c b/hw/isa/isa-bus.c
index 348e0eab9d..576dbf1763 100644
--- a/hw/isa/isa-bus.c
+++ b/hw/isa/isa-bus.c
@@ -221,6 +221,11 @@ static void isabus_bridge_class_init(ObjectClass *klass, void *data)
 
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     dc->fw_name = "isa";
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo isabus_bridge_info = {
diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
index bcbb585888..284f096beb 100644
--- a/hw/misc/unimp.c
+++ b/hw/misc/unimp.c
@@ -90,6 +90,11 @@ static void unimp_class_init(ObjectClass *klass, void *data)
 
     dc->realize = unimp_realize;
     dc->props = unimp_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo unimp_info = {
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index aa2b0d5a85..b230b88753 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -416,6 +416,7 @@ static void etsec_class_init(ObjectClass *klass, void *data)
     dc->realize = etsec_realize;
     dc->reset = etsec_reset;
     dc->props = etsec_properties;
+    dc->user_creatable = true;
 }
 
 static TypeInfo etsec_info = {
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 316fca9bc1..60bf4fdd2e 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -1101,6 +1101,11 @@ static void fw_cfg_io_class_init(ObjectClass *klass, void *data)
 
     dc->realize = fw_cfg_io_realize;
     dc->props = fw_cfg_io_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo fw_cfg_io_info = {
@@ -1167,6 +1172,11 @@ static void fw_cfg_mem_class_init(ObjectClass *klass, void *data)
 
     dc->realize = fw_cfg_mem_realize;
     dc->props = fw_cfg_mem_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo fw_cfg_mem_info = {
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index 98c52e411f..360eeb2e40 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1990,6 +1990,7 @@ static void spapr_phb_class_init(ObjectClass *klass, void *data)
     dc->props = spapr_phb_properties;
     dc->reset = spapr_phb_reset;
     dc->vmsd = &vmstate_spapr_pci;
+    dc->user_creatable = true;
     set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
     hp->plug = spapr_phb_hot_plug_child;
     hp->unplug = spapr_phb_hot_unplug_child;
diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
index eee831efeb..1087b8f14f 100644
--- a/hw/scsi/esp.c
+++ b/hw/scsi/esp.c
@@ -728,6 +728,11 @@ static void sysbus_esp_class_init(ObjectClass *klass, void *data)
     dc->reset = sysbus_esp_hard_reset;
     dc->vmsd = &vmstate_sysbus_esp_scsi;
     set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo sysbus_esp_info = {
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6d6a791ee9..186555188b 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1360,6 +1360,11 @@ static void sdhci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->props = sdhci_sysbus_properties;
     dc->realize = sdhci_sysbus_realize;
     dc->reset = sdhci_poweron_reset;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo sdhci_sysbus_info = {
diff --git a/hw/timer/hpet.c b/hw/timer/hpet.c
index a2c18b30c3..b5dab1c8e2 100644
--- a/hw/timer/hpet.c
+++ b/hw/timer/hpet.c
@@ -771,6 +771,11 @@ static void hpet_device_class_init(ObjectClass *klass, void *data)
     dc->reset = hpet_reset;
     dc->vmsd = &vmstate_hpet;
     dc->props = hpet_device_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo hpet_device_info = {
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 3ada35e954..0e17fb1e60 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -2159,6 +2159,11 @@ static void ohci_sysbus_class_init(ObjectClass *klass, void *data)
     dc->desc = "OHCI USB Controller";
     dc->props = ohci_sysbus_properties;
     dc->reset = usb_ohci_reset_sysbus;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo ohci_sysbus_info = {
diff --git a/hw/vfio/amd-xgbe.c b/hw/vfio/amd-xgbe.c
index 2c60310cf9..f0b6624530 100644
--- a/hw/vfio/amd-xgbe.c
+++ b/hw/vfio/amd-xgbe.c
@@ -38,6 +38,7 @@ static void vfio_amd_xgbe_class_init(ObjectClass *klass, void *data)
     dc->realize = amd_xgbe_realize;
     dc->desc = "VFIO AMD XGBE";
     dc->vmsd = &vfio_platform_amd_xgbe_vmstate;
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_amd_xgbe_dev_info = {
diff --git a/hw/vfio/calxeda-xgmac.c b/hw/vfio/calxeda-xgmac.c
index bb15d588e5..6fae3c5772 100644
--- a/hw/vfio/calxeda-xgmac.c
+++ b/hw/vfio/calxeda-xgmac.c
@@ -38,6 +38,7 @@ static void vfio_calxeda_xgmac_class_init(ObjectClass *klass, void *data)
     dc->realize = calxeda_xgmac_realize;
     dc->desc = "VFIO Calxeda XGMAC";
     dc->vmsd = &vfio_platform_calxeda_xgmac_vmstate;
+    dc->user_creatable = true;
 }
 
 static const TypeInfo vfio_calxeda_xgmac_dev_info = {
diff --git a/hw/virtio/virtio-mmio.c b/hw/virtio/virtio-mmio.c
index 5807aa87fe..b595512a3d 100644
--- a/hw/virtio/virtio-mmio.c
+++ b/hw/virtio/virtio-mmio.c
@@ -450,6 +450,11 @@ static void virtio_mmio_class_init(ObjectClass *klass, void *data)
     dc->reset = virtio_mmio_reset;
     set_bit(DEVICE_CATEGORY_MISC, dc->categories);
     dc->props = virtio_mmio_properties;
+    /*
+     * FIXME: Set only for compatibility on q35 machine-type.
+     * Probably never meant to be user-creatable
+     */
+    dc->user_creatable = true;
 }
 
 static const TypeInfo virtio_mmio_info = {
-- 
2.11.0.259.g40922b1
