Received: from eggs.gnu.org ([209.51.188.92]:57678)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwC-0002Fj-Jj
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwA-0002Qj-4Q
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:11 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43200)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnw9-0002PV-A0
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:09 -0500
Received: by mail-wr1-x444.google.com with SMTP id r2so785336wrv.10
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:08 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:13 +0100
Message-Id: <1549562254-41157-31-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 30/51] ppc64: Express dependencies of 'pseries'
 and 'powernv' machines with kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, philmd@redhat.com

From: Thomas Huth <thuth@redhat.com>

The POWERNV switch should always select ISA_IPMI_BT, then the other
IPMI options are turned on automatically now.
CONFIG_DIMM should always be selected by the pseries machine,
which in turn depends on CONFIG_MEM_DEVICE since DIMM implements
this interface.
CONFIG_VIRTIO_VGA can be dropped from default-configs/ppc64-softmmu.mak
completely since this device is already automatically enabled via
hw/display/Kconfig now.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/ppc64-softmmu.mak |  5 -----
 hw/intc/Kconfig                   |  6 ++----
 hw/mem/Kconfig                    |  1 +
 hw/ppc/Kconfig                    | 22 ++++++++++++++++++++--
 4 files changed, 23 insertions(+), 11 deletions(-)

diff --git a/default-configs/ppc64-softmmu.mak b/default-configs/ppc64-softmmu.mak
index d642b67..cca5266 100644
--- a/default-configs/ppc64-softmmu.mak
+++ b/default-configs/ppc64-softmmu.mak
@@ -5,11 +5,6 @@ include ppc-softmmu.mak
 
 # For PowerNV
 CONFIG_POWERNV=y
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
index fb085d7..be6440e 100644
--- a/hw/ppc/Kconfig
+++ b/hw/ppc/Kconfig
@@ -1,11 +1,29 @@
 config PSERIES
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select DIMM
+    select PCI
+    select VFIO
+    select XICS_SPAPR
+    select XIVE_SPAPR
+    select SPAPR_VSCSI
 
 config SPAPR_RNG
     bool
+    default y
+    depends on PSERIES
 
 config POWERNV
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    select ISA_IPMI_BT
+    select IPMI_LOCAL
+    select ISA_BUS
+    select MC146818RTC
+    select XICS
+    select XIVE
 
 config PPC405
     bool
@@ -39,10 +57,10 @@ config VIRTEX
 
 config XIVE
     bool
-    default y
-    depends on PSERIES
+    depends on POWERNV || PSERIES
 
 config XIVE_SPAPR
     bool
     default y
     depends on PSERIES
+    select XIVE
-- 
1.8.3.1
