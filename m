Return-Path: <SRS0=9x1+=D5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4530C4363A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:27:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14AB32417D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2020 18:27:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14AB32417D
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44980 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kVfJ4-0003bk-Pn
	for qemu-devel@archiver.kernel.org; Thu, 22 Oct 2020 14:27:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf6A-0000Wq-7W; Thu, 22 Oct 2020 14:14:02 -0400
Received: from relay.sw.ru ([185.231.240.75]:52084 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5x-0001nn-Mc; Thu, 22 Oct 2020 14:14:01 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kVf5r-005dVw-RZ; Thu, 22 Oct 2020 21:13:43 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, fam@euphon.net, stefanha@redhat.com,
 kwolf@redhat.com, mreitz@redhat.com, armbru@redhat.com, jsnow@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v12 10/14] block: include supported_read_flags into BDS
 structure
Date: Thu, 22 Oct 2020 21:13:39 +0300
Message-Id: <1603390423-980205-11-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1603390423-980205-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/22 14:13:46
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

Add the new member supported_read_flags to the BlockDriverState
structure. It will control the flags set for copy-on-read operations.
Make the block generic layer evaluate supported read flags before they
go to a block driver.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/io.c                | 12 ++++++++++--
 include/block/block_int.h |  4 ++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/block/io.c b/block/io.c
index 54f0968..78ddf13 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1392,6 +1392,9 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
     if (flags & BDRV_REQ_COPY_ON_READ) {
         int64_t pnum;
 
+        /* The flag BDRV_REQ_COPY_ON_READ has reached its addressee */
+        flags &= ~BDRV_REQ_COPY_ON_READ;
+
         ret = bdrv_is_allocated(bs, offset, bytes, &pnum);
         if (ret < 0) {
             goto out;
@@ -1413,9 +1416,13 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
         goto out;
     }
 
+    if (flags & ~bs->supported_read_flags) {
+        abort();
+    }
+
     max_bytes = ROUND_UP(MAX(0, total_bytes - offset), align);
     if (bytes <= max_bytes && bytes <= max_transfer) {
-        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, 0);
+        ret = bdrv_driver_preadv(bs, offset, bytes, qiov, qiov_offset, flags);
         goto out;
     }
 
@@ -1428,7 +1435,8 @@ static int coroutine_fn bdrv_aligned_preadv(BdrvChild *child,
 
             ret = bdrv_driver_preadv(bs, offset + bytes - bytes_remaining,
                                      num, qiov,
-                                     qiov_offset + bytes - bytes_remaining, 0);
+                                     qiov_offset + bytes - bytes_remaining,
+                                     flags);
             max_bytes -= num;
         } else {
             num = bytes_remaining;
diff --git a/include/block/block_int.h b/include/block/block_int.h
index f782737..474174c 100644
--- a/include/block/block_int.h
+++ b/include/block/block_int.h
@@ -873,6 +873,10 @@ struct BlockDriverState {
     /* I/O Limits */
     BlockLimits bl;
 
+    /*
+     * Flags honored during pread
+     */
+    unsigned int supported_read_flags;
     /* Flags honored during pwrite (so far: BDRV_REQ_FUA,
      * BDRV_REQ_WRITE_UNCHANGED).
      * If a driver does not support BDRV_REQ_WRITE_UNCHANGED, those
-- 
1.8.3.1


