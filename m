Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32F3C433DF
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:01:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FA6120760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:01:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dM1ktG3o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FA6120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3Ww-0006bt-RJ
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:01:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54496)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3Tj-0001xC-KA
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44041
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3Th-0003kg-DQ
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593712708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7HPFMl02Y9MD4a4CgpIrdA3TQqVD3NTJ3aR1ejGSUMI=;
 b=dM1ktG3o6dVWj3HJQZuSbLSQBHBO2joGdQTa+z5+B5pbzQeYnLzncNpgphmdF+omelUzXU
 fSa5QlLKAU7rIHfw/WlED6NQPROZ856/e9Fj+qRi2WO3SSHoX48THk5OWVJ+TqdQSMlxsa
 I5QJwJqi0XPKOjQ9u0KAFsUY05+Zqbw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-FQVN0H24Np-A8zuE12P91w-1; Thu, 02 Jul 2020 13:58:24 -0400
X-MC-Unique: FQVN0H24Np-A8zuE12P91w-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C6CE10059AB;
 Thu,  2 Jul 2020 17:58:22 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A36465D9CA;
 Thu,  2 Jul 2020 17:58:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 3/6] block: add ability to filter out blockdevs during snapshot
Date: Thu,  2 Jul 2020 18:57:51 +0100
Message-Id: <20200702175754.2211821-4-berrange@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

When executing snapshot logic, currently blockdevs are filtered out if
they are read-only or if there is no media present. In order to support
snapshotting when UEFI firmware is in use, we need the ability to filter
out the blockdev used for the firmware vars store. This can be achieved
by having a list of node names that should be excluded from
consideration for snapshots.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/monitor/block-hmp-cmds.c |  4 ++--
 block/snapshot.c               | 41 ++++++++++++++++++++++------------
 include/block/snapshot.h       | 19 +++++++++-------
 migration/savevm.c             | 18 +++++++--------
 4 files changed, 49 insertions(+), 33 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 4c8c375172..0ee6e7a4be 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -899,7 +899,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     ImageEntry *image_entry, *next_ie;
     SnapshotEntry *snapshot_entry;
 
-    bs = bdrv_all_find_vmstate_bs();
+    bs = bdrv_all_find_vmstate_bs(NULL);
     if (!bs) {
         monitor_printf(mon, "No available block device supports snapshots\n");
         return;
@@ -951,7 +951,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     total = 0;
     for (i = 0; i < nb_sns; i++) {
         SnapshotEntry *next_sn;
-        if (bdrv_all_find_snapshot(sn_tab[i].name, &bs1) == 0) {
+        if (bdrv_all_find_snapshot(sn_tab[i].name, NULL, &bs1) == 0) {
             global_snapshots[total] = i;
             total++;
             QTAILQ_FOREACH(image_entry, &image_list, next) {
diff --git a/block/snapshot.c b/block/snapshot.c
index bd9fb01817..c8950b0b86 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -385,12 +385,22 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
     return ret;
 }
 
-static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
+static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs,
+                                           strList *exclude_bs)
 {
+    const char *node_name = bdrv_get_node_name(bs);
+
     if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
         return false;
     }
 
+    while (exclude_bs) {
+        if (g_str_equal(node_name, exclude_bs->value)) {
+            return false;
+        }
+        exclude_bs = exclude_bs->next;
+    }
+
     /* Include all nodes that are either in use by a BlockBackend, or that
      * aren't attached to any node, but owned by the monitor. */
     return bdrv_has_blk(bs) || QLIST_EMPTY(&bs->parents);
@@ -400,7 +410,7 @@ static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
  * These functions will properly handle dataplane (take aio_context_acquire
  * when appropriate for appropriate block drivers) */
 
-bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
+bool bdrv_all_can_snapshot(strList *exclude_bs, BlockDriverState **first_bad_bs)
 {
     bool ok = true;
     BlockDriverState *bs;
@@ -410,7 +420,7 @@ bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs)
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs)) {
+        if (bdrv_all_snapshots_includes_bs(bs, exclude_bs)) {
             ok = bdrv_can_snapshot(bs);
         }
         aio_context_release(ctx);
@@ -425,8 +435,8 @@ fail:
     return ok;
 }
 
-int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
-                             Error **errp)
+int bdrv_all_delete_snapshot(const char *name, strList *exclude_bs,
+                             BlockDriverState **first_bad_bs, Error **errp)
 {
     int ret = 0;
     BlockDriverState *bs;
@@ -437,7 +447,7 @@ int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bad_bs,
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs) &&
+        if (bdrv_all_snapshots_includes_bs(bs, exclude_bs) &&
             bdrv_snapshot_find(bs, snapshot, name) >= 0)
         {
             ret = bdrv_snapshot_delete(bs, snapshot->id_str,
@@ -456,8 +466,8 @@ fail:
 }
 
 
-int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
-                           Error **errp)
+int bdrv_all_goto_snapshot(const char *name, strList *exclude_bs,
+                           BlockDriverState **first_bad_bs, Error **errp)
 {
     int ret = 0;
     BlockDriverState *bs;
@@ -467,7 +477,7 @@ int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs)) {
+        if (bdrv_all_snapshots_includes_bs(bs, exclude_bs)) {
             ret = bdrv_snapshot_goto(bs, name, errp);
         }
         aio_context_release(ctx);
@@ -482,7 +492,8 @@ fail:
     return ret;
 }
 
-int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
+int bdrv_all_find_snapshot(const char *name, strList *exclude_bs,
+                           BlockDriverState **first_bad_bs)
 {
     QEMUSnapshotInfo sn;
     int err = 0;
@@ -493,7 +504,7 @@ int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs)
         AioContext *ctx = bdrv_get_aio_context(bs);
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs)) {
+        if (bdrv_all_snapshots_includes_bs(bs, exclude_bs)) {
             err = bdrv_snapshot_find(bs, &sn, name);
         }
         aio_context_release(ctx);
@@ -511,6 +522,7 @@ fail:
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
                              uint64_t vm_state_size,
+                             strList *exclude_bs,
                              BlockDriverState **first_bad_bs)
 {
     int err = 0;
@@ -524,7 +536,7 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
         if (bs == vm_state_bs) {
             sn->vm_state_size = vm_state_size;
             err = bdrv_snapshot_create(bs, sn);
-        } else if (bdrv_all_snapshots_includes_bs(bs)) {
+        } else if (bdrv_all_snapshots_includes_bs(bs, exclude_bs)) {
             sn->vm_state_size = 0;
             err = bdrv_snapshot_create(bs, sn);
         }
@@ -540,7 +552,7 @@ fail:
     return err;
 }
 
-BlockDriverState *bdrv_all_find_vmstate_bs(void)
+BlockDriverState *bdrv_all_find_vmstate_bs(strList *exclude_bs)
 {
     BlockDriverState *bs;
     BdrvNextIterator it;
@@ -550,7 +562,8 @@ BlockDriverState *bdrv_all_find_vmstate_bs(void)
         bool found;
 
         aio_context_acquire(ctx);
-        found = bdrv_all_snapshots_includes_bs(bs) && bdrv_can_snapshot(bs);
+        found = bdrv_all_snapshots_includes_bs(bs, exclude_bs) &&
+            bdrv_can_snapshot(bs);
         aio_context_release(ctx);
 
         if (found) {
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 2bfcd57578..f20986ca37 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -25,7 +25,7 @@
 #ifndef SNAPSHOT_H
 #define SNAPSHOT_H
 
-
+#include "qapi/qapi-builtin-types.h"
 
 #define SNAPSHOT_OPT_BASE       "snapshot."
 #define SNAPSHOT_OPT_ID         "snapshot.id"
@@ -76,17 +76,20 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
  * These functions will properly handle dataplane (take aio_context_acquire
  * when appropriate for appropriate block drivers */
 
-bool bdrv_all_can_snapshot(BlockDriverState **first_bad_bs);
-int bdrv_all_delete_snapshot(const char *name, BlockDriverState **first_bsd_bs,
-                             Error **errp);
-int bdrv_all_goto_snapshot(const char *name, BlockDriverState **first_bad_bs,
-                           Error **errp);
-int bdrv_all_find_snapshot(const char *name, BlockDriverState **first_bad_bs);
+bool bdrv_all_can_snapshot(strList *exclude_bs,
+                           BlockDriverState **first_bad_bs);
+int bdrv_all_delete_snapshot(const char *name, strList *exclude_bs,
+                             BlockDriverState **first_bsd_bs, Error **errp);
+int bdrv_all_goto_snapshot(const char *name, strList *exclude_bs,
+                           BlockDriverState **first_bad_bs, Error **errp);
+int bdrv_all_find_snapshot(const char *name, strList *exclude_bs,
+                           BlockDriverState **first_bad_bs);
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
                              uint64_t vm_state_size,
+                             strList *exclude_bs,
                              BlockDriverState **first_bad_bs);
 
-BlockDriverState *bdrv_all_find_vmstate_bs(void);
+BlockDriverState *bdrv_all_find_vmstate_bs(strList *exclude_bs);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 53586a6406..4251aa0dde 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2646,7 +2646,7 @@ int save_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    if (!bdrv_all_can_snapshot(&bs)) {
+    if (!bdrv_all_can_snapshot(NULL, &bs)) {
         error_setg(errp, "Device '%s' is writable but does not support "
                    "snapshots", bdrv_get_device_or_node_name(bs));
         return ret;
@@ -2654,7 +2654,7 @@ int save_snapshot(const char *name, Error **errp)
 
     /* Delete old snapshots of the same name */
     if (name) {
-        ret = bdrv_all_delete_snapshot(name, &bs1, errp);
+        ret = bdrv_all_delete_snapshot(name, NULL, &bs1, errp);
         if (ret < 0) {
             error_prepend(errp, "Error while deleting snapshot on device "
                           "'%s': ", bdrv_get_device_or_node_name(bs1));
@@ -2662,7 +2662,7 @@ int save_snapshot(const char *name, Error **errp)
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs();
+    bs = bdrv_all_find_vmstate_bs(NULL);
     if (bs == NULL) {
         error_setg(errp, "No block device can accept snapshots");
         return ret;
@@ -2725,7 +2725,7 @@ int save_snapshot(const char *name, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, &bs);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, NULL, &bs);
     if (ret < 0) {
         error_setg(errp, "Error while creating snapshot on '%s'",
                    bdrv_get_device_or_node_name(bs));
@@ -2843,13 +2843,13 @@ int load_snapshot(const char *name, Error **errp)
         return -EINVAL;
     }
 
-    if (!bdrv_all_can_snapshot(&bs)) {
+    if (!bdrv_all_can_snapshot(NULL, &bs)) {
         error_setg(errp,
                    "Device '%s' is writable but does not support snapshots",
                    bdrv_get_device_or_node_name(bs));
         return -ENOTSUP;
     }
-    ret = bdrv_all_find_snapshot(name, &bs);
+    ret = bdrv_all_find_snapshot(name, NULL, &bs);
     if (ret < 0) {
         error_setg(errp,
                    "Device '%s' does not have the requested snapshot '%s'",
@@ -2857,7 +2857,7 @@ int load_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs();
+    bs_vm_state = bdrv_all_find_vmstate_bs(NULL);
     if (!bs_vm_state) {
         error_setg(errp, "No block device supports snapshots");
         return -ENOTSUP;
@@ -2879,7 +2879,7 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, &bs, errp);
+    ret = bdrv_all_goto_snapshot(name, NULL, &bs, errp);
     if (ret < 0) {
         error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
                       name, bdrv_get_device_or_node_name(bs));
@@ -2964,7 +2964,7 @@ void qmp_delvm(const char *tag, Error **errp)
 {
     BlockDriverState *bs;
 
-    if (bdrv_all_delete_snapshot(tag, &bs, errp) < 0) {
+    if (bdrv_all_delete_snapshot(tag, NULL, &bs, errp) < 0) {
         error_prepend(errp,
                       "deleting snapshot on device '%s': ",
                       bdrv_get_device_or_node_name(bs));
-- 
2.26.2


