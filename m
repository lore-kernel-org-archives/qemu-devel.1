Received: from eggs.gnu.org ([209.51.188.92]:48083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhd-0007Oo-2i
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrey.shinkevich@virtuozzo.com>) id 1hAvhc-0006j1-4c
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 08:06:13 -0400
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Date: Mon,  1 Apr 2019 15:06:04 +0300
Message-Id: <1554120365-39119-3-git-send-email-andrey.shinkevich@virtuozzo.com>
In-Reply-To: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1554120365-39119-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v2 2/3] block/stream: refactor stream_run: drop
 goto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com, berto@igalia.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 6253c86..c065e99 100644
--- a/block/stream.c
+++ b/block/stream.c
@@ -122,13 +122,12 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
     void *buf;
 
     if (!bs->backing) {
-        goto out;
+        return 0;
     }
 
     len = bdrv_getlength(bs);
     if (len < 0) {
-        ret = len;
-        goto out;
+        return len;
     }
     job_progress_set_remaining(&s->common.job, len);
 
@@ -205,14 +204,10 @@ static int coroutine_fn stream_run(Job *job, Error **errp)
         bdrv_disable_copy_on_read(bs);
     }
 
-    /* Do not remove the backing file if an error was there but ignored.  */
-    ret = error;
-
     qemu_vfree(buf);
 
-out:
-    /* Modify backing chain and close BDSes in main loop */
-    return ret;
+    /* Do not remove the backing file if an error was there but ignored. */
+    return error;
 }
 
 static const BlockJobDriver stream_job_driver = {
-- 
1.8.3.1
