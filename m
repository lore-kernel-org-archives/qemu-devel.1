Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1B9C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:37:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D637A2080D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:37:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bVOidU16"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D637A2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56518 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvZf-0007GL-6Z
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:37:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34920)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvO5-000721-8K
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:33393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvO2-00086w-FN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214724;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLOm46KfCEikq86Y3pgvNvo5u9OAutjap0o+dhD/k3Y=;
 b=bVOidU16IldnhHLQjGk+L2d5IKQYnnW4X+PmQ67lfK2E8WrF8LUyELfreEjpVKdZa0pPXd
 lUrIz1PxXrIjutpGcOmGaAHnUAmcJZH0O2OexAnpCtS8wgnLuxe1HcmnpkacwAr+0HLs96
 l0EqMNUaoJCDzPjAJq8ypVAVjumaKr8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-114-QzpgvYIKPfO_IkjCWEt5TA-1; Tue, 20 Oct 2020 13:25:23 -0400
X-MC-Unique: QzpgvYIKPfO_IkjCWEt5TA-1
Received: by mail-wr1-f72.google.com with SMTP id 2so1076716wrd.14
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:25:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=MLOm46KfCEikq86Y3pgvNvo5u9OAutjap0o+dhD/k3Y=;
 b=J26tlQfLO+wT2gzem04c8toBjrtxzDej1ymNEope7W1Fjubj1vUXbxDbkO0W+r9KAk
 l7vRgDjspi/UBZbKonV4K3DuLoypLmHWJ2vMTeQPf+4sqAsmPTAsQRf4lNQeCQHm8+YN
 fR9ftvI4MuHzwQPNUiCeY1U5VeRoiytlQmdfOiTHFD3Wjxg9ZooQpPeIbFAazNq7JvSW
 7v/EHcv6f1GupvDmIGNwCP8ogtqEYiKYXBkM/+sGveTJRJ/KF2PhHcn2ptWGue3HIJsE
 DwnJDQRNnLSinDtKGAwq1uaVizGJOYoaz7o4uvqJI6F45o/LQRiFvdIxaC79Sb0Jk7OZ
 szMg==
X-Gm-Message-State: AOAM533ABGDgQ1yIwx7K0EmUyQ2P8h1paEfEQVyX+0SN3xLAwqTbVcDM
 StCwm7pjWv7mbCSHd0EGORGeZDWSCvCxuWi/pAFVc99aB0N1/JQhNVaipSHzx/vA8SJoKMko/o7
 +lMr6JcvCBUOcxX0=
X-Received: by 2002:a7b:c341:: with SMTP id l1mr4171329wmj.80.1603214721817;
 Tue, 20 Oct 2020 10:25:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4BCYIdH3y+v314ecWJ7QzYvUGZoGOW233TZDHOfC4Nw0fGTCX6iw6Y2XUy6c9lI9/PzLQmQ==
X-Received: by 2002:a7b:c341:: with SMTP id l1mr4171309wmj.80.1603214721583;
 Tue, 20 Oct 2020 10:25:21 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id y7sm3579711wmg.40.2020.10.20.10.25.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:25:20 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/16] util/vfio-helpers: Let qemu_vfio_dma_map() propagate
 Error
Date: Tue, 20 Oct 2020 19:24:22 +0200
Message-Id: <20201020172428.2220726-11-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201020172428.2220726-1-philmd@redhat.com>
References: <20201020172428.2220726-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/20 01:15:43
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Currently qemu_vfio_dma_map() displays errors on stderr.
When using management interface, this information is simply
lost. Pass qemu_vfio_dma_map() an Error* argument so it can
propagate the error to callers.

Reviewed-by: Fam Zheng <fam@euphon.net>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  2 +-
 block/nvme.c                | 14 +++++++-------
 util/vfio-helpers.c         | 12 +++++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 5cb346d8e67..4b97a904e93 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -19,7 +19,7 @@ QEMUVFIOState *qemu_vfio_open_pci(const char *device, size_t *min_page_size,
                                   Error **errp);
 void qemu_vfio_close(QEMUVFIOState *s);
 int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
-                      bool temporary, uint64_t *iova_list);
+                      bool temporary, uint64_t *iova_list, Error **errp);
 int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s);
 void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host);
 void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
diff --git a/block/nvme.c b/block/nvme.c
index 8335f5d70dd..428cda620df 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -167,9 +167,9 @@ static void nvme_init_queue(BDRVNVMeState *s, NVMeQueue *q,
         return;
     }
     memset(q->queue, 0, bytes);
-    r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova);
+    r = qemu_vfio_dma_map(s->vfio, q->queue, bytes, false, &q->iova, errp);
     if (r) {
-        error_setg(errp, "Cannot map queue");
+        error_prepend(errp, "Cannot map queue: ");
     }
 }
 
@@ -223,7 +223,7 @@ static NVMeQueuePair *nvme_create_queue_pair(BDRVNVMeState *s,
     q->completion_bh = aio_bh_new(aio_context, nvme_process_completion_bh, q);
     r = qemu_vfio_dma_map(s->vfio, q->prp_list_pages,
                           s->page_size * NVME_NUM_REQS,
-                          false, &prp_list_iova);
+                          false, &prp_list_iova, errp);
     if (r) {
         goto fail;
     }
@@ -514,9 +514,9 @@ static void nvme_identify(BlockDriverState *bs, int namespace, Error **errp)
         error_setg(errp, "Cannot allocate buffer for identify response");
         goto out;
     }
-    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova);
+    r = qemu_vfio_dma_map(s->vfio, id, sizeof(*id), true, &iova, errp);
     if (r) {
-        error_setg(errp, "Cannot map buffer for DMA");
+        error_prepend(errp, "Cannot map buffer for DMA: ");
         goto out;
     }
 
@@ -990,7 +990,7 @@ try_map:
         r = qemu_vfio_dma_map(s->vfio,
                               qiov->iov[i].iov_base,
                               qiov->iov[i].iov_len,
-                              true, &iova);
+                              true, &iova, NULL);
         if (r == -ENOMEM && retry) {
             retry = false;
             trace_nvme_dma_flush_queue_wait(s);
@@ -1437,7 +1437,7 @@ static void nvme_register_buf(BlockDriverState *bs, void *host, size_t size)
     int ret;
     BDRVNVMeState *s = bs->opaque;
 
-    ret = qemu_vfio_dma_map(s->vfio, host, size, false, NULL);
+    ret = qemu_vfio_dma_map(s->vfio, host, size, false, NULL, NULL);
     if (ret) {
         /* FIXME: we may run out of IOVA addresses after repeated
          * bdrv_register_buf/bdrv_unregister_buf, because nvme_vfio_dma_unmap
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 6a5100f4892..8c075d9aae7 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -486,7 +486,7 @@ static void qemu_vfio_ram_block_added(RAMBlockNotifier *n,
 {
     QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);
     trace_qemu_vfio_ram_block_added(s, host, size);
-    qemu_vfio_dma_map(s, host, size, false, NULL);
+    qemu_vfio_dma_map(s, host, size, false, NULL, NULL);
 }
 
 static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
@@ -501,6 +501,7 @@ static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
 
 static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
 {
+    Error *local_err = NULL;
     void *host_addr = qemu_ram_get_host_addr(rb);
     ram_addr_t length = qemu_ram_get_used_length(rb);
     int ret;
@@ -509,10 +510,11 @@ static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
     if (!host_addr) {
         return 0;
     }
-    ret = qemu_vfio_dma_map(s, host_addr, length, false, NULL);
+    ret = qemu_vfio_dma_map(s, host_addr, length, false, NULL, &local_err);
     if (ret) {
-        fprintf(stderr, "qemu_vfio_init_ramblock: failed %p %" PRId64 "\n",
-                host_addr, (uint64_t)length);
+        error_reportf_err(local_err,
+                          "qemu_vfio_init_ramblock: failed %p %" PRId64 ":",
+                          host_addr, (uint64_t)length);
     }
     return 0;
 }
@@ -754,7 +756,7 @@ qemu_vfio_find_temp_iova(QEMUVFIOState *s, size_t size, uint64_t *iova)
  * mapping status within this area is not allowed).
  */
 int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
-                      bool temporary, uint64_t *iova)
+                      bool temporary, uint64_t *iova, Error **errp)
 {
     int ret = 0;
     int index;
-- 
2.26.2


