Received: from eggs.gnu.org ([209.51.188.92]:36359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4Hy-0002ZB-6g
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gs4Hw-0000jT-BS
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59258)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gs4Hw-0000fX-1Q
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 06:25:44 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0B9CF883B8
	for <qemu-devel@nongnu.org>; Fri,  8 Feb 2019 11:25:39 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  8 Feb 2019 12:23:52 +0100
Message-Id: <20190208112357.31615-9-marcandre.lureau@redhat.com>
In-Reply-To: <20190208112357.31615-1-marcandre.lureau@redhat.com>
References: <20190208112357.31615-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/13] vhost-user: add
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
Cc: kraxel@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Ask vhost user input backend the list of virtio_input_config.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Gerd Hoffmann <kraxel@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 include/hw/virtio/vhost-backend.h     |  4 ++
 hw/virtio/vhost-user.c                | 60 +++++++++++++++++++++++++++
 docs/interop/vhost-user.txt           |  8 ++++
 4 files changed, 73 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index c0133b7f3f..b0c798fa1a 100644
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
index 0acf56fe96..272985adf2 100644
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
@@ -338,6 +339,65 @@ static int vhost_user_write(struct vhost_dev *dev, V=
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
+                     " Read %d instead of %u.", r, size);
+        g_free(p);
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
+    p =3D vhost_user_read_size(dev, msg.hdr.size);
+    if (!p) {
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
index 9ee2a60cfb..e145b3ec55 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -766,6 +766,14 @@ Master message types
       was previously sent.
       The value returned is an error indication; 0 is success.
=20
+ * VHOST_USER_INPUT_GET_CONFIG
+      Id: 31
+      Master payload: N/A
+      Slave payload: (struct virtio_input_config)*
+
+      Ask vhost user input backend the list of virtio_input_config, in
+      host endianness.
+
 Slave message types
 -------------------
=20
--=20
2.20.1.519.g8feddda32c
