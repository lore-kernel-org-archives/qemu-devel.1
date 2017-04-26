Received: from eggs.gnu.org ([2001:4830:134:3::10]:55820)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d3Idu-0007Gi-R8
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:49:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1d3Idq-0008EB-T7
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 04:49:46 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 26 Apr 2017 11:33:15 +0300
Message-ID: <1493195595-4809-1-git-send-email-anton.nefedov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH v3 1/1] qemu-img: wait for convert coroutines
 to complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@virtuozzo.com, qemu-block@nongnu.org, qemu-stable@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, pl@kamp.de, Anton Nefedov <anton.nefedov@virtuozzo.com>

On error path (like i/o error in one of the coroutines), it's required to
  - wait for coroutines completion before cleaning the common structures
  - reenter dependent coroutines so they ever finish

Introduced in 2d9187bc65.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 qemu-img.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index bbe1574..8c50379 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1761,13 +1761,13 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
         qemu_co_mutex_lock(&s->lock);
         if (s->ret != -EINPROGRESS || s->sector_num >= s->total_sectors) {
             qemu_co_mutex_unlock(&s->lock);
-            goto out;
+            break;
         }
         n = convert_iteration_sectors(s, s->sector_num);
         if (n < 0) {
             qemu_co_mutex_unlock(&s->lock);
             s->ret = n;
-            goto out;
+            break;
         }
         /* save current sector and allocation status to local variables */
         sector_num = s->sector_num;
@@ -1792,7 +1792,6 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
                 error_report("error while reading sector %" PRId64
                              ": %s", sector_num, strerror(-ret));
                 s->ret = ret;
-                goto out;
             }
         } else if (!s->min_sparse && status == BLK_ZERO) {
             status = BLK_DATA;
@@ -1801,22 +1800,20 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
 
         if (s->wr_in_order) {
             /* keep writes in order */
-            while (s->wr_offs != sector_num) {
-                if (s->ret != -EINPROGRESS) {
-                    goto out;
-                }
+            while (s->wr_offs != sector_num && s->ret == -EINPROGRESS) {
                 s->wait_sector_num[index] = sector_num;
                 qemu_coroutine_yield();
             }
             s->wait_sector_num[index] = -1;
         }
 
-        ret = convert_co_write(s, sector_num, n, buf, status);
-        if (ret < 0) {
-            error_report("error while writing sector %" PRId64
-                         ": %s", sector_num, strerror(-ret));
-            s->ret = ret;
-            goto out;
+        if (s->ret == -EINPROGRESS) {
+            ret = convert_co_write(s, sector_num, n, buf, status);
+            if (ret < 0) {
+                error_report("error while writing sector %" PRId64
+                             ": %s", sector_num, strerror(-ret));
+                s->ret = ret;
+            }
         }
 
         if (s->wr_in_order) {
@@ -1837,7 +1834,6 @@ static void coroutine_fn convert_co_do_copy(void *opaque)
         }
     }
 
-out:
     qemu_vfree(buf);
     s->co[index] = NULL;
     s->running_coroutines--;
@@ -1899,7 +1895,7 @@ static int convert_do_copy(ImgConvertState *s)
         qemu_coroutine_enter(s->co[i]);
     }
 
-    while (s->ret == -EINPROGRESS) {
+    while (s->running_coroutines) {
         main_loop_wait(false);
     }
 
-- 
2.7.4
