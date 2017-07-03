Received: from eggs.gnu.org ([2001:4830:134:3::10]:47208)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7ID-00006B-BM
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dS7IC-0003da-IO
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dS7IC-0003cX-Bx
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 15:45:56 -0400
Date: Mon, 3 Jul 2017 22:45:49 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1499111049-13721-19-git-send-email-mst@redhat.com>
References: <1499111049-13721-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1499111049-13721-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/21] vhost-user: unregister slave req handler
 at cleanup time
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Maxime Coquelin <maxime.coquelin@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: Maxime Coquelin <maxime.coquelin@redhat.com>

If the backend sends a request just before closing the socket,
the aio dispatcher might schedule its reading after the vhost
device has been cleaned, leading to a NULL pointer dereference
in slave_read();

vhost_user_cleanup() already closes the socket but it is not
enough, the handler has to be unregistered.

Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index 958ee09..2203011 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -779,6 +779,7 @@ static int vhost_user_cleanup(struct vhost_dev *dev)
=20
     u =3D dev->opaque;
     if (u->slave_fd >=3D 0) {
+        qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
         close(u->slave_fd);
         u->slave_fd =3D -1;
     }
--=20
MST
