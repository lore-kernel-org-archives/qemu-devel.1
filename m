Received: from eggs.gnu.org ([2001:4830:134:3::10]:38950)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRpC-0006in-Jv
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1fsRp5-0008NN-KH
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:22 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57310 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1fsRp3-0008Kc-BJ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 08:01:15 -0400
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 22 Aug 2018 14:00:37 +0200
Message-Id: <20180822120050.12694-8-quintela@redhat.com>
In-Reply-To: <20180822120050.12694-1-quintela@redhat.com>
References: <20180822120050.12694-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 07/20] migration: implement bi-directional RDMA
 QIOChannel
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com, Lidong Chen <jemmy858585@gmail.com>, Lidong Chen <lidongchen@tencent.com>

From: Lidong Chen <jemmy858585@gmail.com>

This patch implements bi-directional RDMA QIOChannel. Because different
threads may access RDMAQIOChannel currently, this patch use RCU to protect it.

Signed-off-by: Lidong Chen <lidongchen@tencent.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/colo.c         |   2 +
 migration/migration.c    |   2 +
 migration/postcopy-ram.c |   2 +
 migration/ram.c          |   4 +
 migration/rdma.c         | 196 +++++++++++++++++++++++++++++++++------
 migration/savevm.c       |   3 +
 6 files changed, 183 insertions(+), 26 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index 4381067ed4..88936f5962 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -534,6 +534,7 @@ void *colo_process_incoming_thread(void *opaque)
     uint64_t value;
     Error *local_err = NULL;
 
+    rcu_register_thread();
     qemu_sem_init(&mis->colo_incoming_sem, 0);
 
     migrate_set_state(&mis->state, MIGRATION_STATUS_ACTIVE,
@@ -666,5 +667,6 @@ out:
     }
     migration_incoming_exit_colo();
 
+    rcu_unregister_thread();
     return NULL;
 }
diff --git a/migration/migration.c b/migration/migration.c
index 570da6c0e7..6f2b506335 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2121,6 +2121,7 @@ static void *source_return_path_thread(void *opaque)
     int res;
 
     trace_source_return_path_thread_entry();
+    rcu_register_thread();
 
 retry:
     while (!ms->rp_state.error && !qemu_file_get_error(rp) &&
@@ -2260,6 +2261,7 @@ out:
     trace_source_return_path_thread_end();
     ms->rp_state.from_dst_file = NULL;
     qemu_fclose(rp);
+    rcu_unregister_thread();
     return NULL;
 }
 
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index 932f188949..3952d78e6b 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -853,6 +853,7 @@ static void *postcopy_ram_fault_thread(void *opaque)
     RAMBlock *rb = NULL;
 
     trace_postcopy_ram_fault_thread_entry();
+    rcu_register_thread();
     mis->last_rb = NULL; /* last RAMBlock we sent part of */
     qemu_sem_post(&mis->fault_thread_sem);
 
@@ -1059,6 +1060,7 @@ retry:
             }
         }
     }
+    rcu_unregister_thread();
     trace_postcopy_ram_fault_thread_exit();
     g_free(pfd);
     return NULL;
diff --git a/migration/ram.c b/migration/ram.c
index 1e5c45a514..2f9e8bd7e0 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -989,6 +989,7 @@ static void *multifd_send_thread(void *opaque)
     int ret;
 
     trace_multifd_send_thread_start(p->id);
+    rcu_register_thread();
 
     if (multifd_send_initial_packet(p, &local_err) < 0) {
         goto out;
@@ -1051,6 +1052,7 @@ out:
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
 
+    rcu_unregister_thread();
     trace_multifd_send_thread_end(p->id, p->num_packets, p->num_pages);
 
     return NULL;
@@ -1220,6 +1222,7 @@ static void *multifd_recv_thread(void *opaque)
     int ret;
 
     trace_multifd_recv_thread_start(p->id);
+    rcu_register_thread();
 
     while (true) {
         uint32_t used;
@@ -1266,6 +1269,7 @@ static void *multifd_recv_thread(void *opaque)
     p->running = false;
     qemu_mutex_unlock(&p->mutex);
 
+    rcu_unregister_thread();
     trace_multifd_recv_thread_end(p->id, p->num_packets, p->num_pages);
 
     return NULL;
diff --git a/migration/rdma.c b/migration/rdma.c
index 57af5ed392..a5535fbb97 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -86,6 +86,7 @@ static uint32_t known_capabilities = RDMA_CAPABILITY_PIN_ALL;
                                 " to abort!"); \
                 rdma->error_reported = 1; \
             } \
+            rcu_read_unlock(); \
             return rdma->error_state; \
         } \
     } while (0)
@@ -402,7 +403,8 @@ typedef struct QIOChannelRDMA QIOChannelRDMA;
 
 struct QIOChannelRDMA {
     QIOChannel parent;
-    RDMAContext *rdma;
+    RDMAContext *rdmain;
+    RDMAContext *rdmaout;
     QEMUFile *file;
     bool blocking; /* XXX we don't actually honour this yet */
 };
@@ -2630,12 +2632,20 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
     QEMUFile *f = rioc->file;
-    RDMAContext *rdma = rioc->rdma;
+    RDMAContext *rdma;
     int ret;
     ssize_t done = 0;
     size_t i;
     size_t len = 0;
 
+    rcu_read_lock();
+    rdma = atomic_rcu_read(&rioc->rdmaout);
+
+    if (!rdma) {
+        rcu_read_unlock();
+        return -EIO;
+    }
+
     CHECK_ERROR_STATE();
 
     /*
@@ -2645,6 +2655,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
     ret = qemu_rdma_write_flush(f, rdma);
     if (ret < 0) {
         rdma->error_state = ret;
+        rcu_read_unlock();
         return ret;
     }
 
@@ -2664,6 +2675,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
 
             if (ret < 0) {
                 rdma->error_state = ret;
+                rcu_read_unlock();
                 return ret;
             }
 
@@ -2672,6 +2684,7 @@ static ssize_t qio_channel_rdma_writev(QIOChannel *ioc,
         }
     }
 
+    rcu_read_unlock();
     return done;
 }
 
@@ -2705,12 +2718,20 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
                                       Error **errp)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
-    RDMAContext *rdma = rioc->rdma;
+    RDMAContext *rdma;
     RDMAControlHeader head;
     int ret = 0;
     ssize_t i;
     size_t done = 0;
 
+    rcu_read_lock();
+    rdma = atomic_rcu_read(&rioc->rdmain);
+
+    if (!rdma) {
+        rcu_read_unlock();
+        return -EIO;
+    }
+
     CHECK_ERROR_STATE();
 
     for (i = 0; i < niov; i++) {
@@ -2722,7 +2743,7 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
          * were given and dish out the bytes until we run
          * out of bytes.
          */
-        ret = qemu_rdma_fill(rioc->rdma, data, want, 0);
+        ret = qemu_rdma_fill(rdma, data, want, 0);
         done += ret;
         want -= ret;
         /* Got what we needed, so go to next iovec */
@@ -2744,25 +2765,28 @@ static ssize_t qio_channel_rdma_readv(QIOChannel *ioc,
 
         if (ret < 0) {
             rdma->error_state = ret;
+            rcu_read_unlock();
             return ret;
         }
 
         /*
          * SEND was received with new bytes, now try again.
          */
-        ret = qemu_rdma_fill(rioc->rdma, data, want, 0);
+        ret = qemu_rdma_fill(rdma, data, want, 0);
         done += ret;
         want -= ret;
 
         /* Still didn't get enough, so lets just return */
         if (want) {
             if (done == 0) {
+                rcu_read_unlock();
                 return QIO_CHANNEL_ERR_BLOCK;
             } else {
                 break;
             }
         }
     }
+    rcu_read_unlock();
     return done;
 }
 
@@ -2814,15 +2838,29 @@ qio_channel_rdma_source_prepare(GSource *source,
                                 gint *timeout)
 {
     QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
-    RDMAContext *rdma = rsource->rioc->rdma;
+    RDMAContext *rdma;
     GIOCondition cond = 0;
     *timeout = -1;
 
+    rcu_read_lock();
+    if (rsource->condition == G_IO_IN) {
+        rdma = atomic_rcu_read(&rsource->rioc->rdmain);
+    } else {
+        rdma = atomic_rcu_read(&rsource->rioc->rdmaout);
+    }
+
+    if (!rdma) {
+        error_report("RDMAContext is NULL when prepare Gsource");
+        rcu_read_unlock();
+        return FALSE;
+    }
+
     if (rdma->wr_data[0].control_len) {
         cond |= G_IO_IN;
     }
     cond |= G_IO_OUT;
 
+    rcu_read_unlock();
     return cond & rsource->condition;
 }
 
@@ -2830,14 +2868,28 @@ static gboolean
 qio_channel_rdma_source_check(GSource *source)
 {
     QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
-    RDMAContext *rdma = rsource->rioc->rdma;
+    RDMAContext *rdma;
     GIOCondition cond = 0;
 
+    rcu_read_lock();
+    if (rsource->condition == G_IO_IN) {
+        rdma = atomic_rcu_read(&rsource->rioc->rdmain);
+    } else {
+        rdma = atomic_rcu_read(&rsource->rioc->rdmaout);
+    }
+
+    if (!rdma) {
+        error_report("RDMAContext is NULL when check Gsource");
+        rcu_read_unlock();
+        return FALSE;
+    }
+
     if (rdma->wr_data[0].control_len) {
         cond |= G_IO_IN;
     }
     cond |= G_IO_OUT;
 
+    rcu_read_unlock();
     return cond & rsource->condition;
 }
 
@@ -2848,14 +2900,28 @@ qio_channel_rdma_source_dispatch(GSource *source,
 {
     QIOChannelFunc func = (QIOChannelFunc)callback;
     QIOChannelRDMASource *rsource = (QIOChannelRDMASource *)source;
-    RDMAContext *rdma = rsource->rioc->rdma;
+    RDMAContext *rdma;
     GIOCondition cond = 0;
 
+    rcu_read_lock();
+    if (rsource->condition == G_IO_IN) {
+        rdma = atomic_rcu_read(&rsource->rioc->rdmain);
+    } else {
+        rdma = atomic_rcu_read(&rsource->rioc->rdmaout);
+    }
+
+    if (!rdma) {
+        error_report("RDMAContext is NULL when dispatch Gsource");
+        rcu_read_unlock();
+        return FALSE;
+    }
+
     if (rdma->wr_data[0].control_len) {
         cond |= G_IO_IN;
     }
     cond |= G_IO_OUT;
 
+    rcu_read_unlock();
     return (*func)(QIO_CHANNEL(rsource->rioc),
                    (cond & rsource->condition),
                    user_data);
@@ -2900,15 +2966,32 @@ static int qio_channel_rdma_close(QIOChannel *ioc,
                                   Error **errp)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(ioc);
+    RDMAContext *rdmain, *rdmaout;
     trace_qemu_rdma_close();
-    if (rioc->rdma) {
-        if (!rioc->rdma->error_state) {
-            rioc->rdma->error_state = qemu_file_get_error(rioc->file);
-        }
-        qemu_rdma_cleanup(rioc->rdma);
-        g_free(rioc->rdma);
-        rioc->rdma = NULL;
+
+    rdmain = rioc->rdmain;
+    if (rdmain) {
+        atomic_rcu_set(&rioc->rdmain, NULL);
     }
+
+    rdmaout = rioc->rdmaout;
+    if (rdmaout) {
+        atomic_rcu_set(&rioc->rdmaout, NULL);
+    }
+
+    synchronize_rcu();
+
+    if (rdmain) {
+        qemu_rdma_cleanup(rdmain);
+    }
+
+    if (rdmaout) {
+        qemu_rdma_cleanup(rdmaout);
+    }
+
+    g_free(rdmain);
+    g_free(rdmaout);
+
     return 0;
 }
 
@@ -2951,12 +3034,21 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
                                   size_t size, uint64_t *bytes_sent)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
-    RDMAContext *rdma = rioc->rdma;
+    RDMAContext *rdma;
     int ret;
 
+    rcu_read_lock();
+    rdma = atomic_rcu_read(&rioc->rdmaout);
+
+    if (!rdma) {
+        rcu_read_unlock();
+        return -EIO;
+    }
+
     CHECK_ERROR_STATE();
 
     if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        rcu_read_unlock();
         return RAM_SAVE_CONTROL_NOT_SUPP;
     }
 
@@ -3041,9 +3133,11 @@ static size_t qemu_rdma_save_page(QEMUFile *f, void *opaque,
         }
     }
 
+    rcu_read_unlock();
     return RAM_SAVE_CONTROL_DELAYED;
 err:
     rdma->error_state = ret;
+    rcu_read_unlock();
     return ret;
 }
 
@@ -3219,8 +3313,8 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
     RDMAControlHeader blocks = { .type = RDMA_CONTROL_RAM_BLOCKS_RESULT,
                                  .repeat = 1 };
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
-    RDMAContext *rdma = rioc->rdma;
-    RDMALocalBlocks *local = &rdma->local_ram_blocks;
+    RDMAContext *rdma;
+    RDMALocalBlocks *local;
     RDMAControlHeader head;
     RDMARegister *reg, *registers;
     RDMACompress *comp;
@@ -3233,8 +3327,17 @@ static int qemu_rdma_registration_handle(QEMUFile *f, void *opaque)
     int count = 0;
     int i = 0;
 
+    rcu_read_lock();
+    rdma = atomic_rcu_read(&rioc->rdmain);
+
+    if (!rdma) {
+        rcu_read_unlock();
+        return -EIO;
+    }
+
     CHECK_ERROR_STATE();
 
+    local = &rdma->local_ram_blocks;
     do {
         trace_qemu_rdma_registration_handle_wait();
 
@@ -3468,6 +3571,7 @@ out:
     if (ret < 0) {
         rdma->error_state = ret;
     }
+    rcu_read_unlock();
     return ret;
 }
 
@@ -3481,10 +3585,18 @@ out:
 static int
 rdma_block_notification_handle(QIOChannelRDMA *rioc, const char *name)
 {
-    RDMAContext *rdma = rioc->rdma;
+    RDMAContext *rdma;
     int curr;
     int found = -1;
 
+    rcu_read_lock();
+    rdma = atomic_rcu_read(&rioc->rdmain);
+
+    if (!rdma) {
+        rcu_read_unlock();
+        return -EIO;
+    }
+
     /* Find the matching RAMBlock in our local list */
     for (curr = 0; curr < rdma->local_ram_blocks.nb_blocks; curr++) {
         if (!strcmp(rdma->local_ram_blocks.block[curr].block_name, name)) {
@@ -3495,6 +3607,7 @@ rdma_block_notification_handle(QIOChannelRDMA *rioc, const char *name)
 
     if (found == -1) {
         error_report("RAMBlock '%s' not found on destination", name);
+        rcu_read_unlock();
         return -ENOENT;
     }
 
@@ -3502,6 +3615,7 @@ rdma_block_notification_handle(QIOChannelRDMA *rioc, const char *name)
     trace_rdma_block_notification_handle(name, rdma->next_src_index);
     rdma->next_src_index++;
 
+    rcu_read_unlock();
     return 0;
 }
 
@@ -3524,11 +3638,19 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
                                         uint64_t flags, void *data)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
-    RDMAContext *rdma = rioc->rdma;
+    RDMAContext *rdma;
+
+    rcu_read_lock();
+    rdma = atomic_rcu_read(&rioc->rdmaout);
+    if (!rdma) {
+        rcu_read_unlock();
+        return -EIO;
+    }
 
     CHECK_ERROR_STATE();
 
     if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        rcu_read_unlock();
         return 0;
     }
 
@@ -3536,6 +3658,7 @@ static int qemu_rdma_registration_start(QEMUFile *f, void *opaque,
     qemu_put_be64(f, RAM_SAVE_FLAG_HOOK);
     qemu_fflush(f);
 
+    rcu_read_unlock();
     return 0;
 }
 
@@ -3548,13 +3671,21 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
 {
     Error *local_err = NULL, **errp = &local_err;
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(opaque);
-    RDMAContext *rdma = rioc->rdma;
+    RDMAContext *rdma;
     RDMAControlHeader head = { .len = 0, .repeat = 1 };
     int ret = 0;
 
+    rcu_read_lock();
+    rdma = atomic_rcu_read(&rioc->rdmaout);
+    if (!rdma) {
+        rcu_read_unlock();
+        return -EIO;
+    }
+
     CHECK_ERROR_STATE();
 
     if (migrate_get_current()->state == MIGRATION_STATUS_POSTCOPY_ACTIVE) {
+        rcu_read_unlock();
         return 0;
     }
 
@@ -3586,6 +3717,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
                     qemu_rdma_reg_whole_ram_blocks : NULL);
         if (ret < 0) {
             ERROR(errp, "receiving remote info!");
+            rcu_read_unlock();
             return ret;
         }
 
@@ -3609,6 +3741,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
                         "not identical on both the source and destination.",
                         local->nb_blocks, nb_dest_blocks);
             rdma->error_state = -EINVAL;
+            rcu_read_unlock();
             return -EINVAL;
         }
 
@@ -3625,6 +3758,7 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
                             local->block[i].length,
                             rdma->dest_blocks[i].length);
                 rdma->error_state = -EINVAL;
+                rcu_read_unlock();
                 return -EINVAL;
             }
             local->block[i].remote_host_addr =
@@ -3642,9 +3776,11 @@ static int qemu_rdma_registration_stop(QEMUFile *f, void *opaque,
         goto err;
     }
 
+    rcu_read_unlock();
     return 0;
 err:
     rdma->error_state = ret;
+    rcu_read_unlock();
     return ret;
 }
 
@@ -3662,10 +3798,15 @@ static const QEMUFileHooks rdma_write_hooks = {
 static void qio_channel_rdma_finalize(Object *obj)
 {
     QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(obj);
-    if (rioc->rdma) {
-        qemu_rdma_cleanup(rioc->rdma);
-        g_free(rioc->rdma);
-        rioc->rdma = NULL;
+    if (rioc->rdmain) {
+        qemu_rdma_cleanup(rioc->rdmain);
+        g_free(rioc->rdmain);
+        rioc->rdmain = NULL;
+    }
+    if (rioc->rdmaout) {
+        qemu_rdma_cleanup(rioc->rdmaout);
+        g_free(rioc->rdmaout);
+        rioc->rdmaout = NULL;
     }
 }
 
@@ -3705,13 +3846,16 @@ static QEMUFile *qemu_fopen_rdma(RDMAContext *rdma, const char *mode)
     }
 
     rioc = QIO_CHANNEL_RDMA(object_new(TYPE_QIO_CHANNEL_RDMA));
-    rioc->rdma = rdma;
 
     if (mode[0] == 'w') {
         rioc->file = qemu_fopen_channel_output(QIO_CHANNEL(rioc));
+        rioc->rdmaout = rdma;
+        rioc->rdmain = rdma->return_path;
         qemu_file_set_hooks(rioc->file, &rdma_write_hooks);
     } else {
         rioc->file = qemu_fopen_channel_input(QIO_CHANNEL(rioc));
+        rioc->rdmain = rdma;
+        rioc->rdmaout = rdma->return_path;
         qemu_file_set_hooks(rioc->file, &rdma_read_hooks);
     }
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 7f92567a10..13e51f0e34 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1622,6 +1622,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     qemu_sem_post(&mis->listen_thread_sem);
     trace_postcopy_ram_listen_thread_start();
 
+    rcu_register_thread();
     /*
      * Because we're a thread and not a coroutine we can't yield
      * in qemu_file, and thus we must be blocking now.
@@ -1662,6 +1663,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
          * to leave the guest running and fire MCEs for pages that never
          * arrived as a desperate recovery step.
          */
+        rcu_unregister_thread();
         exit(EXIT_FAILURE);
     }
 
@@ -1676,6 +1678,7 @@ static void *postcopy_ram_listen_thread(void *opaque)
     migration_incoming_state_destroy();
     qemu_loadvm_state_cleanup();
 
+    rcu_unregister_thread();
     return NULL;
 }
 
-- 
2.17.1
