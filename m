Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B9FC43461
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:45:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9107620684
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EcaBt27Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9107620684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9PG-0003RO-N0
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:45:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9G5-0001lY-7R
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:36:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:38965
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9Fz-0002xX-2x
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600169778;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rRV5wlhixDSx8E6LibeWTI488W6QUTJbSbRg/SexRjg=;
 b=EcaBt27ZNQLLJhf9Rq+pRyZhefRtOAcVYDfIBiSalMOK6WaxUAGoWCBRlRUYhvCIwIqou8
 C4BRrUS3iLsl3LCsvI/n//amR0+yFjPV4X70nQnMnQUUhDH3exR+OTTJEw2HOQ1szpIoXp
 rW81a5KiA2wBNf3N1mYRZ9FQMQlCvZ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-GfclKoYFMLq2u5M8CXAU8w-1; Tue, 15 Sep 2020 07:36:14 -0400
X-MC-Unique: GfclKoYFMLq2u5M8CXAU8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 615B41005E65;
 Tue, 15 Sep 2020 11:36:13 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6C3BA747B0;
 Tue, 15 Sep 2020 11:36:09 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 9/9] migration: introduce snapshot-{save, load,
 delete} QMP commands
Date: Tue, 15 Sep 2020 12:35:23 +0100
Message-Id: <20200915113523.2520317-10-berrange@redhat.com>
In-Reply-To: <20200915113523.2520317-1-berrange@redhat.com>
References: <20200915113523.2520317-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.004
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 02:11:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

savevm, loadvm and delvm are some of the few HMP commands that have never
been converted to use QMP. The reasons for the lack of conversion are
that they blocked execution of the event thread, and the semantics
around choice of disks were ill-defined.

Despite this downside, however, libvirt and applications using libvirt
have used these commands for as long as QMP has existed, via the
"human-monitor-command" passthrough command. IOW, while it is clearly
desirable to be able to fix the problems, they are not a blocker to
all real world usage.

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

In addition to using the job framework, the new commands require the
caller to be explicit about all the block device nodes used in the
snapshot operations, with no built-in default heuristics in use.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 migration/savevm.c         | 183 ++++++++++++++++
 qapi/job.json              |   9 +-
 qapi/migration.json        | 120 +++++++++++
 tests/qemu-iotests/310     | 338 ++++++++++++++++++++++++++++++
 tests/qemu-iotests/310.out | 412 +++++++++++++++++++++++++++++++++++++
 tests/qemu-iotests/group   |   1 +
 6 files changed, 1062 insertions(+), 1 deletion(-)
 create mode 100755 tests/qemu-iotests/310
 create mode 100644 tests/qemu-iotests/310.out

diff --git a/migration/savevm.c b/migration/savevm.c
index 56f85be250..85b50953ad 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2980,3 +2980,186 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 
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
+    s->ret = load_snapshot(s->tag, s->vmstate, true, s->devices, s->errp);
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
+    s->ret = save_snapshot(s->tag, false, s->vmstate, true, s->devices, s->errp);
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
+    s->ret = delete_snapshot(s->tag, true, s->devices, s->errp);
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
+                       const char *vmstate,
+                       strList *devices,
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
+    s->vmstate = g_strdup(vmstate);
+    s->devices = QAPI_CLONE(strList, devices);
+
+    job_start(&s->common);
+}
+
+void qmp_snapshot_load(const char *job_id,
+                       const char *tag,
+                       const char *vmstate,
+                       strList *devices,
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
+    s->vmstate = g_strdup(vmstate);
+    s->devices = QAPI_CLONE(strList, devices);
+
+    job_start(&s->common);
+}
+
+void qmp_snapshot_delete(const char *job_id,
+                         const char *tag,
+                         strList *devices,
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
+    s->devices = QAPI_CLONE(strList, devices);
+
+    job_start(&s->common);
+}
diff --git a/qapi/job.json b/qapi/job.json
index 280c2f76f1..b2cbb4fead 100644
--- a/qapi/job.json
+++ b/qapi/job.json
@@ -22,10 +22,17 @@
 #
 # @amend: image options amend job type, see "x-blockdev-amend" (since 5.1)
 #
+# @snapshot-load: snapshot load job type, see "snapshot-load" (since 5.2)
+#
+# @snapshot-save: snapshot save job type, see "snapshot-save" (since 5.2)
+#
+# @snapshot-delete: snapshot delete job type, see "snapshot-delete" (since 5.2)
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
index 675f70bb67..b584c0be31 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1720,3 +1720,123 @@
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
+# @tag: name of the snapshot to create
+# @devices: list of block device node names to save a snapshot to
+# @vmstate: block device node name to save vmstate to
+#
+# Applications should not assume that the snapshot save is complete
+# when this command returns. The job commands / events must be used
+# to determine completion and to fetch details of any errors that arise.
+#
+# Note that the VM CPUs will be paused during the time it takes to
+# save the snapshot
+#
+# It is strongly recommended that @devices contain all writable
+# block device nodes if a consistent snapshot is required.
+#
+# If @tag already exists, an error will be reported
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
+            'vmstate': 'str',
+            'devices': ['str'] } }
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
+# Applications should not assume that the snapshot save is complete
+# when this command returns. The job commands / events must be used
+# to determine completion and to fetch details of any errors that arise.
+#
+# Note that the VM CPUs will be paused during the time it takes to
+# save the snapshot
+#
+# It is strongly recommended that @devices contain all writable
+# block device nodes that can have changed since the original
+# @snapshot-save command execution.
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
+            'vmstate': 'str',
+            'devices': ['str'] } }
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
+# Applications should not assume that the snapshot save is complete
+# when this command returns. The job commands / events must be used
+# to determine completion and to fetch details of any errors that arise.
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
+            'devices': ['str'] } }
diff --git a/tests/qemu-iotests/310 b/tests/qemu-iotests/310
new file mode 100755
index 0000000000..622451c79f
--- /dev/null
+++ b/tests/qemu-iotests/310
@@ -0,0 +1,338 @@
+#!/usr/bin/env bash
+#
+# Test which nodes are involved in internal snapshots
+#
+# Copyright (C) 2020 Red Hat, Inc.
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
+TEST_IMG="$TEST_IMG.alt1" _make_test_img $size
+IMGOPTS= IMGFMT=raw TEST_IMG="$TEST_IMG.alt2" _make_test_img $size
+
+export capture_events="JOB_STATUS_CHANGE STOP RESUME"
+
+wait_job()
+{
+    local job=$1
+    shift
+
+    # All jobs start with two events...
+    #
+    # created
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+    # running
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+
+    # Next events vary depending on job type and
+    # whether it succeeds or not.
+    for evname in $@
+    do
+	_wait_event $QEMU_HANDLE $evname
+    done
+
+    # All jobs finish off with two more events...
+    # concluded
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"query-jobs\"}" "return"
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"job-dismiss\", \"arguments\": {\"id\": \"$job\"}}" "return"
+    # null
+    _wait_event $QEMU_HANDLE "JOB_STATUS_CHANGE"
+}
+
+run_save()
+{
+    local job=$1
+    local vmstate=$2
+    local devices=$3
+    local fail=$4
+
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"snapshot-save\",
+                                  \"arguments\": {
+                                     \"job-id\": \"$job\",
+                                     \"tag\": \"snap0\",
+                                     \"vmstate\": \"$vmstate\",
+                                     \"devices\": $devices}}" "return"
+
+    if [ $fail = 0 ]; then
+	# job status: waiting, pending
+	wait_job $job "STOP" "RESUME" "JOB_STATUS_CHANGE" "JOB_STATUS_CHANGE"
+    else
+	# job status: aborting
+	wait_job $job "JOB_STATUS_CHANGE"
+    fi
+}
+
+run_load()
+{
+    local job=$1
+    local vmstate=$2
+    local devices=$3
+    local fail=$4
+
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"snapshot-load\",
+                                  \"arguments\": {
+                                     \"job-id\": \"$job\",
+                                     \"tag\": \"snap0\",
+                                     \"vmstate\": \"$vmstate\",
+                                     \"devices\": $devices}}" "return"
+    if [ $fail = 0 ]; then
+	# job status: waiting, pending
+	wait_job $job "STOP" "RESUME" "JOB_STATUS_CHANGE" "JOB_STATUS_CHANGE"
+    else
+	# job status: aborting
+	wait_job $job "STOP" "JOB_STATUS_CHANGE"
+    fi
+}
+
+run_delete()
+{
+    local job=$1
+    local devices=$2
+    local fail=$3
+
+    _send_qemu_cmd $QEMU_HANDLE "{\"execute\": \"snapshot-delete\",
+                                  \"arguments\": {
+                                     \"job-id\": \"$job\",
+                                     \"tag\": \"snap0\",
+                                     \"devices\": $devices}}" "return"
+    if [ $fail = 0 ]; then
+	# job status: waiting, pending
+	wait_job $job "JOB_STATUS_CHANGE" "JOB_STATUS_CHANGE"
+    else
+	# job status: aborting
+	wait_job $job "JOB_STATUS_CHANGE"
+    fi
+}
+
+start_qemu()
+{
+    keep_stderr=y
+    _launch_qemu -nodefaults -nographic "$@"
+
+    _send_qemu_cmd $QEMU_HANDLE '{"execute": "qmp_capabilities"}' 'return'
+}
+
+stop_qemu()
+{
+    _send_qemu_cmd $QEMU_HANDLE '{"execute": "quit"}' 'return'
+
+    wait=1 _cleanup_qemu
+}
+
+run_test()
+{
+    local job=$1
+    local vmstate=$2
+    local devices=$3
+    local savefail=$4
+    local loadfail=$5
+    local delfail=$6
+    shift
+    shift
+    shift
+    shift
+    shift
+    shift
+
+    start_qemu $@
+    run_save "save-$job" "$vmstate" "$devices" "$savefail"
+    run_load "load-$job" "$vmstate" "$devices" "$loadfail"
+    run_delete "delete-$job" "$devices" "$delfail"
+    stop_qemu
+}
+
+
+echo
+echo "=====  Snapshot single qcow2 image ====="
+echo
+
+run_test "simple" "diskfmt0" "[\"diskfmt0\"]" 0 0 0 \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+
+echo
+echo "=====  Snapshot no image ====="
+echo
+
+# When snapshotting we need to pass at least one writable disk
+# otherwise there's no work to do
+
+run_test "no-image" "diskfmt0" "[]" 1 1 1 \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+
+echo
+echo "=====  Snapshot missing image ====="
+echo
+
+# The block node names we pass need to actually exist
+
+run_test "missing-image" "diskfmt1729" "[\"diskfmt1729\"]" 1 1 1 \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+
+echo
+echo "=====  Snapshot vmstate not in devices list ====="
+echo
+
+# The node name referred to for vmstate must be one of the nodes
+# being included in the snapshot, otherwise the vmstate that is
+# captured is liable to be overwritten making subsequent load
+# impossible
+
+run_test "excluded-vmstate" "diskfmt0" "[\"diskfmt1\"]" 1 1 0 \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt1','node-name':'disk1'}" \
+    -blockdev "{'driver':'qcow2','file':'disk1','node-name':'diskfmt1'}"
+
+
+echo
+echo "=====  Snapshot protocol instead of format ====="
+echo
+
+# The snapshot has to be done against the qcow2 format layer
+# not the underlying file protocol layer
+
+run_test "proto-not-fmt" "disk0" "[\"disk0\"]" 1 1 1 \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+
+echo
+echo "=====  Snapshot dual qcow2 image ====="
+echo
+
+# We can snapshot multiple  qcow2 disks at the same time
+
+run_test "dual-image" "diskfmt0" "[\"diskfmt0\", \"diskfmt1\"]" 0 0 0 \
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
+# If we're snapshotting multiple disks, all must be capable
+# of supporting snapshots. A raw disk in the list must cause
+# an error.
+
+run_test "raw-fmt" "diskfmt0" "[\"diskfmt0\", \"diskfmt1\", \"diskfmt2\"]" 1 1 1 \
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
+# If we're snapshotting multiple disks, all must be capable
+# of supporting snapshots. A writable raw disk can be excluded
+# from the snapshot, though it means its data won't be restored
+# by later snapshot load operation.
+
+run_test "skip-raw" "diskfmt0" "[\"diskfmt0\", \"diskfmt1\"]" 0 0 0 \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt1','node-name':'disk1'}" \
+    -blockdev "{'driver':'qcow2','file':'disk1','node-name':'diskfmt1'}" \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG.alt2','node-name':'disk2'}" \
+    -blockdev "{'driver':'raw','file':'disk2','node-name':'diskfmt2'}"
+
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
+start_qemu \
+    -device virtio-rng \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+run_save "save-err-stderr" "diskfmt0" "[\"diskfmt0\"]" 0
+stop_qemu
+
+# leave off virtio-rng to provoke vmstate failure
+start_qemu \
+    -blockdev "{'driver':'file','filename':'$TEST_IMG','node-name':'disk0'}" \
+    -blockdev "{'driver':'qcow2','file':'disk0','node-name':'diskfmt0'}"
+
+run_load "load-err-stderr" "diskfmt0" "[\"diskfmt0\"]" 1
+run_delete "delete-err-stderr" "[\"diskfmt0\"]" 0
+
+stop_qemu
+
+# success, all done
+echo "*** done"
+rm -f $seq.full
+status=0
diff --git a/tests/qemu-iotests/310.out b/tests/qemu-iotests/310.out
new file mode 100644
index 0000000000..b2001b2551
--- /dev/null
+++ b/tests/qemu-iotests/310.out
@@ -0,0 +1,412 @@
+QA output created by 310
+Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.IMGFMT.alt1', fmt=IMGFMT size=134217728
+Formatting 'TEST_DIR/t.qcow2.alt2', fmt=IMGFMT size=134217728
+
+=====  Snapshot single qcow2 image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-simple", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "save-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "save-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-simple"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-simple"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-simple"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-simple"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-simple", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "load-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "load-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-simple"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-simple"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-simple"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-simple"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-simple", "tag": "snap0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "delete-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "delete-simple"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-simple"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-simple"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-simple"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-simple"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot no image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-no-image", "tag": "snap0", "vmstate": "diskfmt0", "devices": []}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "save-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-no-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-no-image", "error": "At least one device is required for snapshot"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-no-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-no-image"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-no-image", "tag": "snap0", "vmstate": "diskfmt0", "devices": []}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "load-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-no-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-no-image", "error": "At least one device is required for snapshot"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-no-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-no-image"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-no-image", "tag": "snap0", "devices": []}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "delete-no-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-no-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-no-image", "error": "At least one device is required for snapshot"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-no-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-no-image"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot missing image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-missing-image", "tag": "snap0", "vmstate": "diskfmt1729", "devices": ["diskfmt1729"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "save-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-missing-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-missing-image", "error": "No block device node 'diskfmt1729'"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-missing-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-missing-image"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-missing-image", "tag": "snap0", "vmstate": "diskfmt1729", "devices": ["diskfmt1729"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "load-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-missing-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-missing-image", "error": "No block device node 'diskfmt1729'"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-missing-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-missing-image"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-missing-image", "tag": "snap0", "devices": ["diskfmt1729"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "delete-missing-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-missing-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-missing-image", "error": "No block device node 'diskfmt1729'"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-missing-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-missing-image"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot vmstate not in devices list =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": { "job-id": "save-excluded-vmstate", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "save-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-excluded-vmstate"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-excluded-vmstate", "error": "vmstate block device 'diskfmt0' does not exist"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-excluded-vmstate"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-excluded-vmstate"}}
+{"execute": "snapshot-load", "arguments": { "job-id": "load-excluded-vmstate", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "load-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-excluded-vmstate"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-excluded-vmstate", "error": "Could not find snapshot 'snap0' on 'diskfmt1'"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-excluded-vmstate"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-excluded-vmstate"}}
+{"execute": "snapshot-delete", "arguments": { "job-id": "delete-excluded-vmstate", "tag": "snap0", "devices": ["diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "delete-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "delete-excluded-vmstate"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-excluded-vmstate"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-excluded-vmstate"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-excluded-vmstate"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-excluded-vmstate"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot protocol instead of format =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-proto-not-fmt", "tag": "snap0", "vmstate": "disk0", "devices": ["disk0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "save-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-proto-not-fmt"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-proto-not-fmt", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-proto-not-fmt"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-proto-not-fmt"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-proto-not-fmt", "tag": "snap0", "vmstate": "disk0", "devices": ["disk0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "load-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-proto-not-fmt"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-proto-not-fmt", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-proto-not-fmt"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-proto-not-fmt"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-proto-not-fmt", "tag": "snap0", "devices": ["disk0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "delete-proto-not-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-proto-not-fmt"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-proto-not-fmt", "error": "Device 'disk0' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-proto-not-fmt"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-proto-not-fmt"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot dual qcow2 image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-dual-image", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "save-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "save-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-dual-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-dual-image"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-dual-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-dual-image"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-dual-image", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "load-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "load-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-dual-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-dual-image"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-dual-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-dual-image"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-dual-image", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "delete-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "delete-dual-image"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-dual-image"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-dual-image"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-dual-image"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-dual-image"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot error with raw image =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-raw-fmt", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0", "diskfmt1", "diskfmt2"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "save-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-raw-fmt"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-raw-fmt", "error": "Device 'diskfmt2' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-raw-fmt"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-raw-fmt"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-raw-fmt", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0", "diskfmt1", "diskfmt2"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "load-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-raw-fmt"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-raw-fmt", "error": "Device 'diskfmt2' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-raw-fmt"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-raw-fmt"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-raw-fmt", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1", "diskfmt2"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "delete-raw-fmt"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-raw-fmt"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-raw-fmt", "error": "Device 'diskfmt2' is writable but does not support snapshots"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-raw-fmt"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-raw-fmt"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot with raw image excluded =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-skip-raw", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "save-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "save-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-skip-raw"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-skip-raw"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-skip-raw"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-skip-raw"}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-skip-raw", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "load-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "load-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-skip-raw"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-skip-raw"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-skip-raw"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-skip-raw"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-skip-raw", "tag": "snap0", "devices": ["diskfmt0", "diskfmt1"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "delete-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "delete-skip-raw"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-skip-raw"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-skip-raw"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-skip-raw"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-skip-raw"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+
+=====  Snapshot bad error reporting to stderr =====
+
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-save", "arguments": {"job-id": "save-err-stderr", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "save-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "save-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "RESUME"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "save-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "save-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "save-err-stderr"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-save", "id": "save-err-stderr"}]}
+{"execute": "job-dismiss", "arguments": {"id": "save-err-stderr"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "save-err-stderr"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+{"execute": "qmp_capabilities"}
+{"return": {}}
+{"execute": "snapshot-load", "arguments": {"job-id": "load-err-stderr", "tag": "snap0", "vmstate": "diskfmt0", "devices": ["diskfmt0"]}}
+qemu-system-x86_64: Unknown savevm section or instance '0000:00:02.0/virtio-rng' 0. Make sure that your current VM setup matches your saved VM setup, including any hotplugged devices
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "load-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "load-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "STOP"}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "aborting", "id": "load-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "load-err-stderr"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-load", "id": "load-err-stderr", "error": "Error -22 while loading VM state"}]}
+{"execute": "job-dismiss", "arguments": {"id": "load-err-stderr"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "load-err-stderr"}}
+{"execute": "snapshot-delete", "arguments": {"job-id": "delete-err-stderr", "tag": "snap0", "devices": ["diskfmt0"]}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "created", "id": "delete-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "running", "id": "delete-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "delete-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "delete-err-stderr"}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "concluded", "id": "delete-err-stderr"}}
+{"execute": "query-jobs"}
+{"return": [{"current-progress": 1, "status": "concluded", "total-progress": 1, "type": "snapshot-delete", "id": "delete-err-stderr"}]}
+{"execute": "job-dismiss", "arguments": {"id": "delete-err-stderr"}}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "JOB_STATUS_CHANGE", "data": {"status": "null", "id": "delete-err-stderr"}}
+{"execute": "quit"}
+{"return": {}}
+{"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "event": "SHUTDOWN", "data": {"guest": false, "reason": "host-qmp-quit"}}
+*** done
diff --git a/tests/qemu-iotests/group b/tests/qemu-iotests/group
index 5cad015231..30a04b38c8 100644
--- a/tests/qemu-iotests/group
+++ b/tests/qemu-iotests/group
@@ -291,6 +291,7 @@
 277 rw quick
 279 rw backing quick
 280 rw migration quick
+310 rw quick
 281 rw quick
 282 rw img quick
 283 auto quick
-- 
2.26.2


