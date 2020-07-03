Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7CF6C433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:39:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B2BC2073E
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:39:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B2BC2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ucloud.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39742 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrIAU-0004vt-VA
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:39:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <owen.si@ucloud.cn>) id 1jrI9t-0004Hb-HO
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:39:01 -0400
Received: from m9785.mail.qiye.163.com ([220.181.97.85]:61376)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <owen.si@ucloud.cn>) id 1jrI9n-0005cs-GU
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:39:00 -0400
Received: from localhost.localdomain (unknown [106.75.220.3])
 by m9785.mail.qiye.163.com (Hmail) with ESMTPA id DE2BE5C161B
 for <qemu-devel@nongnu.org>; Fri,  3 Jul 2020 17:29:00 +0800 (CST)
From: Bingsong Si <owen.si@ucloud.cn>
To: qemu-devel@nongnu.org
Subject: [PATCH] ram: add support for dirty page tracking
Date: Fri,  3 Jul 2020 17:28:53 +0800
Message-Id: <20200703092853.1448582-1-owen.si@ucloud.cn>
X-Mailer: git-send-email 2.18.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVITUhCQkJDT0hOQkxPSllXWShZQU
 lCN1dZLVlBSVdZDwkaFQgSH1lBWR0iNQs4HDlIDQMfGFANTh4BEhUzOhxWVlVMSUsoSVlXWQkOFx
 4IWUFZNTQpNjo3JCkuNz5ZV1kWGg8SFR0UWUFZNDBZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Pgw6NBw6Lj8aGBRDShMWCk5C
 Qw0wChdVSlVKTkJITE1DTk9KSEpLVTMWGhIXVRQMHhVVCBI7DhgXFA4fVRgVRVlXWRILWUFZSktN
 VUxOVUlJS1VIWVdZCAFZQUJISUo3Bg++
X-HM-Tid: 0a731401fb092087kuqyde2be5c161b
Received-SPF: pass client-ip=220.181.97.85; envelope-from=owen.si@ucloud.cn;
 helo=m9785.mail.qiye.163.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 05:29:02
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In production, the VM with insentive memory activity maybe failed to migrate,
because of the change of memory in the VM greater than the throughtput of the
network interface, and we want to identify it before migration.

1. dirty tracking start:
virsh qemu-monitor-command <domain> --hmp dirty_track

2. wait some time, stop dirty tracking:
virsh qemu-monitor-command <domain> --hmp dirty_track_stop
Dirty rate: 607 pages/s

Signed-off-by: Bingsong Si <owen.si@ucloud.cn>
---
 hmp-commands.hx       | 26 ++++++++++++++
 include/monitor/hmp.h |  2 ++
 migration/migration.c |  5 +++
 migration/ram.c       | 65 +++++++++++++++++++++++++++++++++
 migration/ram.h       |  5 +++
 migration/savevm.c    | 83 +++++++++++++++++++++++++++++++++++++++++++
 migration/savevm.h    |  2 ++
 7 files changed, 188 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 60f395c276..05a688286b 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1819,6 +1819,32 @@ SRST
   Set QOM property *property* of object at location *path* to value *value*
 ERST
 
+    {
+        .name       = "dirty_track",
+        .args_type  = "",
+        .params     = "",
+        .help       = "track dirty pages rate",
+        .cmd        = hmp_dirty_track,
+    },
+
+SRST
+``dirty_track``
+  Track dirty pages rate.
+ERST
+
+    {
+        .name       = "dirty_track_stop",
+        .args_type  = "",
+        .params     = "",
+        .help       = "stop current dirty pages track",
+        .cmd        = hmp_dirty_track_stop,
+    },
+
+SRST
+``dirty_track_stop``
+  Stop current dirty pages track.
+ERST
+
     {
         .name       = "info",
         .args_type  = "item:s?",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index c986cfd28b..c139fe8758 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -130,5 +130,7 @@ void hmp_hotpluggable_cpus(Monitor *mon, const QDict *qdict);
 void hmp_info_vm_generation_id(Monitor *mon, const QDict *qdict);
 void hmp_info_memory_size_summary(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
+void hmp_dirty_track(Monitor *mon, const QDict *qdict);
+void hmp_dirty_track_stop(Monitor *mon, const QDict *qdict);
 
 #endif
diff --git a/migration/migration.c b/migration/migration.c
index 481a590f72..5550afafe6 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1964,6 +1964,11 @@ static bool migrate_prepare(MigrationState *s, bool blk, bool blk_inc,
 {
     Error *local_err = NULL;
 
+    if (dirty_track_is_running()) {
+        error_setg(errp, "There is a dirty tracking process in progress");
+        return false;
+    }
+
     if (resume) {
         if (s->state != MIGRATION_STATUS_POSTCOPY_PAUSED) {
             error_setg(errp, "Cannot resume if there is no "
diff --git a/migration/ram.c b/migration/ram.c
index 069b6e30bc..03a5e44617 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3780,6 +3780,71 @@ static int ram_resume_prepare(MigrationState *s, void *opaque)
     return 0;
 }
 
+void dirty_track_init(void)
+{
+    RAMBlock *block;
+
+    if (ram_bytes_total()) {
+        RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+            unsigned long pages = block->max_length >> TARGET_PAGE_BITS;
+
+            block->bmap = bitmap_new(pages);
+            bitmap_set(block->bmap, 0, pages);
+        }
+    }
+    ram_state = g_new0(RAMState, 1);
+    ram_state->migration_dirty_pages = 0;
+    memory_global_dirty_log_start();
+}
+
+uint64_t dirty_track_dirty_pages(void)
+{
+    return ram_state->migration_dirty_pages;
+}
+
+void dirty_track_sync(void)
+{
+    RAMBlock *block = NULL;
+    unsigned long offset = 0;
+
+    memory_global_dirty_log_sync();
+    rcu_read_lock();
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+       ramblock_sync_dirty_bitmap(ram_state, block);
+    }
+    rcu_read_unlock();
+
+    rcu_read_lock();
+    block = QLIST_FIRST_RCU(&ram_list.blocks);
+
+    while (block) {
+        offset = migration_bitmap_find_dirty(ram_state, block, offset);
+
+        if (offset << TARGET_PAGE_BITS >= block->used_length) {
+            offset = 0;
+            block = QLIST_NEXT_RCU(block, next);
+        } else {
+            test_and_clear_bit(offset, block->bmap);
+        }
+    }
+
+    rcu_read_unlock();
+}
+
+void dirty_track_cleanup(void)
+{
+    RAMBlock *block;
+
+    memory_global_dirty_log_stop();
+    RAMBLOCK_FOREACH_NOT_IGNORED(block) {
+        g_free(block->bmap);
+        block->bmap = NULL;
+    }
+
+    g_free(ram_state);
+    ram_state = NULL;
+}
+
 static SaveVMHandlers savevm_ram_handlers = {
     .save_setup = ram_save_setup,
     .save_live_iterate = ram_save_iterate,
diff --git a/migration/ram.h b/migration/ram.h
index 2eeaacfa13..104c48285c 100644
--- a/migration/ram.h
+++ b/migration/ram.h
@@ -69,4 +69,9 @@ void colo_flush_ram_cache(void);
 void colo_release_ram_cache(void);
 void colo_incoming_start_dirty_log(void);
 
+void dirty_track_init(void);
+uint64_t dirty_track_dirty_pages(void);
+void dirty_track_sync(void);
+void dirty_track_cleanup(void);
+
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index b979ea6e7f..0be70e6528 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -63,6 +63,8 @@
 #include "migration/colo.h"
 #include "qemu/bitmap.h"
 #include "net/announce.h"
+#include "monitor/monitor.h"
+#include "monitor/hmp.h"
 
 const unsigned int postcopy_ram_discard_version = 0;
 
@@ -171,6 +173,15 @@ static QEMUFile *qemu_fopen_bdrv(BlockDriverState *bs, int is_writable)
     return qemu_fopen_ops(bs, &bdrv_read_ops);
 }
 
+static struct DirtyTrackState {
+    QemuThread thread;
+    int dirty_pages_rate;
+    bool quit;
+} current_dirty_track_state = {
+    { .thread = 0 },
+    .dirty_pages_rate = 0,
+    .quit = false,
+};
 
 /* QEMUFile timer support.
  * Not in qemu-file.c to not add qemu-timer.c as dependency to qemu-file.c
@@ -2747,6 +2758,78 @@ int save_snapshot(const char *name, Error **errp)
     return ret;
 }
 
+static void *dirty_track_thread(void *opaque)
+{
+    int64_t initial_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+    struct DirtyTrackState *s = opaque;
+    int64_t current_time;
+    uint64_t time_spent;
+
+    for (;;) {
+        dirty_track_sync();
+        if (s->quit) {
+            current_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
+            time_spent = current_time - initial_time;
+
+            if (time_spent) {
+                s->dirty_pages_rate = dirty_track_dirty_pages() * 1000 /
+                    time_spent;
+            }
+            break;
+        }
+        usleep(1000 * 100);
+    }
+    return NULL;
+}
+
+bool dirty_track_is_running(void)
+{
+    return !!current_dirty_track_state.thread.thread;
+}
+
+void hmp_dirty_track(Monitor *mon, const QDict *qdict)
+{
+    MigrationState *s = migrate_get_current();
+
+    if (migration_is_running(s->state)) {
+        error_report(QERR_MIGRATION_ACTIVE);
+        return;
+    }
+
+    if (runstate_check(RUN_STATE_INMIGRATE)) {
+        error_report("Guest is waiting for an incoming migration");
+        return;
+    }
+
+    if (dirty_track_is_running()) {
+        error_report("There is a dirty tracking process in progress");
+        return;
+    }
+
+    dirty_track_init();
+    qemu_thread_create(&current_dirty_track_state.thread, "dirty tracking",
+                       dirty_track_thread, &current_dirty_track_state,
+                       QEMU_THREAD_JOINABLE);
+}
+
+void hmp_dirty_track_stop(Monitor *mon, const QDict *qdict)
+{
+    if (current_dirty_track_state.thread.thread == 0) {
+        error_report("There is no dirty tracking process in progress");
+        return;
+    }
+
+    current_dirty_track_state.quit = true;
+    qemu_thread_join(&current_dirty_track_state.thread);
+    monitor_printf(mon, "Dirty rate: %d pages/s\n",
+                   current_dirty_track_state.dirty_pages_rate);
+
+    dirty_track_cleanup();
+    current_dirty_track_state.thread.thread = 0;
+    current_dirty_track_state.dirty_pages_rate = 0;
+    current_dirty_track_state.quit = false;
+}
+
 void qmp_xen_save_devices_state(const char *filename, bool has_live, bool live,
                                 Error **errp)
 {
diff --git a/migration/savevm.h b/migration/savevm.h
index ba64a7e271..216b9b7396 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -65,4 +65,6 @@ void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 
+bool dirty_track_is_running(void);
+
 #endif
-- 
2.18.4


