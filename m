Received: from eggs.gnu.org ([209.51.188.92]:44181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomPN-00029Q-9G
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:43:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gomPL-0004Wf-HJ
	for qemu-devel@nongnu.org; Wed, 30 Jan 2019 04:43:49 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Wed, 30 Jan 2019 10:43:07 +0100
Message-Id: <1548841387-7670-6-git-send-email-thuth@redhat.com>
In-Reply-To: <1548841387-7670-1-git-send-email-thuth@redhat.com>
References: <3f01a301-d639-dbe7-f522-42a50e2d443e@redhat.com>
	<1548841387-7670-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 5/5] ppc: Express dependencies of the
 embedded machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: pbonzini@redhat.com, qemu-ppc@nongnu.org, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

This makes it much easier if the users want to disable some of
the embedded machines for their builds.

Cc: Edgar E. Iglesias <edgar.iglesias@gmail.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc-softmmu.mak | 18 ++++--------------
 hw/ppc/Kconfig                  | 12 ++++++++++++
 2 files changed, 16 insertions(+), 14 deletions(-)

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
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index 8bd25ed..ab9b828 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -18,9 +18,14 @@ config POWERNV
 
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
@@ -69,9 +74,16 @@ config MAC_NEWWORLD
 
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
