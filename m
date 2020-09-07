Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B59ABC433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:17:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7A02166E
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 11:17:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVcB9Uom"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7A02166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFF91-0006N9-5x
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 07:17:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59028)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2P-0002cd-7k
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:59138
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1kFF2H-0007ve-2U
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 07:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599477008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XqeQAtrwuLeSFVRWmN1UxBAMnY/zUvyI12xGACYFF0w=;
 b=TVcB9UomVL3kKTBLL76arTX1gptu3UqQKlpEAUqJPqov0jemB+DeastuLqJGpGQSemgsWt
 f1T6F2BTaun5nt+IJcLpW7jMeEVOmXWcyqyEI7ywGXW9u7ZMTPL4jg4OiaY/x652tPRjTw
 GkEaq7YRCn6bTUPz+58XMmv4bLI0xjc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-Tnlc1GYrNjGceGYHgh4KWQ-1; Mon, 07 Sep 2020 07:10:06 -0400
X-MC-Unique: Tnlc1GYrNjGceGYHgh4KWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B54F1007466;
 Mon,  7 Sep 2020 11:10:05 +0000 (UTC)
Received: from linux.fritz.box.com (ovpn-114-154.ams2.redhat.com
 [10.36.114.154])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 557439CBA;
 Mon,  7 Sep 2020 11:10:01 +0000 (UTC)
From: Kevin Wolf <kwolf@redhat.com>
To: qemu-block@nongnu.org
Subject: [PULL 16/64] block/nvme: Use an array of EventNotifier
Date: Mon,  7 Sep 2020 13:08:48 +0200
Message-Id: <20200907110936.261684-17-kwolf@redhat.com>
In-Reply-To: <20200907110936.261684-1-kwolf@redhat.com>
References: <20200907110936.261684-1-kwolf@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kwolf@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kwolf@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:19:10
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

In preparation of using multiple IRQ (thus multiple eventfds)
make BDRVNVMeState::irq_notifier an array (for now of a single
element, the admin queue notifier).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20200821195359.1285345-16-philmd@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/nvme.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e3719d3bd1..24e6e7f086 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -106,6 +106,12 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
 #define INDEX_ADMIN     0
 #define INDEX_IO(n)     (1 + n)
 
+/* This driver shares a single MSIX IRQ for the admin and I/O queues */
+enum {
+    MSIX_SHARED_IRQ_IDX = 0,
+    MSIX_IRQ_COUNT = 1
+};
+
 struct BDRVNVMeState {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
@@ -120,7 +126,7 @@ struct BDRVNVMeState {
     /* How many uint32_t elements does each doorbell entry take. */
     size_t doorbell_scale;
     bool write_cache_supported;
-    EventNotifier irq_notifier;
+    EventNotifier irq_notifier[MSIX_IRQ_COUNT];
 
     uint64_t nsze; /* Namespace size reported by identify command */
     int nsid;      /* The namespace id to read/write data. */
@@ -631,7 +637,8 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
 
 static void nvme_handle_event(EventNotifier *n)
 {
-    BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
+    BDRVNVMeState *s = container_of(n, BDRVNVMeState,
+                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
 
     trace_nvme_handle_event(s);
     event_notifier_test_and_clear(n);
@@ -683,7 +690,8 @@ out_error:
 static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
-    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
+    BDRVNVMeState *s = container_of(e, BDRVNVMeState,
+                                    irq_notifier[MSIX_SHARED_IRQ_IDX]);
 
     trace_nvme_poll_cb(s);
     return nvme_poll_queues(s);
@@ -705,7 +713,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->device = g_strdup(device);
     s->nsid = namespace;
     s->aio_context = bdrv_get_aio_context(bs);
-    ret = event_notifier_init(&s->irq_notifier, 0);
+    ret = event_notifier_init(&s->irq_notifier[MSIX_SHARED_IRQ_IDX], 0);
     if (ret) {
         error_setg(errp, "Failed to init event notifier");
         return ret;
@@ -784,12 +792,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
-    ret = qemu_vfio_pci_init_irq(s->vfio, &s->irq_notifier,
+    ret = qemu_vfio_pci_init_irq(s->vfio, s->irq_notifier,
                                  VFIO_PCI_MSIX_IRQ_INDEX, errp);
     if (ret) {
         goto out;
     }
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+    aio_set_event_notifier(bdrv_get_aio_context(bs),
+                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, nvme_handle_event, nvme_poll_cb);
 
     nvme_identify(bs, namespace, &local_err);
@@ -872,9 +881,10 @@ static void nvme_close(BlockDriverState *bs)
         nvme_free_queue_pair(s->queues[i]);
     }
     g_free(s->queues);
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+    aio_set_event_notifier(bdrv_get_aio_context(bs),
+                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, NULL, NULL);
-    event_notifier_cleanup(&s->irq_notifier);
+    event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
     qemu_vfio_close(s->vfio);
 
@@ -1381,7 +1391,8 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
         q->completion_bh = NULL;
     }
 
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+    aio_set_event_notifier(bdrv_get_aio_context(bs),
+                           &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, NULL, NULL);
 }
 
@@ -1391,7 +1402,7 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
     BDRVNVMeState *s = bs->opaque;
 
     s->aio_context = new_context;
-    aio_set_event_notifier(new_context, &s->irq_notifier,
+    aio_set_event_notifier(new_context, &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, nvme_handle_event, nvme_poll_cb);
 
     for (int i = 0; i < s->nr_queues; i++) {
-- 
2.25.4


