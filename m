Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC73C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:40:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 798FA2074F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 18:40:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 798FA2074F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQbLG-00065U-MZ
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 14:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jQbI2-0000uq-7w
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:37:09 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <andrey.shinkevich@virtuozzo.com>) id 1jQbHz-0003w9-Fk
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 14:37:06 -0400
Received: from relay.sw.ru ([185.231.240.75]:39796)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jQbHs-0003NL-0V; Mon, 20 Apr 2020 14:36:56 -0400
Received: from dhcp-172-16-25-136.sw.ru ([172.16.25.136] helo=localhost.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.3)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1jQbHi-0001xO-Vd; Mon, 20 Apr 2020 21:36:47 +0300
From: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH 1/7] block: prepare block-stream for using COR-filter
Date: Mon, 20 Apr 2020 21:36:40 +0300
Message-Id: <1587407806-109784-2-git-send-email-andrey.shinkevich@virtuozzo.com>
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

This patch is the first one in the series where the COR-filter node
will be hard-coded for using in the block-stream job. The job may
be run with a block-commit job in parallel. Set the condition to
avoid the job conflicts.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 blockdev.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/blockdev.c b/blockdev.c
index 758e0b5..72d28ce 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -3297,7 +3297,9 @@ void qmp_block_stream(bool has_job_id, const char *job_id, const char *device,
     }
 
     /* Check for op blockers in the whole chain between bs and base */
-    for (iter = bs; iter && iter != base_bs; iter = bdrv_filtered_bs(iter)) {
+    for (iter = bdrv_skip_rw_filters(bs);
+        iter && iter != bdrv_skip_rw_filters(base_bs);
+        iter = bdrv_backing_chain_next(iter)) {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_STREAM, errp)) {
             goto out;
         }
@@ -3455,7 +3457,8 @@ void qmp_block_commit(bool has_job_id, const char *job_id, const char *device,
 
     assert(bdrv_get_aio_context(base_bs) == aio_context);
 
-    for (iter = top_bs; iter != bdrv_filtered_bs(base_bs);
+    for (iter = bdrv_skip_rw_filters(top_bs);
+         iter != bdrv_filtered_bs(base_bs);
          iter = bdrv_filtered_bs(iter))
     {
         if (bdrv_op_is_blocked(iter, BLOCK_OP_TYPE_COMMIT_TARGET, errp)) {
-- 
1.8.3.1


