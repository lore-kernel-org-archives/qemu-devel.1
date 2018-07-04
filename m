Received: from eggs.gnu.org ([2001:4830:134:3::10]:50828)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoO-0004f9-Q4
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:11:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fadoL-00019j-TU
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:56 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51792 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fadoL-00018x-Lw
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 05:10:53 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 57699406C7A9
	for <qemu-devel@nongnu.org>; Wed,  4 Jul 2018 09:10:53 +0000 (UTC)
From: Peter Xu <peterx@redhat.com>
Date: Wed,  4 Jul 2018 17:10:38 +0800
Message-Id: <20180704091038.29449-4-peterx@redhat.com>
In-Reply-To: <20180704091038.29449-1-peterx@redhat.com>
References: <20180704091038.29449-1-peterx@redhat.com>
Subject: [Qemu-devel] [RFC 3/3] qapi: provide send/bcast interface for events
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com

In the past we were always sending events to all the monitors.  In this
patch we introduce a new interface to send an event to a specific
monitor instance, meanwhile renaming the old function from "send" to
"bcast".  So for each event, now we have:

- qapi_event_send_xxx(Monitor *mon, ...) to send events to a monitor, or
- qapi_event_bcast_xxx(...) to send events to all the monitors.

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 block/block-backend.c      |  6 +++---
 block/qcow2.c              |  2 +-
 block/quorum.c             |  4 ++--
 block/write-threshold.c    |  2 +-
 blockjob.c                 | 10 +++++-----
 cpus.c                     |  8 ++++----
 dump.c                     |  2 +-
 hw/acpi/core.c             |  2 +-
 hw/acpi/cpu.c              |  2 +-
 hw/acpi/memory_hotplug.c   |  4 ++--
 hw/char/virtio-console.c   |  2 +-
 hw/core/qdev.c             |  2 +-
 hw/net/virtio-net.c        |  2 +-
 hw/ppc/spapr_rtc.c         |  2 +-
 hw/timer/mc146818rtc.c     |  2 +-
 hw/virtio/virtio-balloon.c |  2 +-
 hw/watchdog/watchdog.c     | 14 +++++++-------
 job.c                      |  2 +-
 migration/migration.c      |  4 ++--
 migration/ram.c            |  2 +-
 scsi/pr-manager-helper.c   |  2 +-
 tests/test-qmp-event.c     |  8 ++++----
 ui/spice-core.c            |  8 ++++----
 ui/vnc.c                   |  6 +++---
 vl.c                       | 14 +++++++-------
 scripts/qapi/common.py     | 16 ++++++++++++++--
 scripts/qapi/events.py     | 27 ++++++++++++++++++++-------
 27 files changed, 91 insertions(+), 66 deletions(-)

diff --git a/block/block-backend.c b/block/block-backend.c
index 4c24faba18..162e087302 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -980,7 +980,7 @@ void blk_dev_change_media_cb(BlockBackend *blk, bool load, Error **errp)
 
         if (tray_was_open != tray_is_open) {
             char *id = blk_get_attached_dev_id(blk);
-            qapi_event_send_device_tray_moved(blk_name(blk), id, tray_is_open);
+            qapi_event_bcast_device_tray_moved(blk_name(blk), id, tray_is_open);
             g_free(id);
         }
     }
@@ -1661,7 +1661,7 @@ static void send_qmp_error_event(BlockBackend *blk,
     BlockDriverState *bs = blk_bs(blk);
 
     optype = is_read ? IO_OPERATION_TYPE_READ : IO_OPERATION_TYPE_WRITE;
-    qapi_event_send_block_io_error(blk_name(blk), !!bs,
+    qapi_event_bcast_block_io_error(blk_name(blk), !!bs,
                                    bs ? bdrv_get_node_name(bs) : NULL, optype,
                                    action, blk_iostatus_is_enabled(blk),
                                    error == ENOSPC, strerror(error));
@@ -1779,7 +1779,7 @@ void blk_eject(BlockBackend *blk, bool eject_flag)
     /* Whether or not we ejected on the backend,
      * the frontend experienced a tray event. */
     id = blk_get_attached_dev_id(blk);
-    qapi_event_send_device_tray_moved(blk_name(blk), id,
+    qapi_event_bcast_device_tray_moved(blk_name(blk), id,
                                       eject_flag);
     g_free(id);
 }
diff --git a/block/qcow2.c b/block/qcow2.c
index 0fcf5ae716..4ea2396ca5 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -4566,7 +4566,7 @@ void qcow2_signal_corruption(BlockDriverState *bs, bool fatal, int64_t offset,
     }
 
     node_name = bdrv_get_node_name(bs);
-    qapi_event_send_block_image_corrupted(bdrv_get_device_name(bs),
+    qapi_event_bcast_block_image_corrupted(bdrv_get_device_name(bs),
                                           *node_name != '\0', node_name,
                                           message, offset >= 0, offset,
                                           size >= 0, size,
diff --git a/block/quorum.c b/block/quorum.c
index eb526cc0f1..2e3b4065d6 100644
--- a/block/quorum.c
+++ b/block/quorum.c
@@ -198,7 +198,7 @@ static void quorum_report_bad(QuorumOpType type, uint64_t offset,
         msg = strerror(-ret);
     }
 
-    qapi_event_send_quorum_report_bad(type, !!msg, msg, node_name, start_sector,
+    qapi_event_bcast_quorum_report_bad(type, !!msg, msg, node_name, start_sector,
                                       end_sector - start_sector);
 }
 
@@ -209,7 +209,7 @@ static void quorum_report_failure(QuorumAIOCB *acb)
     int64_t end_sector = DIV_ROUND_UP(acb->offset + acb->bytes,
                                       BDRV_SECTOR_SIZE);
 
-    qapi_event_send_quorum_failure(reference, start_sector,
+    qapi_event_bcast_quorum_failure(reference, start_sector,
                                    end_sector - start_sector);
 }
 
diff --git a/block/write-threshold.c b/block/write-threshold.c
index 85b78dc2a9..c54cb8adf7 100644
--- a/block/write-threshold.c
+++ b/block/write-threshold.c
@@ -60,7 +60,7 @@ static int coroutine_fn before_write_notify(NotifierWithReturn *notifier,
 
     amount = bdrv_write_threshold_exceeded(bs, req);
     if (amount > 0) {
-        qapi_event_send_block_write_threshold(
+        qapi_event_bcast_block_write_threshold(
             bs->node_name,
             amount,
             bs->write_threshold_offset);
diff --git a/blockjob.c b/blockjob.c
index bf7ef48f98..2f71242ae0 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -311,7 +311,7 @@ static void block_job_event_cancelled(Notifier *n, void *opaque)
         return;
     }
 
-    qapi_event_send_block_job_cancelled(job_type(&job->job),
+    qapi_event_bcast_block_job_cancelled(job_type(&job->job),
                                         job->job.id,
                                         job->job.progress_total,
                                         job->job.progress_current,
@@ -331,7 +331,7 @@ static void block_job_event_completed(Notifier *n, void *opaque)
         msg = strerror(-job->job.ret);
     }
 
-    qapi_event_send_block_job_completed(job_type(&job->job),
+    qapi_event_bcast_block_job_completed(job_type(&job->job),
                                         job->job.id,
                                         job->job.progress_total,
                                         job->job.progress_current,
@@ -348,7 +348,7 @@ static void block_job_event_pending(Notifier *n, void *opaque)
         return;
     }
 
-    qapi_event_send_block_job_pending(job_type(&job->job),
+    qapi_event_bcast_block_job_pending(job_type(&job->job),
                                       job->job.id);
 }
 
@@ -360,7 +360,7 @@ static void block_job_event_ready(Notifier *n, void *opaque)
         return;
     }
 
-    qapi_event_send_block_job_ready(job_type(&job->job),
+    qapi_event_bcast_block_job_ready(job_type(&job->job),
                                     job->job.id,
                                     job->job.progress_total,
                                     job->job.progress_current,
@@ -488,7 +488,7 @@ BlockErrorAction block_job_error_action(BlockJob *job, BlockdevOnError on_err,
         abort();
     }
     if (!block_job_is_internal(job)) {
-        qapi_event_send_block_job_error(job->job.id,
+        qapi_event_bcast_block_job_error(job->job.id,
                                         is_read ? IO_OPERATION_TYPE_READ :
                                         IO_OPERATION_TYPE_WRITE,
                                         action);
diff --git a/cpus.c b/cpus.c
index 488a2b5c62..dfb49656cd 100644
--- a/cpus.c
+++ b/cpus.c
@@ -1011,7 +1011,7 @@ static int do_vm_stop(RunState state, bool send_stop)
         runstate_set(state);
         vm_state_notify(0, state);
         if (send_stop) {
-            qapi_event_send_stop();
+            qapi_event_bcast_stop();
         }
     }
 
@@ -2059,13 +2059,13 @@ int vm_prepare_start(void)
      * the STOP event.
      */
     if (runstate_is_running()) {
-        qapi_event_send_stop();
-        qapi_event_send_resume();
+        qapi_event_bcast_stop();
+        qapi_event_bcast_resume();
         return -1;
     }
 
     /* We are sending this now, but the CPUs will be resumed shortly later */
-    qapi_event_send_resume();
+    qapi_event_bcast_resume();
 
     replay_enable_events();
     cpu_enable_ticks();
diff --git a/dump.c b/dump.c
index 2d8f6b3231..a0655e6429 100644
--- a/dump.c
+++ b/dump.c
@@ -1889,7 +1889,7 @@ static void dump_process(DumpState *s, Error **errp)
     result = qmp_query_dump(NULL);
     /* should never fail */
     assert(result);
-    qapi_event_send_dump_completed(result, !!local_err, (local_err ? \
+    qapi_event_bcast_dump_completed(result, !!local_err, (local_err ? \
                                    error_get_pretty(local_err) : NULL));
     qapi_free_DumpQueryResult(result);
 
diff --git a/hw/acpi/core.c b/hw/acpi/core.c
index aafdc61648..d93446a144 100644
--- a/hw/acpi/core.c
+++ b/hw/acpi/core.c
@@ -570,7 +570,7 @@ static void acpi_pm1_cnt_write(ACPIREGS *ar, uint16_t val)
             break;
         default:
             if (sus_typ == ar->pm1.cnt.s4_val) { /* S4 request */
-                qapi_event_send_suspend_disk();
+                qapi_event_bcast_suspend_disk();
                 qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
             }
             break;
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index d19b7722f0..f38ef7e551 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -160,7 +160,7 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
            cdev = &cpu_st->devs[cpu_st->selector];
            cdev->ost_status = data;
            info = acpi_cpu_device_status(cpu_st->selector, cdev);
-           qapi_event_send_acpi_device_ost(info);
+           qapi_event_bcast_acpi_device_ost(info);
            qapi_free_ACPIOSTInfo(info);
            trace_cpuhp_acpi_write_ost_status(cpu_st->selector,
                                              cdev->ost_status);
diff --git a/hw/acpi/memory_hotplug.c b/hw/acpi/memory_hotplug.c
index 8c7c1013f3..85c5ee1a86 100644
--- a/hw/acpi/memory_hotplug.c
+++ b/hw/acpi/memory_hotplug.c
@@ -161,7 +161,7 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
         /* TODO: implement memory removal on guest signal */
 
         info = acpi_memory_device_status(mem_st->selector, mdev);
-        qapi_event_send_acpi_device_ost(info);
+        qapi_event_bcast_acpi_device_ost(info);
         qapi_free_ACPIOSTInfo(info);
         break;
     case 0x14: /* set is_* fields  */
@@ -184,7 +184,7 @@ static void acpi_memory_hotplug_write(void *opaque, hwaddr addr, uint64_t data,
             hotplug_handler_unplug(hotplug_ctrl, dev, &local_err);
             if (local_err) {
                 trace_mhp_acpi_pc_dimm_delete_failed(mem_st->selector);
-                qapi_event_send_mem_unplug_error(dev->id,
+                qapi_event_bcast_mem_unplug_error(dev->id,
                                                  error_get_pretty(local_err));
                 error_free(local_err);
                 break;
diff --git a/hw/char/virtio-console.c b/hw/char/virtio-console.c
index 2cbe1d4ed5..9f7b276cac 100644
--- a/hw/char/virtio-console.c
+++ b/hw/char/virtio-console.c
@@ -114,7 +114,7 @@ static void set_guest_connected(VirtIOSerialPort *port, int guest_connected)
     }
 
     if (dev->id) {
-        qapi_event_send_vserport_change(dev->id, guest_connected);
+        qapi_event_bcast_vserport_change(dev->id, guest_connected);
     }
 }
 
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index 9cdef2ed98..09299af537 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -996,7 +996,7 @@ static void device_finalize(Object *obj)
     if (dev->pending_deleted_event) {
         g_assert(dev->canonical_path);
 
-        qapi_event_send_device_deleted(!!dev->id, dev->id, dev->canonical_path);
+        qapi_event_bcast_device_deleted(!!dev->id, dev->id, dev->canonical_path);
         g_free(dev->canonical_path);
         dev->canonical_path = NULL;
     }
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4bdd5b8532..b4a29c9d88 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -328,7 +328,7 @@ static void rxfilter_notify(NetClientState *nc)
 
     if (nc->rxfilter_notify_enabled) {
         gchar *path = object_get_canonical_path(OBJECT(n->qdev));
-        qapi_event_send_nic_rx_filter_changed(!!n->netclient_name,
+        qapi_event_bcast_nic_rx_filter_changed(!!n->netclient_name,
                                               n->netclient_name, path);
         g_free(path);
 
diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
index cd049f389d..5cedc8bf87 100644
--- a/hw/ppc/spapr_rtc.c
+++ b/hw/ppc/spapr_rtc.c
@@ -118,7 +118,7 @@ static void rtas_set_time_of_day(PowerPCCPU *cpu, sPAPRMachineState *spapr,
     }
 
     /* Generate a monitor event for the change */
-    qapi_event_send_rtc_change(qemu_timedate_diff(&tm));
+    qapi_event_bcast_rtc_change(qemu_timedate_diff(&tm));
 
     host_ns = qemu_clock_get_ns(rtc_clock);
 
diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index b941aa1966..9819acd3c6 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -635,7 +635,7 @@ static void rtc_set_time(RTCState *s)
     s->base_rtc = mktimegm(&tm);
     s->last_update = qemu_clock_get_ns(rtc_clock);
 
-    qapi_event_send_rtc_change(qemu_timedate_diff(&tm));
+    qapi_event_bcast_rtc_change(qemu_timedate_diff(&tm));
 }
 
 static void rtc_set_cmos(RTCState *s, const struct tm *tm)
diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index fcd41d314e..628c17c1ed 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -366,7 +366,7 @@ static void virtio_balloon_set_config(VirtIODevice *vdev,
     memcpy(&config, config_data, sizeof(struct virtio_balloon_config));
     dev->actual = le32_to_cpu(config.actual);
     if (dev->actual != oldactual) {
-        qapi_event_send_balloon_change(vm_ram_size -
+        qapi_event_bcast_balloon_change(vm_ram_size -
                         ((ram_addr_t) dev->actual << VIRTIO_BALLOON_PFN_SHIFT));
     }
     trace_virtio_balloon_set_config(dev->actual, oldactual);
diff --git a/hw/watchdog/watchdog.c b/hw/watchdog/watchdog.c
index 33e6c20184..f945047221 100644
--- a/hw/watchdog/watchdog.c
+++ b/hw/watchdog/watchdog.c
@@ -102,17 +102,17 @@ void watchdog_perform_action(void)
 {
     switch (watchdog_action) {
     case WATCHDOG_ACTION_RESET:     /* same as 'system_reset' in monitor */
-        qapi_event_send_watchdog(WATCHDOG_ACTION_RESET);
+        qapi_event_bcast_watchdog(WATCHDOG_ACTION_RESET);
         qemu_system_reset_request(SHUTDOWN_CAUSE_GUEST_RESET);
         break;
 
     case WATCHDOG_ACTION_SHUTDOWN:  /* same as 'system_powerdown' in monitor */
-        qapi_event_send_watchdog(WATCHDOG_ACTION_SHUTDOWN);
+        qapi_event_bcast_watchdog(WATCHDOG_ACTION_SHUTDOWN);
         qemu_system_powerdown_request();
         break;
 
     case WATCHDOG_ACTION_POWEROFF:  /* same as 'quit' command in monitor */
-        qapi_event_send_watchdog(WATCHDOG_ACTION_POWEROFF);
+        qapi_event_bcast_watchdog(WATCHDOG_ACTION_POWEROFF);
         exit(0);
 
     case WATCHDOG_ACTION_PAUSE:     /* same as 'stop' command in monitor */
@@ -120,21 +120,21 @@ void watchdog_perform_action(void)
          * you would get a deadlock.  Bypass the problem.
          */
         qemu_system_vmstop_request_prepare();
-        qapi_event_send_watchdog(WATCHDOG_ACTION_PAUSE);
+        qapi_event_bcast_watchdog(WATCHDOG_ACTION_PAUSE);
         qemu_system_vmstop_request(RUN_STATE_WATCHDOG);
         break;
 
     case WATCHDOG_ACTION_DEBUG:
-        qapi_event_send_watchdog(WATCHDOG_ACTION_DEBUG);
+        qapi_event_bcast_watchdog(WATCHDOG_ACTION_DEBUG);
         fprintf(stderr, "watchdog: timer fired\n");
         break;
 
     case WATCHDOG_ACTION_NONE:
-        qapi_event_send_watchdog(WATCHDOG_ACTION_NONE);
+        qapi_event_bcast_watchdog(WATCHDOG_ACTION_NONE);
         break;
 
     case WATCHDOG_ACTION_INJECT_NMI:
-        qapi_event_send_watchdog(WATCHDOG_ACTION_INJECT_NMI);
+        qapi_event_bcast_watchdog(WATCHDOG_ACTION_INJECT_NMI);
         nmi_monitor_handle(0, NULL);
         break;
 
diff --git a/job.c b/job.c
index 03dfc59bcd..88796d6d9a 100644
--- a/job.c
+++ b/job.c
@@ -174,7 +174,7 @@ static void job_state_transition(Job *job, JobStatus s1)
     job->status = s1;
 
     if (!job_is_internal(job) && s1 != s0) {
-        qapi_event_send_job_status_change(job->id, job->status);
+        qapi_event_bcast_job_status_change(job->id, job->status);
     }
 }
 
diff --git a/migration/migration.c b/migration/migration.c
index 728d731433..79851942c9 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -203,7 +203,7 @@ void migration_incoming_state_destroy(void)
 static void migrate_generate_event(int new_state)
 {
     if (migrate_use_events()) {
-        qapi_event_send_migration(new_state);
+        qapi_event_bcast_migration(new_state);
     }
 }
 
@@ -301,7 +301,7 @@ void qemu_start_incoming_migration(const char *uri, Error **errp)
 {
     const char *p;
 
-    qapi_event_send_migration(MIGRATION_STATUS_SETUP);
+    qapi_event_bcast_migration(MIGRATION_STATUS_SETUP);
     if (!strcmp(uri, "defer")) {
         deferred_incoming_migration(errp);
     } else if (strstart(uri, "tcp:", &p)) {
diff --git a/migration/ram.c b/migration/ram.c
index 830406bc4f..68e3308b6b 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -1661,7 +1661,7 @@ static void migration_bitmap_sync(RAMState *rs)
         rs->bytes_xfer_prev = bytes_xfer_now;
     }
     if (migrate_use_events()) {
-        qapi_event_send_migration_pass(ram_counters.dirty_sync_count);
+        qapi_event_bcast_migration_pass(ram_counters.dirty_sync_count);
     }
 }
 
diff --git a/scsi/pr-manager-helper.c b/scsi/pr-manager-helper.c
index fd119bd0c3..7ddc881141 100644
--- a/scsi/pr-manager-helper.c
+++ b/scsi/pr-manager-helper.c
@@ -44,7 +44,7 @@ static void pr_manager_send_status_changed_event(PRManagerHelper *pr_mgr)
     char *id = object_get_canonical_path_component(OBJECT(pr_mgr));
 
     if (id) {
-        qapi_event_send_pr_manager_status_changed(id, !!pr_mgr->ioc);
+        qapi_event_bcast_pr_manager_status_changed(id, !!pr_mgr->ioc);
     }
 }
 
diff --git a/tests/test-qmp-event.c b/tests/test-qmp-event.c
index 8d59d4898e..3a7c4cb0d8 100644
--- a/tests/test-qmp-event.c
+++ b/tests/test-qmp-event.c
@@ -156,7 +156,7 @@ static void test_event_a(TestEventData *data,
     QDict *d;
     d = data->expect;
     qdict_put_str(d, "event", "EVENT_A");
-    qapi_event_send_event_a();
+    qapi_event_bcast_event_a();
 }
 
 static void test_event_b(TestEventData *data,
@@ -165,7 +165,7 @@ static void test_event_b(TestEventData *data,
     QDict *d;
     d = data->expect;
     qdict_put_str(d, "event", "EVENT_B");
-    qapi_event_send_event_b();
+    qapi_event_bcast_event_b();
 }
 
 static void test_event_c(TestEventData *data,
@@ -191,7 +191,7 @@ static void test_event_c(TestEventData *data,
     qdict_put_str(d, "event", "EVENT_C");
     qdict_put(d, "data", d_data);
 
-    qapi_event_send_event_c(true, 1, true, &b, "test2");
+    qapi_event_bcast_event_c(true, 1, true, &b, "test2");
 
     g_free(b.string);
 }
@@ -233,7 +233,7 @@ static void test_event_d(TestEventData *data,
     qdict_put_str(d, "event", "EVENT_D");
     qdict_put(d, "data", d_data);
 
-    qapi_event_send_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE3);
+    qapi_event_bcast_event_d(&a, "test3", false, NULL, true, ENUM_ONE_VALUE3);
 
     g_free(struct1.string);
     g_free(a.string);
diff --git a/ui/spice-core.c b/ui/spice-core.c
index a4fbbc3898..6382efebf1 100644
--- a/ui/spice-core.c
+++ b/ui/spice-core.c
@@ -217,7 +217,7 @@ static void channel_event(int event, SpiceChannelEventInfo *info)
 
     switch (event) {
     case SPICE_CHANNEL_EVENT_CONNECTED:
-        qapi_event_send_spice_connected(qapi_SpiceServerInfo_base(server),
+        qapi_event_bcast_spice_connected(qapi_SpiceServerInfo_base(server),
                                         qapi_SpiceChannel_base(client));
         break;
     case SPICE_CHANNEL_EVENT_INITIALIZED:
@@ -227,11 +227,11 @@ static void channel_event(int event, SpiceChannelEventInfo *info)
         }
         add_channel_info(client, info);
         channel_list_add(info);
-        qapi_event_send_spice_initialized(server, client);
+        qapi_event_bcast_spice_initialized(server, client);
         break;
     case SPICE_CHANNEL_EVENT_DISCONNECTED:
         channel_list_del(info);
-        qapi_event_send_spice_disconnected(qapi_SpiceServerInfo_base(server),
+        qapi_event_bcast_spice_disconnected(qapi_SpiceServerInfo_base(server),
                                            qapi_SpiceChannel_base(client));
         break;
     default:
@@ -285,7 +285,7 @@ static void migrate_connect_complete_cb(SpiceMigrateInstance *sin)
 
 static void migrate_end_complete_cb(SpiceMigrateInstance *sin)
 {
-    qapi_event_send_spice_migrate_completed();
+    qapi_event_bcast_spice_migrate_completed();
     spice_migration_completed = true;
 }
 
diff --git a/ui/vnc.c b/ui/vnc.c
index 2345bd054a..e7c1a7da30 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -296,13 +296,13 @@ static void vnc_qmp_event(VncState *vs, QAPIEvent event)
 
     switch (event) {
     case QAPI_EVENT_VNC_CONNECTED:
-        qapi_event_send_vnc_connected(si, qapi_VncClientInfo_base(vs->info));
+        qapi_event_bcast_vnc_connected(si, qapi_VncClientInfo_base(vs->info));
         break;
     case QAPI_EVENT_VNC_INITIALIZED:
-        qapi_event_send_vnc_initialized(si, vs->info);
+        qapi_event_bcast_vnc_initialized(si, vs->info);
         break;
     case QAPI_EVENT_VNC_DISCONNECTED:
-        qapi_event_send_vnc_disconnected(si, vs->info);
+        qapi_event_bcast_vnc_disconnected(si, vs->info);
         break;
     default:
         break;
diff --git a/vl.c b/vl.c
index e087cc1b72..d3ffd0718a 100644
--- a/vl.c
+++ b/vl.c
@@ -1646,7 +1646,7 @@ void qemu_system_reset(ShutdownCause reason)
         qemu_devices_reset();
     }
     if (reason != SHUTDOWN_CAUSE_SUBSYSTEM_RESET) {
-        qapi_event_send_reset(shutdown_caused_by_guest(reason));
+        qapi_event_bcast_reset(shutdown_caused_by_guest(reason));
     }
     cpu_synchronize_all_post_reset();
 }
@@ -1658,11 +1658,11 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
     if (current_cpu) {
         current_cpu->crash_occurred = true;
     }
-    qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
+    qapi_event_bcast_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
                                    !!info, info);
     vm_stop(RUN_STATE_GUEST_PANICKED);
     if (!no_shutdown) {
-        qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
+        qapi_event_bcast_guest_panicked(GUEST_PANIC_ACTION_POWEROFF,
                                        !!info, info);
         qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_PANIC);
     }
@@ -1704,7 +1704,7 @@ static void qemu_system_suspend(void)
     pause_all_vcpus();
     notifier_list_notify(&suspend_notifiers, NULL);
     runstate_set(RUN_STATE_SUSPENDED);
-    qapi_event_send_suspend();
+    qapi_event_bcast_suspend();
 }
 
 void qemu_system_suspend_request(void)
@@ -1774,7 +1774,7 @@ void qemu_system_shutdown_request(ShutdownCause reason)
 
 static void qemu_system_powerdown(void)
 {
-    qapi_event_send_powerdown();
+    qapi_event_bcast_powerdown();
     notifier_list_notify(&powerdown_notifiers, NULL);
 }
 
@@ -1817,7 +1817,7 @@ static bool main_loop_should_exit(void)
     request = qemu_shutdown_requested();
     if (request) {
         qemu_kill_report();
-        qapi_event_send_shutdown(shutdown_caused_by_guest(request));
+        qapi_event_bcast_shutdown(shutdown_caused_by_guest(request));
         if (no_shutdown) {
             vm_stop(RUN_STATE_SHUTDOWN);
         } else {
@@ -1840,7 +1840,7 @@ static bool main_loop_should_exit(void)
         notifier_list_notify(&wakeup_notifiers, &wakeup_reason);
         wakeup_reason = QEMU_WAKEUP_REASON_NONE;
         resume_all_vcpus();
-        qapi_event_send_wakeup();
+        qapi_event_bcast_wakeup();
     }
     if (qemu_powerdown_requested()) {
         qemu_system_powerdown();
diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 105c82742f..248008f7c6 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -1960,10 +1960,17 @@ extern const QEnumLookup %(c_name)s_lookup;
     return ret
 
 
-def build_params(arg_type, boxed, extra):
+def build_params(arg_type, boxed, extra, prefix=""):
     if not arg_type:
         assert not boxed
-        return extra if extra else "void"
+        if prefix and extra:
+            return "%s, %s" % (prefix, extra)
+        elif prefix:
+            return prefix
+        elif extra:
+            return extra
+        else:
+            return "void"
     ret = ''
     sep = ''
     if boxed:
@@ -1978,6 +1985,11 @@ def build_params(arg_type, boxed, extra):
                 ret += 'bool has_%s, ' % c_name(memb.name)
             ret += '%s %s' % (memb.type.c_param_type(),
                               c_name(memb.name))
+    if prefix:
+        if not ret:
+            ret = prefix
+        else:
+            ret = prefix + sep + ret
     if extra:
         ret += sep + extra
     return ret if ret else "void"
diff --git a/scripts/qapi/events.py b/scripts/qapi/events.py
index fec0168af7..6e0f528207 100644
--- a/scripts/qapi/events.py
+++ b/scripts/qapi/events.py
@@ -15,18 +15,31 @@ See the COPYING file in the top-level directory.
 from qapi.common import *
 
 
-def build_event_send_proto(name, arg_type, boxed):
-    return 'void qapi_event_send_%(c_name)s(%(param)s)' % {
+def build_event_proto_name(name, op):
+    return 'qapi_event_%(op)s_%(c_name)s' % {
         'c_name': c_name(name.lower()),
-        'param': build_params(arg_type, boxed, "")}
+        'op': op}
+
+def build_event_proto_internal(name, arg_type, boxed):
+    return 'void %(protoname)s(%(param)s)' % {
+        'protoname': build_event_proto_name(name, "send_internal"),
+        'param': build_params(arg_type, boxed, "", prefix="Monitor *mon")}
 
 
 def gen_event_send_decl(name, arg_type, boxed):
     return mcgen('''
 
-%(proto)s;
+
+%(int_proto)s;
+#define %(send)s(mon, ...) \\
+    do { %(internal)s(mon, ## __VA_ARGS__); } while (0)
+#define %(bcast)s(...) \\
+    do { %(internal)s(NULL, ## __VA_ARGS__); } while (0)
 ''',
-                 proto=build_event_send_proto(name, arg_type, boxed))
+                 int_proto=build_event_proto_internal(name, arg_type, boxed),
+                 send=build_event_proto_name(name, "send"),
+                 bcast=build_event_proto_name(name, "bcast"),
+                 internal=build_event_proto_name(name, "send_internal"))
 
 
 # Declare and initialize an object 'qapi' using parameters from build_params()
@@ -72,7 +85,7 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
     QDict *qmp;
     QMPEventFuncEmit emit;
 ''',
-                proto=build_event_send_proto(name, arg_type, boxed))
+                proto=build_event_proto_internal(name, arg_type, boxed))
 
     if arg_type and not arg_type.is_empty():
         ret += mcgen('''
@@ -121,7 +134,7 @@ def gen_event_send(name, arg_type, boxed, event_enum_name):
 ''')
 
     ret += mcgen('''
-    emit(NULL, %(c_enum)s, qmp);
+    emit(mon, %(c_enum)s, qmp);
 
 ''',
                  c_enum=c_enum_const(event_enum_name, name))
-- 
2.17.1
