Return-Path: <SRS0=0j61=C7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89480C2D0E2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B7BAC23A5F
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2020 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TikhrPot"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B7BAC23A5F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKdpx-0007PF-Hg
	for qemu-devel@archiver.kernel.org; Tue, 22 Sep 2020 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdox-0005YN-HV
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40973
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kKdou-0008Bb-He
 for qemu-devel@nongnu.org; Tue, 22 Sep 2020 04:38:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600763919;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sZC6xa6hR7fJNx1ScYKH1kNh8OmwESP7iiqvw8pbcT0=;
 b=TikhrPotxM12FeVm13TS2+b7Q3d1lLWeuNHLR9Q9W1z9kW4uDAIU7QEq4E5TkyzAXE0S+E
 052njGLqmxYsSUDSZmMXyzHtTb+Sleo2XLtAnPET+gNemg4J+b69rxsoYOpaPcw3yAdZtp
 uz1lHB1FtCnnIW/CAaSZveSOAYvQ2ac=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-405-49SRSuLjMUiryoQE7Zf5mA-1; Tue, 22 Sep 2020 04:38:36 -0400
X-MC-Unique: 49SRSuLjMUiryoQE7Zf5mA-1
Received: by mail-wm1-f69.google.com with SMTP id t10so383015wmi.9
 for <qemu-devel@nongnu.org>; Tue, 22 Sep 2020 01:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sZC6xa6hR7fJNx1ScYKH1kNh8OmwESP7iiqvw8pbcT0=;
 b=lHWIVWlPXrOB/8LYjVDguqjyONsu352gWuhh6OWp0JnhzvG2SUV9NhKzTXZNaqJL34
 Nwsa7EtYQfs9UMVZ4+/jmNbKWdCiG9dob6+lWF37spqFVs6PlAPip66nQL79swnLj3uw
 aJrJj1LeFP9KP7miGEUOcCUYXa8NJ7NUEtb4AgWwaihwdVFnjAH/RcqVQpLWHr36chnl
 ryjHVpJyvtefql6KNwZG6YL9ZUceYTE+biVpVtC0TSTovYm3gsMwMu6SpO/uMlbJp/rv
 lHFRinNna3sm3Aoxdyvo/c+gNoe1tT0Zx3KTymi0C4WztcESbzMlKEEOCDHJ3s6ipjea
 ZYlw==
X-Gm-Message-State: AOAM532vIF8d5PqYAcO1eElvJXHrU14lZym+a9hMf+AtrTHxHOg4vTxR
 6kLBSkuwIcN06zHIyyMYzT7DA2xfJNfOj06Zik4/yewlDkx1tsRsxizVvHXsZkg7fSwNVlQYk9s
 wdjU/GzgaUjkv/Rw=
X-Received: by 2002:adf:c404:: with SMTP id v4mr3945423wrf.17.1600763914462;
 Tue, 22 Sep 2020 01:38:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxF+UhqcZjJhKCOx+Q+BQywL0fXH3wc58iclR4SZ3UwB3K+7NSbyy3ViBSWSzy1/bWyUBH3EA==
X-Received: by 2002:adf:c404:: with SMTP id v4mr3945400wrf.17.1600763914258;
 Tue, 22 Sep 2020 01:38:34 -0700 (PDT)
Received: from localhost.localdomain (65.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.65])
 by smtp.gmail.com with ESMTPSA id a81sm3632300wmf.32.2020.09.22.01.38.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 01:38:33 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH v2 2/6] block/nvme: Map doorbells pages write-only
Date: Tue, 22 Sep 2020 10:38:17 +0200
Message-Id: <20200922083821.578519-3-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200922083821.578519-1-philmd@redhat.com>
References: <20200922083821.578519-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8;
	text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=philmd@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/22 01:57:21
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
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


