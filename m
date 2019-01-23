Received: from eggs.gnu.org ([209.51.188.92]:60270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWa-0005H4-Ub
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWZ-0003xl-MX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:36 -0500
Received: from mga18.intel.com ([134.134.136.126]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWX-0002NF-2n
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:35 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:10 +0800
Message-Id: <20190123065618.3520-37-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 36/44] i386: express dependencies with
 Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

This way, the default-configs file only need to specify the boards
and any optional devices.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/i386-softmmu.mak | 39 ++++----------------
 hw/acpi/Kconfig                  |  3 ++
 hw/display/Kconfig               |  1 +
 hw/i2c/Makefile.objs             |  4 +-
 hw/i386/Kconfig                  | 63 +++++++++++++++++++++++++++++---
 hw/isa/Kconfig                   |  1 +
 hw/pci-host/Kconfig              |  5 +++
 hw/tpm/Kconfig                   |  5 ++-
 8 files changed, 80 insertions(+), 41 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index d818796840..23ea6a3888 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,10 +1,6 @@
 # Default configuration for i386-softmmu
 
-CONFIG_PCI=y
-CONFIG_ISA_BUS=y
 include hyperv.mak
-CONFIG_VGA_ISA=y
-CONFIG_VMWARE_VGA=y
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_IPMI=y
@@ -12,46 +8,25 @@ CONFIG_IPMI_LOCAL=y
 CONFIG_IPMI_EXTERN=y
 CONFIG_ISA_IPMI_KCS=y
 CONFIG_ISA_IPMI_BT=y
-CONFIG_I8254=y
-CONFIG_ACPI=y
-CONFIG_ACPI_X86=y
-CONFIG_ACPI_X86_ICH=y
-CONFIG_ACPI_MEMORY_HOTPLUG=y
-CONFIG_ACPI_CPU_HOTPLUG=y
-CONFIG_APM=y
-CONFIG_I8257=y
-CONFIG_IDE_ISA=y
-CONFIG_IDE_PIIX=y
+
+# Optional devices:
+#
 CONFIG_HPET=y
 CONFIG_APPLESMC=y
-CONFIG_I8259=y
 CONFIG_PFLASH_CFI01=y
-CONFIG_MC146818RTC=y
-CONFIG_PCI_PIIX=y
-CONFIG_ISA_DEBUG=y
 CONFIG_ISA_TESTDEV=y
-CONFIG_VMPORT=y
 CONFIG_SGA=y
-CONFIG_LPC_ICH9=y
-CONFIG_PCI_EXPRESS_Q35=y
-CONFIG_APIC=y
-CONFIG_IOAPIC=y
 CONFIG_PVPANIC=y
 CONFIG_MEM_DEVICE=y
-CONFIG_DIMM=y
 CONFIG_NVDIMM=y
 CONFIG_ACPI_NVDIMM=y
-CONFIG_XIO3130=y
-CONFIG_IOH3420=y
-CONFIG_I82801B11=y
-CONFIG_SMBIOS=y
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
-CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
-CONFIG_VTD=y
-CONFIG_AMD_IOMMU=y
-CONFIG_PAM=y
+
+# Boards:
+#
+CONFIG_ISAPC=y
 CONFIG_I440FX=y
 CONFIG_Q35=y
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 2f4871c10a..98bb3539e1 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -3,15 +3,18 @@ config ACPI
 
 config ACPI_X86
     bool
+    select ACPI
 
 config ACPI_X86_ICH
     bool
+    select ACPI_X86
 
 config ACPI_CPU_HOTPLUG
     bool
 
 config ACPI_MEMORY_HOTPLUG
     bool
+    select MEM_DEVICE
 
 config ACPI_NVDIMM
     bool
diff --git a/hw/display/Kconfig b/hw/display/Kconfig
index a53ca4601a..3d69435982 100644
--- a/hw/display/Kconfig
+++ b/hw/display/Kconfig
@@ -82,6 +82,7 @@ config VGA
 
 config QXL
     bool
+    default y if PC
     depends on SPICE && PCI
     select VGA
 
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 37cacde978..48f7760379 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,8 +1,8 @@
 common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
-common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
-common-obj-$(CONFIG_APM) += pm_smbus.o
+common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
+common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
 common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 68a9064558..bb3b023b95 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -1,21 +1,71 @@
 config KVM
     bool
 
-config I440FX
+config PC
     bool
-    select QXL if SPICE
+    select ISA_DEBUG
+    select I8259
+    select I8254
+    select PCSPK
+    select I82374
+    select I8257
+    select MC146818RTC
     select TPM_TIS if TPM
-    select XEN_I386 if XEN
+
+config PC_PCI
+    bool
+    select APIC
+    select IOAPIC
+    select APM
+    select PC
+
+config PC_ACPI
+    bool
+    select ACPI_X86
+    select ACPI_CPU_HOTPLUG
+    select ACPI_MEMORY_HOTPLUG
+    depends on ACPI_SMBUS
+
+config I440FX
+    bool
+    select PC_PCI
+    select PC_ACPI
+    select ACPI_SMBUS
+    select PCI_PIIX
+    select FDC
+    select IDE_PIIX
+    select PAM
+    select DIMM
+    select SMBIOS
+    select VMPORT
+    select VMMOUSE
+    select FW_CFG_DMA
 
 config ISAPC
     bool
     select ISA_BUS
+    select PC
+    select IDE_ISA
+    select VGA_ISA
+    # FIXME: it is in the same file as i440fx, and does not compile
+    # if separated
+    depends on I440FX
 
 config Q35
     bool
-    select QXL if SPICE
-    select TPM_TIS if TPM
-    select XEN_I386 if XEN
+    select PC_PCI
+    select PC_ACPI
+    select PCI_EXPRESS_Q35
+    select LPC_ICH9
+    select AHCI
+    select PAM
+    select AMD_IOMMU
+    select DIMM
+    select SMBIOS
+    select VMPORT
+    select VMMOUSE
+    select FW_CFG_DMA
+    select VTD
 
 config VTD
     bool
@@ -28,3 +78,4 @@ config VMPORT
 
 config VMMOUSE
     bool
+    depends on VMPORT
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index 3f451ef006..bf72e4fef2 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -25,4 +25,5 @@ config SMC37C669
 config LPC_ICH9
     bool
     select ISA_BUS
+    select ACPI_SMBUS
     select ACPI_X86_ICH
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index 80d483e0e9..a33dcf26dd 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -21,10 +21,15 @@ config PCI_SABRE
 
 config PCI_PIIX
     bool
+    select PCI
 
 config PCI_EXPRESS_Q35
     bool
     select PCI_EXPRESS
+    select PCI
+    select XIO3130
+    select IOH3420
+    select I82801B11
 
 config PCI_EXPRESS_GENERIC_BRIDGE
     bool
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index da4bb5b6c7..28acdb745e 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -3,10 +3,13 @@ config TPM
 
 config TPM_TIS
     bool
-    depends on TPM
+    default y
+    depends on TPM && PC
 
 config TPM_CRB
     bool
+    default y
+    depends on TPM && PC
 
 config TPM_PASSTHROUGH
     bool
-- 
2.17.1
