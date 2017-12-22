Received: from eggs.gnu.org ([2001:4830:134:3::10]:45992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eSH2b-00063S-Gp
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tiwei.bie@intel.com>) id 1eSH2Z-0007NW-MZ
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:45 -0500
Received: from mga07.intel.com ([134.134.136.100]:46019)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tiwei.bie@intel.com>) id 1eSH2Z-0007Ia-B5
	for qemu-devel@nongnu.org; Fri, 22 Dec 2017 01:42:43 -0500
From: Tiwei Bie <tiwei.bie@intel.com>
Date: Fri, 22 Dec 2017 14:41:50 +0800
Message-Id: <20171222064151.29266-3-tiwei.bie@intel.com>
In-Reply-To: <20171222064151.29266-1-tiwei.bie@intel.com>
References: <20171222064151.29266-1-tiwei.bie@intel.com>
Subject: [Qemu-devel] [RFC 2/3] vhost-user: introduce shared vhost-user state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, alex.williamson@redhat.com, pbonzini@redhat.com, stefanha@redhat.com
Cc: cunming.liang@intel.com, dan.daly@intel.com, jianfeng.tan@intel.com, zhihong.wang@intel.com, xiao.w.wang@intel.com, tiwei.bie@intel.com

When multi-queue is enabled for virtio-net, each virtio
queue pair will have a vhost_dev, and the only thing they
share currently is the chardev. This patch introduces a
vhost-user state structure which will be shared by all
virtio queue pairs of the same virtio device.

Signed-off-by: Tiwei Bie <tiwei.bie@intel.com>
---
 hw/scsi/vhost-user-scsi.c       |  6 +++---
 hw/virtio/vhost-user.c          |  9 +++++----
 include/hw/virtio/vhost-user.h  | 17 +++++++++++++++++
 include/hw/virtio/virtio-scsi.h |  6 +++++-
 net/vhost-user.c                | 30 ++++++++++++++++--------------
 5 files changed, 46 insertions(+), 22 deletions(-)
 create mode 100644 include/hw/virtio/vhost-user.h

diff --git a/hw/scsi/vhost-user-scsi.c b/hw/scsi/vhost-user-scsi.c
index f7561e23fa..2c46c74128 100644
--- a/hw/scsi/vhost-user-scsi.c
+++ b/hw/scsi/vhost-user-scsi.c
@@ -73,7 +73,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     Error *err = NULL;
     int ret;
 
-    if (!vs->conf.chardev.chr) {
+    if (!vs->conf.vhost_user.chr.chr) {
         error_setg(errp, "vhost-user-scsi: missing chardev");
         return;
     }
@@ -91,7 +91,7 @@ static void vhost_user_scsi_realize(DeviceState *dev, Error **errp)
     vsc->dev.vq_index = 0;
     vsc->dev.backend_features = 0;
 
-    ret = vhost_dev_init(&vsc->dev, (void *)&vs->conf.chardev,
+    ret = vhost_dev_init(&vsc->dev, (void *)&vs->conf.vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0);
     if (ret < 0) {
         error_setg(errp, "vhost-user-scsi: vhost initialization failed: %s",
@@ -132,7 +132,7 @@ static uint64_t vhost_user_scsi_get_features(VirtIODevice *vdev,
 }
 
 static Property vhost_user_scsi_properties[] = {
-    DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.chardev),
+    DEFINE_PROP_CHR("chardev", VirtIOSCSICommon, conf.vhost_user.chr),
     DEFINE_PROP_UINT32("boot_tpgt", VirtIOSCSICommon, conf.boot_tpgt, 0),
     DEFINE_PROP_UINT32("num_queues", VirtIOSCSICommon, conf.num_queues, 1),
     DEFINE_PROP_UINT32("virtqueue_size", VirtIOSCSICommon, conf.virtqueue_size,
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index e7108138fd..3e308d0a62 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -12,6 +12,7 @@
 #include "qapi/error.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-backend.h"
+#include "hw/virtio/vhost-user.h"
 #include "hw/virtio/virtio-net.h"
 #include "chardev/char-fe.h"
 #include "sysemu/kvm.h"
@@ -123,7 +124,7 @@ static VhostUserMsg m __attribute__ ((unused));
 #define VHOST_USER_VERSION    (0x1)
 
 struct vhost_user {
-    CharBackend *chr;
+    VhostUser *shared;
     int slave_fd;
 };
 
@@ -135,7 +136,7 @@ static bool ioeventfd_enabled(void)
 static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
 {
     struct vhost_user *u = dev->opaque;
-    CharBackend *chr = u->chr;
+    CharBackend *chr = &u->shared->chr;
     uint8_t *p = (uint8_t *) msg;
     int r, size = VHOST_USER_HDR_SIZE;
 
@@ -221,7 +222,7 @@ static int vhost_user_write(struct vhost_dev *dev, VhostUserMsg *msg,
                             int *fds, int fd_num)
 {
     struct vhost_user *u = dev->opaque;
-    CharBackend *chr = u->chr;
+    CharBackend *chr = &u->shared->chr;
     int ret, size = VHOST_USER_HDR_SIZE + msg->size;
 
     /*
@@ -767,7 +768,7 @@ static int vhost_user_init(struct vhost_dev *dev, void *opaque)
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_USER);
 
     u = g_new0(struct vhost_user, 1);
-    u->chr = opaque;
+    u->shared = opaque;
     u->slave_fd = -1;
     dev->opaque = u;
 
diff --git a/include/hw/virtio/vhost-user.h b/include/hw/virtio/vhost-user.h
new file mode 100644
index 0000000000..10d698abe2
--- /dev/null
+++ b/include/hw/virtio/vhost-user.h
@@ -0,0 +1,17 @@
+/*
+ * Copyright (c) 2017 Intel Corporation
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef HW_VIRTIO_VHOST_USER_H
+#define HW_VIRTIO_VHOST_USER_H
+
+#include "chardev/char-fe.h"
+
+typedef struct VhostUser {
+    CharBackend chr;
+} VhostUser;
+
+#endif
diff --git a/include/hw/virtio/virtio-scsi.h b/include/hw/virtio/virtio-scsi.h
index 4c0bcdb788..885c3e84b5 100644
--- a/include/hw/virtio/virtio-scsi.h
+++ b/include/hw/virtio/virtio-scsi.h
@@ -19,6 +19,7 @@
 #define VIRTIO_SCSI_SENSE_SIZE 0
 #include "standard-headers/linux/virtio_scsi.h"
 #include "hw/virtio/virtio.h"
+#include "hw/virtio/vhost-user.h"
 #include "hw/pci/pci.h"
 #include "hw/scsi/scsi.h"
 #include "chardev/char-fe.h"
@@ -54,7 +55,10 @@ struct VirtIOSCSIConf {
     char *vhostfd;
     char *wwpn;
 #endif
-    CharBackend chardev;
+    union {
+        VhostUser vhost_user;
+        CharBackend chardev;
+    };
     uint32_t boot_tpgt;
     IOThread *iothread;
 };
diff --git a/net/vhost-user.c b/net/vhost-user.c
index c23927c912..b398294074 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -12,6 +12,7 @@
 #include "clients.h"
 #include "net/vhost_net.h"
 #include "net/vhost-user.h"
+#include "hw/virtio/vhost-user.h"
 #include "chardev/char-fe.h"
 #include "qemu/config-file.h"
 #include "qemu/error-report.h"
@@ -20,7 +21,7 @@
 
 typedef struct VhostUserState {
     NetClientState nc;
-    CharBackend chr; /* only queue index 0 */
+    VhostUser vhost_user; /* only queue index 0 */
     VHostNetState *vhost_net;
     guint watch;
     uint64_t acked_features;
@@ -62,7 +63,7 @@ static void vhost_user_stop(int queues, NetClientState *ncs[])
     }
 }
 
-static int vhost_user_start(int queues, NetClientState *ncs[], CharBackend *be)
+static int vhost_user_start(int queues, NetClientState *ncs[], void *be)
 {
     VhostNetOptions options;
     struct vhost_net *net = NULL;
@@ -155,7 +156,7 @@ static void vhost_user_cleanup(NetClientState *nc)
             g_source_remove(s->watch);
             s->watch = 0;
         }
-        qemu_chr_fe_deinit(&s->chr, true);
+        qemu_chr_fe_deinit(&s->vhost_user.chr, true);
     }
 
     qemu_purge_queued_packets(nc);
@@ -189,7 +190,7 @@ static gboolean net_vhost_user_watch(GIOChannel *chan, GIOCondition cond,
 {
     VhostUserState *s = opaque;
 
-    qemu_chr_fe_disconnect(&s->chr);
+    qemu_chr_fe_disconnect(&s->vhost_user.chr);
 
     return TRUE;
 }
@@ -214,7 +215,8 @@ static void chr_closed_bh(void *opaque)
     qmp_set_link(name, false, &err);
     vhost_user_stop(queues, ncs);
 
-    qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, net_vhost_user_event,
+    qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL,
+                             net_vhost_user_event,
                              NULL, opaque, NULL, true);
 
     if (err) {
@@ -237,15 +239,15 @@ static void net_vhost_user_event(void *opaque, int event)
     assert(queues < MAX_QUEUE_NUM);
 
     s = DO_UPCAST(VhostUserState, nc, ncs[0]);
-    chr = qemu_chr_fe_get_driver(&s->chr);
+    chr = qemu_chr_fe_get_driver(&s->vhost_user.chr);
     trace_vhost_user_event(chr->label, event);
     switch (event) {
     case CHR_EVENT_OPENED:
-        if (vhost_user_start(queues, ncs, &s->chr) < 0) {
-            qemu_chr_fe_disconnect(&s->chr);
+        if (vhost_user_start(queues, ncs, &s->vhost_user) < 0) {
+            qemu_chr_fe_disconnect(&s->vhost_user.chr);
             return;
         }
-        s->watch = qemu_chr_fe_add_watch(&s->chr, G_IO_HUP,
+        s->watch = qemu_chr_fe_add_watch(&s->vhost_user.chr, G_IO_HUP,
                                          net_vhost_user_watch, s);
         qmp_set_link(name, true, &err);
         s->started = true;
@@ -261,8 +263,8 @@ static void net_vhost_user_event(void *opaque, int event)
 
             g_source_remove(s->watch);
             s->watch = 0;
-            qemu_chr_fe_set_handlers(&s->chr, NULL, NULL, NULL, NULL,
-                                     NULL, NULL, false);
+            qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL, NULL,
+                                     NULL, NULL, NULL, false);
 
             aio_bh_schedule_oneshot(ctx, chr_closed_bh, opaque);
         }
@@ -294,7 +296,7 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
         if (!nc0) {
             nc0 = nc;
             s = DO_UPCAST(VhostUserState, nc, nc);
-            if (!qemu_chr_fe_init(&s->chr, chr, &err)) {
+            if (!qemu_chr_fe_init(&s->vhost_user.chr, chr, &err)) {
                 error_report_err(err);
                 return -1;
             }
@@ -304,11 +306,11 @@ static int net_vhost_user_init(NetClientState *peer, const char *device,
 
     s = DO_UPCAST(VhostUserState, nc, nc0);
     do {
-        if (qemu_chr_fe_wait_connected(&s->chr, &err) < 0) {
+        if (qemu_chr_fe_wait_connected(&s->vhost_user.chr, &err) < 0) {
             error_report_err(err);
             return -1;
         }
-        qemu_chr_fe_set_handlers(&s->chr, NULL, NULL,
+        qemu_chr_fe_set_handlers(&s->vhost_user.chr, NULL, NULL,
                                  net_vhost_user_event, NULL, nc0->name, NULL,
                                  true);
     } while (!s->started);
-- 
2.13.3
