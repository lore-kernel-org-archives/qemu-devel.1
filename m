Received: from eggs.gnu.org ([2001:4830:134:3::10]:39280)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmuX-0003JE-4z
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1fOmuW-0007tx-9f
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60160 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1fOmuW-0007tb-4s
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 12:28:16 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BBA9C818BAEE
	for <qemu-devel@nongnu.org>; Fri,  1 Jun 2018 16:28:15 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  1 Jun 2018 18:27:47 +0200
Message-Id: <20180601162749.27406-11-marcandre.lureau@redhat.com>
In-Reply-To: <20180601162749.27406-1-marcandre.lureau@redhat.com>
References: <20180601162749.27406-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC v2 10/12] vhost-user: add
 vhost_user_gpu_set_socket()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add a new vhost-user message to give a unix socket for gpu updates to
a vhost-user backend.

Back when I started that work, I added a new GPU channel because the
vhost-user protocol wasn't bidirectional. Since then, there is a
vhost-user-slave channel for the slave to send requests to the master.
We could extend it with GPU messages. However, the GPU protocol is
quite orthogonal to vhost-user and may not need the same kind of
stability guarantees, thus I recommend to have a new dedicated
channel.

FIXME: document the GPU protocol.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 contrib/libvhost-user/libvhost-user.h |  1 +
 include/hw/virtio/vhost-backend.h     |  1 +
 hw/virtio/vhost-user.c                | 11 +++++++++++
 3 files changed, 13 insertions(+)

diff --git a/contrib/libvhost-user/libvhost-user.h b/contrib/libvhost-use=
r/libvhost-user.h
index d6badc8653..57a3a36100 100644
--- a/contrib/libvhost-user/libvhost-user.h
+++ b/contrib/libvhost-user/libvhost-user.h
@@ -90,6 +90,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG,
+    VHOST_USER_GPU_SET_SOCKET,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-=
backend.h
index 6cc2edacc5..a60d278f05 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -159,5 +159,6 @@ int vhost_backend_handle_iotlb_msg(struct vhost_dev *=
dev,
=20
 int vhost_user_input_get_config(struct vhost_dev *dev,
                                 struct virtio_input_config **config);
+int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd);
=20
 #endif /* VHOST_BACKEND_H */
diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 19ed87d07c..5cb76f436b 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -85,6 +85,7 @@ typedef enum VhostUserRequest {
     VHOST_USER_POSTCOPY_LISTEN  =3D 29,
     VHOST_USER_POSTCOPY_END     =3D 30,
     VHOST_USER_INPUT_GET_CONFIG,
+    VHOST_USER_GPU_SET_SOCKET,
     VHOST_USER_MAX
 } VhostUserRequest;
=20
@@ -383,6 +384,16 @@ err:
     return -1;
 }
=20
+int vhost_user_gpu_set_socket(struct vhost_dev *dev, int fd)
+{
+    VhostUserMsg msg =3D {
+        .hdr.request =3D VHOST_USER_GPU_SET_SOCKET,
+        .hdr.flags =3D VHOST_USER_VERSION,
+    };
+
+    return vhost_user_write(dev, &msg, &fd, 1);
+}
+
 static int vhost_user_set_log_base(struct vhost_dev *dev, uint64_t base,
                                    struct vhost_log *log)
 {
--=20
2.17.1.906.g10fd178552
