Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B2F4C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:21:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248CE206C0
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 19:21:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Og6/WfJU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 248CE206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42768 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqLpC-0001O0-DW
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 15:21:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42522)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLi5-0007FO-UO
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34823
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1jqLi3-0005bh-C4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 15:14:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593544462;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zAFtHKEAEKWoAOfXmSXZPp5z9h7DCo+BkNURFMtuFac=;
 b=Og6/WfJUzBQFQrirxH6c16Wx/1IC8WIWHs6oeXxSsQtyIGhEOeQho7ktOjr5ZoxrUJ3SPn
 S/Qpcvy+579YwYUcYcCbhyH3PW3y5D+ZPMlYvWxPHMdwbDcltwxso1DeOnCIsln8CjcwAc
 y5wrZNRxXKZjoD2UWCd9hjhqAMJZeQI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-54-R1nmEce5NDSjSZL7075G_A-1; Tue, 30 Jun 2020 15:14:20 -0400
X-MC-Unique: R1nmEce5NDSjSZL7075G_A-1
Received: by mail-wm1-f70.google.com with SMTP id v6so19114730wmg.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 12:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=zAFtHKEAEKWoAOfXmSXZPp5z9h7DCo+BkNURFMtuFac=;
 b=sdkx4mSrc0sqmIG0+qt3T8aTrgX77QxkSgSQdy0gimNlCemvGJKEC9zOuZLMSqS5zY
 raYgzbIkCbROYRcs0HRyLB4xHHQBzSxhBTfvIbcZgyLvW4+fFH5cCDuxo8uJnwDQe+MQ
 aW0bcXre2iJBZKBOKm+3h49XS5rOxnL6h6LHQllhHdnkmQEKAaVfDbCz4fd2wAUEd4A7
 m47bgt4JJ4yfwRIJFmdJHG3lU2XDa0Os2iR5VjysjFsHq1tfOrXchvyP13bXgSFJQoxT
 D+QMs8ayBGVDmtJL/6r+o1L/NZSKHn+aYHSpkDclUWjcNisAJ880DodLTaRFrObcve/w
 qsrw==
X-Gm-Message-State: AOAM530mF6cPVQH2U0BRlbw+FEDHmhkwqCzmMdJhMWErPKil24BJZjBg
 rkpVAwOJVMdMt8afP28GyJJUTBiNMmz6QYYDDQFMp8mPNR2Jrb6tPg0Ej3Bx8hMirAdbhWNyVei
 UhX7K/U4s2VtVM04=
X-Received: by 2002:a7b:c099:: with SMTP id r25mr24195355wmh.159.1593544459154; 
 Tue, 30 Jun 2020 12:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzS+GVZcXdBdr03+WUdIODlRoiYh+OrDBOfQ3oZdX5CH4N1AC5cjse7JHuOB0xcP1Uld5yNLA==
X-Received: by 2002:a7b:c099:: with SMTP id r25mr24195270wmh.159.1593544457866; 
 Tue, 30 Jun 2020 12:14:17 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id v20sm4225841wmh.26.2020.06.30.12.14.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jun 2020 12:14:17 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH v2 12/12] block/nvme: Use per-queue AIO context
Date: Tue, 30 Jun 2020 21:13:18 +0200
Message-Id: <20200630191318.30021-13-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200630191318.30021-1-philmd@redhat.com>
References: <20200630191318.30021-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 03:55:26
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Maxim Levitsky <mlevitsk@redhat.com>,
 Max Reitz <mreitz@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to use multiple queues on the same hardware,
we need to have each queue able to receive IRQ notifications
in the correct AIO context.
The AIO context and the notification handler have to be proper
to each queue, not to the block driver. Move aio_context and
irq_notifier from BDRVNVMeState to NVMeQueuePair.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
Since v1: Moved irq_notifier to NVMeQueuePair
---
 block/nvme.c | 71 +++++++++++++++++++++++++++-------------------------
 1 file changed, 37 insertions(+), 34 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 90b2e00e8d..e7b9ecec41 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -60,6 +60,8 @@ typedef struct {
 
 typedef struct {
     QemuMutex   lock;
+    AioContext *aio_context;
+    EventNotifier irq_notifier;
 
     /* Read from I/O code path, initialized under BQL */
     BDRVNVMeState   *s;
@@ -107,7 +109,6 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
 #define QUEUE_INDEX_IO(n)   (1 + n)
 
 struct BDRVNVMeState {
-    AioContext *aio_context;
     QEMUVFIOState *vfio;
     NVMeRegs *regs;
     /* The submission/completion queue pairs.
@@ -120,7 +121,6 @@ struct BDRVNVMeState {
     /* How many uint32_t elements does each doorbell entry take. */
     size_t doorbell_scale;
     bool write_cache_supported;
-    EventNotifier irq_notifier;
 
     uint64_t nsze; /* Namespace size reported by identify command */
     int nsid;      /* The namespace id to read/write data. */
@@ -227,11 +227,17 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     if (!q->prp_list_pages) {
         goto fail;
     }
+    r = event_notifier_init(&q->irq_notifier, 0);
+    if (r) {
+        error_setg(errp, "Failed to init event notifier");
+        goto fail;
+    }
     memset(q->prp_list_pages, 0, s->page_size * NVME_QUEUE_SIZE);
     qemu_mutex_init(&q->lock);
     q->s = s;
     q->index = idx;
     qemu_co_queue_init(&q->free_req_queue);
+    q->aio_context = aio_context;
     q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
     r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
                           s->page_size * NVME_NUM_REQS,
@@ -325,7 +331,7 @@ static void nvme_put_free_req_locked(NVMeQueuePair *q, NVMeRequest *req)
 static void nvme_wake_free_req_locked(NVMeQueuePair *q)
 {
     if (!qemu_co_queue_empty(&q->free_req_queue)) {
-        replay_bh_schedule_oneshot_event(q->s->aio_context,
+        replay_bh_schedule_oneshot_event(q->aio_context,
                 nvme_free_req_queue_cb, q);
     }
 }
@@ -492,7 +498,6 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
 static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
                          NvmeCmd *cmd)
 {
-    AioContext *aio_context = bdrv_get_aio_context(bs);
     NVMeRequest *req;
     int ret = -EINPROGRESS;
     req = nvme_get_free_req(q);
@@ -501,7 +506,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     }
     nvme_submit_command(q, req, cmd, nvme_cmd_sync_cb, &ret);
 
-    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
+    AIO_WAIT_WHILE(q->aio_context, ret == -EINPROGRESS);
     return ret;
 }
 
@@ -621,14 +626,16 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
 
 static void nvme_handle_event(EventNotifier *n)
 {
-    BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
+    NVMeQueuePair *q = container_of(n, NVMeQueuePair, irq_notifier);
+    BDRVNVMeState *s = q->s;
 
     trace_nvme_handle_event(s);
     event_notifier_test_and_clear(n);
     nvme_poll_queues(s);
 }
 
-static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
+static bool nvme_add_io_queue(BlockDriverState *bs,
+                              AioContext *aio_context, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
     int n = s->nr_queues;
@@ -636,8 +643,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     int queue_size = NVME_QUEUE_SIZE;
 
-    q = nvme_create_queue_pair(s, bdrv_get_aio_context(bs),
-                               n, queue_size, errp);
+    q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
     if (!q) {
         return false;
     }
@@ -672,7 +678,8 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
 static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
-    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
+    NVMeQueuePair *q = container_of(e, NVMeQueuePair, irq_notifier);
+    BDRVNVMeState *s = q->s;
 
     trace_nvme_poll_cb(s);
     return nvme_poll_queues(s);
@@ -693,12 +700,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     qemu_co_queue_init(&s->dma_flush_queue);
     s->device = g_strdup(device);
     s->nsid = namespace;
-    s->aio_context = bdrv_get_aio_context(bs);
-    ret = event_notifier_init(&s->irq_notifier, 0);
-    if (ret) {
-        error_setg(errp, "Failed to init event notifier");
-        return ret;
-    }
 
     s->vfio = qemu_vfio_open_pci(device, errp);
     if (!s->vfio) {
@@ -773,12 +774,14 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
+    ret = qemu_vfio_pci_init_irq(s->vfio,
+                                 &s->queues[QUEUE_INDEX_ADMIN]->irq_notifier,
                                  VFIO_PCI_MSIX_IRQ_INDEX, errp);
     if (ret) {
         goto out;
     }
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+    aio_set_event_notifier(aio_context,
+                           &s->queues[QUEUE_INDEX_ADMIN]->irq_notifier,
                            false, nvme_handle_event, nvme_poll_cb);
 
     nvme_identify(bs, namespace, &local_err);
@@ -789,7 +792,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
 
     /* Set up command queues. */
-    if (!nvme_add_io_queue(bs, errp)) {
+    if (!nvme_add_io_queue(bs, aio_context, errp)) {
         ret = -EIO;
     }
 out:
@@ -858,12 +861,14 @@ static void nvme_close(BlockDriverState *bs)
     BDRVNVMeState *s = bs->opaque;
 
     for (i = 0; i < s->nr_queues; ++i) {
-        nvme_free_queue_pair(s->queues[i]);
+        NVMeQueuePair *q = s->queues[i];
+
+        aio_set_event_notifier(q->aio_context,
+                               &q->irq_notifier, false, NULL, NULL);
+        event_notifier_cleanup(&q->irq_notifier);
+        nvme_free_queue_pair(q);
     }
     g_free(s->queues);
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
-                           false, NULL, NULL);
-    event_notifier_cleanup(&s->irq_notifier);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
     qemu_vfio_close(s->vfio);
 
@@ -1075,7 +1080,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1184,7 +1189,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .nsid = cpu_to_le32(s->nsid),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1225,7 +1230,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1275,7 +1280,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1368,10 +1373,10 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
 
         qemu_bh_delete(q->completion_bh);
         q->completion_bh = NULL;
-    }
 
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
-                           false, NULL, NULL);
+        aio_set_event_notifier(bdrv_get_aio_context(bs), &q->irq_notifier,
+                               false, NULL, NULL);
+    }
 }
 
 static void nvme_attach_aio_context(BlockDriverState *bs,
@@ -1379,13 +1384,11 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
 {
     BDRVNVMeState *s = bs->opaque;
 
-    s->aio_context = new_context;
-    aio_set_event_notifier(new_context, &s->irq_notifier,
-                           false, nvme_handle_event, nvme_poll_cb);
-
     for (int i = 0; i < s->nr_queues; i++) {
         NVMeQueuePair *q = s->queues[i];
 
+        aio_set_event_notifier(new_context, &q->irq_notifier,
+                               false, nvme_handle_event, nvme_poll_cb);
         q->completion_bh =
             aio_bh_new(new_context, nvme_process_completion_bh, q);
     }
-- 
2.21.3


