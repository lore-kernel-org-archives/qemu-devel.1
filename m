Received: from eggs.gnu.org ([209.51.188.92]:51852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtqG0-00021O-SO
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:51:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gtq4w-0005yx-Hp
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 03:39:39 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 13 Feb 2019 09:38:06 +0100
Message-Id: <1550047098-1210-14-git-send-email-thuth@redhat.com>
In-Reply-To: <1550047098-1210-1-git-send-email-thuth@redhat.com>
References: <1550047098-1210-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 13/25] hw/arm: Express dependencies of the
 virt machine with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: yang.zhong@intel.com, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, philmd@redhat.com

Dependencies have been determined by looking at hw/arm/virt.c

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 14 +-------------
 hw/arm/Kconfig                  | 19 +++++++++++++++++++
 hw/arm/Makefile.objs            |  3 ++-
 3 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index b2e31b3..9db6808 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -3,6 +3,7 @@
 # TODO: ARM_V7M is currently always required - make this more flexible!
 CONFIG_ARM_V7M=y
 
+CONFIG_ARM_VIRT=y
 CONFIG_EXYNOS4=y
 CONFIG_HIGHBANK=y
 CONFIG_INTEGRATOR=y
@@ -28,8 +29,6 @@ CONFIG_VGA=y
 CONFIG_SSI_M25P80=y
 CONFIG_ALLWINNER_EMAC=y
 CONFIG_IMX_FEC=y
-CONFIG_PLATFORM_BUS=y
-CONFIG_VIRTIO_MMIO=y
 
 CONFIG_NETDUINO2=y
 
@@ -63,12 +62,6 @@ CONFIG_IOTKIT_SYSCTL=y
 CONFIG_IOTKIT_SYSINFO=y
 CONFIG_ARMSSE_CPUID=y
 
-CONFIG_PCI_EXPRESS=y
-CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
-CONFIG_VFIO_PLATFORM=y
-CONFIG_VFIO_XGMAC=y
-CONFIG_VFIO_AMD_XGBE=y
-
 CONFIG_ALLWINNER_A10_PIT=y
 CONFIG_ALLWINNER_A10_PIC=y
 CONFIG_ALLWINNER_A10=y
@@ -84,10 +77,5 @@ CONFIG_PCIE_PORT=y
 CONFIG_XIO3130=y
 CONFIG_IOH3420=y
 CONFIG_I82801B11=y
-CONFIG_ACPI=y
-CONFIG_ARM_VIRT=y
-CONFIG_SMBIOS=y
-CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
-CONFIG_FW_CFG_DMA=y
 CONFIG_PCI_EXPRESS_DESIGNWARE=y
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a4fe2c8..3d580fa 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,5 +1,23 @@
 config ARM_VIRT
     bool
+    imply PCI_DEVICES
+    imply VFIO_AMD_XGBE
+    imply VFIO_XGMAC
+    select A15MPCORE
+    select ACPI
+    select ARM_SMMUV3
+    select GPIO_KEY
+    select FW_CFG_DMA
+    select PCI_EXPRESS
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select PFLASH_CFI01
+    select PL011 # UART
+    select PL031 # RTC
+    select PL061 # GPIO
+    select PLATFORM_BUS
+    select SMBIOS
+    select VIRTIO_MMIO
+    select VFIO_PLATFORM
 
 config CHEETAH
     bool
@@ -314,6 +332,7 @@ config A9MPCORE
 
 config A15MPCORE
     bool
+    select ARM_GIC
 
 config ARM11MPCORE
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 053fcb6..f17187f 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,4 +1,5 @@
-obj-y += boot.o sysbus-fdt.o
+obj-y += boot.o
+obj-$(CONFIG_PLATFORM_BUS) += sysbus-fdt.o
 obj-$(CONFIG_ARM_VIRT) += virt.o
 obj-$(CONFIG_ACPI) += virt-acpi-build.o
 obj-$(CONFIG_DIGIC) += digic_boards.o
-- 
1.8.3.1
