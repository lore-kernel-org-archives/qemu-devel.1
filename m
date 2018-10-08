Received: from eggs.gnu.org ([2001:4830:134:3::10]:42898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g9Y0L-0000FV-4g
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:03:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <i.maximets@samsung.com>) id 1g9Y0J-0007so-Oh
	for qemu-devel@nongnu.org; Mon, 08 Oct 2018 12:03:33 -0400
From: Ilya Maximets <i.maximets@samsung.com>
Date: Mon, 08 Oct 2018 19:05:36 +0300
Message-id: <20181008160536.6332-3-i.maximets@samsung.com>
In-reply-to: <20181008160536.6332-1-i.maximets@samsung.com>
MIME-version: 1.0
References: <20181008160536.6332-1-i.maximets@samsung.com>
	<CGME20181008160328eucas1p14fff8e1e5e5f065019353fb86b845340@eucas1p1.samsung.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [RFC 2/2] vhost-user: Fix userfaultfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Ilya Maximets <i.maximets@samsung.com>, qemu-stable@nongnu.org

'fd' received from the vhost side is never freed.
Also, everything (including 'postcopy_listen' state) should be
cleaned up on vhost cleanup.

Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
Fixes: f82c11165ffa ("vhost+postcopy: Register shared ufd with postcopy")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
---
 hw/virtio/vhost-user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index c442daa562..e09bed0e4a 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1280,6 +1280,7 @@ static int vhost_user_postcopy_end(struct vhost_dev=
 *dev, Error **errp)
         return ret;
     }
     postcopy_unregister_shared_ufd(&u->postcopy_fd);
+    close(u->postcopy_fd.fd);
     u->postcopy_fd.handler =3D NULL;
=20
     trace_vhost_user_postcopy_end_exit();
@@ -1419,6 +1420,12 @@ static int vhost_user_backend_cleanup(struct vhost=
_dev *dev)
         postcopy_remove_notifier(&u->postcopy_notifier);
         u->postcopy_notifier.notify =3D NULL;
     }
+    u->postcopy_listen =3D false;
+    if (u->postcopy_fd.handler) {
+        postcopy_unregister_shared_ufd(&u->postcopy_fd);
+        close(u->postcopy_fd.fd);
+        u->postcopy_fd.handler =3D NULL;
+    }
     if (u->slave_fd >=3D 0) {
         qemu_set_fd_handler(u->slave_fd, NULL, NULL, NULL);
         close(u->slave_fd);
--=20
2.17.1
