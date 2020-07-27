Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C68C433E3
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:10:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9EE272064B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:10:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MKg7uAwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9EE272064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40878 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04lb-0007vc-Ok
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:10:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37632)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04kV-0006El-72
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:28701
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04kS-0007dm-1r
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595862543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R0Th0UswnVz9gYW4KO6h6mHyTLrvC+U1InlHF1lf9jE=;
 b=MKg7uAwTwVU5EcVKYiJw5Tx6uV/AiOSox5DUUqk8Zh30yP+GvKBwiCgW2OVx5rtwjj18VU
 n82nuW6FUA7FRZOCkA7ieb5smb58uW8GXrn4d4AyX0DCbXM7wdujjB1J4D2xsX+LQ+mp9H
 yfPIdODBd+WrJo+s5ns5mRdtegEza6I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-9JIy-wSwNKSz0FyOi6W1Sg-1; Mon, 27 Jul 2020 11:08:59 -0400
X-MC-Unique: 9JIy-wSwNKSz0FyOi6W1Sg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16A78805723;
 Mon, 27 Jul 2020 15:08:58 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1054B60BF4;
 Mon, 27 Jul 2020 15:08:54 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/6] block: push error reporting into bdrv_all_*_snapshot
 functions
Date: Mon, 27 Jul 2020 16:08:39 +0100
Message-Id: <20200727150843.3419256-3-berrange@redhat.com>
In-Reply-To: <20200727150843.3419256-1-berrange@redhat.com>
References: <20200727150843.3419256-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 00:16:29
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The bdrv_all_*_snapshot functions return a BlockDriverState pointer
for the invalid backend, which the callers then use to report an
error message. In some cases multiple callers are reporting the
same error message, but with slightly different text. In the future
there will be more error scenarios for some of these methods, which
will benefit from fine grained error message reporting. So it is
helpful to push error reporting down a level.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/monitor/block-hmp-cmds.c |  7 ++--
 block/snapshot.c               | 77 +++++++++++++++++-----------------
 include/block/snapshot.h       | 14 +++----
 migration/savevm.c             | 37 +++++-----------
 monitor/hmp-cmds.c             |  7 +---
 tests/qemu-iotests/267.out     | 10 ++---
 6 files changed, 65 insertions(+), 87 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 4c8c375172..9df11494d6 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -898,10 +898,11 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
 
     ImageEntry *image_entry, *next_ie;
     SnapshotEntry *snapshot_entry;
+    Error *err = NULL;
 
-    bs = bdrv_all_find_vmstate_bs();
+    bs = bdrv_all_find_vmstate_bs(&err);
     if (!bs) {
-        monitor_printf(mon, "No available block device supports snapshots\n");
+        error_report_err(err);
         return;
     }
     aio_context = bdrv_get_aio_context(bs);
@@ -951,7 +952,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     total = 0;
     for (i = 0; i < nb_sns; i++) {
         SnapshotEntry *next_sn;
-        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs1) == 0) {
+        if (bdrv_all_find_snapshot(sn_tab[i].name, NULL) == 0) {
             global_snapshots[total] = i;
             total++;
             QTAILQ_FOREACH(image_entry, &image_list, next) {
diff --git a/block/snapshot.c b/block/snapshot.c
index bd9fb01817..6839060622 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -400,14 +400,14 @@ static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
  * These functions will properly handle dataplane (take aio_context_acquire
  * when appropriate for appropriate block drivers) */
 
-bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
+bool bdrv_all_can_snapshot(Error **errp)
 {
-    bool ok = true;
     BlockDriverState *bs;
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *ctx = bdrv_get_aio_context(bs);
+        bool ok;
 
         aio_context_acquire(ctx);
         if (bdrv_all_snapshots_includes_bs(bs)) {
@@ -415,26 +415,25 @@ bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
         }
         aio_context_release(ctx);
         if (!ok) {
+            error_setg(errp, "Device '%s' is writable but does not support "
+                       "snapshots", bdrv_get_device_or_node_name(bs));
             bdrv_next_cleanup(&it);
-            goto fail;
+            return false;
         }
     }
 
-fail:
-    *first_bad_bs = bs;
-    return ok;
+    return true;
 }
 
-int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
-                             Error **errp)
+int bdrv_all_delete_snapshot(const char *name, Error **errp)
 {
-    int ret = 0;
     BlockDriverState *bs;
     BdrvNextIterator it;
     QEMUSnapshotInfo sn1, *snapshot = &sn1;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *ctx = bdrv_get_aio_context(bs);
+        int ret;
 
         aio_context_acquire(ctx);
         if (bdrv_all_snapshots_includes_bs(bs) &&
@@ -445,26 +444,25 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
         }
         aio_context_release(ctx);
         if (ret < 0) {
+            error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
+                          name, bdrv_get_device_or_node_name(bs));
             bdrv_next_cleanup(&it);
-            goto fail;
+            return -1;
         }
     }
 
-fail:
-    *first_bad_bs = bs;
-    return ret;
+    return 0;
 }
 
 
-int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
-                           Error **errp)
+int bdrv_all_goto_snapshot(const char *name, Error **errp)
 {
-    int ret = 0;
     BlockDriverState *bs;
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *ctx = bdrv_get_aio_context(bs);
+        int ret;
 
         aio_context_acquire(ctx);
         if (bdrv_all_snapshots_includes_bs(bs)) {
@@ -472,75 +470,75 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
         }
         aio_context_release(ctx);
         if (ret < 0) {
+            error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
+                          name, bdrv_get_device_or_node_name(bs));
             bdrv_next_cleanup(&it);
-            goto fail;
+            return -1;
         }
     }
 
-fail:
-    *first_bad_bs = bs;
-    return ret;
+    return 0;
 }
 
-int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
+int bdrv_all_find_snapshot(const char *name, Error **errp)
 {
     QEMUSnapshotInfo sn;
-    int err = 0;
     BlockDriverState *bs;
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *ctx = bdrv_get_aio_context(bs);
+        int ret;
 
         aio_context_acquire(ctx);
         if (bdrv_all_snapshots_includes_bs(bs)) {
-            err = bdrv_snapshot_find(bs, &sn, name);
+            ret = bdrv_snapshot_find(bs, &sn, name);
         }
         aio_context_release(ctx);
-        if (err < 0) {
+        if (ret < 0) {
+            error_setg(errp, "Could not find snapshot '%s' on '%s'",
+                       name, bdrv_get_device_or_node_name(bs));
             bdrv_next_cleanup(&it);
-            goto fail;
+            return -1;
         }
     }
 
-fail:
-    *first_bad_bs = bs;
-    return err;
+    return 0;
 }
 
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
                              uint64_t vm_state_size,
-                             BlockDriverState **first_bad_bs)
+                             Error **errp)
 {
-    int err = 0;
     BlockDriverState *bs;
     BdrvNextIterator it;
 
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *ctx = bdrv_get_aio_context(bs);
+        int ret;
 
         aio_context_acquire(ctx);
         if (bs == vm_state_bs) {
             sn->vm_state_size = vm_state_size;
-            err = bdrv_snapshot_create(bs, sn);
+            ret = bdrv_snapshot_create(bs, sn);
         } else if (bdrv_all_snapshots_includes_bs(bs)) {
             sn->vm_state_size = 0;
-            err = bdrv_snapshot_create(bs, sn);
+            ret = bdrv_snapshot_create(bs, sn);
         }
         aio_context_release(ctx);
-        if (err < 0) {
+        if (ret < 0) {
+            error_setg(errp, "Could not create snapshot '%s' on '%s'",
+                       sn->name, bdrv_get_device_or_node_name(bs));
             bdrv_next_cleanup(&it);
-            goto fail;
+            return -1;
         }
     }
 
-fail:
-    *first_bad_bs = bs;
-    return err;
+    return 0;
 }
 
-BlockDriverState *bdrv_all_find_vmstate_bs(void)
+BlockDriverState *bdrv_all_find_vmstate_bs(Error **errp)
 {
     BlockDriverState *bs;
     BdrvNextIterator it;
@@ -558,5 +556,8 @@ BlockDriverState *bdrv_all_find_vmstate_bs(void)
             break;
         }
     }
+    if (!bs) {
+        error_setg(errp, "No block device supports snapshots");
+    }
     return bs;
 }
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 2bfcd57578..ba1528eee0 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -76,17 +76,15 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
  * These functions will properly handle dataplane (take aio_context_acquire
  * when appropriate for appropriate block drivers */
 
-bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs);
-int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bsd_bs,
-                             Error **errp);
-int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
-                           Error **errp);
-int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs);
+bool bdrv_all_can_snapshot(Error **errp);
+int bdrv_all_delete_snapshot(const char *name, Error **errp);
+int bdrv_all_goto_snapshot(const char *name, Error **errp);
+int bdrv_all_find_snapshot(const char *name, Error **errp);
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
                              uint64_t vm_state_size,
-                             BlockDriverState **first_bad_bs);
+                             Error **errp);
 
-BlockDriverState *bdrv_all_find_vmstate_bs(void);
+BlockDriverState *bdrv_all_find_vmstate_bs(Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index cffee6cab7..19259ef7c0 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2633,7 +2633,7 @@ int qemu_load_device_state(QEMUFile *f)
 
 int save_snapshot(const char *name, Error **errp)
 {
-    BlockDriverState *bs, *bs1;
+    BlockDriverState *bs;
     QEMUSnapshotInfo sn1, *sn = &sn1, old_sn1, *old_sn = &old_sn1;
     int ret = -1, ret2;
     QEMUFile *f;
@@ -2653,25 +2653,19 @@ int save_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    if (!bdrv_all_can_snapshot(&bs)) {
-        error_setg(errp, "Device '%s' is writable but does not support "
-                   "snapshots", bdrv_get_device_or_node_name(bs));
+    if (!bdrv_all_can_snapshot(errp)) {
         return ret;
     }
 
     /* Delete old snapshots of the same name */
     if (name) {
-        ret = bdrv_all_delete_snapshot(name, &bs1, errp);
-        if (ret < 0) {
-            error_prepend(errp, "Error while deleting snapshot on device "
-                          "'%s': ", bdrv_get_device_or_node_name(bs1));
+        if (bdrv_all_delete_snapshot(name, errp) < 0) {
             return ret;
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs();
+    bs = bdrv_all_find_vmstate_bs(errp);
     if (bs == NULL) {
-        error_setg(errp, "No block device can accept snapshots");
         return ret;
     }
     aio_context = bdrv_get_aio_context(bs);
@@ -2736,10 +2730,8 @@ int save_snapshot(const char *name, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, errp);
     if (ret < 0) {
-        error_setg(errp, "Error while creating snapshot on '%s'",
-                   bdrv_get_device_or_node_name(bs));
         goto the_end;
     }
 
@@ -2841,7 +2833,7 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
 
 int load_snapshot(const char *name, Error **errp)
 {
-    BlockDriverState *bs, *bs_vm_state;
+    BlockDriverState *bs_vm_state;
     QEMUSnapshotInfo sn;
     QEMUFile *f;
     int ret;
@@ -2854,23 +2846,16 @@ int load_snapshot(const char *name, Error **errp)
         return -EINVAL;
     }
 
-    if (!bdrv_all_can_snapshot(&bs)) {
-        error_setg(errp,
-                   "Device '%s' is writable but does not support snapshots",
-                   bdrv_get_device_or_node_name(bs));
+    if (!bdrv_all_can_snapshot(errp)) {
         return -ENOTSUP;
     }
-    ret = bdrv_all_find_snapshot(name, &bs);
+    ret = bdrv_all_find_snapshot(name, errp);
     if (ret < 0) {
-        error_setg(errp,
-                   "Device '%s' does not have the requested snapshot '%s'",
-                   bdrv_get_device_or_node_name(bs), name);
         return ret;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs();
+    bs_vm_state = bdrv_all_find_vmstate_bs(errp);
     if (!bs_vm_state) {
-        error_setg(errp, "No block device supports snapshots");
         return -ENOTSUP;
     }
     aio_context = bdrv_get_aio_context(bs_vm_state);
@@ -2890,10 +2875,8 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, &bs, errp);
+    ret = bdrv_all_goto_snapshot(name, errp);
     if (ret < 0) {
-        error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
-                      name, bdrv_get_device_or_node_name(bs));
         goto err_drain;
     }
 
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ae4b6a4246..52f7d322e1 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1111,15 +1111,10 @@ void hmp_savevm(Monitor *mon, const QDict *qdict)
 
 void hmp_delvm(Monitor *mon, const QDict *qdict)
 {
-    BlockDriverState *bs;
     Error *err = NULL;
     const char *name = qdict_get_str(qdict, "name");
 
-    if (bdrv_all_delete_snapshot(name, &bs, &err) < 0) {
-        error_prepend(&err,
-                      "deleting snapshot on device '%s': ",
-                      bdrv_get_device_name(bs));
-    }
+    bdrv_all_delete_snapshot(name, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/tests/qemu-iotests/267.out b/tests/qemu-iotests/267.out
index 215902b3ad..c65cce893a 100644
--- a/tests/qemu-iotests/267.out
+++ b/tests/qemu-iotests/267.out
@@ -6,9 +6,9 @@ Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=134217728
 Testing:
 QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
-Error: No block device can accept snapshots
+Error: No block device supports snapshots
 (qemu) info snapshots
-No available block device supports snapshots
+No block device supports snapshots
 (qemu) loadvm snap0
 Error: No block device supports snapshots
 (qemu) quit
@@ -22,7 +22,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 Error: Device 'none0' is writable but does not support snapshots
 (qemu) info snapshots
-No available block device supports snapshots
+No block device supports snapshots
 (qemu) loadvm snap0
 Error: Device 'none0' is writable but does not support snapshots
 (qemu) quit
@@ -58,7 +58,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 Error: Device 'virtio0' is writable but does not support snapshots
 (qemu) info snapshots
-No available block device supports snapshots
+No block device supports snapshots
 (qemu) loadvm snap0
 Error: Device 'virtio0' is writable but does not support snapshots
 (qemu) quit
@@ -83,7 +83,7 @@ QEMU X.Y.Z monitor - type 'help' for more information
 (qemu) savevm snap0
 Error: Device 'file' is writable but does not support snapshots
 (qemu) info snapshots
-No available block device supports snapshots
+No block device supports snapshots
 (qemu) loadvm snap0
 Error: Device 'file' is writable but does not support snapshots
 (qemu) quit
-- 
2.26.2


