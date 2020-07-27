Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E71BC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:15:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC0AB20672
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:15:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MFJGlN9+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC0AB20672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58046 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04qu-0007Pz-5P
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38208)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04lH-00083M-Dy
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:58632
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04lE-0007nk-5p
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595862590;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Zy7Mn3kcExFnf9k5vuQODWSC9AL71T7bebtFYFHT/I=;
 b=MFJGlN9+WKLghLtM5fOWyfT6Jhh0I5Gpl0AUn2HU3FNVjtUAS2Jb7Il67wTKxS4xvZrZY8
 Pf0OKYva2RBdD1lhvN+S/ERPgFY7eZ1At0EAGlw92y4aOipjNkaYuCk8fczuGcZfWH5tQg
 yTCVHN7EdPfEoU3tBcKe8Hu/62T3S28=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-324-y5Edv29yNuC2FB5YDPMGyw-1; Mon, 27 Jul 2020 11:09:39 -0400
X-MC-Unique: y5Edv29yNuC2FB5YDPMGyw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C910D79EC2;
 Mon, 27 Jul 2020 15:09:17 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C2C8560BF4;
 Mon, 27 Jul 2020 15:09:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 6/6] migration: introduce snapshot-{save, load,
 delete} QMP commands
Date: Mon, 27 Jul 2020 16:08:43 +0100
Message-Id: <20200727150843.3419256-7-berrange@redhat.com>
In-Reply-To: <20200727150843.3419256-1-berrange@redhat.com>
References: <20200727150843.3419256-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:44:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>
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
 migration/savevm.c           | 172 +++++++++++++++++++++++++++++++++--
 monitor/hmp-cmds.c           |   4 +-
 qapi/job.json                |   9 +-
 qapi/migration.json          | 112 +++++++++++++++++++++++
 replay/replay-snapshot.c     |   4 +-
 softmmu/vl.c                 |   2 +-
 tests/qemu-iotests/310       | 125 +++++++++++++++++++++++++
 tests/qemu-iotests/310.out   |   0
 tests/qemu-iotests/group     |   1 +
 10 files changed, 421 insertions(+), 18 deletions(-)
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
index 1707fa30db..13c5a54aae 100644
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
@@ -2631,7 +2633,8 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-int save_snapshot(const char *name, Error **errp)
+int save_snapshot(const char *name, const char *vmstate,
+                  strList *devices, Error **errp)
 {
     BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2653,18 +2656,18 @@ int save_snapshot(const char *name, Error **errp)
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
@@ -2730,7 +2733,7 @@ int save_snapshot(const char *name, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, NULL, errp);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, devices, errp);
     if (ret < 0) {
         goto the_end;
     }
@@ -2831,7 +2834,8 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_snapshot(const char *name, Error **errp)
+int load_snapshot(const char *name, const char *vmstate,
+                  strList *devices, Error **errp)
 {
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2846,15 +2850,15 @@ int load_snapshot(const char *name, Error **errp)
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
@@ -2875,7 +2879,7 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, NULL, errp);
+    ret = bdrv_all_goto_snapshot(name, devices, errp);
     if (ret < 0) {
         goto err_drain;
     }
@@ -2936,3 +2940,151 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 
     return !(vmsd && vmsd->unmigratable);
 }
+
+typedef struct SnapshotJob {
+    Job common;
+    char *tag;
+    char *vmstate;
+    strList *devices;
+} SnapshotJob;
+
+static void qmp_snapshot_job_free(SnapshotJob *s)
+{
+    g_free(s->tag);
+    g_free(s->vmstate);
+    qapi_free_strList(s->devices);
+}
+
+static int coroutine_fn snapshot_load_job_run(Job *job, Error **errp)
+{
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+    int ret;
+    int saved_vm_running;
+
+    job_progress_set_remaining(&s->common, 1);
+
+    saved_vm_running = runstate_is_running();
+    vm_stop(RUN_STATE_RESTORE_VM);
+
+    ret = load_snapshot(s->tag, s->vmstate, s->devices, errp);
+    if (ret == 0 && saved_vm_running) {
+        vm_start();
+    }
+
+    job_progress_update(&s->common, 1);
+
+    qmp_snapshot_job_free(s);
+
+    return ret;
+}
+
+static int coroutine_fn snapshot_save_job_run(Job *job, Error **errp)
+{
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+    int ret;
+
+    job_progress_set_remaining(&s->common, 1);
+    ret = save_snapshot(s->tag, s->vmstate, s->devices, errp);
+    job_progress_update(&s->common, 1);
+
+    qmp_snapshot_job_free(s);
+
+    return ret;
+}
+
+static int coroutine_fn snapshot_delete_job_run(Job *job, Error **errp)
+{
+    SnapshotJob *s = container_of(job, SnapshotJob, common);
+    int ret;
+
+    job_progress_set_remaining(&s->common, 1);
+    ret = bdrv_all_delete_snapshot(s->tag, s->devices, errp);
+    job_progress_update(&s->common, 1);
+
+    qmp_snapshot_job_free(s);
+
+    return ret;
+}
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
index 90e717f0c4..2b51273720 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1095,7 +1095,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
+    if (load_snapshot(name, NULL, NULL, &err) == 0 && saved_vm_running) {
         vm_start();
     }
     hmp_handle_error(mon, err);
@@ -1105,7 +1105,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_snapshot(qdict_get_try_str(qdict, "name"), &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"), NULL, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/qapi/job.json b/qapi/job.json
index c48a0c3e34..6aa03a7aff 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -21,10 +21,17 @@
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
index d5000558c6..0ca556c158 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1621,3 +1621,115 @@
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
+# status. Clients can wait for the JOB_STATUS_CHANGE event.
+#
+# Note that the VM CPUs will be paused during the time it takes to
+# save the snapshot
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
+# status. Clients can wait for the JOB_STATUS_CHANGE event.
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
index 3416241557..9d2d38360a 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4456,7 +4456,7 @@ void qemu_init(int argc, char **argv, char **envp)
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
index 0000000000..b84b3a6dd6
--- /dev/null
+++ b/tests/qemu-iotests/310
@@ -0,0 +1,125 @@
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
+    _cleanup_test_img
+    rm -f "$SOCK_DIR/nbd"
+}
+trap "_cleanup; exit \$status" 0 1 2 3 15
+
+# get standard environment, filters and checks
+. ./common.rc
+. ./common.filter
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
+do_run_qemu()
+{
+    echo Testing: "$@"
+    (
+        if ! test -t 0; then
+            while read cmd; do
+                echo $cmd
+            done
+        fi
+        echo quit
+    ) | $QEMU -nographic -qmp stdio -nodefaults "$@"
+    echo
+}
+
+run_qemu()
+{
+    do_run_qemu "$@" 2>&1 | _filter_testdir | _filter_qemu | _filter_hmp |
+        _filter_generated_node_ids | _filter_imgfmt | _filter_vmstate_size
+}
+
+size=128M
+
+run_test()
+{
+    if [ -n "$BACKING_FILE" ]; then
+        _make_test_img -b "$BACKING_FILE" -F $IMGFMT $size
+    else
+        _make_test_img $size
+    fi
+    run_qemu "$@" <<EOF | _filter_date
+{ "execute": "qmp_capabilities" }
+{ "execute": "snapshot-save",
+  "arguments": {
+    "job-id": "snapsave0",
+    "tag": "snap0",
+    "devices": ["disk1"]
+  } }
+{ "execute": "query-jobs" }
+{ "execute": "query-named-block-nodes" }
+{ "execute": "snapshot-load",
+  "arguments": {
+    "job-id": "snapload0",
+    "tag": "snap0",
+    "devices": ["disk1"]
+  } }
+{ "execute": "query-jobs" }
+{ "execute": "query-named-block-nodes" }
+{ "execute": "snapshot-delete",
+  "arguments": {
+    "job-id": "snapdel0",
+    "tag": "snap0",
+    "devices": ["disk1"]
+  } }
+{ "execute": "query-jobs" }
+{ "execute": "snapshot-delete",
+  "arguments": {
+    "job-id": "snapdel1",
+    "tag": "snap1",
+    "devices": ["disk1"]
+  } }
+{ "execute": "query-jobs" }
+{ "execute": "query-named-block-nodes" }
+{ "execute": "quit" }
+EOF
+}
+
+echo "Basic test"
+
+run_test -blockdev "{\"driver\":\"file\",\"filename\":\"$TEST_IMG\",\"node-name\":\"disk0\"}" \
+         -blockdev "{\"driver\":\"qcow2\",\"file\":\"disk0\",\"node-name\":\"disk1\"}"
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/310.out b/tests/qemu-iotests/310.out
new file mode 100644
index 0000000000..e69de29bb2
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 1d0252e1f0..fb2a442e9f 100644
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


