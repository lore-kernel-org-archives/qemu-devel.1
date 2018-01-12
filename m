Received: from eggs.gnu.org ([2001:4830:134:3::10]:48313)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvG-0003N2-EC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1eZyvF-0002p7-HC
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:02 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51436)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1eZyvF-0002oE-BH
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 07:59:01 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 5138D76540
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 12:59:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 12 Jan 2018 13:58:49 +0100
Message-Id: <20180112125854.18261-10-kraxel@redhat.com>
In-Reply-To: <20180112125854.18261-1-kraxel@redhat.com>
References: <20180112125854.18261-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/14] ui: refactor code for determining if an
 update should be sent to the client
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

The logic for determining if it is possible to send an update to the clie=
nt
will become more complicated shortly, so pull it out into a separate meth=
od
for easier extension later.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Darren Kenny <darren.kenny@oracle.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20171218191228.31018-9-berrange@redhat.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 243c72be13..4ba7fc076a 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -961,6 +961,25 @@ static int find_and_clear_dirty_height(VncState *vs,
     return h;
 }
=20
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
     VncDisplay *vd =3D vs->vd;
@@ -975,13 +994,7 @@ static int vnc_update_client(VncState *vs, int has_d=
irty)
     }
=20
     vs->has_dirty +=3D has_dirty;
-    if (vs->update =3D=3D VNC_STATE_UPDATE_NONE) {
-        return 0;
-    }
-
-    if (vs->output.offset && !vs->audio_cap &&
-        vs->update !=3D VNC_STATE_UPDATE_FORCE) {
-        /* kernel send buffers are full -> drop frames to throttle */
+    if (!vnc_should_update(vs)) {
         return 0;
     }
=20
--=20
2.9.3
