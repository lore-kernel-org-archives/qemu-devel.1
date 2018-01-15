Received: from eggs.gnu.org ([2001:4830:134:3::10]:49896)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Kz-0007cS-HB
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eb3Kx-0003cY-CJ
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:54:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57732)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eb3Kx-0003cK-6U
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 06:53:59 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 504BEC057FA7
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 11:53:58 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Mon, 15 Jan 2018 12:52:58 +0100
Message-Id: <20180115115309.23982-17-quintela@redhat.com>
In-Reply-To: <20180115115309.23982-1-quintela@redhat.com>
References: <20180115115309.23982-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 16/27] migration: qemu_savevm_state_cleanup() in
 cleanup
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

Moving existing callers all into migrate_fd_cleanup().  It simplifies
migration_thread() a bit.

Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index f579752d21..02d8bc07b1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1107,6 +1107,8 @@ static void migrate_fd_cleanup(void *opaque)
     qemu_bh_delete(s->cleanup_bh);
     s->cleanup_bh = NULL;
 
+    qemu_savevm_state_cleanup();
+
     if (s->to_dst_file) {
         Error *local_err = NULL;
 
@@ -2329,13 +2331,6 @@ static void *migration_thread(void *opaque)
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
@@ -2358,7 +2353,6 @@ static void *migration_thread(void *opaque)
                              "COLO enabled", __func__);
             }
             migrate_start_colo_process(s);
-            qemu_savevm_state_cleanup();
             /*
             * Fixme: we will run VM in COLO no matter its old running state.
             * After exited COLO, we will keep running.
-- 
2.14.3
