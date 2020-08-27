Return-Path: <SRS0=k4hX=CF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54FA0C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4D9322CBB
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2020 11:22:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7gr8FnV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4D9322CBB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBFzM-0003dX-65
	for qemu-devel@archiver.kernel.org; Thu, 27 Aug 2020 07:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54578)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtr-0005Mb-Et
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41741
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kBFtl-0000sG-H4
 for qemu-devel@nongnu.org; Thu, 27 Aug 2020 07:16:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598527012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VFmAqgi0oDnUbE1d/mBrknkR9Vzfje8F61ZX8h/v9RU=;
 b=X7gr8FnVMzJDwkW2UzZbDFEjYAbgYDrTSGUDLofJ6kGTac9E6AamgWHGIXC+I8HvgDsFj0
 hWgJ/Z8K96nEp8QS0H2esUfLY705zRxmeYwhgXLtJgSR6+Xirmi/EUkYtNcLan5kBMXS1/
 JNd3Fy81RhF0+YmfX27kNWJJfQrkykQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-470-ylmg2vPtMIGFOZS9Uq1thQ-1; Thu, 27 Aug 2020 07:16:49 -0400
X-MC-Unique: ylmg2vPtMIGFOZS9Uq1thQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6844E420E7;
 Thu, 27 Aug 2020 11:16:48 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDF637049B;
 Thu, 27 Aug 2020 11:16:44 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 7/7] migration: introduce snapshot-{save, load,
 delete} QMP commands
Date: Thu, 27 Aug 2020 12:16:06 +0100
Message-Id: <20200827111606.1408275-8-berrange@redhat.com>
In-Reply-To: <20200827111606.1408275-1-berrange@redhat.com>
References: <20200827111606.1408275-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/27 07:16:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, John Snow <jsnow@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

savevm, loadvm and delvm are some of the few HMP commands that have never
been converted to use QMP. The primary reason for this lack of conversion
is that they block execution of the thread for as long as they run.

Despite this downside, however, libvirt and applications using libvirt
have used these commands for as long as QMP has existed, via the
"human-monitor-command" passthrough command. IOW, while it is clearly
desirable to be able to fix the blocking problem, this is not an
immediate obstacle to real world usage.

Meanwhile there is a need for other features which involve adding new
parameters to the commands. This is possible with HMP passthrough, but
it provides no reliable way for apps to introspect features, so using
QAPI modelling is highly desirable.

This patch thus introduces new snapshot-{load,save,delete} commands to
QMP that are intended to replace the old HMP counterparts. The new
commands are given different names, because they will be using the new
QEMU job framework and thus will have diverging behaviour from the HMP
originals. It would thus be misleading to keep the same name.

While this design uses the generic job framework, the current impl is
still blocking. The intention that the blocking problem is fixed later.
None the less applications using these new commands should assume that
they are asynchronous and thus wait for the job status change event to
indicate completion.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h |  10 +-
 migration/savevm.c           | 220 ++++++++++++++++++++-
 monitor/hmp-cmds.c           |   4 +-
 qapi/job.json                |   9 +-
 qapi/migration.json          | 135 +++++++++++++
 replay/replay-snapshot.c     |   4 +-
 softmmu/vl.c                 |   2 +-
 tests/qemu-iotests/310       | 255 ++++++++++++++++++++++++
 tests/qemu-iotests/310.out   | 369 +++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group     |   1 +
 10 files changed, 991 insertions(+), 18 deletions(-)
 create mode 100755 tests/qemu-iotests/310
 create mode 100644 tests/qemu-iotests/310.out

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index c85b6ec75b..f2ed9d1e43 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -15,7 +15,13 @@
 #ifndef QEMU_MIGRATION_SNAPSHOT_H
 #define QEMU_MIGRATION_SNAPSHOT_H
 
-int save_snapshot(const char *name, Error **errp);
-int load_snapshot(const char *name, Error **errp);
+#include "qapi/qapi-builtin-types.h"
+
+int save_snapshot(const char *name,
+                  const char *vmstate, strList *devices,
+                  Error **errp);
+int load_snapshot(const char *name,
+                  const char *vmstate, strList *devices,
+                  Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 4a52704132..c5d8131d82 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -43,6 +43,8 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/clone-visitor.h"
+#include "qapi/qapi-builtin-visit.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/error-report.h"
 #include "sysemu/cpus.h"
@@ -2658,7 +2660,8 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-int save_snapshot(const char *name, Error **errp)
+int save_snapshot(const char *name, const char *vmstate,
+                  strList *devices, Error **errp)
 {
     BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2680,18 +2683,18 @@ int save_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    if (!bdrv_all_can_snapshot(NULL, errp)) {
+    if (!bdrv_all_can_snapshot(devices, errp)) {
         return ret;
     }
 
     /* Delete old snapshots of the same name */
     if (name) {
-        if (bdrv_all_delete_snapshot(name, NULL, errp) < 0) {
+        if (bdrv_all_delete_snapshot(name, devices, errp) < 0) {
             return ret;
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
+    bs = bdrv_all_find_vmstate_bs(vmstate, devices, errp);
     if (bs == NULL) {
         return ret;
     }
@@ -2757,7 +2760,7 @@ int save_snapshot(const char *name, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, NULL, errp);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, devices, errp);
     if (ret < 0) {
         goto the_end;
     }
@@ -2858,7 +2861,8 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_snapshot(const char *name, Error **errp)
+int load_snapshot(const char *name, const char *vmstate,
+                  strList *devices, Error **errp)
 {
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2873,15 +2877,15 @@ int load_snapshot(const char *name, Error **errp)
         return -1;
     }
 
-    if (!bdrv_all_can_snapshot(NULL, errp)) {
+    if (!bdrv_all_can_snapshot(devices, errp)) {
         return -1;
     }
-    ret = bdrv_all_find_snapshot(name, NULL, errp);
+    ret = bdrv_all_find_snapshot(name, devices, errp);
     if (ret < 0) {
         return -1;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(vmstate, devices, errp);
     if (!bs_vm_state) {
         return -1;
     }
@@ -2902,7 +2906,7 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, NULL, errp);
+    ret = bdrv_all_goto_snapshot(name, devices, errp);
     if (ret < 0) {
         goto err_drain;
     }
@@ -2936,6 +2940,19 @@ err_drain:
     return -1;
 }
 
+static int delete_snapshot(const char *name, strList *devices, Error **errp)
+{
+    if (!bdrv_all_can_snapshot(devices, errp)) {
+        return -1;
+    }
+
+    if (bdrv_all_delete_snapshot(name, devices, errp) < 0) {
+        return -1;
+    }
+
+    return 0;
+}
+
 void vmstate_register_ram(MemoryRegion *mr, DeviceState *dev)
 {
     qemu_ram_set_idstr(mr->ram_block,
@@ -2963,3 +2980,186 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 
     return !(vmsd && vmsd->unmigratable);
 }
+
+typedef struct SnapshotJob {
+    Job common;
+    char *tag;
+    char *vmstate;
+    strList *devices;
+    Coroutine *co;
+    Error **errp;
+    int ret;
+} SnapshotJob;
+
+static void qmp_snapshot_job_free(SnapshotJob *s)
+{
+    g_free(s->tag);
+    g_free(s->vmstate);
+    qapi_free_strList(s->devices);
+}
+
+
+static void snapshot_load_job_bh(void *opaque)
+{
+    Job *job = opaque;
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+    int saved_vm_running;
+
+    job_progress_set_remaining(&s->common, 1);
+
+    saved_vm_running = runstate_is_running();
+    vm_stop(RUN_STATE_RESTORE_VM);
+
+    s->ret = load_snapshot(s->tag, s->vmstate, s->devices, s->errp);
+    if (s->ret == 0 && saved_vm_running) {
+        vm_start();
+    }
+
+    job_progress_update(&s->common, 1);
+
+    qmp_snapshot_job_free(s);
+    aio_co_wake(s->co);
+}
+
+static void snapshot_save_job_bh(void *opaque)
+{
+    Job *job = opaque;
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+
+    job_progress_set_remaining(&s->common, 1);
+    s->ret = save_snapshot(s->tag, s->vmstate, s->devices, s->errp);
+    job_progress_update(&s->common, 1);
+
+    qmp_snapshot_job_free(s);
+    aio_co_wake(s->co);
+}
+
+static void snapshot_delete_job_bh(void *opaque)
+{
+    Job *job = opaque;
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+
+    job_progress_set_remaining(&s->common, 1);
+    s->ret = delete_snapshot(s->tag, s->devices, s->errp);
+    job_progress_update(&s->common, 1);
+
+    qmp_snapshot_job_free(s);
+    aio_co_wake(s->co);
+}
+
+static int coroutine_fn snapshot_save_job_run(Job *job, Error **errp)
+{
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+    s->errp = errp;
+    s->co = qemu_coroutine_self();
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            snapshot_save_job_bh, job);
+    qemu_coroutine_yield();
+    return s->ret;
+}
+
+static int coroutine_fn snapshot_load_job_run(Job *job, Error **errp)
+{
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+    s->errp = errp;
+    s->co = qemu_coroutine_self();
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            snapshot_load_job_bh, job);
+    qemu_coroutine_yield();
+    return s->ret;
+}
+
+static int coroutine_fn snapshot_delete_job_run(Job *job, Error **errp)
+{
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+    s->errp = errp;
+    s->co = qemu_coroutine_self();
+    aio_bh_schedule_oneshot(qemu_get_aio_context(),
+                            snapshot_delete_job_bh, job);
+    qemu_coroutine_yield();
+    return s->ret;
+}
+
+
+static const JobDriver snapshot_load_job_driver = {
+    .instance_size = sizeof(SnapshotJob),
+    .job_type      = JOB_TYPE_SNAPSHOT_LOAD,
+    .run           = snapshot_load_job_run,
+};
+
+static const JobDriver snapshot_save_job_driver = {
+    .instance_size = sizeof(SnapshotJob),
+    .job_type      = JOB_TYPE_SNAPSHOT_SAVE,
+    .run           = snapshot_save_job_run,
+};
+
+static const JobDriver snapshot_delete_job_driver = {
+    .instance_size = sizeof(SnapshotJob),
+    .job_type      = JOB_TYPE_SNAPSHOT_DELETE,
+    .run           = snapshot_delete_job_run,
+};
+
+
+void qmp_snapshot_save(const char *job_id,
+                       const char *tag,
+                       bool has_vmstate, const char *vmstate,
+                       bool has_devices, strList *devices,
+                       Error **errp)
+{
+    SnapshotJob *s;
+
+    s = job_create(job_id, &snapshot_save_job_driver, NULL,
+                   qemu_get_aio_context(), JOB_MANUAL_DISMISS,
+                   NULL, NULL, errp);
+    if (!s) {
+        return;
+    }
+
+    s->tag = g_strdup(tag);
+    s->vmstate = has_vmstate ? g_strdup(vmstate) : NULL;
+    s->devices = has_devices ? QAPI_CLONE(strList, devices) : NULL;
+
+    job_start(&s->common);
+}
+
+void qmp_snapshot_load(const char *job_id,
+                       const char *tag,
+                       bool has_vmstate, const char *vmstate,
+                       bool has_devices, strList *devices,
+                       Error **errp)
+{
+    SnapshotJob *s;
+
+    s = job_create(job_id, &snapshot_load_job_driver, NULL,
+                   qemu_get_aio_context(), JOB_MANUAL_DISMISS,
+                   NULL, NULL, errp);
+    if (!s) {
+        return;
+    }
+
+    s->tag = g_strdup(tag);
+    s->vmstate = has_vmstate ? g_strdup(vmstate) : NULL;
+    s->devices = has_devices ? QAPI_CLONE(strList, devices) : NULL;
+
+    job_start(&s->common);
+}
+
+void qmp_snapshot_delete(const char *job_id,
+                         const char *tag,
+                         bool has_devices, strList *devices,
+                         Error **errp)
+{
+    SnapshotJob *s;
+
+    s = job_create(job_id, &snapshot_delete_job_driver, NULL,
+                   qemu_get_aio_context(), JOB_MANUAL_DISMISS,
+                   NULL, NULL, errp);
+    if (!s) {
+        return;
+    }
+
+    s->tag = g_strdup(tag);
+    s->devices = has_devices ? QAPI_CLONE(strList, devices) : NULL;
+
+    job_start(&s->common);
+}
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 51f624b5ea..2ac2c109db 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1121,7 +1121,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
+    if (load_snapshot(name, NULL, NULL, &err) == 0 && saved_vm_running) {
         vm_start();
     }
     hmp_handle_error(mon, err);
@@ -1131,7 +1131,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"), NULL, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/qapi/job.json b/qapi/job.json
index 280c2f76f1..51bee470f0 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -22,10 +22,17 @@
 #
 # @amend: image options amend job type, see "x-blockdev-amend" (since 5.1)
 #
+# @snapshot-load: snapshot load job type, see "loadvm" (since 5.2)
+#
+# @snapshot-save: snapshot save job type, see "savevm" (since 5.2)
+#
+# @snapshot-delete: snapshot delete job type, see "delvm" (since 5.2)
+#
 # Since: 1.7
 ##
 { 'enum': 'JobType',
-  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend'] }
+  'data': ['commit', 'stream', 'mirror', 'backup', 'create', 'amend',
+           'snapshot-load', 'snapshot-save', 'snapshot-delete'] }
 
 ##
 # @JobStatus:
diff --git a/qapi/migration.json b/qapi/migration.json
index 5f6b06172c..d70f627b77 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1720,3 +1720,138 @@
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
+
+##
+# @snapshot-save:
+#
+# Save a VM snapshot
+#
+# @job-id: identifier for the newly created job
+# @tag: name of the snapshot to create. If it already
+# exists it will be replaced.
+# @devices: list of block device node names to save a snapshot to
+# @vmstate: block device node name to save vmstate to
+#
+# Applications should not assume that the snapshot save is complete
+# when this command returns. Completion is indicated by the job
+# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
+# job aborts, errors can be obtained via the 'query-jobs' command,
+# though. Note that at this time most vmstate procssing errors only
+# get printed to stderr. This limitation will be fixed at a future
+# date.
+#
+# Note that the VM CPUs will be paused during the time it takes to
+# save the snapshot
+#
+# If @devices is not specified, or is an empty list, then the
+# historical default logic for picking devices will be used.
+#
+# If @vmstate is not specified, then the first valid block
+# device will be used for vmstate.
+#
+# Returns: nothing
+#
+# Example:
+#
+# -> { "execute": "snapshot-save",
+#      "data": {
+#         "job-id": "snapsave0",
+#         "tag": "my-snap",
+#         "vmstate": "disk0",
+#         "devices": ["disk0", "disk1"]
+#      }
+#    }
+# <- { "return": { } }
+#
+# Since: 5.2
+##
+{ 'command': 'snapshot-save',
+  'data': { 'job-id': 'str',
+            'tag': 'str',
+            '*vmstate': 'str',
+            '*devices': ['str'] } }
+
+##
+# @snapshot-load:
+#
+# Load a VM snapshot
+#
+# @job-id: identifier for the newly created job
+# @tag: name of the snapshot to load.
+# @devices: list of block device node names to load a snapshot from
+# @vmstate: block device node name to load vmstate from
+#
+# Applications should not assume that the snapshot load is complete
+# when this command returns. Completion is indicated by the job
+# status. Clients can wait for the JOB_STATUS_CHANGE event. If the
+# job aborts, errors can be obtained via the 'query-jobs' command,
+# though. Note that at this time most vmstate procssing errors only
+# get printed to stderr. This limitation will be fixed at a future
+# date.
+#
+# If @devices is not specified, or is an empty list, then the
+# historical default logic for picking devices will be used.
+#
+# If @vmstate is not specified, then the first valid block
+# device will be used for vmstate.
+#
+# Returns: nothing
+#
+# Example:
+#
+# -> { "execute": "snapshot-load",
+#      "data": {
+#         "job-id": "snapload0",
+#         "tag": "my-snap",
+#         "vmstate": "disk0",
+#         "devices": ["disk0", "disk1"]
+#      }
+#    }
+# <- { "return": { } }
+#
+# Since: 5.2
+##
+{ 'command': 'snapshot-load',
+  'data': { 'job-id': 'str',
+            'tag': 'str',
+            '*vmstate': 'str',
+            '*devices': ['str'] } }
+
+##
+# @snapshot-delete:
+#
+# Delete a VM snapshot
+#
+# @job-id: identifier for the newly created job
+# @tag: name of the snapshot to delete.
+# @devices: list of block device node names to delete a snapshot from
+#
+# Applications should not assume that the snapshot load is complete
+# when this command returns. Completion is indicated by the job
+# status. Clients can wait for the JOB_STATUS_CHANGE event.
+#
+# Note that the VM CPUs will be paused during the time it takes to
+# delete the snapshot
+#
+# If @devices is not specified, or is an empty list, then the
+# historical default logic for picking devices will be used.
+#
+# Returns: nothing
+#
+# Example:
+#
+# -> { "execute": "snapshot-delete",
+#      "data": {
+#         "job-id": "snapdelete0",
+#         "tag": "my-snap",
+#         "devices": ["disk0", "disk1"]
+#      }
+#    }
+# <- { "return": { } }
+#
+# Since: 5.2
+##
+{ 'command': 'snapshot-delete',
+  'data': { 'job-id': 'str',
+            'tag': 'str',
+            '*devices': ['str'] } }
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index e26fa4c892..f0f45a4f24 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,13 +77,13 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_snapshot(replay_snapshot, &err) != 0) {
+            if (save_snapshot(replay_snapshot, NULL, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_snapshot(replay_snapshot, &err) != 0) {
+            if (load_snapshot(replay_snapshot, NULL, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0cc86b0766..8dbc2fe638 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4459,7 +4459,7 @@ void qemu_init(int argc, char **argv, char **envp)
     register_global_state();
     if (loadvm) {
         Error *local_err = NULL;
-        if (load_snapshot(loadvm, &local_err) < 0) {
+        if (load_snapshot(loadvm, NULL, NULL, &local_err) < 0) {
             error_report_err(local_err);
             autostart = 0;
             exit(1);
diff --git a/tests/qemu-iotests/310 b/tests/qemu-iotests/310
new file mode 100755
index 0000000000..66cb58d2c8
--- /dev/null
+++ b/tests/qemu-iotests/310
@@ -0,0 +1,255 @@
+#!/usr/bin/env bash
+#
+# Test which nodes are involved in internal snapshots
+#
+# Copyright (C) 2019 Red Hat, Inc.
+#
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 2 of the License, or
+# (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program.  If not, see <http://www.gnu.org/licenses/>.
+#
+
+# creator
+owner=berrange@redhat.com
+
+seq=`basename $0`
+echo "QA output created by $seq"
+
+status=1	# failure is the default!
+
+_cleanup()
+{
+    _cleanup_qemu
+    _cleanup_test_img
+    TEST_IMG="$TEST_IMG.alt1" _cleanup_test_img
+    TEST_IMG="$TEST_IMG.alt2" _cleanup_test_img
+    rm -f "$SOCK_DIR/nbd"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
+. ./common.qemu
+
+_supported_fmt qcow2
+_supported_proto file
+_supported_os Linux
+_require_drivers copy-on-read
+
+# Internal snapshots are (currently) impossible with refcount_bits=1,
+# and generally impossible with external data files
+_unsupported_imgopts 'refcount_bits=1[^0-9]' data_file
+
+_require_devices virtio-blk
+
+
+size=128M
+
+if [ -n "$BACKING_FILE" ]; then
+    _make_test_img -b "$BACKING_FILE" -F $IMGFMT $size
+else
+    _make_test_img $size
+fi
+
+    _make_test_img $size
+
+echo "Single disk test"
+
+export capture_events="JOB_STATUS_CHANGE STOP RESUME"
+
+run_snapshot()
+{
+    local op=$1
+
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"snapshot-${op}\", \"arguments\": {\"job-id\": \"snap${op}0\", \"tag\": \"snap0\", \"devices\": $SNAP_DEVICES}}" "return"
+    # created
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+    # running
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+    if [ $op = "delete" ]; then
+	if [ $SNAP_DELETE_FAIL = 1 ]; then
+	    # aborting
+	    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+	else
+	    # waiting
+	    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+	    # pending
+	    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+	fi
+    else
+	if [ $SNAP_FAIL = 0 ]; then
+	    _wait_event $QEMU_HANDLE "STOP"
+	    _wait_event $QEMU_HANDLE "RESUME"
+	    # waiting
+	    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+	    # pending
+	    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+	else
+	    if [ $op = "load" ]; then
+		_wait_event $QEMU_HANDLE "STOP"
+	    fi
+	    # aborting
+	    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+	fi
+    fi
+    # concluded
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"query-jobs\"}" "return"
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"job-dismiss\", \"arguments\": {\"id\": \"snap${op}0\"}}" "return"
+    # null
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+}
+
+run_test()
+{
+    keep_stderr=y
+    _launch_qemu -nodefaults -nographic "$@"
+
+    _send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
+
+    run_snapshot "save"
+    run_snapshot "load"
+    run_snapshot "delete"
+
+    _send_qemu_cmd $QEMU_HANDLE '{"execute": "quit"}' 'return'
+
+    wait=1 _cleanup_qemu
+}
+
+
+echo
+echo "=====  Snapshot single qcow2 image ====="
+echo
+
+SNAP_DEVICES='["diskfmt0"]' SNAP_FAIL=0 SNAP_DELETE_FAIL=0 \
+  run_test \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+echo
+echo "=====  Snapshot no image ====="
+echo
+
+TEST_IMG="$TEST_IMG.alt1" _make_test_img $size
+
+SNAP_DEVICES="[]" SNAP_FAIL=1 SNAP_DELETE_FAIL=0 \
+  run_test
+
+
+echo
+echo "=====  Snapshot missing image ====="
+echo
+
+SNAP_DEVICES='["diskfmt1729"]' SNAP_FAIL=1 SNAP_DELETE_FAIL=1 \
+  run_test \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+
+echo
+echo "=====  Snapshot protocol instead of format ====="
+echo
+
+SNAP_DEVICES='["disk0"]' SNAP_FAIL=1 SNAP_DELETE_FAIL=1 \
+  run_test \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+
+echo
+echo "=====  Snapshot dual qcow2 image ====="
+echo
+
+SNAP_DEVICES='["diskfmt0", "diskfmt1"]' SNAP_FAIL=0 SNAP_DELETE_FAIL=0 \
+  run_test \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt1','node-name':'disk1'}" \
+    -blockdev "{'driver':'qcow2','file':'disk1','node-name':'diskfmt1'}"
+
+
+echo
+echo "=====  Snapshot error with raw image ====="
+echo
+
+IMGOPTS= IMGFMT=raw TEST_IMG="$TEST_IMG.alt2" _make_test_img $size
+
+SNAP_DEVICES='["diskfmt0", "diskfmt1", "diskfmt2"]' SNAP_FAIL=1 SNAP_DELETE_FAIL=1 \
+  run_test \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt1','node-name':'disk1'}" \
+    -blockdev "{'driver':'qcow2','file':'disk1','node-name':'diskfmt1'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt2','node-name':'disk2'}" \
+    -blockdev "{'driver':'raw','file':'disk2','node-name':'diskfmt2'}"
+
+
+echo
+echo "=====  Snapshot with raw image excluded ====="
+echo
+
+SNAP_DEVICES='["diskfmt0", "diskfmt1"]' SNAP_FAIL=0 SNAP_DELETE_FAIL=0 \
+  run_test \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt1','node-name':'disk1'}" \
+    -blockdev "{'driver':'qcow2','file':'disk1','node-name':'diskfmt1'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt2','node-name':'disk2'}" \
+    -blockdev "{'driver':'raw','file':'disk2','node-name':'diskfmt2'}"
+
+echo
+echo "=====  Snapshot bad error reporting to stderr ====="
+echo
+
+# This demonstrates that we're not capturing vmstate loading failures
+# into QMP errors, they're ending up in stderr instead. vmstate needs
+# to report errors via Error object but that is a major piece of work
+# for the future. This test case's expected output log will need
+# adjusting when that is done.
+
+SNAP_DEVICES='["diskfmt0"]'
+SNAP_FAIL=1
+SNAP_DELETE_FAIL=0
+
+keep_stderr=y
+_launch_qemu -nodefaults -nographic \
+    -device virtio-rng \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
+
+run_snapshot "save"
+
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "quit"}' 'return'
+
+wait=1 _cleanup_qemu
+
+# leave off virtio-rng to provoke vmstate failure
+_launch_qemu -nodefaults -nographic \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
+
+run_snapshot "load"
+run_snapshot "delete"
+
+_send_qemu_cmd $QEMU_HANDLE '{"execute": "quit"}' 'return'
+
+wait=1 _cleanup_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/310.out b/tests/qemu-iotests/310.out
new file mode 100644
index 0000000000..32c797ab1e
--- /dev/null
+++ b/tests/qemu-iotests/310.out
@@ -0,0 +1,369 @@
+QA output created by 310
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Single disk test
+
+=====  Snapshot single qcow2 image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot no image =====
+
+Formatting 'TEST_DIR/t.IMGFMT.alt1', fmt=IMGFMT size=134217728
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": []}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0", "error": "No block device supports snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": []}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0", "error": "No block device supports snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": []}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot missing image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": ["diskfmt1729"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0", "error": "No block device node 'diskfmt1729'"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": ["diskfmt1729"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0", "error": "No block device node 'diskfmt1729'"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": ["diskfmt1729"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0", "error": "No block device node 'diskfmt1729'"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot protocol instead of format =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": ["disk0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": ["disk0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": ["disk0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot dual qcow2 image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot error with raw image =====
+
+Formatting 'TEST_DIR/t.qcow2.alt2', fmt=IMGFMT size=134217728
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1", "diskfmt2"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0", "error": "Device 'diskfmt2' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1", "diskfmt2"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0", "error": "Device 'diskfmt2' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1", "diskfmt2"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0", "error": "Device 'diskfmt2' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot with raw image excluded =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot bad error reporting to stderr =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "snapsave0", "tag": "snap0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapsave0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "snapsave0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapsave0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapsave0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-load", "arguments": {"job-id": "snapload0", "tag": "snap0", "devices": ["diskfmt0"]}}
+qemu-system-x86_64: Unknown savevm section or instance '0000:00:02.0/virtio-rng' 0. Make sure that your current VM setup matches your saved VM setup, including any hotplugged devices
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapsave0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "snapload0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "snapload0", "error": "Error -22 while loading VM state"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapload0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapload0"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "snapdelete0", "tag": "snap0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "snapload0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "snapdelete0"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "snapdelete0"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "snapdelete0"}]}
+{"execute": "job-dismiss", "arguments": {"id": "snapdelete0"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "snapdelete0"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index a53ea7f78b..b2a5dfbc5a 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -290,6 +290,7 @@
 277 rw quick
 279 rw backing quick
 280 rw migration quick
+310 rw quick
 281 rw quick
 282 rw img quick
 283 auto quick
-- 
2.26.2


