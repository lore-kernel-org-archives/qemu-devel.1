Received: from eggs.gnu.org ([2001:4830:134:3::10]:35067)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fnAJJ-0002hA-KV
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 18:18:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter@lekensteyn.nl>) id 1fnAJI-00030h-Mk
	for qemu-devel@nongnu.org; Tue, 07 Aug 2018 18:18:37 -0400
From: Peter Wu <peter@lekensteyn.nl>
Date: Wed,  8 Aug 2018 00:18:30 +0200
Message-Id: <20180807221830.3844-1-peter@lekensteyn.nl>
Subject: [Qemu-devel] [PATCH] vnc: fix memleak of the "vnc-worker-output"
 name
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

Fixes repeated memory leaks of 18 bytes when using VNC:

    Direct leak of 831024 byte(s) in 46168 object(s) allocated from:
        ...
        #4 0x7f6d2f919bdd in g_strdup_vprintf glib/gstrfuncs.c:514
        #5 0x56085cdcf660 in buffer_init util/buffer.c:59
        #6 0x56085ca6a7ec in vnc_async_encoding_start ui/vnc-jobs.c:177
        #7 0x56085ca6b815 in vnc_worker_thread_loop ui/vnc-jobs.c:240

Fixes: 543b95801f98 ("vnc: attach names to buffers")
Cc: Gerd Hoffmann <kraxel@redhat.com>
CC: qemu-stable@nongnu.org
Signed-off-by: Peter Wu <peter@lekensteyn.nl>
---
 ui/vnc-jobs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index b0b15d42a8..929391f85d 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig, VncState *local)
 
 static void vnc_async_encoding_end(VncState *orig, VncState *local)
 {
+    buffer_free(&local->output);
     orig->tight = local->tight;
     orig->zlib = local->zlib;
     orig->hextile = local->hextile;
@@ -278,7 +279,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
         /* Copy persistent encoding data */
         vnc_async_encoding_end(job->vs, &vs);
 
-	qemu_bh_schedule(job->vs->bh);
+        qemu_bh_schedule(job->vs->bh);
     }  else {
         buffer_reset(&vs.output);
         /* Copy persistent encoding data */
-- 
2.18.0
