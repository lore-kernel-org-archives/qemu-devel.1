Return-Path: <SRS0=e3er=AV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF7AC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:55:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B383D207BC
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2020 08:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B383D207BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtooK-0000Rm-VP
	for qemu-devel@archiver.kernel.org; Fri, 10 Jul 2020 04:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36886)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1jtonb-0008Q1-Oq; Fri, 10 Jul 2020 04:54:27 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:3718 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yezhenyu2@huawei.com>)
 id 1jtonZ-0008B1-I4; Fri, 10 Jul 2020 04:54:27 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id A981EC9A05AA6EA97629;
 Fri, 10 Jul 2020 16:54:16 +0800 (CST)
Received: from DESKTOP-KKJBAGG.china.huawei.com (10.174.186.75) by
 DGGEMS405-HUB.china.huawei.com (10.3.19.205) with Microsoft SMTP Server id
 14.3.487.0; Fri, 10 Jul 2020 16:54:06 +0800
From: Zhenyu Ye <yezhenyu2@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH v1] qmp: don't hold ctx lock while querying blockstats
Date: Fri, 10 Jul 2020 16:54:00 +0800
Message-ID: <20200710085400.343-1-yezhenyu2@huawei.com>
X-Mailer: git-send-email 2.22.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.75]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=yezhenyu2@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/10 04:54:17
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: kwolf@redhat.com, qemu-block@nongnu.org, yezhenyu2@huawei.com,
 qemu-trivial@nongnu.org, armbru@redhat.com, xiexiangyou@huawei.com,
 mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Because the QMP command runs in the main thread, and changes
to the aio context of iothread will only be executed in the
main thread (they will not be in parallel), so there is no
need a lock protection while querying blockstats.

If we hold the lock here, while the I/O pressure is high in
vm and the I/O returns slowly, the main thread will be stuck
until the lock is released, which will affect the vcpu operation
and finall cause the vm to be stuck.

Signed-off-by: Zhenyu Ye <yezhenyu2@huawei.com>
---
 block/qapi.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/block/qapi.c b/block/qapi.c
index afd9f3b4a7..fa56bc145d 100644
--- a/block/qapi.c
+++ b/block/qapi.c
@@ -609,11 +609,8 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
     if (has_query_nodes && query_nodes) {
         for (bs = bdrv_next_node(NULL); bs; bs = bdrv_next_node(bs)) {
             BlockStatsList *info = g_malloc0(sizeof(*info));
-            AioContext *ctx = bdrv_get_aio_context(bs);
 
-            aio_context_acquire(ctx);
             info->value = bdrv_query_bds_stats(bs, false);
-            aio_context_release(ctx);
 
             *p_next = info;
             p_next = &info->next;
@@ -621,7 +618,6 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
     } else {
         for (blk = blk_all_next(NULL); blk; blk = blk_all_next(blk)) {
             BlockStatsList *info;
-            AioContext *ctx = blk_get_aio_context(blk);
             BlockStats *s;
             char *qdev;
 
@@ -629,7 +625,6 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
                 continue;
             }
 
-            aio_context_acquire(ctx);
             s = bdrv_query_bds_stats(blk_bs(blk), true);
             s->has_device = true;
             s->device = g_strdup(blk_name(blk));
@@ -643,7 +638,6 @@ BlockStatsList *qmp_query_blockstats(bool has_query_nodes,
             }
 
             bdrv_query_blk_stats(s->stats, blk);
-            aio_context_release(ctx);
 
             info = g_malloc0(sizeof(*info));
             info->value = s;
-- 
2.19.1



