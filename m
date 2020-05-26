Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72B0EC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:43:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 413A320723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JW7DB0/i"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 413A320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48224 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcft-0006HT-Bn
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:43:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41288)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdceq-0004YQ-W7
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60817
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcep-0002qL-4n
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590511346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K9IEHoDlJS+FjDytuoMfolDjl7ZsoI2ZIWaE7cuA0UY=;
 b=JW7DB0/iOimD1qDOmepgbR7eCkv6cazfJ6XpDbDFwvvrKtZ4NXhYV3dVVvl3Kb9iJkFyhm
 zkUppxqAgKSpY1Em46cY8GgXCOL21Vm/Aef+b7xJWxKjw+v2dJHPlUiv7Uzrg+DExiWQBC
 jhlCWukBef82oaena+BY0emWj7wXIdU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-OxiSAE20Mq-sBsu8QGaqeQ-1; Tue, 26 May 2020 12:42:24 -0400
X-MC-Unique: OxiSAE20Mq-sBsu8QGaqeQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0EA1E460;
 Tue, 26 May 2020 16:42:23 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5204D86C7E;
 Tue, 26 May 2020 16:42:14 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 01/11] migration: refactor init_dirty_bitmap_migration
Date: Tue, 26 May 2020 11:42:01 -0500
Message-Id: <20200526164211.1569366-2-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
References: <20200526164211.1569366-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=eblake@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:51:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block I/O path" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Split out handling one bs, it is needed for the following commit, which
will handle BlockBackends separately.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20200521220648.3255-2-vsementsov@virtuozzo.com>
[eblake: shorter subject line]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 89 +++++++++++++++++++---------------
 1 file changed, 49 insertions(+), 40 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7eafface6149..7e9371808653 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -267,13 +267,58 @@ static void dirty_bitmap_mig_cleanup(void)
     }
 }

+/* Called with iothread lock taken. */
+static int add_bitmaps_to_list(BlockDriverState *bs, const char *bs_name)
+{
+    BdrvDirtyBitmap *bitmap;
+    DirtyBitmapMigBitmapState *dbms;
+    Error *local_err = NULL;
+
+    FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
+        if (!bdrv_dirty_bitmap_name(bitmap)) {
+            continue;
+        }
+
+        if (!bs_name || strcmp(bs_name, "") == 0) {
+            error_report("Found bitmap '%s' in unnamed node %p. It can't "
+                         "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
+            return -1;
+        }
+
+        if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT, &local_err)) {
+            error_report_err(local_err);
+            return -1;
+        }
+
+        bdrv_ref(bs);
+        bdrv_dirty_bitmap_set_busy(bitmap, true);
+
+        dbms = g_new0(DirtyBitmapMigBitmapState, 1);
+        dbms->bs = bs;
+        dbms->node_name = bs_name;
+        dbms->bitmap = bitmap;
+        dbms->total_sectors = bdrv_nb_sectors(bs);
+        dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
+            bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
+        if (bdrv_dirty_bitmap_enabled(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
+        }
+        if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
+            dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
+        }
+
+        QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
+                             dbms, entry);
+    }
+
+    return 0;
+}
+
 /* Called with iothread lock taken. */
 static int init_dirty_bitmap_migration(void)
 {
     BlockDriverState *bs;
-    BdrvDirtyBitmap *bitmap;
     DirtyBitmapMigBitmapState *dbms;
-    Error *local_err = NULL;

     dirty_bitmap_mig_state.bulk_completed = false;
     dirty_bitmap_mig_state.prev_bs = NULL;
@@ -281,44 +326,8 @@ static int init_dirty_bitmap_migration(void)
     dirty_bitmap_mig_state.no_bitmaps = false;

     for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
-        const char *name = bdrv_get_device_or_node_name(bs);
-
-        FOR_EACH_DIRTY_BITMAP(bs, bitmap) {
-            if (!bdrv_dirty_bitmap_name(bitmap)) {
-                continue;
-            }
-
-            if (!name || strcmp(name, "") == 0) {
-                error_report("Found bitmap '%s' in unnamed node %p. It can't "
-                             "be migrated", bdrv_dirty_bitmap_name(bitmap), bs);
-                goto fail;
-            }
-
-            if (bdrv_dirty_bitmap_check(bitmap, BDRV_BITMAP_DEFAULT,
-                                        &local_err)) {
-                error_report_err(local_err);
-                goto fail;
-            }
-
-            bdrv_ref(bs);
-            bdrv_dirty_bitmap_set_busy(bitmap, true);
-
-            dbms = g_new0(DirtyBitmapMigBitmapState, 1);
-            dbms->bs = bs;
-            dbms->node_name = name;
-            dbms->bitmap = bitmap;
-            dbms->total_sectors = bdrv_nb_sectors(bs);
-            dbms->sectors_per_chunk = CHUNK_SIZE * 8 *
-                bdrv_dirty_bitmap_granularity(bitmap) >> BDRV_SECTOR_BITS;
-            if (bdrv_dirty_bitmap_enabled(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_ENABLED;
-            }
-            if (bdrv_dirty_bitmap_get_persistence(bitmap)) {
-                dbms->flags |= DIRTY_BITMAP_MIG_START_FLAG_PERSISTENT;
-            }
-
-            QSIMPLEQ_INSERT_TAIL(&dirty_bitmap_mig_state.dbms_list,
-                                 dbms, entry);
+        if (add_bitmaps_to_list(bs, bdrv_get_device_or_node_name(bs))) {
+            goto fail;
         }
     }

-- 
2.26.2


