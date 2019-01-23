Received: from eggs.gnu.org ([209.51.188.92]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWv-0005W4-Pk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWu-00048L-MW
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:57 -0500
Received: from mga18.intel.com ([134.134.136.126]:36919)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWu-0002Mh-D1
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:56 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:16 +0800
Message-Id: <20190123065618.3520-43-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 42/44] i386-softmmu.mak: remove all
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
Cc: pbonzini@redhat.com, thuth@redhat.com, peter.maydell@linaro.org, ehabkost@redhat.com, sameo@linux.intel.com, yang.zhong@intel.com

%-softmmu.mak only keep boards definitions in Kconfig mode.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 default-configs/i386-softmmu.mak | 22 ----------------------
 hw/acpi/Kconfig                  |  5 +++++
 hw/i386/Kconfig                  |  5 +++++
 hw/ipmi/Kconfig                  |  8 ++++++++
 hw/mem/Kconfig                   |  2 ++
 hw/misc/Kconfig                  |  4 ++++
 hw/pci-bridge/Kconfig            |  1 +
 hw/timer/Kconfig                 |  1 +
 8 files changed, 26 insertions(+), 22 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 992aea8f30..7b083412af 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,27 +1,5 @@
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
-CONFIG_SGA=y
-CONFIG_PVPANIC=y
-CONFIG_MEM_DEVICE=y
-CONFIG_NVDIMM=y
-CONFIG_ACPI_NVDIMM=y
-CONFIG_PXB=y
-CONFIG_ACPI_VMGENID=y
-CONFIG_SEV=$(CONFIG_KVM)
-
 # Boards:
 #
 CONFIG_ISAPC=y
diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 98bb3539e1..1b9b56e4fd 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -18,9 +18,14 @@ config ACPI_MEMORY_HOTPLUG
 
 config ACPI_NVDIMM
     bool
+    default y
+    depends on PC || Q35
 
 config ACPI_VMGENID
     bool
+    default y
+    depends on PC || Q35
 
 config IPMI
     bool
+    depends on PC
diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index 6fa943380c..273fc88daa 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -1,6 +1,10 @@
 config KVM
     bool
 
+config SEV
+    bool
+    default y if PC && KVM
+
 config PC
     bool
     select ISA_DEBUG
@@ -25,6 +29,7 @@ config PC_ACPI
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
     select SMBUS_EEPROM
+    select PFLASH_CFI01
     depends on ACPI_SMBUS
 
 config I440FX
diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
index 68f8ba1a54..b15c7b3edc 100644
--- a/hw/ipmi/Kconfig
+++ b/hw/ipmi/Kconfig
@@ -3,12 +3,20 @@ config IPMI
 
 config IPMI_LOCAL
     bool
+    default y
+    depends on IPMI
 
 config IPMI_EXTERN
     bool
+    default y
+    depends on IPMI
 
 config ISA_IPMI_KCS
     bool
+    default y if PC
+    select IPMI
 
 config ISA_IPMI_BT
     bool
+    default y if PC
+    select IPMI
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index a3a4372fa7..a2f8ce9079 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -6,3 +6,5 @@ config MEM_DEVICE
 
 config NVDIMM
     bool
+    default y
+    depends on PC || Q35
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 73ceefab75..6fb1c0ca22 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -1,5 +1,6 @@
 config APPLESMC
     bool
+    default y if PC
     depends on ISA_BUS
 
 config MAX111X
@@ -19,10 +20,12 @@ config ISA_DEBUG
 
 config SGA
     bool
+    default y if PC
     depends on ISA_BUS
 
 config ISA_TESTDEV
     bool
+    default y if PC
 
 config PCI_TESTDEV
     bool
@@ -99,6 +102,7 @@ config IOTKIT_SYSINFO
 
 config PVPANIC
     bool
+    default y if PC
     depends on ISA_BUS
 
 config AUX
diff --git a/hw/pci-bridge/Kconfig b/hw/pci-bridge/Kconfig
index c8ccf71259..067861ade4 100644
--- a/hw/pci-bridge/Kconfig
+++ b/hw/pci-bridge/Kconfig
@@ -5,6 +5,7 @@ config PCIE_PORT
 
 config PXB
     bool
+    default y if PC
 
 config XIO3130
     bool
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index a021c742de..51921eb63f 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -15,6 +15,7 @@ config DS1338
 
 config HPET
     bool
+    default y if PC
 
 config I8254
     bool
-- 
2.17.1
