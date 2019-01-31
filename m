Received: from eggs.gnu.org ([209.51.188.92]:59506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmp-0001wW-6P
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1gpCmo-0006Qh-8c
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 08:53:47 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Thu, 31 Jan 2019 14:53:26 +0100
Message-Id: <1548942810-22942-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1548942810-22942-1-git-send-email-thuth@redhat.com>
References: <1548942810-22942-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH v2 1/5] ppc64: Express dependencies of
 'pseries' and 'powernv' machines with kconfig
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

The POWERNV switch should always select ISA_IPMI_BT, then the other
IPMI options are turned on automatically now.
CONFIG_DIMM should always be selected by the pseries machine,
which in turn depends on CONFIG_MEM_DEVICE since DIMM implements
this interface.
CONFIG_VIRTIO_VGA can be dropped from default-configs/ppc64-softmmu.mak
completely since this device is already automatically enabled via
hw/display/Kconfig now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/ppc64-softmmu.mak |  8 --------
 hw/intc/Kconfig                   |  6 ++----
 hw/mem/Kconfig                    |  1 +
 hw/ppc/Kconfig                    | 18 ++++++++++++++----
 4 files changed, 17 insertions(+), 16 deletions(-)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index a0a9151..cca5266 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -5,14 +5,6 @@ include ppc-softmmu.mak
 
 # For PowerNV
 CONFIG_POWERNV=y
-CONFIG_IPMI=y
-CONFIG_IPMI_LOCAL=y
-CONFIG_IPMI_EXTERN=y
-CONFIG_ISA_IPMI_BT=y
 
 # For pSeries
 CONFIG_PSERIES=y
-CONFIG_VIRTIO_VGA=y
-CONFIG_MEM_DEVICE=y
-CONFIG_DIMM=y
-CONFIG_SPAPR_RNG=y
diff --git a/hw/intc/Kconfig b/hw/intc/Kconfig
index 6eea14e..de10a6b 100644
--- a/hw/intc/Kconfig
+++ b/hw/intc/Kconfig
@@ -31,13 +31,11 @@ config OPENPIC_KVM
 
 config XICS
     bool
-    default y
-    depends on PSERIES
+    depends on POWERNV || PSERIES
 
 config XICS_SPAPR
     bool
-    default y
-    depends on PSERIES
+    select XICS
 
 config XICS_KVM
     bool
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index d1e635c..620fd4c 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -1,5 +1,6 @@
 config DIMM
     bool
+    select MEM_DEVICE
 
 config MEM_DEVICE
     bool
diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
index b0095e1..4dbf866 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -1,11 +1,23 @@
 config PSERIES
     bool
+    select DIMM
+    select PCI
+    select VFIO
+    select XICS_SPAPR
+    select XIVE_SPAPR
 
 config SPAPR_RNG
     bool
+    default y
+    depends on PSERIES
 
 config POWERNV
     bool
+    select ISA_IPMI_BT
+    select ISA_BUS
+    select MC146818RTC
+    select XICS
+    select XIVE
 
 config PPC405
     bool
@@ -45,16 +57,14 @@ config MAC_PMU
 
 config XIVE
     bool
-    default y
-    depends on PSERIES
+    depends on POWERNV || PSERIES
 
 config MACIO_GPIO
     bool
 
 config XIVE_SPAPR
     bool
-    default y
-    depends on PSERIES
+    select XIVE
 
 config CUDA
     bool
-- 
1.8.3.1
