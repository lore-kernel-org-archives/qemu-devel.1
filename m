Return-Path: <SRS0=4PQo=7I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8399C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D96220723
	for <qemu-devel@archiver.kernel.org>; Tue, 26 May 2020 16:43:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NEXKtTrS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D96220723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdcgC-0006ou-3i
	for qemu-devel@archiver.kernel.org; Tue, 26 May 2020 12:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41452)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcew-0004kI-Qx
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33760
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1jdcev-0002ul-19
 for qemu-devel@nongnu.org; Tue, 26 May 2020 12:42:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590511352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzLG/YoBJu2Cdm4qXbVPDSGQ6Rw+an87q7CnjlpFAPk=;
 b=NEXKtTrSap16Y4qQPqIntYgWVqFkfOnTP/qYd03rCCCOZB3jfmHHbm5MCTzcPX0HPBeEob
 EK63frpAG2kVZrfLr1ROeWD1L8hCwpW8AFmMcpclPvyMv1vP16nk/j91lXmanS5jG14FuP
 l+wNyAxfiBGjtu4/YRkmEvMVRivkk+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-86-DZtiH-AKMsKnmMzHnhp4VA-1; Tue, 26 May 2020 12:42:28 -0400
X-MC-Unique: DZtiH-AKMsKnmMzHnhp4VA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC47C1800D42;
 Tue, 26 May 2020 16:42:26 +0000 (UTC)
Received: from blue.redhat.com (ovpn-112-88.phx2.redhat.com [10.3.112.88])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA736062D;
 Tue, 26 May 2020 16:42:26 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 03/11] migration: fix bitmaps pre-blockdev migration with
 mirror job
Date: Tue, 26 May 2020 11:42:03 -0500
Message-Id: <20200526164211.1569366-4-eblake@redhat.com>
In-Reply-To: <20200526164211.1569366-1-eblake@redhat.com>
References: <20200526164211.1569366-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/26 01:14:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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

Important thing for bitmap migration is to select destination block
node to obtain the migrated bitmap.

Prepatch, on source we use bdrv_get_device_or_node_name() to identify
the node, and on target we do bdrv_lookup_bs.
bdrv_get_device_or_node_name() returns blk name only for direct
children of blk. So, bitmaps of direct children of blks are migrated by
blk name and others - by node name.

Old libvirt is unprepared to bitmap migration by node-name,
node-names are mostly auto-generated. So actually only migration by blk
name works for it.

Newer libvirt will use new interface (which will be added soon) to
specify node-mapping for bitmaps migration explicitly. Still, let's
improve the current behavior a bit.

Now, consider classic libvirt migrations assisted by mirror block job:
mirror block job inserts filter, so our source is not a direct child of
blk, and bitmaps are migrated by node-names. And this just doesn't work
with auto-generated node names.

Let's fix it by using blk-name even if some implicit filters are
inserted.

Note2: we, of course, can't skip filters and use blk name to migrate
bitmaps in filtered node by blk name for this blk if these filters have
named bitmaps which should be migrated.

Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1652424
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20200521220648.3255-4-vsementsov@virtuozzo.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[eblake: comment typo fix, shorter subject line]
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 45 +++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 7e9371808653..69ddf289ddb9 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -319,14 +319,54 @@ static int init_dirty_bitmap_migration(void)
 {
     BlockDriverState *bs;
     DirtyBitmapMigBitmapState *dbms;
+    GHashTable *handled_by_blk = g_hash_table_new(NULL, NULL);
+    BlockBackend *blk;

     dirty_bitmap_mig_state.bulk_completed = false;
     dirty_bitmap_mig_state.prev_bs = NULL;
     dirty_bitmap_mig_state.prev_bitmap = NULL;
     dirty_bitmap_mig_state.no_bitmaps = false;

+    /*
+     * Use blockdevice name for direct (or filtered) children of named block
+     * backends.
+     */
+    for (blk = blk_next(NULL); blk; blk = blk_next(blk)) {
+        const char *name = blk_name(blk);
+
+        if (!name || strcmp(name, "") == 0) {
+            continue;
+        }
+
+        bs = blk_bs(blk);
+
+        /* Skip filters without bitmaps */
+        while (bs && bs->drv && bs->drv->is_filter &&
+               !bdrv_has_named_bitmaps(bs))
+        {
+            if (bs->backing) {
+                bs = bs->backing->bs;
+            } else if (bs->file) {
+                bs = bs->file->bs;
+            } else {
+                bs = NULL;
+            }
+        }
+
+        if (bs && bs->drv && !bs->drv->is_filter) {
+            if (add_bitmaps_to_list(bs, name)) {
+                goto fail;
+            }
+            g_hash_table_add(handled_by_blk, bs);
+        }
+    }
+
     for (bs = bdrv_next_all_states(NULL); bs; bs = bdrv_next_all_states(bs)) {
-        if (add_bitmaps_to_list(bs, bdrv_get_device_or_node_name(bs))) {
+        if (g_hash_table_contains(handled_by_blk, bs)) {
+            continue;
+        }
+
+        if (add_bitmaps_to_list(bs, bdrv_get_node_name(bs))) {
             goto fail;
         }
     }
@@ -340,9 +380,12 @@ static int init_dirty_bitmap_migration(void)
         dirty_bitmap_mig_state.no_bitmaps = true;
     }

+    g_hash_table_destroy(handled_by_blk);
+
     return 0;

 fail:
+    g_hash_table_destroy(handled_by_blk);
     dirty_bitmap_mig_cleanup();

     return -1;
-- 
2.26.2


