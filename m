Return-Path: <SRS0=Z1O7=DF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A952C2D0A8
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:24:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83A1121D95
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2020 13:24:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83A1121D95
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kMt8a-0005pm-KM
	for qemu-devel@archiver.kernel.org; Mon, 28 Sep 2020 09:24:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55936)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsnW-0005co-KB; Mon, 28 Sep 2020 09:02:30 -0400
Received: from relay.sw.ru ([185.231.240.75]:58974 helo=relay3.sw.ru)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsnU-0000Wy-LZ; Mon, 28 Sep 2020 09:02:30 -0400
Received: from [172.16.25.136] (helo=localhost.sw.ru)
 by relay3.sw.ru with esmtp (Exim 4.94)
 (envelope-from <andrey.shinkevich@virtuozzo.com>)
 id 1kMsmw-001tba-G6; Mon, 28 Sep 2020 16:01:54 +0300
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, mreitz@redhat.com,
 stefanha@redhat.com, fam@euphon.net, jsnow@redhat.com, armbru@redhat.com,
 eblake@redhat.com, den@openvz.org, vsementsov@virtuozzo.com,
 andrey.shinkevich@virtuozzo.com
Subject: [PATCH v9 5/9] copy-on-read: limit guest COR activity to base in COR
 driver
Date: Mon, 28 Sep 2020 15:59:57 +0300
Message-Id: <1601298001-774096-6-git-send-email-andrey.shinkevich@virtuozzo.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
References: <1601298001-774096-1-git-send-email-andrey.shinkevich@virtuozzo.com>
Received-SPF: pass client-ip=185.231.240.75;
 envelope-from=andrey.shinkevich@virtuozzo.com; helo=relay3.sw.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 09:00:28
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

Limit the guest's COR operations by the base node in the backing chain
when the base node name is given. It will be useful for a block stream
job when the COR-filter is applied.

Signed-off-by: Andrey Shinkevich <andrey.shinkevich@virtuozzo.com>
---
 block/copy-on-read.c | 38 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/block/copy-on-read.c b/block/copy-on-read.c
index e04092f..f53f7e0 100644
--- a/block/copy-on-read.c
+++ b/block/copy-on-read.c
@@ -121,8 +121,42 @@ static int coroutine_fn cor_co_preadv_part(BlockDriverState *bs,
                                            size_t qiov_offset,
                                            int flags)
 {
-    return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
-                               flags | BDRV_REQ_COPY_ON_READ);
+    int64_t n = 0;
+    int64_t size = offset + bytes;
+    int local_flags;
+    int ret;
+    BDRVStateCOR *state = bs->opaque;
+
+    if (!state->base_bs) {
+        return bdrv_co_preadv_part(bs->file, offset, bytes, qiov, qiov_offset,
+                                   flags | BDRV_REQ_COPY_ON_READ);
+    }
+
+    while (offset < size) {
+        local_flags = flags;
+
+        /* In case of failure, try to copy-on-read anyway */
+        ret = bdrv_is_allocated(bs->file->bs, offset, bytes, &n);
+        if (!ret) {
+            ret = bdrv_is_allocated_above(bdrv_cow_bs(bs->file->bs),
+                                          state->base_bs, false, offset, n, &n);
+            if (ret > 0) {
+                local_flags |= BDRV_REQ_COPY_ON_READ;
+            }
+        }
+
+        ret = bdrv_co_preadv_part(bs->file, offset, n, qiov, qiov_offset,
+                                  local_flags);
+        if (ret < 0) {
+            return ret;
+        }
+
+        offset += n;
+        qiov_offset += n;
+        bytes -= n;
+    }
+
+    return 0;
 }
 
 
-- 
1.8.3.1


