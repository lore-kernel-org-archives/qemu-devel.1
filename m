Return-Path: <SRS0=MTtZ=AN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F73C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:01:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1B5120760
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2020 18:01:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YhheYWls"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1B5120760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jr3Wn-0006D4-0I
	for qemu-devel@archiver.kernel.org; Thu, 02 Jul 2020 14:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3Tl-0001zz-35
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:33 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46202
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1jr3Th-0003km-VG
 for qemu-devel@nongnu.org; Thu, 02 Jul 2020 13:58:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593712709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2cnqQ9SUpodkmHJ9GHvFF4TamKwzMWJAZH9j3FPdITc=;
 b=YhheYWlsroAoJSoQWntmH0VVL1i0iGPc9tPcinzTmKqTxnvMs2WzWYdYKlzog+hye6BiAk
 nkDARXouJrU5EIo16a1XzFgd9oDc86jqGbzmTuw4NbgTodV7eZfGeRX/W0YHwnzlUCzvEa
 AtSBTQHS2J0Yyr0PnU+MSJjtp8jvRoM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-nXeHgWiqO8CVO-Q3bcn27g-1; Thu, 02 Jul 2020 13:58:27 -0400
X-MC-Unique: nXeHgWiqO8CVO-Q3bcn27g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 509CC8031F6;
 Thu,  2 Jul 2020 17:58:26 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.36.110.52])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B91945D9CA;
 Thu,  2 Jul 2020 17:58:22 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 4/6] block: allow specifying name of block device for vmstate
 storage
Date: Thu,  2 Jul 2020 18:57:52 +0100
Message-Id: <20200702175754.2211821-5-berrange@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=berrange@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/02 04:00:43
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

Currently the vmstate will be stored in the first block device that
supports snapshots. Historically this would have usually been the
root device, but with UEFI it might be the variable store. There
needs to be a way to override the choice of block device to store
the state in.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 block/monitor/block-hmp-cmds.c |  2 +-
 block/snapshot.c               | 33 +++++++++++++++++++++++++++++----
 include/block/snapshot.h       |  4 +++-
 migration/savevm.c             |  6 ++----
 4 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/block/monitor/block-hmp-cmds.c b/block/monitor/block-hmp-cmds.c
index 0ee6e7a4be..a698fac027 100644
--- a/block/monitor/block-hmp-cmds.c
+++ b/block/monitor/block-hmp-cmds.c
@@ -899,7 +899,7 @@ void hmp_info_snapshots(Monitor *mon, const QDict *qdict)
     ImageEntry *image_entry, *next_ie;
     SnapshotEntry *snapshot_entry;
 
-    bs = bdrv_all_find_vmstate_bs(NULL);
+    bs = bdrv_all_find_vmstate_bs(NULL, NULL, NULL);
     if (!bs) {
         monitor_printf(mon, "No available block device supports snapshots\n");
         return;
diff --git a/block/snapshot.c b/block/snapshot.c
index c8950b0b86..4774a1890d 100644
--- a/block/snapshot.c
+++ b/block/snapshot.c
@@ -552,7 +552,9 @@ fail:
     return err;
 }
 
-BlockDriverState *bdrv_all_find_vmstate_bs(strList *exclude_bs)
+BlockDriverState *bdrv_all_find_vmstate_bs(const char *vmstate_bs,
+                                           strList *exclude_bs,
+                                           Error **errp)
 {
     BlockDriverState *bs;
     BdrvNextIterator it;
@@ -560,16 +562,39 @@ BlockDriverState *bdrv_all_find_vmstate_bs(strList *exclude_bs)
     for (bs = bdrv_first(&it); bs; bs = bdrv_next(&it)) {
         AioContext *ctx = bdrv_get_aio_context(bs);
         bool found;
+        Error *err = NULL;
 
         aio_context_acquire(ctx);
-        found = bdrv_all_snapshots_includes_bs(bs, exclude_bs) &&
-            bdrv_can_snapshot(bs);
+        if (vmstate_bs == NULL) {
+            found = bdrv_all_snapshots_includes_bs(bs, exclude_bs) &&
+                bdrv_can_snapshot(bs);
+        } else {
+            if (g_str_equal(vmstate_bs, bdrv_get_node_name(bs))) {
+                found = bdrv_all_snapshots_includes_bs(bs, exclude_bs) &&
+                    bdrv_can_snapshot(bs);
+                if (!found) {
+                    error_setg(&err,
+                               "block device '%s' cannot accept snapshots",
+                               vmstate_bs);
+                }
+            } else {
+                found = false;
+            }
+        }
         aio_context_release(ctx);
 
-        if (found) {
+        if (found || err) {
             bdrv_next_cleanup(&it);
+            if (err) {
+                error_propagate(errp, err);
+                return NULL;
+            }
             break;
         }
     }
+
+    if (!bs) {
+        error_setg(errp, "No block device can accept snapshots");
+    }
     return bs;
 }
diff --git a/include/block/snapshot.h b/include/block/snapshot.h
index f20986ca37..ff627df5cb 100644
--- a/include/block/snapshot.h
+++ b/include/block/snapshot.h
@@ -90,6 +90,8 @@ int bdrv_all_create_snapshot(QEMUSnapshotInfo *sn,
                              strList *exclude_bs,
                              BlockDriverState **first_bad_bs);
 
-BlockDriverState *bdrv_all_find_vmstate_bs(strList *exclude_bs);
+BlockDriverState *bdrv_all_find_vmstate_bs(const char *vmstate_bs,
+                                           strList *exclude_bs,
+                                           Error **errp);
 
 #endif
diff --git a/migration/savevm.c b/migration/savevm.c
index 4251aa0dde..b11c6a882d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2662,9 +2662,8 @@ int save_snapshot(const char *name, Error **errp)
         }
     }
 
-    bs = bdrv_all_find_vmstate_bs(NULL);
+    bs = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
     if (bs == NULL) {
-        error_setg(errp, "No block device can accept snapshots");
         return ret;
     }
     aio_context = bdrv_get_aio_context(bs);
@@ -2857,9 +2856,8 @@ int load_snapshot(const char *name, Error **errp)
         return ret;
     }
 
-    bs_vm_state = bdrv_all_find_vmstate_bs(NULL);
+    bs_vm_state = bdrv_all_find_vmstate_bs(NULL, NULL, errp);
     if (!bs_vm_state) {
-        error_setg(errp, "No block device supports snapshots");
         return -ENOTSUP;
     }
     aio_context = bdrv_get_aio_context(bs_vm_state);
-- 
2.26.2


