Received: from eggs.gnu.org ([2001:4830:134:3::10]:41243)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxph-0004C7-1A
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fdxpd-0003pc-Pz
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:10:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57112 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fdxpd-0003mm-KV
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:09:57 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50C27BB41E
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 13:09:57 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri, 13 Jul 2018 15:09:04 +0200
Message-Id: <20180713130916.4153-18-marcandre.lureau@redhat.com>
In-Reply-To: <20180713130916.4153-1-marcandre.lureau@redhat.com>
References: <20180713130916.4153-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 17/29] vhost-user: add
 vhost_user_gpu_get_num_capsets()
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

See vhost-user.txt protocol documentation for details.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 include/hw/virtio/vhost-backend.h     |  1 +
 hw/virtio/vhost-user.c                | 15 +++++++++++++++
 docs/interop/vhost-user.txt           |  8 ++++++++
 4 files changed, 25 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 42e227cce6..9f30e05bd1 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -93,6 +93,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG =3D 31,
     VHOST_USER_GPU_SET_SOCKET   =3D 32,
+    VHOST_USER_GPU_GET_NUM_CAPSETS =3D 33,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
index daf9180c33..730e24c33b 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -164,5 +164,6 @@ int vhost_backend_handle_iotlb_msg(struct vhost_dev *=
dev,
 int vhost_user_input_get_config(struct vhost_dev *dev,
                                 struct virtio_input_config **config);
 int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
+int vhost_user_gpu_get_num_capsets(struct vhost_dev *dev, uint32_t *num)=
;
=20
 #endif /* VHOST_BACKEND_H */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 8c1a1742b0..bfec6528f2 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -91,6 +91,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG =3D 31,
     VHOST_USER_GPU_SET_SOCKET   =3D 32,
+    VHOST_USER_GPU_GET_NUM_CAPSETS =3D 33,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -922,6 +923,20 @@ static int vhost_user_get_u64(struct vhost_dev *dev,=
 int request, uint64_t *u64)
     return 0;
 }
=20
+int vhost_user_gpu_get_num_capsets(struct vhost_dev *dev, uint32_t *num)
+{
+    uint64_t u64;
+
+    if (vhost_user_get_u64(dev, VHOST_USER_GPU_GET_NUM_CAPSETS, &u64) < =
0) {
+        return -1;
+    }
+    if (u64 > INT32_MAX) {
+        return -1;
+    }
+    *num =3D u64;
+    return 0;
+}
+
 static int vhost_user_get_features(struct vhost_dev *dev, uint64_t *feat=
ures)
 {
     return vhost_user_get_u64(dev, VHOST_USER_GET_FEATURES, features);
diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
index c4c063a8c0..ba5e37d714 100644
--- a/docs/interop/vhost-user.txt
+++ b/docs/interop/vhost-user.txt
@@ -777,6 +777,14 @@ Master message types
       ancillary data. The GPU protocol is used to inform the master of
       rendering state and updates. See vhost-user-gpu.rst for details.
=20
+ * VHOST_USER_GPU_GET_NUM_CAPSETS
+      Id: 33
+      Master payload: N/A
+      Slave payload: u64
+
+      Get the virtio-gpu 'num_capsets' config value. For non-virgl
+      rendering, the value can be 0.
+
 Slave message types
 -------------------
=20
--=20
2.18.0.129.ge3331758f1
