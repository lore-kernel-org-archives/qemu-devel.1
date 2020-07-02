Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 572E3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:05:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 247322063A
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R4hjEZNC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 247322063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3aX-0002Ld-Cw
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:05:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54566)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3Tr-0002EW-HA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:24718
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3Tp-0003mj-HQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593712716;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NROZs6HderGG4OkHrcO2CRQWMJbU1tMrf9Vi7ZxYT0w=;
 b=R4hjEZNCBXlkGlMVo3WBOusWBqHBggkYUFHUFXFRVJyn62EH3cvywgwMxGbcyBkRV5r3/Y
 otmnHsG7FWEGyOeBy5MXWD00ESTd/dbxsGA5ufmMlgBwNeuZX67q3wYx4UljBuGXqi65aB
 uJ1S1+tSjZLbR15NYhMb8WwwU9/vpTw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-2jf1QIiKNkaz73YUukb6ag-1; Thu, 02 Jul 2020 13:58:35 -0400
X-MC-Unique: 2jf1QIiKNkaz73YUukb6ag-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 28CC5185B3B3;
 Thu,  2 Jul 2020 17:58:34 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B17D25D9CA;
 Thu,  2 Jul 2020 17:58:30 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 6/6] migration: support picking vmstate disk in QMP snapshot
 commands
Date: Thu,  2 Jul 2020 18:57:54 +0100
Message-Id: <20200702175754.2211821-7-berrange@redhat.com>
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

This wires up support for a new "vmstate" parameter to the QMP commands
for snapshots (savevm, loadvm). This parameter accepts block driver
state node name.

One use case for this would be a VM using OVMF firmware where the
variables store is the first snapshottable disk image. The vmstate
snapshot usually wants to be stored in the primary root disk of the
VM, not the firmeware varstore. Thus there needs to be a mechanism
to override the default choice of disk.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 include/migration/snapshot.h |  8 ++++++--
 migration/savevm.c           | 16 ++++++++++------
 monitor/hmp-cmds.c           |  6 ++++--
 qapi/migration.json          |  6 ++++++
 replay/replay-snapshot.c     |  4 ++--
 softmmu/vl.c                 |  2 +-
 6 files changed, 29 insertions(+), 13 deletions(-)

diff --git a/include/migration/snapshot.h b/include/migration/snapshot.h
index dffb84dbe5..721147d3c1 100644
--- a/include/migration/snapshot.h
+++ b/include/migration/snapshot.h
@@ -17,7 +17,11 @@
 
 #include "qapi/qapi-builtin-types.h"
 
-int save_snapshot(const char *name, strList *exclude, Error **errp);
-int load_snapshot(const char *name, strList *exclude, Error **errp);
+int save_snapshot(const char *name,
+                  const char *vmstate, strList *exclude,
+                  Error **errp);
+int load_snapshot(const char *name,
+                  const char *vmstate, strList *exclude,
+                  Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 4b040676f7..5fd593e475 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2624,7 +2624,8 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
-int save_snapshot(const char *name, strList *exclude, Error **errp)
+int save_snapshot(const char *name, const char *vmstate,
+                  strList *exclude, Error **errp)
 {
     BlockDriverState *bs, *bs1;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
@@ -2662,7 +2663,7 @@ int save_snapshot(const char *name, strList *exclude, Error **errp)
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(NULL, exclude, errp);
+    bs = bdrv_all_find_vmstate_bs(vmstate, exclude, errp);
     if (bs == NULL) {
         return ret;
     }
@@ -2827,7 +2828,8 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
-int load_snapshot(const char *name, strList *exclude, Error **errp)
+int load_snapshot(const char *name, const char *vmstate,
+                  strList *exclude, Error **errp)
 {
     BlockDriverState *bs, *bs_vm_state;
     QEMUSnapshotInfo sn;
@@ -2856,7 +2858,7 @@ int load_snapshot(const char *name, strList *exclude, Error **errp)
         return ret;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, exclude, errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(vmstate, exclude, errp);
     if (!bs_vm_state) {
         return -ENOTSUP;
     }
@@ -2943,13 +2945,15 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 }
 
 void qmp_savevm(const char *tag,
+                bool has_vmstate, const char *vmstate,
                 bool has_exclude, strList *exclude,
                 Error **errp)
 {
-    save_snapshot(tag, exclude, errp);
+    save_snapshot(tag, vmstate, exclude, errp);
 }
 
 void qmp_loadvm(const char *tag,
+                bool has_vmstate, const char *vmstate,
                 bool has_exclude, strList *exclude,
                 Error **errp)
 {
@@ -2957,7 +2961,7 @@ void qmp_loadvm(const char *tag,
 
     vm_stop(RUN_STATE_RESTORE_VM);
 
-    if (load_snapshot(tag, exclude, errp) == 0 && saved_vm_running) {
+    if (load_snapshot(tag, vmstate, exclude, errp) == 0 && saved_vm_running) {
         vm_start();
     }
 }
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index fcde649100..586676e179 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1091,7 +1091,8 @@ void hmp_loadvm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    qmp_loadvm(qdict_get_str(qdict, "name"), false, NULL, &err);
+    qmp_loadvm(qdict_get_str(qdict, "name"),
+               false, NULL, false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
@@ -1099,7 +1100,8 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
 
-    qmp_savevm(qdict_get_try_str(qdict, "name"), false, NULL, &err);
+    qmp_savevm(qdict_get_try_str(qdict, "name"),
+               false, NULL, false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/qapi/migration.json b/qapi/migration.json
index 2388664077..91173f5b06 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1630,6 +1630,7 @@
 # @tag: name of the snapshot to create. If it already
 # exists it will be replaced.
 # @exclude: list of block device node names to exclude
+# @vmstate: block device node name to save vmstate to
 #
 # Note that execution of the VM will be paused during the time
 # it takes to save the snapshot
@@ -1641,6 +1642,7 @@
 # -> { "execute": "savevm",
 #      "data": {
 #         "tag": "my-snap",
+#         "vmstate": "disk0",
 #         "exclude": ["pflash0-vars"]
 #      }
 #    }
@@ -1650,6 +1652,7 @@
 ##
 { 'command': 'savevm',
   'data': { 'tag': 'str',
+            '*vmstate': 'str',
             '*exclude': ['str'] } }
 
 ##
@@ -1659,6 +1662,7 @@
 #
 # @tag: name of the snapshot to load.
 # @exclude: list of block device node names to exclude
+# @vmstate: block device node name to load vmstate from
 #
 # Returns: nothing
 #
@@ -1667,6 +1671,7 @@
 # -> { "execute": "loadvm",
 #      "data": {
 #         "tag": "my-snap",
+#         "vmstate": "disk0",
 #         "exclude": ["pflash0-vars"]
 #      }
 #    }
@@ -1676,6 +1681,7 @@
 ##
 { 'command': 'loadvm',
   'data': { 'tag': 'str',
+            '*vmstate': 'str',
             '*exclude': ['str'] } }
 
 ##
diff --git a/replay/replay-snapshot.c b/replay/replay-snapshot.c
index 1351170c67..f0f45a4f24 100644
--- a/replay/replay-snapshot.c
+++ b/replay/replay-snapshot.c
@@ -77,13 +77,13 @@ void replay_vmstate_init(void)
 
     if (replay_snapshot) {
         if (replay_mode == REPLAY_MODE_RECORD) {
-            if (save_snapshot(replay_snapshot, NULL, &err) != 0) {
+            if (save_snapshot(replay_snapshot, NULL, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not create snapshot for icount record");
                 exit(1);
             }
         } else if (replay_mode == REPLAY_MODE_PLAY) {
-            if (load_snapshot(replay_snapshot, NULL, &err) != 0) {
+            if (load_snapshot(replay_snapshot, NULL, NULL, &err) != 0) {
                 error_report_err(err);
                 error_report("Could not load snapshot for icount replay");
                 exit(1);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index f7c8be8c6a..fbaa326675 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -4452,7 +4452,7 @@ void qemu_init(int argc, char **argv, char **envp)
     register_global_state();
     if (loadvm) {
         Error *local_err = NULL;
-        if (load_snapshot(loadvm, NULL, &local_err) < 0) {
+        if (load_snapshot(loadvm, NULL, NULL, &local_err) < 0) {
             error_report_err(local_err);
             autostart = 0;
             exit(1);
-- 
2.26.2


