Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8A46C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F1712086A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 10:08:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F1712086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8i0G-0001YI-SJ
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 05:08:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50777)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8hxV-0004W6-Ab
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:05:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1j8hxU-0007lW-9E
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 05:05:57 -0500
Received: from relay.sw.ru ([185.231.240.75]:48190)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1j8hxR-0007jJ-S7; Mon, 02 Mar 2020 05:05:54 -0500
Received: from vovaso.qa.sw.ru ([10.94.3.0] helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1j8hxI-000350-An; Mon, 02 Mar 2020 13:05:44 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 4/5] block/io: fix bdrv_co_do_pwrite_zeroes head calculation
Date: Mon,  2 Mar 2020 13:05:36 +0300
Message-Id: <20200302100537.29058-5-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200302100537.29058-1-vsementsov@virtuozzo.com>
References: <20200302100537.29058-1-vsementsov@virtuozzo.com>
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
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
 qemu-stable@nongnu.org, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, den@openvz.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's wrong to update head using num in this place, as num may be
reduced during the iteration, and we'll have wrong head value on next
iteration.

Instead update head at iteration end.

Cc: qemu-stable@nongnu.org
Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block/io.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/io.c b/block/io.c
index 75fd5600c2..c64566b4cf 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1785,7 +1785,6 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
              * convenience, limit this request to max_transfer even if
              * we don't need to fall back to writes.  */
             num = MIN(MIN(bytes, max_transfer), alignment - head);
-            head = (head + num) % alignment;
             assert(num < max_write_zeroes);
         } else if (tail && num > alignment) {
             /* Shorten the request to the last aligned sector.  */
@@ -1844,6 +1843,9 @@ static int coroutine_fn bdrv_co_do_pwrite_zeroes(BlockDriverState *bs,
 
         offset += num;
         bytes -= num;
+        if (head) {
+            head = offset % alignment;
+        }
     }
 
 fail:
-- 
2.21.0


