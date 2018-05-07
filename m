Received: from eggs.gnu.org ([2001:4830:134:3::10]:44365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcot-0008HV-4m
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:52:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fFcor-0002wj-Ot
	for qemu-devel@nongnu.org; Mon, 07 May 2018 05:52:35 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  7 May 2018 11:52:25 +0200
Message-Id: <20180507095225.11659-2-kraxel@redhat.com>
In-Reply-To: <20180507095225.11659-1-kraxel@redhat.com>
References: <20180507095225.11659-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] qxl: fix local renderer crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-stable@nongnu.org

Make sure we only ask the spice local renderer for display updates in
case we have a valid primary surface.  Without that spice is confused
and throws errors in case a display update request (triggered by
screendump for example) happens in parallel to a mode switch and hits
the race window where the old primary surface is gone and the new isn't
establisted yet.

Cc: qemu-stable@nongnu.org
Fixes: https://bugzilla.redhat.com//show_bug.cgi?id=3D1567733
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180427115528.345-1-kraxel@redhat.com
---
 hw/display/qxl-render.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e7ac4f8789..c62b9a5e75 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -169,7 +169,8 @@ void qxl_render_update(PCIQXLDevice *qxl)
=20
     qemu_mutex_lock(&qxl->ssd.lock);
=20
-    if (!runstate_is_running() || !qxl->guest_primary.commands) {
+    if (!runstate_is_running() || !qxl->guest_primary.commands ||
+        qxl->mode =3D=3D QXL_MODE_UNDEFINED) {
         qxl_render_update_area_unlocked(qxl);
         qemu_mutex_unlock(&qxl->ssd.lock);
         return;
--=20
2.9.3
