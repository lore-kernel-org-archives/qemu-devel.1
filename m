Return-Path: <SRS0=aFsj=XS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A739C04EBF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:26:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2CA21207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Sep 2019 12:26:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2CA21207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55898 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iCNPp-0004q9-Py
	for qemu-devel@archiver.kernel.org; Mon, 23 Sep 2019 08:26:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48171)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNIF-0006tg-SO
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:18:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <anton.nefedov@virtuozzo.com>) id 1iCNID-0001nJ-A8
 for qemu-devel@nongnu.org; Mon, 23 Sep 2019 08:18:15 -0400
Received: from relay.sw.ru ([185.231.240.75]:59136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iCNI7-0001he-Qd; Mon, 23 Sep 2019 08:18:08 -0400
Received: from [172.16.25.154] (helo=xantnef-ws.sw.ru)
 by relay.sw.ru with esmtp (Exim 4.92.2)
 (envelope-from <anton.nefedov@virtuozzo.com>)
 id 1iCNI3-0007xx-NA; Mon, 23 Sep 2019 15:18:03 +0300
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
To: qemu-block@nongnu.org
Subject: [PATCH v10 3/9] block: add empty account cookie type
Date: Mon, 23 Sep 2019 15:17:31 +0300
Message-Id: <20190923121737.83281-4-anton.nefedov@virtuozzo.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
References: <20190923121737.83281-1-anton.nefedov@virtuozzo.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: kwolf@redhat.com, vsementsov@virtuozzo.com, berto@igalia.com,
 den@virtuozzo.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 Anton Nefedov <anton.nefedov@virtuozzo.com>, pbonzini@redhat.com,
 jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Each block_acct_done/failed call is designed to correspond to a
previous block_acct_start call, which initializes the stats cookie.
However sometimes it is not the case, e.g. some error paths might
report the same cookie twice because it is hard to accurately track if
the cookie was reported yet or not.

This patch cleans the cookie after report.
(Note: block_acct_failed/done without a previous block_acct_start at
all should be avoided. Uninitialized cookie might hold a garbage value
and there is still "< BLOCK_MAX_IOTYPE" assertion for that)

It will be particularly useful in ide code where it's hard to
keep track whether the request done its accounting or not: in the
following patch of the series, trim requests will do the accounting
separately.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/accounting.h | 1 +
 block/accounting.c         | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/include/block/accounting.h b/include/block/accounting.h
index ba8b04d572..878b4c3581 100644
--- a/include/block/accounting.h
+++ b/include/block/accounting.h
@@ -33,6 +33,7 @@ typedef struct BlockAcctTimedStats BlockAcctTimedStats;
 typedef struct BlockAcctStats BlockAcctStats;
 
 enum BlockAcctType {
+    BLOCK_ACCT_NONE = 0,
     BLOCK_ACCT_READ,
     BLOCK_ACCT_WRITE,
     BLOCK_ACCT_FLUSH,
diff --git a/block/accounting.c b/block/accounting.c
index 70a3d9a426..8d41c8a83a 100644
--- a/block/accounting.c
+++ b/block/accounting.c
@@ -195,6 +195,10 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
 
     assert(cookie->type < BLOCK_MAX_IOTYPE);
 
+    if (cookie->type == BLOCK_ACCT_NONE) {
+        return;
+    }
+
     qemu_mutex_lock(&stats->lock);
 
     if (failed) {
@@ -217,6 +221,8 @@ static void block_account_one_io(BlockAcctStats *stats, BlockAcctCookie *cookie,
     }
 
     qemu_mutex_unlock(&stats->lock);
+
+    cookie->type = BLOCK_ACCT_NONE;
 }
 
 void block_acct_done(BlockAcctStats *stats, BlockAcctCookie *cookie)
-- 
2.17.1


