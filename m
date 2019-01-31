Received: from eggs.gnu.org ([209.51.188.92]:59707)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCnA-0002E4-Ob
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:54:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCn9-0006Yu-3c
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:54:08 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 31 Jan 2019 14:53:30 +0100
Message-Id: <1548942810-22942-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1548942810-22942-1-git-send-email-thuth@redhat.com>
References: <1548942810-22942-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 5/5] ppc: Express dependencies of the
 embedded machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, yang.zhong@intel.com

This makes it much easier if the users want to disable some of
the embedded machines for their builds.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc-softmmu.mak | 18 ++++--------------
 hw/nvram/Kconfig                |  2 ++
 hw/ppc/Kconfig                  | 12 ++++++++++++
 3 files changed, 18 insertions(+), 14 deletions(-)

diff --git a/default-configs/ppc-softmmu.mak b/default-configs/ppc-softmmu.mak
index 5265d8a..5192aca 100644
--- a/default-configs/ppc-softmmu.mak
+++ b/default-configs/ppc-softmmu.mak
@@ -1,27 +1,17 @@
 # Default configuration for ppc-softmmu
 
-CONFIG_PCI=y
 CONFIG_PCI_DEVICES=y
-CONFIG_ISA_BUS=y
 CONFIG_TEST_DEVICES=y
 
-# For embedded PPCs:
-CONFIG_PPC4XX=y
-CONFIG_M48T59=y
+# FIXME: CONFIG_SERIAL is currently still required to link all of the
+# ppc machines (due to the usage of serial_mm_init() in ppc405_uc.c).
 CONFIG_SERIAL=y
-CONFIG_OPENPIC=y
-CONFIG_PPCE500_PCI=y
-CONFIG_PFLASH_CFI01=y
-CONFIG_PFLASH_CFI02=y
-CONFIG_XILINX=y
-CONFIG_XILINX_ETHLITE=y
+
+# For embedded PPCs:
 CONFIG_E500=y
-CONFIG_PLATFORM_BUS=y
-CONFIG_ETSEC=y
 CONFIG_PPC405=y
 CONFIG_PPC440=y
 CONFIG_VIRTEX=y
-CONFIG_PCI_EXPRESS=y
 
 # For Sam460ex
 CONFIG_SAM460EX=y
diff --git a/hw/nvram/Kconfig b/hw/nvram/Kconfig
index 1f5ec95..4f44f9b 100644
--- a/hw/nvram/Kconfig
+++ b/hw/nvram/Kconfig
@@ -3,6 +3,8 @@ config DS1225Y
 
 config AT24C
     bool
+    default y if E500
+    depends on I2C
 
 config MAC_NVRAM
     bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 35e3704..4085107 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -21,9 +21,14 @@ config POWERNV
 
 config PPC405
     bool
+    select M48T59
+    select PFLASH_CFI02
+    select PPC4XX
 
 config PPC440
     bool
+    select PCI_EXPRESS
+    select PPC4XX
 
 config PPC4XX
     bool
@@ -72,9 +77,16 @@ config MAC_NEWWORLD
 
 config E500
     bool
+    select ETSEC
+    select OPENPIC
+    select PLATFORM_BUS
+    select PPCE500_PCI
 
 config VIRTEX
     bool
+    select PFLASH_CFI01
+    select XILINX
+    select XILINX_ETHLITE
 
 config MAC_DBDMA
     bool
-- 
1.8.3.1
