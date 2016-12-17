Received: from eggs.gnu.org ([2001:4830:134:3::10]:53575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICV1-00008D-Sz
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1cICV0-0008R0-RY
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:55 -0500
Received: from mga05.intel.com ([192.55.52.43]:21540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1cICV0-0007ss-Ew
	for qemu-devel@nongnu.org; Sat, 17 Dec 2016 05:45:54 -0500
From: Wei Wang <wei.w.wang@intel.com>
Date: Sat, 17 Dec 2016 18:43:42 +0800
Message-Id: <1481971427-11094-33-git-send-email-wei.w.wang@intel.com>
In-Reply-To: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
References: <1481971427-11094-1-git-send-email-wei.w.wang@intel.com>
Subject: [Qemu-devel] [PATCH v1 32/37] vhost-user: add asynchronous read for
 the vhost-user master
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: marcandre.lureau@gmail.com, mst@redhat.com, stefanha@redhat.com, pbonzini@redhat.com, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org
Cc: Wei Wang <wei.w.wang@intel.com>

Enable the vhost-user master to asynchronously receive messages
from the slave.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
---
 hw/virtio/vhost-user.c         | 42 +++++++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/vhost-user.h |  4 ++++
 include/net/vhost-user.h       |  4 ++++
 net/vhost-user.c               | 20 ++++++++++++++++++--
 4 files changed, 67 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ce92140..800b8ed 100644
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
+        error_report("Wrong message size received %d\n", size);
+        return;
+    }
+
+    memcpy(p, buf, VHOST_USER_HDR_SIZE);
+
+    if (msg.size) {
+        p += VHOST_USER_HDR_SIZE;
+        size = qemu_chr_fe_read_all(chr_be, p, msg.size);
+        if (size != msg.size) {
+            error_report("Wrong message size received %d != %d\n",
+                           size, msg.size);
+            return;
+        }
+    }
+
+    if (msg.request > VHOST_USER_MAX)
+        error_report("vhost-user master read incorrect msg \n");
+
+    switch(msg.request) {
+    default:
+        error_report("vhost-user master does not support msg request = %d\n",
+                     msg.request);
+        break;
+    }
+}
+
 static int process_message_reply(struct vhost_dev *dev,
                                  VhostUserRequest request)
 {
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
index 12e4dc9..142ea52 100644
--- a/include/hw/virtio/vhost-user.h
+++ b/include/hw/virtio/vhost-user.h
@@ -102,4 +102,8 @@ static VhostUserMsg m __attribute__ ((unused));
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
index 7aff77e..58eee6a 100644
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
@@ -190,6 +190,22 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
     return FALSE;
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
@@ -265,7 +281,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
             error_report_err(err);
             return -1;
         }
-        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
+        qemu_chr_fe_set_handlers(&s->chr, vhost_user_can_read, vhost_user_asyn_read,
                                  net_vhost_user_event, nc0->name, NULL, true);
     } while (!s->started);
 
-- 
2.7.4
