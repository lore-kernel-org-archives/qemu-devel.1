Received: from eggs.gnu.org ([2001:4830:134:3::10]:53424)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNR-0007Ii-FK
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1fYoNO-0006nt-Bv
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:33 -0400
Received: from relay.sw.ru ([185.231.240.75]:58262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1fYoNO-0006kk-06
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:03:30 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Fri, 29 Jun 2018 11:03:20 +0300
Message-Id: <20180629080320.320144-8-dplotnikov@virtuozzo.com>
In-Reply-To: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
References: <20180629080320.320144-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v0 7/7] migration: add background snapshotting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: dgilbert@redhat.com, quintela@redhat.com, pbonzini@redhat.com
Cc: qemu-devel@nongnu.org

The patch enables to save vmstate to a migration thread
in the background: ram is being saved while vCPUs are running.
This is done to reduce downtime on vm snapshotting: the majority
of vmstate is ram, the rest of devices consumes only a few MB of
memory on a typical vm.
By this moment, there were no means to make a snapshot without
full vm stopping. From now, one can save a vm state having the vm
stopped only for a couple of seconds to save devices' states. Then
the vm resumed and ram is written without the vm full stopping.

To use async vm state it's needed to enable "background-snapshot"
migration capability and start the migration.

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/migration.c | 104 +++++++++++++++++++++++++++++++++++++++++-
 migration/savevm.c    |  91 +++++++++++++++++++-----------------
 migration/savevm.h    |   2 +
 3 files changed, 154 insertions(+), 43 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 131d0904e4..b062bd8ddc 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2188,6 +2188,100 @@ bool migrate_colo_enabled(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_COLO];
 }
 
+static void background_snapshot_sigsegv_handler(int unused0, siginfo_t *info, void *unused1)
+{
+    if (ram_process_page_fault(info->si_addr)) {
+        assert(false);
+    }
+}
+
+static void *background_snapshot_thread(void *opaque)
+{
+    MigrationState *m = opaque;
+    QIOChannelBuffer *bioc;
+    QEMUFile *fb;
+    RamBlockList *ram_blocks;
+    int res = 0;
+
+    rcu_register_thread();
+
+    qemu_file_set_rate_limit(m->to_dst_file, INT64_MAX);
+
+    qemu_mutex_lock_iothread();
+    vm_stop(RUN_STATE_PAUSED);
+
+    qemu_savevm_state_header(m->to_dst_file);
+    qemu_mutex_unlock_iothread();
+    qemu_savevm_state_setup(m->to_dst_file);
+    qemu_mutex_lock_iothread();
+
+    migrate_set_state(&m->state, MIGRATION_STATUS_SETUP,
+                      MIGRATION_STATUS_ACTIVE);
+
+    // save the device state to the temporary buffer
+    bioc = qio_channel_buffer_new(4096);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vmstate-buffer");
+    fb = qemu_fopen_channel_output(QIO_CHANNEL(bioc));
+    object_unref(OBJECT(bioc));
+
+    ram_blocks = ram_blocks_get();
+    ram_blocks_fill(ram_blocks);
+    ram_blocks_set_ro(ram_blocks);
+
+    if(global_state_store()) {
+        goto exit;
+    }
+
+    if (qemu_save_all_device_states(fb, false, true) < 0) {
+        migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto exit;
+    }
+
+    sigsegv_user_handler_set(background_snapshot_sigsegv_handler);
+
+    smp_mb();
+    vm_start();
+    qemu_mutex_unlock_iothread();
+
+    while (!res) {
+        res = qemu_savevm_state_iterate(m->to_dst_file, false);
+
+        if (res < 0 || qemu_file_get_error(m->to_dst_file)) {
+            migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
+                              MIGRATION_STATUS_FAILED);
+            goto exit;
+        }
+    }
+
+    // By this moment we have RAM saved into the stream
+    // The next step is to flush the device state right after the
+    // RAM saved. The rest of device state is stored in
+    // the temporary buffer. Let's flush the buffer into the stream.
+    qemu_put_buffer(m->to_dst_file, bioc->data, bioc->usage);
+    qemu_fflush(m->to_dst_file);
+
+    if (qemu_file_get_error(m->to_dst_file)) {
+        migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto exit;
+    }
+
+    migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
+                                 MIGRATION_STATUS_COMPLETED);
+exit:
+    ram_blocks_set_rw(ram_blocks);
+    ram_blocks_clear(ram_blocks);
+    smp_mb();
+    sigsegv_user_handler_reset();
+    qemu_fclose(fb);
+    qemu_mutex_lock_iothread();
+    qemu_savevm_state_cleanup();
+    qemu_mutex_unlock_iothread();
+    rcu_unregister_thread();
+    return NULL;
+}
+
 /*
  * Master migration thread on the source VM.
  * It drives the migration and pumps the data down the outgoing channel.
@@ -2402,8 +2496,14 @@ void migrate_fd_connect(MigrationState *s)
         migrate_fd_cleanup(s);
         return;
     }
-    qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
-                       QEMU_THREAD_JOINABLE);
+    if (migrate_background_snapshot()) {
+        qemu_thread_create(&s->thread, "bg_snapshot",
+                           background_snapshot_thread, s,
+                           QEMU_THREAD_JOINABLE);
+    } else {
+        qemu_thread_create(&s->thread, "live_migration", migration_thread, s,
+                           QEMU_THREAD_JOINABLE);
+    }
     s->migration_thread_running = true;
 }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index f202c3de3a..641b897ff5 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1107,51 +1107,15 @@ void qemu_savevm_state_complete_postcopy(QEMUFile *f)
     qemu_fflush(f);
 }
 
-int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
-                                       bool inactivate_disks)
+int qemu_save_all_device_states(QEMUFile *f, bool inactivate_disks,
+                                bool send_eof)
 {
-    QJSON *vmdesc;
     int vmdesc_len;
     SaveStateEntry *se;
     int ret;
-    bool in_postcopy = migration_in_postcopy();
-
-    trace_savevm_state_complete_precopy();
+    QJSON *vmdesc = qjson_new();
 
     cpu_synchronize_all_states();
-
-    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
-        if (!se->ops ||
-            (in_postcopy && se->ops->has_postcopy &&
-             se->ops->has_postcopy(se->opaque)) ||
-            (in_postcopy && !iterable_only) ||
-            !se->ops->save_live_complete_precopy) {
-            continue;
-        }
-
-        if (se->ops && se->ops->is_active) {
-            if (!se->ops->is_active(se->opaque)) {
-                continue;
-            }
-        }
-        trace_savevm_section_start(se->idstr, se->section_id);
-
-        save_section_header(f, se, QEMU_VM_SECTION_END);
-
-        ret = se->ops->save_live_complete_precopy(f, se->opaque);
-        trace_savevm_section_end(se->idstr, se->section_id, ret);
-        save_section_footer(f, se);
-        if (ret < 0) {
-            qemu_file_set_error(f, ret);
-            return -1;
-        }
-    }
-
-    if (iterable_only) {
-        return 0;
-    }
-
-    vmdesc = qjson_new();
     json_prop_int(vmdesc, "page_size", qemu_target_page_size());
     json_start_array(vmdesc, "devices");
     QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
@@ -1193,8 +1157,8 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
             return ret;
         }
     }
-    if (!in_postcopy) {
-        /* Postcopy stream will still be going */
+
+    if (send_eof) {
         qemu_put_byte(f, QEMU_VM_EOF);
     }
 
@@ -1213,6 +1177,51 @@ int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
     return 0;
 }
 
+int qemu_savevm_state_complete_precopy(QEMUFile *f, bool iterable_only,
+                                       bool inactivate_disks)
+{
+    SaveStateEntry *se;
+    int ret;
+    bool in_postcopy = migration_in_postcopy();
+
+    trace_savevm_state_complete_precopy();
+
+    cpu_synchronize_all_states();
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->ops ||
+            (in_postcopy && se->ops->has_postcopy &&
+             se->ops->has_postcopy(se->opaque)) ||
+            (in_postcopy && !iterable_only) ||
+            !se->ops->save_live_complete_precopy) {
+            continue;
+        }
+
+        if (se->ops && se->ops->is_active) {
+            if (!se->ops->is_active(se->opaque)) {
+                continue;
+            }
+        }
+        trace_savevm_section_start(se->idstr, se->section_id);
+
+        save_section_header(f, se, QEMU_VM_SECTION_END);
+
+        ret = se->ops->save_live_complete_precopy(f, se->opaque);
+        trace_savevm_section_end(se->idstr, se->section_id, ret);
+        save_section_footer(f, se);
+        if (ret < 0) {
+            qemu_file_set_error(f, ret);
+            return -1;
+        }
+    }
+
+    if (iterable_only) {
+        return 0;
+    }
+
+    return qemu_save_all_device_states(f, inactivate_disks, !in_postcopy);
+}
+
 /* Give an estimate of the amount left to be transferred,
  * the result is split into the amount for units that can and
  * for units that can't do postcopy.
diff --git a/migration/savevm.h b/migration/savevm.h
index 295c4a1f2c..87b278142d 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -55,4 +55,6 @@ void qemu_savevm_send_postcopy_ram_discard(QEMUFile *f, const char *name,
 int qemu_loadvm_state(QEMUFile *f);
 void qemu_loadvm_state_cleanup(void);
 
+int qemu_save_all_device_states(QEMUFile *f, bool inactivate_disks,
+                                bool send_eof);
 #endif
-- 
2.17.0
