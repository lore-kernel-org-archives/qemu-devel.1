Return-Path: <SRS0=HfOj=DH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C286BC4727E
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:50:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D57C2074A
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Sep 2020 09:50:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D57C2074A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNYl3-0002K5-Ao
	for qemu-devel@archiver.kernel.org; Wed, 30 Sep 2020 05:50:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37532)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhQ-00072p-M1
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:5155 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cenjiahui@huawei.com>)
 id 1kNYhM-0003oH-Tl
 for qemu-devel@nongnu.org; Wed, 30 Sep 2020 05:47:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id A8B59516CA08BE7B74C5;
 Wed, 30 Sep 2020 17:46:52 +0800 (CST)
Received: from localhost (10.174.186.107) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.487.0; Wed, 30 Sep 2020
 17:46:42 +0800
From: Jiahui Cen <cenjiahui@huawei.com>
To: <qemu-devel@nongnu.org>
Subject: [RFC PATCH v2 2/8] block-backend: rehandle block aios when EIO
Date: Wed, 30 Sep 2020 17:46:00 +0800
Message-ID: <20200930094606.5323-3-cenjiahui@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200930094606.5323-1-cenjiahui@huawei.com>
References: <20200930094606.5323-1-cenjiahui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.174.186.107]
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=45.249.212.190; envelope-from=cenjiahui@huawei.com;
 helo=huawei.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/30 05:46:53
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
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
Cc: kwolf@redhat.com, fangying1@huawei.com, cenjiahui@huawei.com,
 zhang.zhanghailiang@huawei.com, mreitz@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When a backend device temporarily does not response, like a network disk down
due to some network faults, any IO to the coresponding virtual block device
in VM would return I/O error. If the hypervisor returns the error to VM, the
filesystem on this block device may not work as usual. And in many situations,
the returned error is often an EIO.

To avoid this unavailablity, we can store the failed AIOs, and resend them
later. If the error is temporary, the retries can succeed and the AIOs can
be successfully completed.

Signed-off-by: Jiahui Cen <cenjiahui@huawei.com>
Signed-off-by: Ying Fang <fangying1@huawei.com>
---
 block/block-backend.c | 89 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/block/block-backend.c b/block/block-backend.c
index b8367d82cc..8050669d23 100644
--- a/block/block-backend.c
+++ b/block/block-backend.c
@@ -365,6 +365,12 @@ BlockBackend *blk_new(AioContext *ctx, uint64_t perm, uint64_t shared_perm)
     notifier_list_init(&blk->remove_bs_notifiers);
     notifier_list_init(&blk->insert_bs_notifiers);
 
+    /* for rehandle */
+    blk->reinfo.enable = false;
+    blk->reinfo.ts = NULL;
+    qatomic_set(&blk->reinfo.in_flight, 0);
+    QTAILQ_INIT(&blk->reinfo.re_aios);
+
     QLIST_INIT(&blk->aio_notifiers);
 
     QTAILQ_INSERT_TAIL(&block_backends, blk, link);
@@ -1425,8 +1431,16 @@ static const AIOCBInfo blk_aio_em_aiocb_info = {
     .get_aio_context    = blk_aio_em_aiocb_get_aio_context,
 };
 
+static void blk_rehandle_timer_cb(void *opaque);
+static void blk_rehandle_aio_complete(BlkAioEmAIOCB *acb);
+
 static void blk_aio_complete(BlkAioEmAIOCB *acb)
 {
+    if (acb->rwco.blk->reinfo.enable) {
+        blk_rehandle_aio_complete(acb);
+        return;
+    }
+
     if (acb->has_returned) {
         acb->common.cb(acb->common.opaque, acb->rwco.ret);
         blk_dec_in_flight(acb->rwco.blk);
@@ -1459,6 +1473,7 @@ static BlockAIOCB *blk_aio_prwv(BlockBackend *blk, int64_t offset, int bytes,
         .ret    = NOT_DONE,
     };
     acb->bytes = bytes;
+    acb->co_entry = co_entry;
     acb->has_returned = false;
 
     co = qemu_coroutine_create(co_entry, acb);
@@ -2054,6 +2069,20 @@ static int blk_do_set_aio_context(BlockBackend *blk, AioContext *new_context,
             throttle_group_attach_aio_context(tgm, new_context);
             bdrv_drained_end(bs);
         }
+
+        if (blk->reinfo.enable) {
+            if (blk->reinfo.ts) {
+                timer_del(blk->reinfo.ts);
+                timer_free(blk->reinfo.ts);
+            }
+            blk->reinfo.ts = aio_timer_new(new_context, QEMU_CLOCK_REALTIME,
+                                           SCALE_MS, blk_rehandle_timer_cb,
+                                           blk);
+            if (qatomic_read(&blk->reinfo.in_flight)) {
+                timer_mod(blk->reinfo.ts,
+                          qemu_clock_get_ms(QEMU_CLOCK_REALTIME));
+            }
+        }
     }
 
     blk->ctx = new_context;
@@ -2406,6 +2435,66 @@ static void blk_root_drained_end(BdrvChild *child, int *drained_end_counter)
     }
 }
 
+static void blk_rehandle_insert_aiocb(BlockBackend *blk, BlkAioEmAIOCB *acb)
+{
+    assert(blk->reinfo.enable);
+
+    qatomic_inc(&blk->reinfo.in_flight);
+    QTAILQ_INSERT_TAIL(&blk->reinfo.re_aios, acb, list);
+    timer_mod(blk->reinfo.ts, qemu_clock_get_ms(QEMU_CLOCK_REALTIME) +
+                              blk->reinfo.timer_interval_ms);
+}
+
+static void blk_rehandle_remove_aiocb(BlockBackend *blk, BlkAioEmAIOCB *acb)
+{
+    QTAILQ_REMOVE(&blk->reinfo.re_aios, acb, list);
+    qatomic_dec(&blk->reinfo.in_flight);
+}
+
+static void blk_rehandle_timer_cb(void *opaque)
+{
+    BlockBackend *blk = opaque;
+    BlockBackendRehandleInfo *reinfo = &blk->reinfo;
+    BlkAioEmAIOCB *acb, *tmp;
+    Coroutine *co;
+
+    aio_context_acquire(blk_get_aio_context(blk));
+    QTAILQ_FOREACH_SAFE(acb, &reinfo->re_aios, list, tmp) {
+        if (acb->rwco.ret == NOT_DONE) {
+            continue;
+        }
+
+        blk_inc_in_flight(acb->rwco.blk);
+        acb->rwco.ret = NOT_DONE;
+        acb->has_returned = false;
+        blk_rehandle_remove_aiocb(acb->rwco.blk, acb);
+
+        co = qemu_coroutine_create(acb->co_entry, acb);
+        qemu_coroutine_enter(co);
+
+        acb->has_returned = true;
+        if (acb->rwco.ret != NOT_DONE) {
+            replay_bh_schedule_oneshot_event(blk_get_aio_context(blk),
+                                             blk_aio_complete_bh, acb);
+        }
+    }
+    aio_context_release(blk_get_aio_context(blk));
+}
+
+static void blk_rehandle_aio_complete(BlkAioEmAIOCB *acb)
+{
+    if (acb->has_returned) {
+        blk_dec_in_flight(acb->rwco.blk);
+        if (acb->rwco.ret == -EIO) {
+            blk_rehandle_insert_aiocb(acb->rwco.blk, acb);
+            return;
+        }
+
+        acb->common.cb(acb->common.opaque, acb->rwco.ret);
+        qemu_aio_unref(acb);
+    }
+}
+
 void blk_register_buf(BlockBackend *blk, void *host, size_t size)
 {
     bdrv_register_buf(blk_bs(blk), host, size);
-- 
2.28.0


