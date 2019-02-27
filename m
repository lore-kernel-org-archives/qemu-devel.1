Received: from eggs.gnu.org ([209.51.188.92]:57021)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gywct-0001BB-01
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:39:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1gywcr-0005tj-0M
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:39:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37368)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1gywcq-0005so-QE
	for qemu-devel@nongnu.org; Wed, 27 Feb 2019 05:39:44 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8687319FB2
	for <qemu-devel@nongnu.org>; Wed, 27 Feb 2019 10:31:03 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Wed, 27 Feb 2019 11:30:12 +0100
Message-Id: <20190227103017.29515-8-marcandre.lureau@redhat.com>
In-Reply-To: <20190227103017.29515-1-marcandre.lureau@redhat.com>
References: <20190227103017.29515-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 07/12] vhost-user: split vhost_user_read()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: kraxel@redhat.com, mst@redhat.com

Split vhost_user_read(), so only header can be read with
vhost_user_read_header().

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 hw/virtio/vhost-user.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b2e1175c1e..0acf56fe96 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -210,7 +210,7 @@ static bool ioeventfd_enabled(void)
     return !kvm_enabled() || kvm_eventfds_enabled();
 }
=20
-static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
+static int vhost_user_read_header(struct vhost_dev *dev, VhostUserMsg *m=
sg)
 {
     struct vhost_user *u =3D dev->opaque;
     CharBackend *chr =3D u->user->chr;
@@ -221,7 +221,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vho=
stUserMsg *msg)
     if (r !=3D size) {
         error_report("Failed to read msg header. Read %d instead of %d."
                      " Original request %d.", r, size, msg->hdr.request)=
;
-        goto fail;
+        return -1;
     }
=20
     /* validate received flags */
@@ -229,7 +229,21 @@ static int vhost_user_read(struct vhost_dev *dev, Vh=
ostUserMsg *msg)
         error_report("Failed to read msg header."
                 " Flags 0x%x instead of 0x%x.", msg->hdr.flags,
                 VHOST_USER_REPLY_MASK | VHOST_USER_VERSION);
-        goto fail;
+        return -1;
+    }
+
+    return 0;
+}
+
+static int vhost_user_read(struct vhost_dev *dev, VhostUserMsg *msg)
+{
+    struct vhost_user *u =3D dev->opaque;
+    CharBackend *chr =3D u->user->chr;
+    uint8_t *p =3D (uint8_t *) msg;
+    int r, size;
+
+    if (vhost_user_read_header(dev, msg) < 0) {
+        return -1;
     }
=20
     /* validate message size is sane */
@@ -237,7 +251,7 @@ static int vhost_user_read(struct vhost_dev *dev, Vho=
stUserMsg *msg)
         error_report("Failed to read msg header."
                 " Size %d exceeds the maximum %zu.", msg->hdr.size,
                 VHOST_USER_PAYLOAD_SIZE);
-        goto fail;
+        return -1;
     }
=20
     if (msg->hdr.size) {
@@ -247,14 +261,11 @@ static int vhost_user_read(struct vhost_dev *dev, V=
hostUserMsg *msg)
         if (r !=3D size) {
             error_report("Failed to read msg payload."
                          " Read %d instead of %d.", r, msg->hdr.size);
-            goto fail;
+            return -1;
         }
     }
=20
     return 0;
-
-fail:
-    return -1;
 }
=20
 static int process_message_reply(struct vhost_dev *dev,
--=20
2.21.0
