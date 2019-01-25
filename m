Received: from eggs.gnu.org ([209.51.188.92]:58658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyPB-00082U-TD
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gmyP9-0002Jc-Ol
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:09 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39528)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gmyP7-0002HU-Lx
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 05:08:07 -0500
Received: by mail-wm1-x343.google.com with SMTP id y8so6010472wmi.4
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 02:08:05 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 25 Jan 2019 11:07:10 +0100
Message-Id: <1548410831-19553-52-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
References: <1548410831-19553-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 51/52] i386-softmmu.mak: remove all CONFIG_*
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
Cc: yang.zhong@intel.com, thuth@redhat.com

From: Yang Zhong <yang.zhong@intel.com>

%-softmmu.mak only keep boards definitions in Kconfig mode.

Signed-off-by: Yang Zhong <yang.zhong@intel.com>
Message-Id: <20190123065618.3520-43-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/i386-softmmu.mak | 18 ------------------
 hw/acpi/Kconfig                  |  6 ++++++
 hw/i386/Kconfig                  |  5 +++++
 hw/ipmi/Kconfig                  |  8 ++++++++
 hw/mem/Kconfig                   |  2 ++
 hw/misc/Kconfig                  |  4 ++++
 hw/pci-bridge/Kconfig            |  1 +
 hw/timer/Kconfig                 |  1 +
 8 files changed, 27 insertions(+), 18 deletions(-)

diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index f29f83e..07b1e82 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -1,25 +1,7 @@
 # Default configuration for i386-softmmu
 
-CONFIG_VMXNET3_PCI=y
-CONFIG_IPMI=y
-CONFIG_IPMI_LOCAL=y
-CONFIG_IPMI_EXTERN=y
-CONFIG_ISA_IPMI_KCS=y
-CONFIG_ISA_IPMI_BT=y
-
 # Optional devices:
 #
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
 CONFIG_PCI_DEVICES=y
 
 # Boards:
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
index 966c97c..8f0d6ce 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -5,6 +5,10 @@ config SEV
 config PC
     bool
 
+config SEV
+    bool
+    default y if PC && KVM
+
 config PC
     bool
     select ISA_DEBUG
@@ -28,6 +32,7 @@ config PC_ACPI
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
     select SMBUS_EEPROM
+    select PFLASH_CFI01
     depends on ACPI_SMBUS
 
 config I440FX
diff --git a/hw/ipmi/Kconfig b/hw/ipmi/Kconfig
index 68f8ba1..b15c7b3 100644
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
index a3a4372..d1e635c 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -6,3 +6,5 @@ config MEM_DEVICE
 
 config NVDIMM
     bool
+    default y
+    depends on PC
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 55170f6..823135c 100644
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
@@ -100,6 +103,7 @@ config IOTKIT_SYSINFO
 
 config PVPANIC
     bool
+    default y if PC
     depends on ISA_BUS
 
 config AUX
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
