Received: from eggs.gnu.org ([209.51.188.92]:57687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwD-0002GI-1c
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwA-0002QZ-3n
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:12 -0500
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:55513)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnw9-0002PM-AP
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:09 -0500
Received: by mail-wm1-x342.google.com with SMTP id r17so793871wmh.5
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:12 +0100
Message-Id: <1549562254-41157-30-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 29/51] i386-softmmu.mak: remove all CONFIG_*
 except boards definitions
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

From: Yang Zhong <yang.zhong@intel.com>

%-softmmu.mak only keep boards definitions in Kconfig mode.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-43-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak | 37 ++++++++++++++++++-------------------
 hw/acpi/Kconfig                  |  6 ++++++
 hw/i386/Kconfig                  | 15 +++++++++++++++
 hw/mem/Kconfig                   |  2 ++
 hw/pci-bridge/Kconfig            |  1 +
 hw/timer/Kconfig                 |  1 +
 6 files changed, 43 insertions(+), 19 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index e779ee1..ba3fb3f 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,25 +1,24 @@
 # Default configuration for i386-softmmu
 
-CONFIG_VMXNET3_PCI=y
-CONFIG_ISA_IPMI_KCS=y
-CONFIG_ISA_IPMI_BT=y
-
-# Optional devices:
+# Uncomment the following lines to disable these optional devices:
 #
-CONFIG_HPET=y
-CONFIG_APPLESMC=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_ISA_DEBUG=y
-CONFIG_ISA_TESTDEV=y
-CONFIG_TEST_DEVICES=y
-CONFIG_SGA=y
-CONFIG_PVPANIC=y
-CONFIG_MEM_DEVICE=y
-CONFIG_NVDIMM=y
-CONFIG_ACPI_NVDIMM=y
-CONFIG_PXB=y
-CONFIG_ACPI_VMGENID=y
-CONFIG_PCI_DEVICES=y
+#CONFIG_AMD_IOMMU=n
+#CONFIG_APPLESMC=n
+#CONFIG_FDC=n
+#CONFIG_HPET=n
+#CONFIG_HYPERV=n
+#CONFIG_ISA_DEBUG=n
+#CONFIG_ISA_IPMI_BT=n
+#CONFIG_ISA_IPMI_KCS=n
+#CONFIG_PCI_DEVICES=n
+#CONFIG_PVPANIC=n
+#CONFIG_QXL=n
+#CONFIG_SEV=n
+#CONFIG_SGA=n
+#CONFIG_TEST_DEVICES=n
+#CONFIG_TPM_CRB=n
+#CONFIG_TPM_TIS=n
+#CONFIG_VTD=n
 
 # Boards:
 #
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 035a28f..eca3bee 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -4,6 +4,9 @@ config ACPI
 config ACPI_X86
     bool
     select ACPI
+    select ACPI_NVDIMM
+    select ACPI_CPU_HOTPLUG
+    select ACPI_MEMORY_HOTPLUG
 
 config ACPI_X86_ICH
     bool
@@ -18,6 +21,9 @@ config ACPI_MEMORY_HOTPLUG
 
 config ACPI_NVDIMM
     bool
+    depends on ACPI
 
 config ACPI_VMGENID
     bool
+    default y
+    depends on PC
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index b9d9168..790d37e 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -4,17 +4,31 @@ config SEV
 
 config PC
     bool
+    imply APPLESMC
     imply HYPERV
+    imply ISA_IPMI_KCS
+    imply ISA_IPMI_BT
+    imply ISA_DEBUG
+    imply PCI_DEVICES
+    imply PVPANIC
     imply QXL
     imply SEV
+    imply SGA
+    imply TEST_DEVICES
     imply TPM_CRB
     imply TPM_TIS
     select I8259
     select I8254
+    select PCKBD
     select PCSPK
     select I82374
     select I8257
     select MC146818RTC
+    # Needed by the board code:
+    select PARALLEL
+    # For ACPI builder:
+    select SERIAL_ISA
+    select ACPI_VMGENID
 
 config PC_PCI
     bool
@@ -29,6 +43,7 @@ config PC_ACPI
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
     select SMBUS_EEPROM
+    select PFLASH_CFI01
     depends on ACPI_SMBUS
 
 config I440FX
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index a3a4372..d1e635c 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -6,3 +6,5 @@ config MEM_DEVICE
 
 config NVDIMM
     bool
+    default y
+    depends on PC
diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
index 0519eb1..b167b98 100644
--- a/hw/pci-bridge/Kconfig
+++ b/hw/pci-bridge/Kconfig
@@ -5,6 +5,7 @@ config PCIE_PORT
 
 config PXB
     bool
+    default y if Q35
 
 config XIO3130
     bool
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index a021c74..51921eb 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -15,6 +15,7 @@ config DS1338
 
 config HPET
     bool
+    default y if PC
 
 config I8254
     bool
-- 
1.8.3.1
