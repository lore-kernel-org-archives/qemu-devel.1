Return-Path: <SRS0=gwGE=EC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F939C55178
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:07:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE83922264
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2020 14:07:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fkoiN60/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE83922264
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXPcp-0004uM-SL
	for qemu-devel@archiver.kernel.org; Tue, 27 Oct 2020 10:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35916)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPTA-0003Iv-18
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:57:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44780)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kXPSy-0004Kq-5X
 for qemu-devel@nongnu.org; Tue, 27 Oct 2020 09:56:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603807007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YRHflBytAvKOEPighLIKwiOsYqMDgywNA3AUBcmPj5o=;
 b=fkoiN60/k62X8n4I4/I956X1wL37PsrOnQzzB2uMPc5cgMwQgUKb+rT4ispKSuFMIgwNlK
 ANiR4XUyx+DsOz/I96zZ0vIPP4ILmqKOKi4UY3MQmGiuMFVDBcv9nqRl5H1Lc1aumwXzhm
 7zdvcPP35t4F4y2KndmRHoOuF4eAROg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-H0hSWUS5Ph6MmH3Z-xuZ2A-1; Tue, 27 Oct 2020 09:56:45 -0400
X-MC-Unique: H0hSWUS5Ph6MmH3Z-xuZ2A-1
Received: by mail-ed1-f70.google.com with SMTP id a15so706013eda.15
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2020 06:56:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YRHflBytAvKOEPighLIKwiOsYqMDgywNA3AUBcmPj5o=;
 b=jeAXZnUl4mLXVN07EMeYyctXsE7hO6TIdy72SS4JwxQPHFF/LGG3QfCUMYJ0bE8SP6
 kNDB+NOpqGGMHYEkCAmpDGHSVZ0wTBhSBW4mEzGPbkWhnGy101Hp+NEKFe9rIcIXi3r8
 O546dOTTlQ3sj8orJQVLTlpmb5ltciU3nXrSPKbvCSZHwAWxokkwPumJtMo6tj2gJcWZ
 XMV1lJ/16RS533dBoZGh849NLp7ike2Lq7erfWesau9vggfKhk8+bw4b3Makm7xgFbQ2
 HHyOmYahZpN3jyMHN2Tg1oH61p2rhza1omQgKLHQ5/7emmhBlTAZ76SO5rcGTgbzTccQ
 9JwQ==
X-Gm-Message-State: AOAM5301lqzY+GTbpLwmX41k8ee37T/fhI2aOtQte+sEYzbZWj0Ov9HO
 dWXKE/n4ZB+J+Kz3/MePVrG1UDutnJjnYyeQ1Dyy5wPX922v3/+qPtNt1kRvHtJ7NX/gq4yT4/K
 XNwiop+TzFc9pqU0=
X-Received: by 2002:a50:9f03:: with SMTP id b3mr2284398edf.268.1603807004100; 
 Tue, 27 Oct 2020 06:56:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxLKiojXcmb2GVg4IwMH6G/vgitauYTwsK2dW7aRAEXasjzgL7BxPDzcyHc7vnnOIFVcv3ylQ==
X-Received: by 2002:a50:9f03:: with SMTP id b3mr2284374edf.268.1603807003858; 
 Tue, 27 Oct 2020 06:56:43 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id 11sm1082584ejy.19.2020.10.27.06.56.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2020 06:56:43 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/25] block/nvme: Use unsigned integer for queue counter/size
Date: Tue, 27 Oct 2020 14:55:32 +0100
Message-Id: <20201027135547.374946-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201027135547.374946-1-philmd@redhat.com>
References: <20201027135547.374946-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/27 01:06:06
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 Max Reitz <mreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can not have negative queue count/size/index, use unsigned type.
Rename 'nr_queues' as 'queue_count' to match the spec naming.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 38 ++++++++++++++++++--------------------
 block/trace-events | 10 +++++-----
 2 files changed, 23 insertions(+), 25 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 30075e230ca..8b0fd59c6ea 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -104,7 +104,7 @@ struct BDRVNVMeState {
      * [1..]: io queues.
      */
     NVMeQueuePair **queues;
-    int nr_queues;
+    unsigned queue_count;
     size_t page_size;
     /* How many uint32_t elements does each doorbell entry take. */
     size_t doorbell_scale;
@@ -161,7 +161,7 @@ static QemuOptsList runtime_opts = {
 };
 
 static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
-                            int nentries, int entry_bytes, Error **errp)
+                            unsigned nentries, size_t entry_bytes, Error **errp)
 {
     size_t bytes;
     int r;
@@ -206,7 +206,7 @@ static void nvme_free_req_queue_cb(void *opaque)
 
 static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
                                              AioContext *aio_context,
-                                             int idx, int size,
+                                             unsigned idx, size_t size,
                                              Error **errp)
 {
     int i, r;
@@ -623,7 +623,7 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
     bool progress = false;
     int i;
 
-    for (i = 0; i < s->nr_queues; i++) {
+    for (i = 0; i < s->queue_count; i++) {
         if (nvme_poll_queue(s->queues[i])) {
             progress = true;
         }
@@ -644,10 +644,10 @@ static void nvme_handle_event(EventNotifier *n)
 static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
-    int n = s->nr_queues;
+    unsigned n = s->queue_count;
     NVMeQueuePair *q;
     NvmeCmd cmd;
-    int queue_size = NVME_QUEUE_SIZE;
+    unsigned queue_size = NVME_QUEUE_SIZE;
 
     q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
                                n, queue_size, errp);
@@ -661,7 +661,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create CQ io queue [%d]", n);
+        error_setg(errp, "Failed to create CQ io queue [%u]", n);
         goto out_error;
     }
     cmd = (NvmeCmd) {
@@ -671,12 +671,12 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create SQ io queue [%d]", n);
+        error_setg(errp, "Failed to create SQ io queue [%u]", n);
         goto out_error;
     }
     s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
     s->queues[n] = q;
-    s->nr_queues++;
+    s->queue_count++;
     return true;
 out_error:
     nvme_free_queue_pair(q);
@@ -785,7 +785,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         ret = -EINVAL;
         goto out;
     }
-    s->nr_queues = 1;
+    s->queue_count = 1;
     QEMU_BUILD_BUG_ON(NVME_QUEUE_SIZE & 0xF000);
     regs->aqa = cpu_to_le32((NVME_QUEUE_SIZE << AQA_ACQS_SHIFT) |
                             (NVME_QUEUE_SIZE << AQA_ASQS_SHIFT));
@@ -895,10 +895,9 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
 
 static void nvme_close(BlockDriverState *bs)
 {
-    int i;
     BDRVNVMeState *s = bs->opaque;
 
-    for (i = 0; i < s->nr_queues; ++i) {
+    for (unsigned i = 0; i < s->queue_count; ++i) {
         nvme_free_queue_pair(s->queues[i]);
     }
     g_free(s->queues);
@@ -1123,7 +1122,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
     };
 
     trace_nvme_prw_aligned(s, is_write, offset, bytes, flags, qiov->niov);
-    assert(s->nr_queues > 1);
+    assert(s->queue_count > 1);
     req = nvme_get_free_req(ioq);
     assert(req);
 
@@ -1233,7 +1232,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .ret = -EINPROGRESS,
     };
 
-    assert(s->nr_queues > 1);
+    assert(s->queue_count > 1);
     req = nvme_get_free_req(ioq);
     assert(req);
     nvme_submit_command(ioq, req, &cmd, nvme_rw_cb, &data);
@@ -1285,7 +1284,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     cmd.cdw12 = cpu_to_le32(cdw12);
 
     trace_nvme_write_zeroes(s, offset, bytes, flags);
-    assert(s->nr_queues > 1);
+    assert(s->queue_count > 1);
     req = nvme_get_free_req(ioq);
     assert(req);
 
@@ -1328,7 +1327,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
         return -ENOTSUP;
     }
 
-    assert(s->nr_queues > 1);
+    assert(s->queue_count > 1);
 
     buf = qemu_try_memalign(s->page_size, s->page_size);
     if (!buf) {
@@ -1408,7 +1407,7 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
 
-    for (int i = 0; i < s->nr_queues; i++) {
+    for (unsigned i = 0; i < s->queue_count; i++) {
         NVMeQueuePair *q = s->queues[i];
 
         qemu_bh_delete(q->completion_bh);
@@ -1429,7 +1428,7 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
     aio_set_event_notifier(new_context, &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, nvme_handle_event, nvme_poll_cb);
 
-    for (int i = 0; i < s->nr_queues; i++) {
+    for (unsigned i = 0; i < s->queue_count; i++) {
         NVMeQueuePair *q = s->queues[i];
 
         q->completion_bh =
@@ -1446,11 +1445,10 @@ static void nvme_aio_plug(BlockDriverState *bs)
 
 static void nvme_aio_unplug(BlockDriverState *bs)
 {
-    int i;
     BDRVNVMeState *s = bs->opaque;
     assert(s->plugged);
     s->plugged = false;
-    for (i = INDEX_IO(0); i < s->nr_queues; i++) {
+    for (unsigned i = INDEX_IO(0); i < s->queue_count; i++) {
         NVMeQueuePair *q = s->queues[i];
         qemu_mutex_lock(&q->lock);
         nvme_kick(q);
diff --git a/block/trace-events b/block/trace-events
index f6a0f99df1a..8368f4acb0b 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -136,13 +136,13 @@ qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s
 # nvme.c
 nvme_controller_capability_raw(uint64_t value) "0x%08"PRIx64
 nvme_controller_capability(const char *desc, uint64_t value) "%s: %"PRIu64
-nvme_kick(void *s, int queue) "s %p queue %d"
+nvme_kick(void *s, unsigned q_index) "s %p q #%u"
 nvme_dma_flush_queue_wait(void *s) "s %p"
 nvme_error(int cmd_specific, int sq_head, int sqid, int cid, int status) "cmd_specific %d sq_head %d sqid %d cid %d status 0x%x"
-nvme_process_completion(void *s, int index, int inflight) "s %p queue %d inflight %d"
-nvme_process_completion_queue_plugged(void *s, int index) "s %p queue %d"
-nvme_complete_command(void *s, int index, int cid) "s %p queue %d cid %d"
-nvme_submit_command(void *s, int index, int cid) "s %p queue %d cid %d"
+nvme_process_completion(void *s, unsigned q_index, int inflight) "s %p q #%u inflight %d"
+nvme_process_completion_queue_plugged(void *s, unsigned q_index) "s %p q #%u"
+nvme_complete_command(void *s, unsigned q_index, int cid) "s %p q #%u cid %d"
+nvme_submit_command(void *s, unsigned q_index, int cid) "s %p q #%u cid %d"
 nvme_submit_command_raw(int c0, int c1, int c2, int c3, int c4, int c5, int c6, int c7) "%02x %02x %02x %02x %02x %02x %02x %02x"
 nvme_handle_event(void *s) "s %p"
 nvme_poll_queue(void *s, unsigned q_index) "s %p q #%u"
-- 
2.26.2


