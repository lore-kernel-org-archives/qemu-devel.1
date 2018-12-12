Received: from eggs.gnu.org ([2001:4830:134:3::10]:52731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N8-0001ND-9A
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gX6N5-0000g7-OU
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:26 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:32991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gX6N5-0000Vq-Du
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 10:24:23 -0500
Received: by mail-wr1-x430.google.com with SMTP id c14so18140375wrr.0
	for <qemu-devel@nongnu.org>; Wed, 12 Dec 2018 07:24:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	u10sm15878859wrr.33.2018.12.12.07.24.03 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 12 Dec 2018 07:24:03 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 12 Dec 2018 16:23:04 +0100
Message-Id: <1544628195-37728-44-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
References: <1544628195-37728-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 43/54] vhost: restrict Linux dependency to
 kernel vhost
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

vhost-user does not depend on Linux; it can run on any POSIX system.  Restrict
vhost-kernel to Linux in hw/virtio/vhost-backend.c, everything else can be
compiled on all POSIX systems.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Message-Id: <1543851204-41186-4-git-send-email-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/Makefile.objs     |  5 ++---
 default-configs/virtio.mak |  4 ++--
 hw/virtio/Makefile.objs    |  5 +++--
 hw/virtio/vhost-backend.c  | 11 +++++++++--
 4 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/backends/Makefile.objs b/backends/Makefile.objs
index 717fcbd..ff619d3 100644
--- a/backends/Makefile.objs
+++ b/backends/Makefile.objs
@@ -9,10 +9,9 @@ common-obj-$(CONFIG_POSIX) += hostmem-file.o
 common-obj-y += cryptodev.o
 common-obj-y += cryptodev-builtin.o
 
-ifeq ($(CONFIG_VIRTIO),y)
+ifeq ($(CONFIG_VIRTIO_CRYPTO),y)
 common-obj-y += cryptodev-vhost.o
-common-obj-$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += \
-    cryptodev-vhost-user.o
+common-obj-$(CONFIG_VHOST_CRYPTO) += cryptodev-vhost-user.o
 endif
 
 common-obj-$(CONFIG_LINUX) += hostmem-memfd.o
diff --git a/default-configs/virtio.mak b/default-configs/virtio.mak
index 1304849..340050a 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,5 +1,5 @@
-CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
-CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_VHOST_USER_SCSI=$(CONFIG_VHOST_USER)
+CONFIG_VHOST_USER_BLK=$(CONFIG_VHOST_USER)
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_9P=y
 CONFIG_VIRTIO_BALLOON=y
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 1b2799c..e8eff80 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -9,9 +9,10 @@ obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
 
-obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
+obj-$(CONFIG_VHOST_USER) += vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
+obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += vhost.o vhost-backend.o
+common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))) += vhost-stub.o
 endif
 
-common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
 common-obj-$(CONFIG_ALL) += vhost-stub.o
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 7f09efa..b5d2e30 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -9,12 +9,14 @@
  */
 
 #include "qemu/osdep.h"
-#include <linux/vhost.h>
-#include <sys/ioctl.h>
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "qemu/error-report.h"
 
+#ifdef CONFIG_LINUX
+#include <linux/vhost.h>
+#include <sys/ioctl.h>
+
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
 {
@@ -265,18 +267,23 @@ static const VhostOps kernel_ops = {
         .vhost_set_iotlb_callback = vhost_kernel_set_iotlb_callback,
         .vhost_send_device_iotlb_msg = vhost_kernel_send_device_iotlb_msg,
 };
+#endif
 
 int vhost_set_backend_type(struct vhost_dev *dev, VhostBackendType backend_type)
 {
     int r = 0;
 
     switch (backend_type) {
+#ifdef CONFIG_LINUX
     case VHOST_BACKEND_TYPE_KERNEL:
         dev->vhost_ops = &kernel_ops;
         break;
+#endif
+#ifdef CONFIG_VHOST_USER
     case VHOST_BACKEND_TYPE_USER:
         dev->vhost_ops = &user_ops;
         break;
+#endif
     default:
         error_report("Unknown vhost backend type");
         r = -1;
-- 
1.8.3.1
