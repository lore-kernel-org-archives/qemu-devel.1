Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99607C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:40:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C39B20872
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 11:40:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hwWcN146"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C39B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35614 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kI9Js-0006md-IT
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 07:40:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35820)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9Fo-0001PG-EC
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:36:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44607
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kI9Fk-0002vj-WF
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 07:36:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600169763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P9iiBhaZ4EZPuVwfELWDmms0fDtNc9iEMg7v0gMULxA=;
 b=hwWcN146UGpVwVVWcHywWRCrND8scK2chIDhBSFMsvcRaxP2ojfFYLae400rJBm2KXzBi6
 sJedHh0XjtyG/+beATjn7xR0GjmqElvXnnmB7bUfHb2MlmEbzpZ1otC9SU0PbY2Nt7AWyo
 Qw7Ayv3926J2A8xa4cbfPmaVM36ZNFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-b5YBrXi-PgaUhQ0h3DQBhw-1; Tue, 15 Sep 2020 07:36:02 -0400
X-MC-Unique: b5YBrXi-PgaUhQ0h3DQBhw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2622B1005E64;
 Tue, 15 Sep 2020 11:36:01 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.68])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4E0AA747B0;
 Tue, 15 Sep 2020 11:35:57 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 6/9] migration: wire up support for snapshot device
 selection
Date: Tue, 15 Sep 2020 12:35:20 +0100
Message-Id: <20200915113523.2520317-7-berrange@redhat.com>
In-Reply-To: <20200915113523.2520317-1-berrange@redhat.com>
References: <20200915113523.2520317-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.003
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/15 03:21:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Modify load_snapshot/save_snapshot to accept the device list and vmstate
node name parameters previously added to the block layer.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h | 12 ++++++++++--
 migration/savevm.c           | 24 ++++++++++++++----------
 monitor/hmp-cmds.c           |  4 ++--
 replay/replay-snapshot.c     |  4 ++--
 softmmu/vl.c                 |  2 +-
 5 files changed, 29 insertions(+), 17 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index d7db1174ef..b2c72e0a1b 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -15,7 +15,15 @@
 #ifndef QEMU_MIGRATION_SNAPSHOT_H
 #define QEMU_MIGRATION_SNAPSHOT_H
 
-int save_snapshot(const char *name, bool overwrite, Error **errp);
-int load_snapshot(const char *name, Error **errp);
+#include "qapi/qapi-builtin-types.h"
+
+int save_snapshot(const char *name, bool overwrite,
+                  const char *vmstate,
+                  bool has_devices, strList *devices,
+                  Error **errp);
+int load_snapshot(const char *name,
+                  const char *vmstate,
+                  bool has_devices, strList *devices,
+                  Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 2025e3e579..b3d2ce7045 100644
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
 
-int save_snapshot(const char *name, bool overwrite, Error **errp)
+int save_snapshot(const char *name, bool overwrite, const char *vmstate,
+                  bool has_devices, strList *devices, Error **errp)
 {
     BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2680,18 +2683,18 @@ int save_snapshot(const char *name, bool overwrite, Error **errp)
         return ret;
     }
 
-    if (!bdrv_all_can_snapshot(false, NULL, errp)) {
+    if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
         return ret;
     }
 
     /* Delete old snapshots of the same name */
     if (name && overwrite) {
-        if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
+        if (bdrv_all_delete_snapshot(name, has_devices, devices, errp) < 0) {
             return ret;
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(NULL, false, NULL, errp);
+    bs = bdrv_all_find_vmstate_bs(vmstate, has_devices, devices, errp);
     if (bs == NULL) {
         return ret;
     }
@@ -2757,7 +2760,7 @@ int save_snapshot(const char *name, bool overwrite, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, false, NULL, errp);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, has_devices, devices, errp);
     if (ret < 0) {
         goto the_end;
     }
@@ -2858,7 +2861,8 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_snapshot(const char *name, Error **errp)
+int load_snapshot(const char *name, const char *vmstate,
+                  bool has_devices, strList *devices, Error **errp)
 {
     BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2873,15 +2877,15 @@ int load_snapshot(const char *name, Error **errp)
         return -1;
     }
 
-    if (!bdrv_all_can_snapshot(false, NULL, errp)) {
+    if (!bdrv_all_can_snapshot(has_devices, devices, errp)) {
         return -1;
     }
-    ret = bdrv_all_find_snapshot(name, false, NULL, errp);
+    ret = bdrv_all_find_snapshot(name, has_devices, devices, errp);
     if (ret < 0) {
         return -1;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, false, NULL, errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(vmstate, has_devices, devices, errp);
     if (!bs_vm_state) {
         return -1;
     }
@@ -2902,7 +2906,7 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, false, NULL, errp);
+    ret = bdrv_all_goto_snapshot(name, has_devices, devices, errp);
     if (ret < 0) {
         goto err_drain;
     }
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index c1b8533d0c..1191aac3ae 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1121,7 +1121,7 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(name, &err) == 0 && saved_vm_running) {
+    if (load_snapshot(name, NULL, false, NULL, &err) == 0 && saved_vm_running) {
         vm_start();
     }
     hmp_handle_error(mon, err);
@@ -1131,7 +1131,7 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    save_snapshot(qdict_get_try_str(qdict, "name"), true, &err);
+    save_snapshot(qdict_get_try_str(qdict, "name"), true, NULL, false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 8e7ff97d11..8ed09177b5 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,13 +77,13 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_snapshot(replay_snapshot, true, &err) != 0) {
+            if (save_snapshot(replay_snapshot, true, NULL, false, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_snapshot(replay_snapshot, &err) != 0) {
+            if (load_snapshot(replay_snapshot, NULL, false, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f7b103467c..820d380229 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4459,7 +4459,7 @@ void qemu_init(int argc, char **argv, char **envp)
     register_global_state();
     if (loadvm) {
         Error *local_err = NULL;
-        if (load_snapshot(loadvm, &local_err) < 0) {
+        if (load_snapshot(loadvm, NULL, false, NULL, &local_err) < 0) {
             error_report_err(local_err);
             autostart = 0;
             exit(1);
-- 
2.26.2


