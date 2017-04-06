Received: from eggs.gnu.org ([2001:4830:134:3::10]:50454)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Aw-00068n-5f
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1cw7Au-0008Oe-VG
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47668)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1cw7Au-0008Mu-MS
	for qemu-devel@nongnu.org; Thu, 06 Apr 2017 09:10:08 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D0613C04B92B
	for <qemu-devel@nongnu.org>; Thu,  6 Apr 2017 13:10:07 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Thu,  6 Apr 2017 15:08:51 +0200
Message-Id: <20170406130913.2232-33-quintela@redhat.com>
In-Reply-To: <20170406130913.2232-1-quintela@redhat.com>
References: <20170406130913.2232-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH 32/54] ram: Move last_req_rb to RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com

It was on MigrationState when it is only used inside ram.c for
postcopy.  Problem is that we need to access it without being able to
pass it RAMState directly.

Signed-off-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
---
 include/migration/migration.h | 2 --
 migration/migration.c         | 1 -
 migration/ram.c               | 7 +++++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 87d0cc5..0f75573 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -189,8 +189,6 @@ struct MigrationState
     /* Queue of outstanding page requests from the destination */
     QemuMutex src_page_req_mutex;
     QSIMPLEQ_HEAD(src_page_requests, MigrationSrcPageRequest) src_page_requests;
-    /* The RAMBlock used in the last src_page_request */
-    RAMBlock *last_req_rb;
     /* The semaphore is used to notify COLO thread that failover is finished */
     QemuSemaphore colo_exit_sem;
 
diff --git a/migration/migration.c b/migration/migration.c
index 5a13ed0..429bab4 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1118,7 +1118,6 @@ MigrationState *migrate_init(const MigrationParams *params)
     s->postcopy_after_devices = false;
     s->postcopy_requests = 0;
     s->migration_thread_running = false;
-    s->last_req_rb = NULL;
     error_free(s->error);
     s->error = NULL;
 
diff --git a/migration/ram.c b/migration/ram.c
index 2f5cbd1..cec51b4 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -204,6 +204,8 @@ struct RAMState {
     QemuMutex bitmap_mutex;
     /* Ram Bitmap protected by RCU */
     RAMBitmap *ram_bitmap;
+    /* The RAMBlock used in the last src_page_requests */
+    RAMBlock *last_req_rb;
 };
 typedef struct RAMState RAMState;
 
@@ -1226,12 +1228,13 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
                          ram_addr_t start, ram_addr_t len)
 {
     RAMBlock *ramblock;
+    RAMState *rs = &ram_state;
 
     ms->postcopy_requests++;
     rcu_read_lock();
     if (!rbname) {
         /* Reuse last RAMBlock */
-        ramblock = ms->last_req_rb;
+        ramblock = rs->last_req_rb;
 
         if (!ramblock) {
             /*
@@ -1249,7 +1252,7 @@ int ram_save_queue_pages(MigrationState *ms, const char *rbname,
             error_report("ram_save_queue_pages no block '%s'", rbname);
             goto err;
         }
-        ms->last_req_rb = ramblock;
+        rs->last_req_rb = ramblock;
     }
     trace_ram_save_queue_pages(ramblock->idstr, start, len);
     if (start+len > ramblock->used_length) {
-- 
2.9.3
