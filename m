Return-Path: <SRS0=xVqP=Z2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD9C4C43603
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:10:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 947C220656
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2019 19:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TvNRhrjP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 947C220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ica2x-0003zR-Fy
	for qemu-devel@archiver.kernel.org; Wed, 04 Dec 2019 14:10:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51138)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1ica18-0002ZH-LK
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1ica15-0005Pq-8H
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:52 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32247
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1ica14-0005Oj-WB
 for qemu-devel@nongnu.org; Wed, 04 Dec 2019 14:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1575486529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HNKuisohKuzW0O/AF+rSjIu6/T1DLhroU5kUOiE3QF0=;
 b=TvNRhrjPEnOoMvI5VoTf2B6MABFlrU1RzIsfgOwIUSdgOT8IJED2LbKk8TmVSSQKolvBre
 2ShjSq5cqGvTb8PLT5Wlyra3VSLFyFeYtFD9B1QOZVYwzNuox6nXgz0/ThexnVkmiHusSP
 RqMvDE1JlyFsy0L8edtrP/bRzW6V7Zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-352-XXtWF4u6MjCRQXVPHE99WA-1; Wed, 04 Dec 2019 14:08:48 -0500
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D51618A6EF2
 for <qemu-devel@nongnu.org>; Wed,  4 Dec 2019 19:08:47 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9B85810013A1;
 Wed,  4 Dec 2019 19:08:42 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id 2F3A722474F; Wed,  4 Dec 2019 14:08:42 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] virtiofsd: Specify size of notification buffer using
 config space
Date: Wed,  4 Dec 2019 14:08:35 -0500
Message-Id: <20191204190836.31324-5-vgoyal@redhat.com>
In-Reply-To: <20191204190836.31324-1-vgoyal@redhat.com>
References: <20191204190836.31324-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-MC-Unique: XXtWF4u6MjCRQXVPHE99WA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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

Daemon specifies size of notification buffer needed and that should be done
using config space.

Only ->notify_buf_size value of config space comes from daemon. Rest of
it is filled by qemu device emulation code.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 contrib/virtiofsd/fuse_virtio.c            | 31 ++++++++++++++++++++++
 hw/virtio/vhost-user-fs.c                  | 26 ++++++++++++++++++
 include/hw/virtio/vhost-user-fs.h          |  2 ++
 include/standard-headers/linux/virtio_fs.h |  2 ++
 4 files changed, 61 insertions(+)

diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index b1eebcf054..94cf9b3791 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -869,6 +869,35 @@ static bool fv_queue_order(VuDev *dev, int qidx)
     return false;
 }
=20
+static uint64_t fv_get_protocol_features(VuDev *dev)
+{
+=09return 1ull << VHOST_USER_PROTOCOL_F_CONFIG;
+}
+
+static int fv_get_config(VuDev *dev, uint8_t *config, uint32_t len)
+{
+=09struct virtio_fs_config fscfg =3D {};
+=09unsigned notify_size, roundto =3D 64;
+=09union fuse_notify_union {
+=09=09struct fuse_notify_poll_wakeup_out=09wakeup_out;
+=09=09struct fuse_notify_inval_inode_out=09inode_out;
+=09=09struct fuse_notify_inval_entry_out=09entry_out;
+=09=09struct fuse_notify_delete_out=09=09delete_out;
+=09=09struct fuse_notify_store_out=09=09store_out;
+=09=09struct fuse_notify_retrieve_out=09=09retrieve_out;
+=09};
+
+=09notify_size =3D sizeof(struct fuse_out_header) +
+=09=09      sizeof(union fuse_notify_union);
+=09notify_size =3D ((notify_size + roundto)/roundto) * roundto;
+
+=09fscfg.notify_buf_size =3D notify_size;
+=09memcpy(config, &fscfg, len);
+=09fuse_log(FUSE_LOG_DEBUG, "%s:Setting notify_buf_size=3D%d\n", __func__,
+                 fscfg.notify_buf_size);
+=09return 0;
+}
+
 static const VuDevIface fv_iface =3D {
     .get_features =3D fv_get_features,
     .set_features =3D fv_set_features,
@@ -877,6 +906,8 @@ static const VuDevIface fv_iface =3D {
     .queue_set_started =3D fv_queue_set_started,
=20
     .queue_is_processed_in_order =3D fv_queue_order,
+    .get_protocol_features =3D fv_get_protocol_features,
+    .get_config =3D fv_get_config,
 };
=20
 /*
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 5555fe9dbe..5a6d244b98 100644
--- a/hw/virtio/vhost-user-fs.c
+++ b/hw/virtio/vhost-user-fs.c
@@ -277,16 +277,40 @@ uint64_t vhost_user_fs_slave_io(struct vhost_dev *dev=
, VhostUserFSSlaveMsg *sm,
     return (uint64_t)done;
 }
=20
+static int vhost_user_fs_handle_config_change(struct vhost_dev *dev)
+{
+    return 0;
+}
+
+const VhostDevConfigOps fs_ops =3D {
+    .vhost_dev_config_notifier =3D vhost_user_fs_handle_config_change,
+};
=20
 static void vuf_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VHostUserFS *fs =3D VHOST_USER_FS(vdev);
     struct virtio_fs_config fscfg =3D {};
+    int ret;
+
+    /*
+     * As of now we only get notification buffer size from device. And tha=
t's
+     * needed only if notification queue is enabled.
+     */
+    if (fs->notify_enabled) {
+        ret =3D vhost_dev_get_config(&fs->vhost_dev, (uint8_t *)&fs->fscfg=
,
+                                   sizeof(struct virtio_fs_config));
+        if (ret < 0) {
+            error_report("vhost-user-fs: get device config space failed."
+                         " ret=3D%d\n", ret);
+            return;
+        }
+    }
=20
     memcpy((char *)fscfg.tag, fs->conf.tag,
            MIN(strlen(fs->conf.tag) + 1, sizeof(fscfg.tag)));
=20
     virtio_stl_p(vdev, &fscfg.num_request_queues, fs->conf.num_request_que=
ues);
+    virtio_stl_p(vdev, &fscfg.notify_buf_size, fs->fscfg.notify_buf_size);
=20
     memcpy(config, &fscfg, sizeof(fscfg));
 }
@@ -545,6 +569,8 @@ static void vuf_device_realize(DeviceState *dev, Error =
**errp)
     fs->vhost_dev.nvqs =3D 2 + fs->conf.num_request_queues;
=20
     fs->vhost_dev.vqs =3D g_new0(struct vhost_virtqueue, fs->vhost_dev.nvq=
s);
+
+    vhost_dev_set_config_notifier(&fs->vhost_dev, &fs_ops);
     ret =3D vhost_dev_init(&fs->vhost_dev, &fs->vhost_user,
                          VHOST_BACKEND_TYPE_USER, 0);
     if (ret < 0) {
diff --git a/include/hw/virtio/vhost-user-fs.h b/include/hw/virtio/vhost-us=
er-fs.h
index bd47e0da98..f667cc4b5a 100644
--- a/include/hw/virtio/vhost-user-fs.h
+++ b/include/hw/virtio/vhost-user-fs.h
@@ -14,6 +14,7 @@
 #ifndef _QEMU_VHOST_USER_FS_H
 #define _QEMU_VHOST_USER_FS_H
=20
+#include "standard-headers/linux/virtio_fs.h"
 #include "hw/virtio/virtio.h"
 #include "hw/virtio/vhost.h"
 #include "hw/virtio/vhost-user.h"
@@ -58,6 +59,7 @@ typedef struct {
     struct vhost_virtqueue *vhost_vqs;
     struct vhost_dev vhost_dev;
     VhostUserState vhost_user;
+    struct virtio_fs_config fscfg;
=20
     /*< public >*/
     MemoryRegion cache;
diff --git a/include/standard-headers/linux/virtio_fs.h b/include/standard-=
headers/linux/virtio_fs.h
index 9ee95f584f..719216a262 100644
--- a/include/standard-headers/linux/virtio_fs.h
+++ b/include/standard-headers/linux/virtio_fs.h
@@ -17,6 +17,8 @@ struct virtio_fs_config {
=20
 =09/* Number of request queues */
 =09uint32_t num_request_queues;
+=09/* Size of notification buffer */
+=09uint32_t notify_buf_size;
 } QEMU_PACKED;
=20
 #define VIRTIO_FS_PCI_CACHE_BAR 2
--=20
2.20.1


