Return-Path: <SRS0=Dndf=B6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E3CFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:08:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57755208B3
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2020 17:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dtDzWylq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57755208B3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8o3L-0001dE-M3
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 13:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36278)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nvW-0005Sv-2A
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:35 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41088
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1k8nvS-0006T8-R8
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 13:00:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597942830;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v0lvUfHZ5sUY4TlbEB+TMIDYZfmDwZ5AnicnBqS/RQ4=;
 b=dtDzWylqnxegiibbsphi1KDY0oSJ5K63wzqNcThpRTE5C8LxXfDsvXoLZZlyedhD46fvZC
 6wEbH4ixwUbl6ti2LESchfo8D8wsc5BYG61YEEGxYkFjt0SFzEzYA81r6QWUPwwJSzq5u6
 IH/KKNgt1HLzmLChGhtB/VXb8MvaKQc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-481-0OGN-uyyORexCm24Gqkapg-1; Thu, 20 Aug 2020 13:00:25 -0400
X-MC-Unique: 0OGN-uyyORexCm24Gqkapg-1
Received: by mail-wm1-f72.google.com with SMTP id u144so1005840wmu.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2020 10:00:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=v0lvUfHZ5sUY4TlbEB+TMIDYZfmDwZ5AnicnBqS/RQ4=;
 b=adOyoO4dzVlLz2Bvim0GRt+VM/kdMDRqzJhyjgh92Piq4pfwkzs2akY58ygcKjhXVO
 Qwg/ncmgdOh4yj8zDwq7wKzkbVlFi4lUQGXb4PlE9mne38PpqGuvWIYZiEeQr5oxgtGm
 +uK2u0UjNxgA0YZKHT409uk5fkfdNWAWfS8TabWkQcgK+WQs7zAVy5jrss5dAEItqt9U
 OI++xgwaLdH4IKxzNwXSpHa8a+Kph2420RCAHOXeSMzkRfLu22mCFC4D35ZCd0WHGTeP
 ffzkyEFCY43qY5uw1D2beVRnNTDePHO1GWL4Q+u50JeY7Axv420v/FtDRNFofbno7dIX
 9OuQ==
X-Gm-Message-State: AOAM530lHTmiREPJeH6a3sWtnwoJGria1b0zgBwjoVrHJHjKlVPH5jqg
 rde4FsaA31R23ohM4tZye1j7xt87sOkn+wjivwfiENybzTZAwFuiaNGlCnQqm3i6Rn42NW45R6G
 qRvu1vKERAwzlsEY=
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr4578358wmf.26.1597942824428; 
 Thu, 20 Aug 2020 10:00:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyAF6ZnVtW7htX6aFBwt/CyNog9meDYTvlWL4La0VHmWkx3XI1/VPe554Tx9WH56RAq9GjDng==
X-Received: by 2002:a1c:b4c1:: with SMTP id d184mr4578338wmf.26.1597942824139; 
 Thu, 20 Aug 2020 10:00:24 -0700 (PDT)
Received: from x1w.redhat.com (121.red-81-40-121.staticip.rima-tde.net.
 [81.40.121.121])
 by smtp.gmail.com with ESMTPSA id n12sm5771622wrq.63.2020.08.20.10.00.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2020 10:00:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 15/15] block/nvme: Use an array of EventNotifier
Date: Thu, 20 Aug 2020 18:59:01 +0200
Message-Id: <20200820165901.1139109-16-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200820165901.1139109-1-philmd@redhat.com>
References: <20200820165901.1139109-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/19 20:12:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
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
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In preparation of using multiple IRQ (thus multiple eventfds)
make BDRVNVMeState::irq_notifier an array (for now of a single
element, the admin queue notifier).

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index a61e86a83eb..fe8a40b7ede 100644
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


