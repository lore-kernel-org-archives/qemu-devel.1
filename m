Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57D3DC43468
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:38:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1F9D2399C
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 16:38:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PALxeFnB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1F9D2399C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50564 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKOpZ-0003Dc-Ve
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 12:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhm-0004W6-MM
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:18 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:50508
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKOhd-0007QZ-An
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 12:30:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600705804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZC6xa6hR7fJNx1ScYKH1kNh8OmwESP7iiqvw8pbcT0=;
 b=PALxeFnBmJkAw3eckd3L+NNRYPjFfPqMZGHFoQ9O2xIcW64/sgQJ8pfrdZ5FZLCjjg25hh
 +9Iuv0n6xJXYi3rDUkGv+iEtraT5ZcktRirX/uoL2aJ1x+9cCrvfTL8nuykpTqrgX8VnXJ
 m7NPKJzNvmeYHF7EWMq7K+BMxxr9lj4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-mI6Tou2DPa-hO5jMZAw18g-1; Mon, 21 Sep 2020 12:30:02 -0400
X-MC-Unique: mI6Tou2DPa-hO5jMZAw18g-1
Received: by mail-wr1-f69.google.com with SMTP id f18so6093542wrv.19
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 09:30:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sZC6xa6hR7fJNx1ScYKH1kNh8OmwESP7iiqvw8pbcT0=;
 b=ukFGQbPBuNXVoxyus+iJhAwzpkg6aQlGiY8ZUeQLAjUFSUR4s3F1IB5zk6jDqFa/Er
 VavOAqgbNejVRtWA2sXaJRG/TwjO5M/P30EmSa7BnmtzK8M+Gqxxnoa1ahP1Jq0L9890
 Fcc3hMBTC3MkaamU6NAFc3YCMpr6TAeo/RIF0outb9wx4aATSp01lvwgdw3YIl3aF45T
 3+B1yd9yhKq0KrvhUrQburvperadDicaWyp3guyf1OhjhDFrplyukhmthaDI0ZmNHA/h
 Vo8y1COqQcAZpabp5vYrN9mNpzkPY8UN704kQqGlK2QA6aE98RQSRGCbbRoLu9NwVCxv
 6mDg==
X-Gm-Message-State: AOAM533j9mjY6Wj3Lr8aA0nMz4NTWNZ6SHXz4uXgZSyO8ITXkgYw93I7
 usQ6LHbpslFTzNE1N2HVvx348xuWGUigIunjpmX1QHv01W1v0/5bcspUNBEK0KjRkfjmPiu3+Uu
 nT0P3DSQFYxYqzpc=
X-Received: by 2002:a7b:c959:: with SMTP id i25mr197182wml.39.1600705801473;
 Mon, 21 Sep 2020 09:30:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNS1UUWMCMi5dN+C53zPVnHzJVRbDkldI4yGh41Hj0IqRxHo0OfxT7hN44z4Ta/Ssr8zP9Zg==
X-Received: by 2002:a7b:c959:: with SMTP id i25mr197162wml.39.1600705801250;
 Mon, 21 Sep 2020 09:30:01 -0700 (PDT)
Received: from x1w.redhat.com (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id y1sm127613wma.36.2020.09.21.09.30.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 09:30:00 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH 2/6] block/nvme: Map doorbells pages write-only
Date: Mon, 21 Sep 2020 18:29:45 +0200
Message-Id: <20200921162949.553863-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200921162949.553863-1-philmd@redhat.com>
References: <20200921162949.553863-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 03:43:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Per the datasheet sections 3.1.13/3.1.14:
  "The host should not read the doorbell registers."

As we don't need read access, map the doorbells with write-only
permission. We keep a reference to this mapped address in the
BDRVNVMeState structure.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 block/nvme.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 5a4dc6a722a..3c834da8fec 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -31,7 +31,7 @@
 #define NVME_SQ_ENTRY_BYTES 64
 #define NVME_CQ_ENTRY_BYTES 16
 #define NVME_QUEUE_SIZE 128
-#define NVME_BAR_SIZE 8192
+#define NVME_DOORBELL_SIZE 4096
 
 /*
  * We have to leave one slot empty as that is the full queue case where
@@ -84,10 +84,6 @@ typedef struct {
 /* Memory mapped registers */
 typedef volatile struct {
     NvmeBar ctrl;
-    struct {
-        uint32_t sq_tail;
-        uint32_t cq_head;
-    } doorbells[];
 } NVMeRegs;
 
 #define INDEX_ADMIN     0
@@ -103,6 +99,11 @@ struct BDRVNVMeState {
     AioContext *aio_context;
     QEMUVFIOState *vfio;
     NVMeRegs *regs;
+    /* Memory mapped registers */
+    volatile struct {
+        uint32_t sq_tail;
+        uint32_t cq_head;
+    } *doorbells;
     /* The submission/completion queue pairs.
      * [0]: admin queue.
      * [1..]: io queues.
@@ -247,14 +248,14 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
         error_propagate(errp, local_err);
         goto fail;
     }
-    q->sq.doorbell = &s->regs->doorbells[idx * s->doorbell_scale].sq_tail;
+    q->sq.doorbell = &s->doorbells[idx * s->doorbell_scale].sq_tail;
 
     nvme_init_queue(s, &q->cq, size, NVME_CQ_ENTRY_BYTES, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto fail;
     }
-    q->cq.doorbell = &s->regs->doorbells[idx * s->doorbell_scale].cq_head;
+    q->cq.doorbell = &s->doorbells[idx * s->doorbell_scale].cq_head;
 
     return q;
 fail:
@@ -712,13 +713,12 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, NVME_BAR_SIZE,
+    s->regs = qemu_vfio_pci_map_bar(s->vfio, 0, 0, sizeof(NvmeBar),
                                     PROT_READ | PROT_WRITE, errp);
     if (!s->regs) {
         ret = -EINVAL;
         goto out;
     }
-
     /* Perform initialize sequence as described in NVMe spec "7.6.1
      * Initialization". */
 
@@ -748,6 +748,13 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         }
     }
 
+    s->doorbells = qemu_vfio_pci_map_bar(s->vfio, 0, sizeof(NvmeBar),
+                                         NVME_DOORBELL_SIZE, PROT_WRITE, errp);
+    if (!s->doorbells) {
+        ret = -EINVAL;
+        goto out;
+    }
+
     /* Set up admin queue. */
     s->queues = g_new(NVMeQueuePair *, 1);
     s->queues[INDEX_ADMIN] = nvme_create_queue_pair(s, aio_context, 0,
@@ -873,7 +880,9 @@ static void nvme_close(BlockDriverState *bs)
                            &s->irq_notifier[MSIX_SHARED_IRQ_IDX],
                            false, NULL, NULL);
     event_notifier_cleanup(&s->irq_notifier[MSIX_SHARED_IRQ_IDX]);
-    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZE);
+    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->doorbells,
+                            sizeof(NvmeBar), NVME_DOORBELL_SIZE);
+    qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, sizeof(NvmeBar));
     qemu_vfio_close(s->vfio);
 
     g_free(s->device);
-- 
2.26.2


