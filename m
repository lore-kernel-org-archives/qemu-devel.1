Received: from eggs.gnu.org ([208.118.235.92]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPHG-00041R-VS
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gcPH9-0005XF-DZ
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:16 -0500
Received: from mga11.intel.com ([192.55.52.93]:57867)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gcPH7-0004Bd-4V
	for qemu-devel@nongnu.org; Thu, 27 Dec 2018 01:36:11 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 27 Dec 2018 14:34:16 +0800
Message-Id: <20181227063419.12981-23-yang.zhong@intel.com>
In-Reply-To: <20181227063419.12981-1-yang.zhong@intel.com>
References: <20181227063419.12981-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH 22/25] i386-softmmu.mak: remove all
 CONFIG_* except boards definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, sameo@linux.intel.com, ehabkost@redhat.com, peter.maydell@linaro.org, thuth@redhat.com, yang.zhong@intel.com

%-softmmu.mak only keep boards definitions in Kconfig mode.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/i386-softmmu.mak | 30 ------------------------------
 hw/i386/Kconfig                  | 30 ++++++++++++++++++++++++++++++
 hw/ide/Kconfig                   |  2 +-
 hw/net/Kconfig                   |  2 ++
 4 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index d3488b5a6d..7b083412af 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,35 +1,5 @@
 # Default configuration for i386-softmmu
 
-CONFIG_VMXNET3_PCI=y
-CONFIG_IPMI=y
-CONFIG_IPMI_LOCAL=y
-CONFIG_IPMI_EXTERN=y
-CONFIG_ISA_IPMI_KCS=y
-CONFIG_ISA_IPMI_BT=y
-
-# Optional devices:
-#
-CONFIG_HPET=y
-CONFIG_APPLESMC=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_ISA_TESTDEV=y
-CONFIG_VMPORT=y
-CONFIG_SGA=y
-CONFIG_PVPANIC=y
-CONFIG_MEM_DEVICE=y
-CONFIG_DIMM=y
-CONFIG_NVDIMM=y
-CONFIG_ACPI_NVDIMM=y
-CONFIG_PCIE_PORT=y
-CONFIG_SMBIOS=y
-CONFIG_PXB=y
-CONFIG_ACPI_VMGENID=y
-CONFIG_FW_CFG_DMA=y
-CONFIG_I2C=y
-CONFIG_SEV=$(CONFIG_KVM)
-CONFIG_VTD=y
-CONFIG_AMD_IOMMU=y
-
 # Boards:
 #
 CONFIG_ISAPC=y
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index af4b81bae1..c00080ac76 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -1,6 +1,9 @@
 config KVM
     bool
 
+config SEV
+    bool
+
 config PC
     bool
     select ISA_DEBUG
@@ -13,6 +16,29 @@ config PC
     select TPM_TIS if TPM
     select HYPERV
     select HYPERV_TESTDEV
+    select DIMM
+    select AMD_IOMMU
+    select NVDIMM
+    select ACPI_NVDIMM
+    select ACPI_VMGENID
+    select SMBIOS
+    select IPMI
+    select IPMI_LOCAL
+    select IPMI_EXTERN
+    select ISA_IPMI_KCS
+    select ISA_IPMI_BT
+    select PFLASH_CFI01
+    select I2C
+    select PVPANIC
+    select PXB
+    select VMPORT
+    select VMMOUSE
+    select SEV if KVM
+    select HPET
+    select APPLESMC
+    select ISA_TESTDEV
+    select SGA
+    select FW_CFG_DMA
 
 config PC_PCI
     bool
@@ -37,6 +63,7 @@ config I440FX
     select PCI_PIIX
     select FDC
     select IDE_PIIX
+    select VTD
 
 config ISAPC
     bool
@@ -55,6 +82,8 @@ config Q35
     select PCI_Q35
     select LPC_ICH9
     select AHCI
+    select VTD
+    select PCIE_PORT
 
 config VTD
     bool
@@ -67,3 +96,4 @@ config VMPORT
 
 config VMMOUSE
     bool
+    depends on VMPORT
diff --git a/hw/ide/Kconfig b/hw/ide/Kconfig
index 41d3057675..b9ba571c04 100644
--- a/hw/ide/Kconfig
+++ b/hw/ide/Kconfig
@@ -17,7 +17,7 @@ config IDE_ISA
 
 config IDE_PIIX
     bool
-    depends on PCI
+    select IDE_PCI
     select IDE_QDEV
 
 config IDE_CMD646
diff --git a/hw/net/Kconfig b/hw/net/Kconfig
index 8b65de1d7f..3be0571649 100644
--- a/hw/net/Kconfig
+++ b/hw/net/Kconfig
@@ -108,6 +108,7 @@ config ROCKER
 
 config CAN_BUS
     bool
+    default y
 
 config CAN_PCI
     bool
@@ -116,3 +117,4 @@ config CAN_PCI
 
 config CAN_SJA1000
     bool
+    default y
-- 
2.17.1
