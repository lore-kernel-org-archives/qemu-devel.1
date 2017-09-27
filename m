Received: from eggs.gnu.org ([2001:4830:134:3::10]:47813)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxIT8-0007Du-LM
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dxIT4-0007dJ-KE
	for qemu-devel@nongnu.org; Wed, 27 Sep 2017 15:58:06 -0400
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 27 Sep 2017 16:56:34 -0300
Message-Id: <20170927195635.16014-5-ehabkost@redhat.com>
In-Reply-To: <20170927195635.16014-1-ehabkost@redhat.com>
References: <20170927195635.16014-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] pci: Add
 INTERFACE_CONVENTIONAL_PCI_DEVICE to Conventional PCI devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <dgibson@redhat.com>, Alistair Francis <alistair23@gmail.com>, Laine Stump <laine@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, John Snow <jsnow@redhat.com>, Alberto Garcia <berto@igalia.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Jiri Slaby <jslaby@suse.cz>, Alexander Graf <agraf@suse.de>, Jason Wang <jasowang@redhat.com>, Jiri Pirko <jiri@resnulli.us>, =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Hannes Reinecke <hare@suse.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, xen-devel@lists.xenproject.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org

Add INTERFACE_CONVENTIONAL_PCI_DEVICE to all direct subtypes of
TYPE_PCI_DEVICE, except:

1) The ones that already have INTERFACE_PCIE_DEVICE set:

* base-xhci
* e1000e
* nvme
* pvscsi
* vfio-pci
* virtio-pci
* vmxnet3

2) base-pci-bridge

Not all PCI bridges are Conventional PCI devices, so
INTERFACE_CONVENTIONAL_PCI_DEVICE is added only to the subtypes
that are actually Conventional PCI:

* dec-21154-p2p-bridge
* i82801b11-bridge
* pbm-bridge
* pci-bridge

The direct subtypes of base-pci-bridge not touched by this patch
are:

* xilinx-pcie-root: Already marked as PCIe-only.
* pcie-pci-bridge: Already marked as PCIe-only.
* pcie-port: all non-abstract subtypes of pcie-port are already
  marked as PCIe-only devices.

3) megasas-base

Not all megasas devices are Conventional PCI devices, so the
interface names are added to the subclasses registered by
megasas_register_types(), according to information in the
megasas_devices[] array.

"megasas-gen2" already implements INTERFACE_PCIE_DEVICE, so add
INTERFACE_CONVENTIONAL_PCI_DEVICE only to "megasas".

Acked-by: Alberto Garcia <berto@igalia.com>
Acked-by: John Snow <jsnow@redhat.com>
Acked-by: Anthony PERARD <anthony.perard@citrix.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
Changes v1 -> v2:
* s/legacy/conventional/
  * Suggested-by: Alex Williamson <alex.williamson@redhat.com>
* Note about pcie-pci-bridge on commit message.
* New devices: sungem, sunhme

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Igor Mammedov <imammedo@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Anthony Perard <anthony.perard@citrix.com>
Cc: John Snow <jsnow@redhat.com>
Cc: Alberto Garcia <berto@igalia.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Alexander Graf <agraf@suse.de>
Cc: Marcel Apfelbaum <marcel@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>
Cc: "Herv=C3=A9 Poussineau" <hpoussin@reactos.org>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: Artyom Tarasenko <atar4qemu@gmail.com>
Cc: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org
Cc: xen-devel@lists.xenproject.org
Cc: qemu-block@nongnu.org
Cc: qemu-ppc@nongnu.org
Cc: qemu-arm@nongnu.org
---
 hw/acpi/piix4.c                     |  1 +
 hw/audio/ac97.c                     |  4 ++++
 hw/audio/es1370.c                   |  4 ++++
 hw/audio/intel-hda.c                |  4 ++++
 hw/char/serial-pci.c                | 12 ++++++++++++
 hw/display/cirrus_vga.c             |  4 ++++
 hw/display/qxl.c                    |  4 ++++
 hw/display/sm501.c                  |  4 ++++
 hw/display/vga-pci.c                |  4 ++++
 hw/display/vmware_vga.c             |  4 ++++
 hw/i2c/smbus_ich9.c                 |  4 ++++
 hw/i386/amd_iommu.c                 |  4 ++++
 hw/i386/kvm/pci-assign.c            |  4 ++++
 hw/i386/pc_piix.c                   |  4 ++++
 hw/i386/xen/xen_platform.c          |  4 ++++
 hw/i386/xen/xen_pvdevice.c          |  4 ++++
 hw/ide/ich.c                        |  4 ++++
 hw/ide/pci.c                        |  4 ++++
 hw/ipack/tpci200.c                  |  4 ++++
 hw/isa/i82378.c                     |  4 ++++
 hw/isa/lpc_ich9.c                   |  1 +
 hw/isa/piix4.c                      |  4 ++++
 hw/isa/vt82c686.c                   | 16 ++++++++++++++++
 hw/mips/gt64xxx_pci.c               |  4 ++++
 hw/misc/edu.c                       |  5 +++++
 hw/misc/ivshmem.c                   |  4 ++++
 hw/misc/macio/macio.c               |  4 ++++
 hw/misc/pci-testdev.c               |  4 ++++
 hw/net/e1000.c                      |  4 ++++
 hw/net/eepro100.c                   |  4 ++++
 hw/net/ne2000.c                     |  4 ++++
 hw/net/pcnet-pci.c                  |  4 ++++
 hw/net/rocker/rocker.c              |  4 ++++
 hw/net/rtl8139.c                    |  4 ++++
 hw/net/sungem.c                     |  4 ++++
 hw/net/sunhme.c                     |  4 ++++
 hw/pci-bridge/dec.c                 |  8 ++++++++
 hw/pci-bridge/i82801b11.c           |  4 ++++
 hw/pci-bridge/pci_bridge_dev.c      |  1 +
 hw/pci-bridge/pci_expander_bridge.c |  8 ++++++++
 hw/pci-host/apb.c                   |  8 ++++++++
 hw/pci-host/bonito.c                |  4 ++++
 hw/pci-host/gpex.c                  |  4 ++++
 hw/pci-host/grackle.c               |  4 ++++
 hw/pci-host/piix.c                  |  8 ++++++++
 hw/pci-host/ppce500.c               |  4 ++++
 hw/pci-host/prep.c                  |  4 ++++
 hw/pci-host/q35.c                   |  4 ++++
 hw/pci-host/uninorth.c              | 16 ++++++++++++++++
 hw/pci-host/versatile.c             |  4 ++++
 hw/ppc/ppc4xx_pci.c                 |  4 ++++
 hw/scsi/esp-pci.c                   |  4 ++++
 hw/scsi/lsi53c895a.c                |  4 ++++
 hw/scsi/megasas.c                   |  4 ++++
 hw/scsi/mptsas.c                    |  4 ++++
 hw/sd/sdhci.c                       |  4 ++++
 hw/sh4/sh_pci.c                     |  4 ++++
 hw/sparc64/sun4u.c                  |  4 ++++
 hw/usb/hcd-ehci-pci.c               |  4 ++++
 hw/usb/hcd-ohci.c                   |  4 ++++
 hw/usb/hcd-uhci.c                   |  4 ++++
 hw/vfio/pci-quirks.c                |  4 ++++
 hw/watchdog/wdt_i6300esb.c          |  4 ++++
 hw/xen/xen_pt.c                     |  4 ++++
 64 files changed, 296 insertions(+)

diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
index f4fd5907b8..a0fb1ce037 100644
--- a/hw/acpi/piix4.c
+++ b/hw/acpi/piix4.c
@@ -718,6 +718,7 @@ static const TypeInfo piix4_pm_info =3D {
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
 };
diff --git a/hw/audio/ac97.c b/hw/audio/ac97.c
index 959c786261..337402e9c6 100644
--- a/hw/audio/ac97.c
+++ b/hw/audio/ac97.c
@@ -1431,6 +1431,10 @@ static const TypeInfo ac97_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof (AC97LinkState),
     .class_init    =3D ac97_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void ac97_register_types (void)
diff --git a/hw/audio/es1370.c b/hw/audio/es1370.c
index dd7c23d185..59cf252754 100644
--- a/hw/audio/es1370.c
+++ b/hw/audio/es1370.c
@@ -1082,6 +1082,10 @@ static const TypeInfo es1370_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof (ES1370State),
     .class_init    =3D es1370_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void es1370_register_types (void)
diff --git a/hw/audio/intel-hda.c b/hw/audio/intel-hda.c
index 18a50a8f83..a3e670c188 100644
--- a/hw/audio/intel-hda.c
+++ b/hw/audio/intel-hda.c
@@ -1263,6 +1263,10 @@ static const TypeInfo intel_hda_info =3D {
     .instance_size =3D sizeof(IntelHDAState),
     .class_init    =3D intel_hda_class_init,
     .abstract      =3D true,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static const TypeInfo intel_hda_info_ich6 =3D {
diff --git a/hw/char/serial-pci.c b/hw/char/serial-pci.c
index 303104dd19..cb0d04c1d9 100644
--- a/hw/char/serial-pci.c
+++ b/hw/char/serial-pci.c
@@ -250,6 +250,10 @@ static const TypeInfo serial_pci_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCISerialState),
     .class_init    =3D serial_pci_class_initfn,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static const TypeInfo multi_2x_serial_pci_info =3D {
@@ -257,6 +261,10 @@ static const TypeInfo multi_2x_serial_pci_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIMultiSerialState),
     .class_init    =3D multi_2x_serial_pci_class_initfn,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static const TypeInfo multi_4x_serial_pci_info =3D {
@@ -264,6 +272,10 @@ static const TypeInfo multi_4x_serial_pci_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIMultiSerialState),
     .class_init    =3D multi_4x_serial_pci_class_initfn,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void serial_pci_register_types(void)
diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index afc290ab91..b4d579857a 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -3162,6 +3162,10 @@ static const TypeInfo cirrus_vga_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCICirrusVGAState),
     .class_init    =3D cirrus_vga_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void cirrus_vga_register_types(void)
diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index ae3677fd1e..b20e259122 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -2430,6 +2430,10 @@ static const TypeInfo qxl_pci_type_info =3D {
     .instance_size =3D sizeof(PCIQXLDevice),
     .abstract =3D true,
     .class_init =3D qxl_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void qxl_primary_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 9aa515b3da..6eddac911e 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -1843,6 +1843,10 @@ static const TypeInfo sm501_pci_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(SM501PCIState),
     .class_init    =3D sm501_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void sm501_register_types(void)
diff --git a/hw/display/vga-pci.c b/hw/display/vga-pci.c
index ac9a76499e..7adb89fcb4 100644
--- a/hw/display/vga-pci.c
+++ b/hw/display/vga-pci.c
@@ -338,6 +338,10 @@ static const TypeInfo vga_pci_type_info =3D {
     .instance_size =3D sizeof(PCIVGAState),
     .abstract =3D true,
     .class_init =3D vga_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void vga_class_init(ObjectClass *klass, void *data)
diff --git a/hw/display/vmware_vga.c b/hw/display/vmware_vga.c
index 4a64b41259..cdc3fed6ca 100644
--- a/hw/display/vmware_vga.c
+++ b/hw/display/vmware_vga.c
@@ -1350,6 +1350,10 @@ static const TypeInfo vmsvga_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(struct pci_vmsvga_state_s),
     .class_init    =3D vmsvga_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void vmsvga_register_types(void)
diff --git a/hw/i2c/smbus_ich9.c b/hw/i2c/smbus_ich9.c
index ea51e09186..e47556c9d8 100644
--- a/hw/i2c/smbus_ich9.c
+++ b/hw/i2c/smbus_ich9.c
@@ -119,6 +119,10 @@ static const TypeInfo ich9_smb_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(ICH9SMBState),
     .class_init =3D ich9_smb_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void ich9_smb_register(void)
diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
index 334938a280..ad8155ca4c 100644
--- a/hw/i386/amd_iommu.c
+++ b/hw/i386/amd_iommu.c
@@ -1227,6 +1227,10 @@ static const TypeInfo amdviPCI =3D {
     .name =3D "AMDVI-PCI",
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(AMDVIPCIState),
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void amdvi_iommu_memory_region_class_init(ObjectClass *klass, voi=
d *data)
diff --git a/hw/i386/kvm/pci-assign.c b/hw/i386/kvm/pci-assign.c
index 33e20cb3e8..d8559d8342 100644
--- a/hw/i386/kvm/pci-assign.c
+++ b/hw/i386/kvm/pci-assign.c
@@ -1864,6 +1864,10 @@ static const TypeInfo assign_info =3D {
     .instance_size      =3D sizeof(AssignedDevice),
     .class_init         =3D assign_class_init,
     .instance_init      =3D assigned_dev_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void assign_register_types(void)
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 9ff79b1fd9..1a56465490 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -1055,6 +1055,10 @@ static TypeInfo isa_bridge_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init =3D isa_bridge_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pt_graphics_register_types(void)
diff --git a/hw/i386/xen/xen_platform.c b/hw/i386/xen/xen_platform.c
index 9ba7474566..056b87de0b 100644
--- a/hw/i386/xen/xen_platform.c
+++ b/hw/i386/xen/xen_platform.c
@@ -517,6 +517,10 @@ static const TypeInfo xen_platform_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIXenPlatformState),
     .class_init    =3D xen_platform_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void xen_platform_register_types(void)
diff --git a/hw/i386/xen/xen_pvdevice.c b/hw/i386/xen/xen_pvdevice.c
index c093b34458..f748823658 100644
--- a/hw/i386/xen/xen_pvdevice.c
+++ b/hw/i386/xen/xen_pvdevice.c
@@ -127,6 +127,10 @@ static const TypeInfo xen_pv_type_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(XenPVDevice),
     .class_init    =3D xen_pv_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void xen_pv_register_types(void)
diff --git a/hw/ide/ich.c b/hw/ide/ich.c
index 9472a60cab..8dd0ced6b3 100644
--- a/hw/ide/ich.c
+++ b/hw/ide/ich.c
@@ -184,6 +184,10 @@ static const TypeInfo ich_ahci_info =3D {
     .instance_size =3D sizeof(AHCIPCIState),
     .instance_init =3D pci_ich9_ahci_init,
     .class_init    =3D ich_ahci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void ich_ahci_register_types(void)
diff --git a/hw/ide/pci.c b/hw/ide/pci.c
index f2dcc0ed77..053c0375c1 100644
--- a/hw/ide/pci.c
+++ b/hw/ide/pci.c
@@ -451,6 +451,10 @@ static const TypeInfo pci_ide_type_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIIDEState),
     .abstract =3D true,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pci_ide_register_types(void)
diff --git a/hw/ipack/tpci200.c b/hw/ipack/tpci200.c
index 4dfa6b33f3..da05c8589d 100644
--- a/hw/ipack/tpci200.c
+++ b/hw/ipack/tpci200.c
@@ -646,6 +646,10 @@ static const TypeInfo tpci200_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(TPCI200State),
     .class_init    =3D tpci200_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void tpci200_register_types(void)
diff --git a/hw/isa/i82378.c b/hw/isa/i82378.c
index 4d29a9900c..d20ea4c2ee 100644
--- a/hw/isa/i82378.c
+++ b/hw/isa/i82378.c
@@ -138,6 +138,10 @@ static const TypeInfo i82378_type_info =3D {
     .instance_size =3D sizeof(I82378State),
     .instance_init =3D i82378_init,
     .class_init =3D i82378_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void i82378_register_types(void)
diff --git a/hw/isa/lpc_ich9.c b/hw/isa/lpc_ich9.c
index ac8416d42b..39f56ba44e 100644
--- a/hw/isa/lpc_ich9.c
+++ b/hw/isa/lpc_ich9.c
@@ -823,6 +823,7 @@ static const TypeInfo ich9_lpc_info =3D {
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
         { TYPE_ACPI_DEVICE_IF },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
 };
diff --git a/hw/isa/piix4.c b/hw/isa/piix4.c
index f811eba59d..6b8bc3faf0 100644
--- a/hw/isa/piix4.c
+++ b/hw/isa/piix4.c
@@ -132,6 +132,10 @@ static const TypeInfo piix4_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PIIX4State),
     .class_init    =3D piix4_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void piix4_register_types(void)
diff --git a/hw/isa/vt82c686.c b/hw/isa/vt82c686.c
index 50dc83df77..c129985e2a 100644
--- a/hw/isa/vt82c686.c
+++ b/hw/isa/vt82c686.c
@@ -301,6 +301,10 @@ static const TypeInfo via_ac97_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(VT686AC97State),
     .class_init    =3D via_ac97_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void vt82c686b_mc97_realize(PCIDevice *dev, Error **errp)
@@ -341,6 +345,10 @@ static const TypeInfo via_mc97_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(VT686MC97State),
     .class_init    =3D via_mc97_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 /* vt82c686 pm init */
@@ -419,6 +427,10 @@ static const TypeInfo via_pm_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(VT686PMState),
     .class_init    =3D via_pm_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static const VMStateDescription vmstate_via =3D {
@@ -502,6 +514,10 @@ static const TypeInfo via_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(VT82C686BState),
     .class_init    =3D via_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void vt82c686b_register_types(void)
diff --git a/hw/mips/gt64xxx_pci.c b/hw/mips/gt64xxx_pci.c
index e8b2eef688..5a9dad9aae 100644
--- a/hw/mips/gt64xxx_pci.c
+++ b/hw/mips/gt64xxx_pci.c
@@ -1232,6 +1232,10 @@ static const TypeInfo gt64120_pci_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init    =3D gt64120_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void gt64120_class_init(ObjectClass *klass, void *data)
diff --git a/hw/misc/edu.c b/hw/misc/edu.c
index 01acacf142..34eb05d213 100644
--- a/hw/misc/edu.c
+++ b/hw/misc/edu.c
@@ -408,12 +408,17 @@ static void edu_class_init(ObjectClass *class, void=
 *data)
=20
 static void pci_edu_register_types(void)
 {
+    static InterfaceInfo interfaces[] =3D {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    };
     static const TypeInfo edu_info =3D {
         .name          =3D "edu",
         .parent        =3D TYPE_PCI_DEVICE,
         .instance_size =3D sizeof(EduState),
         .instance_init =3D edu_instance_init,
         .class_init    =3D edu_class_init,
+        .interfaces =3D interfaces,
     };
=20
     type_register_static(&edu_info);
diff --git a/hw/misc/ivshmem.c b/hw/misc/ivshmem.c
index b3ef3ec1e3..a5a46827fe 100644
--- a/hw/misc/ivshmem.c
+++ b/hw/misc/ivshmem.c
@@ -1010,6 +1010,10 @@ static const TypeInfo ivshmem_common_info =3D {
     .instance_size =3D sizeof(IVShmemState),
     .abstract      =3D true,
     .class_init    =3D ivshmem_common_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static const VMStateDescription ivshmem_plain_vmsd =3D {
diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
index 5d57f45dc6..298e65071c 100644
--- a/hw/misc/macio/macio.c
+++ b/hw/misc/macio/macio.c
@@ -415,6 +415,10 @@ static const TypeInfo macio_type_info =3D {
     .instance_init =3D macio_instance_init,
     .abstract      =3D true,
     .class_init    =3D macio_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void macio_register_types(void)
diff --git a/hw/misc/pci-testdev.c b/hw/misc/pci-testdev.c
index 7d5990213e..32041f535f 100644
--- a/hw/misc/pci-testdev.c
+++ b/hw/misc/pci-testdev.c
@@ -326,6 +326,10 @@ static const TypeInfo pci_testdev_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCITestDevState),
     .class_init    =3D pci_testdev_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pci_testdev_register_types(void)
diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index eebe3a9c13..acdb935af5 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -1685,6 +1685,10 @@ static const TypeInfo e1000_base_info =3D {
     .instance_init =3D e1000_instance_init,
     .class_size    =3D sizeof(E1000BaseClass),
     .abstract      =3D true,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static const E1000Info e1000_devices[] =3D {
diff --git a/hw/net/eepro100.c b/hw/net/eepro100.c
index a7b9f77519..80b8f47c4b 100644
--- a/hw/net/eepro100.c
+++ b/hw/net/eepro100.c
@@ -2116,6 +2116,10 @@ static void eepro100_register_types(void)
         type_info.class_init =3D eepro100_class_init;
         type_info.instance_size =3D sizeof(EEPRO100State);
         type_info.instance_init =3D eepro100_instance_init;
+        type_info.interfaces =3D (InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        };
=20
         type_register(&type_info);
     }
diff --git a/hw/net/ne2000.c b/hw/net/ne2000.c
index 798d681e25..3938e6ddd8 100644
--- a/hw/net/ne2000.c
+++ b/hw/net/ne2000.c
@@ -786,6 +786,10 @@ static const TypeInfo ne2000_info =3D {
     .instance_size =3D sizeof(PCINE2000State),
     .class_init    =3D ne2000_class_init,
     .instance_init =3D ne2000_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void ne2000_register_types(void)
diff --git a/hw/net/pcnet-pci.c b/hw/net/pcnet-pci.c
index 0acf8a4879..0ae5ca4701 100644
--- a/hw/net/pcnet-pci.c
+++ b/hw/net/pcnet-pci.c
@@ -365,6 +365,10 @@ static const TypeInfo pcnet_info =3D {
     .instance_size =3D sizeof(PCIPCNetState),
     .class_init    =3D pcnet_class_init,
     .instance_init =3D pcnet_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pci_pcnet_register_types(void)
diff --git a/hw/net/rocker/rocker.c b/hw/net/rocker/rocker.c
index 9273473d59..823a29df03 100644
--- a/hw/net/rocker/rocker.c
+++ b/hw/net/rocker/rocker.c
@@ -1525,6 +1525,10 @@ static const TypeInfo rocker_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(Rocker),
     .class_init    =3D rocker_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void rocker_register_types(void)
diff --git a/hw/net/rtl8139.c b/hw/net/rtl8139.c
index 3be24bbee7..bef0464b2e 100644
--- a/hw/net/rtl8139.c
+++ b/hw/net/rtl8139.c
@@ -3442,6 +3442,10 @@ static const TypeInfo rtl8139_info =3D {
     .instance_size =3D sizeof(RTL8139State),
     .class_init    =3D rtl8139_class_init,
     .instance_init =3D rtl8139_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void rtl8139_register_types(void)
diff --git a/hw/net/sungem.c b/hw/net/sungem.c
index dffa0c90f3..6aa8d1117b 100644
--- a/hw/net/sungem.c
+++ b/hw/net/sungem.c
@@ -1437,6 +1437,10 @@ static const TypeInfo sungem_info =3D {
     .instance_size =3D sizeof(SunGEMState),
     .class_init    =3D sungem_class_init,
     .instance_init =3D sungem_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
 };
=20
 static void sungem_register_types(void)
diff --git a/hw/net/sunhme.c b/hw/net/sunhme.c
index 60277adcf1..b1efa1b88d 100644
--- a/hw/net/sunhme.c
+++ b/hw/net/sunhme.c
@@ -968,6 +968,10 @@ static const TypeInfo sunhme_info =3D {
     .class_init    =3D sunhme_class_init,
     .instance_size =3D sizeof(SunHMEState),
     .instance_init =3D sunhme_instance_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { }
+    }
 };
=20
 static void sunhme_register_types(void)
diff --git a/hw/pci-bridge/dec.c b/hw/pci-bridge/dec.c
index eb275e1a25..84492d5e5f 100644
--- a/hw/pci-bridge/dec.c
+++ b/hw/pci-bridge/dec.c
@@ -79,6 +79,10 @@ static const TypeInfo dec_21154_pci_bridge_info =3D {
     .parent        =3D TYPE_PCI_BRIDGE,
     .instance_size =3D sizeof(PCIBridge),
     .class_init    =3D dec_21154_pci_bridge_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 PCIBus *pci_dec_21154_init(PCIBus *parent_bus, int devfn)
@@ -138,6 +142,10 @@ static const TypeInfo dec_21154_pci_host_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init    =3D dec_21154_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pci_dec_21154_device_class_init(ObjectClass *klass, void *da=
ta)
diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
index 2c1b747b4b..cb522bf30c 100644
--- a/hw/pci-bridge/i82801b11.c
+++ b/hw/pci-bridge/i82801b11.c
@@ -106,6 +106,10 @@ static const TypeInfo i82801b11_bridge_info =3D {
     .parent        =3D TYPE_PCI_BRIDGE,
     .instance_size =3D sizeof(I82801b11Bridge),
     .class_init    =3D i82801b11_bridge_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void d2pbr_register(void)
diff --git a/hw/pci-bridge/pci_bridge_dev.c b/hw/pci-bridge/pci_bridge_de=
v.c
index 4373f1d3e2..d56f6638c2 100644
--- a/hw/pci-bridge/pci_bridge_dev.c
+++ b/hw/pci-bridge/pci_bridge_dev.c
@@ -238,6 +238,7 @@ static const TypeInfo pci_bridge_dev_info =3D {
     .instance_finalize =3D pci_bridge_dev_instance_finalize,
     .interfaces =3D (InterfaceInfo[]) {
         { TYPE_HOTPLUG_HANDLER },
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
         { }
     }
 };
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expa=
nder_bridge.c
index ff59abf208..8c8ac737ad 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -316,6 +316,10 @@ static const TypeInfo pxb_dev_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PXBDev),
     .class_init    =3D pxb_dev_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pxb_pcie_dev_realize(PCIDevice *dev, Error **errp)
@@ -350,6 +354,10 @@ static const TypeInfo pxb_pcie_dev_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PXBDev),
     .class_init    =3D pxb_pcie_dev_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pxb_register_types(void)
diff --git a/hw/pci-host/apb.c b/hw/pci-host/apb.c
index b709456b97..1edf57f600 100644
--- a/hw/pci-host/apb.c
+++ b/hw/pci-host/apb.c
@@ -836,6 +836,10 @@ static const TypeInfo pbm_pci_host_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init    =3D pbm_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pbm_host_class_init(ObjectClass *klass, void *data)
@@ -883,6 +887,10 @@ static const TypeInfo pbm_pci_bridge_info =3D {
     .parent        =3D TYPE_PCI_BRIDGE,
     .class_init    =3D pbm_pci_bridge_class_init,
     .instance_size =3D sizeof(PBMPCIBridge),
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pbm_iommu_memory_region_class_init(ObjectClass *klass, void =
*data)
diff --git a/hw/pci-host/bonito.c b/hw/pci-host/bonito.c
index 89133a9dd3..9f61e27edc 100644
--- a/hw/pci-host/bonito.c
+++ b/hw/pci-host/bonito.c
@@ -833,6 +833,10 @@ static const TypeInfo bonito_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIBonitoState),
     .class_init    =3D bonito_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void bonito_pcihost_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index be25245219..4090793cf0 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -166,6 +166,10 @@ static const TypeInfo gpex_root_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(GPEXRootState),
     .class_init =3D gpex_root_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void gpex_register(void)
diff --git a/hw/pci-host/grackle.c b/hw/pci-host/grackle.c
index 2e281f6155..38cd279b6b 100644
--- a/hw/pci-host/grackle.c
+++ b/hw/pci-host/grackle.c
@@ -142,6 +142,10 @@ static const TypeInfo grackle_pci_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init =3D grackle_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pci_grackle_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/piix.c b/hw/pci-host/piix.c
index 894e131c00..2b8d90a853 100644
--- a/hw/pci-host/piix.c
+++ b/hw/pci-host/piix.c
@@ -694,6 +694,10 @@ static const TypeInfo piix3_pci_type_info =3D {
     .instance_size =3D sizeof(PIIX3State),
     .abstract =3D true,
     .class_init =3D pci_piix3_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void piix3_class_init(ObjectClass *klass, void *data)
@@ -748,6 +752,10 @@ static const TypeInfo i440fx_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCII440FXState),
     .class_init    =3D i440fx_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 /* IGD Passthrough Host Bridge. */
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index becc0eeb76..39cd24464d 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -516,6 +516,10 @@ static const TypeInfo e500_host_bridge_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PPCE500PCIBridgeState),
     .class_init    =3D e500_host_bridge_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static Property pcihost_properties[] =3D {
diff --git a/hw/pci-host/prep.c b/hw/pci-host/prep.c
index 8b293ba0f1..92eed0f3e1 100644
--- a/hw/pci-host/prep.c
+++ b/hw/pci-host/prep.c
@@ -372,6 +372,10 @@ static const TypeInfo raven_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(RavenPCIState),
     .class_init =3D raven_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static Property raven_pcihost_properties[] =3D {
diff --git a/hw/pci-host/q35.c b/hw/pci-host/q35.c
index 1ff648e80c..ddaa7d1b44 100644
--- a/hw/pci-host/q35.c
+++ b/hw/pci-host/q35.c
@@ -591,6 +591,10 @@ static const TypeInfo mch_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(MCHPCIState),
     .class_init =3D mch_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void q35_register(void)
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index 6cf5e59f86..ea5c265718 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -374,6 +374,10 @@ static const TypeInfo unin_main_pci_host_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init =3D unin_main_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void u3_agp_pci_host_class_init(ObjectClass *klass, void *data)
@@ -398,6 +402,10 @@ static const TypeInfo u3_agp_pci_host_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init =3D u3_agp_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void unin_agp_pci_host_class_init(ObjectClass *klass, void *data)
@@ -422,6 +430,10 @@ static const TypeInfo unin_agp_pci_host_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init =3D unin_agp_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void unin_internal_pci_host_class_init(ObjectClass *klass, void *=
data)
@@ -446,6 +458,10 @@ static const TypeInfo unin_internal_pci_host_info =3D=
 {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init =3D unin_internal_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void pci_unin_main_class_init(ObjectClass *klass, void *data)
diff --git a/hw/pci-host/versatile.c b/hw/pci-host/versatile.c
index aa1fdf75fd..6394a520fc 100644
--- a/hw/pci-host/versatile.c
+++ b/hw/pci-host/versatile.c
@@ -487,6 +487,10 @@ static const TypeInfo versatile_pci_host_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init    =3D versatile_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static Property pci_vpb_properties[] =3D {
diff --git a/hw/ppc/ppc4xx_pci.c b/hw/ppc/ppc4xx_pci.c
index 6953f8b9ac..4765dcecca 100644
--- a/hw/ppc/ppc4xx_pci.c
+++ b/hw/ppc/ppc4xx_pci.c
@@ -359,6 +359,10 @@ static const TypeInfo ppc4xx_host_bridge_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init    =3D ppc4xx_host_bridge_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void ppc4xx_pcihost_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/esp-pci.c b/hw/scsi/esp-pci.c
index e295d88939..419fc668ac 100644
--- a/hw/scsi/esp-pci.c
+++ b/hw/scsi/esp-pci.c
@@ -398,6 +398,10 @@ static const TypeInfo esp_pci_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIESPState),
     .class_init =3D esp_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 typedef struct {
diff --git a/hw/scsi/lsi53c895a.c b/hw/scsi/lsi53c895a.c
index 3e56ab267c..423a2848ea 100644
--- a/hw/scsi/lsi53c895a.c
+++ b/hw/scsi/lsi53c895a.c
@@ -2244,6 +2244,10 @@ static const TypeInfo lsi_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(LSIState),
     .class_init    =3D lsi_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void lsi53c810_class_init(ObjectClass *klass, void *data)
diff --git a/hw/scsi/megasas.c b/hw/scsi/megasas.c
index 535ee267c3..d5eae6239a 100644
--- a/hw/scsi/megasas.c
+++ b/hw/scsi/megasas.c
@@ -2468,6 +2468,10 @@ static struct MegasasInfo megasas_devices[] =3D {
         .is_express =3D false,
         .vmsd =3D &vmstate_megasas_gen1,
         .props =3D megasas_properties_gen1,
+        .interfaces =3D (InterfaceInfo[]) {
+            { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+            { },
+        },
     },{
         .name =3D TYPE_MEGASAS_GEN2,
         .desc =3D "LSI MegaRAID SAS 2108",
diff --git a/hw/scsi/mptsas.c b/hw/scsi/mptsas.c
index d05fa9f549..f6db1b0103 100644
--- a/hw/scsi/mptsas.c
+++ b/hw/scsi/mptsas.c
@@ -1439,6 +1439,10 @@ static const TypeInfo mptsas_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(MPTSASState),
     .class_init =3D mptsas1068_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void mptsas_register_types(void)
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 6d6a791ee9..b064a087c9 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1315,6 +1315,10 @@ static const TypeInfo sdhci_pci_info =3D {
     .parent =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(SDHCIState),
     .class_init =3D sdhci_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static Property sdhci_sysbus_properties[] =3D {
diff --git a/hw/sh4/sh_pci.c b/hw/sh4/sh_pci.c
index 38395c082b..cbb01af57f 100644
--- a/hw/sh4/sh_pci.c
+++ b/hw/sh4/sh_pci.c
@@ -179,6 +179,10 @@ static const TypeInfo sh_pci_host_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(PCIDevice),
     .class_init    =3D sh_pci_host_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void sh_pci_device_class_init(ObjectClass *klass, void *data)
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index c3280aaf38..8282651aeb 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -275,6 +275,10 @@ static const TypeInfo ebus_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(EbusState),
     .class_init    =3D ebus_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 #define TYPE_OPENPROM "openprom"
diff --git a/hw/usb/hcd-ehci-pci.c b/hw/usb/hcd-ehci-pci.c
index 6dedcb8989..8c0fc53a26 100644
--- a/hw/usb/hcd-ehci-pci.c
+++ b/hw/usb/hcd-ehci-pci.c
@@ -170,6 +170,10 @@ static const TypeInfo ehci_pci_type_info =3D {
     .instance_finalize =3D usb_ehci_pci_finalize,
     .abstract =3D true,
     .class_init =3D ehci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void ehci_data_class_init(ObjectClass *klass, void *data)
diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
index 267982e160..a31df67daa 100644
--- a/hw/usb/hcd-ohci.c
+++ b/hw/usb/hcd-ohci.c
@@ -2139,6 +2139,10 @@ static const TypeInfo ohci_pci_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(OHCIPCIState),
     .class_init    =3D ohci_pci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static Property ohci_sysbus_properties[] =3D {
diff --git a/hw/usb/hcd-uhci.c b/hw/usb/hcd-uhci.c
index e3562a4c60..836b11f177 100644
--- a/hw/usb/hcd-uhci.c
+++ b/hw/usb/hcd-uhci.c
@@ -1323,6 +1323,10 @@ static const TypeInfo uhci_pci_type_info =3D {
     .class_size    =3D sizeof(UHCIPCIDeviceClass),
     .abstract =3D true,
     .class_init =3D uhci_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void uhci_data_class_init(ObjectClass *klass, void *data)
diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
index 349085ea12..2bd9d126d1 100644
--- a/hw/vfio/pci-quirks.c
+++ b/hw/vfio/pci-quirks.c
@@ -1197,6 +1197,10 @@ static TypeInfo vfio_pci_igd_lpc_bridge_info =3D {
     .name =3D "vfio-pci-igd-lpc-bridge",
     .parent =3D TYPE_PCI_DEVICE,
     .class_init =3D vfio_pci_igd_lpc_bridge_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void vfio_pci_igd_register_types(void)
diff --git a/hw/watchdog/wdt_i6300esb.c b/hw/watchdog/wdt_i6300esb.c
index 49b3cd188a..e596b0804d 100644
--- a/hw/watchdog/wdt_i6300esb.c
+++ b/hw/watchdog/wdt_i6300esb.c
@@ -463,6 +463,10 @@ static const TypeInfo i6300esb_info =3D {
     .parent        =3D TYPE_PCI_DEVICE,
     .instance_size =3D sizeof(I6300State),
     .class_init    =3D i6300esb_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void i6300esb_register_types(void)
diff --git a/hw/xen/xen_pt.c b/hw/xen/xen_pt.c
index 375efa68f6..01df3414d3 100644
--- a/hw/xen/xen_pt.c
+++ b/hw/xen/xen_pt.c
@@ -964,6 +964,10 @@ static const TypeInfo xen_pci_passthrough_info =3D {
     .instance_size =3D sizeof(XenPCIPassthroughState),
     .instance_finalize =3D xen_pci_passthrough_finalize,
     .class_init =3D xen_pci_passthrough_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
+        { INTERFACE_CONVENTIONAL_PCI_DEVICE },
+        { },
+    },
 };
=20
 static void xen_pci_passthrough_register_types(void)
--=20
2.13.5
