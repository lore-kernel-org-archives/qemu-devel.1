Received: from eggs.gnu.org ([2001:4830:134:3::10]:37508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC1yb-0005Qo-IC
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:55:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fC1yW-0008SV-OQ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:55:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59920 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1fC1yW-0008SJ-JM
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 07:55:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 43BE440252F5
	for <qemu-devel@nongnu.org>; Fri, 27 Apr 2018 11:55:36 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Fri, 27 Apr 2018 13:55:28 +0200
Message-Id: <20180427115528.345-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] qxl: fix local renderer crash
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

Make sure we only ask the spice local renderer for display updates in
case we have a valid primary surface.  Without that spice is confused
and throws errors in case a display update request (triggered by
screendump for example) happens in parallel to a mode switch and hits
the race window where the old primary surface is gone and the new isn't
establisted yet.

Fixes: https://bugzilla.redhat.com//show_bug.cgi?id=1567733
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
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
2.9.3
