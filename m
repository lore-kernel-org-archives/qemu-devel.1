Received: from eggs.gnu.org ([2001:4830:134:3::10]:56620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi21-0006bD-8u
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eWi20-0001xH-GL
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40348)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eWi20-0001wG-Ab
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 07:20:28 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 878B1C0587DF
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 12:20:27 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  3 Jan 2018 20:20:06 +0800
Message-Id: <20180103122017.14794-3-peterx@redhat.com>
In-Reply-To: <20180103122017.14794-1-peterx@redhat.com>
References: <20180103122017.14794-1-peterx@redhat.com>
Subject: [Qemu-devel] [PATCH v2 02/13] migration:
 qemu_savevm_state_cleanup() in cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com

Moving existing callers all into migrate_fd_cleanup().  It simplifies
migration_thread() a bit.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/migration.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 5a12738447..2c2140006c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1077,6 +1077,8 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_bh_delete(s->cleanup_bh);
     s->cleanup_bh = NULL;
 
+    qemu_savevm_state_cleanup();
+
     if (s->to_dst_file) {
         Error *local_err = NULL;
 
@@ -2290,13 +2292,6 @@ static void *migration_thread(void *opaque)
     end_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
 
     qemu_mutex_lock_iothread();
-    /*
-     * The resource has been allocated by migration will be reused in COLO
-     * process, so don't release them.
-     */
-    if (!enable_colo) {
-        qemu_savevm_state_cleanup();
-    }
     if (s->state == MIGRATION_STATUS_COMPLETED) {
         uint64_t transferred_bytes = qemu_ftell(s->to_dst_file);
         s->total_time = end_time - s->total_time;
@@ -2319,7 +2314,6 @@ static void *migration_thread(void *opaque)
                              "COLO enabled", __func__);
             }
             migrate_start_colo_process(s);
-            qemu_savevm_state_cleanup();
             /*
             * Fixme: we will run VM in COLO no matter its old running state.
             * After exited COLO, we will keep running.
-- 
2.14.3
