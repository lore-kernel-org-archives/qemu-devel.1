Return-Path: <SRS0=Oie8=3L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDC35C3F68F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C52D82468C
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2020 13:28:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C52D82468C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42070 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuG3E-0003oW-FT
	for qemu-devel@archiver.kernel.org; Wed, 22 Jan 2020 08:28:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51912)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyw-0006mj-M2
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1iuFyv-0002Mh-IX
 for qemu-devel@nongnu.org; Wed, 22 Jan 2020 08:23:42 -0500
Received: from relay.sw.ru ([185.231.240.75]:42300)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFys-0002I1-VO; Wed, 22 Jan 2020 08:23:39 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1iuFyj-00057B-EI; Wed, 22 Jan 2020 16:23:29 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 2/7] migration/block-dirty-bitmap: rename finish_lock to just
 lock
Date: Wed, 22 Jan 2020 16:23:23 +0300
Message-Id: <20200122132328.31156-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200122132328.31156-1-vsementsov@virtuozzo.com>
References: <20200122132328.31156-1-vsementsov@virtuozzo.com>
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
Cc: kwolf@redhat.com, fam@euphon.net, vsementsov@virtuozzo.com,
 quintela@redhat.com, dgilbert@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

finish_lock is bad name, as lock used not only on process end.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 migration/block-dirty-bitmap.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 281d20f41d..502e858c31 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -141,13 +141,13 @@ typedef struct DirtyBitmapLoadState {
     BdrvDirtyBitmap *bitmap;
 
     GSList *enabled_bitmaps;
-    QemuMutex finish_lock;
+    QemuMutex lock; /* protect enabled_bitmaps */
 } DirtyBitmapLoadState;
 static DirtyBitmapLoadState dbm_load_state;
 
 void init_dirty_bitmap_incoming_migration(void)
 {
-    qemu_mutex_init(&dbm_load_state.finish_lock);
+    qemu_mutex_init(&dbm_load_state.lock);
 }
 
 static uint32_t qemu_get_bitmap_flags(QEMUFile *f)
@@ -495,7 +495,7 @@ void dirty_bitmap_mig_before_vm_start(void)
 {
     GSList *item;
 
-    qemu_mutex_lock(&dbm_load_state.finish_lock);
+    qemu_mutex_lock(&dbm_load_state.lock);
 
     for (item = dbm_load_state.enabled_bitmaps; item;
          item = g_slist_next(item))
@@ -514,7 +514,7 @@ void dirty_bitmap_mig_before_vm_start(void)
     g_slist_free(dbm_load_state.enabled_bitmaps);
     dbm_load_state.enabled_bitmaps = NULL;
 
-    qemu_mutex_unlock(&dbm_load_state.finish_lock);
+    qemu_mutex_unlock(&dbm_load_state.lock);
 }
 
 static void dirty_bitmap_load_complete(QEMUFile *f)
@@ -524,7 +524,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f)
     trace_dirty_bitmap_load_complete();
     bdrv_dirty_bitmap_deserialize_finish(s->bitmap);
 
-    qemu_mutex_lock(&dbm_load_state.finish_lock);
+    qemu_mutex_lock(&dbm_load_state.lock);
 
     for (item = dbm_load_state.enabled_bitmaps; item;
          item = g_slist_next(item))
@@ -558,7 +558,7 @@ static void dirty_bitmap_load_complete(QEMUFile *f)
         bdrv_dirty_bitmap_unlock(s->bitmap);
     }
 
-    qemu_mutex_unlock(&dbm_load_state.finish_lock);
+    qemu_mutex_unlock(&dbm_load_state.lock);
 }
 
 static int dirty_bitmap_load_bits(QEMUFile *f)
-- 
2.21.0


