Received: from eggs.gnu.org ([2001:4830:134:3::10]:58747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDP-0004ty-Hi
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:25:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fGNDM-0001aJ-TU
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:60852 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fGNDM-0001Z4-O3
	for qemu-devel@nongnu.org; Wed, 09 May 2018 07:24:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 627B7406C755
	for <qemu-devel@nongnu.org>; Wed,  9 May 2018 11:24:56 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  9 May 2018 13:23:52 +0200
Message-Id: <20180509112406.6183-28-quintela@redhat.com>
In-Reply-To: <20180509112406.6183-1-quintela@redhat.com>
References: <20180509112406.6183-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 27/41] migration: new message
 MIG_RP_MSG_RESUME_ACK
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

Creating new message to reply for MIG_CMD_POSTCOPY_RESUME. One uint32_t
is used as payload to let the source know whether destination is ready
to continue the migration.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180502104740.12123-15-peterx@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/migration.c  | 37 +++++++++++++++++++++++++++++++++++++
 migration/migration.h  |  3 +++
 migration/savevm.c     |  3 ++-
 migration/trace-events |  1 +
 4 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/migration/migration.c b/migration/migration.c
index 7c5e20b3f6..4f2c6d22d1 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -96,6 +96,7 @@ enum mig_rp_message_type {
     MIG_RP_MSG_REQ_PAGES_ID, /* data (start: be64, len: be32, id: string) */
     MIG_RP_MSG_REQ_PAGES,    /* data (start: be64, len: be32) */
     MIG_RP_MSG_RECV_BITMAP,  /* send recved_bitmap back to source */
+    MIG_RP_MSG_RESUME_ACK,   /* tell source that we are ready to resume */
 
     MIG_RP_MSG_MAX
 };
@@ -564,6 +565,14 @@ void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
     trace_migrate_send_rp_recv_bitmap(block_name, res);
 }
 
+void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value)
+{
+    uint32_t buf;
+
+    buf = cpu_to_be32(value);
+    migrate_send_rp_message(mis, MIG_RP_MSG_RESUME_ACK, sizeof(buf), &buf);
+}
+
 MigrationCapabilityStatusList *qmp_query_migrate_capabilities(Error **errp)
 {
     MigrationCapabilityStatusList *head = NULL;
@@ -1843,6 +1852,7 @@ static struct rp_cmd_args {
     [MIG_RP_MSG_REQ_PAGES]      = { .len = 12, .name = "REQ_PAGES" },
     [MIG_RP_MSG_REQ_PAGES_ID]   = { .len = -1, .name = "REQ_PAGES_ID" },
     [MIG_RP_MSG_RECV_BITMAP]    = { .len = -1, .name = "RECV_BITMAP" },
+    [MIG_RP_MSG_RESUME_ACK]     = { .len =  4, .name = "RESUME_ACK" },
     [MIG_RP_MSG_MAX]            = { .len = -1, .name = "MAX" },
 };
 
@@ -1900,6 +1910,25 @@ static int migrate_handle_rp_recv_bitmap(MigrationState *s, char *block_name)
     return ram_dirty_bitmap_reload(s, block);
 }
 
+static int migrate_handle_rp_resume_ack(MigrationState *s, uint32_t value)
+{
+    trace_source_return_path_thread_resume_ack(value);
+
+    if (value != MIGRATION_RESUME_ACK_VALUE) {
+        error_report("%s: illegal resume_ack value %"PRIu32,
+                     __func__, value);
+        return -1;
+    }
+
+    /* Now both sides are active. */
+    migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_RECOVER,
+                      MIGRATION_STATUS_POSTCOPY_ACTIVE);
+
+    /* TODO: notify send thread that time to continue send pages */
+
+    return 0;
+}
+
 /*
  * Handles messages sent on the return path towards the source VM
  *
@@ -2019,6 +2048,14 @@ retry:
             }
             break;
 
+        case MIG_RP_MSG_RESUME_ACK:
+            tmp32 = ldl_be_p(buf);
+            if (migrate_handle_rp_resume_ack(ms, tmp32)) {
+                mark_source_rp_bad(ms);
+                goto out;
+            }
+            break;
+
         default:
             break;
         }
diff --git a/migration/migration.h b/migration/migration.h
index 2321ea37b3..556964d9d9 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -24,6 +24,8 @@
 
 struct PostcopyBlocktimeContext;
 
+#define  MIGRATION_RESUME_ACK_VALUE  (1)
+
 /* State for the incoming migration */
 struct MigrationIncomingState {
     QEMUFile *from_src_file;
@@ -262,6 +264,7 @@ int migrate_send_rp_req_pages(MigrationIncomingState *mis, const char* rbname,
                               ram_addr_t start, size_t len);
 void migrate_send_rp_recv_bitmap(MigrationIncomingState *mis,
                                  char *block_name);
+void migrate_send_rp_resume_ack(MigrationIncomingState *mis, uint32_t value);
 
 void dirty_bitmap_mig_before_vm_start(void);
 void init_dirty_bitmap_incoming_migration(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index a7e793eef7..6a2d77cbf3 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1795,7 +1795,8 @@ static int loadvm_postcopy_handle_resume(MigrationIncomingState *mis)
 
     trace_loadvm_postcopy_handle_resume();
 
-    /* TODO: Tell source that "we are ready" */
+    /* Tell source that "we are ready" */
+    migrate_send_rp_resume_ack(mis, MIGRATION_RESUME_ACK_VALUE);
 
     return 0;
 }
diff --git a/migration/trace-events b/migration/trace-events
index 29cc10f299..40a7217829 100644
--- a/migration/trace-events
+++ b/migration/trace-events
@@ -120,6 +120,7 @@ source_return_path_thread_entry(void) ""
 source_return_path_thread_loop_top(void) ""
 source_return_path_thread_pong(uint32_t val) "0x%x"
 source_return_path_thread_shut(uint32_t val) "0x%x"
+source_return_path_thread_resume_ack(uint32_t v) "%"PRIu32
 migrate_global_state_post_load(const char *state) "loaded state: %s"
 migrate_global_state_pre_save(const char *state) "saved state: %s"
 migration_thread_low_pending(uint64_t pending) "%" PRIu64
-- 
2.17.0
