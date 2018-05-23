Received: from eggs.gnu.org ([2001:4830:134:3::10]:48937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyw-0001rI-Oi
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fLUyw-0000pG-2J
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:14 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46954 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fLUyv-0000p7-TK
	for qemu-devel@nongnu.org; Wed, 23 May 2018 10:43:13 -0400
Date: Wed, 23 May 2018 17:43:12 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1527086545-68024-17-git-send-email-mst@redhat.com>
References: <1527086545-68024-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1527086545-68024-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 16/28] libvhost-user: Send messages with no data
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Yongji Xie <xieyongji@baidu.com>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The response to a VHOST_USER_POSTCOPY_ADVISE contains a fd but doesn't
actually contain any data.   FIx vu_message_write so that it doesn't
do a 0-byte write() call, since this was ending up with rc=3D0
that was confusing the error handling code.

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 contrib/libvhost-user/libvhost-user.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/contrib/libvhost-user/libvhost-user.c b/contrib/libvhost-use=
r/libvhost-user.c
index beeed0c..54e643d 100644
--- a/contrib/libvhost-user/libvhost-user.c
+++ b/contrib/libvhost-user/libvhost-user.c
@@ -323,13 +323,15 @@ vu_message_write(VuDev *dev, int conn_fd, VhostUser=
Msg *vmsg)
         rc =3D sendmsg(conn_fd, &msg, 0);
     } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
=20
-    do {
-        if (vmsg->data) {
-            rc =3D write(conn_fd, vmsg->data, vmsg->size);
-        } else {
-            rc =3D write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->size);
-        }
-    } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+    if (vmsg->size) {
+        do {
+            if (vmsg->data) {
+                rc =3D write(conn_fd, vmsg->data, vmsg->size);
+            } else {
+                rc =3D write(conn_fd, p + VHOST_USER_HDR_SIZE, vmsg->siz=
e);
+            }
+        } while (rc < 0 && (errno =3D=3D EINTR || errno =3D=3D EAGAIN));
+    }
=20
     if (rc <=3D 0) {
         vu_panic(dev, "Error while writing: %s", strerror(errno));
--=20
MST
