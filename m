Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77D5BC433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:04:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDBFB20760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:04:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dFn49tGR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDBFB20760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3ZK-0000xQ-Vi
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:04:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3To-00027q-2o
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:36 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47035
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3Tl-0003lM-S8
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593712713;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tWV/1I/IjGPsoIAyNec9bR5w4pDHH9o9N+zoRMO4Jdw=;
 b=dFn49tGR9DaRl6vk7RiXGt2zZVm8HmWH2dMiZ9nAYW/WJ1ThAecbm0AJRi8X4J/o9V0XMJ
 h4gPlyExcyItW5riPM+3q5JaiK6ltUxeYlCWuRxk1ocpspng0oUUCfkWM2beU3tZtKtr6P
 zgyGodRqXIgf1iDeNOvPZJW6PsRpQ7w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-jafgEZnzMAuxqUy91tq4fw-1; Thu, 02 Jul 2020 13:58:31 -0400
X-MC-Unique: jafgEZnzMAuxqUy91tq4fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4F3A8107ACCD;
 Thu,  2 Jul 2020 17:58:30 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A6BF95D9CA;
 Thu,  2 Jul 2020 17:58:26 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 5/6] migration: support excluding block devs in QMP snapshot
 commands
Date: Thu,  2 Jul 2020 18:57:53 +0100
Message-Id: <20200702175754.2211821-6-berrange@redhat.com>
In-Reply-To: <20200702175754.2211821-1-berrange@redhat.com>
References: <20200702175754.2211821-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 03:23:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
 qemu-block@nongnu.org, Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This wires up support for a new "exclude" parameter to the QMP commands
for snapshots (savevm, loadvm, delvm). This parameter accepts a list of
block driver state node names.

One use case for this would be a VM using OVMF firmware where the
variables store is a raw disk image. Ideally the variable store would be
qcow2, allowing its contents to be included in the snapshot, but
typically today the variable store is raw. It is still useful to be able
to snapshot VMs using OVMF, even if the varstore is excluded, as the
main OS disk content is usually the stuff the user cares about.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h |  6 ++++--
 migration/savevm.c           | 38 +++++++++++++++++++++---------------
 monitor/hmp-cmds.c           |  6 +++---
 qapi/migration.json          | 21 ++++++++++++++------
 replay/replay-snapshot.c     |  4 ++--
 softmmu/vl.c                 |  2 +-
 6 files changed, 47 insertions(+), 30 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index c85b6ec75b..dffb84dbe5 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -15,7 +15,9 @@
 #ifndef QEMU_MIGRATION_SNAPSHOT_H
 #define QEMU_MIGRATION_SNAPSHOT_H
 
-int save_snapshot(const char *name, Error **errp);
-int load_snapshot(const char *name, Error **errp);
+#include "qapi/qapi-builtin-types.h"
+
+int save_snapshot(const char *name, strList *exclude, Error **errp);
+int load_snapshot(const char *name, strList *exclude, Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index b11c6a882d..4b040676f7 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2624,7 +2624,7 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-int save_snapshot(const char *name, Error **errp)
+int save_snapshot(const char *name, strList *exclude, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2646,7 +2646,7 @@ int save_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    if (!bdrv_all_can_snapshot(NULL, &bs)) {
+    if (!bdrv_all_can_snapshot(exclude, &bs)) {
         error_setg(errp, "Device '%s' is writable but does not support "
                    "snapshots", bdrv_get_device_or_node_name(bs));
         return ret;
@@ -2654,7 +2654,7 @@ int save_snapshot(const char *name, Error **errp)
 
     /* Delete old snapshots of the same name */
     if (name) {
-        ret = bdrv_all_delete_snapshot(name, NULL, &bs1, errp);
+        ret = bdrv_all_delete_snapshot(name, exclude, &bs1, errp);
         if (ret < 0) {
             error_prepend(errp, "Error while deleting snapshot on device "
                           "'%s': ", bdrv_get_device_or_node_name(bs1));
@@ -2662,7 +2662,7 @@ int save_snapshot(const char *name, Error **errp)
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
+    bs = bdrv_all_find_vmstate_bs(NULL, exclude, errp);
     if (bs == NULL) {
         return ret;
     }
@@ -2724,7 +2724,7 @@ int save_snapshot(const char *name, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, NULL, &bs);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, exclude, &bs);
     if (ret < 0) {
         error_setg(errp, "Error while creating snapshot on '%s'",
                    bdrv_get_device_or_node_name(bs));
@@ -2827,7 +2827,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_snapshot(const char *name, Error **errp)
+int load_snapshot(const char *name, strList *exclude, Error **errp)
 {
     BlockDriverState *bs, *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2842,13 +2842,13 @@ int load_snapshot(const char *name, Error **errp)
         return -EINVAL;
     }
 
-    if (!bdrv_all_can_snapshot(NULL, &bs)) {
+    if (!bdrv_all_can_snapshot(exclude, &bs)) {
         error_setg(errp,
                    "Device '%s' is writable but does not support snapshots",
                    bdrv_get_device_or_node_name(bs));
         return -ENOTSUP;
     }
-    ret = bdrv_all_find_snapshot(name, NULL, &bs);
+    ret = bdrv_all_find_snapshot(name, exclude, &bs);
     if (ret < 0) {
         error_setg(errp,
                    "Device '%s' does not have the requested snapshot '%s'",
@@ -2856,7 +2856,7 @@ int load_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, exclude, errp);
     if (!bs_vm_state) {
         return -ENOTSUP;
     }
@@ -2877,7 +2877,7 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, NULL, &bs, errp);
+    ret = bdrv_all_goto_snapshot(name, exclude, &bs, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
                       name, bdrv_get_device_or_node_name(bs));
@@ -2942,27 +2942,33 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
     return !(vmsd && vmsd->unmigratable);
 }
 
-void qmp_savevm(const char *tag, Error **errp)
+void qmp_savevm(const char *tag,
+                bool has_exclude, strList *exclude,
+                Error **errp)
 {
-    save_snapshot(tag, errp);
+    save_snapshot(tag, exclude, errp);
 }
 
-void qmp_loadvm(const char *tag, Error **errp)
+void qmp_loadvm(const char *tag,
+                bool has_exclude, strList *exclude,
+                Error **errp)
 {
     int saved_vm_running  = runstate_is_running();
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(tag, errp) == 0 && saved_vm_running) {
+    if (load_snapshot(tag, exclude, errp) == 0 && saved_vm_running) {
         vm_start();
     }
 }
 
-void qmp_delvm(const char *tag, Error **errp)
+void qmp_delvm(const char *tag,
+               bool has_exclude, strList *exclude,
+               Error **errp)
 {
     BlockDriverState *bs;
 
-    if (bdrv_all_delete_snapshot(tag, NULL, &bs, errp) < 0) {
+    if (bdrv_all_delete_snapshot(tag, exclude, &bs, errp) < 0) {
         error_prepend(errp,
                       "deleting snapshot on device '%s': ",
                       bdrv_get_device_or_node_name(bs));
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 26a5a1a701..fcde649100 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1091,7 +1091,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    qmp_loadvm(qdict_get_str(qdict, "name"), &err);
+    qmp_loadvm(qdict_get_str(qdict, "name"), false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
@@ -1099,7 +1099,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    qmp_savevm(qdict_get_try_str(qdict, "name"), &err);
+    qmp_savevm(qdict_get_try_str(qdict, "name"), false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
@@ -1107,7 +1107,7 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    qmp_delvm(qdict_get_str(qdict, "name"), &err);
+    qmp_delvm(qdict_get_str(qdict, "name"), false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 849de38fb0..2388664077 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1629,6 +1629,7 @@
 #
 # @tag: name of the snapshot to create. If it already
 # exists it will be replaced.
+# @exclude: list of block device node names to exclude
 #
 # Note that execution of the VM will be paused during the time
 # it takes to save the snapshot
@@ -1639,7 +1640,8 @@
 #
 # -> { "execute": "savevm",
 #      "data": {
-#         "tag": "my-snap"
+#         "tag": "my-snap",
+#         "exclude": ["pflash0-vars"]
 #      }
 #    }
 # <- { "return": { } }
@@ -1647,7 +1649,8 @@
 # Since: 5.2
 ##
 { 'command': 'savevm',
-  'data': { 'tag': 'str' } }
+  'data': { 'tag': 'str',
+            '*exclude': ['str'] } }
 
 ##
 # @loadvm:
@@ -1655,6 +1658,7 @@
 # Load a VM snapshot
 #
 # @tag: name of the snapshot to load.
+# @exclude: list of block device node names to exclude
 #
 # Returns: nothing
 #
@@ -1662,7 +1666,8 @@
 #
 # -> { "execute": "loadvm",
 #      "data": {
-#         "tag": "my-snap"
+#         "tag": "my-snap",
+#         "exclude": ["pflash0-vars"]
 #      }
 #    }
 # <- { "return": { } }
@@ -1670,7 +1675,8 @@
 # Since: 5.2
 ##
 { 'command': 'loadvm',
-  'data': { 'tag': 'str' } }
+  'data': { 'tag': 'str',
+            '*exclude': ['str'] } }
 
 ##
 # @delvm:
@@ -1678,6 +1684,7 @@
 # Delete a VM snapshot
 #
 # @tag: name of the snapshot to delete.
+# @exclude: list of block device node names to exclude
 #
 # Note that execution of the VM will be paused during the time
 # it takes to delete the snapshot
@@ -1688,7 +1695,8 @@
 #
 # -> { "execute": "delvm",
 #      "data": {
-#         "tag": "my-snap"
+#         "tag": "my-snap",
+#         "exclude": ["pflash0-vars"]
 #      }
 #    }
 # <- { "return": { } }
@@ -1696,4 +1704,5 @@
 # Since: 5.2
 ##
 { 'command': 'delvm',
-  'data': { 'tag': 'str' } }
+  'data': { 'tag': 'str',
+            '*exclude': ['str'] } }
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index e26fa4c892..1351170c67 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,13 +77,13 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_snapshot(replay_snapshot, &err) != 0) {
+            if (save_snapshot(replay_snapshot, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_snapshot(replay_snapshot, &err) != 0) {
+            if (load_snapshot(replay_snapshot, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 3e15ee2435..f7c8be8c6a 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4452,7 +4452,7 @@ void qemu_init(int argc, char **argv, char **envp)
     register_global_state();
     if (loadvm) {
         Error *local_err = NULL;
-        if (load_snapshot(loadvm, &local_err) < 0) {
+        if (load_snapshot(loadvm, NULL, &local_err) < 0) {
             error_report_err(local_err);
             autostart = 0;
             exit(1);
-- 
2.26.2


