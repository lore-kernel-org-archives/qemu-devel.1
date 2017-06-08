Received: from eggs.gnu.org ([2001:4830:134:3::10]:59178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3EO-0001Qb-HB
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dJ3EN-0007lA-Kb
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dJ3EN-0007km-EK
	for qemu-devel@nongnu.org; Thu, 08 Jun 2017 15:36:31 -0400
Date: Thu, 8 Jun 2017 22:36:24 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <1496950567-26343-2-git-send-email-mst@redhat.com>
References: <1496950567-26343-1-git-send-email-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1496950567-26343-1-git-send-email-mst@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/3] vhost-user-bridge: fix iov_restore_front()
 warning
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Jens Freimann <jfreiman@redhat.com>, Victor Kaplansky <victork@redhat.com>, Yuanhan Liu <yuanhan.liu@linux.intel.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

  CC      tests/vhost-user-bridge.o
/home/dgilbert/git/qemu-world3/tests/vhost-user-bridge.c:228:23: warning:=
 variables 'front' and 'iov' used in loop condition not modified in loop =
body [-Wfor-loop-analysis]
    for (cur =3D front; front !=3D iov; cur++) {
                      ^~~~~    ~~~
1 warning generated.

Fix the loop, document the function, and fix some related assert().

In practice, the loop bug was harmless because the front sg buffer is
enough to discard/restore the header size.

Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Tested-by: Jens Freimann <jfreiman@redhat.com>
---
 tests/vhost-user-bridge.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 8618c20..1e5b5ca 100644
--- a/tests/vhost-user-bridge.c
+++ b/tests/vhost-user-bridge.c
@@ -220,12 +220,18 @@ vubr_handle_tx(VuDev *dev, int qidx)
     free(elem);
 }
=20
+
+/* this function reverse the effect of iov_discard_front() it must be
+ * called with 'front' being the original struct iovec and 'bytes'
+ * being the number of bytes you shaved off
+ */
 static void
 iov_restore_front(struct iovec *front, struct iovec *iov, size_t bytes)
 {
     struct iovec *cur;
=20
-    for (cur =3D front; front !=3D iov; cur++) {
+    for (cur =3D front; cur !=3D iov; cur++) {
+        assert(bytes >=3D cur->iov_len);
         bytes -=3D cur->iov_len;
     }
=20
@@ -302,7 +308,8 @@ vubr_backend_recv_cb(int sock, void *ctx)
             }
             iov_from_buf(sg, elem->in_num, 0, &hdr, sizeof hdr);
             total +=3D hdrlen;
-            assert(iov_discard_front(&sg, &num, hdrlen) =3D=3D hdrlen);
+            ret =3D iov_discard_front(&sg, &num, hdrlen);
+            assert(ret =3D=3D hdrlen);
         }
=20
         struct msghdr msg =3D {
--=20
MST
