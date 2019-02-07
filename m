Received: from eggs.gnu.org ([209.51.188.92]:57459)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvx-0001yO-GQ
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnvw-0002If-94
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:57 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:45687)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnvv-0002Hx-VM
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:57:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id q15so770221wro.12
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:57:55 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:00 +0100
Message-Id: <1549562254-41157-18-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 17/51] i386: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com, Yang Zhong <yang.zhong@intel.com>

This way, the default-configs file only need to specify the boards
and any optional devices.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-37-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak | 45 ++++++++----------------------------
 hw/acpi/Kconfig                  |  3 +++
 hw/i2c/Makefile.objs             |  2 +-
 hw/i386/Kconfig                  | 50 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/Makefile.objs            |  5 ++--
 hw/isa/Kconfig                   |  1 +
 hw/pci-host/Kconfig              |  4 ++++
 hw/tpm/Kconfig                   |  2 ++
 8 files changed, 73 insertions(+), 39 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 54b571f..ed234c1 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,12 +1,6 @@
 # Default configuration for i386-softmmu
 
-CONFIG_PCI=y
-CONFIG_PCI_DEVICES=y
-CONFIG_ISA_BUS=y
 include hyperv.mak
-CONFIG_TEST_DEVICES=y
-CONFIG_VGA_ISA=y
-CONFIG_VMWARE_VGA=y
 CONFIG_VMXNET3_PCI=y
 CONFIG_VIRTIO_VGA=y
 CONFIG_IPMI=y
@@ -14,49 +8,28 @@ CONFIG_IPMI_LOCAL=y
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
 CONFIG_ISA_DEBUG=y
 CONFIG_ISA_TESTDEV=y
-CONFIG_VMPORT=y
+CONFIG_TEST_DEVICES=y
 CONFIG_SGA=y
-CONFIG_LPC_ICH9=y
-CONFIG_PCI_EXPRESS=y
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
-CONFIG_ACPI_SMBUS=y
 CONFIG_SMBUS_EEPROM=y
-CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
-CONFIG_VTD=y
-CONFIG_AMD_IOMMU=y
-CONFIG_PAM=y
-CONFIG_PC=y
+CONFIG_PCI_DEVICES=y
+
+# Boards:
+#
+CONFIG_ISAPC=y
 CONFIG_I440FX=y
 CONFIG_Q35=y
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index c485a34..035a28f 100644
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
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index cecee48..aaa3997 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -2,7 +2,7 @@ common-obj-$(CONFIG_I2C) += core.o smbus.o
 common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
-common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
+common-obj-$(CONFIG_ACPI_X86_ICH) += smbus_ich9.o
 common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
 common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 0f94ae1..daf2015 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -7,16 +7,65 @@ config PC
     imply QXL
     imply SEV
     imply TPM_TIS
+    select I8259
+    select I8254
+    select PCSPK
+    select I82374
+    select I8257
+    select MC146818RTC
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
 
 config I440FX
     bool
+    select PC_PCI
+    select PC_ACPI
+    select ACPI_SMBUS
+    select PCI_PIIX
+    select FDC
+    select IDE_PIIX
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
+    imply VTD
+    imply AMD_IOMMU
+    select PC_PCI
+    select PC_ACPI
+    select PCI_EXPRESS_Q35
+    select LPC_ICH9
+    select AHCI
+    select DIMM
+    select SMBIOS
+    select VMPORT
+    select VMMOUSE
+    select FW_CFG_DMA
 
 config VTD
     bool
@@ -29,3 +78,4 @@ config VMPORT
 
 config VMMOUSE
     bool
+    depends on VMPORT
diff --git a/hw/i386/Makefile.objs b/hw/i386/Makefile.objs
index 3de7ca2..27248a0 100644
--- a/hw/i386/Makefile.objs
+++ b/hw/i386/Makefile.objs
@@ -4,8 +4,9 @@ obj-y += pc.o
 obj-$(CONFIG_I440FX) += pc_piix.o
 obj-$(CONFIG_Q35) += pc_q35.o
 obj-y += pc_sysfw.o
-obj-$(CONFIG_VTD) += x86-iommu.o intel_iommu.o
-obj-$(CONFIG_AMD_IOMMU) += x86-iommu.o amd_iommu.o
+obj-y += x86-iommu.o
+obj-$(CONFIG_VTD) += intel_iommu.o
+obj-$(CONFIG_AMD_IOMMU) += amd_iommu.o
 obj-$(CONFIG_XEN) += ../xenpv/ xen/
 obj-$(CONFIG_VMPORT) += vmport.o
 obj-$(CONFIG_VMMOUSE) += vmmouse.o
diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
index af68af9..6f0812d 100644
--- a/hw/isa/Kconfig
+++ b/hw/isa/Kconfig
@@ -27,4 +27,5 @@ config SMC37C669
 config LPC_ICH9
     bool
     select ISA_BUS
+    select ACPI_SMBUS
     select ACPI_X86_ICH
diff --git a/hw/pci-host/Kconfig b/hw/pci-host/Kconfig
index c01812a..ff4080c 100644
--- a/hw/pci-host/Kconfig
+++ b/hw/pci-host/Kconfig
@@ -27,10 +27,14 @@ config PCI_SABRE
 
 config PCI_PIIX
     bool
+    select PCI
+    select PAM
+    select ISA_BUS
 
 config PCI_EXPRESS_Q35
     bool
     select PCI_EXPRESS
+    select PAM
 
 config PCI_EXPRESS_GENERIC_BRIDGE
     bool
diff --git a/hw/tpm/Kconfig b/hw/tpm/Kconfig
index f3eb570..b0c2c05 100644
--- a/hw/tpm/Kconfig
+++ b/hw/tpm/Kconfig
@@ -7,6 +7,8 @@ config TPM_TIS
 
 config TPM_CRB
     bool
+    default y
+    depends on TPM && PC
 
 config TPM_PASSTHROUGH
     bool
-- 
1.8.3.1
