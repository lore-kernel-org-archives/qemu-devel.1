Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14323C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:58:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D200220723
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 20:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XaBMW2gq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D200220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVig7-00034Q-8P
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 15:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46585)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vgoyal@redhat.com>) id 1iVieU-0001Km-FO
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vgoyal@redhat.com>) id 1iVieS-00046d-34
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:57:09 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58178
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vgoyal@redhat.com>) id 1iVieR-00045r-VW
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 15:57:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1573851427;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mrGnB1iv8Csi0czBGKotd+GZIBwERQbtlUN8heaoB48=;
 b=XaBMW2gqTjkUGM/1i+ui/TDsz94t9b2H1QpVIyK8kyrGT4BhHOpG/uXNLCn4ANLgzRqum1
 TjKXAIJ1ElWdrT4ERRe7Vj4VXOlZmyb00uFOxcMydUMIEwAzwlMbUnqrZXImPi1wZjXAzD
 CUAffCm9eDh/h0E+02eQvs30pcCubMo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-228-8oBQMcV6NAaiOs4x7NUieg-1; Fri, 15 Nov 2019 15:55:58 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FE92107ACC4;
 Fri, 15 Nov 2019 20:55:57 +0000 (UTC)
Received: from horse.redhat.com (unknown [10.18.25.35])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5E1DC5ED35;
 Fri, 15 Nov 2019 20:55:51 +0000 (UTC)
Received: by horse.redhat.com (Postfix, from userid 10451)
 id D5E6C224777; Fri, 15 Nov 2019 15:55:50 -0500 (EST)
From: Vivek Goyal <vgoyal@redhat.com>
To: virtio-fs@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 3/4] virtiofsd: Specify size of notification buffer using
 config space
Date: Fri, 15 Nov 2019 15:55:42 -0500
Message-Id: <20191115205543.1816-4-vgoyal@redhat.com>
In-Reply-To: <20191115205543.1816-1-vgoyal@redhat.com>
References: <20191115205543.1816-1-vgoyal@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-MC-Unique: 8oBQMcV6NAaiOs4x7NUieg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: miklos@szeredi.hu, stefanha@redhat.com, vgoyal@redhat.com,
 dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Daemon specifies size of notification buffer needed and that should be done
using config space.

Only ->notify_buf_size value of config space comes from daemon. Rest of
it is filled by qemu device emulation code.

Signed-off-by: Vivek Goyal <vgoyal@redhat.com>
---
 contrib/virtiofsd/fuse_virtio.c            | 26 +++++++++++++++++++++-
 hw/virtio/vhost-user-fs.c                  | 26 ++++++++++++++++++++++
 include/hw/virtio/vhost-user-fs.h          |  2 ++
 include/standard-headers/linux/virtio_fs.h |  2 ++
 4 files changed, 55 insertions(+), 1 deletion(-)

diff --git a/contrib/virtiofsd/fuse_virtio.c b/contrib/virtiofsd/fuse_virti=
o.c
index 411114c9b3..982b6ad0bd 100644
--- a/contrib/virtiofsd/fuse_virtio.c
+++ b/contrib/virtiofsd/fuse_virtio.c
@@ -109,7 +109,8 @@ static uint64_t fv_get_features(VuDev *dev)
     uint64_t features;
=20
     features =3D 1ull << VIRTIO_F_VERSION_1 |
-               1ull << VIRTIO_FS_F_NOTIFICATION;
+               1ull << VIRTIO_FS_F_NOTIFICATION |
+               1ull << VHOST_USER_F_PROTOCOL_FEATURES;
=20
     return features;
 }
@@ -927,6 +928,27 @@ static bool fv_queue_order(VuDev *dev, int qidx)
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
+
+=09fuse_log(FUSE_LOG_DEBUG, "%s:Setting notify_buf_size=3D%d\n", __func__,
+                 sizeof(struct fuse_notify_lock_out));
+=09/*
+=09 * As of now only notification related to lock is supported. As more
+=09 * notification types are supported, bump up the size accordingly.
+=09 */
+=09fscfg.notify_buf_size =3D sizeof(struct fuse_notify_lock_out);
+
+=09memcpy(config, &fscfg, len);
+=09return 0;
+}
+
 static const VuDevIface fv_iface =3D {
     .get_features =3D fv_get_features,
     .set_features =3D fv_set_features,
@@ -935,6 +957,8 @@ static const VuDevIface fv_iface =3D {
     .queue_set_started =3D fv_queue_set_started,
=20
     .queue_is_processed_in_order =3D fv_queue_order,
+    .get_protocol_features =3D fv_get_protocol_features,
+    .get_config =3D fv_get_config,
 };
=20
 /*
diff --git a/hw/virtio/vhost-user-fs.c b/hw/virtio/vhost-user-fs.c
index 5555fe9dbe..8dd9b1496f 100644
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
+=09if (ret < 0) {
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


