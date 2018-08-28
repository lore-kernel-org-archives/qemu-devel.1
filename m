Received: from eggs.gnu.org ([2001:4830:134:3::10]:33429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujXK-0006NU-Lq
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:20:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fujO8-0004x5-Rk
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53904 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fujO8-0004uL-Jo
	for qemu-devel@nongnu.org; Tue, 28 Aug 2018 15:10:52 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 426D1400738B
	for <qemu-devel@nongnu.org>; Tue, 28 Aug 2018 19:10:52 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Tue, 28 Aug 2018 21:10:44 +0200
Message-Id: <20180828191048.29806-3-armbru@redhat.com>
In-Reply-To: <20180828191048.29806-1-armbru@redhat.com>
References: <20180828191048.29806-1-armbru@redhat.com>
Subject: [Qemu-devel] [PULL 2/6] qapi: Drop qapi_event_send_FOO()'s Error **
 argument
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>

From: Peter Xu <peterx@redhat.com>

The generated qapi_event_send_FOO() take an Error ** argument.  They
can't actually fail, because all they do with the argument is passing it
to functions that can't fail: the QObject output visitor, and the
@qmp_emit callback, which is either monitor_qapi_event_queue() or
event_test_emit().

Drop the argument, and pass &error_abort to the QObject output visitor
and @qmp_emit instead.

Suggested-by: Eric Blake <eblake@redhat.com>
Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20180815133747.25032-4-peterx@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
[Commit message rewritten, update to qapi-code-gen.txt corrected]
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 block/block-backend.c        |  8 +++-----
 block/qcow2.c                |  2 +-
 block/quorum.c               |  4 ++--
 block/write-threshold.c      |  3 +--
 blockjob.c                   | 13 +++++--------
 cpus.c                       |  8 ++++----
 docs/devel/qapi-code-gen.txt |  8 +++-----
 dump.c                       |  3 +--
 hw/acpi/core.c               |  2 +-
 hw/acpi/cpu.c                |  2 +-
 hw/acpi/memory_hotplug.c     |  5 ++---
 hw/char/virtio-console.c     |  3 +--
 hw/core/qdev.c               |  3 +--
 hw/net/virtio-net.c          |  2 +-
 hw/ppc/spapr_rtc.c           |  2 +-
 hw/timer/mc146818rtc.c       |  2 +-
 hw/virtio/virtio-balloon.c   |  3 +--
 hw/watchdog/watchdog.c       | 15 +++++++--------
 include/qapi/qmp-event.h     |  3 +--
 job.c                        |  2 +-
 migration/migration.c        |  4 ++--
 migration/ram.c              |  2 +-
 monitor.c                    |  5 ++---
 scripts/qapi/events.py       | 23 ++++++-----------------
 scsi/pr-manager-helper.c     |  3 +--
 tests/test-qmp-event.c       | 11 +++++------
 ui/spice-core.c              | 10 ++++------
 ui/vnc.c                     |  7 +++----
 vl.c                         | 16 +++++++---------
 29 files changed, 70 insertions(+), 104 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index fa120630be..14a1b7ac6a 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -980,8 +980,7 @@ void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp)
 
         if (tray_was_open != tray_is_open) {
             char *id = blk_get_attached_dev_id(blk);
-            qapi_event_send_device_tray_moved(blk_name(blk), id, tray_is_open,
-                                              &error_abort);
+            qapi_event_send_device_tray_moved(blk_name(blk), id, tray_is_open);
             g_free(id);
         }
     }
@@ -1665,8 +1664,7 @@ static void send_qmp_error_event(BlockBackend *blk,
     qapi_event_send_block_io_error(blk_name(blk), !!bs,
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
-                                   error == ENOSPC, strerror(error),
-                                   &error_abort);
+                                   error == ENOSPC, strerror(error));
 }
 
 /* This is done by device models because, while the block layer knows
@@ -1782,7 +1780,7 @@ void blk_eject(BlockBackend *blk, bool eject_flag)
      * the frontend experienced a tray event. */
     id = blk_get_attached_dev_id(blk);
     qapi_event_send_device_tray_moved(blk_name(blk), id,
-                                      eject_flag, &error_abort);
+                                      eject_flag);
     g_free(id);
 }
 
diff --git a/block/qcow2.c b/block/qcow2.c
index ec9e6238a0..c13153735a 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4659,7 +4659,7 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
                                           *node_name != '\0', node_name,
                                           message, offset >= 0, offset,
                                           size >= 0, size,
-                                          fatal, &error_abort);
+                                          fatal);
     g_free(message);
 
     if (fatal) {
diff --git a/block/quorum.c b/block/quorum.c
index 9152da8c58..eb526cc0f1 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -199,7 +199,7 @@ static void quorum_report_bad(QuorumOpType type, uint64_t offset,
     }
 
     qapi_event_send_quorum_report_bad(type, !!msg, msg, node_name, start_sector,
-                                      end_sector - start_sector, &error_abort);
+                                      end_sector - start_sector);
 }
 
 static void quorum_report_failure(QuorumAIOCB *acb)
@@ -210,7 +210,7 @@ static void quorum_report_failure(QuorumAIOCB *acb)
                                       BDRV_SECTOR_SIZE);
 
     qapi_event_send_quorum_failure(reference, start_sector,
-                                   end_sector - start_sector, &error_abort);
+                                   end_sector - start_sector);
 }
 
 static int quorum_vote_error(QuorumAIOCB *acb);
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 1d48fc2077..85b78dc2a9 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -63,8 +63,7 @@ static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
         qapi_event_send_block_write_threshold(
             bs->node_name,
             amount,
-            bs->write_threshold_offset,
-            &error_abort);
+            bs->write_threshold_offset);
 
         /* autodisable to avoid flooding the monitor */
         write_threshold_disable(bs);
diff --git a/blockjob.c b/blockjob.c
index be5903aa96..bf7ef48f98 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -315,8 +315,7 @@ static void block_job_event_cancelled(Notifier *n, void *opaque)
                                         job->job.id,
                                         job->job.progress_total,
                                         job->job.progress_current,
-                                        job->speed,
-                                        &error_abort);
+                                        job->speed);
 }
 
 static void block_job_event_completed(Notifier *n, void *opaque)
@@ -338,8 +337,7 @@ static void block_job_event_completed(Notifier *n, void *opaque)
                                         job->job.progress_current,
                                         job->speed,
                                         !!msg,
-                                        msg,
-                                        &error_abort);
+                                        msg);
 }
 
 static void block_job_event_pending(Notifier *n, void *opaque)
@@ -351,8 +349,7 @@ static void block_job_event_pending(Notifier *n, void *opaque)
     }
 
     qapi_event_send_block_job_pending(job_type(&job->job),
-                                      job->job.id,
-                                      &error_abort);
+                                      job->job.id);
 }
 
 static void block_job_event_ready(Notifier *n, void *opaque)
@@ -367,7 +364,7 @@ static void block_job_event_ready(Notifier *n, void *opaque)
                                     job->job.id,
                                     job->job.progress_total,
                                     job->job.progress_current,
-                                    job->speed, &error_abort);
+                                    job->speed);
 }
 
 
@@ -494,7 +491,7 @@ BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
         qapi_event_send_block_job_error(job->job.id,
                                         is_read ? IO_OPERATION_TYPE_READ :
                                         IO_OPERATION_TYPE_WRITE,
-                                        action, &error_abort);
+                                        action);
     }
     if (action == BLOCK_ERROR_ACTION_STOP) {
         job_pause(&job->job);
diff --git a/cpus.c b/cpus.c
index 8ee6e5db93..412aebc8b0 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1053,7 +1053,7 @@ static int do_vm_stop(RunState state, bool send_stop)
         runstate_set(state);
         vm_state_notify(0, state);
         if (send_stop) {
-            qapi_event_send_stop(&error_abort);
+            qapi_event_send_stop();
         }
     }
 
@@ -2107,13 +2107,13 @@ int vm_prepare_start(void)
      * the STOP event.
      */
     if (runstate_is_running()) {
-        qapi_event_send_stop(&error_abort);
-        qapi_event_send_resume(&error_abort);
+        qapi_event_send_stop();
+        qapi_event_send_resume();
         return -1;
     }
 
     /* We are sending this now, but the CPUs will be resumed shortly later */
-    qapi_event_send_resume(&error_abort);
+    qapi_event_send_resume();
 
     replay_enable_events();
     cpu_enable_ticks();
diff --git a/docs/devel/qapi-code-gen.txt b/docs/devel/qapi-code-gen.txt
index c2e11465f0..220791d737 100644
--- a/docs/devel/qapi-code-gen.txt
+++ b/docs/devel/qapi-code-gen.txt
@@ -1340,7 +1340,7 @@ Example:
     #include "example-qapi-types.h"
 
 
-    void qapi_event_send_my_event(Error **errp);
+    void qapi_event_send_my_event(void);
 
     typedef enum example_QAPIEvent {
         EXAMPLE_QAPI_EVENT_MY_EVENT = 0,
@@ -1356,10 +1356,9 @@ Example:
     $ cat qapi-generated/example-qapi-events.c
 [Uninteresting stuff omitted...]
 
-    void qapi_event_send_my_event(Error **errp)
+    void qapi_event_send_my_event(void)
     {
         QDict *qmp;
-        Error *err = NULL;
         QMPEventFuncEmit emit;
 
         emit = qmp_event_get_func_emit();
@@ -1369,9 +1368,8 @@ Example:
 
         qmp = qmp_event_build_dict("MY_EVENT");
 
-        emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp, &err);
+        emit(EXAMPLE_QAPI_EVENT_MY_EVENT, qmp);
 
-        error_propagate(errp, err);
         qobject_unref(qmp);
     }
 
diff --git a/dump.c b/dump.c
index 500b554523..4ec94c5e25 100644
--- a/dump.c
+++ b/dump.c
@@ -1890,8 +1890,7 @@ static void dump_process(DumpState *s, Error **errp)
     /* should never fail */
     assert(result);
     qapi_event_send_dump_completed(result, !!local_err, (local_err ? \
-                                   error_get_pretty(local_err) : NULL),
-                                   &error_abort);
+                                   error_get_pretty(local_err) : NULL));
     qapi_free_DumpQueryResult(result);
 
     error_propagate(errp, local_err);
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index b8d39012cd..aafdc61648 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -570,7 +570,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
             break;
         default:
             if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
-                qapi_event_send_suspend_disk(&error_abort);
+                qapi_event_send_suspend_disk();
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             }
             break;
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 5ae595ecbe..d19b7722f0 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -160,7 +160,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
            cdev = &cpu_st->devs[cpu_st->selector];
            cdev->ost_status = data;
            info = acpi_cpu_device_status(cpu_st->selector, cdev);
-           qapi_event_send_acpi_device_ost(info, &error_abort);
+           qapi_event_send_acpi_device_ost(info);
            qapi_free_ACPIOSTInfo(info);
            trace_cpuhp_acpi_write_ost_status(cpu_st->selector,
                                              cdev->ost_status);
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 0ff1712c4c..8c7c1013f3 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -161,7 +161,7 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
         /* TODO: implement memory removal on guest signal */
 
         info = acpi_memory_device_status(mem_st->selector, mdev);
-        qapi_event_send_acpi_device_ost(info, &error_abort);
+        qapi_event_send_acpi_device_ost(info);
         qapi_free_ACPIOSTInfo(info);
         break;
     case 0x14: /* set is_* fields  */
@@ -185,8 +185,7 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
             if (local_err) {
                 trace_mhp_acpi_pc_dimm_delete_failed(mem_st->selector);
                 qapi_event_send_mem_unplug_error(dev->id,
-                                                 error_get_pretty(local_err),
-                                                 &error_abort);
+                                                 error_get_pretty(local_err));
                 error_free(local_err);
                 break;
             }
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 679a824888..2cbe1d4ed5 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -114,8 +114,7 @@ static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
     }
 
     if (dev->id) {
-        qapi_event_send_vserport_change(dev->id, guest_connected,
-                                        &error_abort);
+        qapi_event_send_vserport_change(dev->id, guest_connected);
     }
 }
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 529b82de18..36b788a66b 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -1000,8 +1000,7 @@ static void device_finalize(Object *obj)
     if (dev->pending_deleted_event) {
         g_assert(dev->canonical_path);
 
-        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path,
-                                       &error_abort);
+        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path);
         g_free(dev->canonical_path);
         dev->canonical_path = NULL;
     }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index f154756e85..4bdd5b8532 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -329,7 +329,7 @@ static void rxfilter_notify(NetClientState *nc)
     if (nc->rxfilter_notify_enabled) {
         gchar *path = object_get_canonical_path(OBJECT(n->qdev));
         qapi_event_send_nic_rx_filter_changed(!!n->netclient_name,
-                                              n->netclient_name, path, &error_abort);
+                                              n->netclient_name, path);
         g_free(path);
 
         /* disable event notification to avoid events flooding */
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index a37360537e..cd049f389d 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -118,7 +118,7 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     }
 
     /* Generate a monitor event for the change */
-    qapi_event_send_rtc_change(qemu_timedate_diff(&tm), &error_abort);
+    qapi_event_send_rtc_change(qemu_timedate_diff(&tm));
 
     host_ns = qemu_clock_get_ns(rtc_clock);
 
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index a504f0308d..acee47da0e 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -635,7 +635,7 @@ static void rtc_set_time(RTCState *s)
     s->base_rtc = mktimegm(&tm);
     s->last_update = qemu_clock_get_ns(rtc_clock);
 
-    qapi_event_send_rtc_change(qemu_timedate_diff(&tm), &error_abort);
+    qapi_event_send_rtc_change(qemu_timedate_diff(&tm));
 }
 
 static void rtc_set_cmos(RTCState *s, const struct tm *tm)
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index b5425080c5..1728e4f83a 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -365,8 +365,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
     dev->actual = le32_to_cpu(config.actual);
     if (dev->actual != oldactual) {
         qapi_event_send_balloon_change(vm_ram_size -
-                        ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT),
-                        &error_abort);
+                        ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
 }
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 6e8ba061d8..33e6c20184 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -102,17 +102,17 @@ void watchdog_perform_action(void)
 {
     switch (watchdog_action) {
     case WATCHDOG_ACTION_RESET:     /* same as 'system_reset' in monitor */
-        qapi_event_send_watchdog(WATCHDOG_ACTION_RESET, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_RESET);
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;
 
     case WATCHDOG_ACTION_SHUTDOWN:  /* same as 'system_powerdown' in monitor */
-        qapi_event_send_watchdog(WATCHDOG_ACTION_SHUTDOWN, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_SHUTDOWN);
         qemu_system_powerdown_request();
         break;
 
     case WATCHDOG_ACTION_POWEROFF:  /* same as 'quit' command in monitor */
-        qapi_event_send_watchdog(WATCHDOG_ACTION_POWEROFF, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_POWEROFF);
         exit(0);
 
     case WATCHDOG_ACTION_PAUSE:     /* same as 'stop' command in monitor */
@@ -120,22 +120,21 @@ void watchdog_perform_action(void)
          * you would get a deadlock.  Bypass the problem.
          */
         qemu_system_vmstop_request_prepare();
-        qapi_event_send_watchdog(WATCHDOG_ACTION_PAUSE, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_PAUSE);
         qemu_system_vmstop_request(RUN_STATE_WATCHDOG);
         break;
 
     case WATCHDOG_ACTION_DEBUG:
-        qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG);
         fprintf(stderr, "watchdog: timer fired\n");
         break;
 
     case WATCHDOG_ACTION_NONE:
-        qapi_event_send_watchdog(WATCHDOG_ACTION_NONE, &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_NONE);
         break;
 
     case WATCHDOG_ACTION_INJECT_NMI:
-        qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI,
-                                 &error_abort);
+        qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
         nmi_monitor_handle(0, NULL);
         break;
 
diff --git a/include/qapi/qmp-event.h b/include/qapi/qmp-event.h
index 0c87ad833e..23e588ccf8 100644
--- a/include/qapi/qmp-event.h
+++ b/include/qapi/qmp-event.h
@@ -14,8 +14,7 @@
 #ifndef QMP_EVENT_H
 #define QMP_EVENT_H
 
-
-typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict, Error **errp);
+typedef void (*QMPEventFuncEmit)(unsigned event, QDict *dict);
 
 void qmp_event_set_func_emit(QMPEventFuncEmit emit);
 
diff --git a/job.c b/job.c
index e36ebaafd8..b9ebd1c091 100644
--- a/job.c
+++ b/job.c
@@ -174,7 +174,7 @@ static void job_state_transition(Job *job, JobStatus s1)
     job->status = s1;
 
     if (!job_is_internal(job) && s1 != s0) {
-        qapi_event_send_job_status_change(job->id, job->status, &error_abort);
+        qapi_event_send_job_status_change(job->id, job->status);
     }
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 4b316ec343..05d0a7296a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -204,7 +204,7 @@ void migration_incoming_state_destroy(void)
 static void migrate_generate_event(int new_state)
 {
     if (migrate_use_events()) {
-        qapi_event_send_migration(new_state, &error_abort);
+        qapi_event_send_migration(new_state);
     }
 }
 
@@ -302,7 +302,7 @@ void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
 
-    qapi_event_send_migration(MIGRATION_STATUS_SETUP, &error_abort);
+    qapi_event_send_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
diff --git a/migration/ram.c b/migration/ram.c
index 79c89425a3..f6fd8e5e09 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1670,7 +1670,7 @@ static void migration_bitmap_sync(RAMState *rs)
         rs->bytes_xfer_prev = bytes_xfer_now;
     }
     if (migrate_use_events()) {
-        qapi_event_send_migration_pass(ram_counters.dirty_sync_count, NULL);
+        qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
     }
 }
 
diff --git a/monitor.c b/monitor.c
index 021c11b1bf..2cdf243c0c 100644
--- a/monitor.c
+++ b/monitor.c
@@ -688,7 +688,7 @@ monitor_qapi_event_queue_no_reenter(QAPIEvent event, QDict *qdict)
 }
 
 static void
-monitor_qapi_event_queue(QAPIEvent event, QDict *qdict, Error **errp)
+monitor_qapi_event_queue(QAPIEvent event, QDict *qdict)
 {
     /*
      * monitor_qapi_event_queue_no_reenter() is not reentrant: it
@@ -4316,8 +4316,7 @@ static void handle_qmp_command(void *opaque, QObject *req, Error *err)
              * that command was dropped.
              */
             qapi_event_send_command_dropped(id,
-                                            COMMAND_DROP_REASON_QUEUE_FULL,
-                                            &error_abort);
+                                            COMMAND_DROP_REASON_QUEUE_FULL);
             qmp_request_free(req_obj);
             return;
         }
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index 764ef177ab..2ed7902424 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -18,7 +18,7 @@ from qapi.common import *
 def build_event_send_proto(name, arg_type, boxed):
     return 'void qapi_event_send_%(c_name)s(%(param)s)' % {
         'c_name': c_name(name.lower()),
-        'param': build_params(arg_type, boxed, 'Error **errp')}
+        'param': build_params(arg_type, boxed)}
 
 
 def gen_event_send_decl(name, arg_type, boxed):
@@ -70,7 +70,6 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
 %(proto)s
 {
     QDict *qmp;
-    Error *err = NULL;
     QMPEventFuncEmit emit;
 ''',
                 proto=build_event_send_proto(name, arg_type, boxed))
@@ -103,45 +102,35 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
 ''')
         if not arg_type.is_implicit():
             ret += mcgen('''
-    visit_type_%(c_name)s(v, "%(name)s", &arg, &err);
+    visit_type_%(c_name)s(v, "%(name)s", &arg, &error_abort);
 ''',
                          name=name, c_name=arg_type.c_name())
         else:
             ret += mcgen('''
 
-    visit_start_struct(v, "%(name)s", NULL, 0, &err);
-    if (err) {
-        goto out;
-    }
-    visit_type_%(c_name)s_members(v, &param, &err);
-    if (!err) {
-        visit_check_struct(v, &err);
-    }
+    visit_start_struct(v, "%(name)s", NULL, 0, &error_abort);
+    visit_type_%(c_name)s_members(v, &param, &error_abort);
+    visit_check_struct(v, &error_abort);
     visit_end_struct(v, NULL);
 ''',
                          name=name, c_name=arg_type.c_name())
         ret += mcgen('''
-    if (err) {
-        goto out;
-    }
 
     visit_complete(v, &obj);
     qdict_put_obj(qmp, "data", obj);
 ''')
 
     ret += mcgen('''
-    emit(%(c_enum)s, qmp, &err);
+    emit(%(c_enum)s, qmp);
 
 ''',
                  c_enum=c_enum_const(event_enum_name, name))
 
     if arg_type and not arg_type.is_empty():
         ret += mcgen('''
-out:
     visit_free(v);
 ''')
     ret += mcgen('''
-    error_propagate(errp, err);
     qobject_unref(qmp);
 }
 ''')
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index 3027dde60d..438380fced 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -44,8 +44,7 @@ static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
     char *id = object_get_canonical_path_component(OBJECT(pr_mgr));
 
     if (id) {
-        qapi_event_send_pr_manager_status_changed(id, !!pr_mgr->ioc,
-                                                  &error_abort);
+        qapi_event_send_pr_manager_status_changed(id, !!pr_mgr->ioc);
         g_free(id);
     }
 }
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 8677094ad1..9cddd72adb 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -95,7 +95,7 @@ static bool qdict_cmp_simple(QDict *a, QDict *b)
 
 /* This function is hooked as final emit function, which can verify the
    correctness. */
-static void event_test_emit(test_QAPIEvent event, QDict *d, Error **errp)
+static void event_test_emit(test_QAPIEvent event, QDict *d)
 {
     QDict *t;
     int64_t s, ms;
@@ -156,7 +156,7 @@ static void test_event_a(TestEventData *data,
     QDict *d;
     d = data->expect;
     qdict_put_str(d, "event", "EVENT_A");
-    qapi_event_send_event_a(&error_abort);
+    qapi_event_send_event_a();
 }
 
 static void test_event_b(TestEventData *data,
@@ -165,7 +165,7 @@ static void test_event_b(TestEventData *data,
     QDict *d;
     d = data->expect;
     qdict_put_str(d, "event", "EVENT_B");
-    qapi_event_send_event_b(&error_abort);
+    qapi_event_send_event_b();
 }
 
 static void test_event_c(TestEventData *data,
@@ -191,7 +191,7 @@ static void test_event_c(TestEventData *data,
     qdict_put_str(d, "event", "EVENT_C");
     qdict_put(d, "data", d_data);
 
-    qapi_event_send_event_c(true, 1, true, &b, "test2", &error_abort);
+    qapi_event_send_event_c(true, 1, true, &b, "test2");
 
     g_free(b.string);
 }
@@ -233,8 +233,7 @@ static void test_event_d(TestEventData *data,
     qdict_put_str(d, "event", "EVENT_D");
     qdict_put(d, "data", d_data);
 
-    qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE3,
-                           &error_abort);
+    qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE3);
 
     g_free(struct1.string);
     g_free(a.string);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index f8c0878529..a4fbbc3898 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -218,8 +218,7 @@ static void channel_event(int event, SpiceChannelEventInfo *info)
     switch (event) {
     case SPICE_CHANNEL_EVENT_CONNECTED:
         qapi_event_send_spice_connected(qapi_SpiceServerInfo_base(server),
-                                        qapi_SpiceChannel_base(client),
-                                        &error_abort);
+                                        qapi_SpiceChannel_base(client));
         break;
     case SPICE_CHANNEL_EVENT_INITIALIZED:
         if (auth) {
@@ -228,13 +227,12 @@ static void channel_event(int event, SpiceChannelEventInfo *info)
         }
         add_channel_info(client, info);
         channel_list_add(info);
-        qapi_event_send_spice_initialized(server, client, &error_abort);
+        qapi_event_send_spice_initialized(server, client);
         break;
     case SPICE_CHANNEL_EVENT_DISCONNECTED:
         channel_list_del(info);
         qapi_event_send_spice_disconnected(qapi_SpiceServerInfo_base(server),
-                                           qapi_SpiceChannel_base(client),
-                                           &error_abort);
+                                           qapi_SpiceChannel_base(client));
         break;
     default:
         break;
@@ -287,7 +285,7 @@ static void migrate_connect_complete_cb(SpiceMigrateInstance *sin)
 
 static void migrate_end_complete_cb(SpiceMigrateInstance *sin)
 {
-    qapi_event_send_spice_migrate_completed(&error_abort);
+    qapi_event_send_spice_migrate_completed();
     spice_migration_completed = true;
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index ccb1335d86..916a16d312 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -296,14 +296,13 @@ static void vnc_qmp_event(VncState *vs, QAPIEvent event)
 
     switch (event) {
     case QAPI_EVENT_VNC_CONNECTED:
-        qapi_event_send_vnc_connected(si, qapi_VncClientInfo_base(vs->info),
-                                      &error_abort);
+        qapi_event_send_vnc_connected(si, qapi_VncClientInfo_base(vs->info));
         break;
     case QAPI_EVENT_VNC_INITIALIZED:
-        qapi_event_send_vnc_initialized(si, vs->info, &error_abort);
+        qapi_event_send_vnc_initialized(si, vs->info);
         break;
     case QAPI_EVENT_VNC_DISCONNECTED:
-        qapi_event_send_vnc_disconnected(si, vs->info, &error_abort);
+        qapi_event_send_vnc_disconnected(si, vs->info);
         break;
     default:
         break;
diff --git a/vl.c b/vl.c
index 5ba06adf78..10dd690e30 100644
--- a/vl.c
+++ b/vl.c
@@ -1647,8 +1647,7 @@ void qemu_system_reset(ShutdownCause reason)
         qemu_devices_reset();
     }
     if (reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
-        qapi_event_send_reset(shutdown_caused_by_guest(reason),
-                              &error_abort);
+        qapi_event_send_reset(shutdown_caused_by_guest(reason));
     }
     cpu_synchronize_all_post_reset();
 }
@@ -1661,11 +1660,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
         current_cpu->crash_occurred = true;
     }
     qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
-                                   !!info, info, &error_abort);
+                                   !!info, info);
     vm_stop(RUN_STATE_GUEST_PANICKED);
     if (!no_shutdown) {
         qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
-                                       !!info, info, &error_abort);
+                                       !!info, info);
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_PANIC);
     }
 
@@ -1706,7 +1705,7 @@ static void qemu_system_suspend(void)
     pause_all_vcpus();
     notifier_list_notify(&suspend_notifiers, NULL);
     runstate_set(RUN_STATE_SUSPENDED);
-    qapi_event_send_suspend(&error_abort);
+    qapi_event_send_suspend();
 }
 
 void qemu_system_suspend_request(void)
@@ -1776,7 +1775,7 @@ void qemu_system_shutdown_request(ShutdownCause reason)
 
 static void qemu_system_powerdown(void)
 {
-    qapi_event_send_powerdown(&error_abort);
+    qapi_event_send_powerdown();
     notifier_list_notify(&powerdown_notifiers, NULL);
 }
 
@@ -1819,8 +1818,7 @@ static bool main_loop_should_exit(void)
     request = qemu_shutdown_requested();
     if (request) {
         qemu_kill_report();
-        qapi_event_send_shutdown(shutdown_caused_by_guest(request),
-                                 &error_abort);
+        qapi_event_send_shutdown(shutdown_caused_by_guest(request));
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
@@ -1843,7 +1841,7 @@ static bool main_loop_should_exit(void)
         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
         resume_all_vcpus();
-        qapi_event_send_wakeup(&error_abort);
+        qapi_event_send_wakeup();
     }
     if (qemu_powerdown_requested()) {
         qemu_system_powerdown();
-- 
2.17.1
