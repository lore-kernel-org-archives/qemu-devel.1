Received: from eggs.gnu.org ([2001:4830:134:3::10]:55635)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhkE-0005dp-UC
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:15:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dGhk9-0004HM-VN
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:15:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44316)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dGhk9-0004HE-Pd
	for qemu-devel@nongnu.org; Fri, 02 Jun 2017 04:15:37 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CEB1E659AD
	for <qemu-devel@nongnu.org>; Fri,  2 Jun 2017 08:15:36 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Fri,  2 Jun 2017 12:15:19 +0400
Message-Id: <20170602081519.15648-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] vhost-user-bridge: fix iov_restore_front()
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
Cc: dgilbert@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

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
---
 tests/vhost-user-bridge.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tests/vhost-user-bridge.c b/tests/vhost-user-bridge.c
index 8618c20d53..1e5b5ca3da 100644
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
2.13.0.91.g00982b8dd
