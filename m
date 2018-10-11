Received: from eggs.gnu.org ([2001:4830:134:3::10]:44843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaY-0004vK-Lj
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gAgaU-0001cF-2b
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:38 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39090)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gAgaT-0001Xb-IJ
	for qemu-devel@nongnu.org; Thu, 11 Oct 2018 15:25:33 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Thu, 11 Oct 2018 20:25:10 +0100
Message-Id: <20181011192513.63634-5-dgilbert@redhat.com>
In-Reply-To: <20181011192513.63634-1-dgilbert@redhat.com>
References: <20181011192513.63634-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/7] vhost-user: Fix userfaultfd leak
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com
Cc: wei@redhat.com, thuth@redhat.com, i.maximets@samsung.com, den@openvz.org

From: Ilya Maximets <i.maximets@samsung.com>

'fd' received from the vhost side is never freed.
Also, everything (including 'postcopy_listen' state) should be
cleaned up on vhost cleanup.

Fixes: 46343570c06e ("vhost+postcopy: Wire up POSTCOPY_END notify")
Fixes: f82c11165ffa ("vhost+postcopy: Register shared ufd with postcopy")
Cc: qemu-stable@nongnu.org
Signed-off-by: Ilya Maximets <i.maximets@samsung.com>
Message-Id: <20181008160536.6332-3-i.maximets@samsung.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 hw/virtio/vhost-user.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index b041343632..ed47d645d9 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -1291,6 +1291,7 @@ static int vhost_user_postcopy_end(struct vhost_dev=
 *dev, Error **errp)
         return ret;
     }
     postcopy_unregister_shared_ufd(&u->postcopy_fd);
+    close(u->postcopy_fd.fd);
     u->postcopy_fd.handler =3D NULL;
=20
     trace_vhost_user_postcopy_end_exit();
@@ -1430,6 +1431,12 @@ static int vhost_user_backend_cleanup(struct vhost=
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
2.19.0
