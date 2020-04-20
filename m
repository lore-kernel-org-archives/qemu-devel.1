Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 771EFC54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:38:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50C6C20724
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:38:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50C6C20724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40650 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbJS-0002wY-Fw
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:38:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44864 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jQbI4-00011Z-Di
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:37:10 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jQbI1-00040C-Ti
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:37:08 -0400
Received: from relay.sw.ru ([185.231.240.75]:39784)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jQbHr-0003NE-Nc; Mon, 20 Apr 2020 14:36:55 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jQbHj-0001xO-B4; Mon, 20 Apr 2020 21:36:47 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 3/7] block: protect parallel jobs from overlapping
Date: Mon, 20 Apr 2020 21:36:42 +0300
Message-Id: <1587407806-109784-4-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1587407806-109784-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay.sw.ru
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 14:36:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, armbru@redhat.com,
 qemu-devel@nongnu.org, andrey.shinkevich@virtuozzo.com, den@openvz.org,
 mreitz@redhat.com, jsnow@redhat.com, dgilbert@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When it comes to the check for the blocked operations, the node may be
a filter linked to blk. In that case, do not miss to set blocked
operations for the underlying node.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 blockjob.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/blockjob.c b/blockjob.c
index 73d9f1b..2898929 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -189,7 +189,14 @@ void block_job_remove_all_bdrv(BlockJob *job)
     GSList *l;
     for (l = job->nodes; l; l = l->next) {
         BdrvChild *c = l->data;
-        bdrv_op_unblock_all(c->bs, job->blocker);
+        BlockDriverState *bs = c->bs;
+        bdrv_op_unblock_all(bs, job->blocker);
+        if (bs->drv && bs->drv->is_filter) {
+            bs = bdrv_filtered_bs(bs);
+            if (bs) {
+                bdrv_op_unblock_all(bs, job->blocker);
+            }
+        }
         bdrv_root_unref_child(c);
     }
     g_slist_free(job->nodes);
@@ -230,6 +237,12 @@ int block_job_add_bdrv(BlockJob *job, const char *name, BlockDriverState *bs,
 
     job->nodes = g_slist_prepend(job->nodes, c);
     bdrv_op_block_all(bs, job->blocker);
+    if (bs->drv && bs->drv->is_filter) {
+        bs = bdrv_filtered_bs(bs);
+        if (bs) {
+            bdrv_op_block_all(bs, job->blocker);
+        }
+    }
 
     return 0;
 }
-- 
1.8.3.1


