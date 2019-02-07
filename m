Received: from eggs.gnu.org ([209.51.188.92]:57855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwi-0002hP-Se
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1grnwZ-0002cf-8L
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:38 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:52274)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1grnwX-0002W3-8N
	for qemu-devel@nongnu.org; Thu, 07 Feb 2019 12:58:33 -0500
Received: by mail-wm1-x343.google.com with SMTP id m1so823375wml.2
	for <qemu-devel@nongnu.org>; Thu, 07 Feb 2019 09:58:22 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu,  7 Feb 2019 18:57:27 +0100
Message-Id: <1549562254-41157-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
References: <1549562254-41157-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 44/51] s390x: express dependencies with Kconfig
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

Instead of hard-coding all config switches in the config file
default-configs/s390x-softmmu.mak, let's use the new Kconfig files
to express the necessary dependencies: The S390_CCW_VIRTIO config switch
for the "s390-ccw-virtio" machine now selects all non-optional devices.

And since we already have the VIRTIO_PCI and VIRTIO_MMIO config switches
for the other two virtio transports, this patch also introduces a new
config switch VIRTIO_CCW for the third, s390x-specific virtio transport,
so that all three virtio transports are now handled in the same way.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 default-configs/s390x-softmmu.mak | 20 ++++++++++++--------
 hw/s390x/Kconfig                  |  9 +++++++++
 hw/s390x/Makefile.objs            |  4 +++-
 hw/virtio/Kconfig                 |  4 ++++
 4 files changed, 28 insertions(+), 9 deletions(-)

diff --git a/default-configs/s390x-softmmu.mak b/default-configs/s390x-softmmu.mak
index 2be5059..f2287a1 100644
--- a/default-configs/s390x-softmmu.mak
+++ b/default-configs/s390x-softmmu.mak
@@ -1,9 +1,13 @@
-CONFIG_PCI=y
-CONFIG_VIRTIO_PCI=y
-CONFIG_SCLPCONSOLE=y
-CONFIG_TERMINAL3270=y
-CONFIG_S390_FLIC=y
-CONFIG_WDT_DIAG288=y
+# Default configuration for s390x-softmmu
+
+# Uncomment the following lines to disable these optional devices:
+#
+#CONFIG_TERMINAL3270=n
+#CONFIG_VFIO_AP=n
+#CONFIG_VFIO_CCW=n
+#CONFIG_VIRTIO_PCI=n
+#CONFIG_WDT_DIAG288=n
+
+# Boards:
+#
 CONFIG_S390_CCW_VIRTIO=y
-CONFIG_VFIO_CCW=y
-CONFIG_VFIO_AP=y
diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
index 303db7f..a7046ea 100644
--- a/hw/s390x/Kconfig
+++ b/hw/s390x/Kconfig
@@ -1,2 +1,11 @@
 config S390_CCW_VIRTIO
     bool
+    imply VIRTIO_PCI
+    imply TERMINAL3270
+    imply VFIO_AP
+    imply VFIO_CCW
+    imply WDT_DIAG288
+    select PCI
+    select S390_FLIC
+    select SCLPCONSOLE
+    select VIRTIO_CCW
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index a18c471..9884979 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -6,7 +6,8 @@ obj-y += sclpcpu.o
 obj-y += ipl.o
 obj-y += css.o
 obj-$(CONFIG_S390_CCW_VIRTIO) += s390-virtio-ccw.o
-obj-y += 3270-ccw.o
+obj-$(CONFIG_TERMINAL3270) += 3270-ccw.o
+ifeq ($(CONFIG_VIRTIO_CCW),y)
 obj-y += virtio-ccw.o
 obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
@@ -19,6 +20,7 @@ obj-$(CONFIG_VIRTIO_NET) += virtio-ccw-net.o
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
