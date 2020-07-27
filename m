Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45A02C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A08A2070B
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 21:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XQrFrU8O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A08A2070B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51350 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0AKA-00053L-8r
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 17:06:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35192)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAd-0005V3-L5
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:27 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24659
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1k0AAZ-0004yW-RH
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 16:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595883380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uLYCusIIYVBIf0xiCXWTmILkEuREcQ5pTTnFopi18ZM=;
 b=XQrFrU8OU/SeCGTIJoZT56A2C96VBy4U+FCLsqUql+H4eOEl/Je8GwdUDZ8/Tnv5CANsc5
 6jLJqH3pyvxuklHtq35bNFqg0pJZEU5SfyJp2jTb9j7EmAm2IIFxirPDJvytiJw6fGq0+4
 9jVlsbQivkRHDk901WEKEaTq4icoSV4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-ypknWNVTPRO0pN_9js9nuA-1; Mon, 27 Jul 2020 16:56:18 -0400
X-MC-Unique: ypknWNVTPRO0pN_9js9nuA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 683DB10059A9;
 Mon, 27 Jul 2020 20:56:17 +0000 (UTC)
Received: from blue.redhat.com (ovpn-118-248.rdu2.redhat.com [10.10.118.248])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3554D19724;
 Mon, 27 Jul 2020 20:56:16 +0000 (UTC)
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/24] migration/block-dirty-bitmap: simplify
 dirty_bitmap_load_complete
Date: Mon, 27 Jul 2020 15:55:33 -0500
Message-Id: <20200727205543.206624-15-eblake@redhat.com>
In-Reply-To: <20200727205543.206624-1-eblake@redhat.com>
References: <20200727205543.206624-1-eblake@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
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
Cc: Fam Zheng <fam@euphon.net>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "open list:Block I/O path" <qemu-block@nongnu.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

bdrv_enable_dirty_bitmap_locked() call does nothing, as if we are in
postcopy, bitmap successor must be enabled, and reclaim operation will
enable the bitmap.

So, actually we need just call _reclaim_ in both if branches, and
making differences only to add an assertion seems not really good. The
logic becomes simple: on load complete we do reclaim and that's all.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
Message-Id: <20200727194236.19551-14-vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 migration/block-dirty-bitmap.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/migration/block-dirty-bitmap.c b/migration/block-dirty-bitmap.c
index 9194807b54f1..405a259296d9 100644
--- a/migration/block-dirty-bitmap.c
+++ b/migration/block-dirty-bitmap.c
@@ -603,6 +603,10 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)

     qemu_mutex_lock(&s->lock);

+    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
+        bdrv_reclaim_dirty_bitmap(s->bitmap, &error_abort);
+    }
+
     for (item = s->enabled_bitmaps; item; item = g_slist_next(item)) {
         LoadBitmapState *b = item->data;

@@ -612,27 +616,6 @@ static void dirty_bitmap_load_complete(QEMUFile *f, DBMLoadState *s)
         }
     }

-    if (bdrv_dirty_bitmap_has_successor(s->bitmap)) {
-        bdrv_dirty_bitmap_lock(s->bitmap);
-        if (s->enabled_bitmaps == NULL) {
-            /* in postcopy */
-            bdrv_reclaim_dirty_bitmap_locked(s->bitmap, &error_abort);
-            bdrv_enable_dirty_bitmap_locked(s->bitmap);
-        } else {
-            /* target not started, successor must be empty */
-            int64_t count = bdrv_get_dirty_count(s->bitmap);
-            BdrvDirtyBitmap *ret = bdrv_reclaim_dirty_bitmap_locked(s->bitmap,
-                                                                    NULL);
-            /* bdrv_reclaim_dirty_bitmap can fail only on no successor (it
-             * must be) or on merge fail, but merge can't fail when second
-             * bitmap is empty
-             */
-            assert(ret == s->bitmap &&
-                   count == bdrv_get_dirty_count(s->bitmap));
-        }
-        bdrv_dirty_bitmap_unlock(s->bitmap);
-    }
-
     qemu_mutex_unlock(&s->lock);
 }

-- 
2.27.0


