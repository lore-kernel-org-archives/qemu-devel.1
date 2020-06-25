Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E6AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7FB4220679
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 19:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CtDJeMgV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7FB4220679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60148 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joX8v-0003xi-Px
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 15:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40552)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwj-00011y-MX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:50:01 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59827
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1joWwh-0001I9-LM
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:50:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593110998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J6KNnPouNo074HwjJp3LZ774db1owVLbnaAdPIC0ay4=;
 b=CtDJeMgVSW8Sej7hPhaxqCW20Aq1cCJ2DJDovjBBbQCi4/uAIVrcLoCXZpyeauemoPDjgL
 qExCCHRgj3q1ce1ntld6o0Wfwtr5+NnTYE5MLds+w9aZNltNkz5geHflWUvI6B3EgbABst
 MGic8Crc0e3QfIIJdj9C2WRsGrFjAk4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-482-bTJjE_jrOf-9zmri1r_1XQ-1; Thu, 25 Jun 2020 14:49:52 -0400
X-MC-Unique: bTJjE_jrOf-9zmri1r_1XQ-1
Received: by mail-wr1-f69.google.com with SMTP id y16so7685440wrr.20
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:49:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=J6KNnPouNo074HwjJp3LZ774db1owVLbnaAdPIC0ay4=;
 b=IvdQ66F3xfERsLjXW22J1z7cnyOgSMqlznXStnoA6DW8oLFE36bjw+inXm7IdtLX3p
 fUUq5P8axeQB1jyA/RE9TcFMMB4rgMir09R01424Tnp/aylXSd5r4dVcJkSZ1M75Pj+P
 BQJ7dN/Jv3kabJwntxvdGny5/ZmD2EJO2RByC9zGxIm4/+FE3oCskY8ltem87iKXzBeD
 8M08liLqBHvvyweBCLEwSqmwOZMNIxyX3xBaWMTYOcPawBtYbZhrC5iFdRMxvaxB6e/u
 NCQ064vbg0vrp8CmKQFeCGUFC4XEzGDLrZXbnBQTGi6mTTA/taKPpj7llPq5yZlKabHs
 Jb/A==
X-Gm-Message-State: AOAM531i1FFjRhLCVaNgvr6dPLv01BoctP63myYEA/7DfanKDW+m3HBh
 m+lIKA5jgu++h9EcyupXTIkmMq2eaZECJ67DtEdq1UVHPiOZ6/wb0anJvvCHXjXcarZL9TNP1MZ
 SOgASsoXn7WDC9Yw=
X-Received: by 2002:a05:600c:2045:: with SMTP id
 p5mr5352532wmg.91.1593110991002; 
 Thu, 25 Jun 2020 11:49:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/2Wk8W3TCFa0pSd5Pg0O29Xw/XHbyw8/JZaS9NHCmqmadJh7UszD8vJp+rwy4knFS8xOAqQ==
X-Received: by 2002:a05:600c:2045:: with SMTP id
 p5mr5352516wmg.91.1593110990770; 
 Thu, 25 Jun 2020 11:49:50 -0700 (PDT)
Received: from localhost.localdomain (1.red-83-51-162.dynamicip.rima-tde.net.
 [83.51.162.1])
 by smtp.gmail.com with ESMTPSA id c2sm33371926wrv.47.2020.06.25.11.49.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2020 11:49:50 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [RFC PATCH 15/17] block/nvme: Use per-queue AIO context
Date: Thu, 25 Jun 2020 20:48:36 +0200
Message-Id: <20200625184838.28172-16-philmd@redhat.com>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200625184838.28172-1-philmd@redhat.com>
References: <20200625184838.28172-1-philmd@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/25 00:45:15
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To be able to use multiple queues on the same hardware,
we need to have each queue able to receive IRQ notifications
in the correct AIO context.
The context has to be proper to each queue, not to the block
driver. Move aio_context from BDRVNVMeState to NVMeQueuePair.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
RFC because I'm not familiar with AIO context

 block/nvme.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index ac933cafd0..0f7cc568ef 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -51,6 +51,7 @@ typedef struct {
 } NVMeRequest;
 
 typedef struct {
+    AioContext *aio_context;
     CoQueue     free_req_queue;
     QemuMutex   lock;
 
@@ -93,7 +94,6 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
 #define QUEUE_INDEX_IO(n)   (1 + n)
 
 typedef struct {
-    AioContext *aio_context;
     QEMUVFIOState *vfio;
     NVMeRegs *regs;
     /* The submission/completion queue pairs.
@@ -190,6 +190,7 @@ static void nvme_free_req_queue_cb(void *opaque)
 }
 
 static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
+                                             AioContext *aio_context,
                                              int idx, int size,
                                              Error **errp)
 {
@@ -207,6 +208,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     if (!q->prp_list_pages) {
         goto fail;
     }
+    q->aio_context = aio_context;
     memset(q->prp_list_pages, 0, s->page_size * NVME_QUEUE_SIZE);
     qemu_mutex_init(&q->lock);
     q->index = idx;
@@ -365,7 +367,7 @@ static bool nvme_process_completion(BDRVNVMeState *s, NVMeQueuePair *q)
         smp_mb_release();
         *q->cq.doorbell = cpu_to_le32(q->cq.head);
         if (!qemu_co_queue_empty(&q->free_req_queue)) {
-            replay_bh_schedule_oneshot_event(s->aio_context,
+            replay_bh_schedule_oneshot_event(q->aio_context,
                                              nvme_free_req_queue_cb, q);
         }
     }
@@ -419,7 +421,6 @@ static void nvme_cmd_sync_cb(void *opaque, int ret)
 static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
                          NvmeCmd *cmd)
 {
-    AioContext *aio_context = bdrv_get_aio_context(bs);
     NVMeRequest *req;
     BDRVNVMeState *s = bs->opaque;
     int ret = -EINPROGRESS;
@@ -429,7 +430,7 @@ static int nvme_cmd_sync(BlockDriverState *bs, NVMeQueuePair *q,
     }
     nvme_submit_command(s, q, req, cmd, nvme_cmd_sync_cb, &ret);
 
-    AIO_WAIT_WHILE(aio_context, ret == -EINPROGRESS);
+    AIO_WAIT_WHILE(q->aio_context, ret == -EINPROGRESS);
     return ret;
 }
 
@@ -547,7 +548,8 @@ static void nvme_handle_event(EventNotifier *n)
     nvme_poll_queues(s);
 }
 
-static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
+static bool nvme_add_io_queue(BlockDriverState *bs,
+                              AioContext *aio_context, Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
     int n = s->nr_queues;
@@ -555,7 +557,7 @@ static bool nvme_add_io_queue(BlockDriverState *bs, Error **errp)
     NvmeCmd cmd;
     int queue_size = NVME_QUEUE_SIZE;
 
-    q = nvme_create_queue_pair(s, n, queue_size, errp);
+    q = nvme_create_queue_pair(s, aio_context, n, queue_size, errp);
     if (!q) {
         return false;
     }
@@ -600,6 +602,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
                      Error **errp)
 {
     BDRVNVMeState *s = bs->opaque;
+    AioContext *aio_context = bdrv_get_aio_context(bs);
     int ret;
     uint64_t cap;
     uint64_t timeout_ms;
@@ -610,7 +613,6 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     qemu_co_queue_init(&s->dma_flush_queue);
     s->device = g_strdup(device);
     s->nsid = namespace;
-    s->aio_context = bdrv_get_aio_context(bs);
     ret = event_notifier_init(&s->irq_notifier, 0);
     if (ret) {
         error_setg(errp, "Failed to init event notifier");
@@ -660,7 +662,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
 
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
-    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(s, 0,
+    s->queues[QUEUE_INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
                                                           NVME_QUEUE_SIZE,
                                                           errp);
     if (!s->queues[QUEUE_INDEX_ADMIN]) {
@@ -695,7 +697,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     if (ret) {
         goto out;
     }
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+    aio_set_event_notifier(aio_context, &s->irq_notifier,
                            false, nvme_handle_event, nvme_poll_cb);
 
     nvme_identify(bs, namespace, &local_err);
@@ -706,7 +708,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
 
     /* Set up command queues. */
-    if (!nvme_add_io_queue(bs, errp)) {
+    if (!nvme_add_io_queue(bs, aio_context, errp)) {
         ret = -EIO;
     }
 out:
@@ -775,11 +777,11 @@ static void nvme_close(BlockDriverState *bs)
     BDRVNVMeState *s = bs->opaque;
 
     for (i = 0; i < s->nr_queues; ++i) {
+        aio_set_event_notifier(s->queues[i]->aio_context,
+                               &s->irq_notifier, false, NULL, NULL);
         nvme_free_queue_pair(s->queues[i]);
     }
     g_free(s->queues);
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
-                           false, NULL, NULL);
     event_notifier_cleanup(&s->irq_notifier);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
     qemu_vfio_close(s->vfio);
@@ -992,7 +994,7 @@ static coroutine_fn int nvme_co_prw_aligned(BlockDriverState *bs,
         .cdw12 = cpu_to_le32(cdw12),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1101,7 +1103,7 @@ static coroutine_fn int nvme_co_flush(BlockDriverState *bs)
         .nsid = cpu_to_le32(s->nsid),
     };
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1142,7 +1144,7 @@ static coroutine_fn int nvme_co_pwrite_zeroes(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1192,7 +1194,7 @@ static int coroutine_fn nvme_co_pdiscard(BlockDriverState *bs,
     };
 
     NVMeCoData data = {
-        .ctx = bdrv_get_aio_context(bs),
+        .ctx = ioq->aio_context,
         .ret = -EINPROGRESS,
     };
 
@@ -1289,7 +1291,6 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
 {
     BDRVNVMeState *s = bs->opaque;
 
-    s->aio_context = new_context;
     aio_set_event_notifier(new_context, &s->irq_notifier,
                            false, nvme_handle_event, nvme_poll_cb);
 }
-- 
2.21.3


