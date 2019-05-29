Return-Path: <SRS0=DspQ=T5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B783FC28CC0
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:49:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 915C123BCD
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2019 15:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 915C123BCD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:56880 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hW0pT-0005n9-PE
	for qemu-devel@archiver.kernel.org; Wed, 29 May 2019 11:49:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54878)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0n8-0004V5-Vo
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1hW0n7-00053R-Rh
	for qemu-devel@nongnu.org; Wed, 29 May 2019 11:47:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:43146)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n7-00051w-IO; Wed, 29 May 2019 11:47:01 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
	by relay.sw.ru with esmtp (Exim 4.91)
	(envelope-from <vsementsov@virtuozzo.com>)
	id 1hW0n2-0004iP-7J; Wed, 29 May 2019 18:46:56 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Date: Wed, 29 May 2019 18:46:50 +0300
Message-Id: <20190529154654.95870-4-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190529154654.95870-1-vsementsov@virtuozzo.com>
References: <20190529154654.95870-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v8 3/7] block: allow not one child for implicit
 node
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, vsementsov@virtuozzo.com,
	mreitz@redhat.com, stefanha@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Upcoming backup-top filter wants to operate like usual implicit filter
node with fall-through to backing child. But also needs additional
target child, let's support that.

On the other hand, after backup completion (before job dismiss) filter
is still attached to job blk, but don't have any children. Support this
too.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/block.c b/block.c
index 57216f4115..3f4de3ae32 100644
--- a/block.c
+++ b/block.c
@@ -6200,9 +6200,20 @@ void bdrv_refresh_filename(BlockDriverState *bs)
     }
 
     if (bs->implicit) {
-        /* For implicit nodes, just copy everything from the single child */
+        /*
+         * For implicit nodes, just copy everything from the single child or
+         * from backing, if there are several children.
+         * If there are no children for some reason (filter is still attached
+         * to block-job blk, but already removed from backing chain of device)
+         * do nothing.
+         */
         child = QLIST_FIRST(&bs->children);
-        assert(QLIST_NEXT(child, next) == NULL);
+        if (!child) {
+            return;
+        } else if (QLIST_NEXT(child, next)) {
+            assert(bs->backing);
+            child = bs->backing;
+        }
 
         pstrcpy(bs->exact_filename, sizeof(bs->exact_filename),
                 child->bs->exact_filename);
-- 
2.18.0


