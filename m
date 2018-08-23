Received: from eggs.gnu.org ([2001:4830:134:3::10]:39855)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmMQ-00020L-DP
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1fsmMP-0006z3-8N
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 05:57:02 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 23 Aug 2018 11:56:43 +0200
Message-Id: <20180823095653.14556-3-kraxel@redhat.com>
In-Reply-To: <20180823095653.14556-1-kraxel@redhat.com>
References: <20180823095653.14556-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/12] vnc: fix memleak of the
 "vnc-worker-output" name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: libvir-list@redhat.com, Gerd Hoffmann <kraxel@redhat.com>, Peter Wu <peter@lekensteyn.nl>, qemu-stable@nongnu.org

From: Peter Wu <peter@lekensteyn.nl>

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
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-id: 20180807221830.3844-1-peter@lekensteyn.nl
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 ui/vnc-jobs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
index b0b15d42a8..929391f85d 100644
--- a/ui/vnc-jobs.c
+++ b/ui/vnc-jobs.c
@@ -193,6 +193,7 @@ static void vnc_async_encoding_start(VncState *orig, =
VncState *local)
=20
 static void vnc_async_encoding_end(VncState *orig, VncState *local)
 {
+    buffer_free(&local->output);
     orig->tight =3D local->tight;
     orig->zlib =3D local->zlib;
     orig->hextile =3D local->hextile;
@@ -278,7 +279,7 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
         /* Copy persistent encoding data */
         vnc_async_encoding_end(job->vs, &vs);
=20
-	qemu_bh_schedule(job->vs->bh);
+        qemu_bh_schedule(job->vs->bh);
     }  else {
         buffer_reset(&vs.output);
         /* Copy persistent encoding data */
--=20
2.9.3
