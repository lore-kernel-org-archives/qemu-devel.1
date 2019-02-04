Received: from eggs.gnu.org ([209.51.188.92]:60032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7v-00064v-PS
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gqj7u-0004Ei-BP
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:51 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:51435)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gqj7u-00044p-2q
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:37:50 -0500
Received: by mail-wm1-x336.google.com with SMTP id b11so980860wmj.1
	for <qemu-devel@nongnu.org>; Mon, 04 Feb 2019 10:37:32 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	s132sm8836236wmf.28.2019.02.04.10.37.30 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 04 Feb 2019 10:37:30 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon,  4 Feb 2019 19:36:14 +0100
Message-Id: <1549305379-51117-73-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
References: <1549305379-51117-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 72/77] hw/vfio/Makefile.objs: Create new
 CONFIG_* variables for VFIO core and PCI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Make hw/vfio configurable and add new CONFIG_VFIO_* to the
default-configs/s390x*-softmmu.mak.  This allow a finer-grain
selection of the various VFIO backends.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <20190202072456.6468-28-yang.zhong@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/arm-softmmu.mak   | 2 ++
 default-configs/pci.mak           | 2 ++
 default-configs/s390x-softmmu.mak | 5 +++--
 hw/Makefile.objs                  | 2 +-
 hw/vfio/Makefile.objs             | 7 +++----
 5 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmmu.mak
index d700d09..734ca72 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -124,6 +124,8 @@ CONFIG_VERSATILE_PCI=y
 CONFIG_VERSATILE_I2C=y
 
 CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=y
+CONFIG_VFIO=$(CONFIG_LINUX)
+CONFIG_VFIO_PLATFORM=y
 CONFIG_VFIO_XGMAC=y
 CONFIG_VFIO_AMD_XGBE=y
 
diff --git a/default-configs/pci.mak b/default-configs/pci.mak
index 83738cb..037636f 100644
--- a/default-configs/pci.mak
+++ b/default-configs/pci.mak
@@ -47,3 +47,5 @@ CONFIG_VGA_PCI=y
 CONFIG_BOCHS_DISPLAY=y
 CONFIG_IVSHMEM_DEVICE=$(CONFIG_IVSHMEM)
 CONFIG_ROCKER=y
+CONFIG_VFIO=$(CONFIG_LINUX)
+CONFIG_VFIO_PCI=y
diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 8bb7e43..6f2c6ce 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -5,7 +5,8 @@ CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
 CONFIG_S390_FLIC=y
 CONFIG_S390_FLIC_KVM=$(CONFIG_KVM)
-CONFIG_VFIO_CCW=$(CONFIG_LINUX)
 CONFIG_WDT_DIAG288=y
-CONFIG_VFIO_AP=$(CONFIG_LINUX)
 CONFIG_S390_CCW_VIRTIO=y
+CONFIG_VFIO=$(CONFIG_LINUX)
+CONFIG_VFIO_CCW=y
+CONFIG_VFIO_AP=y
diff --git a/hw/Makefile.objs b/hw/Makefile.objs
index 22dd211..e2fcd6a 100644
--- a/hw/Makefile.objs
+++ b/hw/Makefile.objs
@@ -30,7 +30,7 @@ devices-dirs-$(CONFIG_SOFTMMU) += ssi/
 devices-dirs-$(CONFIG_SOFTMMU) += timer/
 devices-dirs-$(CONFIG_TPM) += tpm/
 devices-dirs-$(CONFIG_SOFTMMU) += usb/
-devices-dirs-$(CONFIG_LINUX) += vfio/
+devices-dirs-$(CONFIG_VFIO) += vfio/
 devices-dirs-$(CONFIG_SOFTMMU) += virtio/
 devices-dirs-$(CONFIG_SOFTMMU) += watchdog/
 devices-dirs-$(CONFIG_SOFTMMU) += xen/
diff --git a/hw/vfio/Makefile.objs b/hw/vfio/Makefile.objs
index 9180589..abad8b8 100644
--- a/hw/vfio/Makefile.objs
+++ b/hw/vfio/Makefile.objs
@@ -1,8 +1,7 @@
-obj-$(CONFIG_SOFTMMU) += common.o
-obj-$(CONFIG_PCI) += pci.o pci-quirks.o display.o
+obj-y += common.o spapr.o
+obj-$(CONFIG_VFIO_PCI) += pci.o pci-quirks.o display.o
 obj-$(CONFIG_VFIO_CCW) += ccw.o
-obj-$(CONFIG_SOFTMMU) += platform.o
+obj-$(CONFIG_VFIO_PLATFORM) += platform.o
 obj-$(CONFIG_VFIO_XGMAC) += calxeda-xgmac.o
 obj-$(CONFIG_VFIO_AMD_XGBE) += amd-xgbe.o
-obj-$(CONFIG_SOFTMMU) += spapr.o
 obj-$(CONFIG_VFIO_AP) += ap.o
-- 
1.8.3.1
