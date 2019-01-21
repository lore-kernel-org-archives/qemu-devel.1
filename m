Received: from eggs.gnu.org ([209.51.188.92]:51596)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy3-0004Ij-So
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gldy1-00043l-Lh
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:39 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36960)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gldxz-0003vh-Jr
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 13:06:37 -0500
Received: by mail-wm1-x343.google.com with SMTP id g67so11691690wmd.2
	for <qemu-devel@nongnu.org>; Mon, 21 Jan 2019 10:06:29 -0800 (PST)
Received: from 640k.lan ([93.56.166.5]) by smtp.gmail.com with ESMTPSA id
	133sm56197732wme.9.2019.01.21.10.06.26 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 21 Jan 2019 10:06:26 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 21 Jan 2019 19:05:36 +0100
Message-Id: <1548093980-43088-6-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
References: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/49] vhost: restrict Linux dependency to
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
 hw/net/vhost_net.c         |  3 +--
 hw/virtio/Makefile.objs    |  8 +++++---
 hw/virtio/vhost-backend.c  | 12 ++++++++++--
 hw/virtio/vhost-user.c     | 13 ++++++++++++-
 hw/virtio/vhost.c          |  2 +-
 7 files changed, 33 insertions(+), 14 deletions(-)

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
index ecb4420..b653aa0 100644
--- a/default-configs/virtio.mak
+++ b/default-configs/virtio.mak
@@ -1,5 +1,5 @@
-CONFIG_VHOST_USER_SCSI=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
-CONFIG_VHOST_USER_BLK=$(call land,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))
+CONFIG_VHOST_USER_SCSI=$(CONFIG_VHOST_USER)
+CONFIG_VHOST_USER_BLK=$(CONFIG_VHOST_USER)
 CONFIG_VIRTIO=y
 CONFIG_VIRTIO_9P=$(CONFIG_VIRTFS)
 CONFIG_VIRTIO_BALLOON=y
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 2a300ee..ae3ca23 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -18,14 +18,13 @@
 #include "net/tap.h"
 #include "net/vhost-user.h"
 
+#include "standard-headers/linux/vhost_types.h"
 #include "hw/virtio/virtio-net.h"
 #include "net/vhost_net.h"
 #include "qemu/error-report.h"
 
 
-#include <linux/vhost.h>
 #include <sys/socket.h>
-#include <linux/kvm.h>
 #include <netpacket/packet.h>
 #include <net/ethernet.h>
 #include <net/if.h>
diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index ea7913d..d8685a1 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -2,15 +2,18 @@ ifeq ($(CONFIG_VIRTIO),y)
 common-obj-y += virtio-bus.o
 obj-y += virtio.o
 
+obj-$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX)) += vhost.o vhost-backend.o
+common-obj-$(call lnot,$(call lor,$(CONFIG_VHOST_USER),$(CONFIG_LINUX))) += vhost-stub.o
+obj-$(CONFIG_VHOST_USER) += vhost-user.o
+
 common-obj-$(CONFIG_VIRTIO_RNG) += virtio-rng.o
 common-obj-$(CONFIG_VIRTIO_PCI) += virtio-pci.o
 common-obj-$(CONFIG_VIRTIO_MMIO) += virtio-mmio.o
 obj-$(CONFIG_VIRTIO_BALLOON) += virtio-balloon.o
 obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
 obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
-
-obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
+
 ifeq ($(CONFIG_PCI),y)
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-pci.o
 obj-$(CONFIG_VHOST_USER_BLK) += vhost-user-blk-pci.o
@@ -28,5 +31,4 @@ obj-$(CONFIG_VIRTIO_SERIAL) += virtio-serial-pci.o
 endif
 endif
 
-common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
 common-obj-$(CONFIG_ALL) += vhost-stub.o
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 7f09efa..e0f0bb7 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -9,11 +9,14 @@
  */
 
 #include "qemu/osdep.h"
-#include <linux/vhost.h>
-#include <sys/ioctl.h>
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
 #include "qemu/error-report.h"
+#include "standard-headers/linux/vhost_types.h"
+
+#ifdef CONFIG_LINUX
+#include <linux/vhost.h>
+#include <sys/ioctl.h>
 
 static int vhost_kernel_call(struct vhost_dev *dev, unsigned long int request,
                              void *arg)
@@ -265,18 +268,23 @@ static const VhostOps kernel_ops = {
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
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 564a31d..0d6c64e 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -27,8 +27,12 @@
 #include <sys/ioctl.h>
 #include <sys/socket.h>
 #include <sys/un.h>
-#include <linux/vhost.h>
+
+#include "standard-headers/linux/vhost_types.h"
+
+#ifdef CONFIG_LINUX
 #include <linux/userfaultfd.h>
+#endif
 
 #define VHOST_MEMORY_MAX_NREGIONS    8
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
@@ -1110,6 +1114,7 @@ out:
     return ret;
 }
 
+#ifdef CONFIG_LINUX
 /*
  * Called back from the postcopy fault thread when a fault is received on our
  * ufd.
@@ -1177,6 +1182,7 @@ static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
     trace_vhost_user_postcopy_waker_nomatch(qemu_ram_get_idstr(rb), offset);
     return 0;
 }
+#endif
 
 /*
  * Called at the start of an inbound postcopy on reception of the
@@ -1184,6 +1190,7 @@ static int vhost_user_postcopy_waker(struct PostCopyFD *pcfd, RAMBlock *rb,
  */
 static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
 {
+#ifdef CONFIG_LINUX
     struct vhost_user *u = dev->opaque;
     CharBackend *chr = u->user->chr;
     int ufd;
@@ -1227,6 +1234,10 @@ static int vhost_user_postcopy_advise(struct vhost_dev *dev, Error **errp)
     u->postcopy_fd.idstr = "vhost-user"; /* Need to find unique name */
     postcopy_register_shared_ufd(&u->postcopy_fd);
     return 0;
+#else
+    error_setg(errp, "Postcopy not supported on non-Linux systems");
+    return -1;
+#endif
 }
 
 /*
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 569c405..311432f 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -21,7 +21,7 @@
 #include "qemu/range.h"
 #include "qemu/error-report.h"
 #include "qemu/memfd.h"
-#include <linux/vhost.h>
+#include "standard-headers/linux/vhost_types.h"
 #include "exec/address-spaces.h"
 #include "hw/virtio/virtio-bus.h"
 #include "hw/virtio/virtio-access.h"
-- 
1.8.3.1
