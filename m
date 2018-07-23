Received: from eggs.gnu.org ([2001:4830:134:3::10]:40523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhI2-0001Ha-NS
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <flukshun@gmail.com>) id 1fhhI1-00027I-PD
	for qemu-devel@nongnu.org; Mon, 23 Jul 2018 16:18:42 -0400
Sender: fluxion <flukshun@gmail.com>
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 23 Jul 2018 15:16:19 -0500
Message-Id: <20180723201748.25573-11-mdroth@linux.vnet.ibm.com>
In-Reply-To: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
References: <20180723201748.25573-1-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 10/99] qxl: fix local renderer crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>

From: Gerd Hoffmann <kraxel@redhat.com>

Make sure we only ask the spice local renderer for display updates in
case we have a valid primary surface.  Without that spice is confused
and throws errors in case a display update request (triggered by
screendump for example) happens in parallel to a mode switch and hits
the race window where the old primary surface is gone and the new isn't
establisted yet.

Cc: qemu-stable@nongnu.org
Fixes: https://bugzilla.redhat.com//show_bug.cgi?id=1567733
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-id: 20180427115528.345-1-kraxel@redhat.com
(cherry picked from commit 5bd5c27c7d284d01477c5cc022ce22438c46bf9f)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 hw/display/qxl-render.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/display/qxl-render.c b/hw/display/qxl-render.c
index e7ac4f8789..c62b9a5e75 100644
--- a/hw/display/qxl-render.c
+++ b/hw/display/qxl-render.c
@@ -169,7 +169,8 @@ void qxl_render_update(PCIQXLDevice *qxl)
 
     qemu_mutex_lock(&qxl->ssd.lock);
 
-    if (!runstate_is_running() || !qxl->guest_primary.commands) {
+    if (!runstate_is_running() || !qxl->guest_primary.commands ||
+        qxl->mode == QXL_MODE_UNDEFINED) {
         qxl_render_update_area_unlocked(qxl);
         qemu_mutex_unlock(&qxl->ssd.lock);
         return;
-- 
2.17.1
