Received: from eggs.gnu.org ([209.51.188.92]:59768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GNS-0001p9-IM
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:33:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1h3GGV-00026S-5u
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:26:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1h3GGT-00023o-AJ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 04:26:29 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 8D4B2356C4
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 08:26:27 +0000 (UTC)
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 11 Mar 2019 09:26:17 +0100
Message-Id: <20190311082619.17966-4-kraxel@redhat.com>
In-Reply-To: <20190311082619.17966-1-kraxel@redhat.com>
References: <20190311082619.17966-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PULL 3/5] vnc: fix update stalls
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>

vnc aborts display update jobs on video mode switches and page flips.
That can cause vnc update stalls in case an unfinished vnc job gets
aborted.  The vnc client will never receive the requested update then.
Fix that by copying the state from job_update back to update in that
case.

Reports complain about stalls with two or more clients being connected
at the same time, on some but not all connections.  I suspect it can
also happen with a single connection, multiple connections only make
this more much likely to happen.

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1662260
Reported-by: Ying Fang <fangying1@huawei.com>
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
Reviewed-by: Ying Fang <fangying1@huawei.com>
Message-id: 20190305130930.24516-1-kraxel@redhat.com
---
 ui/vnc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/ui/vnc.c b/ui/vnc.c
index da4a21d4ce94..2f2ab62fcf71 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -700,6 +700,12 @@ static void vnc_abort_display_jobs(VncDisplay *vd)
     }
     QTAILQ_FOREACH(vs, &vd->clients, next) {
         vnc_lock_output(vs);
+        if (vs->update == VNC_STATE_UPDATE_NONE &&
+            vs->job_update != VNC_STATE_UPDATE_NONE) {
+            /* job aborted before completion */
+            vs->update = vs->job_update;
+            vs->job_update = VNC_STATE_UPDATE_NONE;
+        }
         vs->abort = false;
         vnc_unlock_output(vs);
     }
-- 
2.18.1
