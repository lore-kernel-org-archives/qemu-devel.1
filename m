Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D033C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:12:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF34420672
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 15:12:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IA/T3Nbp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF34420672
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47976 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k04nX-0002ni-4y
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 11:12:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37838)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04ki-0006na-S7
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:21415
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1k04kg-0007gw-5Y
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 11:09:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595862557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=WCkLAXBjLGBbuz5WvnpxcNCWRuwJufaoH+ZkmO8gEUo=;
 b=IA/T3Nbp2YLuRfzKBKy8DHumr5RdvOVlGv/+aFUDbN6jnfRCXqXxYXMs+kvR5BojRSegS2
 Fz9lVOOQ1NWQwrVuT9GA08sqKmdUEhbw8u0yASrH1Eg3jHVqHxGSWp8ZWIfsQyENoNigvZ
 L9ippMb2sFIcWSn3t54b8be+Gl1kRZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-442-u1eDLRbGOzecB4PXvwGilQ-1; Mon, 27 Jul 2020 11:09:15 -0400
X-MC-Unique: u1eDLRbGOzecB4PXvwGilQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 708881932483;
 Mon, 27 Jul 2020 15:09:14 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.5])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 9048E60BF4;
 Mon, 27 Jul 2020 15:09:05 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 5/6] block: allow specifying name of block device for
 vmstate storage
Date: Mon, 27 Jul 2020 16:08:42 +0100
Message-Id: <20200727150843.3419256-6-berrange@redhat.com>
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

Currently the vmstate will be stored in the first block device that
supports snapshots. Historically this would have usually been the
root device, but with UEFI it might be the variable store. There
needs to be a way to override the choice of block device to store
the state in.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/monitor/block-hmp-cmds.c |  2 +-
 block/snapshot.c               | 64 ++++++++++++++++++++++++++--------
 include/block/snapshot.h       |  4 ++-
 migration/savevm.c             |  4 +--
 4 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index db76c43cc2..81d1b52262 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -900,7 +900,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     SnapshotEntry *snapshot_entry;
     Error *err = NULL;
 
-    bs = bdrv_all_find_vmstate_bs(NULL, &err);
+    bs = bdrv_all_find_vmstate_bs(NULL, NULL, &err);
     if (!bs) {
         error_report_err(err);
         return;
diff --git a/block/snapshot.c b/block/snapshot.c
index f2600a8c7f..b1ad70e278 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -551,27 +551,63 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
     return 0;
 }
 
-BlockDriverState *bdrv_all_find_vmstate_bs(strList *devices, Error **errp)
+BlockDriverState *bdrv_all_find_vmstate_bs(const char *vmstate_bs,
+                                           strList *devices,
+                                           Error **errp)
 {
     BlockDriverState *bs;
     BdrvNextIterator it;
 
-    for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
-        AioContext *ctx = bdrv_get_aio_context(bs);
-        bool found;
+    if (vmstate_bs) {
+        bool usable = false;
+        for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+            AioContext *ctx = bdrv_get_aio_context(bs);
+            bool match;
 
-        aio_context_acquire(ctx);
-        found = bdrv_all_snapshots_includes_bs(bs, devices) &&
-            bdrv_can_snapshot(bs);
-        aio_context_release(ctx);
+            aio_context_acquire(ctx);
+            if (g_str_equal(vmstate_bs, bdrv_get_node_name(bs))) {
+                match = true;
+                usable = bdrv_can_snapshot(bs);
+            }
+            aio_context_release(ctx);
+            if (match) {
+                bdrv_next_cleanup(&it);
+                break;
+            }
+        }
+        if (!bs) {
+            error_setg(errp,
+                       "block device '%s' does not exist",
+                       vmstate_bs);
+            return NULL;
+        }
 
-        if (found) {
-            bdrv_next_cleanup(&it);
-            break;
+        if (!usable) {
+            error_setg(errp,
+                       "block device '%s' does not support snapshots",
+                       vmstate_bs);
+            return NULL;
+        }
+    } else {
+        for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
+            AioContext *ctx = bdrv_get_aio_context(bs);
+            bool found;
+
+            aio_context_acquire(ctx);
+            found = bdrv_all_snapshots_includes_bs(bs, devices) &&
+                bdrv_can_snapshot(bs);
+            aio_context_release(ctx);
+
+            if (found) {
+                bdrv_next_cleanup(&it);
+                break;
+            }
+        }
+
+        if (!bs) {
+            error_setg(errp, "No block device supports snapshots");
+            return NULL;
         }
-    }
-    if (!bs) {
-        error_setg(errp, "No block device supports snapshots");
     }
     return bs;
 }
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index 1c5b0705a9..05550e5da1 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -86,6 +86,8 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              strList *devices,
                              Error **errp);
 
-BlockDriverState *bdrv_all_find_vmstate_bs(strList *devices, Error **errp);
+BlockDriverState *bdrv_all_find_vmstate_bs(const char *vmstate_bs,
+                                           strList *devices,
+                                           Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index cdc1f2f2d8..1707fa30db 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2664,7 +2664,7 @@ int save_snapshot(const char *name, Error **errp)
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(NULL, errp);
+    bs = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
     if (bs == NULL) {
         return ret;
     }
@@ -2854,7 +2854,7 @@ int load_snapshot(const char *name, Error **errp)
         return -1;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, errp);
+    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
     if (!bs_vm_state) {
         return -1;
     }
-- 
2.26.2


