Received: from eggs.gnu.org ([2001:4830:134:3::10]:40128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cko3o-0002n4-IV
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:32:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1cko3l-0007NE-DO
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:32:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43718)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1cko3l-0007MQ-7v
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:32:01 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2FDB7E9DD
	for <qemu-devel@nongnu.org>; Mon,  6 Mar 2017 08:32:00 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon,  6 Mar 2017 09:31:51 +0100
Message-Id: <1488789111-27340-1-git-send-email-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH] qxl: clear guest_cursor on QXL_CURSOR_HIDE
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

Make sure we don't leave guest_cursor pointing into nowhere.  This might
lead to (rare) live migration failures, due to target trying to restore
the cursor from the stale pointer.

Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=1421788
Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/qxl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/display/qxl.c b/hw/display/qxl.c
index af4c0ca..0d02f0e 100644
--- a/hw/display/qxl.c
+++ b/hw/display/qxl.c
@@ -477,6 +477,11 @@ static int qxl_track_command(PCIQXLDevice *qxl, struct QXLCommandExt *ext)
             qxl->guest_cursor = ext->cmd.data;
             qemu_mutex_unlock(&qxl->track_lock);
         }
+        if (cmd->type == QXL_CURSOR_HIDE) {
+            qemu_mutex_lock(&qxl->track_lock);
+            qxl->guest_cursor = 0;
+            qemu_mutex_unlock(&qxl->track_lock);
+        }
         break;
     }
     }
-- 
1.8.3.1
