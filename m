Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 449ACC2BD09
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D15F24653
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 19:32:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D15F24653
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icwri-00075U-6B
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 14:32:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56391)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icwq8-0006XZ-OC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:31:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1icwq7-0001ND-Bb
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 14:31:04 -0500
Received: from relay.sw.ru ([185.231.240.75]:51528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1icwq0-0001A4-Qt; Thu, 05 Dec 2019 14:30:57 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1icwpt-0001aj-II; Thu, 05 Dec 2019 22:30:49 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH for-4.2?] block/qcow2-bitmap: fix crash bug in
 qcow2_co_remove_persistent_dirty_bitmap
Date: Thu,  5 Dec 2019 22:30:49 +0300
Message-Id: <20191205193049.30666-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, jsnow@redhat.com,
 qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Here is double bug:

First, return error but not set errp. This may lead to:
qmp block-dirty-bitmap-remove may report success when actually failed

block-dirty-bitmap-remove used in a transaction will crash, as
qmp_transaction will think that it returned success and will cal
block_dirty_bitmap_remove_commit which will crash, as state->bitmap is
NULL

Second (like in anecdote), this case is not an error at all. As it is
documented in the comment above bdrv_co_remove_persistent_dirty_bitmap
definition, absence of bitmap is not an error, and similar case handled
at start of qcow2_co_remove_persistent_dirty_bitmap, it returns 0 when
there is no bitmaps at all..

But when there are some bitmaps, but not the requested one, it return
error with errp unset.

Fix that.

Fixes: b56a1e31759b750
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

Ohm, suddenly we faced this bug. It's a regression in 4.2. I'm very
sorry for introducing it, and it sad that it's found so late..

Personally, I think that this one worth rc5, as it makes new bitmap
interfaces unusable. But the decision is yours.

Last minute edit: hmm, actually, transaction action introduced in
4.2, so crash is not a regression, only broken block-dirty-bitmap-remove
command is a regression... Maybe it's OK for stable.

 block/qcow2-bitmap.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
index 8abaf632fc..c6c8ebbe89 100644
--- a/block/qcow2-bitmap.c
+++ b/block/qcow2-bitmap.c
@@ -1469,8 +1469,10 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
     Qcow2BitmapList *bm_list;
 
     if (s->nb_bitmaps == 0) {
-        /* Absence of the bitmap is not an error: see explanation above
-         * bdrv_remove_persistent_dirty_bitmap() definition. */
+        /*
+         * Absence of the bitmap is not an error: see explanation above
+         * bdrv_co_remove_persistent_dirty_bitmap() definition.
+         */
         return 0;
     }
 
@@ -1485,7 +1487,8 @@ int coroutine_fn qcow2_co_remove_persistent_dirty_bitmap(BlockDriverState *bs,
 
     bm = find_bitmap_by_name(bm_list, name);
     if (bm == NULL) {
-        ret = -EINVAL;
+        /* Absence of the bitmap is not an error, see above. */
+        ret = 0;
         goto out;
     }
 
-- 
2.21.0


