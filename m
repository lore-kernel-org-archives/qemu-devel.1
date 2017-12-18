Received: from eggs.gnu.org ([2001:4830:134:3::10]:49943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qM-0006Gs-1v
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qA-0004uU-Sr
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57654)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qA-0004tY-M6
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:42 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D1C54C045757
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:41 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:16 +0000
Message-Id: <20171218191228.31018-2-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 01/13] ui: remove 'sync' parametr from
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

There is only one caller of vnc_update_client and that always passes false
for the 'sync' parameter.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 9f8d5a1b1f..7ba3297dfa 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -596,7 +596,7 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
    3) resolutions > 1024
 */
 
-static int vnc_update_client(VncState *vs, int has_dirty, bool sync);
+static int vnc_update_client(VncState *vs, int has_dirty);
 static void vnc_disconnect_start(VncState *vs);
 
 static void vnc_colordepth(VncState *vs);
@@ -961,7 +961,7 @@ static int find_and_clear_dirty_height(VncState *vs,
     return h;
 }
 
-static int vnc_update_client(VncState *vs, int has_dirty, bool sync)
+static int vnc_update_client(VncState *vs, int has_dirty)
 {
     if (vs->disconnecting) {
         vnc_disconnect_finish(vs);
@@ -1025,9 +1025,6 @@ static int vnc_update_client(VncState *vs, int has_dirty, bool sync)
         }
 
         vnc_job_push(job);
-        if (sync) {
-            vnc_jobs_join(vs);
-        }
         vs->force_update = 0;
         vs->has_dirty = 0;
         return n;
@@ -1035,8 +1032,6 @@ static int vnc_update_client(VncState *vs, int has_dirty, bool sync)
 
     if (vs->disconnecting) {
         vnc_disconnect_finish(vs);
-    } else if (sync) {
-        vnc_jobs_join(vs);
     }
 
     return 0;
@@ -2863,7 +2858,7 @@ static void vnc_refresh(DisplayChangeListener *dcl)
     vnc_unlock_display(vd);
 
     QTAILQ_FOREACH_SAFE(vs, &vd->clients, next, vn) {
-        rects += vnc_update_client(vs, has_dirty, false);
+        rects += vnc_update_client(vs, has_dirty);
         /* vs might be free()ed here */
     }
 
-- 
2.14.3
