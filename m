Received: from eggs.gnu.org ([209.51.188.92]:42591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goPuZ-0008Pc-RA
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:42:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1goPuR-0002ee-NF
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 04:42:25 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Tue, 29 Jan 2019 10:42:14 +0100
Message-Id: <1548754934-6031-1-git-send-email-thuth@redhat.com>
In-Reply-To: <20190128170819.4998232d.cohuck@redhat.com>
References: <20190128170819.4998232d.cohuck@redhat.com>
Subject: [Qemu-devel] [PATCH v2] s390x: express dependencies with Kconfig
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, yang.zhong@intel.com
Cc: pbonzini@redhat.com, qemu-s390x@nongnu.org

Instead of hard-coding all config switches in the config file
default-configs/s390x-softmmu.mak, let's use the new Kconfig files
to express the necessary dependencies: The S390_CCW_VIRTIO config switch
for the "s390-ccw-virtio" machine now selects all non-optional devices.

And since we already have the VIRTIO_PCI and VIRTIO_MMIO config switches
for the other two virtio transports, this patch also introduces a new
config switch VIRTIO_CCW for the third, s390x-specific virtio transport,
so that all three virtio transports are now handled in the same way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 v2:
 - Use CONFIG_TERMINAL3270 for 3270-ccw.o
 - Use CONFIG_VIRTIO_CCW for all related devices in the Makefile

 default-configs/s390x-softmmu.mak | 12 ++++++++----
 hw/s390x/Kconfig                  |  4 ++++
 hw/s390x/Makefile.objs            |  4 +++-
 hw/virtio/Kconfig                 |  4 ++++
 4 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 2be5059..08b1683 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,9 +1,13 @@
-CONFIG_PCI=y
+# Default configuration for s390x-softmmu
+
+# Optional devices:
+#
 CONFIG_VIRTIO_PCI=y
-CONFIG_SCLPCONSOLE=y
 CONFIG_TERMINAL3270=y
-CONFIG_S390_FLIC=y
 CONFIG_WDT_DIAG288=y
-CONFIG_S390_CCW_VIRTIO=y
 CONFIG_VFIO_CCW=y
 CONFIG_VFIO_AP=y
+
+# Boards:
+#
+CONFIG_S390_CCW_VIRTIO=y
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 303db7f..9a36c39 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -1,2 +1,6 @@
 config S390_CCW_VIRTIO
     bool
+    select PCI
+    select S390_FLIC
+    select SCLPCONSOLE
+    select VIRTIO_CCW
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index a884aae..ac56a63 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -7,7 +7,8 @@ obj-y += sclpcpu.o
 obj-y += ipl.o
 obj-y += css.o
 obj-y += s390-virtio-ccw.o
-obj-y += 3270-ccw.o
+obj-$(CONFIG_TERMINAL3270) += 3270-ccw.o
+ifeq ($(CONFIG_VIRTIO_CCW),y)
 obj-y += virtio-ccw.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
@@ -20,6 +21,7 @@ obj-$(CONFIG_VIRTIO_NET) += virtio-ccw-net.o
 obj-$(CONFIG_VIRTIO_BLK) += virtio-ccw-blk.o
 obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
+endif
 obj-y += css-bridge.o
 obj-y += ccw-device.o
 obj-$(CONFIG_PCI) += s390-pci-bus.o s390-pci-inst.o
diff --git a/hw/virtio/Kconfig b/hw/virtio/Kconfig
index 74f4573..e0452de 100644
--- a/hw/virtio/Kconfig
+++ b/hw/virtio/Kconfig
@@ -16,6 +16,10 @@ config VIRTIO_MMIO
     bool
     select VIRTIO
 
+config VIRTIO_CCW
+    bool
+    select VIRTIO
+
 config VIRTIO_BALLOON
     bool
     default y
-- 
1.8.3.1
