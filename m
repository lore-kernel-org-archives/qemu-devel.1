Received: from eggs.gnu.org ([209.51.188.92]:36122)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rc-0007Hz-73
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gp6rb-0003PV-Ap
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:60113)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gp6rb-0002jN-30
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 02:34:19 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Thu, 31 Jan 2019 15:32:33 +0800
Message-Id: <20190131073234.18037-27-yang.zhong@intel.com>
In-Reply-To: <20190131073234.18037-1-yang.zhong@intel.com>
References: <20190131073234.18037-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [PATCH v1 26/27] hw/i2c/Makefile.objs: Create new
 CONFIG_* variables for EEPROM and ACPI controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, thuth@redhat.com, yang.zhong@intel.com

From: Paolo Bonzini <pbonzini@redhat.com>

Create separate variables for these components, they are
used in many boards but not all.  This allows finer-grain
selection of the included code with default-configs/*.mak.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak         | 1 +
 default-configs/i386-softmmu.mak        | 2 ++
 default-configs/mips-softmmu-common.mak | 2 ++
 default-configs/ppc-softmmu.mak         | 1 +
 hw/i2c/Makefile.objs                    | 5 +++--
 5 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index d3fc82256f..d2c8b52f6d 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -150,6 +150,7 @@ CONFIG_ACPI=y
 CONFIG_ARM_VIRT=y
 CONFIG_SMBIOS=y
 CONFIG_ASPEED_SOC=y
+CONFIG_SMBUS_EEPROM=y
 CONFIG_GPIO_KEY=y
 CONFIG_MSF2=y
 CONFIG_FW_CFG_DMA=y
diff --git a/default-configs/i386-softmmu.mak b/default-configs/i386-softmmu.mak
index 71c9f6fbcb..15b628757b 100644
--- a/default-configs/i386-softmmu.mak
+++ b/default-configs/i386-softmmu.mak
@@ -62,6 +62,8 @@ CONFIG_I82801B11=y
 CONFIG_SMBIOS=y
 CONFIG_PXB=y
 CONFIG_ACPI_VMGENID=y
+CONFIG_ACPI_SMBUS=y
+CONFIG_SMBUS_EEPROM=y
 CONFIG_FW_CFG_DMA=y
 CONFIG_I2C=y
 CONFIG_SEV=$(CONFIG_KVM)
diff --git a/default-configs/mips-softmmu-common.mak b/default-configs/mips-softmmu-common.mak
index 479fb4d900..ded74980e1 100644
--- a/default-configs/mips-softmmu-common.mak
+++ b/default-configs/mips-softmmu-common.mak
@@ -39,3 +39,5 @@ CONFIG_I2C=y
 CONFIG_R4K=y
 CONFIG_MALTA=y
 CONFIG_MIPSSIM=y
+CONFIG_ACPI_SMBUS=y
+CONFIG_SMBUS_EEPROM=y
diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 7f80f0ccba..52acb7cf39 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -36,6 +36,7 @@ CONFIG_AT24C=y
 CONFIG_BITBANG_I2C=y
 CONFIG_M41T80=y
 CONFIG_VGA_CIRRUS=y
+CONFIG_SMBUS_EEPROM=y
 
 # For Macs
 CONFIG_ESCC=y
diff --git a/hw/i2c/Makefile.objs b/hw/i2c/Makefile.objs
index 82e747e1cd..cecee486f7 100644
--- a/hw/i2c/Makefile.objs
+++ b/hw/i2c/Makefile.objs
@@ -1,8 +1,9 @@
-common-obj-$(CONFIG_I2C) += core.o smbus.o smbus_eeprom.o
+common-obj-$(CONFIG_I2C) += core.o smbus.o
+common-obj-$(CONFIG_SMBUS_EEPROM) += smbus_eeprom.o
 common-obj-$(CONFIG_DDC) += i2c-ddc.o
 common-obj-$(CONFIG_VERSATILE_I2C) += versatile_i2c.o
 common-obj-$(CONFIG_ACPI_X86) += smbus_ich9.o
-common-obj-$(CONFIG_APM) += pm_smbus.o
+common-obj-$(CONFIG_ACPI_SMBUS) += pm_smbus.o
 common-obj-$(CONFIG_BITBANG_I2C) += bitbang_i2c.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_i2c.o
 common-obj-$(CONFIG_IMX_I2C) += imx_i2c.o
-- 
2.17.1
