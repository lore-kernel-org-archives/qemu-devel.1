Received: from eggs.gnu.org ([2001:4830:134:3::10]:47115)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba6-0000fM-2Q
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dUba2-0001Ne-Sf
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 12:30:41 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 10 Jul 2017 19:30:16 +0300
Message-Id: <20170710163029.129912-4-vsementsov@virtuozzo.com>
In-Reply-To: <20170710163029.129912-1-vsementsov@virtuozzo.com>
References: <20170710163029.129912-1-vsementsov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v7 03/16] migration: split common postcopy out
 of ram postcopy
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
---
 migration/migration.c | 39 ++++++++++++++++++++++++++-------------
 migration/migration.h |  2 ++
 migration/savevm.c    | 48 +++++++++++++++++++++++++++++++++++++++---------
 3 files changed, 67 insertions(+), 22 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 51ccd1a4c5..d3a2fd405a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1221,6 +1221,11 @@ bool migrate_postcopy_ram(void)
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
@@ -1577,9 +1582,11 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
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
@@ -1588,8 +1595,10 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
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
@@ -1614,7 +1623,9 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
     qemu_savevm_send_postcopy_listen(fb);
 
     qemu_savevm_state_complete_precopy(fb, false, false);
-    qemu_savevm_send_ping(fb, 3);
+    if (migrate_postcopy_ram()) {
+        qemu_savevm_send_ping(fb, 3);
+    }
 
     qemu_savevm_send_postcopy_run(fb);
 
@@ -1649,11 +1660,13 @@ static int postcopy_start(MigrationState *ms, bool *old_vm_running)
 
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
 
     if (migrate_release_ram()) {
         ram_postcopy_migrated_memory_release(ms);
@@ -1831,7 +1844,7 @@ static void *migration_thread(void *opaque)
         qemu_savevm_send_ping(s->to_dst_file, 1);
     }
 
-    if (migrate_postcopy_ram()) {
+    if (migrate_postcopy()) {
         /*
          * Tell the destination that we *might* want to do postcopy later;
          * if the other end can't do postcopy it should fail now, nice and
@@ -1864,7 +1877,7 @@ static void *migration_thread(void *opaque)
             if (pending_size && pending_size >= threshold_size) {
                 /* Still a significant amount to transfer */
 
-                if (migrate_postcopy_ram() &&
+                if (migrate_postcopy() &&
                     s->state != MIGRATION_STATUS_POSTCOPY_ACTIVE &&
                     pend_nonpost <= threshold_size &&
                     atomic_read(&s->start_postcopy)) {
diff --git a/migration/migration.h b/migration/migration.h
index 148c9facbc..1d974bacce 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -165,6 +165,8 @@ bool migration_is_blocked(Error **errp);
 bool migration_in_postcopy(void);
 MigrationState *migrate_get_current(void);
 
+bool migrate_postcopy(void);
+
 bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
diff --git a/migration/savevm.c b/migration/savevm.c
index 37da83509f..cf79e1d3ac 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -89,7 +89,7 @@ static struct mig_cmd_args {
     [MIG_CMD_INVALID]          = { .len = -1, .name = "INVALID" },
     [MIG_CMD_OPEN_RETURN_PATH] = { .len =  0, .name = "OPEN_RETURN_PATH" },
     [MIG_CMD_PING]             = { .len = sizeof(uint32_t), .name = "PING" },
-    [MIG_CMD_POSTCOPY_ADVISE]  = { .len = 16, .name = "POSTCOPY_ADVISE" },
+    [MIG_CMD_POSTCOPY_ADVISE]  = { .len = -1, .name = "POSTCOPY_ADVISE" },
     [MIG_CMD_POSTCOPY_LISTEN]  = { .len =  0, .name = "POSTCOPY_LISTEN" },
     [MIG_CMD_POSTCOPY_RUN]     = { .len =  0, .name = "POSTCOPY_RUN" },
     [MIG_CMD_POSTCOPY_RAM_DISCARD] = {
@@ -98,6 +98,23 @@ static struct mig_cmd_args {
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
@@ -861,12 +878,17 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
 /* Send prior to any postcopy transfer */
 void qemu_savevm_send_postcopy_advise(QEMUFile *f)
 {
-    uint64_t tmp[2];
-    tmp[0] = cpu_to_be64(ram_pagesize_summary());
-    tmp[1] = cpu_to_be64(qemu_target_page_size());
+    if (migrate_postcopy_ram()) {
+        uint64_t tmp[2];
+        tmp[0] = cpu_to_be64(ram_pagesize_summary());
+        tmp[1] = cpu_to_be64(qemu_target_page_size());
 
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
@@ -1352,6 +1374,10 @@ static int loadvm_postcopy_handle_advise(MigrationIncomingState *mis)
         return -1;
     }
 
+    if (!migrate_postcopy_ram()) {
+        return 0;
+    }
+
     if (!postcopy_ram_supported_by_host()) {
         postcopy_state_set(POSTCOPY_INCOMING_NONE);
         return -1;
@@ -1562,7 +1588,9 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
          * A rare case, we entered listen without having to do any discards,
          * so do the setup that's normally done at the time of the 1st discard.
          */
-        postcopy_ram_prepare_discard(mis);
+        if (migrate_postcopy_ram()) {
+            postcopy_ram_prepare_discard(mis);
+        }
     }
 
     /*
@@ -1570,8 +1598,10 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
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
2.11.1
