Received: from eggs.gnu.org ([2001:4830:134:3::10]:41149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpT-0003zU-2O
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpR-0002jx-RQ
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:47 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpR-0002i6-Le
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:45 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 576808185343
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:45 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:08:59 +0200
Message-Id: <20180713130916.4153-13-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 12/29] vhost-user: add
 vhost_user_input_get_config()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: airlied@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Ask vhost user input backend the list of virtio_input_config.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 include/hw/virtio/vhost-backend.h     |  4 ++
 hw/virtio/vhost-user.c                | 59 +++++++++++++++++++++++++++
 docs/interop/vhost-user.txt           |  7 ++++
 4 files changed, 71 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 4aa55b4d2d..a4afbc3a46 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -91,6 +91,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  =3D 28,
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_POSTCOPY_END     =3D 30,
+    VHOST_USER_INPUT_GET_CONFIG =3D 31,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
index 81283ec50f..1fca321d8a 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -12,6 +12,7 @@
 #define VHOST_BACKEND_H
=20
 #include "exec/memory.h"
+#include "standard-headers/linux/virtio_input.h"
=20
 typedef enum VhostBackendType {
     VHOST_BACKEND_TYPE_NONE =3D 0,
@@ -160,4 +161,7 @@ int vhost_backend_invalidate_device_iotlb(struct vhos=
t_dev *dev,
 int vhost_backend_handle_iotlb_msg(struct vhost_dev *dev,
                                           struct vhost_iotlb_msg *imsg);
=20
+int vhost_user_input_get_config(struct vhost_dev *dev,
+                                struct virtio_input_config **config);
+
 #endif /* VHOST_BACKEND_H */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 29f8568a13..0c6914fab7 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -89,6 +89,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_ADVISE  =3D 28,
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_POSTCOPY_END     =3D 30,
+    VHOST_USER_INPUT_GET_CONFIG =3D 31,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -338,6 +339,64 @@ static int vhost_user_write(struct vhost_dev *dev, V=
hostUserMsg *msg,
     return 0;
 }
=20
+static void *vhost_user_read_size(struct vhost_dev *dev, uint32_t size)
+{
+    struct vhost_user *u =3D dev->opaque;
+    CharBackend *chr =3D u->user->chr;
+    int r;
+    uint8_t *p =3D g_malloc(size);
+
+    r =3D qemu_chr_fe_read_all(chr, p, size);
+    if (r !=3D size) {
+        error_report("Failed to read msg payload."
+                     " Read %d instead of %d.", r, size);
+        return NULL;
+    }
+
+    return p;
+}
+
+int vhost_user_input_get_config(struct vhost_dev *dev,
+                                struct virtio_input_config **config)
+{
+    void *p =3D NULL;
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_INPUT_GET_CONFIG,
+        .hdr.flags =3D VHOST_USER_VERSION,
+    };
+
+    if (vhost_user_write(dev, &msg, NULL, 0) < 0) {
+        goto err;
+    }
+
+    if (vhost_user_read_header(dev, &msg) < 0) {
+        goto err;
+    }
+
+    p =3D vhost_user_read_size(dev, msg.hdr.size);
+    if (!p) {
+        goto err;
+    }
+
+    if (msg.hdr.request !=3D VHOST_USER_INPUT_GET_CONFIG) {
+        error_report("Received unexpected msg type. Expected %d received=
 %d",
+                     VHOST_USER_INPUT_GET_CONFIG, msg.hdr.request);
+        goto err;
+    }
+
+    if (msg.hdr.size % sizeof(struct virtio_input_config)) {
+        error_report("Invalid msg size");
+        goto err;
+    }
+
+    *config =3D p;
+    return msg.hdr.size / sizeof(struct virtio_input_config);
+
+err:
+    g_free(p);
+    return -1;
+}
+
 static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
                                    struct vhost_log *log)
 {
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index f59667f498..cba1ddde16 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -761,6 +761,13 @@ Master message types
       was previously sent.
       The value returned is an error indication; 0 is success.
=20
+ * VHOST_USER_INPUT_GET_CONFIG
+      Id: 31
+      Master payload: N/A
+      Slave payload: (struct virtio_input_config)*
+
+      Ask vhost user input backend the list of virtio_input_config.
+
 Slave message types
 -------------------
=20
--=20
2.18.0.129.ge3331758f1
