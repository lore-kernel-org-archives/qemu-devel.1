Received: from eggs.gnu.org ([2001:4830:134:3::10]:44961)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968x-0005oM-75
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1d968u-0001zG-0C
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:62480)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1d968t-0001je-Lr
	for qemu-devel@nongnu.org; Fri, 12 May 2017 04:41:43 -0400
From: Wei Wang <wei.w.wang@intel.com>
Date: Fri, 12 May 2017 16:35:43 +0800
Message-Id: <1494578148-102868-12-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
References: <1494578148-102868-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v2 11/16] vhost-user: add asynchronous read for
 the vhost-user master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: stefanha@gmail.com, marcandre.lureau@gmail.com, mst@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org
Cc: Wei Wang <wei.w.wang@intel.com>

Enable the vhost-user master to asynchronously receive messages
from the slave. The vhost_user_asyn_read and vhost_user_can_read
stub functions are defined for platforms that do not support the
use of virtio.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/Makefile.objs        |  6 +++---
 hw/virtio/vhost-stub.c         | 11 +++++++++++
 hw/virtio/vhost-user.c         | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/vhost-user.h |  4 ++++
 include/net/vhost-user.h       |  4 ++++
 net/vhost-user.c               | 23 ++++++++++++++++++++---
 6 files changed, 83 insertions(+), 7 deletions(-)

diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
index 5e81f2f..59e826e 100644
--- a/hw/virtio/Makefile.objs
+++ b/hw/virtio/Makefile.objs
@@ -10,7 +10,7 @@ obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
 obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
 obj-y += virtio-crypto.o
 obj-$(CONFIG_VIRTIO_PCI) += virtio-crypto-pci.o
-endif
-
+else
 common-obj-$(call lnot,$(CONFIG_LINUX)) += vhost-stub.o
-common-obj-$(CONFIG_ALL) += vhost-stub.o
+common-obj-y += vhost-stub.o
+endif
diff --git a/hw/virtio/vhost-stub.c b/hw/virtio/vhost-stub.c
index 2d76cde..e130791 100644
--- a/hw/virtio/vhost-stub.c
+++ b/hw/virtio/vhost-stub.c
@@ -1,7 +1,18 @@
 #include "qemu/osdep.h"
 #include "hw/virtio/vhost.h"
+#include "hw/virtio/vhost-user.h"
 
 bool vhost_has_free_slot(void)
 {
     return true;
 }
+
+void vhost_user_asyn_read(void *opaque, const uint8_t *buf, int size)
+{
+    return;
+}
+
+int vhost_user_can_read(void *opaque)
+{
+    return 0;
+}
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ca8fe36..5d55ea1 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -14,7 +14,7 @@
 #include "hw/virtio/vhost-backend.h"
 #include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
-#include "sysemu/char.h"
+#include "net/vhost-user.h"
 #include "sysemu/kvm.h"
 #include "qemu/error-report.h"
 #include "qemu/sockets.h"
@@ -75,6 +75,46 @@ fail:
     return -1;
 }
 
+int vhost_user_can_read(void *opaque)
+{
+    return VHOST_USER_HDR_SIZE;
+}
+
+void vhost_user_asyn_read(void *opaque, const uint8_t *buf, int size)
+{
+    const char *name = opaque;
+    VhostUserMsg msg;
+    uint8_t *p = (uint8_t *) &msg;
+    CharBackend *chr_be = net_name_to_chr_be(name);
+
+    if (size != VHOST_USER_HDR_SIZE) {
+        error_report("%s: wrong message size received %d", __func__, size);
+        return;
+    }
+
+    memcpy(p, buf, VHOST_USER_HDR_SIZE);
+
+    if (msg.size) {
+        p += VHOST_USER_HDR_SIZE;
+        size = qemu_chr_fe_read_all(chr_be, p, msg.size);
+        if (size != msg.size) {
+            error_report("%s: wrong message size %d != %d", __func__,
+                         size, msg.size);
+            return;
+        }
+    }
+
+    if (msg.request > VHOST_USER_MAX) {
+        error_report("%s:incorrect msg %d", __func__, msg.request);
+    }
+
+    switch (msg.request) {
+    default:
+        error_report("%s: does not support msg %d", __func__, msg.request);
+        break;
+    }
+}
+
 static int process_message_reply(struct vhost_dev *dev,
                                  VhostUserRequest request)
 {
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 1fccbe2..eae5431 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -103,4 +103,8 @@ static VhostUserMsg m __attribute__ ((unused));
 /* The version of the protocol we support */
 #define VHOST_USER_VERSION    (0x1)
 
+int vhost_user_can_read(void *opaque);
+
+void vhost_user_asyn_read(void *opaque, const uint8_t *buf, int size);
+
 #endif
diff --git a/include/net/vhost-user.h b/include/net/vhost-user.h
index d9e328d..1bb5f1a 100644
--- a/include/net/vhost-user.h
+++ b/include/net/vhost-user.h
@@ -11,8 +11,12 @@
 #ifndef NET_VHOST_USER_H
 #define NET_VHOST_USER_H
 
+#include "sysemu/char.h"
+
 struct vhost_net;
 struct vhost_net *vhost_user_get_vhost_net(NetClientState *nc);
 uint64_t vhost_user_get_acked_features(NetClientState *nc);
 
+CharBackend *net_name_to_chr_be(const char *name);
+
 #endif /* VHOST_USER_H */
diff --git a/net/vhost-user.c b/net/vhost-user.c
index e7e6340..91ee146 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -12,7 +12,7 @@
 #include "clients.h"
 #include "net/vhost_net.h"
 #include "net/vhost-user.h"
-#include "sysemu/char.h"
+#include "hw/virtio/vhost-user.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
 #include "qmp-commands.h"
@@ -221,6 +221,22 @@ static void chr_closed_bh(void *opaque)
     }
 }
 
+CharBackend *net_name_to_chr_be(const char *name)
+{
+    NetClientState *ncs[MAX_QUEUE_NUM];
+    VhostUserState *s;
+    int queues;
+
+    queues = qemu_find_net_clients_except(name, ncs,
+                                          NET_CLIENT_DRIVER_NIC,
+                                          MAX_QUEUE_NUM);
+    assert(queues < MAX_QUEUE_NUM);
+
+    s = DO_UPCAST(VhostUserState, nc, ncs[0]);
+
+    return &s->chr;
+}
+
 static void net_vhost_user_event(void *opaque, int event)
 {
     const char *name = opaque;
@@ -307,8 +323,9 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
             error_report_err(err);
             return -1;
         }
-        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
-                                 net_vhost_user_event, nc0->name, NULL, true);
+        qemu_chr_fe_set_handlers(&s->chr, vhost_user_can_read,
+                                 vhost_user_asyn_read, net_vhost_user_event,
+                                 nc0->name, NULL, true);
     } while (!s->started);
 
     assert(s->vhost_net);
-- 
2.7.4
