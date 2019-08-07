Return-Path: <SRS0=g8gL=WD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DB21C32751
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25BAA21E71
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2019 14:13:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25BAA21E71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41610 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvMh3-0001Ur-BD
	for qemu-devel@archiver.kernel.org; Wed, 07 Aug 2019 10:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36616)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg8-0007lf-3S
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <vsementsov@virtuozzo.com>) id 1hvMg6-0003KJ-T0
 for qemu-devel@nongnu.org; Wed, 07 Aug 2019 10:12:35 -0400
Received: from relay.sw.ru ([185.231.240.75]:40636)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMg4-0003Cz-4t; Wed, 07 Aug 2019 10:12:32 -0400
Received: from [10.94.3.0] (helo=kvm.qa.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92)
 (envelope-from <vsementsov@virtuozzo.com>)
 id 1hvMfz-0005oH-EK; Wed, 07 Aug 2019 17:12:27 +0300
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
To: qemu-block@nongnu.org
Date: Wed,  7 Aug 2019 17:12:18 +0300
Message-Id: <20190807141226.193501-3-vsementsov@virtuozzo.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20190807141226.193501-1-vsementsov@virtuozzo.com>
References: <20190807141226.193501-1-vsementsov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 185.231.240.75
Subject: [Qemu-devel] [PATCH v4 02/10] block: reverse order for reopen
 commits
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
 qemu-devel@nongnu.org, mreitz@redhat.com, den@openvz.org, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

It's needed to fix reopening qcow2 with bitmaps to RW. Currently it
can't work, as qcow2 needs write access to file child, to mark bitmaps
in-image with IN_USE flag. But usually children goes after parents in
reopen queue and file child is still RO on qcow2 reopen commit. Reverse
reopen order to fix it.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 block.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/block.c b/block.c
index 696162cd7a..d59f9f97cb 100644
--- a/block.c
+++ b/block.c
@@ -3476,10 +3476,16 @@ int bdrv_reopen_multiple(BlockReopenQueue *bs_queue, Error **errp)
         bs_entry->perms_checked = true;
     }
 
-    /* If we reach this point, we have success and just need to apply the
-     * changes
+    /*
+     * If we reach this point, we have success and just need to apply the
+     * changes.
+     *
+     * Reverse order is used to comfort qcow2 driver: on commit it need to write
+     * IN_USE flag to the image, to mark bitmaps in the image as invalid. But
+     * children are usually goes after parents in reopen-queue, so go from last
+     * to first element.
      */
-    QTAILQ_FOREACH(bs_entry, bs_queue, entry) {
+    QTAILQ_FOREACH_REVERSE(bs_entry, bs_queue, entry) {
         bdrv_reopen_commit(&bs_entry->state);
     }
 
-- 
2.18.0


