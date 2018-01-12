Received: from eggs.gnu.org ([2001:4830:134:3::10]:48308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0003Mx-Bm
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvF-0002ob-AX
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:50048)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvF-0002o0-4Z
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3DB7915447
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:42 +0100
Message-Id: <20180112125854.18261-3-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/14] ui: remove 'sync' parameter from
 vnc_update_client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Daniel P. Berrange" <berrange@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

There is only one caller of vnc_update_client and that always passes fals=
e
for the 'sync' parameter.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-2-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 7d537b5c6b..d72a61bde3 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -596,7 +596,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
    3) resolutions > 1024
 */
=20
-static int vnc_update_client(VncState *vs, int has_dirty, bool sync);
+static int vnc_update_client(VncState *vs, int has_dirty);
 static void vnc_disconnect_start(VncState *vs);
=20
 static void vnc_colordepth(VncState *vs);
@@ -961,7 +961,7 @@ static int find_and_clear_dirty_height(VncState *vs,
     return h;
 }
=20
-static int vnc_update_client(VncState *vs, int has_dirty, bool sync)
+static int vnc_update_client(VncState *vs, int has_dirty)
 {
     if (vs->disconnecting) {
         vnc_disconnect_finish(vs);
@@ -1025,9 +1025,6 @@ static int vnc_update_client(VncState *vs, int has_=
dirty, bool sync)
         }
=20
         vnc_job_push(job);
-        if (sync) {
-            vnc_jobs_join(vs);
-        }
         vs->force_update =3D 0;
         vs->has_dirty =3D 0;
         return n;
@@ -1035,8 +1032,6 @@ static int vnc_update_client(VncState *vs, int has_=
dirty, bool sync)
=20
     if (vs->disconnecting) {
         vnc_disconnect_finish(vs);
-    } else if (sync) {
-        vnc_jobs_join(vs);
     }
=20
     return 0;
@@ -2863,7 +2858,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     vnc_unlock_display(vd);
=20
     QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
-        rects +=3D vnc_update_client(vs, has_dirty, false);
+        rects +=3D vnc_update_client(vs, has_dirty);
         /* vs might be free()ed here */
     }
=20
--=20
2.9.3
