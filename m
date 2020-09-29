Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E246DC4727C
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:50:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DAF72083B
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 12:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DAF72083B
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33906 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNF5P-0001GY-S4
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 08:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53400)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kNEwf-0007wv-L1; Tue, 29 Sep 2020 08:41:25 -0400
Received: from relay.sw.ru ([185.231.240.75]:35052 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kNEwa-0000hc-AB; Tue, 29 Sep 2020 08:41:25 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kNEw0-002EOe-Nx; Tue, 29 Sep 2020 15:40:44 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v10 6/9] copy-on-read: skip non-guest reads if no copy needed
Date: Tue, 29 Sep 2020 15:38:26 +0300
Message-Id: <1601383109-110988-7-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1601383109-110988-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 08:38:56
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Reply-to: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
From: Andrey Shinkevich via <qemu-devel@nongnu.org>

If the flag BDRV_REQ_PREFETCH was set, pass it further to the
COR-driver to skip unneeded reading. It can be taken into account for
the COR-algorithms optimization. That check is being made during the
block stream job by the moment.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c | 14 ++++++++++----
 block/io.c           |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index f53f7e0..5389dca 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -145,10 +145,16 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
             }
         }
 
-        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
-                                  local_flags);
-        if (ret < 0) {
-            return ret;
+        if ((flags & BDRV_REQ_PREFETCH) &
+            !(local_flags & BDRV_REQ_COPY_ON_READ)) {
+            /* Skip non-guest reads if no copy needed */
+        } else {
+
+            ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
+                                      local_flags);
+            if (ret < 0) {
+                return ret;
+            }
         }
 
         offset += n;
diff --git a/block/io.c b/block/io.c
index 11df188..62b75a5 100644
--- a/block/io.c
+++ b/block/io.c
@@ -1388,7 +1388,7 @@ static int coroutine_fn bdrv_co_do_copy_on_readv(BdrvChild *child,
             qemu_iovec_init_buf(&local_qiov, bounce_buffer, pnum);
 
             ret = bdrv_driver_preadv(bs, cluster_offset, pnum,
-                                     &local_qiov, 0, 0);
+                                     &local_qiov, 0, flags & BDRV_REQ_PREFETCH);
             if (ret < 0) {
                 goto err;
             }
-- 
1.8.3.1


