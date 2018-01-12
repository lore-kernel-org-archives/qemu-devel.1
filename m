Received: from eggs.gnu.org ([2001:4830:134:3::10]:48316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0003N4-FF
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvF-0002op-CB
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51434)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvF-0002nv-4A
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:01 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 32DDA7653E
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:47 +0100
Message-Id: <20180112125854.18261-8-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/14] ui: introduce enum to track VNC client
 framebuffer update request state
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

Currently the VNC servers tracks whether a client has requested an increm=
ental
or forced update with two boolean flags. There are only really 3 distinct
states to track, so create an enum to more accurately reflect permitted s=
tates.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-7-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.h |  9 +++++++--
 ui/vnc.c | 21 +++++++++++----------
 2 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/ui/vnc.h b/ui/vnc.h
index 694cf32ca9..b9d310e640 100644
--- a/ui/vnc.h
+++ b/ui/vnc.h
@@ -252,6 +252,12 @@ struct VncJob
     QTAILQ_ENTRY(VncJob) next;
 };
=20
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
=20
     VncDisplay *vd;
-    int need_update;
-    int force_update;
+    VncStateUpdate update; /* Most recent pending request from client */
     int has_dirty;
     uint32_t features;
     int absolute;
diff --git a/ui/vnc.c b/ui/vnc.c
index a79848f083..30e2feeae3 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -975,16 +975,17 @@ static int vnc_update_client(VncState *vs, int has_=
dirty)
     }
=20
     vs->has_dirty +=3D has_dirty;
-    if (!vs->need_update) {
+    if (vs->update =3D=3D VNC_STATE_UPDATE_NONE) {
         return 0;
     }
=20
-    if (vs->output.offset && !vs->audio_cap && !vs->force_update) {
+    if (vs->output.offset && !vs->audio_cap &&
+        vs->update !=3D VNC_STATE_UPDATE_FORCE) {
         /* kernel send buffers are full -> drop frames to throttle */
         return 0;
     }
=20
-    if (!vs->has_dirty && !vs->force_update) {
+    if (!vs->has_dirty && vs->update !=3D VNC_STATE_UPDATE_FORCE) {
         return 0;
     }
=20
@@ -1030,7 +1031,7 @@ static int vnc_update_client(VncState *vs, int has_=
dirty)
     }
=20
     vnc_job_push(job);
-    vs->force_update =3D 0;
+    vs->update =3D VNC_STATE_UPDATE_INCREMENTAL;
     vs->has_dirty =3D 0;
     return n;
 }
@@ -1869,14 +1870,14 @@ static void ext_key_event(VncState *vs, int down,
 static void framebuffer_update_request(VncState *vs, int incremental,
                                        int x, int y, int w, int h)
 {
-    vs->need_update =3D 1;
-
     if (incremental) {
-        return;
+        if (vs->update !=3D VNC_STATE_UPDATE_FORCE) {
+            vs->update =3D VNC_STATE_UPDATE_INCREMENTAL;
+        }
+    } else {
+        vs->update =3D VNC_STATE_UPDATE_FORCE;
+        vnc_set_area_dirty(vs->dirty, vs->vd, x, y, w, h);
     }
-
-    vs->force_update =3D 1;
-    vnc_set_area_dirty(vs->dirty, vs->vd, x, y, w, h);
 }
=20
 static void send_ext_key_event_ack(VncState *vs)
--=20
2.9.3
