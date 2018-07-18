Received: from eggs.gnu.org ([2001:4830:134:3::10]:52999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoam-0003Hx-4w
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dplotnikov@virtuozzo.com>) id 1ffoag-0000Im-SR
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:16 -0400
Received: from relay.sw.ru ([185.231.240.75]:36422)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dplotnikov@virtuozzo.com>)
	id 1ffoag-0000GP-K9
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 11:42:10 -0400
From: Denis Plotnikov <dplotnikov@virtuozzo.com>
Date: Wed, 18 Jul 2018 18:42:00 +0300
Message-Id: <20180718154200.26777-18-dplotnikov@virtuozzo.com>
In-Reply-To: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
References: <20180718154200.26777-1-dplotnikov@virtuozzo.com>
Subject: [Qemu-devel] [PATCH v1 17/17] background snapshot: enable
 background snapshot
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
migration capability and start the migration

Signed-off-by: Denis Plotnikov <dplotnikov@virtuozzo.com>
---
 migration/migration.c | 103 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 2 deletions(-)

diff --git a/migration/migration.c b/migration/migration.c
index 131d0904e4..935e5b6f2e 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2188,6 +2188,99 @@ bool migrate_colo_enabled(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_X_COLO];
 }
 
+static void background_snapshot_sigsegv_handler(int unused0, siginfo_t *info,
+                                                void *unused1)
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
+    /* save the device state to the temporary buffer */
+    bioc = qio_channel_buffer_new(4096);
+    qio_channel_set_name(QIO_CHANNEL(bioc), "vmstate-buffer");
+    fb = qemu_fopen_channel_output(QIO_CHANNEL(bioc));
+    object_unref(OBJECT(bioc));
+
+    ram_block_list_create();
+    ram_block_list_set_readonly();
+
+    if (global_state_store()) {
+        goto exit;
+    }
+
+    if (qemu_savevm_state_save(fb, false, true) < 0) {
+        migrate_set_state(&m->state, MIGRATION_STATUS_ACTIVE,
+                          MIGRATION_STATUS_FAILED);
+        goto exit;
+    }
+
+    sigsegv_user_handler_set(background_snapshot_sigsegv_handler);
+
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
+    /*
+     * By this moment we have RAM saved into the stream
+     * The next step is to flush the device state right after the
+     * RAM saved. The rest of device state is stored in
+     * the temporary buffer. Do flush the buffer into the stream.
+     */
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
+    ram_block_list_set_writable();
+    ram_block_list_destroy();
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
@@ -2402,8 +2495,14 @@ void migrate_fd_connect(MigrationState *s)
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
 
-- 
2.17.0
