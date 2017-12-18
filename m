Received: from eggs.gnu.org ([2001:4830:134:3::10]:50212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qS-0006Pr-Uw
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qK-000570-VQ
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:00 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qK-00055P-Ji
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:12:52 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A604581226
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:12:51 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:21 +0000
Message-Id: <20171218191228.31018-7-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 06/13] ui: introduce enum to track VNC
 client framebuffer update request state
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

Currently the VNC servers tracks whether a client has requested an incremental
or forced update with two boolean flags. There are only really 3 distinct
states to track, so create an enum to more accurately reflect permitted states.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 21 +++++++++++----------
 ui/vnc.h |  9 +++++++--
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index f53eddb8e5..d3b04f1166 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -975,16 +975,17 @@ static int vnc_update_client(VncState *vs, int has_dirty)
     }
 
     vs->has_dirty += has_dirty;
-    if (!vs->need_update) {
+    if (vs->update == VNC_STATE_UPDATE_NONE) {
         return 0;
     }
 
-    if (vs->output.offset && !vs->audio_cap && !vs->force_update) {
+    if (vs->output.offset && !vs->audio_cap &&
+        vs->update != VNC_STATE_UPDATE_FORCE) {
         /* kernel send buffers are full -> drop frames to throttle */
         return 0;
     }
 
-    if (!vs->has_dirty && !vs->force_update) {
+    if (!vs->has_dirty && vs->update != VNC_STATE_UPDATE_FORCE) {
         return 0;
     }
 
@@ -1030,7 +1031,7 @@ static int vnc_update_client(VncState *vs, int has_dirty)
     }
 
     vnc_job_push(job);
-    vs->force_update = 0;
+    vs->update = VNC_STATE_UPDATE_INCREMENTAL;
     vs->has_dirty = 0;
     return n;
 }
@@ -1869,14 +1870,14 @@ static void ext_key_event(VncState *vs, int down,
 static void framebuffer_update_request(VncState *vs, int incremental,
                                        int x, int y, int w, int h)
 {
-    vs->need_update = 1;
-
     if (incremental) {
-        return;
+        if (vs->update != VNC_STATE_UPDATE_FORCE) {
+            vs->update = VNC_STATE_UPDATE_INCREMENTAL;
+        }
+    } else {
+        vs->update = VNC_STATE_UPDATE_FORCE;
+        vnc_set_area_dirty(vs->dirty, vs->vd, x, y, w, h);
     }
-
-    vs->force_update = 1;
-    vnc_set_area_dirty(vs->dirty, vs->vd, x, y, w, h);
 }
 
 static void send_ext_key_event_ack(VncState *vs)
diff --git a/ui/vnc.h b/ui/vnc.h
index 694cf32ca9..b9d310e640 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -252,6 +252,12 @@ struct VncJob
     QTAILQ_ENTRY(VncJob) next;
 };
 
+typedef enum {
+    VNC_STATE_UPDATE_NONE,
+    VNC_STATE_UPDATE_INCREMENTAL,
+    VNC_STATE_UPDATE_FORCE,
+} VncStateUpdate;
+
 struct VncState
 {
     QIOChannelSocket *sioc; /* The underlying socket */
@@ -264,8 +270,7 @@ struct VncState
                            * vnc-jobs-async.c */
 
     VncDisplay *vd;
-    int need_update;
-    int force_update;
+    VncStateUpdate update; /* Most recent pending request from client */
     int has_dirty;
     uint32_t features;
     int absolute;
-- 
2.14.3
