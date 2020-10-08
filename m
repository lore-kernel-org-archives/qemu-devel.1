Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76044C4363C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:52:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4B482087D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 15:52:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZS/MNLja"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4B482087D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43208 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQYDe-0008PW-RI
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 11:52:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58406)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQYBd-0006Z9-2J
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:21956)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kQYBa-0002b6-Cn
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 11:50:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602172227;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W8nF0INCjumOuHpy7REtxvUeNk+vkD2Xh/N2quph/z0=;
 b=ZS/MNLjabeDgVphSProXDRJVdWH8bL/iSEG3ipnaq/H80SPkb+64NPI1bwnWFhYsxh5ClH
 S1D+OrieP9FIzaYMMVcu5bpwzPZYEZWduG0zWJCEuX0NXiSUX/j3p6PU3DVGvvipIfldR3
 9kxCbF+8NTkGxNJTP5cn+rh54d51j/Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-48-huo1bH-iOAuF31rzZoNF3w-1; Thu, 08 Oct 2020 11:50:25 -0400
X-MC-Unique: huo1bH-iOAuF31rzZoNF3w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93D8510AB002;
 Thu,  8 Oct 2020 15:50:18 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.13])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9A715C1BD;
 Thu,  8 Oct 2020 15:50:14 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v6 03/10] block: add ability to specify list of blockdevs
 during snapshot
Date: Thu,  8 Oct 2020 16:49:54 +0100
Message-Id: <20201008155001.3357288-4-berrange@redhat.com>
In-Reply-To: <20201008155001.3357288-1-berrange@redhat.com>
References: <20201008155001.3357288-1-berrange@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/08 01:56:49
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When running snapshot operations, there are various rules for which
blockdevs are included/excluded. While this provides reasonable default
behaviour, there are scenarios that are not well handled by the default
logic. Some of the conditions do not have a single correct answer.

Thus there needs to be a way for the mgmt app to provide an explicit
list of blockdevs to perform snapshots across. This can be achieved
by passing a list of node names that should be used.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/monitor/block-hmp-cmds.c |   4 +-
 block/snapshot.c               | 180 ++++++++++++++++++++++++---------
 include/block/snapshot.h       |  22 ++--
 migration/savevm.c             |  16 +--
 monitor/hmp-cmds.c             |   2 +-
 replay/replay-debugging.c      |   4 +-
 6 files changed, 162 insertions(+), 66 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 548bb6b5e3..ebb6ae0333 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -901,7 +901,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     SnapshotEntry *snapshot_entry;
     Error *err = NULL;
 
-    bs = bdrv_all_find_vmstate_bs(&err);
+    bs = bdrv_all_find_vmstate_bs(false, NULL, &err);
     if (!bs) {
         error_report_err(err);
         return;
@@ -953,7 +953,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     total = 0;
     for (i = 0; i < nb_sns; i++) {
         SnapshotEntry *next_sn;
-        if (bdrv_all_find_snapshot(sn_tab[i].name, NULL) == 0) {
+        if (bdrv_all_find_snapshot(sn_tab[i].name, false, NULL, NULL) == 0) {
             global_snapshots[total] = i;
             total++;
             QTAILQ_FOREACH(image_entry, &image_list, next) {
diff --git a/block/snapshot.c b/block/snapshot.c
index 50e35bb9fa..155b8aad88 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -447,6 +447,41 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
     return ret;
 }
 
+
+static int bdrv_all_get_snapshot_devices(bool has_devices, strList *devices,
+                                         GList **all_bdrvs,
+                                         Error **errp)
+{
+    g_autoptr(GList) bdrvs = NULL;
+
+    if (has_devices) {
+        if (!devices) {
+            error_setg(errp, "At least one device is required for snapshot");
+            return -1;
+        }
+
+        while (devices) {
+            BlockDriverState *bs = bdrv_find_node(devices->value);
+            if (!bs) {
+                error_setg(errp, "No block device node '%s'", devices->value);
+                return -1;
+            }
+            bdrvs = g_list_append(bdrvs, bs);
+            devices = devices->next;
+        }
+    } else {
+        BlockDriverState *bs;
+        BdrvNextIterator it;
+        for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+            bdrvs = g_list_append(bdrvs, bs);
+        }
+    }
+
+    *all_bdrvs = g_steal_pointer(&bdrvs);
+    return 0;
+}
+
+
 static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
 {
     if (!bdrv_is_inserted(bs) || bdrv_is_read_only(bs)) {
@@ -462,43 +497,59 @@ static bool bdrv_all_snapshots_includes_bs(BlockDriverState *bs)
  * These functions will properly handle dataplane (take aio_context_acquire
  * when appropriate for appropriate block drivers) */
 
-bool bdrv_all_can_snapshot(Error **errp)
+bool bdrv_all_can_snapshot(bool has_devices, strList *devices,
+                           Error **errp)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    g_autoptr(GList) bdrvs = NULL;
+    GList *iterbdrvs;
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
+        return false;
+    }
+
+    iterbdrvs = bdrvs;
+    while (iterbdrvs) {
+        BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
         bool ok;
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs)) {
+        if (devices || bdrv_all_snapshots_includes_bs(bs)) {
             ok = bdrv_can_snapshot(bs);
         }
         aio_context_release(ctx);
         if (!ok) {
             error_setg(errp, "Device '%s' is writable but does not support "
                        "snapshots", bdrv_get_device_or_node_name(bs));
-            bdrv_next_cleanup(&it);
             return false;
         }
+
+        iterbdrvs = iterbdrvs->next;
     }
 
     return true;
 }
 
-int bdrv_all_delete_snapshot(const char *name, Error **errp)
+int bdrv_all_delete_snapshot(const char *name,
+                             bool has_devices, strList *devices,
+                             Error **errp)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
-    QEMUSnapshotInfo sn1, *snapshot = &sn1;
+    g_autoptr(GList) bdrvs = NULL;
+    GList *iterbdrvs;
+
+    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
+        return -1;
+    }
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    iterbdrvs = bdrvs;
+    while (iterbdrvs) {
+        BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
-        int ret;
+        QEMUSnapshotInfo sn1, *snapshot = &sn1;
+        int ret = 0;
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs) &&
+        if ((devices || bdrv_all_snapshots_includes_bs(bs)) &&
             bdrv_snapshot_find(bs, snapshot, name) >= 0)
         {
             ret = bdrv_snapshot_delete(bs, snapshot->id_str,
@@ -508,61 +559,80 @@ int bdrv_all_delete_snapshot(const char *name, Error **errp)
         if (ret < 0) {
             error_prepend(errp, "Could not delete snapshot '%s' on '%s': ",
                           name, bdrv_get_device_or_node_name(bs));
-            bdrv_next_cleanup(&it);
             return -1;
         }
+
+        iterbdrvs = iterbdrvs->next;
     }
 
     return 0;
 }
 
 
-int bdrv_all_goto_snapshot(const char *name, Error **errp)
+int bdrv_all_goto_snapshot(const char *name,
+                           bool has_devices, strList *devices,
+                           Error **errp)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    g_autoptr(GList) bdrvs = NULL;
+    GList *iterbdrvs;
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
+        return -1;
+    }
+
+    iterbdrvs = bdrvs;
+    while (iterbdrvs) {
+        BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
-        int ret;
+        int ret = 0;
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs)) {
+        if (devices || bdrv_all_snapshots_includes_bs(bs)) {
             ret = bdrv_snapshot_goto(bs, name, errp);
         }
         aio_context_release(ctx);
         if (ret < 0) {
             error_prepend(errp, "Could not load snapshot '%s' on '%s': ",
                           name, bdrv_get_device_or_node_name(bs));
-            bdrv_next_cleanup(&it);
             return -1;
         }
+
+        iterbdrvs = iterbdrvs->next;
     }
 
     return 0;
 }
 
-int bdrv_all_find_snapshot(const char *name, Error **errp)
+int bdrv_all_find_snapshot(const char *name,
+                           bool has_devices, strList *devices,
+                           Error **errp)
 {
-    QEMUSnapshotInfo sn;
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    g_autoptr(GList) bdrvs = NULL;
+    GList *iterbdrvs;
+
+    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
+        return -1;
+    }
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    iterbdrvs = bdrvs;
+    while (iterbdrvs) {
+        BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
-        int ret;
+        QEMUSnapshotInfo sn;
+        int ret = 0;
 
         aio_context_acquire(ctx);
-        if (bdrv_all_snapshots_includes_bs(bs)) {
+        if (devices || bdrv_all_snapshots_includes_bs(bs)) {
             ret = bdrv_snapshot_find(bs, &sn, name);
         }
         aio_context_release(ctx);
         if (ret < 0) {
             error_setg(errp, "Could not find snapshot '%s' on '%s'",
                        name, bdrv_get_device_or_node_name(bs));
-            bdrv_next_cleanup(&it);
             return -1;
         }
+
+        iterbdrvs = iterbdrvs->next;
     }
 
     return 0;
@@ -571,20 +641,27 @@ int bdrv_all_find_snapshot(const char *name, Error **errp)
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
                              uint64_t vm_state_size,
+                             bool has_devices, strList *devices,
                              Error **errp)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    g_autoptr(GList) bdrvs = NULL;
+    GList *iterbdrvs;
+
+    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
+        return -1;
+    }
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    iterbdrvs = bdrvs;
+    while (iterbdrvs) {
+        BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
-        int ret;
+        int ret = 0;
 
         aio_context_acquire(ctx);
         if (bs == vm_state_bs) {
             sn->vm_state_size = vm_state_size;
             ret = bdrv_snapshot_create(bs, sn);
-        } else if (bdrv_all_snapshots_includes_bs(bs)) {
+        } else if (devices || bdrv_all_snapshots_includes_bs(bs)) {
             sn->vm_state_size = 0;
             ret = bdrv_snapshot_create(bs, sn);
         }
@@ -592,34 +669,43 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
         if (ret < 0) {
             error_setg(errp, "Could not create snapshot '%s' on '%s'",
                        sn->name, bdrv_get_device_or_node_name(bs));
-            bdrv_next_cleanup(&it);
             return -1;
         }
+
+        iterbdrvs = iterbdrvs->next;
     }
 
     return 0;
 }
 
-BlockDriverState *bdrv_all_find_vmstate_bs(Error **errp)
+BlockDriverState *bdrv_all_find_vmstate_bs(bool has_devices, strList *devices,
+                                           Error **errp)
 {
-    BlockDriverState *bs;
-    BdrvNextIterator it;
+    g_autoptr(GList) bdrvs = NULL;
+    GList *iterbdrvs;
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+    if (bdrv_all_get_snapshot_devices(has_devices, devices, &bdrvs, errp) < 0) {
+        return NULL;
+    }
+
+    iterbdrvs = bdrvs;
+    while (iterbdrvs) {
+        BlockDriverState *bs = iterbdrvs->data;
         AioContext *ctx = bdrv_get_aio_context(bs);
-        bool found;
+        bool found = false;
 
         aio_context_acquire(ctx);
-        found = bdrv_all_snapshots_includes_bs(bs) && bdrv_can_snapshot(bs);
+        found = (devices || bdrv_all_snapshots_includes_bs(bs)) &&
+            bdrv_can_snapshot(bs);
         aio_context_release(ctx);
 
         if (found) {
-            bdrv_next_cleanup(&it);
-            break;
+            return bs;
         }
+
+        iterbdrvs = iterbdrvs->next;
     }
-    if (!bs) {
-        error_setg(errp, "No block device supports snapshots");
-    }
-    return bs;
+
+    error_setg(errp, "No block device supports snapshots");
+    return NULL;
 }
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 5cb2b696ad..2569a903f2 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -25,7 +25,7 @@
 #ifndef SNAPSHOT_H
 #define SNAPSHOT_H
 
-
+#include "qapi/qapi-builtin-types.h"
 
 #define SNAPSHOT_OPT_BASE       "snapshot."
 #define SNAPSHOT_OPT_ID         "snapshot.id"
@@ -77,15 +77,25 @@ int bdrv_snapshot_load_tmp_by_id_or_name(BlockDriverState *bs,
  * These functions will properly handle dataplane (take aio_context_acquire
  * when appropriate for appropriate block drivers */
 
-bool bdrv_all_can_snapshot(Error **errp);
-int bdrv_all_delete_snapshot(const char *name, Error **errp);
-int bdrv_all_goto_snapshot(const char *name, Error **errp);
-int bdrv_all_find_snapshot(const char *name, Error **errp);
+bool bdrv_all_can_snapshot(bool has_devices, strList *devices,
+                           Error **errp);
+int bdrv_all_delete_snapshot(const char *name,
+                             bool has_devices, strList *devices,
+                             Error **errp);
+int bdrv_all_goto_snapshot(const char *name,
+                           bool has_devices, strList *devices,
+                           Error **errp);
+int bdrv_all_find_snapshot(const char *name,
+                           bool has_devices, strList *devices,
+                           Error **errp);
 int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              BlockDriverState *vm_state_bs,
                              uint64_t vm_state_size,
+                             bool has_devices,
+                             strList *devices,
                              Error **errp);
 
-BlockDriverState *bdrv_all_find_vmstate_bs(Error **errp);
+BlockDriverState *bdrv_all_find_vmstate_bs(bool has_devices, strList *devices,
+                                           Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 87eaa07553..e4e65d5a22 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2680,18 +2680,18 @@ int save_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    if (!bdrv_all_can_snapshot(errp)) {
+    if (!bdrv_all_can_snapshot(false, NULL, errp)) {
         return ret;
     }
 
     /* Delete old snapshots of the same name */
     if (name) {
-        if (bdrv_all_delete_snapshot(name, errp) < 0) {
+        if (bdrv_all_delete_snapshot(name, false, NULL, errp) < 0) {
             return ret;
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(errp);
+    bs = bdrv_all_find_vmstate_bs(false, NULL, errp);
     if (bs == NULL) {
         return ret;
     }
@@ -2762,7 +2762,7 @@ int save_snapshot(const char *name, Error **errp)
     aio_context_release(aio_context);
     aio_context = NULL;
 
-    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, errp);
+    ret = bdrv_all_create_snapshot(sn, bs, vm_state_size, false, NULL, errp);
     if (ret < 0) {
         goto the_end;
     }
@@ -2873,15 +2873,15 @@ int load_snapshot(const char *name, Error **errp)
     AioContext *aio_context;
     MigrationIncomingState *mis = migration_incoming_get_current();
 
-    if (!bdrv_all_can_snapshot(errp)) {
+    if (!bdrv_all_can_snapshot(false, NULL, errp)) {
         return -1;
     }
-    ret = bdrv_all_find_snapshot(name, errp);
+    ret = bdrv_all_find_snapshot(name, false, NULL, errp);
     if (ret < 0) {
         return -1;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(false, NULL, errp);
     if (!bs_vm_state) {
         return -1;
     }
@@ -2908,7 +2908,7 @@ int load_snapshot(const char *name, Error **errp)
     /* Flush all IO requests so they don't interfere with the new state.  */
     bdrv_drain_all_begin();
 
-    ret = bdrv_all_goto_snapshot(name, errp);
+    ret = bdrv_all_goto_snapshot(name, false, NULL, errp);
     if (ret < 0) {
         goto err_drain;
     }
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 14848a3381..f1b9df7250 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1142,7 +1142,7 @@ void hmp_delvm(Monitor *mon, const QDict *qdict)
     Error *err = NULL;
     const char *name = qdict_get_str(qdict, "name");
 
-    bdrv_all_delete_snapshot(name, &err);
+    bdrv_all_delete_snapshot(name, false, NULL, &err);
     hmp_handle_error(mon, err);
 }
 
diff --git a/replay/replay-debugging.c b/replay/replay-debugging.c
index 8785489c02..2dd474c7a0 100644
--- a/replay/replay-debugging.c
+++ b/replay/replay-debugging.c
@@ -149,7 +149,7 @@ static char *replay_find_nearest_snapshot(int64_t icount,
 
     *snapshot_icount = -1;
 
-    bs = bdrv_all_find_vmstate_bs(NULL);
+    bs = bdrv_all_find_vmstate_bs(false, NULL, NULL);
     if (!bs) {
         goto fail;
     }
@@ -160,7 +160,7 @@ static char *replay_find_nearest_snapshot(int64_t icount,
     aio_context_release(aio_context);
 
     for (i = 0; i < nb_sns; i++) {
-        if (bdrv_all_find_snapshot(sn_tab[i].name, NULL) == 0) {
+        if (bdrv_all_find_snapshot(sn_tab[i].name, false, NULL, NULL) == 0) {
             if (sn_tab[i].icount != -1ULL
                 && sn_tab[i].icount <= icount
                 && (!nearest || nearest->icount < sn_tab[i].icount)) {
-- 
2.26.2


