Received: from eggs.gnu.org ([2001:4830:134:3::10]:51082)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mX-0006sx-Nj
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ey7mV-0008J0-Dm
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34264 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ey7mV-0008In-8O
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 23:17:47 -0400
Date: Tue, 20 Mar 2018 05:17:46 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1521515720-612046-32-git-send-email-mst@redhat.com>
References: <1521515720-612046-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1521515720-612046-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL v2 31/50] vhost+postcopy: Register shared ufd
 with postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Register the UFD that comes in as the response to the 'advise' method
with the postcopy code.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user.c b/hw/virtio/vhost-user.c
index ceb17b0..5900583 100644
--- a/hw/virtio/vhost-user.c
+++ b/hw/virtio/vhost-user.c
@@ -171,6 +171,7 @@ struct vhost_user {
     CharBackend *chr;
     int slave_fd;
     NotifierWithReturn postcopy_notifier;
+    struct PostCopyFD  postcopy_fd;
 };
=20
 static bool ioeventfd_enabled(void)
@@ -797,6 +798,17 @@ out:
 }
=20
 /*
+ * Called back from the postcopy fault thread when a fault is received o=
n our
+ * ufd.
+ * TODO: This is Linux specific
+ */
+static int vhost_user_postcopy_fault_handler(struct PostCopyFD *pcfd,
+                                             void *ufd)
+{
+    return 0;
+}
+
+/*
  * Called at the start of an inbound postcopy on reception of the
  * 'advise' command.
  */
@@ -835,8 +847,14 @@ static int vhost_user_postcopy_advise(struct vhost_d=
ev *dev, Error **errp)
         error_setg(errp, "%s: Failed to get ufd", __func__);
         return -1;
     }
+    fcntl(ufd, F_SETFL, O_NONBLOCK);
=20
-    /* TODO: register ufd with userfault thread */
+    /* register ufd with userfault thread */
+    u->postcopy_fd.fd =3D ufd;
+    u->postcopy_fd.data =3D dev;
+    u->postcopy_fd.handler =3D vhost_user_postcopy_fault_handler;
+    u->postcopy_fd.idstr =3D "vhost-user"; /* Need to find unique name *=
/
+    postcopy_register_shared_ufd(&u->postcopy_fd);
     return 0;
 }
=20
--=20
MST
