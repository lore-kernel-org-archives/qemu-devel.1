Return-Path: <SRS0=Tmh/=3Z=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AD3C352A3
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEC962072B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Feb 2020 11:22:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEC962072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45260 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izIlW-0007vV-4q
	for qemu-devel@archiver.kernel.org; Wed, 05 Feb 2020 06:22:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52966)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIjw-0005GE-UX
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1izIjv-0001No-O1
 for qemu-devel@nongnu.org; Wed, 05 Feb 2020 06:21:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:41398)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjs-00015V-KA; Wed, 05 Feb 2020 06:21:00 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1izIjl-0006Jd-9v; Wed, 05 Feb 2020 14:20:53 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v4 10/10] block/qcow2-bitmap: use bdrv_dirty_bitmap_next_dirty
Date: Wed,  5 Feb 2020 14:20:41 +0300
Message-Id: <20200205112041.6003-11-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200205112041.6003-1-vsementsov@virtuozzo.com>
References: <20200205112041.6003-1-vsementsov@virtuozzo.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 185.231.240.75
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, qemu-devel@nongnu.org,
 mreitz@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

store_bitmap_data() loop does bdrv_set_dirty_iter() on each iteration,
which means that we actually don't need iterator itself and we can use
simpler bitmap API.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Max Reitz <mreitz@redhat.com>
---
 block/qcow2-bitmap.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index d41f5d049b..82646c53bd 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1289,7 +1289,6 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
     uint64_t bm_size = bdrv_dirty_bitmap_size(bitmap);
     const char *bm_name = bdrv_dirty_bitmap_name(bitmap);
     uint8_t *buf = NULL;
-    BdrvDirtyBitmapIter *dbi;
     uint64_t *tb;
     uint64_t tb_size =
             size_to_clusters(s,
@@ -1308,12 +1307,14 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
         return NULL;
     }
 
-    dbi = bdrv_dirty_iter_new(bitmap);
     buf = g_malloc(s->cluster_size);
     limit = bytes_covered_by_bitmap_cluster(s, bitmap);
     assert(DIV_ROUND_UP(bm_size, limit) == tb_size);
 
-    while ((offset = bdrv_dirty_iter_next(dbi)) >= 0) {
+    offset = 0;
+    while ((offset = bdrv_dirty_bitmap_next_dirty(bitmap, offset, INT64_MAX))
+           >= 0)
+    {
         uint64_t cluster = offset / limit;
         uint64_t end, write_size;
         int64_t off;
@@ -1356,23 +1357,17 @@ static uint64_t *store_bitmap_data(BlockDriverState *bs,
             goto fail;
         }
 
-        if (end >= bm_size) {
-            break;
-        }
-
-        bdrv_set_dirty_iter(dbi, end);
+        offset = end;
     }
 
     *bitmap_table_size = tb_size;
     g_free(buf);
-    bdrv_dirty_iter_free(dbi);
 
     return tb;
 
 fail:
     clear_bitmap_table(bs, tb, tb_size);
     g_free(buf);
-    bdrv_dirty_iter_free(dbi);
     g_free(tb);
 
     return NULL;
-- 
2.21.0


