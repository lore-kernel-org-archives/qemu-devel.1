Received: from eggs.gnu.org ([2001:4830:134:3::10]:47628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCF-0000yq-L7
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:16:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1dmUCC-0005DU-M7
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51083)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1dmUCC-0005Ca-BQ
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 20:15:56 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7T0Eesg078680
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:55 -0400
Received: from e15.ny.us.ibm.com (e15.ny.us.ibm.com [129.33.205.205])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2cmnx0yuma-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 28 Aug 2017 20:15:55 -0400
Received: from localhost
	by e15.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 28 Aug 2017 20:15:53 -0400
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon, 28 Aug 2017 19:13:57 -0500
In-Reply-To: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1503965694-10794-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1503965694-10794-23-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PATCH 22/79] qemu-img: wait for convert coroutines to
 complete
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

On error path (like i/o error in one of the coroutines), it's required to
  - wait for coroutines completion before cleaning the common structures
  - reenter dependent coroutines so they ever finish

Introduced in 2d9187bc65.

Cc: qemu-stable@nongnu.org
Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Peter Lieven <pl@kamp.de>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
(cherry picked from commit b91127edd0ff96f27f1e58e47f4e9f9d6a0fed02)
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qemu-img.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index 2e61561..26ded22 100644
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
