Received: from eggs.gnu.org ([209.51.188.92]:33505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabz-0008W2-TU
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:31:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ggabv-0000uq-BR
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 14:30:59 -0500
From: Eduardo Habkost <ehabkost@redhat.com>
Date: Mon,  7 Jan 2019 17:30:20 -0200
Message-Id: <20190107193020.21744-4-ehabkost@redhat.com>
In-Reply-To: <20190107193020.21744-1-ehabkost@redhat.com>
References: <20190107193020.21744-1-ehabkost@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] machine: Use shorter format for
 GlobalProperty arrays
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>, qemu-s390x@nongnu.org, Halil Pasic <pasic@linux.ibm.com>, Anthony Perard <anthony.perard@citrix.com>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Stefano Stabellini <sstabellini@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-ppc@nongnu.org, xen-devel@lists.xenproject.org

Instead of verbose arrays with 4 lines for each entry, make each
entry take only one line.  This makes long arrays that couldn't
fit in the screen become short and readable.

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
-        .driver   = "qemu32-" TYPE_X86_CPU,\
-        .property = "model-id",\
-        .value    = "QEMU Virtual CPU version " v,\
-    },\
-    {\
-        .driver   = "qemu64-" TYPE_X86_CPU,\
-        .property = "model-id",\
-        .value    = "QEMU Virtual CPU version " v,\
-    },\
-    {\
-        .driver   = "athlon-" TYPE_X86_CPU,\
-        .property = "model-id",\
-        .value    = "QEMU Virtual CPU version " v,\
-    },
+    { "qemu32-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
+    { "qemu64-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },\
+    { "athlon-" TYPE_X86_CPU, "model-id", "QEMU Virtual CPU version " v, },
 
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 4b4d6c23de..5530b71981 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -24,23 +24,10 @@
 #include "hw/pci/pci.h"
 
 GlobalProperty hw_compat_3_1[] = {
-    {
-        .driver   = "pcie-root-port",
-        .property = "x-speed",
-        .value    = "2_5",
-    },{
-        .driver   = "pcie-root-port",
-        .property = "x-width",
-        .value    = "1",
-    },{
-        .driver   = "memory-backend-file",
-        .property = "x-use-canonical-path-for-ramblock-id",
-        .value    = "true",
-    },{
-        .driver   = "memory-backend-memfd",
-        .property = "x-use-canonical-path-for-ramblock-id",
-        .value    = "true",
-    },
+    { "pcie-root-port", "x-speed", "2_5" },
+    { "pcie-root-port", "x-width", "1" },
+    { "memory-backend-file", "x-use-canonical-path-for-ramblock-id", "true" },
+    { "memory-backend-memfd", "x-use-canonical-path-for-ramblock-id", "true" },
 };
 const size_t hw_compat_3_1_len = G_N_ELEMENTS(hw_compat_3_1);
 
@@ -48,269 +35,96 @@ GlobalProperty hw_compat_3_0[] = {};
 const size_t hw_compat_3_0_len = G_N_ELEMENTS(hw_compat_3_0);
 
 GlobalProperty hw_compat_2_12[] = {
-    {
-        .driver   = "migration",
-        .property = "decompress-error-check",
-        .value    = "off",
-    },{
-        .driver   = "hda-audio",
-        .property = "use-timer",
-        .value    = "false",
-    },{
-        .driver   = "cirrus-vga",
-        .property = "global-vmstate",
-        .value    = "true",
-    },{
-        .driver   = "VGA",
-        .property = "global-vmstate",
-        .value    = "true",
-    },{
-        .driver   = "vmware-svga",
-        .property = "global-vmstate",
-        .value    = "true",
-    },{
-        .driver   = "qxl-vga",
-        .property = "global-vmstate",
-        .value    = "true",
-    },
+    { "migration", "decompress-error-check", "off" },
+    { "hda-audio", "use-timer", "false" },
+    { "cirrus-vga", "global-vmstate", "true" },
+    { "VGA", "global-vmstate", "true" },
+    { "vmware-svga", "global-vmstate", "true" },
+    { "qxl-vga", "global-vmstate", "true" },
 };
 const size_t hw_compat_2_12_len = G_N_ELEMENTS(hw_compat_2_12);
 
 GlobalProperty hw_compat_2_11[] = {
-    {
-        .driver   = "hpet",
-        .property = "hpet-offset-saved",
-        .value    = "false",
-    },{
-        .driver   = "virtio-blk-pci",
-        .property = "vectors",
-        .value    = "2",
-    },{
-        .driver   = "vhost-user-blk-pci",
-        .property = "vectors",
-        .value    = "2",
-    },{
-        .driver   = "e1000",
-        .property = "migrate_tso_props",
-        .value    = "off",
-    },
+    { "hpet", "hpet-offset-saved", "false" },
+    { "virtio-blk-pci", "vectors", "2" },
+    { "vhost-user-blk-pci", "vectors", "2" },
+    { "e1000", "migrate_tso_props", "off" },
 };
 const size_t hw_compat_2_11_len = G_N_ELEMENTS(hw_compat_2_11);
 
 GlobalProperty hw_compat_2_10[] = {
-    {
-        .driver   = "virtio-mouse-device",
-        .property = "wheel-axis",
-        .value    = "false",
-    },{
-        .driver   = "virtio-tablet-device",
-        .property = "wheel-axis",
-        .value    = "false",
-    },
+    { "virtio-mouse-device", "wheel-axis", "false" },
+    { "virtio-tablet-device", "wheel-axis", "false" },
 };
 const size_t hw_compat_2_10_len = G_N_ELEMENTS(hw_compat_2_10);
 
 GlobalProperty hw_compat_2_9[] = {
-    {
-        .driver   = "pci-bridge",
-        .property = "shpc",
-        .value    = "off",
-    },{
-        .driver   = "intel-iommu",
-        .property = "pt",
-        .value    = "off",
-    },{
-        .driver   = "virtio-net-device",
-        .property = "x-mtu-bypass-backend",
-        .value    = "off",
-    },{
-        .driver   = "pcie-root-port",
-        .property = "x-migrate-msix",
-        .value    = "false",
-    },
+    { "pci-bridge", "shpc", "off" },
+    { "intel-iommu", "pt", "off" },
+    { "virtio-net-device", "x-mtu-bypass-backend", "off" },
+    { "pcie-root-port", "x-migrate-msix", "false" },
 };
 const size_t hw_compat_2_9_len = G_N_ELEMENTS(hw_compat_2_9);
 
 GlobalProperty hw_compat_2_8[] = {
-    {
-        .driver   = "fw_cfg_mem",
-        .property = "x-file-slots",
-        .value    = "0x10",
-    },{
-        .driver   = "fw_cfg_io",
-        .property = "x-file-slots",
-        .value    = "0x10",
-    },{
-        .driver   = "pflash_cfi01",
-        .property = "old-multiple-chip-handling",
-        .value    = "on",
-    },{
-        .driver   = "pci-bridge",
-        .property = "shpc",
-        .value    = "on",
-    },{
-        .driver   = TYPE_PCI_DEVICE,
-        .property = "x-pcie-extcap-init",
-        .value    = "off",
-    },{
-        .driver   = "virtio-pci",
-        .property = "x-pcie-deverr-init",
-        .value    = "off",
-    },{
-        .driver   = "virtio-pci",
-        .property = "x-pcie-lnkctl-init",
-        .value    = "off",
-    },{
-        .driver   = "virtio-pci",
-        .property = "x-pcie-pm-init",
-        .value    = "off",
-    },{
-        .driver   = "cirrus-vga",
-        .property = "vgamem_mb",
-        .value    = "8",
-    },{
-        .driver   = "isa-cirrus-vga",
-        .property = "vgamem_mb",
-        .value    = "8",
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
 const size_t hw_compat_2_8_len = G_N_ELEMENTS(hw_compat_2_8);
 
 GlobalProperty hw_compat_2_7[] = {
-    {
-        .driver   = "virtio-pci",
-        .property = "page-per-vq",
-        .value    = "on",
-    },{
-        .driver   = "virtio-serial-device",
-        .property = "emergency-write",
-        .value    = "off",
-    },{
-        .driver   = "ioapic",
-        .property = "version",
-        .value    = "0x11",
-    },{
-        .driver   = "intel-iommu",
-        .property = "x-buggy-eim",
-        .value    = "true",
-    },{
-        .driver   = "virtio-pci",
-        .property = "x-ignore-backend-features",
-        .value    = "on",
-    },
+    { "virtio-pci", "page-per-vq", "on" },
+    { "virtio-serial-device", "emergency-write", "off" },
+    { "ioapic", "version", "0x11" },
+    { "intel-iommu", "x-buggy-eim", "true" },
+    { "virtio-pci", "x-ignore-backend-features", "on" },
 };
 const size_t hw_compat_2_7_len = G_N_ELEMENTS(hw_compat_2_7);
 
 GlobalProperty hw_compat_2_6[] = {
-    {
-        .driver   = "virtio-mmio",
-        .property = "format_transport_address",
-        .value    = "off",
-    },{
-        .driver   = "virtio-pci",
-        .property = "disable-modern",
-        .value    = "on",
-    },{
-        .driver   = "virtio-pci",
-        .property = "disable-legacy",
-        .value    = "off",
-    },
+    { "virtio-mmio", "format_transport_address", "off" },
+    { "virtio-pci", "disable-modern", "on" },
+    { "virtio-pci", "disable-legacy", "off" },
 };
 const size_t hw_compat_2_6_len = G_N_ELEMENTS(hw_compat_2_6);
 
 GlobalProperty hw_compat_2_5[] = {
-    {
-        .driver   = "isa-fdc",
-        .property = "fallback",
-        .value    = "144",
-    },{
-        .driver   = "pvscsi",
-        .property = "x-old-pci-configuration",
-        .value    = "on",
-    },{
-        .driver   = "pvscsi",
-        .property = "x-disable-pcie",
-        .value    = "on",
-    },
-    {
-        .driver   = "vmxnet3",
-        .property = "x-old-msi-offsets",
-        .value    = "on",
-    },{
-        .driver   = "vmxnet3",
-        .property = "x-disable-pcie",
-        .value    = "on",
-    },
+    { "isa-fdc", "fallback", "144" },
+    { "pvscsi", "x-old-pci-configuration", "on" },
+    { "pvscsi", "x-disable-pcie", "on" },
+    { "vmxnet3", "x-old-msi-offsets", "on" },
+    { "vmxnet3", "x-disable-pcie", "on" },
 };
 const size_t hw_compat_2_5_len = G_N_ELEMENTS(hw_compat_2_5);
 
 GlobalProperty hw_compat_2_4[] = {
-    {
-        .driver   = "virtio-blk-device",
-        .property = "scsi",
-        .value    = "true",
-    },{
-        .driver   = "e1000",
-        .property = "extra_mac_registers",
-        .value    = "off",
-    },{
-        .driver   = "virtio-pci",
-        .property = "x-disable-pcie",
-        .value    = "on",
-    },{
-        .driver   = "virtio-pci",
-        .property = "migrate-extra",
-        .value    = "off",
-    },{
-        .driver   = "fw_cfg_mem",
-        .property = "dma_enabled",
-        .value    = "off",
-    },{
-        .driver   = "fw_cfg_io",
-        .property = "dma_enabled",
-        .value    = "off",
-    }
+    { "virtio-blk-device", "scsi", "true" },
+    { "e1000", "extra_mac_registers", "off" },
+    { "virtio-pci", "x-disable-pcie", "on" },
+    { "virtio-pci", "migrate-extra", "off" },
+    { "fw_cfg_mem", "dma_enabled", "off" },
+    { "fw_cfg_io", "dma_enabled", "off" }
 };
 const size_t hw_compat_2_4_len = G_N_ELEMENTS(hw_compat_2_4);
 
 GlobalProperty hw_compat_2_3[] = {
-    {
-        .driver   = "virtio-blk-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver   = "virtio-balloon-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver   = "virtio-serial-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver   = "virtio-9p-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver   = "virtio-rng-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver   = TYPE_PCI_DEVICE,
-        .property = "x-pcie-lnksta-dllla",
-        .value    = "off",
-    },{
-        .driver   = "migration",
-        .property = "send-configuration",
-        .value    = "off",
-    },{
-        .driver   = "migration",
-        .property = "send-section-footer",
-        .value    = "off",
-    },{
-        .driver   = "migration",
-        .property = "store-global-state",
-        .value    = "off",
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
 const size_t hw_compat_2_3_len = G_N_ELEMENTS(hw_compat_2_3);
 
@@ -318,35 +132,13 @@ GlobalProperty hw_compat_2_2[] = {};
 const size_t hw_compat_2_2_len = G_N_ELEMENTS(hw_compat_2_2);
 
 GlobalProperty hw_compat_2_1[] = {
-    {
-        .driver   = "intel-hda",
-        .property = "old_msi_addr",
-        .value    = "on",
-    },{
-        .driver   = "VGA",
-        .property = "qemu-extended-regs",
-        .value    = "off",
-    },{
-        .driver   = "secondary-vga",
-        .property = "qemu-extended-regs",
-        .value    = "off",
-    },{
-        .driver   = "virtio-scsi-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver   = "usb-mouse",
-        .property = "usb_version",
-        .value    = "1",
-    },{
-        .driver   = "usb-kbd",
-        .property = "usb_version",
-        .value    = "1",
-    },{
-        .driver   = "virtio-pci",
-        .property = "virtio-pci-bus-master-bug-migration",
-        .value    = "on",
-    },
+    { "intel-hda", "old_msi_addr", "on" },
+    { "VGA", "qemu-extended-regs", "off" },
+    { "secondary-vga", "qemu-extended-regs", "off" },
+    { "virtio-scsi-pci", "any_layout", "off" },
+    { "usb-mouse", "usb_version", "1" },
+    { "usb-kbd", "usb_version", "1" },
+    { "virtio-pci", "virtio-pci-bus-master-bug-migration", "on" },
 };
 const size_t hw_compat_2_1_len = G_N_ELEMENTS(hw_compat_2_1);
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index ff14b6d4df..f238424499 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -111,174 +111,67 @@ static unsigned e820_entries;
 struct hpet_fw_config hpet_cfg = {.count = UINT8_MAX};
 
 GlobalProperty pc_compat_3_1[] = {
-    {
-        .driver   = "intel-iommu",
-        .property = "dma-drain",
-        .value    = "off",
-    },
+    { "intel-iommu", "dma-drain", "off" },
 };
 const size_t pc_compat_3_1_len = G_N_ELEMENTS(pc_compat_3_1);
 
 GlobalProperty pc_compat_3_0[] = {
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "x-hv-synic-kvm-only",
-        .value    = "on",
-    },{
-        .driver   = "Skylake-Server" "-" TYPE_X86_CPU,
-        .property = "pku",
-        .value    = "off",
-    },{
-        .driver   = "Skylake-Server-IBRS" "-" TYPE_X86_CPU,
-        .property = "pku",
-        .value    = "off",
-    },
+    { TYPE_X86_CPU, "x-hv-synic-kvm-only", "on" },
+    { "Skylake-Server" "-" TYPE_X86_CPU, "pku", "off" },
+    { "Skylake-Server-IBRS" "-" TYPE_X86_CPU, "pku", "off" },
 };
 const size_t pc_compat_3_0_len = G_N_ELEMENTS(pc_compat_3_0);
 
 GlobalProperty pc_compat_2_12[] = {
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "legacy-cache",
-        .value    = "on",
-    },{
-        .driver   = TYPE_X86_CPU,
-        .property = "topoext",
-        .value    = "off",
-    },{
-        .driver   = "EPYC-" TYPE_X86_CPU,
-        .property = "xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "EPYC-IBPB-" TYPE_X86_CPU,
-        .property = "xlevel",
-        .value    = "0x8000000a",
-    },
+    { TYPE_X86_CPU, "legacy-cache", "on" },
+    { TYPE_X86_CPU, "topoext", "off" },
+    { "EPYC-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
+    { "EPYC-IBPB-" TYPE_X86_CPU, "xlevel", "0x8000000a" },
 };
 const size_t pc_compat_2_12_len = G_N_ELEMENTS(pc_compat_2_12);
 
 GlobalProperty pc_compat_2_11[] = {
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "x-migrate-smi-count",
-        .value    = "off",
-    },{
-        .driver   = "Skylake-Server" "-" TYPE_X86_CPU,
-        .property = "clflushopt",
-        .value    = "off",
-    },
+    { TYPE_X86_CPU, "x-migrate-smi-count", "off" },
+    { "Skylake-Server" "-" TYPE_X86_CPU, "clflushopt", "off" },
 };
 const size_t pc_compat_2_11_len = G_N_ELEMENTS(pc_compat_2_11);
 
 GlobalProperty pc_compat_2_10[] = {
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "x-hv-max-vps",
-        .value    = "0x40",
-    },{
-        .driver   = "i440FX-pcihost",
-        .property = "x-pci-hole64-fix",
-        .value    = "off",
-    },{
-        .driver   = "q35-pcihost",
-        .property = "x-pci-hole64-fix",
-        .value    = "off",
-    },
+    { TYPE_X86_CPU, "x-hv-max-vps", "0x40" },
+    { "i440FX-pcihost", "x-pci-hole64-fix", "off" },
+    { "q35-pcihost", "x-pci-hole64-fix", "off" },
 };
 const size_t pc_compat_2_10_len = G_N_ELEMENTS(pc_compat_2_10);
 
 GlobalProperty pc_compat_2_9[] = {
-    {
-        .driver   = "mch",
-        .property = "extended-tseg-mbytes",
-        .value    = "0",
-    },
+    { "mch", "extended-tseg-mbytes", "0" },
 };
 const size_t pc_compat_2_9_len = G_N_ELEMENTS(pc_compat_2_9);
 
 GlobalProperty pc_compat_2_8[] = {
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "tcg-cpuid",
-        .value    = "off",
-    },
-    {
-        .driver   = "kvmclock",
-        .property = "x-mach-use-reliable-get-clock",
-        .value    = "off",
-    },
-    {
-        .driver   = "ICH9-LPC",
-        .property = "x-smi-broadcast",
-        .value    = "off",
-    },
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "vmware-cpuid-freq",
-        .value    = "off",
-    },
-    {
-        .driver   = "Haswell-" TYPE_X86_CPU,
-        .property = "stepping",
-        .value    = "1",
-    },
+    { TYPE_X86_CPU, "tcg-cpuid", "off" },
+    { "kvmclock", "x-mach-use-reliable-get-clock", "off" },
+    { "ICH9-LPC", "x-smi-broadcast", "off" },
+    { TYPE_X86_CPU, "vmware-cpuid-freq", "off" },
+    { "Haswell-" TYPE_X86_CPU, "stepping", "1" },
 };
 const size_t pc_compat_2_8_len = G_N_ELEMENTS(pc_compat_2_8);
 
 GlobalProperty pc_compat_2_7[] = {
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "l3-cache",
-        .value    = "off",
-    },
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "full-cpuid-auto-level",
-        .value    = "off",
-    },
-    {
-        .driver   = "Opteron_G3" "-" TYPE_X86_CPU,
-        .property = "family",
-        .value    = "15",
-    },
-    {
-        .driver   = "Opteron_G3" "-" TYPE_X86_CPU,
-        .property = "model",
-        .value    = "6",
-    },
-    {
-        .driver   = "Opteron_G3" "-" TYPE_X86_CPU,
-        .property = "stepping",
-        .value    = "1",
-    },
-    {
-        .driver   = "isa-pcspk",
-        .property = "migrate",
-        .value    = "off",
-    },
+    { TYPE_X86_CPU, "l3-cache", "off" },
+    { TYPE_X86_CPU, "full-cpuid-auto-level", "off" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "family", "15" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "model", "6" },
+    { "Opteron_G3" "-" TYPE_X86_CPU, "stepping", "1" },
+    { "isa-pcspk", "migrate", "off" },
 };
 const size_t pc_compat_2_7_len = G_N_ELEMENTS(pc_compat_2_7);
 
 GlobalProperty pc_compat_2_6[] = {
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "cpuid-0xb",
-        .value    = "off",
-    },{
-        .driver   = "vmxnet3",
-        .property = "romfile",
-        .value    = "",
-    },
-    {
-        .driver = TYPE_X86_CPU,
-        .property = "fill-mtrr-mask",
-        .value = "off",
-    },
-    {
-        .driver   = "apic-common",
-        .property = "legacy-instance-id",
-        .value    = "on",
-    }
+    { TYPE_X86_CPU, "cpuid-0xb", "off" },
+    { "vmxnet3", "romfile", "" },
+    { TYPE_X86_CPU, "fill-mtrr-mask", "off" },
+    { "apic-common", "legacy-instance-id", "on", }
 };
 const size_t pc_compat_2_6_len = G_N_ELEMENTS(pc_compat_2_6);
 
@@ -287,499 +180,148 @@ const size_t pc_compat_2_5_len = G_N_ELEMENTS(pc_compat_2_5);
 
 GlobalProperty pc_compat_2_4[] = {
     PC_CPU_MODEL_IDS("2.4.0")
-    {
-        .driver   = "Haswell-" TYPE_X86_CPU,
-        .property = "abm",
-        .value    = "off",
-    },
-    {
-        .driver   = "Haswell-noTSX-" TYPE_X86_CPU,
-        .property = "abm",
-        .value    = "off",
-    },
-    {
-        .driver   = "Broadwell-" TYPE_X86_CPU,
-        .property = "abm",
-        .value    = "off",
-    },
-    {
-        .driver   = "Broadwell-noTSX-" TYPE_X86_CPU,
-        .property = "abm",
-        .value    = "off",
-    },
-    {
-        .driver   = "host" "-" TYPE_X86_CPU,
-        .property = "host-cache-info",
-        .value    = "on",
-    },
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "check",
-        .value    = "off",
-    },
-    {
-        .driver   = "qemu64" "-" TYPE_X86_CPU,
-        .property = "sse4a",
-        .value    = "on",
-    },
-    {
-        .driver   = "qemu64" "-" TYPE_X86_CPU,
-        .property = "abm",
-        .value    = "on",
-    },
-    {
-        .driver   = "qemu64" "-" TYPE_X86_CPU,
-        .property = "popcnt",
-        .value    = "on",
-    },
-    {
-        .driver   = "qemu32" "-" TYPE_X86_CPU,
-        .property = "popcnt",
-        .value    = "on",
-    },{
-        .driver   = "Opteron_G2" "-" TYPE_X86_CPU,
-        .property = "rdtscp",
-        .value    = "on",
-    },{
-        .driver   = "Opteron_G3" "-" TYPE_X86_CPU,
-        .property = "rdtscp",
-        .value    = "on",
-    },{
-        .driver   = "Opteron_G4" "-" TYPE_X86_CPU,
-        .property = "rdtscp",
-        .value    = "on",
-    },{
-        .driver   = "Opteron_G5" "-" TYPE_X86_CPU,
-        .property = "rdtscp",
-        .value    = "on",
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
 const size_t pc_compat_2_4_len = G_N_ELEMENTS(pc_compat_2_4);
 
 GlobalProperty pc_compat_2_3[] = {
     PC_CPU_MODEL_IDS("2.3.0")
-    {
-        .driver   = TYPE_X86_CPU,
-        .property = "arat",
-        .value    = "off",
-    },{
-        .driver   = "qemu64" "-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "4",
-    },{
-        .driver   = "kvm64" "-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "5",
-    },{
-        .driver   = "pentium3" "-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "2",
-    },{
-        .driver   = "n270" "-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "5",
-    },{
-        .driver   = "Conroe" "-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "4",
-    },{
-        .driver   = "Penryn" "-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "4",
-    },{
-        .driver   = "Nehalem" "-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "4",
-    },{
-        .driver   = "n270" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Penryn" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Conroe" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Nehalem" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Westmere" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "SandyBridge" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "IvyBridge" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Haswell" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Haswell-noTSX" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Broadwell" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver   = "Broadwell-noTSX" "-" TYPE_X86_CPU,
-        .property = "min-xlevel",
-        .value    = "0x8000000a",
-    },{
-        .driver = TYPE_X86_CPU,
-        .property = "kvm-no-smi-migration",
-        .value    = "on",
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
 const size_t pc_compat_2_3_len = G_N_ELEMENTS(pc_compat_2_3);
 
 GlobalProperty pc_compat_2_2[] = {
     PC_CPU_MODEL_IDS("2.2.0")
-    {
-        .driver = "kvm64" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "kvm32" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Conroe" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Penryn" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Nehalem" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Westmere" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "SandyBridge" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Haswell" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Broadwell" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Opteron_G1" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Opteron_G2" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Opteron_G3" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Opteron_G4" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Opteron_G5" "-" TYPE_X86_CPU,
-        .property = "vme",
-        .value = "off",
-    },
-    {
-        .driver = "Haswell" "-" TYPE_X86_CPU,
-        .property = "f16c",
-        .value = "off",
-    },
-    {
-        .driver = "Haswell" "-" TYPE_X86_CPU,
-        .property = "rdrand",
-        .value = "off",
-    },
-    {
-        .driver = "Broadwell" "-" TYPE_X86_CPU,
-        .property = "f16c",
-        .value = "off",
-    },
-    {
-        .driver = "Broadwell" "-" TYPE_X86_CPU,
-        .property = "rdrand",
-        .value = "off",
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
 const size_t pc_compat_2_2_len = G_N_ELEMENTS(pc_compat_2_2);
 
 GlobalProperty pc_compat_2_1[] = {
     PC_CPU_MODEL_IDS("2.1.0")
-    {
-        .driver = "coreduo" "-" TYPE_X86_CPU,
-        .property = "vmx",
-        .value = "on",
-    },
-    {
-        .driver = "core2duo" "-" TYPE_X86_CPU,
-        .property = "vmx",
-        .value = "on",
-    },
+    { "coreduo" "-" TYPE_X86_CPU, "vmx", "on" },
+    { "core2duo" "-" TYPE_X86_CPU, "vmx", "on" },
 };
 const size_t pc_compat_2_1_len = G_N_ELEMENTS(pc_compat_2_1);
 
 GlobalProperty pc_compat_2_0[] = {
     PC_CPU_MODEL_IDS("2.0.0")
-    {
-        .driver   = "virtio-scsi-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver   = "PIIX4_PM",
-        .property = "memory-hotplug-support",
-        .value    = "off",
-    },
-    {
-        .driver   = "apic",
-        .property = "version",
-        .value    = "0x11",
-    },
-    {
-        .driver   = "nec-usb-xhci",
-        .property = "superspeed-ports-first",
-        .value    = "off",
-    },
-    {
-        .driver   = "nec-usb-xhci",
-        .property = "force-pcie-endcap",
-        .value    = "on",
-    },
-    {
-        .driver   = "pci-serial",
-        .property = "prog_if",
-        .value    = "0",
-    },
-    {
-        .driver   = "pci-serial-2x",
-        .property = "prog_if",
-        .value    = "0",
-    },
-    {
-        .driver   = "pci-serial-4x",
-        .property = "prog_if",
-        .value    = "0",
-    },
-    {
-        .driver   = "virtio-net-pci",
-        .property = "guest_announce",
-        .value    = "off",
-    },
-    {
-        .driver   = "ICH9-LPC",
-        .property = "memory-hotplug-support",
-        .value    = "off",
-    },{
-        .driver   = "xio3130-downstream",
-        .property = COMPAT_PROP_PCP,
-        .value    = "off",
-    },{
-        .driver   = "ioh3420",
-        .property = COMPAT_PROP_PCP,
-        .value    = "off",
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
 const size_t pc_compat_2_0_len = G_N_ELEMENTS(pc_compat_2_0);
 
 GlobalProperty pc_compat_1_7[] = {
     PC_CPU_MODEL_IDS("1.7.0")
-    {
-        .driver   = TYPE_USB_DEVICE,
-        .property = "msos-desc",
-        .value    = "no",
-    },
-    {
-        .driver   = "PIIX4_PM",
-        .property = "acpi-pci-hotplug-with-bridge-support",
-        .value    = "off",
-    },
-    {
-        .driver   = "hpet",
-        .property = HPET_INTCAP,
-        .value    = "4",
-    },
+    { TYPE_USB_DEVICE, "msos-desc", "no" },
+    { "PIIX4_PM", "acpi-pci-hotplug-with-bridge-support", "off" },
+    { "hpet", HPET_INTCAP, "4" },
 };
 const size_t pc_compat_1_7_len = G_N_ELEMENTS(pc_compat_1_7);
 
 GlobalProperty pc_compat_1_6[] = {
     PC_CPU_MODEL_IDS("1.6.0")
-    {
-        .driver   = "e1000",
-        .property = "mitigation",
-        .value    = "off",
-    },{
-        .driver   = "qemu64-" TYPE_X86_CPU,
-        .property = "model",
-        .value    = "2",
-    },{
-        .driver   = "qemu32-" TYPE_X86_CPU,
-        .property = "model",
-        .value    = "3",
-    },{
-        .driver   = "i440FX-pcihost",
-        .property = "short_root_bus",
-        .value    = "1",
-    },{
-        .driver   = "q35-pcihost",
-        .property = "short_root_bus",
-        .value    = "1",
-    },
+    { "e1000", "mitigation", "off" },
+    { "qemu64-" TYPE_X86_CPU, "model", "2" },
+    { "qemu32-" TYPE_X86_CPU, "model", "3" },
+    { "i440FX-pcihost", "short_root_bus", "1" },
+    { "q35-pcihost", "short_root_bus", "1" },
 };
 const size_t pc_compat_1_6_len = G_N_ELEMENTS(pc_compat_1_6);
 
 GlobalProperty pc_compat_1_5[] = {
     PC_CPU_MODEL_IDS("1.5.0")
-    {
-        .driver   = "Conroe-" TYPE_X86_CPU,
-        .property = "model",
-        .value    = "2",
-    },{
-        .driver   = "Conroe-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "2",
-    },{
-        .driver   = "Penryn-" TYPE_X86_CPU,
-        .property = "model",
-        .value    = "2",
-    },{
-        .driver   = "Penryn-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "2",
-    },{
-        .driver   = "Nehalem-" TYPE_X86_CPU,
-        .property = "model",
-        .value    = "2",
-    },{
-        .driver   = "Nehalem-" TYPE_X86_CPU,
-        .property = "min-level",
-        .value    = "2",
-    },{
-        .driver   = "virtio-net-pci",
-        .property = "any_layout",
-        .value    = "off",
-    },{
-        .driver = TYPE_X86_CPU,
-        .property = "pmu",
-        .value = "on",
-    },{
-        .driver   = "i440FX-pcihost",
-        .property = "short_root_bus",
-        .value    = "0",
-    },{
-        .driver   = "q35-pcihost",
-        .property = "short_root_bus",
-        .value    = "0",
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
 const size_t pc_compat_1_5_len = G_N_ELEMENTS(pc_compat_1_5);
 
 GlobalProperty pc_compat_1_4[] = {
     PC_CPU_MODEL_IDS("1.4.0")
-    {
-        .driver   = "scsi-hd",
-        .property = "discard_granularity",
-        .value    = "0",
-    },{
-        .driver   = "scsi-cd",
-        .property = "discard_granularity",
-        .value    = "0",
-    },{
-        .driver   = "scsi-disk",
-        .property = "discard_granularity",
-        .value    = "0",
-    },{
-        .driver   = "ide-hd",
-        .property = "discard_granularity",
-        .value    = "0",
-    },{
-        .driver   = "ide-cd",
-        .property = "discard_granularity",
-        .value    = "0",
-    },{
-        .driver   = "ide-drive",
-        .property = "discard_granularity",
-        .value    = "0",
-    },{
-        .driver   = "virtio-blk-pci",
-        .property = "discard_granularity",
-        .value    = "0",
-    },{
-        .driver   = "virtio-serial-pci",
-        .property = "vectors",
-        /* DEV_NVECTORS_UNSPECIFIED as a uint32_t string */
-        .value    = "0xFFFFFFFF",
-    },{
-        .driver   = "virtio-net-pci",
-        .property = "ctrl_guest_offloads",
-        .value    = "off",
-    },{
-        .driver   = "e1000",
-        .property = "romfile",
-        .value    = "pxe-e1000.rom",
-    },{
-        .driver   = "ne2k_pci",
-        .property = "romfile",
-        .value    = "pxe-ne2k_pci.rom",
-    },{
-        .driver   = "pcnet",
-        .property = "romfile",
-        .value    = "pxe-pcnet.rom",
-    },{
-        .driver   = "rtl8139",
-        .property = "romfile",
-        .value    = "pxe-rtl8139.rom",
-    },{
-        .driver   = "virtio-net-pci",
-        .property = "romfile",
-        .value    = "pxe-virtio.rom",
-    },{
-        .driver   = "486-" TYPE_X86_CPU,
-        .property = "model",
-        .value    = "0",
-    },
-    {
-        .driver = "n270" "-" TYPE_X86_CPU,
-        .property = "movbe",
-        .value = "off",
-    },
-    {
-        .driver = "Westmere" "-" TYPE_X86_CPU,
-        .property = "pclmulqdq",
-        .value = "off",
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
 const size_t pc_compat_1_4_len = G_N_ELEMENTS(pc_compat_1_4);
 
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index fd20227af3..5088e2f492 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -694,23 +694,10 @@ static void pc_i440fx_1_3_machine_options(MachineClass *m)
 {
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("1.3.0")
-        {
-            .driver   = "usb-tablet",
-            .property = "usb_version",
-            .value    = "1",
-        },{
-            .driver   = "virtio-net-pci",
-            .property = "ctrl_mac_addr",
-            .value    = "off",
-        },{
-            .driver   = "virtio-net-pci",
-            .property = "mq",
-            .value    = "off",
-        }, {
-            .driver   = "e1000",
-            .property = "autonegotiation",
-            .value    = "off",
-        },
+        { "usb-tablet", "usb_version", "1" },
+        { "virtio-net-pci", "ctrl_mac_addr", "off" },
+        { "virtio-net-pci", "mq", "off" },
+        { "e1000", "autonegotiation", "off" },
     };
 
     pc_i440fx_1_4_machine_options(m);
@@ -726,31 +713,12 @@ static void pc_i440fx_1_2_machine_options(MachineClass *m)
 {
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("1.2.0")
-        {
-            .driver   = "nec-usb-xhci",
-            .property = "msi",
-            .value    = "off",
-        },{
-            .driver   = "nec-usb-xhci",
-            .property = "msix",
-            .value    = "off",
-        },{
-            .driver   = "ivshmem",
-            .property = "use64",
-            .value    = "0",
-        },{
-            .driver   = "qxl",
-            .property = "revision",
-            .value    = "3",
-        },{
-            .driver   = "qxl-vga",
-            .property = "revision",
-            .value    = "3",
-        },{
-            .driver   = "VGA",
-            .property = "mmio",
-            .value    = "off",
-        },
+        { "nec-usb-xhci", "msi", "off" },
+        { "nec-usb-xhci", "msix", "off" },
+        { "ivshmem", "use64", "0" },
+        { "qxl", "revision", "3" },
+        { "qxl-vga", "revision", "3" },
+        { "VGA", "mmio", "off" },
     };
 
     pc_i440fx_1_3_machine_options(m);
@@ -766,35 +734,13 @@ static void pc_i440fx_1_1_machine_options(MachineClass *m)
 {
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("1.1.0")
-        {
-            .driver   = "virtio-scsi-pci",
-            .property = "hotplug",
-            .value    = "off",
-        },{
-            .driver   = "virtio-scsi-pci",
-            .property = "param_change",
-            .value    = "off",
-        },{
-            .driver   = "VGA",
-            .property = "vgamem_mb",
-            .value    = "8",
-        },{
-            .driver   = "vmware-svga",
-            .property = "vgamem_mb",
-            .value    = "8",
-        },{
-            .driver   = "qxl-vga",
-            .property = "vgamem_mb",
-            .value    = "8",
-        },{
-            .driver   = "qxl",
-            .property = "vgamem_mb",
-            .value    = "8",
-        },{
-            .driver   = "virtio-blk-pci",
-            .property = "config-wce",
-            .value    = "off",
-        },
+        { "virtio-scsi-pci", "hotplug", "off" },
+        { "virtio-scsi-pci", "param_change", "off" },
+        { "VGA", "vgamem_mb", "8" },
+        { "vmware-svga", "vgamem_mb", "8" },
+        { "qxl-vga", "vgamem_mb", "8" },
+        { "qxl", "vgamem_mb", "8" },
+        { "virtio-blk-pci", "config-wce", "off" },
     };
 
     pc_i440fx_1_2_machine_options(m);
@@ -809,23 +755,10 @@ static void pc_i440fx_1_0_machine_options(MachineClass *m)
 {
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("1.0")
-        {
-            .driver   = TYPE_ISA_FDC,
-            .property = "check_media_rate",
-            .value    = "off",
-        },{
-            .driver   = "virtio-balloon-pci",
-            .property = "class",
-            .value    = stringify(PCI_CLASS_MEMORY_RAM),
-        },{
-            .driver   = "apic-common",
-            .property = "vapic",
-            .value    = "off",
-        },{
-            .driver   = TYPE_USB_DEVICE,
-            .property = "full-path",
-            .value    = "no",
-        },
+        { TYPE_ISA_FDC, "check_media_rate", "off" },
+        { "virtio-balloon-pci", "class", stringify(PCI_CLASS_MEMORY_RAM) },
+        { "apic-common", "vapic", "off" },
+        { TYPE_USB_DEVICE, "full-path", "no" },
     };
 
     pc_i440fx_1_1_machine_options(m);
@@ -857,31 +790,12 @@ static void pc_i440fx_0_14_machine_options(MachineClass *m)
 {
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("0.14")
-        {
-            .driver   = "virtio-blk-pci",
-            .property = "event_idx",
-            .value    = "off",
-        },{
-            .driver   = "virtio-serial-pci",
-            .property = "event_idx",
-            .value    = "off",
-        },{
-            .driver   = "virtio-net-pci",
-            .property = "event_idx",
-            .value    = "off",
-        },{
-            .driver   = "virtio-balloon-pci",
-            .property = "event_idx",
-            .value    = "off",
-        },{
-            .driver   = "qxl",
-            .property = "revision",
-            .value    = "2",
-        },{
-            .driver   = "qxl-vga",
-            .property = "revision",
-            .value    = "2",
-        },
+        { "virtio-blk-pci", "event_idx", "off" },
+        { "virtio-serial-pci", "event_idx", "off" },
+        { "virtio-net-pci", "event_idx", "off" },
+        { "virtio-balloon-pci", "event_idx", "off" },
+        { "qxl", "revision", "2" },
+        { "qxl-vga", "revision", "2" },
     };
 
     pc_i440fx_0_15_machine_options(m);
@@ -897,27 +811,11 @@ static void pc_i440fx_0_13_machine_options(MachineClass *m)
     PCMachineClass *pcmc = PC_MACHINE_CLASS(m);
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("0.13")
-        {
-            .driver   = TYPE_PCI_DEVICE,
-            .property = "command_serr_enable",
-            .value    = "off",
-        },{
-            .driver   = "AC97",
-            .property = "use_broken_id",
-            .value    = "1",
-        },{
-            .driver   = "virtio-9p-pci",
-            .property = "vectors",
-            .value    = "0",
-        },{
-            .driver   = "VGA",
-            .property = "rombar",
-            .value    = "0",
-        },{
-            .driver   = "vmware-svga",
-            .property = "rombar",
-            .value    = "0",
-        },
+        { TYPE_PCI_DEVICE, "command_serr_enable", "off" },
+        { "AC97", "use_broken_id", "1" },
+        { "virtio-9p-pci", "vectors", "0" },
+        { "VGA", "rombar", "0" },
+        { "vmware-svga", "rombar", "0" },
     };
 
     pc_i440fx_0_14_machine_options(m);
@@ -933,27 +831,11 @@ static void pc_i440fx_0_12_machine_options(MachineClass *m)
 {
     static GlobalProperty compat[] = {
         PC_CPU_MODEL_IDS("0.12")
-        {
-            .driver   = "virtio-serial-pci",
-            .property = "max_ports",
-            .value    = "1",
-        },{
-            .driver   = "virtio-serial-pci",
-            .property = "vectors",
-            .value    = "0",
-        },{
-            .driver   = "usb-mouse",
-            .property = "serial",
-            .value    = "1",
-        },{
-            .driver   = "usb-tablet",
-            .property = "serial",
-            .value    = "1",
-        },{
-            .driver   = "usb-kbd",
-            .property = "serial",
-            .value    = "1",
-        },
+        { "virtio-serial-pci", "max_ports", "1" },
+        { "virtio-serial-pci", "vectors", "0" },
+        { "usb-mouse", "serial", "1" },
+        { "usb-tablet", "serial", "1" },
+        { "usb-kbd", "serial", "1" },
     };
 
     pc_i440fx_0_13_machine_options(m);
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d7d87b0ae8..697faa99e9 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4053,16 +4053,8 @@ static void spapr_machine_2_12_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
-        {
-            .driver = TYPE_POWERPC_CPU,
-            .property = "pre-3.0-migration",
-            .value    = "on",
-        },
-        {
-            .driver = TYPE_SPAPR_CPU_CORE,
-            .property = "pre-3.0-migration",
-            .value    = "on",
-        },
+        { TYPE_POWERPC_CPU, "pre-3.0-migration", "on" },
+        { TYPE_SPAPR_CPU_CORE, "pre-3.0-migration", "on" },
     };
 
     spapr_machine_3_0_class_options(mc);
@@ -4126,11 +4118,7 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
-        {
-            .driver = TYPE_POWERPC_CPU,
-            .property = "pre-2.10-migration",
-            .value    = "on",
-        },
+        { TYPE_POWERPC_CPU, "pre-2.10-migration", "on" },
     };
 
     spapr_machine_2_10_class_options(mc);
@@ -4150,11 +4138,7 @@ DEFINE_SPAPR_MACHINE(2_9, "2.9", false);
 static void spapr_machine_2_8_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property = "pcie-extended-configuration-space",
-            .value    = "off",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pcie-extended-configuration-space", "off" },
     };
 
     spapr_machine_2_9_class_options(mc);
@@ -4222,26 +4206,10 @@ static void spapr_machine_2_7_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property = "mem_win_size",
-            .value    = "0xf80000000",
-        },
-        {
-            .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property = "mem64_win_size",
-            .value    = "0",
-        },
-        {
-            .driver = TYPE_POWERPC_CPU,
-            .property = "pre-2.8-migration",
-            .value    = "on",
-        },
-        {
-            .driver = TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property = "pre-2.8-migration",
-            .value    = "on",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0xf80000000", },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem64_win_size", "0", },
+        { TYPE_POWERPC_CPU, "pre-2.8-migration", "on", },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "pre-2.8-migration", "on", },
     };
 
     spapr_machine_2_8_class_options(mc);
@@ -4261,11 +4229,7 @@ DEFINE_SPAPR_MACHINE(2_7, "2.7", false);
 static void spapr_machine_2_6_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property = "ddw",
-            .value    = "off",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "ddw", "off" },
     };
 
     spapr_machine_2_7_class_options(mc);
@@ -4284,11 +4248,7 @@ static void spapr_machine_2_5_class_options(MachineClass *mc)
 {
     sPAPRMachineClass *smc = SPAPR_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
-        {
-            .driver   = "spapr-vlan",
-            .property = "use-rx-buffer-pools",
-            .value    = "off",
-        },
+        { "spapr-vlan", "use-rx-buffer-pools", "off" },
     };
 
     spapr_machine_2_6_class_options(mc);
@@ -4321,11 +4281,7 @@ DEFINE_SPAPR_MACHINE(2_4, "2.4", false);
 static void spapr_machine_2_3_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
-        {
-            .driver   = "spapr-pci-host-bridge",
-            .property = "dynamic-reconfiguration",
-            .value    = "off",
-        },
+        { "spapr-pci-host-bridge", "dynamic-reconfiguration", "off" },
     };
     spapr_machine_2_4_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_3, hw_compat_2_3_len);
@@ -4340,11 +4296,7 @@ DEFINE_SPAPR_MACHINE(2_3, "2.3", false);
 static void spapr_machine_2_2_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_SPAPR_PCI_HOST_BRIDGE,
-            .property = "mem_win_size",
-            .value    = "0x20000000",
-        },
+        { TYPE_SPAPR_PCI_HOST_BRIDGE, "mem_win_size", "0x20000000" },
     };
 
     spapr_machine_2_3_class_options(mc);
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index c737507053..811fdf913d 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -712,11 +712,7 @@ static void ccw_machine_2_11_instance_options(MachineState *machine)
 static void ccw_machine_2_11_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_SCLP_EVENT_FACILITY,
-            .property = "allow_all_mask_sizes",
-            .value    = "off",
-        },
+        { TYPE_SCLP_EVENT_FACILITY, "allow_all_mask_sizes", "off", },
     };
 
     ccw_machine_2_12_class_options(mc);
@@ -751,11 +747,7 @@ static void ccw_machine_2_9_class_options(MachineClass *mc)
 {
     S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_S390_STATTRIB,
-            .property = "migration-enabled",
-            .value    = "off",
-        },
+        { TYPE_S390_STATTRIB, "migration-enabled", "off", },
     };
 
     ccw_machine_2_10_class_options(mc);
@@ -773,11 +765,7 @@ static void ccw_machine_2_8_instance_options(MachineState *machine)
 static void ccw_machine_2_8_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_S390_FLIC_COMMON,
-            .property = "adapter_routes_max_batch",
-            .value    = "64",
-        },
+        { TYPE_S390_FLIC_COMMON, "adapter_routes_max_batch", "64", },
     };
 
     ccw_machine_2_9_class_options(mc);
@@ -810,15 +798,8 @@ static void ccw_machine_2_6_class_options(MachineClass *mc)
 {
     S390CcwMachineClass *s390mc = S390_MACHINE_CLASS(mc);
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_S390_IPL,
-            .property = "iplbext_migration",
-            .value    = "off",
-        }, {
-            .driver   = TYPE_VIRTUAL_CSS_BRIDGE,
-            .property = "css_dev_path",
-            .value    = "off",
-        },
+        { TYPE_S390_IPL, "iplbext_migration", "off", },
+         { TYPE_VIRTUAL_CSS_BRIDGE, "css_dev_path", "off", },
     };
 
     s390mc->ri_allowed = false;
@@ -848,43 +829,15 @@ static void ccw_machine_2_4_instance_options(MachineState *machine)
 static void ccw_machine_2_4_class_options(MachineClass *mc)
 {
     static GlobalProperty compat[] = {
-        {
-            .driver   = TYPE_S390_SKEYS,
-            .property = "migration-enabled",
-            .value    = "off",
-        },{
-            .driver   = "virtio-blk-ccw",
-            .property = "max_revision",
-            .value    = "0",
-        },{
-            .driver   = "virtio-balloon-ccw",
-            .property = "max_revision",
-            .value    = "0",
-        },{
-            .driver   = "virtio-serial-ccw",
-            .property = "max_revision",
-            .value    = "0",
-        },{
-            .driver   = "virtio-9p-ccw",
-            .property = "max_revision",
-            .value    = "0",
-        },{
-            .driver   = "virtio-rng-ccw",
-            .property = "max_revision",
-            .value    = "0",
-        },{
-            .driver   = "virtio-net-ccw",
-            .property = "max_revision",
-            .value    = "0",
-        },{
-            .driver   = "virtio-scsi-ccw",
-            .property = "max_revision",
-            .value    = "0",
-        },{
-            .driver   = "vhost-scsi-ccw",
-            .property = "max_revision",
-            .value    = "0",
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
 
     ccw_machine_2_5_class_options(mc);
diff --git a/hw/xen/xen-common.c b/hw/xen/xen-common.c
index d51148b6b3..18a9045556 100644
--- a/hw/xen/xen-common.c
+++ b/hw/xen/xen-common.c
@@ -163,21 +163,9 @@ static void xen_accel_class_init(ObjectClass *oc, void *data)
 {
     AccelClass *ac = ACCEL_CLASS(oc);
     static GlobalProperty compat[] = {
-        {
-            .driver = "migration",
-            .property = "store-global-state",
-            .value = "off",
-        },
-        {
-            .driver = "migration",
-            .property = "send-configuration",
-            .value = "off",
-        },
-        {
-            .driver = "migration",
-            .property = "send-section-footer",
-            .value = "off",
-        }
+        { "migration", "store-global-state", "off" },
+        { "migration", "send-configuration", "off" },
+        { "migration", "send-section-footer", "off" },
     };
 
     ac->name = "Xen";
-- 
2.18.0.rc1.1.g3f1ff2140
