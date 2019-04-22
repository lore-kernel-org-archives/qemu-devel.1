Received: from eggs.gnu.org ([209.51.188.92]:57995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIW2Y-0002xf-7x
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:19:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hIW2W-0006Y9-RP
	for qemu-devel@nongnu.org; Mon, 22 Apr 2019 06:19:10 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 22 Apr 2019 13:18:59 +0300
Message-Id: <20190422101900.13897-3-vsementsov@virtuozzo.com>
In-Reply-To: <20190422101900.13897-1-vsementsov@virtuozzo.com>
References: <20190422101900.13897-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v5 2/3] block/stream: refactor stream_run: drop
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
Cc: xiechanglong.d@gmail.com, wencongyang2@huawei.com, fam@euphon.net, stefanha@redhat.com, mreitz@redhat.com, kwolf@redhat.com, jsnow@redhat.com, berto@igalia.com, den@openvz.org, vsementsov@virtuozzo.com, andrey.shinkevich@virtuozzo.com

The goto is unnecessary in the stream_run() since the common exit
code was removed in the commit eb23654dbe43b549ea2a9ebff9d8e:
"jobs: utilize job_exit shim".

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/stream.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/block/stream.c b/block/stream.c
index 0920092ed2..e73a3201c8 100644
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
2.18.0
