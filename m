Received: from eggs.gnu.org ([2001:4830:134:3::10]:50369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qW-0006So-Vc
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1eR0qT-0005L6-DT
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35798)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1eR0qT-0005JD-3D
	for qemu-devel@nongnu.org; Mon, 18 Dec 2017 14:13:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3FFED7EA83
	for <qemu-devel@nongnu.org>; Mon, 18 Dec 2017 19:13:00 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Mon, 18 Dec 2017 19:12:23 +0000
Message-Id: <20171218191228.31018-9-berrange@redhat.com>
In-Reply-To: <20171218191228.31018-1-berrange@redhat.com>
References: <20171218191228.31018-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v1 08/13] ui: refactor code for determining if
 an update should be sent to the client
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

The logic for determining if it is possible to send an update to the client
will become more complicated shortly, so pull it out into a separate method
for easier extension later.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 ui/vnc.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 51fbf0449d..6ae002cd36 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -961,6 +961,25 @@ static int find_and_clear_dirty_height(VncState *vs,
     return h;
 }
 
+static bool vnc_should_update(VncState *vs)
+{
+    switch (vs->update) {
+    case VNC_STATE_UPDATE_NONE:
+        break;
+    case VNC_STATE_UPDATE_INCREMENTAL:
+        /* Only allow incremental updates if the output buffer
+         * is empty, or if audio capture is enabled.
+         */
+        if (!vs->output.offset || vs->audio_cap) {
+            return true;
+        }
+        break;
+    case VNC_STATE_UPDATE_FORCE:
+        return true;
+    }
+    return false;
+}
+
 static int vnc_update_client(VncState *vs, int has_dirty)
 {
     VncDisplay *vd = vs->vd;
@@ -975,13 +994,7 @@ static int vnc_update_client(VncState *vs, int has_dirty)
     }
 
     vs->has_dirty += has_dirty;
-    if (vs->update == VNC_STATE_UPDATE_NONE) {
-        return 0;
-    }
-
-    if (vs->output.offset && !vs->audio_cap &&
-        vs->update != VNC_STATE_UPDATE_FORCE) {
-        /* kernel send buffers are full -> drop frames to throttle */
+    if (!vnc_should_update(vs)) {
         return 0;
     }
 
-- 
2.14.3
