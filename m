Received: from eggs.gnu.org ([2001:4830:134:3::10]:48246)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvD-0003L5-JV
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvA-0002iP-SM
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56729)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvA-0002hU-JZ
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:58:56 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A690840111
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:58:55 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:44 +0100
Message-Id: <20180112125854.18261-5-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 04/14] ui: remove redundant indentation in
 vnc_client_update
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

Now that previous dead / unreachable code has been removed, we can simpli=
fy
the indentation in the vnc_client_update method.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-4-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 106 ++++++++++++++++++++++++++++++++-------------------------=
------
 1 file changed, 54 insertions(+), 52 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 29a7208475..7582111ca6 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -963,74 +963,76 @@ static int find_and_clear_dirty_height(VncState *vs=
,
=20
 static int vnc_update_client(VncState *vs, int has_dirty)
 {
+    VncDisplay *vd =3D vs->vd;
+    VncJob *job;
+    int y;
+    int height, width;
+    int n =3D 0;
+
     if (vs->disconnecting) {
         vnc_disconnect_finish(vs);
         return 0;
     }
=20
     vs->has_dirty +=3D has_dirty;
-    if (vs->need_update) {
-        VncDisplay *vd =3D vs->vd;
-        VncJob *job;
-        int y;
-        int height, width;
-        int n =3D 0;
+    if (!vs->need_update) {
+        return 0;
+    }
=20
-        if (vs->output.offset && !vs->audio_cap && !vs->force_update)
-            /* kernel send buffers are full -> drop frames to throttle *=
/
-            return 0;
+    if (vs->output.offset && !vs->audio_cap && !vs->force_update) {
+        /* kernel send buffers are full -> drop frames to throttle */
+        return 0;
+    }
=20
-        if (!vs->has_dirty && !vs->audio_cap && !vs->force_update)
-            return 0;
+    if (!vs->has_dirty && !vs->audio_cap && !vs->force_update) {
+        return 0;
+    }
=20
-        /*
-         * Send screen updates to the vnc client using the server
-         * surface and server dirty map.  guest surface updates
-         * happening in parallel don't disturb us, the next pass will
-         * send them to the client.
-         */
-        job =3D vnc_job_new(vs);
+    /*
+     * Send screen updates to the vnc client using the server
+     * surface and server dirty map.  guest surface updates
+     * happening in parallel don't disturb us, the next pass will
+     * send them to the client.
+     */
+    job =3D vnc_job_new(vs);
=20
-        height =3D pixman_image_get_height(vd->server);
-        width =3D pixman_image_get_width(vd->server);
+    height =3D pixman_image_get_height(vd->server);
+    width =3D pixman_image_get_width(vd->server);
=20
-        y =3D 0;
-        for (;;) {
-            int x, h;
-            unsigned long x2;
-            unsigned long offset =3D find_next_bit((unsigned long *) &vs=
->dirty,
-                                                 height * VNC_DIRTY_BPL(=
vs),
-                                                 y * VNC_DIRTY_BPL(vs));
-            if (offset =3D=3D height * VNC_DIRTY_BPL(vs)) {
-                /* no more dirty bits */
+    y =3D 0;
+    for (;;) {
+        int x, h;
+        unsigned long x2;
+        unsigned long offset =3D find_next_bit((unsigned long *) &vs->di=
rty,
+                                             height * VNC_DIRTY_BPL(vs),
+                                             y * VNC_DIRTY_BPL(vs));
+        if (offset =3D=3D height * VNC_DIRTY_BPL(vs)) {
+            /* no more dirty bits */
+            break;
+        }
+        y =3D offset / VNC_DIRTY_BPL(vs);
+        x =3D offset % VNC_DIRTY_BPL(vs);
+        x2 =3D find_next_zero_bit((unsigned long *) &vs->dirty[y],
+                                VNC_DIRTY_BPL(vs), x);
+        bitmap_clear(vs->dirty[y], x, x2 - x);
+        h =3D find_and_clear_dirty_height(vs, y, x, x2, height);
+        x2 =3D MIN(x2, width / VNC_DIRTY_PIXELS_PER_BIT);
+        if (x2 > x) {
+            n +=3D vnc_job_add_rect(job, x * VNC_DIRTY_PIXELS_PER_BIT, y=
,
+                                  (x2 - x) * VNC_DIRTY_PIXELS_PER_BIT, h=
);
+        }
+        if (!x && x2 =3D=3D width / VNC_DIRTY_PIXELS_PER_BIT) {
+            y +=3D h;
+            if (y =3D=3D height) {
                 break;
             }
-            y =3D offset / VNC_DIRTY_BPL(vs);
-            x =3D offset % VNC_DIRTY_BPL(vs);
-            x2 =3D find_next_zero_bit((unsigned long *) &vs->dirty[y],
-                                    VNC_DIRTY_BPL(vs), x);
-            bitmap_clear(vs->dirty[y], x, x2 - x);
-            h =3D find_and_clear_dirty_height(vs, y, x, x2, height);
-            x2 =3D MIN(x2, width / VNC_DIRTY_PIXELS_PER_BIT);
-            if (x2 > x) {
-                n +=3D vnc_job_add_rect(job, x * VNC_DIRTY_PIXELS_PER_BI=
T, y,
-                                      (x2 - x) * VNC_DIRTY_PIXELS_PER_BI=
T, h);
-            }
-            if (!x && x2 =3D=3D width / VNC_DIRTY_PIXELS_PER_BIT) {
-                y +=3D h;
-                if (y =3D=3D height) {
-                    break;
-                }
-            }
         }
-
-        vnc_job_push(job);
-        vs->force_update =3D 0;
-        vs->has_dirty =3D 0;
-        return n;
     }
=20
-    return 0;
+    vnc_job_push(job);
+    vs->force_update =3D 0;
+    vs->has_dirty =3D 0;
+    return n;
 }
=20
 /* audio */
--=20
2.9.3
