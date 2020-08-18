Return-Path: <SRS0=kYy5=B4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC611C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:46:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6BF4207D3
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2020 16:46:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eVJjrhZc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6BF4207D3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43732 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k84kt-00013O-RF
	for qemu-devel@archiver.kernel.org; Tue, 18 Aug 2020 12:46:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47418)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jl-0007em-Hv
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:31778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k84jj-0007E7-OR
 for qemu-devel@nongnu.org; Tue, 18 Aug 2020 12:45:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597769122;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e19aBsxvolU8tmqe5AUsSaq8/P+UaGQZEhfVX5QNhjQ=;
 b=eVJjrhZcCab6GDf/H6YExNFcsrJcL876OHnt3PpsIaBgTKB/PSgpBORAQ1rHaHz0nOm55D
 KANJneQdagb3KNjuka/YUeKucqext9pcOWLskNO963N65U1meYa6oYN8D0IwurljsL8h9b
 suLTJW5js9iOH4WtUNpRXYpIHBmquP8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-2Rtw1MeKOkO3CH2nxMUm5g-1; Tue, 18 Aug 2020 12:45:18 -0400
X-MC-Unique: 2Rtw1MeKOkO3CH2nxMUm5g-1
Received: by mail-wm1-f69.google.com with SMTP id v8so6315224wma.6
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2020 09:45:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=e19aBsxvolU8tmqe5AUsSaq8/P+UaGQZEhfVX5QNhjQ=;
 b=L3mxATyPgnaLNNvTgY5mM5Kln7zQv+asrm/5MBwgq7pLenN+2q98PWnpXXlQHR/VHI
 SbPpS+I5pzlqB5OUeoBLyc/naTWoVD8x46W+hR4Fb7vPaGru7yCDR2Vbu9ooCkkVXTvC
 jpidfEXuYqDdCfCWVCF4crA5JU9SMRX1tJBocNfSfLfkZLtsd2YU4HKuQ+GUeH89nZ31
 kGv+MTiykwBufzV+PBY6fjpAl9pHX+i4+3EtYBuXQlHLIPcnQsBlNNQSD5Ba7d2smN2l
 b28IQ6rN1uf2ad2xJCkevEVA9OI4Ds2figWW6wTYjIFBC/bDDxUQaqynxyKarQMbVRq+
 J3nw==
X-Gm-Message-State: AOAM5313FjdZ07wXJmMYYRV43AYI2M7veDPlls7SzIm2j68shMgp7mzB
 pJj6eZL+kyBCvIWvjcjehOqXKpm0FRtgpV/30YdoeiYTALdi41I8Kqcur0V5Cs3zuFPd/6zHYLg
 drq2p26wnryYaY7A=
X-Received: by 2002:adf:edc3:: with SMTP id v3mr124649wro.193.1597769116820;
 Tue, 18 Aug 2020 09:45:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwaYLwM6Dx0C091uvD6Br8Rmlz1Hx12Kd/HBSfZFAB43UyxWpNq5Syf+ZnHgwaZQnl3ao8dwg==
X-Received: by 2002:adf:edc3:: with SMTP id v3mr124622wro.193.1597769116552;
 Tue, 18 Aug 2020 09:45:16 -0700 (PDT)
Received: from localhost.localdomain (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id y142sm731885wmd.3.2020.08.18.09.45.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2020 09:45:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [RFC PATCH v3 1/5] block/nvme: Use an array of EventNotifier
Date: Tue, 18 Aug 2020 18:45:05 +0200
Message-Id: <20200818164509.736367-2-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818164509.736367-1-philmd@redhat.com>
References: <20200818164509.736367-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/18 12:45:22
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In preparation of using multiple IRQ (thus multiple eventfds)
make BDRVNVMeState::irq_notifier an array (for now of a single
element, the admin queue notifier).

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 28 ++++++++++++++++++----------
 1 file changed, 18 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index a61e86a83eb..cdd16d451e7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -106,6 +106,9 @@ QEMU_BUILD_BUG_ON(offsetof(NVMeRegs, doorbells) != 0x1000);
 #define INDEX_ADMIN     0
 #define INDEX_IO(n)     (1 + n)
 
+/* This driver shares a single MSIX IRQ for the admin and I/O queues */
+#define MSIX_IRQ_COUNT  1
+
 struct BDRVNVMeState {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
@@ -120,7 +123,7 @@ struct BDRVNVMeState {
     /* How many uint32_t elements does each doorbell entry take. */
     size_t doorbell_scale;
     bool write_cache_supported;
-    EventNotifier irq_notifier;
+    EventNotifier irq_notifier[MSIX_IRQ_COUNT];
 
     uint64_t nsze; /* Namespace size reported by identify command */
     int nsid;      /* The namespace id to read/write data. */
@@ -631,7 +634,8 @@ static bool nvme_poll_queues(BDRVNVMeState *s)
 
 static void nvme_handle_event(EventNotifier *n)
 {
-    BDRVNVMeState *s = container_of(n, BDRVNVMeState, irq_notifier);
+    BDRVNVMeState *s = container_of(n, BDRVNVMeState,
+                                    irq_notifier[INDEX_ADMIN]);
 
     trace_nvme_handle_event(s);
     event_notifier_test_and_clear(n);
@@ -683,7 +687,8 @@ out_error:
 static bool nvme_poll_cb(void *opaque)
 {
     EventNotifier *e = opaque;
-    BDRVNVMeState *s = container_of(e, BDRVNVMeState, irq_notifier);
+    BDRVNVMeState *s = container_of(e, BDRVNVMeState,
+                                    irq_notifier[INDEX_ADMIN]);
 
     trace_nvme_poll_cb(s);
     return nvme_poll_queues(s);
@@ -705,7 +710,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     s->device = g_strdup(device);
     s->nsid = namespace;
     s->aio_context = bdrv_get_aio_context(bs);
-    ret = event_notifier_init(&s->irq_notifier, 0);
+    ret = event_notifier_init(&s->irq_notifier[INDEX_ADMIN], 0);
     if (ret) {
         error_setg(errp, "Failed to init event notifier");
         return ret;
@@ -784,12 +789,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
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
+                           &s->irq_notifier[INDEX_ADMIN],
                            false, nvme_handle_event, nvme_poll_cb);
 
     nvme_identify(bs, namespace, &local_err);
@@ -872,9 +878,10 @@ static void nvme_close(BlockDriverState *bs)
         nvme_free_queue_pair(s->queues[i]);
     }
     g_free(s->queues);
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+    aio_set_event_notifier(bdrv_get_aio_context(bs),
+                           &s->irq_notifier[INDEX_ADMIN],
                            false, NULL, NULL);
-    event_notifier_cleanup(&s->irq_notifier);
+    event_notifier_cleanup(&s->irq_notifier[INDEX_ADMIN]);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
     qemu_vfio_close(s->vfio);
 
@@ -1381,7 +1388,8 @@ static void nvme_detach_aio_context(BlockDriverState *bs)
         q->completion_bh = NULL;
     }
 
-    aio_set_event_notifier(bdrv_get_aio_context(bs), &s->irq_notifier,
+    aio_set_event_notifier(bdrv_get_aio_context(bs),
+                           &s->irq_notifier[INDEX_ADMIN],
                            false, NULL, NULL);
 }
 
@@ -1391,7 +1399,7 @@ static void nvme_attach_aio_context(BlockDriverState *bs,
     BDRVNVMeState *s = bs->opaque;
 
     s->aio_context = new_context;
-    aio_set_event_notifier(new_context, &s->irq_notifier,
+    aio_set_event_notifier(new_context, &s->irq_notifier[INDEX_ADMIN],
                            false, nvme_handle_event, nvme_poll_cb);
 
     for (int i = 0; i < s->nr_queues; i++) {
-- 
2.26.2


