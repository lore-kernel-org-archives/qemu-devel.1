Received: from eggs.gnu.org ([209.51.188.92]:36176)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbMF-0004UN-Hm
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:31:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ghbM8-00069x-04
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41472)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ghbM4-00066q-6X
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:30:45 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 10 Jan 2019 12:29:53 -0200
Message-Id: <20190110142955.23254-9-ehabkost@redhat.com>
In-Reply-To: <20190110142955.23254-1-ehabkost@redhat.com>
References: <20190110142955.23254-1-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/10] machine: Use shorter format for
 GlobalProperty arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org

Instead of verbose arrays with 4 lines for each entry, make each
entry take only one line.  This makes long arrays that couldn't
fit in the screen become short and readable.

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190107193020.21744-4-ehabkost@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/i386/pc.h       |  18 +-
 hw/core/machine.c          | 338 ++++-------------
 hw/i386/pc.c               | 720 +++++++------------------------------
 hw/i386/pc_piix.c          | 192 ++--------
 hw/ppc/spapr.c             |  72 +---
 hw/s390x/s390-virtio-ccw.c |  75 +---
 hw/xen/xen-common.c        |  18 +-
 7 files changed, 265 insertions(+), 1168 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 84720bede9..0abbe45637 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -354,21 +354,9 @@ extern const size_t pc_compat_1_4_len;
  * depending on QEMU versions up to QEMU 2.4.
  */
 #define PC_CPU_MODEL_IDS(v) \
-    {\
-        .driver   =3D "qemu32-" TYPE_X86_CPU,\
-        .property =3D "model-id",\
-        .value    =3D "QEMU Virtual CPU version " v,\
-    },\
-    {\
-        .driver   =3D "qemu64-" TYPE_X86_CPU,\
-        .property =3D "model-id",\
-        .value    =3D "QEMU Virtual CPU version " v,\
-    },\
-    {\
-        .driver   =3D "athlon-" TYPE_X86_CPU,\
-        .property =3D "model-id",\
-        .value    =3D "QEMU Virtual CPU version " v,\
-    },
+    { "qemu32-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v,=
 },\
+    { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v,=
 },\
+    { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v,=
 },
=20
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *=
data) \
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4b4d6c23de..5530b71981 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,23 +24,10 @@
 #include "hw/pci/pci.h"
=20
 GlobalProperty hw_compat_3_1[] =3D {
-    {
-        .driver   =3D "pcie-root-port",
-        .property =3D "x-speed",
-        .value    =3D "2_5",
-    },{
-        .driver   =3D "pcie-root-port",
-        .property =3D "x-width",
-        .value    =3D "1",
-    },{
-        .driver   =3D "memory-backend-file",
-        .property =3D "x-use-canonical-path-for-ramblock-id",
-        .value    =3D "true",
-    },{
-        .driver   =3D "memory-backend-memfd",
-        .property =3D "x-use-canonical-path-for-ramblock-id",
-        .value    =3D "true",
-    },
+    { "pcie-root-port", "x-speed", "2_5" },
+    { "pcie-root-port", "x-width", "1" },
+    { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "tr=
ue" },
+    { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "t=
rue" },
 };
 const size_t hw_compat_3_1_len =3D G_N_ELEMENTS(hw_compat_3_1);
=20
@@ -48,269 +35,96 @@ GlobalProperty hw_compat_3_0[] =3D {};
 const size_t hw_compat_3_0_len =3D G_N_ELEMENTS(hw_compat_3_0);
=20
 GlobalProperty hw_compat_2_12[] =3D {
-    {
-        .driver   =3D "migration",
-        .property =3D "decompress-error-check",
-        .value    =3D "off",
-    },{
-        .driver   =3D "hda-audio",
-        .property =3D "use-timer",
-        .value    =3D "false",
-    },{
-        .driver   =3D "cirrus-vga",
-        .property =3D "global-vmstate",
-        .value    =3D "true",
-    },{
-        .driver   =3D "VGA",
-        .property =3D "global-vmstate",
-        .value    =3D "true",
-    },{
-        .driver   =3D "vmware-svga",
-        .property =3D "global-vmstate",
-        .value    =3D "true",
-    },{
-        .driver   =3D "qxl-vga",
-        .property =3D "global-vmstate",
-        .value    =3D "true",
-    },
+    { "migration", "decompress-error-check", "off" },
+    { "hda-audio", "use-timer", "false" },
+    { "cirrus-vga", "global-vmstate", "true" },
+    { "VGA", "global-vmstate", "true" },
+    { "vmware-svga", "global-vmstate", "true" },
+    { "qxl-vga", "global-vmstate", "true" },
 };
 const size_t hw_compat_2_12_len =3D G_N_ELEMENTS(hw_compat_2_12);
=20
 GlobalProperty hw_compat_2_11[] =3D {
-    {
-        .driver   =3D "hpet",
-        .property =3D "hpet-offset-saved",
-        .value    =3D "false",
-    },{
-        .driver   =3D "virtio-blk-pci",
-        .property =3D "vectors",
-        .value    =3D "2",
-    },{
-        .driver   =3D "vhost-user-blk-pci",
-        .property =3D "vectors",
-        .value    =3D "2",
-    },{
-        .driver   =3D "e1000",
-        .property =3D "migrate_tso_props",
-        .value    =3D "off",
-    },
+    { "hpet", "hpet-offset-saved", "false" },
+    { "virtio-blk-pci", "vectors", "2" },
+    { "vhost-user-blk-pci", "vectors", "2" },
+    { "e1000", "migrate_tso_props", "off" },
 };
 const size_t hw_compat_2_11_len =3D G_N_ELEMENTS(hw_compat_2_11);
=20
 GlobalProperty hw_compat_2_10[] =3D {
-    {
-        .driver   =3D "virtio-mouse-device",
-        .property =3D "wheel-axis",
-        .value    =3D "false",
-    },{
-        .driver   =3D "virtio-tablet-device",
-        .property =3D "wheel-axis",
-        .value    =3D "false",
-    },
+    { "virtio-mouse-device", "wheel-axis", "false" },
+    { "virtio-tablet-device", "wheel-axis", "false" },
 };
 const size_t hw_compat_2_10_len =3D G_N_ELEMENTS(hw_compat_2_10);
=20
 GlobalProperty hw_compat_2_9[] =3D {
-    {
-        .driver   =3D "pci-bridge",
-        .property =3D "shpc",
-        .value    =3D "off",
-    },{
-        .driver   =3D "intel-iommu",
-        .property =3D "pt",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-net-device",
-        .property =3D "x-mtu-bypass-backend",
-        .value    =3D "off",
-    },{
-        .driver   =3D "pcie-root-port",
-        .property =3D "x-migrate-msix",
-        .value    =3D "false",
-    },
+    { "pci-bridge", "shpc", "off" },
+    { "intel-iommu", "pt", "off" },
+    { "virtio-net-device", "x-mtu-bypass-backend", "off" },
+    { "pcie-root-port", "x-migrate-msix", "false" },
 };
 const size_t hw_compat_2_9_len =3D G_N_ELEMENTS(hw_compat_2_9);
=20
 GlobalProperty hw_compat_2_8[] =3D {
-    {
-        .driver   =3D "fw_cfg_mem",
-        .property =3D "x-file-slots",
-        .value    =3D "0x10",
-    },{
-        .driver   =3D "fw_cfg_io",
-        .property =3D "x-file-slots",
-        .value    =3D "0x10",
-    },{
-        .driver   =3D "pflash_cfi01",
-        .property =3D "old-multiple-chip-handling",
-        .value    =3D "on",
-    },{
-        .driver   =3D "pci-bridge",
-        .property =3D "shpc",
-        .value    =3D "on",
-    },{
-        .driver   =3D TYPE_PCI_DEVICE,
-        .property =3D "x-pcie-extcap-init",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "x-pcie-deverr-init",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "x-pcie-lnkctl-init",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "x-pcie-pm-init",
-        .value    =3D "off",
-    },{
-        .driver   =3D "cirrus-vga",
-        .property =3D "vgamem_mb",
-        .value    =3D "8",
-    },{
-        .driver   =3D "isa-cirrus-vga",
-        .property =3D "vgamem_mb",
-        .value    =3D "8",
-    },
+    { "fw_cfg_mem", "x-file-slots", "0x10" },
+    { "fw_cfg_io", "x-file-slots", "0x10" },
+    { "pflash_cfi01", "old-multiple-chip-handling", "on" },
+    { "pci-bridge", "shpc", "on" },
+    { TYPE_PCI_DEVICE, "x-pcie-extcap-init", "off" },
+    { "virtio-pci", "x-pcie-deverr-init", "off" },
+    { "virtio-pci", "x-pcie-lnkctl-init", "off" },
+    { "virtio-pci", "x-pcie-pm-init", "off" },
+    { "cirrus-vga", "vgamem_mb", "8" },
+    { "isa-cirrus-vga", "vgamem_mb", "8" },
 };
 const size_t hw_compat_2_8_len =3D G_N_ELEMENTS(hw_compat_2_8);
=20
 GlobalProperty hw_compat_2_7[] =3D {
-    {
-        .driver   =3D "virtio-pci",
-        .property =3D "page-per-vq",
-        .value    =3D "on",
-    },{
-        .driver   =3D "virtio-serial-device",
-        .property =3D "emergency-write",
-        .value    =3D "off",
-    },{
-        .driver   =3D "ioapic",
-        .property =3D "version",
-        .value    =3D "0x11",
-    },{
-        .driver   =3D "intel-iommu",
-        .property =3D "x-buggy-eim",
-        .value    =3D "true",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "x-ignore-backend-features",
-        .value    =3D "on",
-    },
+    { "virtio-pci", "page-per-vq", "on" },
+    { "virtio-serial-device", "emergency-write", "off" },
+    { "ioapic", "version", "0x11" },
+    { "intel-iommu", "x-buggy-eim", "true" },
+    { "virtio-pci", "x-ignore-backend-features", "on" },
 };
 const size_t hw_compat_2_7_len =3D G_N_ELEMENTS(hw_compat_2_7);
=20
 GlobalProperty hw_compat_2_6[] =3D {
-    {
-        .driver   =3D "virtio-mmio",
-        .property =3D "format_transport_address",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "disable-modern",
-        .value    =3D "on",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "disable-legacy",
-        .value    =3D "off",
-    },
+    { "virtio-mmio", "format_transport_address", "off" },
+    { "virtio-pci", "disable-modern", "on" },
+    { "virtio-pci", "disable-legacy", "off" },
 };
 const size_t hw_compat_2_6_len =3D G_N_ELEMENTS(hw_compat_2_6);
=20
 GlobalProperty hw_compat_2_5[] =3D {
-    {
-        .driver   =3D "isa-fdc",
-        .property =3D "fallback",
-        .value    =3D "144",
-    },{
-        .driver   =3D "pvscsi",
-        .property =3D "x-old-pci-configuration",
-        .value    =3D "on",
-    },{
-        .driver   =3D "pvscsi",
-        .property =3D "x-disable-pcie",
-        .value    =3D "on",
-    },
-    {
-        .driver   =3D "vmxnet3",
-        .property =3D "x-old-msi-offsets",
-        .value    =3D "on",
-    },{
-        .driver   =3D "vmxnet3",
-        .property =3D "x-disable-pcie",
-        .value    =3D "on",
-    },
+    { "isa-fdc", "fallback", "144" },
+    { "pvscsi", "x-old-pci-configuration", "on" },
+    { "pvscsi", "x-disable-pcie", "on" },
+    { "vmxnet3", "x-old-msi-offsets", "on" },
+    { "vmxnet3", "x-disable-pcie", "on" },
 };
 const size_t hw_compat_2_5_len =3D G_N_ELEMENTS(hw_compat_2_5);
=20
 GlobalProperty hw_compat_2_4[] =3D {
-    {
-        .driver   =3D "virtio-blk-device",
-        .property =3D "scsi",
-        .value    =3D "true",
-    },{
-        .driver   =3D "e1000",
-        .property =3D "extra_mac_registers",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "x-disable-pcie",
-        .value    =3D "on",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "migrate-extra",
-        .value    =3D "off",
-    },{
-        .driver   =3D "fw_cfg_mem",
-        .property =3D "dma_enabled",
-        .value    =3D "off",
-    },{
-        .driver   =3D "fw_cfg_io",
-        .property =3D "dma_enabled",
-        .value    =3D "off",
-    }
+    { "virtio-blk-device", "scsi", "true" },
+    { "e1000", "extra_mac_registers", "off" },
+    { "virtio-pci", "x-disable-pcie", "on" },
+    { "virtio-pci", "migrate-extra", "off" },
+    { "fw_cfg_mem", "dma_enabled", "off" },
+    { "fw_cfg_io", "dma_enabled", "off" }
 };
 const size_t hw_compat_2_4_len =3D G_N_ELEMENTS(hw_compat_2_4);
=20
 GlobalProperty hw_compat_2_3[] =3D {
-    {
-        .driver   =3D "virtio-blk-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-balloon-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-serial-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-9p-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-rng-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver   =3D TYPE_PCI_DEVICE,
-        .property =3D "x-pcie-lnksta-dllla",
-        .value    =3D "off",
-    },{
-        .driver   =3D "migration",
-        .property =3D "send-configuration",
-        .value    =3D "off",
-    },{
-        .driver   =3D "migration",
-        .property =3D "send-section-footer",
-        .value    =3D "off",
-    },{
-        .driver   =3D "migration",
-        .property =3D "store-global-state",
-        .value    =3D "off",
-    },
+    { "virtio-blk-pci", "any_layout", "off" },
+    { "virtio-balloon-pci", "any_layout", "off" },
+    { "virtio-serial-pci", "any_layout", "off" },
+    { "virtio-9p-pci", "any_layout", "off" },
+    { "virtio-rng-pci", "any_layout", "off" },
+    { TYPE_PCI_DEVICE, "x-pcie-lnksta-dllla", "off" },
+    { "migration", "send-configuration", "off" },
+    { "migration", "send-section-footer", "off" },
+    { "migration", "store-global-state", "off" },
 };
 const size_t hw_compat_2_3_len =3D G_N_ELEMENTS(hw_compat_2_3);
=20
@@ -318,35 +132,13 @@ GlobalProperty hw_compat_2_2[] =3D {};
 const size_t hw_compat_2_2_len =3D G_N_ELEMENTS(hw_compat_2_2);
=20
 GlobalProperty hw_compat_2_1[] =3D {
-    {
-        .driver   =3D "intel-hda",
-        .property =3D "old_msi_addr",
-        .value    =3D "on",
-    },{
-        .driver   =3D "VGA",
-        .property =3D "qemu-extended-regs",
-        .value    =3D "off",
-    },{
-        .driver   =3D "secondary-vga",
-        .property =3D "qemu-extended-regs",
-        .value    =3D "off",
-    },{
-        .driver   =3D "virtio-scsi-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver   =3D "usb-mouse",
-        .property =3D "usb_version",
-        .value    =3D "1",
-    },{
-        .driver   =3D "usb-kbd",
-        .property =3D "usb_version",
-        .value    =3D "1",
-    },{
-        .driver   =3D "virtio-pci",
-        .property =3D "virtio-pci-bus-master-bug-migration",
-        .value    =3D "on",
-    },
+    { "intel-hda", "old_msi_addr", "on" },
+    { "VGA", "qemu-extended-regs", "off" },
+    { "secondary-vga", "qemu-extended-regs", "off" },
+    { "virtio-scsi-pci", "any_layout", "off" },
+    { "usb-mouse", "usb_version", "1" },
+    { "usb-kbd", "usb_version", "1" },
+    { "virtio-pci", "virtio-pci-bus-master-bug-migration", "on" },
 };
 const size_t hw_compat_2_1_len =3D G_N_ELEMENTS(hw_compat_2_1);
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ff14b6d4df..f238424499 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -111,174 +111,67 @@ static unsigned e820_entries;
 struct hpet_fw_config hpet_cfg =3D {.count =3D UINT8_MAX};
=20
 GlobalProperty pc_compat_3_1[] =3D {
-    {
-        .driver   =3D "intel-iommu",
-        .property =3D "dma-drain",
-        .value    =3D "off",
-    },
+    { "intel-iommu", "dma-drain", "off" },
 };
 const size_t pc_compat_3_1_len =3D G_N_ELEMENTS(pc_compat_3_1);
=20
 GlobalProperty pc_compat_3_0[] =3D {
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "x-hv-synic-kvm-only",
-        .value    =3D "on",
-    },{
-        .driver   =3D "Skylake-Server" "-" TYPE_X86_CPU,
-        .property =3D "pku",
-        .value    =3D "off",
-    },{
-        .driver   =3D "Skylake-Server-IBRS" "-" TYPE_X86_CPU,
-        .property =3D "pku",
-        .value    =3D "off",
-    },
+    { TYPE_X86_CPU, "x-hv-synic-kvm-only", "on" },
+    { "Skylake-Server" "-" TYPE_X86_CPU, "pku", "off" },
+    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "pku", "off" },
 };
 const size_t pc_compat_3_0_len =3D G_N_ELEMENTS(pc_compat_3_0);
=20
 GlobalProperty pc_compat_2_12[] =3D {
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "legacy-cache",
-        .value    =3D "on",
-    },{
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "topoext",
-        .value    =3D "off",
-    },{
-        .driver   =3D "EPYC-" TYPE_X86_CPU,
-        .property =3D "xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "EPYC-IBPB-" TYPE_X86_CPU,
-        .property =3D "xlevel",
-        .value    =3D "0x8000000a",
-    },
+    { TYPE_X86_CPU, "legacy-cache", "on" },
+    { TYPE_X86_CPU, "topoext", "off" },
+    { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
+    { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
 };
 const size_t pc_compat_2_12_len =3D G_N_ELEMENTS(pc_compat_2_12);
=20
 GlobalProperty pc_compat_2_11[] =3D {
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "x-migrate-smi-count",
-        .value    =3D "off",
-    },{
-        .driver   =3D "Skylake-Server" "-" TYPE_X86_CPU,
-        .property =3D "clflushopt",
-        .value    =3D "off",
-    },
+    { TYPE_X86_CPU, "x-migrate-smi-count", "off" },
+    { "Skylake-Server" "-" TYPE_X86_CPU, "clflushopt", "off" },
 };
 const size_t pc_compat_2_11_len =3D G_N_ELEMENTS(pc_compat_2_11);
=20
 GlobalProperty pc_compat_2_10[] =3D {
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "x-hv-max-vps",
-        .value    =3D "0x40",
-    },{
-        .driver   =3D "i440FX-pcihost",
-        .property =3D "x-pci-hole64-fix",
-        .value    =3D "off",
-    },{
-        .driver   =3D "q35-pcihost",
-        .property =3D "x-pci-hole64-fix",
-        .value    =3D "off",
-    },
+    { TYPE_X86_CPU, "x-hv-max-vps", "0x40" },
+    { "i440FX-pcihost", "x-pci-hole64-fix", "off" },
+    { "q35-pcihost", "x-pci-hole64-fix", "off" },
 };
 const size_t pc_compat_2_10_len =3D G_N_ELEMENTS(pc_compat_2_10);
=20
 GlobalProperty pc_compat_2_9[] =3D {
-    {
-        .driver   =3D "mch",
-        .property =3D "extended-tseg-mbytes",
-        .value    =3D "0",
-    },
+    { "mch", "extended-tseg-mbytes", "0" },
 };
 const size_t pc_compat_2_9_len =3D G_N_ELEMENTS(pc_compat_2_9);
=20
 GlobalProperty pc_compat_2_8[] =3D {
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "tcg-cpuid",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "kvmclock",
-        .property =3D "x-mach-use-reliable-get-clock",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "ICH9-LPC",
-        .property =3D "x-smi-broadcast",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "vmware-cpuid-freq",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "Haswell-" TYPE_X86_CPU,
-        .property =3D "stepping",
-        .value    =3D "1",
-    },
+    { TYPE_X86_CPU, "tcg-cpuid", "off" },
+    { "kvmclock", "x-mach-use-reliable-get-clock", "off" },
+    { "ICH9-LPC", "x-smi-broadcast", "off" },
+    { TYPE_X86_CPU, "vmware-cpuid-freq", "off" },
+    { "Haswell-" TYPE_X86_CPU, "stepping", "1" },
 };
 const size_t pc_compat_2_8_len =3D G_N_ELEMENTS(pc_compat_2_8);
=20
 GlobalProperty pc_compat_2_7[] =3D {
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "l3-cache",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "full-cpuid-auto-level",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
-        .property =3D "family",
-        .value    =3D "15",
-    },
-    {
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
-        .property =3D "model",
-        .value    =3D "6",
-    },
-    {
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
-        .property =3D "stepping",
-        .value    =3D "1",
-    },
-    {
-        .driver   =3D "isa-pcspk",
-        .property =3D "migrate",
-        .value    =3D "off",
-    },
+    { TYPE_X86_CPU, "l3-cache", "off" },
+    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
+    { "isa-pcspk", "migrate", "off" },
 };
 const size_t pc_compat_2_7_len =3D G_N_ELEMENTS(pc_compat_2_7);
=20
 GlobalProperty pc_compat_2_6[] =3D {
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "cpuid-0xb",
-        .value    =3D "off",
-    },{
-        .driver   =3D "vmxnet3",
-        .property =3D "romfile",
-        .value    =3D "",
-    },
-    {
-        .driver =3D TYPE_X86_CPU,
-        .property =3D "fill-mtrr-mask",
-        .value =3D "off",
-    },
-    {
-        .driver   =3D "apic-common",
-        .property =3D "legacy-instance-id",
-        .value    =3D "on",
-    }
+    { TYPE_X86_CPU, "cpuid-0xb", "off" },
+    { "vmxnet3", "romfile", "" },
+    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
+    { "apic-common", "legacy-instance-id", "on", }
 };
 const size_t pc_compat_2_6_len =3D G_N_ELEMENTS(pc_compat_2_6);
=20
@@ -287,499 +180,148 @@ const size_t pc_compat_2_5_len =3D G_N_ELEMENTS(p=
c_compat_2_5);
=20
 GlobalProperty pc_compat_2_4[] =3D {
     PC_CPU_MODEL_IDS("2.4.0")
-    {
-        .driver   =3D "Haswell-" TYPE_X86_CPU,
-        .property =3D "abm",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "Haswell-noTSX-" TYPE_X86_CPU,
-        .property =3D "abm",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "Broadwell-" TYPE_X86_CPU,
-        .property =3D "abm",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "Broadwell-noTSX-" TYPE_X86_CPU,
-        .property =3D "abm",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "host" "-" TYPE_X86_CPU,
-        .property =3D "host-cache-info",
-        .value    =3D "on",
-    },
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "check",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
-        .property =3D "sse4a",
-        .value    =3D "on",
-    },
-    {
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
-        .property =3D "abm",
-        .value    =3D "on",
-    },
-    {
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
-        .property =3D "popcnt",
-        .value    =3D "on",
-    },
-    {
-        .driver   =3D "qemu32" "-" TYPE_X86_CPU,
-        .property =3D "popcnt",
-        .value    =3D "on",
-    },{
-        .driver   =3D "Opteron_G2" "-" TYPE_X86_CPU,
-        .property =3D "rdtscp",
-        .value    =3D "on",
-    },{
-        .driver   =3D "Opteron_G3" "-" TYPE_X86_CPU,
-        .property =3D "rdtscp",
-        .value    =3D "on",
-    },{
-        .driver   =3D "Opteron_G4" "-" TYPE_X86_CPU,
-        .property =3D "rdtscp",
-        .value    =3D "on",
-    },{
-        .driver   =3D "Opteron_G5" "-" TYPE_X86_CPU,
-        .property =3D "rdtscp",
-        .value    =3D "on",
-    }
+    { "Haswell-" TYPE_X86_CPU, "abm", "off" },
+    { "Haswell-noTSX-" TYPE_X86_CPU, "abm", "off" },
+    { "Broadwell-" TYPE_X86_CPU, "abm", "off" },
+    { "Broadwell-noTSX-" TYPE_X86_CPU, "abm", "off" },
+    { "host" "-" TYPE_X86_CPU, "host-cache-info", "on" },
+    { TYPE_X86_CPU, "check", "off" },
+    { "qemu64" "-" TYPE_X86_CPU, "sse4a", "on" },
+    { "qemu64" "-" TYPE_X86_CPU, "abm", "on" },
+    { "qemu64" "-" TYPE_X86_CPU, "popcnt", "on" },
+    { "qemu32" "-" TYPE_X86_CPU, "popcnt", "on" },
+    { "Opteron_G2" "-" TYPE_X86_CPU, "rdtscp", "on" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "rdtscp", "on" },
+    { "Opteron_G4" "-" TYPE_X86_CPU, "rdtscp", "on" },
+    { "Opteron_G5" "-" TYPE_X86_CPU, "rdtscp", "on", }
 };
 const size_t pc_compat_2_4_len =3D G_N_ELEMENTS(pc_compat_2_4);
=20
 GlobalProperty pc_compat_2_3[] =3D {
     PC_CPU_MODEL_IDS("2.3.0")
-    {
-        .driver   =3D TYPE_X86_CPU,
-        .property =3D "arat",
-        .value    =3D "off",
-    },{
-        .driver   =3D "qemu64" "-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "4",
-    },{
-        .driver   =3D "kvm64" "-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "5",
-    },{
-        .driver   =3D "pentium3" "-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "2",
-    },{
-        .driver   =3D "n270" "-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "5",
-    },{
-        .driver   =3D "Conroe" "-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "4",
-    },{
-        .driver   =3D "Penryn" "-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "4",
-    },{
-        .driver   =3D "Nehalem" "-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "4",
-    },{
-        .driver   =3D "n270" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Penryn" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Conroe" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Nehalem" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Westmere" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "SandyBridge" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "IvyBridge" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Haswell" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Haswell-noTSX" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Broadwell" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver   =3D "Broadwell-noTSX" "-" TYPE_X86_CPU,
-        .property =3D "min-xlevel",
-        .value    =3D "0x8000000a",
-    },{
-        .driver =3D TYPE_X86_CPU,
-        .property =3D "kvm-no-smi-migration",
-        .value    =3D "on",
-    },
+    { TYPE_X86_CPU, "arat", "off" },
+    { "qemu64" "-" TYPE_X86_CPU, "min-level", "4" },
+    { "kvm64" "-" TYPE_X86_CPU, "min-level", "5" },
+    { "pentium3" "-" TYPE_X86_CPU, "min-level", "2" },
+    { "n270" "-" TYPE_X86_CPU, "min-level", "5" },
+    { "Conroe" "-" TYPE_X86_CPU, "min-level", "4" },
+    { "Penryn" "-" TYPE_X86_CPU, "min-level", "4" },
+    { "Nehalem" "-" TYPE_X86_CPU, "min-level", "4" },
+    { "n270" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Penryn" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Conroe" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Nehalem" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Westmere" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "SandyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "IvyBridge" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Haswell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Haswell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Broadwell" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { "Broadwell-noTSX" "-" TYPE_X86_CPU, "min-xlevel", "0x8000000a" },
+    { TYPE_X86_CPU, "kvm-no-smi-migration", "on" },
 };
 const size_t pc_compat_2_3_len =3D G_N_ELEMENTS(pc_compat_2_3);
=20
 GlobalProperty pc_compat_2_2[] =3D {
     PC_CPU_MODEL_IDS("2.2.0")
-    {
-        .driver =3D "kvm64" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "kvm32" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Conroe" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Penryn" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Nehalem" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Westmere" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "SandyBridge" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Haswell" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Broadwell" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Opteron_G1" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Opteron_G2" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Opteron_G3" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Opteron_G4" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Opteron_G5" "-" TYPE_X86_CPU,
-        .property =3D "vme",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Haswell" "-" TYPE_X86_CPU,
-        .property =3D "f16c",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Haswell" "-" TYPE_X86_CPU,
-        .property =3D "rdrand",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Broadwell" "-" TYPE_X86_CPU,
-        .property =3D "f16c",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Broadwell" "-" TYPE_X86_CPU,
-        .property =3D "rdrand",
-        .value =3D "off",
-    },
+    { "kvm64" "-" TYPE_X86_CPU, "vme", "off" },
+    { "kvm32" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Conroe" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Penryn" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Nehalem" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Westmere" "-" TYPE_X86_CPU, "vme", "off" },
+    { "SandyBridge" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Haswell" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Broadwell" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Opteron_G1" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Opteron_G2" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Opteron_G4" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Opteron_G5" "-" TYPE_X86_CPU, "vme", "off" },
+    { "Haswell" "-" TYPE_X86_CPU, "f16c", "off" },
+    { "Haswell" "-" TYPE_X86_CPU, "rdrand", "off" },
+    { "Broadwell" "-" TYPE_X86_CPU, "f16c", "off" },
+    { "Broadwell" "-" TYPE_X86_CPU, "rdrand", "off" },
 };
 const size_t pc_compat_2_2_len =3D G_N_ELEMENTS(pc_compat_2_2);
=20
 GlobalProperty pc_compat_2_1[] =3D {
     PC_CPU_MODEL_IDS("2.1.0")
-    {
-        .driver =3D "coreduo" "-" TYPE_X86_CPU,
-        .property =3D "vmx",
-        .value =3D "on",
-    },
-    {
-        .driver =3D "core2duo" "-" TYPE_X86_CPU,
-        .property =3D "vmx",
-        .value =3D "on",
-    },
+    { "coreduo" "-" TYPE_X86_CPU, "vmx", "on" },
+    { "core2duo" "-" TYPE_X86_CPU, "vmx", "on" },
 };
 const size_t pc_compat_2_1_len =3D G_N_ELEMENTS(pc_compat_2_1);
=20
 GlobalProperty pc_compat_2_0[] =3D {
     PC_CPU_MODEL_IDS("2.0.0")
-    {
-        .driver   =3D "virtio-scsi-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver   =3D "PIIX4_PM",
-        .property =3D "memory-hotplug-support",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "apic",
-        .property =3D "version",
-        .value    =3D "0x11",
-    },
-    {
-        .driver   =3D "nec-usb-xhci",
-        .property =3D "superspeed-ports-first",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "nec-usb-xhci",
-        .property =3D "force-pcie-endcap",
-        .value    =3D "on",
-    },
-    {
-        .driver   =3D "pci-serial",
-        .property =3D "prog_if",
-        .value    =3D "0",
-    },
-    {
-        .driver   =3D "pci-serial-2x",
-        .property =3D "prog_if",
-        .value    =3D "0",
-    },
-    {
-        .driver   =3D "pci-serial-4x",
-        .property =3D "prog_if",
-        .value    =3D "0",
-    },
-    {
-        .driver   =3D "virtio-net-pci",
-        .property =3D "guest_announce",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "ICH9-LPC",
-        .property =3D "memory-hotplug-support",
-        .value    =3D "off",
-    },{
-        .driver   =3D "xio3130-downstream",
-        .property =3D COMPAT_PROP_PCP,
-        .value    =3D "off",
-    },{
-        .driver   =3D "ioh3420",
-        .property =3D COMPAT_PROP_PCP,
-        .value    =3D "off",
-    },
+    { "virtio-scsi-pci", "any_layout", "off" },
+    { "PIIX4_PM", "memory-hotplug-support", "off" },
+    { "apic", "version", "0x11" },
+    { "nec-usb-xhci", "superspeed-ports-first", "off" },
+    { "nec-usb-xhci", "force-pcie-endcap", "on" },
+    { "pci-serial", "prog_if", "0" },
+    { "pci-serial-2x", "prog_if", "0" },
+    { "pci-serial-4x", "prog_if", "0" },
+    { "virtio-net-pci", "guest_announce", "off" },
+    { "ICH9-LPC", "memory-hotplug-support", "off" },
+    { "xio3130-downstream", COMPAT_PROP_PCP, "off" },
+    { "ioh3420", COMPAT_PROP_PCP, "off" },
 };
 const size_t pc_compat_2_0_len =3D G_N_ELEMENTS(pc_compat_2_0);
=20
 GlobalProperty pc_compat_1_7[] =3D {
     PC_CPU_MODEL_IDS("1.7.0")
-    {
-        .driver   =3D TYPE_USB_DEVICE,
-        .property =3D "msos-desc",
-        .value    =3D "no",
-    },
-    {
-        .driver   =3D "PIIX4_PM",
-        .property =3D "acpi-pci-hotplug-with-bridge-support",
-        .value    =3D "off",
-    },
-    {
-        .driver   =3D "hpet",
-        .property =3D HPET_INTCAP,
-        .value    =3D "4",
-    },
+    { TYPE_USB_DEVICE, "msos-desc", "no" },
+    { "PIIX4_PM", "acpi-pci-hotplug-with-bridge-support", "off" },
+    { "hpet", HPET_INTCAP, "4" },
 };
 const size_t pc_compat_1_7_len =3D G_N_ELEMENTS(pc_compat_1_7);
=20
 GlobalProperty pc_compat_1_6[] =3D {
     PC_CPU_MODEL_IDS("1.6.0")
-    {
-        .driver   =3D "e1000",
-        .property =3D "mitigation",
-        .value    =3D "off",
-    },{
-        .driver   =3D "qemu64-" TYPE_X86_CPU,
-        .property =3D "model",
-        .value    =3D "2",
-    },{
-        .driver   =3D "qemu32-" TYPE_X86_CPU,
-        .property =3D "model",
-        .value    =3D "3",
-    },{
-        .driver   =3D "i440FX-pcihost",
-        .property =3D "short_root_bus",
-        .value    =3D "1",
-    },{
-        .driver   =3D "q35-pcihost",
-        .property =3D "short_root_bus",
-        .value    =3D "1",
-    },
+    { "e1000", "mitigation", "off" },
+    { "qemu64-" TYPE_X86_CPU, "model", "2" },
+    { "qemu32-" TYPE_X86_CPU, "model", "3" },
+    { "i440FX-pcihost", "short_root_bus", "1" },
+    { "q35-pcihost", "short_root_bus", "1" },
 };
 const size_t pc_compat_1_6_len =3D G_N_ELEMENTS(pc_compat_1_6);
=20
 GlobalProperty pc_compat_1_5[] =3D {
     PC_CPU_MODEL_IDS("1.5.0")
-    {
-        .driver   =3D "Conroe-" TYPE_X86_CPU,
-        .property =3D "model",
-        .value    =3D "2",
-    },{
-        .driver   =3D "Conroe-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "2",
-    },{
-        .driver   =3D "Penryn-" TYPE_X86_CPU,
-        .property =3D "model",
-        .value    =3D "2",
-    },{
-        .driver   =3D "Penryn-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "2",
-    },{
-        .driver   =3D "Nehalem-" TYPE_X86_CPU,
-        .property =3D "model",
-        .value    =3D "2",
-    },{
-        .driver   =3D "Nehalem-" TYPE_X86_CPU,
-        .property =3D "min-level",
-        .value    =3D "2",
-    },{
-        .driver   =3D "virtio-net-pci",
-        .property =3D "any_layout",
-        .value    =3D "off",
-    },{
-        .driver =3D TYPE_X86_CPU,
-        .property =3D "pmu",
-        .value =3D "on",
-    },{
-        .driver   =3D "i440FX-pcihost",
-        .property =3D "short_root_bus",
-        .value    =3D "0",
-    },{
-        .driver   =3D "q35-pcihost",
-        .property =3D "short_root_bus",
-        .value    =3D "0",
-    },
+    { "Conroe-" TYPE_X86_CPU, "model", "2" },
+    { "Conroe-" TYPE_X86_CPU, "min-level", "2" },
+    { "Penryn-" TYPE_X86_CPU, "model", "2" },
+    { "Penryn-" TYPE_X86_CPU, "min-level", "2" },
+    { "Nehalem-" TYPE_X86_CPU, "model", "2" },
+    { "Nehalem-" TYPE_X86_CPU, "min-level", "2" },
+    { "virtio-net-pci", "any_layout", "off" },
+    { TYPE_X86_CPU, "pmu", "on" },
+    { "i440FX-pcihost", "short_root_bus", "0" },
+    { "q35-pcihost", "short_root_bus", "0" },
 };
 const size_t pc_compat_1_5_len =3D G_N_ELEMENTS(pc_compat_1_5);
=20
 GlobalProperty pc_compat_1_4[] =3D {
     PC_CPU_MODEL_IDS("1.4.0")
-    {
-        .driver   =3D "scsi-hd",
-        .property =3D "discard_granularity",
-        .value    =3D "0",
-    },{
-        .driver   =3D "scsi-cd",
-        .property =3D "discard_granularity",
-        .value    =3D "0",
-    },{
-        .driver   =3D "scsi-disk",
-        .property =3D "discard_granularity",
-        .value    =3D "0",
-    },{
-        .driver   =3D "ide-hd",
-        .property =3D "discard_granularity",
-        .value    =3D "0",
-    },{
-        .driver   =3D "ide-cd",
-        .property =3D "discard_granularity",
-        .value    =3D "0",
-    },{
-        .driver   =3D "ide-drive",
-        .property =3D "discard_granularity",
-        .value    =3D "0",
-    },{
-        .driver   =3D "virtio-blk-pci",
-        .property =3D "discard_granularity",
-        .value    =3D "0",
-    },{
-        .driver   =3D "virtio-serial-pci",
-        .property =3D "vectors",
-        /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */
-        .value    =3D "0xFFFFFFFF",
-    },{
-        .driver   =3D "virtio-net-pci",
-        .property =3D "ctrl_guest_offloads",
-        .value    =3D "off",
-    },{
-        .driver   =3D "e1000",
-        .property =3D "romfile",
-        .value    =3D "pxe-e1000.rom",
-    },{
-        .driver   =3D "ne2k_pci",
-        .property =3D "romfile",
-        .value    =3D "pxe-ne2k_pci.rom",
-    },{
-        .driver   =3D "pcnet",
-        .property =3D "romfile",
-        .value    =3D "pxe-pcnet.rom",
-    },{
-        .driver   =3D "rtl8139",
-        .property =3D "romfile",
-        .value    =3D "pxe-rtl8139.rom",
-    },{
-        .driver   =3D "virtio-net-pci",
-        .property =3D "romfile",
-        .value    =3D "pxe-virtio.rom",
-    },{
-        .driver   =3D "486-" TYPE_X86_CPU,
-        .property =3D "model",
-        .value    =3D "0",
-    },
-    {
-        .driver =3D "n270" "-" TYPE_X86_CPU,
-        .property =3D "movbe",
-        .value =3D "off",
-    },
-    {
-        .driver =3D "Westmere" "-" TYPE_X86_CPU,
-        .property =3D "pclmulqdq",
-        .value =3D "off",
-    },
+    { "scsi-hd", "discard_granularity", "0" },
+    { "scsi-cd", "discard_granularity", "0" },
+    { "scsi-disk", "discard_granularity", "0" },
+    { "ide-hd", "discard_granularity", "0" },
+    { "ide-cd", "discard_granularity", "0" },
+    { "ide-drive", "discard_granularity", "0" },
+    { "virtio-blk-pci", "discard_granularity", "0" },
+    /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string: */
+    { "virtio-serial-pci", "vectors", "0xFFFFFFFF" },
+    { "virtio-net-pci", "ctrl_guest_offloads", "off" },
+    { "e1000", "romfile", "pxe-e1000.rom" },
+    { "ne2k_pci", "romfile", "pxe-ne2k_pci.rom" },
+    { "pcnet", "romfile", "pxe-pcnet.rom" },
+    { "rtl8139", "romfile", "pxe-rtl8139.rom" },
+    { "virtio-net-pci", "romfile", "pxe-virtio.rom" },
+    { "486-" TYPE_X86_CPU, "model", "0" },
+    { "n270" "-" TYPE_X86_CPU, "movbe", "off" },
+    { "Westmere" "-" TYPE_X86_CPU, "pclmulqdq", "off" },
 };
 const size_t pc_compat_1_4_len =3D G_N_ELEMENTS(pc_compat_1_4);
=20
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fd20227af3..5088e2f492 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -694,23 +694,10 @@ static void pc_i440fx_1_3_machine_options(MachineCl=
ass *m)
 {
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("1.3.0")
-        {
-            .driver   =3D "usb-tablet",
-            .property =3D "usb_version",
-            .value    =3D "1",
-        },{
-            .driver   =3D "virtio-net-pci",
-            .property =3D "ctrl_mac_addr",
-            .value    =3D "off",
-        },{
-            .driver   =3D "virtio-net-pci",
-            .property =3D "mq",
-            .value    =3D "off",
-        }, {
-            .driver   =3D "e1000",
-            .property =3D "autonegotiation",
-            .value    =3D "off",
-        },
+        { "usb-tablet", "usb_version", "1" },
+        { "virtio-net-pci", "ctrl_mac_addr", "off" },
+        { "virtio-net-pci", "mq", "off" },
+        { "e1000", "autonegotiation", "off" },
     };
=20
     pc_i440fx_1_4_machine_options(m);
@@ -726,31 +713,12 @@ static void pc_i440fx_1_2_machine_options(MachineCl=
ass *m)
 {
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("1.2.0")
-        {
-            .driver   =3D "nec-usb-xhci",
-            .property =3D "msi",
-            .value    =3D "off",
-        },{
-            .driver   =3D "nec-usb-xhci",
-            .property =3D "msix",
-            .value    =3D "off",
-        },{
-            .driver   =3D "ivshmem",
-            .property =3D "use64",
-            .value    =3D "0",
-        },{
-            .driver   =3D "qxl",
-            .property =3D "revision",
-            .value    =3D "3",
-        },{
-            .driver   =3D "qxl-vga",
-            .property =3D "revision",
-            .value    =3D "3",
-        },{
-            .driver   =3D "VGA",
-            .property =3D "mmio",
-            .value    =3D "off",
-        },
+        { "nec-usb-xhci", "msi", "off" },
+        { "nec-usb-xhci", "msix", "off" },
+        { "ivshmem", "use64", "0" },
+        { "qxl", "revision", "3" },
+        { "qxl-vga", "revision", "3" },
+        { "VGA", "mmio", "off" },
     };
=20
     pc_i440fx_1_3_machine_options(m);
@@ -766,35 +734,13 @@ static void pc_i440fx_1_1_machine_options(MachineCl=
ass *m)
 {
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("1.1.0")
-        {
-            .driver   =3D "virtio-scsi-pci",
-            .property =3D "hotplug",
-            .value    =3D "off",
-        },{
-            .driver   =3D "virtio-scsi-pci",
-            .property =3D "param_change",
-            .value    =3D "off",
-        },{
-            .driver   =3D "VGA",
-            .property =3D "vgamem_mb",
-            .value    =3D "8",
-        },{
-            .driver   =3D "vmware-svga",
-            .property =3D "vgamem_mb",
-            .value    =3D "8",
-        },{
-            .driver   =3D "qxl-vga",
-            .property =3D "vgamem_mb",
-            .value    =3D "8",
-        },{
-            .driver   =3D "qxl",
-            .property =3D "vgamem_mb",
-            .value    =3D "8",
-        },{
-            .driver   =3D "virtio-blk-pci",
-            .property =3D "config-wce",
-            .value    =3D "off",
-        },
+        { "virtio-scsi-pci", "hotplug", "off" },
+        { "virtio-scsi-pci", "param_change", "off" },
+        { "VGA", "vgamem_mb", "8" },
+        { "vmware-svga", "vgamem_mb", "8" },
+        { "qxl-vga", "vgamem_mb", "8" },
+        { "qxl", "vgamem_mb", "8" },
+        { "virtio-blk-pci", "config-wce", "off" },
     };
=20
     pc_i440fx_1_2_machine_options(m);
@@ -809,23 +755,10 @@ static void pc_i440fx_1_0_machine_options(MachineCl=
ass *m)
 {
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("1.0")
-        {
-            .driver   =3D TYPE_ISA_FDC,
-            .property =3D "check_media_rate",
-            .value    =3D "off",
-        },{
-            .driver   =3D "virtio-balloon-pci",
-            .property =3D "class",
-            .value    =3D stringify(PCI_CLASS_MEMORY_RAM),
-        },{
-            .driver   =3D "apic-common",
-            .property =3D "vapic",
-            .value    =3D "off",
-        },{
-            .driver   =3D TYPE_USB_DEVICE,
-            .property =3D "full-path",
-            .value    =3D "no",
-        },
+        { TYPE_ISA_FDC, "check_media_rate", "off" },
+        { "virtio-balloon-pci", "class", stringify(PCI_CLASS_MEMORY_RAM)=
 },
+        { "apic-common", "vapic", "off" },
+        { TYPE_USB_DEVICE, "full-path", "no" },
     };
=20
     pc_i440fx_1_1_machine_options(m);
@@ -857,31 +790,12 @@ static void pc_i440fx_0_14_machine_options(MachineC=
lass *m)
 {
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("0.14")
-        {
-            .driver   =3D "virtio-blk-pci",
-            .property =3D "event_idx",
-            .value    =3D "off",
-        },{
-            .driver   =3D "virtio-serial-pci",
-            .property =3D "event_idx",
-            .value    =3D "off",
-        },{
-            .driver   =3D "virtio-net-pci",
-            .property =3D "event_idx",
-            .value    =3D "off",
-        },{
-            .driver   =3D "virtio-balloon-pci",
-            .property =3D "event_idx",
-            .value    =3D "off",
-        },{
-            .driver   =3D "qxl",
-            .property =3D "revision",
-            .value    =3D "2",
-        },{
-            .driver   =3D "qxl-vga",
-            .property =3D "revision",
-            .value    =3D "2",
-        },
+        { "virtio-blk-pci", "event_idx", "off" },
+        { "virtio-serial-pci", "event_idx", "off" },
+        { "virtio-net-pci", "event_idx", "off" },
+        { "virtio-balloon-pci", "event_idx", "off" },
+        { "qxl", "revision", "2" },
+        { "qxl-vga", "revision", "2" },
     };
=20
     pc_i440fx_0_15_machine_options(m);
@@ -897,27 +811,11 @@ static void pc_i440fx_0_13_machine_options(MachineC=
lass *m)
     PCMachineClass *pcmc =3D PC_MACHINE_CLASS(m);
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("0.13")
-        {
-            .driver   =3D TYPE_PCI_DEVICE,
-            .property =3D "command_serr_enable",
-            .value    =3D "off",
-        },{
-            .driver   =3D "AC97",
-            .property =3D "use_broken_id",
-            .value    =3D "1",
-        },{
-            .driver   =3D "virtio-9p-pci",
-            .property =3D "vectors",
-            .value    =3D "0",
-        },{
-            .driver   =3D "VGA",
-            .property =3D "rombar",
-            .value    =3D "0",
-        },{
-            .driver   =3D "vmware-svga",
-            .property =3D "rombar",
-            .value    =3D "0",
-        },
+        { TYPE_PCI_DEVICE, "command_serr_enable", "off" },
+        { "AC97", "use_broken_id", "1" },
+        { "virtio-9p-pci", "vectors", "0" },
+        { "VGA", "rombar", "0" },
+        { "vmware-svga", "rombar", "0" },
     };
=20
     pc_i440fx_0_14_machine_options(m);
@@ -933,27 +831,11 @@ static void pc_i440fx_0_12_machine_options(MachineC=
lass *m)
 {
     static GlobalProperty compat[] =3D {
         PC_CPU_MODEL_IDS("0.12")
-        {
-            .driver   =3D "virtio-serial-pci",
-            .property =3D "max_ports",
-            .value    =3D "1",
-        },{
-            .driver   =3D "virtio-serial-pci",
-            .property =3D "vectors",
-            .value    =3D "0",
-        },{
-            .driver   =3D "usb-mouse",
-            .property =3D "serial",
-            .value    =3D "1",
-        },{
-            .driver   =3D "usb-tablet",
-            .property =3D "serial",
-            .value    =3D "1",
-        },{
-            .driver   =3D "usb-kbd",
-            .property =3D "serial",
-            .value    =3D "1",
-        },
+        { "virtio-serial-pci", "max_ports", "1" },
+        { "virtio-serial-pci", "vectors", "0" },
+        { "usb-mouse", "serial", "1" },
+        { "usb-tablet", "serial", "1" },
+        { "usb-kbd", "serial", "1" },
     };
=20
     pc_i440fx_0_13_machine_options(m);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index b6e42c7775..0942f35bf8 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4113,16 +4113,8 @@ static void spapr_machine_2_12_class_options(Machi=
neClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        {
-            .driver =3D TYPE_POWERPC_CPU,
-            .property =3D "pre-3.0-migration",
-            .value    =3D "on",
-        },
-        {
-            .driver =3D TYPE_SPAPR_CPU_CORE,
-            .property =3D "pre-3.0-migration",
-            .value    =3D "on",
-        },
+        { TYPE_POWERPC_CPU, "pre-3.0-migration", "on" },
+        { TYPE_SPAPR_CPU_CORE, "pre-3.0-migration", "on" },
     };
=20
     spapr_machine_3_0_class_options(mc);
@@ -4186,11 +4178,7 @@ static void spapr_machine_2_9_class_options(Machin=
eClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        {
-            .driver =3D TYPE_POWERPC_CPU,
-            .property =3D "pre-2.10-migration",
-            .value    =3D "on",
-        },
+        { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
     };
=20
     spapr_machine_2_10_class_options(mc);
@@ -4210,11 +4198,7 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property =3D "pcie-extended-configuration-space",
-            .value    =3D "off",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pcie-extended-configuration-space=
", "off" },
     };
=20
     spapr_machine_2_9_class_options(mc);
@@ -4282,26 +4266,10 @@ static void spapr_machine_2_7_class_options(Machi=
neClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property =3D "mem_win_size",
-            .value    =3D "0xf80000000",
-        },
-        {
-            .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property =3D "mem64_win_size",
-            .value    =3D "0",
-        },
-        {
-            .driver =3D TYPE_POWERPC_CPU,
-            .property =3D "pre-2.8-migration",
-            .value    =3D "on",
-        },
-        {
-            .driver =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property =3D "pre-2.8-migration",
-            .value    =3D "on",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
+        { TYPE_POWERPC_CPU, "pre-2.8-migration", "on", },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-2.8-migration", "on", },
     };
=20
     spapr_machine_2_8_class_options(mc);
@@ -4321,11 +4289,7 @@ DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
 static void spapr_machine_2_6_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property =3D "ddw",
-            .value    =3D "off",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "ddw", "off" },
     };
=20
     spapr_machine_2_7_class_options(mc);
@@ -4344,11 +4308,7 @@ static void spapr_machine_2_5_class_options(Machin=
eClass *mc)
 {
     sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D "spapr-vlan",
-            .property =3D "use-rx-buffer-pools",
-            .value    =3D "off",
-        },
+        { "spapr-vlan", "use-rx-buffer-pools", "off" },
     };
=20
     spapr_machine_2_6_class_options(mc);
@@ -4381,11 +4341,7 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
 static void spapr_machine_2_3_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D "spapr-pci-host-bridge",
-            .property =3D "dynamic-reconfiguration",
-            .value    =3D "off",
-        },
+        { "spapr-pci-host-bridge", "dynamic-reconfiguration", "off" },
     };
     spapr_machine_2_4_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len)=
;
@@ -4400,11 +4356,7 @@ DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
 static void spapr_machine_2_2_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property =3D "mem_win_size",
-            .value    =3D "0x20000000",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0x20000000" },
     };
=20
     spapr_machine_2_3_class_options(mc);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c737507053..811fdf913d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -712,11 +712,7 @@ static void ccw_machine_2_11_instance_options(Machin=
eState *machine)
 static void ccw_machine_2_11_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_SCLP_EVENT_FACILITY,
-            .property =3D "allow_all_mask_sizes",
-            .value    =3D "off",
-        },
+        { TYPE_SCLP_EVENT_FACILITY, "allow_all_mask_sizes", "off", },
     };
=20
     ccw_machine_2_12_class_options(mc);
@@ -751,11 +747,7 @@ static void ccw_machine_2_9_class_options(MachineCla=
ss *mc)
 {
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_S390_STATTRIB,
-            .property =3D "migration-enabled",
-            .value    =3D "off",
-        },
+        { TYPE_S390_STATTRIB, "migration-enabled", "off", },
     };
=20
     ccw_machine_2_10_class_options(mc);
@@ -773,11 +765,7 @@ static void ccw_machine_2_8_instance_options(Machine=
State *machine)
 static void ccw_machine_2_8_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_S390_FLIC_COMMON,
-            .property =3D "adapter_routes_max_batch",
-            .value    =3D "64",
-        },
+        { TYPE_S390_FLIC_COMMON, "adapter_routes_max_batch", "64", },
     };
=20
     ccw_machine_2_9_class_options(mc);
@@ -810,15 +798,8 @@ static void ccw_machine_2_6_class_options(MachineCla=
ss *mc)
 {
     S390CcwMachineClass *s390mc =3D S390_MACHINE_CLASS(mc);
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_S390_IPL,
-            .property =3D "iplbext_migration",
-            .value    =3D "off",
-        }, {
-            .driver   =3D TYPE_VIRTUAL_CSS_BRIDGE,
-            .property =3D "css_dev_path",
-            .value    =3D "off",
-        },
+        { TYPE_S390_IPL, "iplbext_migration", "off", },
+         { TYPE_VIRTUAL_CSS_BRIDGE, "css_dev_path", "off", },
     };
=20
     s390mc->ri_allowed =3D false;
@@ -848,43 +829,15 @@ static void ccw_machine_2_4_instance_options(Machin=
eState *machine)
 static void ccw_machine_2_4_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] =3D {
-        {
-            .driver   =3D TYPE_S390_SKEYS,
-            .property =3D "migration-enabled",
-            .value    =3D "off",
-        },{
-            .driver   =3D "virtio-blk-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },{
-            .driver   =3D "virtio-balloon-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },{
-            .driver   =3D "virtio-serial-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },{
-            .driver   =3D "virtio-9p-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },{
-            .driver   =3D "virtio-rng-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },{
-            .driver   =3D "virtio-net-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },{
-            .driver   =3D "virtio-scsi-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },{
-            .driver   =3D "vhost-scsi-ccw",
-            .property =3D "max_revision",
-            .value    =3D "0",
-        },
+        { TYPE_S390_SKEYS, "migration-enabled", "off", },
+        { "virtio-blk-ccw", "max_revision", "0", },
+        { "virtio-balloon-ccw", "max_revision", "0", },
+        { "virtio-serial-ccw", "max_revision", "0", },
+        { "virtio-9p-ccw", "max_revision", "0", },
+        { "virtio-rng-ccw", "max_revision", "0", },
+        { "virtio-net-ccw", "max_revision", "0", },
+        { "virtio-scsi-ccw", "max_revision", "0", },
+        { "vhost-scsi-ccw", "max_revision", "0", },
     };
=20
     ccw_machine_2_5_class_options(mc);
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index d51148b6b3..18a9045556 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -163,21 +163,9 @@ static void xen_accel_class_init(ObjectClass *oc, vo=
id *data)
 {
     AccelClass *ac =3D ACCEL_CLASS(oc);
     static GlobalProperty compat[] =3D {
-        {
-            .driver =3D "migration",
-            .property =3D "store-global-state",
-            .value =3D "off",
-        },
-        {
-            .driver =3D "migration",
-            .property =3D "send-configuration",
-            .value =3D "off",
-        },
-        {
-            .driver =3D "migration",
-            .property =3D "send-section-footer",
-            .value =3D "off",
-        }
+        { "migration", "store-global-state", "off" },
+        { "migration", "send-configuration", "off" },
+        { "migration", "send-section-footer", "off" },
     };
=20
     ac->name =3D "Xen";
--=20
2.18.0.rc1.1.g3f1ff2140
