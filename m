Received: from eggs.gnu.org ([2001:4830:134:3::10]:50201)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLZ-0002n6-4c
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1cdDLW-0004L2-92
	for qemu-devel@nongnu.org; Mon, 13 Feb 2017 04:55:01 -0500
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 13 Feb 2017 12:54:35 +0300
Message-Id: <1486979689-230770-4-git-send-email-vsementsov@virtuozzo.com>
In-Reply-To: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
References: <1486979689-230770-1-git-send-email-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH 03/17] migration: split common postcopy out of
 ram postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, armbru@redhat.com, eblake@redhat.com, famz@redhat.com, stefanha@redhat.com, amit.shah@redhat.com, quintela@redhat.com, mreitz@redhat.com, kwolf@redhat.com, peter.maydell@linaro.org, dgilbert@redhat.com, den@openvz.org, jsnow@redhat.com, vsementsov@virtuozzo.com, lirans@il.ibm.com

Split common postcopy staff from ram postcopy staff.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/migration.h |  1 +
 migration/migration.c         | 39 ++++++++++++++++++++++++-----------
 migration/postcopy-ram.c      |  4 +++-
 migration/savevm.c            | 48 +++++++++++++++++++++++++++++++++++--------
 4 files changed, 70 insertions(+), 22 deletions(-)

diff --git a/include/migration/migration.h b/include/migration/migration.h
index 7528cc2..35f7460 100644
--- a/include/migration/migration.h
+++ b/include/migration/migration.h
@@ -304,6 +304,7 @@ int migrate_add_blocker(Error *reason, Error **errp);
  */
 void migrate_del_blocker(Error *reason);
 
+bool migrate_postcopy(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 
diff --git a/migration/migration.c b/migration/migration.c
index 2b179c6..ae8dbfb 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1306,6 +1306,11 @@ bool migrate_postcopy_ram(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_POSTCOPY_RAM];
 }
 
+bool migrate_postcopy(void)
+{
+    return migrate_postcopy_ram();
+}
+
 bool migrate_auto_converge(void)
 {
     MigrationState *s;
@@ -1635,9 +1640,11 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
      * need to tell the destination to throw any pages it's already received
      * that are dirty
      */
-    if (ram_postcopy_send_discard_bitmap(ms)) {
-        error_report("postcopy send discard bitmap failed");
-        goto fail;
+    if (migrate_postcopy_ram()) {
+        if (ram_postcopy_send_discard_bitmap(ms)) {
+            error_report("postcopy send discard bitmap failed");
+            goto fail;
+        }
     }
 
     /*
@@ -1646,8 +1653,10 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
      * wrap their state up here
      */
     qemu_file_set_rate_limit(ms->to_dst_file, INT64_MAX);
-    /* Ping just for debugging, helps line traces up */
-    qemu_savevm_send_ping(ms->to_dst_file, 2);
+    if (migrate_postcopy_ram()) {
+        /* Ping just for debugging, helps line traces up */
+        qemu_savevm_send_ping(ms->to_dst_file, 2);
+    }
 
     /*
      * While loading the device state we may trigger page transfer
@@ -1672,7 +1681,9 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     qemu_savevm_send_postcopy_listen(fb);
 
     qemu_savevm_state_complete_precopy(fb, false);
-    qemu_savevm_send_ping(fb, 3);
+    if (migrate_postcopy_ram()) {
+        qemu_savevm_send_ping(fb, 3);
+    }
 
     qemu_savevm_send_postcopy_run(fb);
 
@@ -1707,11 +1718,13 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
 
     qemu_mutex_unlock_iothread();
 
-    /*
-     * Although this ping is just for debug, it could potentially be
-     * used for getting a better measurement of downtime at the source.
-     */
-    qemu_savevm_send_ping(ms->to_dst_file, 4);
+    if (migrate_postcopy_ram()) {
+        /*
+         * Although this ping is just for debug, it could potentially be
+         * used for getting a better measurement of downtime at the source.
+         */
+        qemu_savevm_send_ping(ms->to_dst_file, 4);
+    }
 
     ret = qemu_file_get_error(ms->to_dst_file);
     if (ret) {
@@ -1878,7 +1891,9 @@ static void *migration_thread(void *opaque)
 
         /* And do a ping that will make stuff easier to debug */
         qemu_savevm_send_ping(s->to_dst_file, 1);
+    }
 
+    if (migrate_postcopy()) {
         /*
          * Tell the destination that we *might* want to do postcopy later;
          * if the other end can't do postcopy it should fail now, nice and
@@ -1912,7 +1927,7 @@ static void *migration_thread(void *opaque)
             if (pending_size && pending_size >= max_size) {
                 /* Still a significant amount to transfer */
 
-                if (migrate_postcopy_ram() &&
+                if (migrate_postcopy() &&
                     s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
                     pend_nonpost <= max_size &&
                     atomic_read(&s->start_postcopy)) {
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index a40dddb..aef5690 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -339,7 +339,9 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingState *mis)
     }
 
     postcopy_state_set(POSTCOPY_INCOMING_END);
-    migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
+    if (migrate_postcopy_ram()) {
+        migrate_send_rp_shut(mis, qemu_file_get_error(mis->from_src_file) != 0);
+    }
 
     if (mis->postcopy_tmp_page) {
         munmap(mis->postcopy_tmp_page, getpagesize());
diff --git a/migration/savevm.c b/migration/savevm.c
index 8ebb27a..8fab701 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -73,7 +73,7 @@ static struct mig_cmd_args {
     [MIG_CMD_INVALID]          = { .len = -1, .name = "INVALID" },
     [MIG_CMD_OPEN_RETURN_PATH] = { .len =  0, .name = "OPEN_RETURN_PATH" },
     [MIG_CMD_PING]             = { .len = sizeof(uint32_t), .name = "PING" },
-    [MIG_CMD_POSTCOPY_ADVISE]  = { .len = 16, .name = "POSTCOPY_ADVISE" },
+    [MIG_CMD_POSTCOPY_ADVISE]  = { .len = -1, .name = "POSTCOPY_ADVISE" },
     [MIG_CMD_POSTCOPY_LISTEN]  = { .len =  0, .name = "POSTCOPY_LISTEN" },
     [MIG_CMD_POSTCOPY_RUN]     = { .len =  0, .name = "POSTCOPY_RUN" },
     [MIG_CMD_POSTCOPY_RAM_DISCARD] = {
@@ -82,6 +82,23 @@ static struct mig_cmd_args {
     [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
 };
 
+/* Note for MIG_CMD_POSTCOPY_ADVISE:
+ * The format of arguments is depending on postcopy mode:
+ * - postcopy RAM only
+ *   uint64_t host page size
+ *   uint64_t taget page size
+ *
+ * - postcopy RAM and postcopy dirty bitmaps
+ *   format is the same as for postcopy RAM only
+ *
+ * - postcopy dirty bitmaps only
+ *   Nothing. Command length field is 0.
+ *
+ * Be careful: adding a new postcopy entity with some other parameters should
+ * not break format self-description ability. Good way is to introduce some
+ * generic extendable format with an exception for two old entities.
+ */
+
 static int announce_self_create(uint8_t *buf,
                                 uint8_t *mac_addr)
 {
@@ -868,12 +885,17 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 /* Send prior to any postcopy transfer */
 void qemu_savevm_send_postcopy_advise(QEMUFile *f)
 {
-    uint64_t tmp[2];
-    tmp[0] = cpu_to_be64(getpagesize());
-    tmp[1] = cpu_to_be64(1ul << qemu_target_page_bits());
+    if (migrate_postcopy_ram()) {
+        uint64_t tmp[2];
+        tmp[0] = cpu_to_be64(getpagesize());
+        tmp[1] = cpu_to_be64(1ul << qemu_target_page_bits());
 
-    trace_qemu_savevm_send_postcopy_advise();
-    qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE, 16, (uint8_t *)tmp);
+        trace_qemu_savevm_send_postcopy_advise();
+        qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE,
+                                 16, (uint8_t *)tmp);
+    } else {
+        qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_ADVISE, 0, NULL);
+    }
 }
 
 /* Sent prior to starting the destination running in postcopy, discard pages
@@ -1356,6 +1378,10 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (!migrate_postcopy_ram()) {
+        return 0;
+    }
+
     if (!postcopy_ram_supported_by_host()) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
@@ -1557,7 +1583,9 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
          * A rare case, we entered listen without having to do any discards,
          * so do the setup that's normally done at the time of the 1st discard.
          */
-        postcopy_ram_prepare_discard(mis);
+        if (migrate_postcopy_ram()) {
+            postcopy_ram_prepare_discard(mis);
+        }
     }
 
     /*
@@ -1565,8 +1593,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
      * However, at this point the CPU shouldn't be running, and the IO
      * shouldn't be doing anything yet so don't actually expect requests
      */
-    if (postcopy_ram_enable_notify(mis)) {
-        return -1;
+    if (migrate_postcopy_ram()) {
+        if (postcopy_ram_enable_notify(mis)) {
+            return -1;
+        }
     }
 
     if (mis->have_listen_thread) {
-- 
1.8.3.1
