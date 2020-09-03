Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8624C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:45:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 823092072A
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 12:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EHuRz5ld"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 823092072A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDocC-0005pA-Jm
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 08:45:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53680)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMm-0001L0-L3
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42349
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kDoMk-0007un-JE
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 08:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599136161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NpnignYWyGxwS894GY8oMk/a6JEblSgZ3kZBOAlqf6A=;
 b=EHuRz5ldh7m30rNP6kcSn7OglEJNee23uWnD1qbqDSwGfoAPCJpwQB9o8oLJyAXJc1+tlM
 0xOgw/2znYP0ZrIGKntH+3yLhQKHk13tP0yGX/grE4vrkyM1Oq5Fx53vWQKcDyYXgOGkt+
 Upgi4BS6XPkdbtYVlJRxbyzEZvuzOpA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-404-vHrFYYKbNAOakWWihsOSQg-1; Thu, 03 Sep 2020 08:29:20 -0400
X-MC-Unique: vHrFYYKbNAOakWWihsOSQg-1
Received: by mail-wr1-f71.google.com with SMTP id g6so1032041wrv.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2020 05:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NpnignYWyGxwS894GY8oMk/a6JEblSgZ3kZBOAlqf6A=;
 b=MuLIGhFiG8i0nPSkwSuBOov+NWYA/tCTAIbzjeBP5bhjJV+T2fZIQaAbEjpZ24IbSH
 p3BYLUxd16K6K83JiWpI6UjCVnmOXCHrF3aRH02TmojZ8HiGo8cnd4I1PDKNtwYYdMr7
 MJ31DQQKzxmSyaLmMYEg6OMydHJ94y0e74eRNXXnHv9ULpBWEpzeb3SIhwd+C62r/l8+
 2XCFfKvo7GxuI/gUfMDhN6UQsBhXrTvRxQauXQe6o4mHIIx5Cy0PQBts0r6xy41Z/jDm
 xTxOcoGk8NcJKBkc8mp2seFJG9x9fTuV4fsEMFaJVw2dypC1BBaxsFqpbg9mbmgguVcy
 ik1Q==
X-Gm-Message-State: AOAM533et1khJu9JWhvqSy9ualbwNl7xWfF0/9lBB0qxlMr+q9UjXRky
 4jjyQwf8IscOYt5VILYois8wbwhDB2jjo1SqogEdAagVan24hCmNqSZvN/d6MN/D3gbiWrTJOu+
 hNVc6e0HlnL5EUZg=
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr2143358wrn.238.1599136159152; 
 Thu, 03 Sep 2020 05:29:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxR9VEDlF2c2hXScIfRFO6BMVLUh++Phr1HzLZP45Ib7PyZQGziMgfXkk+UlgLLkTuTZ0hqUg==
X-Received: by 2002:adf:dfc3:: with SMTP id q3mr2143341wrn.238.1599136158915; 
 Thu, 03 Sep 2020 05:29:18 -0700 (PDT)
Received: from localhost.localdomain (50.red-83-52-54.dynamicip.rima-tde.net.
 [83.52.54.50])
 by smtp.gmail.com with ESMTPSA id f6sm5522520wme.32.2020.09.03.05.29.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 05:29:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 15/15] block/nvme: Use an array of EventNotifier
Date: Thu,  3 Sep 2020 14:28:03 +0200
Message-Id: <20200903122803.405265-16-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200903122803.405265-1-philmd@redhat.com>
References: <20200903122803.405265-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 01:58:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Klaus Jensen <k.jensen@samsung.com>,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Keith Busch <kbusch@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In preparation of using multiple IRQ (thus multiple eventfds)
make BDRVNVMeState::irq_notifier an array (for now of a single
element, the admin queue notifier).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index e3719d3bd14..24e6e7f0866 100644
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
2.26.2


