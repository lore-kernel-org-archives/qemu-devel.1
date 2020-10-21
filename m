Return-Path: <SRS0=0rPh=D4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0154C388F9
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:33:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 19E9620872
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2020 16:33:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AauFFVsU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 19E9620872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVH3d-0007z6-1Q
	for qemu-devel@archiver.kernel.org; Wed, 21 Oct 2020 12:33:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59602)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVGyH-0002QG-36
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:28:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:53502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kVGy0-0004w4-HG
 for qemu-devel@nongnu.org; Wed, 21 Oct 2020 12:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603297676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F/lJ7b5QHazwE44O5W/DfjoU/L5X0g+BgPFuUSBaWtA=;
 b=AauFFVsUIOWJDJv+ZuuTH7vFTgxxUMdyj+nFmwpZxf5XOO0YB4G2O/mch5BUOvqVXlMwIC
 XfYzCBphXjt0u3m9uBX02UGhhKs2pR6LGt3mnc8kFdkkf0qkbtpPX5GA3TDy8ZB/gUYCxO
 DNIcdcVzWobKMD75pDiJvL8Po2p9K68=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-193-vTZR2DFcOg-NZSpXuQ29lw-1; Wed, 21 Oct 2020 12:27:53 -0400
X-MC-Unique: vTZR2DFcOg-NZSpXuQ29lw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A7CC61074665;
 Wed, 21 Oct 2020 16:27:52 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E36C910013C1;
 Wed, 21 Oct 2020 16:27:40 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 08/11] migration: wire up support for snapshot device
 selection
Date: Wed, 21 Oct 2020 17:27:01 +0100
Message-Id: <20201021162704.3652555-9-berrange@redhat.com>
In-Reply-To: <20201021162704.3652555-1-berrange@redhat.com>
References: <20201021162704.3652555-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/21 02:16:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Modify load_snapshot/save_snapshot to accept the device list and vmstate
node name parameters previously added to the block layer.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h | 18 ++++++++++++++++--
 migration/savevm.c           | 28 +++++++++++++++++-----------
 monitor/hmp-cmds.c           |  5 +++--
 replay/replay-debugging.c    |  4 ++--
 replay/replay-snapshot.c     |  5 +++--
 softmmu/vl.c                 |  2 +-
 6 files changed, 42 insertions(+), 20 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index d8c22d343c..3bdbef435b 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -15,23 +15,37 @@
 #ifndef QEMU_MIGRATION_SNAPSHOT_H
 #define QEMU_MIGRATION_SNAPSHOT_H
 
+#include "qapi/qapi-builtin-types.h"
+
 /**
  * save_snapshot: Save an internal snapshot.
  * @name: name of internal snapshot
  * @overwrite: replace existing snapshot with @name
+ * @vmstate: blockdev node name to store VM state in
+ * @has_devices: whether to use explicit device list
+ * @devices: explicit device list to snapshot
  * @errp: pointer to error object
  * On success, return %true.
  * On failure, store an error through @errp and return %false.
  */
-bool save_snapshot(const char *name, bool overwrite, Error **errp);
+bool save_snapshot(const char *name, bool overwrite,
+                   const char *vmstate,
+                   bool has_devices, strList *devices,
+                   Error **errp);
 
 /**
  * load_snapshot: Load an internal snapshot.
  * @name: name of internal snapshot
+ * @vmstate: blockdev node name to load VM state from
+ * @has_devices: whether to use explicit device list
+ * @devices: explicit device list to snapshot
  * @errp: pointer to error object
  * On success, return %true.
  * On failure, store an error through @errp and return %false.
  */
-bool load_snapshot(const char *name, Error **errp);
+bool load_snapshot(const char *name,
+                   const char *vmstate,
+                   bool has_devices, strList *devices,
+                   Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 4f194e95cc..59ad94ed14 100644
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
 
-bool save_snapshot(const char *name, bool overwrite, Error **errp)
+bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
+                  bool has_devices, strList *devices, Error **errp)
 {
     BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2680,18 +2683,19 @@ bool save_snapshot(const char *name, bool overwrite, Error **errp)
         return false;
     }
 
-    if (!bdrv_all_can_snapshot(false, NULL, errp)) {
+    if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
         return false;
     }
 
     /* Delete old snapshots of the same name */
     if (name) {
         if (overwrite) {
-            if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
+            if (bdrv_all_delete_snapshot(name, has_devices,
+                                         devices, errp) < 0) {
                 return false;
             }
         } else {
-            ret2 = bdrv_all_has_snapshot(name, false, NULL, errp);
+            ret2 = bdrv_all_has_snapshot(name, has_devices, devices, errp);
             if (ret2 < 0) {
                 return false;
             }
@@ -2704,7 +2708,7 @@ bool save_snapshot(const char *name, bool overwrite, Error **errp)
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, errp);
+    bs = bdrv_all_find_vmstate_bs(vmstate, has_devices, devices, errp);
     if (bs == NULL) {
         return false;
     }
@@ -2775,7 +2779,8 @@ bool save_snapshot(const char *name, bool overwrite, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, false, NULL, errp);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size,
+                                   has_devices, devices, errp);
     if (ret < 0) {
         goto the_end;
     }
@@ -2877,7 +2882,8 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-bool load_snapshot(const char *name, Error **errp)
+bool load_snapshot(const char *name, const char *vmstate,
+                   bool has_devices, strList *devices, Error **errp)
 {
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2886,10 +2892,10 @@ bool load_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!bdrv_all_can_snapshot(false, NULL, errp)) {
+    if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
         return false;
     }
-    ret = bdrv_all_has_snapshot(name, false, NULL, errp);
+    ret = bdrv_all_has_snapshot(name, has_devices, devices, errp);
     if (ret < 0) {
         return false;
     }
@@ -2899,7 +2905,7 @@ bool load_snapshot(const char *name, Error **errp)
         return -1;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, false, NULL, errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(vmstate, has_devices, devices, errp);
     if (!bs_vm_state) {
         return false;
     }
@@ -2926,7 +2932,7 @@ bool load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, false, NULL, errp);
+    ret = bdrv_all_goto_snapshot(name, has_devices, devices, errp);
     if (ret < 0) {
         goto err_drain;
     }
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index d92398e1c8..fdb8188e44 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1123,7 +1123,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (!load_snapshot(name, &err) && saved_vm_running) {
+    if (!load_snapshot(name, NULL, false, NULL, &err) && saved_vm_running) {
         vm_start();
     }
     hmp_handle_error(mon, err);
@@ -1133,7 +1133,8 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_snapshot(qdict_get_try_str(qdict, "name"), true, &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"),
+                  true, NULL, false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 2d21711fc2..a25b53d014 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -197,7 +197,7 @@ static void replay_seek(int64_t icount, QEMUTimerCB callback, Error **errp)
         if (icount < replay_get_current_icount()
             || replay_get_current_icount() < snapshot_icount) {
             vm_stop(RUN_STATE_RESTORE_VM);
-            load_snapshot(snapshot, errp);
+            load_snapshot(snapshot, NULL, false, NULL, errp);
         }
         g_free(snapshot);
     }
@@ -331,7 +331,7 @@ void replay_gdb_attached(void)
      */
     if (replay_mode == REPLAY_MODE_PLAY
         && !replay_snapshot) {
-        if (!save_snapshot("start_debugging", true, NULL)) {
+        if (!save_snapshot("start_debugging", true, NULL, false, NULL, NULL)) {
             /* Can't create the snapshot. Continue conventional debugging. */
         }
     }
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 31c5a8702b..e8767a1937 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,13 +77,14 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (!save_snapshot(replay_snapshot, true, &err)) {
+            if (!save_snapshot(replay_snapshot,
+                               true, NULL, false, NULL, &err)) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (!load_snapshot(replay_snapshot, &err)) {
+            if (!load_snapshot(replay_snapshot, NULL, false, NULL, &err)) {
                 error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 495a980db0..7570db412e 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4484,7 +4484,7 @@ void qemu_init(int argc, char **argv, char **envp)
     register_global_state();
     if (loadvm) {
         Error *local_err = NULL;
-        if (!load_snapshot(loadvm, &local_err)) {
+        if (!load_snapshot(loadvm, NULL, false, NULL, &local_err)) {
             error_report_err(local_err);
             autostart = 0;
             exit(1);
-- 
2.26.2


