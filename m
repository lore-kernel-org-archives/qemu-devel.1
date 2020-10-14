Return-Path: <SRS0=kfsL=DV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 144FFC43467
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:11:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A121221EB
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2020 16:10:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZqfoyhpI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A121221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kSjMf-0000Cj-VN
	for qemu-devel@archiver.kernel.org; Wed, 14 Oct 2020 12:10:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58150)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAl-0004M4-5Y
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:40001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kSjAg-0000sn-TY
 for qemu-devel@nongnu.org; Wed, 14 Oct 2020 11:58:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602691111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6X8GnBykdmK/5a5uNwFE6Cz8VpoGtSMgA4K7YGZ7Ns=;
 b=ZqfoyhpIX0BiTIEGgGvSeAE0yXirpF7ejnvT+SHJqKvBzOop9CP8SfkT9ZmOdThDOroj/I
 +P4BpuBdxUkvkfXcCw3CiVf3oKVEQyJBxLnRuU5wQsIPyLHmryYOd5o+FIjYBnTLSfN+0h
 vIyrJHUzgm9i3M5dmMOuk8EPaC7ieLo=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-AFBBDsVuNKGCvqdn4CYl1w-1; Wed, 14 Oct 2020 11:58:29 -0400
X-MC-Unique: AFBBDsVuNKGCvqdn4CYl1w-1
Received: by mail-wr1-f71.google.com with SMTP id b11so1557974wrm.3
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2020 08:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=i6X8GnBykdmK/5a5uNwFE6Cz8VpoGtSMgA4K7YGZ7Ns=;
 b=DAaYKwpquohGLx1du79yvSrsV8rHpnmUnlwQYcUzG0A/37Gq5FRiS9MSvTtgzldT/D
 2VVd4yMiqA+G6cW3h3KY6v/RcuuQ9042oxtQd0Hy+RL8xPR5mGM1wRVa37Uljc0RIGEa
 oQTTUamxws6qjn0l3eQXqP3yZvjDJ5MK+v4FVrrrAL5QL9eIgPOzHpK3VGk83Sn3ah2M
 KQ3uw+U8GDgqp2pg+X2rOymLL1/79cA9f+oCDkQ+ShiAzibIDhChemOMPJ9SamVg1sfm
 xDc7m9t0scNUgjhqNJtPiCdISZC/jFDlXdOKVAG3ry3e1W8or8LBxNPbLQLmpGqI6aez
 tCTw==
X-Gm-Message-State: AOAM531W5ZdZOS6tzTdUtaaGbUwgCLTMQo/5M4H8WMp8VCObdqKs7l/Y
 vk86kLXodUpDMF9C1arwpAZvXBaRJXe2DKYb48BD5chFZzfUX4AqW1I2NeTPVfzNDr3//1FC56l
 t0I2hc8VhshVm278=
X-Received: by 2002:adf:e292:: with SMTP id v18mr6286713wri.256.1602691108004; 
 Wed, 14 Oct 2020 08:58:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxzBpitalcaSg+IeiqueUqGPcfpwo/IferQGLaPsK2pcjC6erHlT5XVa8mtinwklnxwNcC84w==
X-Received: by 2002:adf:e292:: with SMTP id v18mr6286692wri.256.1602691107758; 
 Wed, 14 Oct 2020 08:58:27 -0700 (PDT)
Received: from x1w.redhat.com (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id f14sm94960wme.22.2020.10.14.08.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2020 08:58:27 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/15] block/nvme: Use unsigned integer for queue counter/size
Date: Wed, 14 Oct 2020 17:57:58 +0200
Message-Id: <20201014155810.102841-4-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201014155810.102841-1-philmd@redhat.com>
References: <20201014155810.102841-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/14 03:37:33
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We can not have negative queue count/size/index, use unsigned type.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c       | 24 +++++++++++-------------
 block/trace-events | 10 +++++-----
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 7c253eafa7f..d84206b598d 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -103,7 +103,7 @@ struct BDRVNVMeState {
      * [1..]: io queues.
      */
     NVMeQueuePair **queues;
-    int nr_queues;
+    unsigned nr_queues;
     size_t page_size;
     /* How many uint32_t elements does each doorbell entry take. */
     size_t doorbell_scale;
@@ -154,7 +154,7 @@ static QemuOptsList runtime_opts = {
 };
 
 static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
-                            int nentries, int entry_bytes, Error **errp)
+                            unsigned nentries, size_t entry_bytes, Error **errp)
 {
     size_t bytes;
     int r;
@@ -198,7 +198,7 @@ static void nvme_free_req_queue_cb(void *opaque)
 
 static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
                                              AioContext *aio_context,
-                                             int idx, int size,
+                                             unsigned idx, size_t size,
                                              Error **errp)
 {
     int i, r;
@@ -640,10 +640,10 @@ static bool nvme_poll_cb(void *opaque)
 static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
-    int n = s->nr_queues;
+    unsigned n = s->nr_queues;
     NVMeQueuePair *q;
     NvmeCmd cmd;
-    int queue_size = NVME_QUEUE_SIZE;
+    unsigned queue_size = NVME_QUEUE_SIZE;
 
     q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
                                n, queue_size, errp);
@@ -657,7 +657,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x3),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create CQ io queue [%d]", n);
+        error_setg(errp, "Failed to create CQ io queue [%u]", n);
         goto out_error;
     }
     cmd = (NvmeCmd) {
@@ -667,7 +667,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
         .cdw11 = cpu_to_le32(0x1 | (n << 16)),
     };
     if (nvme_cmd_sync(bs, s->queues[INDEX_ADMIN], &cmd)) {
-        error_setg(errp, "Failed to create SQ io queue [%d]", n);
+        error_setg(errp, "Failed to create SQ io queue [%u]", n);
         goto out_error;
     }
     s->queues = g_renew(NVMeQueuePair *, s->queues, n + 1);
@@ -869,10 +869,9 @@ static int nvme_enable_disable_write_cache(BlockDriverState *bs, bool enable,
 
 static void nvme_close(BlockDriverState *bs)
 {
-    int i;
     BDRVNVMeState *s = bs->opaque;
 
-    for (i = 0; i < s->nr_queues; ++i) {
+    for (unsigned i = 0; i < s->nr_queues; ++i) {
         nvme_free_queue_pair(s->queues[i]);
     }
     g_free(s->queues);
@@ -1380,7 +1379,7 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
 {
     BDRVNVMeState *s = bs->opaque;
 
-    for (int i = 0; i < s->nr_queues; i++) {
+    for (unsigned i = 0; i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
 
         qemu_bh_delete(q->completion_bh);
@@ -1401,7 +1400,7 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
     aio_set_event_notifier(new_context, &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, nvme_handle_event, nvme_poll_cb);
 
-    for (int i = 0; i < s->nr_queues; i++) {
+    for (unsigned i = 0; i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
 
         q->completion_bh =
@@ -1418,11 +1417,10 @@ static void nvme_aio_plug(BlockDriverState *bs)
 
 static void nvme_aio_unplug(BlockDriverState *bs)
 {
-    int i;
     BDRVNVMeState *s = bs->opaque;
     assert(s->plugged);
     s->plugged = false;
-    for (i = INDEX_IO(0); i < s->nr_queues; i++) {
+    for (unsigned i = INDEX_IO(0); i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
         qemu_mutex_lock(&q->lock);
         nvme_kick(q);
diff --git a/block/trace-events b/block/trace-events
index fa50af6b6f3..3bb5a238601 100644
--- a/block/trace-events
+++ b/block/trace-events
@@ -134,13 +134,13 @@ qed_aio_write_postfill(void *s, void *acb, uint64_t start, size_t len, uint64_t
 qed_aio_write_main(void *s, void *acb, int ret, uint64_t offset, size_t len) "s %p acb %p ret %d offset %"PRIu64" len %zu"
 
 # nvme.c
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


