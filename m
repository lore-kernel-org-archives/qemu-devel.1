Received: from eggs.gnu.org ([2001:4830:134:3::10]:50043)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qO-0006Js-JU
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qE-0004yP-Qu
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qE-0004xS-Ha
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:46 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9DCAB5FD45
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:45 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:18 +0000
Message-Id: <20171218191228.31018-4-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 03/13] ui: remove redundant indentation in
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
Cc: Gerd Hoffmann <kraxel@redhat.com>, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, P J P <ppandit@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Now that previous dead / unreachable code has been removed, we can simplify
the indentation in the vnc_client_update method.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 112 ++++++++++++++++++++++++++++++++-------------------------------
 1 file changed, 57 insertions(+), 55 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 869c75bbcf..a61fcbd20c 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -963,74 +963,76 @@ static int find_and_clear_dirty_height(VncState *vs,
 
 static int vnc_update_client(VncState *vs, int has_dirty)
 {
+    VncDisplay *vd = vs->vd;
+    VncJob *job;
+    int y;
+    int height, width;
+    int n = 0;
+
     if (vs->disconnecting) {
         vnc_disconnect_finish(vs);
         return 0;
     }
 
     vs->has_dirty += has_dirty;
-    if (vs->need_update) {
-        VncDisplay *vd = vs->vd;
-        VncJob *job;
-        int y;
-        int height, width;
-        int n = 0;
-
-        if (vs->output.offset && !vs->audio_cap && !vs->force_update)
-            /* kernel send buffers are full -> drop frames to throttle */
-            return 0;
+    if (!vs->need_update) {
+        return 0;
+    }
 
-        if (!vs->has_dirty && !vs->audio_cap && !vs->force_update)
-            return 0;
+    if (vs->output.offset && !vs->audio_cap && !vs->force_update) {
+        /* kernel send buffers are full -> drop frames to throttle */
+        return 0;
+    }
 
-        /*
-         * Send screen updates to the vnc client using the server
-         * surface and server dirty map.  guest surface updates
-         * happening in parallel don't disturb us, the next pass will
-         * send them to the client.
-         */
-        job = vnc_job_new(vs);
-
-        height = pixman_image_get_height(vd->server);
-        width = pixman_image_get_width(vd->server);
-
-        y = 0;
-        for (;;) {
-            int x, h;
-            unsigned long x2;
-            unsigned long offset = find_next_bit((unsigned long *) &vs->dirty,
-                                                 height * VNC_DIRTY_BPL(vs),
-                                                 y * VNC_DIRTY_BPL(vs));
-            if (offset == height * VNC_DIRTY_BPL(vs)) {
-                /* no more dirty bits */
+    if (!vs->has_dirty && !vs->audio_cap && !vs->force_update) {
+        return 0;
+    }
+
+    /*
+     * Send screen updates to the vnc client using the server
+     * surface and server dirty map.  guest surface updates
+     * happening in parallel don't disturb us, the next pass will
+     * send them to the client.
+     */
+    job = vnc_job_new(vs);
+
+    height = pixman_image_get_height(vd->server);
+    width = pixman_image_get_width(vd->server);
+
+    y = 0;
+    for (;;) {
+        int x, h;
+        unsigned long x2;
+        unsigned long offset = find_next_bit((unsigned long *) &vs->dirty,
+                                             height * VNC_DIRTY_BPL(vs),
+                                             y * VNC_DIRTY_BPL(vs));
+        if (offset == height * VNC_DIRTY_BPL(vs)) {
+            /* no more dirty bits */
+            break;
+        }
+        y = offset / VNC_DIRTY_BPL(vs);
+        x = offset % VNC_DIRTY_BPL(vs);
+        x2 = find_next_zero_bit((unsigned long *) &vs->dirty[y],
+                                VNC_DIRTY_BPL(vs), x);
+        bitmap_clear(vs->dirty[y], x, x2 - x);
+        h = find_and_clear_dirty_height(vs, y, x, x2, height);
+        x2 = MIN(x2, width / VNC_DIRTY_PIXELS_PER_BIT);
+        if (x2 > x) {
+            n += vnc_job_add_rect(job, x * VNC_DIRTY_PIXELS_PER_BIT, y,
+                                  (x2 - x) * VNC_DIRTY_PIXELS_PER_BIT, h);
+        }
+        if (!x && x2 == width / VNC_DIRTY_PIXELS_PER_BIT) {
+            y += h;
+            if (y == height) {
                 break;
             }
-            y = offset / VNC_DIRTY_BPL(vs);
-            x = offset % VNC_DIRTY_BPL(vs);
-            x2 = find_next_zero_bit((unsigned long *) &vs->dirty[y],
-                                    VNC_DIRTY_BPL(vs), x);
-            bitmap_clear(vs->dirty[y], x, x2 - x);
-            h = find_and_clear_dirty_height(vs, y, x, x2, height);
-            x2 = MIN(x2, width / VNC_DIRTY_PIXELS_PER_BIT);
-            if (x2 > x) {
-                n += vnc_job_add_rect(job, x * VNC_DIRTY_PIXELS_PER_BIT, y,
-                                      (x2 - x) * VNC_DIRTY_PIXELS_PER_BIT, h);
-            }
-            if (!x && x2 == width / VNC_DIRTY_PIXELS_PER_BIT) {
-                y += h;
-                if (y == height) {
-                    break;
-                }
-            }
         }
-
-        vnc_job_push(job);
-        vs->force_update = 0;
-        vs->has_dirty = 0;
-        return n;
     }
 
-    return 0;
+    vnc_job_push(job);
+    vs->force_update = 0;
+    vs->has_dirty = 0;
+    return n;
 }
 
 /* audio */
-- 
2.14.3
