Return-Path: <SRS0=NWXH=WU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24EF2C3A59E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:09:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E59CB2082E
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Aug 2019 10:08:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E59CB2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1Syh-0006gq-6O
	for qemu-devel@archiver.kernel.org; Sat, 24 Aug 2019 06:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51289)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1SxY-0006A9-OO
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:07:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1i1SxX-0005XM-PU
 for qemu-devel@nongnu.org; Sat, 24 Aug 2019 06:07:48 -0400
Received: from relay.sw.ru ([185.231.240.75]:60740)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1i1SxU-0005Se-J3; Sat, 24 Aug 2019 06:07:44 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1i1SxR-0007AX-IJ; Sat, 24 Aug 2019 13:07:41 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Sat, 24 Aug 2019 13:07:40 +0300
Message-Id: <20190824100740.61635-1-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH] block: fix permission update in
 bdrv_replace_node
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
Cc: kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's wrong to OR shared permissions. It may lead to crash on further
permission updates.
Also, no needs to consider previously calculated permissions, as at
this point we already bind all new parents and bdrv_get_cumulative_perm
result is enough. So fix the bug by just set permissions by
bdrv_get_cumulative_perm result.

Bug was introduced in long ago 234ac1a9025, in 2.9.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---

Hi all!

I found this bug during my work around backup-top filter. It happens that
on filter removing, bdrv_replace_node() breaks permissions in graph which
lead to bdrv_set_backing_hd(new backing: NULL) on
assert(tighten_restrictions == false).

 block.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 874a29a983..5944124845 100644
--- a/block.c
+++ b/block.c
@@ -4165,7 +4165,6 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
 {
     BdrvChild *c, *next;
     GSList *list = NULL, *p;
-    uint64_t old_perm, old_shared;
     uint64_t perm = 0, shared = BLK_PERM_ALL;
     int ret;
 
@@ -4211,8 +4210,8 @@ void bdrv_replace_node(BlockDriverState *from, BlockDriverState *to,
         bdrv_unref(from);
     }
 
-    bdrv_get_cumulative_perm(to, &old_perm, &old_shared);
-    bdrv_set_perm(to, old_perm | perm, old_shared | shared);
+    bdrv_get_cumulative_perm(to, &perm, &shared);
+    bdrv_set_perm(to, perm, shared);
 
 out:
     g_slist_free(list);
-- 
2.18.0


