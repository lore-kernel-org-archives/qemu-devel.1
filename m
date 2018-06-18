Received: from eggs.gnu.org ([2001:4830:134:3::10]:44069)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwrD-0002D9-3R
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fUwr6-0005Bi-QE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:19 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45474 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fUwr6-0005BP-LX
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 12:18:12 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5A90C7DAC3
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 16:18:12 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Mon, 18 Jun 2018 18:17:19 +0200
Message-Id: <20180618161729.334-17-marcandre.lureau@redhat.com>
In-Reply-To: <20180618161729.334-1-marcandre.lureau@redhat.com>
References: <20180618161729.334-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 16/26] vhost-user: add
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
Cc: berrange@redhat.com, kraxel@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 include/hw/virtio/vhost-backend.h     |  1 +
 hw/virtio/vhost-user.c                | 15 +++++++++++++++
 3 files changed, 17 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index 9899bfda9e..b572071d61 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -93,6 +93,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG,
     VHOST_USER_GPU_SET_SOCKET,
+    VHOST_USER_GPU_GET_NUM_CAPSETS,
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
index 37864bc06a..8702027269 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -91,6 +91,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG,
     VHOST_USER_GPU_SET_SOCKET,
+    VHOST_USER_GPU_GET_NUM_CAPSETS,
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
+    if (u64 > UINT32_MAX) {
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
--=20
2.18.0.rc1
