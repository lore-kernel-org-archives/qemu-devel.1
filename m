Received: from eggs.gnu.org ([209.51.188.92]:60202)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWO-000560-Gs
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1gmCWM-0003s3-58
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:23 -0500
Received: from mga18.intel.com ([134.134.136.126]:36921)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1gmCWL-0002NF-Pc
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 02:00:22 -0500
From: Yang Zhong <yang.zhong@intel.com>
Date: Wed, 23 Jan 2019 14:56:07 +0800
Message-Id: <20190123065618.3520-34-yang.zhong@intel.com>
In-Reply-To: <20190123065618.3520-1-yang.zhong@intel.com>
References: <20190123065618.3520-1-yang.zhong@intel.com>
Subject: [Qemu-devel] [RFC PATCH v4 33/44] scsi: express dependencies with
 Kconfig
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

From: Paolo Bonzini <pbonzini@redhat.com>

This automatically removes the SCSI subsystem from the
binary altogether if no controllers are selected.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Yang Zhong <yang.zhong@intel.com>
---
 hw/scsi/Kconfig       | 12 ++++++++++++
 hw/scsi/Makefile.objs |  2 +-
 hw/usb/Kconfig        |  2 ++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/Kconfig b/hw/scsi/Kconfig
index 812a12522b..7a9d373382 100644
--- a/hw/scsi/Kconfig
+++ b/hw/scsi/Kconfig
@@ -5,24 +5,29 @@ config LSI_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config MPTSAS_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config MEGASAS_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config VMW_PVSCSI_SCSI_PCI
     bool
     default y
     depends on PCI
+    select SCSI
 
 config ESP
     bool
+    select SCSI
 
 config ESP_PCI
     bool
@@ -30,8 +35,15 @@ config ESP_PCI
     depends on PCI
     select ESP
 
+config SPAPR_VSCSI
+    bool
+    depends on PSERIES
+    select SCSI
+
 config VIRTIO_SCSI
     bool
+    default y
+    select SCSI
 
 config VHOST_USER_SCSI
     bool
diff --git a/hw/scsi/Makefile.objs b/hw/scsi/Makefile.objs
index 45167baeaf..54b36ed8b1 100644
--- a/hw/scsi/Makefile.objs
+++ b/hw/scsi/Makefile.objs
@@ -6,7 +6,7 @@ common-obj-$(CONFIG_MEGASAS_SCSI_PCI) += megasas.o
 common-obj-$(CONFIG_VMW_PVSCSI_SCSI_PCI) += vmw_pvscsi.o
 common-obj-$(CONFIG_ESP) += esp.o
 common-obj-$(CONFIG_ESP_PCI) += esp-pci.o
-obj-$(CONFIG_PSERIES) += spapr_vscsi.o
+obj-$(CONFIG_SPAPR_VSCSI) += spapr_vscsi.o
 
 ifeq ($(CONFIG_VIRTIO_SCSI),y)
 obj-y += virtio-scsi.o virtio-scsi-dataplane.o
diff --git a/hw/usb/Kconfig b/hw/usb/Kconfig
index 0b8f41040e..db46c56cc8 100644
--- a/hw/usb/Kconfig
+++ b/hw/usb/Kconfig
@@ -52,11 +52,13 @@ config USB_STORAGE_BOT
     bool
     default y
     depends on USB
+    select SCSI
 
 config USB_STORAGE_UAS
     bool
     default y
     depends on USB
+    select SCSI
 
 config USB_AUDIO
     bool
-- 
2.17.1
