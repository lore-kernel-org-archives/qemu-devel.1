Received: from eggs.gnu.org ([2001:4830:134:3::10]:32859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMCq0-0001Qm-Nu
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fMCpz-0003GF-Vv
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:47200 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fMCpz-0003G5-RA
	for qemu-devel@nongnu.org; Fri, 25 May 2018 09:32:55 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 70E835B5E3
	for <qemu-devel@nongnu.org>; Fri, 25 May 2018 13:32:55 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Fri, 25 May 2018 15:32:46 +0200
Message-Id: <20180525133246.7839-3-quintela@redhat.com>
In-Reply-To: <20180525133246.7839-1-quintela@redhat.com>
References: <20180525133246.7839-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 2/2] migration: use g_free for ram load bitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Peter Xu <peterx@redhat.com>

Buffers allocated with bitmap_new() should be freed with g_free().

Both reported by Coverity:

*** CID 1391300:  API usage errors  (ALLOC_FREE_MISMATCH)
/migration/ram.c: 3517 in ram_dirty_bitmap_reload()
3511          * the last one to sync, we need to notify the main send thread.
3512          */
3513         ram_dirty_bitmap_reload_notify(s);
3514
3515         ret = 0;
3516     out:
>>>     CID 1391300:  API usage errors  (ALLOC_FREE_MISMATCH)
>>>     Calling "free" frees "le_bitmap" using "free" but it should have been freed using "g_free".
3517         free(le_bitmap);
3518         return ret;
3519     }
3520
3521     static int ram_resume_prepare(MigrationState *s, void *opaque)
3522     {

*** CID 1391292:  API usage errors  (ALLOC_FREE_MISMATCH)
/migration/ram.c: 249 in ramblock_recv_bitmap_send()
243          * Mark as an end, in case the middle part is screwed up due to
244          * some "misterious" reason.
245          */
246         qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
247         qemu_fflush(file);
248
>>>     CID 1391292:  API usage errors  (ALLOC_FREE_MISMATCH)
>>>     Calling "free" frees "le_bitmap" using "free" but it should have been freed using "g_free".
249         free(le_bitmap);
250
251         if (qemu_file_get_error(file)) {
252             return qemu_file_get_error(file);
253         }
254

Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Message-Id: <20180525015042.31778-1-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/ram.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5bcbf7a9f9..c53e8369a3 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -246,7 +246,7 @@ int64_t ramblock_recv_bitmap_send(QEMUFile *file,
     qemu_put_be64(file, RAMBLOCK_RECV_BITMAP_ENDING);
     qemu_fflush(file);
 
-    free(le_bitmap);
+    g_free(le_bitmap);
 
     if (qemu_file_get_error(file)) {
         return qemu_file_get_error(file);
@@ -3514,7 +3514,7 @@ int ram_dirty_bitmap_reload(MigrationState *s, RAMBlock *block)
 
     ret = 0;
 out:
-    free(le_bitmap);
+    g_free(le_bitmap);
     return ret;
 }
 
-- 
2.17.0
