Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB24EC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:28:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8428920CC7
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 10:28:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8428920CC7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlVIY-0006BO-Pc
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 06:28:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54434)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <root@localhost>)
 id 1jlVGr-0004Hz-Ah; Wed, 17 Jun 2020 06:26:17 -0400
Received: from [114.255.249.163] (port=49820 helo=localhost)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <root@localhost>)
 id 1jlVGo-0007Oh-G5; Wed, 17 Jun 2020 06:26:17 -0400
Received: by localhost (Postfix, from userid 0)
 id 1939F1415E5; Wed, 17 Jun 2020 18:20:24 +0800 (CST)
From: Lin Ma <lma@suse.com>
To: qemu-block@nongnu.org
Subject: [PATCH v2 2/3] block: Add GET LBA STATUS support
Date: Wed, 17 Jun 2020 18:20:18 +0800
Message-Id: <20200617102019.29652-3-lma@suse.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200617102019.29652-1-lma@suse.com>
References: <20200617102019.29652-1-lma@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 114.255.249.163 (failed)
Received-SPF: none client-ip=114.255.249.163; envelope-from=root@localhost;
 helo=localhost
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/17 06:20:25
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: 68
X-Spam_score: 6.8
X-Spam_bar: ++++++
X-Spam_report: (6.8 / 5.0 requ) BAYES_00=-1.9, FSL_HELO_NON_FQDN_1=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, HELO_LOCALHOST=3.828, RCVD_IN_MSPIKE_BL=0.01,
 RCVD_IN_MSPIKE_ZBI=2.7, RCVD_IN_XBL=0.375, RDNS_NONE=0.793,
 SPF_NONE=0.001 autolearn=_AUTOLEARN
X-Spam_action: reject
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
Cc: fam@euphon.net, kwolf@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com,
 stefanha@redhat.com, Lin Ma <lma@suse.com>, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Lin Ma <lma@suse.com>
---
 block/block-backend.c          | 38 ++++++++++++++++++++++++++++++++++
 include/sysemu/block-backend.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index 6936b25c83..6d08dd5e0d 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -1650,6 +1650,44 @@ int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes)
     return blk_prw(blk, offset, NULL, bytes, blk_pdiscard_entry, 0);
 }
 
+static int coroutine_fn
+blk_do_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                      uint32_t *num_blocks, uint32_t *is_deallocated)
+{
+    int ret;
+
+    blk_wait_while_drained(blk);
+
+    ret = blk_check_byte_request(blk, offset, bytes);
+    if (ret < 0) {
+        return ret;
+    }
+
+    return bdrv_co_get_lba_status(blk->root, offset, bytes, num_blocks,
+                                  is_deallocated);
+}
+
+static void blk_aio_get_lba_status_entry(void *opaque)
+{
+    BlkAioEmAIOCB *acb = opaque;
+    BlkRwCo *rwco = &acb->rwco;
+
+    void *data = acb->common.opaque;
+    uint32_t *num_blocks = (uint32_t *)data;
+    uint32_t *is_deallocated = (uint32_t *)(data + sizeof(uint32_t));
+
+    rwco->ret = blk_do_get_lba_status(rwco->blk, rwco->offset, acb->bytes,
+                                      num_blocks, is_deallocated);
+    blk_aio_complete(acb);
+}
+
+BlockAIOCB *blk_aio_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                                   BlockCompletionFunc *cb, void *opaque)
+{
+    return blk_aio_prwv(blk, offset, bytes, NULL, blk_aio_get_lba_status_entry,
+                        0, cb, opaque);
+}
+
 /* To be called between exactly one pair of blk_inc/dec_in_flight() */
 static int coroutine_fn blk_do_flush(BlockBackend *blk)
 {
diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
index 8203d7f6f9..cd527ec0c9 100644
--- a/include/sysemu/block-backend.h
+++ b/include/sysemu/block-backend.h
@@ -171,6 +171,8 @@ BlockAIOCB *blk_aio_flush(BlockBackend *blk,
                           BlockCompletionFunc *cb, void *opaque);
 BlockAIOCB *blk_aio_pdiscard(BlockBackend *blk, int64_t offset, int bytes,
                              BlockCompletionFunc *cb, void *opaque);
+BlockAIOCB *blk_aio_get_lba_status(BlockBackend *blk, int64_t offset, int bytes,
+                                   BlockCompletionFunc *cb, void *opaque);
 void blk_aio_cancel(BlockAIOCB *acb);
 void blk_aio_cancel_async(BlockAIOCB *acb);
 int blk_ioctl(BlockBackend *blk, unsigned long int req, void *buf);
-- 
2.26.0


