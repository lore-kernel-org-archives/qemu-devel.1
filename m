Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28743C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23972073C
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MzbuwHRL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23972073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ica7C-0006x4-GR
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51162)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ica1A-0002Zt-RV
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:09:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ica18-0005Tb-SR
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:56 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33248
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ica16-0005PE-V9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575486529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mAhYHUCtIsGWrIxvI8A8iRtDjmmVa3sO5ynZ4qkQ8zs=;
 b=MzbuwHRL58viIq1pCteogtkDmBdKnCHZXTnwpKsD7VCClKTLdAu1YuCSi3k9HXMXXXYipo
 9fJEWwHf7EazatjUGL9So5ETuJ7wPJMwdU4qPpRtZfQ34mVvow9qnOk34PNnBdMYmBHg0K
 UWqkUWYGsZhIgdUkCP2PSE26nv+mBJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-11-8Gv5jSC7NbiMAaXj4HbROw-1; Wed, 04 Dec 2019 14:08:48 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6BABD18A6EF1
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 19:08:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9A6D5600C8;
 Wed,  4 Dec 2019 19:08:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 2B8B922471C; Wed,  4 Dec 2019 14:08:42 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 3/5] virtiofd: Create a notification queue
Date: Wed,  4 Dec 2019 14:08:34 -0500
Message-Id: <20191204190836.31324-4-vgoyal@redhat.com>
In-Reply-To: <20191204190836.31324-1-vgoyal@redhat.com>
References: <20191204190836.31324-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: 8Gv5jSC7NbiMAaXj4HbROw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: mszeredi@redhat.com, dgilbert@redhat.com, stefanha@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Add a notification queue which will be used to send async notifications
for file lock availability.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 contrib/virtiofsd/fuse_i.h                 |  1 +
 contrib/virtiofsd/fuse_virtio.c            | 74 +++++++++++++++-------
 hw/virtio/vhost-user-fs-pci.c              |  2 +-
 hw/virtio/vhost-user-fs.c                  | 37 +++++++++--
 include/hw/virtio/vhost-user-fs.h          |  1 +
 include/standard-headers/linux/virtio_fs.h |  3 +
 6 files changed, 87 insertions(+), 31 deletions(-)

diff --git a/contrib/virtiofsd/fuse_i.h b/contrib/virtiofsd/fuse_i.h
index 966b1a3baa..4eeae0bfeb 100644
--- a/contrib/virtiofsd/fuse_i.h
+++ b/contrib/virtiofsd/fuse_i.h
@@ -74,6 +74,7 @@ struct fuse_session {
 =09char *vu_socket_lock;
 =09struct fv_VuDev *virtio_dev;
 =09int thread_pool_size;
+=09bool notify_enabled;
 };
=20
 struct fuse_chan {
diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 2a9cd60a01..b1eebcf054 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -14,6 +14,7 @@
 #include "qemu/osdep.h"
 #include "qemu/iov.h"
 #include "qapi/error.h"
+#include "standard-headers/linux/virtio_fs.h"
 #include "fuse_i.h"
 #include "fuse_kernel.h"
 #include "fuse_misc.h"
@@ -92,23 +93,31 @@ struct fv_VuDev {
      */
     size_t nqueues;
     struct fv_QueueInfo **qi;
-};
-
-/* From spec */
-struct virtio_fs_config {
-    char tag[36];
-    uint32_t num_queues;
+    /* True if notification queue is being used */
+    bool notify_enabled;
 };
=20
 /* Callback from libvhost-user */
 static uint64_t fv_get_features(VuDev *dev)
 {
-    return 1ULL << VIRTIO_F_VERSION_1;
+    uint64_t features;
+
+    features =3D 1ull << VIRTIO_F_VERSION_1 |
+               1ull << VIRTIO_FS_F_NOTIFICATION;
+
+    return features;
 }
=20
 /* Callback from libvhost-user */
 static void fv_set_features(VuDev *dev, uint64_t features)
 {
+    struct fv_VuDev *vud =3D container_of(dev, struct fv_VuDev, dev);
+    struct fuse_session *se =3D vud->se;
+
+    if ((1ull << VIRTIO_FS_F_NOTIFICATION) & features) {
+        vud->notify_enabled =3D true;
+        se->notify_enabled =3D true;
+    }
 }
=20
 /*
@@ -765,6 +774,9 @@ static void fv_queue_set_started(VuDev *dev, int qidx, =
bool started)
 {
     struct fv_VuDev *vud =3D container_of(dev, struct fv_VuDev, dev);
     struct fv_QueueInfo *ourqi;
+    void * (*thread_func) (void *) =3D fv_queue_thread;
+    int valid_queues =3D 2; /* One hiprio queue and one request queue */
+    bool notification_q =3D false;
=20
     fuse_log(FUSE_LOG_INFO, "%s: qidx=3D%d started=3D%d\n", __func__, qidx=
,
              started);
@@ -776,10 +788,18 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
, bool started)
      * well-behaved client in mind and may not protect against all types o=
f
      * races yet.
      */
-    if (qidx > 1) {
-        fuse_log(FUSE_LOG_ERR,
-                 "%s: multiple request queues not yet implemented, please =
only "
-                 "configure 1 request queue\n",
+    if (vud->notify_enabled) {
+        valid_queues++;
+        /*
+         * If notification queue is enabled, then qidx 1 is notificaiton q=
ueue.
+         */
+        if (qidx =3D=3D 1)
+            notification_q =3D true;
+    }
+
+    if (qidx >=3D valid_queues) {
+        fuse_log(FUSE_LOG_ERR, "%s: multiple request queues not yet"
+                 "implemented, please only configure 1 request queue\n",
                  __func__);
         exit(EXIT_FAILURE);
     }
@@ -803,13 +823,19 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
, bool started)
             assert(vud->qi[qidx]->kick_fd =3D=3D -1);
         }
         ourqi =3D vud->qi[qidx];
+        pthread_mutex_init(&ourqi->vq_lock, NULL);
+        /*
+         * For notification queue, we don't have to start a thread yet.
+         */
+        if (notification_q)
+            return;
+
         ourqi->kick_fd =3D dev->vq[qidx].kick_fd;
=20
         ourqi->kill_fd =3D eventfd(0, EFD_CLOEXEC | EFD_SEMAPHORE);
         assert(ourqi->kill_fd !=3D -1);
-        pthread_mutex_init(&ourqi->vq_lock, NULL);
=20
-        if (pthread_create(&ourqi->thread, NULL, fv_queue_thread, ourqi)) =
{
+        if (pthread_create(&ourqi->thread, NULL, thread_func, ourqi)) {
             fuse_log(FUSE_LOG_ERR, "%s: Failed to create thread for queue =
%d\n",
                      __func__, qidx);
             assert(0);
@@ -819,17 +845,19 @@ static void fv_queue_set_started(VuDev *dev, int qidx=
, bool started)
         assert(qidx < vud->nqueues);
         ourqi =3D vud->qi[qidx];
=20
-        /* Kill the thread */
-        if (eventfd_write(ourqi->kill_fd, 1)) {
-            fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
-        }
-        ret =3D pthread_join(ourqi->thread, NULL);
-        if (ret) {
-            fuse_log(FUSE_LOG_ERR, "%s: Failed to join thread idx %d err %=
d\n",
-                     __func__, qidx, ret);
+        if (!notification_q) {
+            /* Kill the thread */
+            if (eventfd_write(ourqi->kill_fd, 1)) {
+                fuse_log(FUSE_LOG_ERR, "Eventfd_read for queue: %m\n");
+            }
+            ret =3D pthread_join(ourqi->thread, NULL);
+            if (ret) {
+                fuse_log(FUSE_LOG_ERR, "%s: Failed to join thread idx %d e=
rr"
+                         " %d\n", __func__, qidx, ret);
+            }
+            close(ourqi->kill_fd);
         }
         pthread_mutex_destroy(&ourqi->vq_lock);
-        close(ourqi->kill_fd);
         ourqi->kick_fd =3D -1;
         free(vud->qi[qidx]);
         vud->qi[qidx] =3D NULL;
@@ -1034,7 +1062,7 @@ int virtio_session_mount(struct fuse_session *se)
     se->virtio_dev =3D calloc(sizeof(struct fv_VuDev), 1);
     se->virtio_dev->se =3D se;
     pthread_rwlock_init(&se->virtio_dev->vu_dispatch_rwlock, NULL);
-    vu_init(&se->virtio_dev->dev, 2, se->vu_socketfd, fv_panic, fv_set_wat=
ch,
+    vu_init(&se->virtio_dev->dev, 3, se->vu_socketfd, fv_panic, fv_set_wat=
ch,
             fv_remove_watch, &fv_iface);
=20
     return 0;
diff --git a/hw/virtio/vhost-user-fs-pci.c b/hw/virtio/vhost-user-fs-pci.c
index 0f3c3c8711..95f9fe5c5c 100644
--- a/hw/virtio/vhost-user-fs-pci.c
+++ b/hw/virtio/vhost-user-fs-pci.c
@@ -44,7 +44,7 @@ static void vhost_user_fs_pci_realize(VirtIOPCIProxy *vpc=
i_dev, Error **errp)
     uint64_t totalsize;
=20
     if (vpci_dev->nvectors =3D=3D DEV_NVECTORS_UNSPECIFIED) {
-        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 1;
+        vpci_dev->nvectors =3D dev->vdev.conf.num_request_queues + 2;
     }
=20
     qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 455e97beea..5555fe9dbe 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -24,6 +24,10 @@
 #include "exec/address-spaces.h"
 #include "trace.h"
=20
+static const int user_feature_bits[] =3D {
+    VIRTIO_FS_F_NOTIFICATION,
+};
+
 uint64_t vhost_user_fs_slave_map(struct vhost_dev *dev, VhostUserFSSlaveMs=
g *sm,
                                  int fd)
 {
@@ -378,12 +382,23 @@ static void vuf_set_status(VirtIODevice *vdev, uint8_=
t status)
     }
 }
=20
-static uint64_t vuf_get_features(VirtIODevice *vdev,
-                                      uint64_t requested_features,
-                                      Error **errp)
+static uint64_t vuf_get_features(VirtIODevice *vdev, uint64_t features,
+                                 Error **errp)
 {
-    /* No feature bits used yet */
-    return requested_features;
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+
+    virtio_add_feature(&features, VIRTIO_FS_F_NOTIFICATION);
+
+    return vhost_get_features(&fs->vhost_dev, user_feature_bits, features)=
;
+}
+
+static void vuf_set_features(VirtIODevice *vdev, uint64_t features)
+{
+    VHostUserFS *fs =3D VHOST_USER_FS(vdev);
+
+    if (virtio_has_feature(features, VIRTIO_FS_F_NOTIFICATION)) {
+        fs->notify_enabled =3D true;
+    }
 }
=20
 static void vuf_handle_output(VirtIODevice *vdev, VirtQueue *vq)
@@ -515,13 +530,20 @@ static void vuf_device_realize(DeviceState *dev, Erro=
r **errp)
     /* Hiprio queue */
     virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
=20
+    /* Notification queue. Feature negotiation happens later. So at this
+     * point of time we don't know if driver will use notification queue
+     * or not.
+     */
+    virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
+
     /* Request queues */
     for (i =3D 0; i < fs->conf.num_request_queues; i++) {
         virtio_add_queue(vdev, fs->conf.queue_size, vuf_handle_output);
     }
=20
-    /* 1 high prio queue, plus the number configured */
-    fs->vhost_dev.nvqs =3D 1 + fs->conf.num_request_queues;
+    /* 1 high prio queue, 1 notification queue plus the number configured =
*/
+    fs->vhost_dev.nvqs =3D 2 + fs->conf.num_request_queues;
+
     fs->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, fs->vhost_dev.nvq=
s);
     ret =3D vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0);
@@ -584,6 +606,7 @@ static void vuf_class_init(ObjectClass *klass, void *da=
ta)
     vdc->realize =3D vuf_device_realize;
     vdc->unrealize =3D vuf_device_unrealize;
     vdc->get_features =3D vuf_get_features;
+    vdc->set_features =3D vuf_set_features;
     vdc->get_config =3D vuf_get_config;
     vdc->set_status =3D vuf_set_status;
     vdc->guest_notifier_mask =3D vuf_guest_notifier_mask;
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-us=
er-fs.h
index 4e7be1f312..bd47e0da98 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -64,6 +64,7 @@ typedef struct {
     /* Metadata version table */
     size_t mdvt_size;
     MemoryRegion mdvt;
+    bool notify_enabled;
 } VHostUserFS;
=20
 /* Callbacks from the vhost-user code for slave commands */
diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standard-=
headers/linux/virtio_fs.h
index 310210b7b6..9ee95f584f 100644
--- a/include/standard-headers/linux/virtio_fs.h
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -8,6 +8,9 @@
 #include "standard-headers/linux/virtio_config.h"
 #include "standard-headers/linux/virtio_types.h"
=20
+/* Feature bits */
+#define VIRTIO_FS_F_NOTIFICATION=090=09/* Notification queue supported */
+
 struct virtio_fs_config {
 =09/* Filesystem name (UTF-8, not NUL-terminated, padded with NULs) */
 =09uint8_t tag[36];
--=20
2.20.1


