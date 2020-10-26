Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07F6CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:09:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96CCB2224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:09:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WaJ3v6Fq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96CCB2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0Nr-0006wa-Ge
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:09:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AY-0007vV-5l
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28839)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0AW-0008Os-6a
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nFpAvnhzKFUahLqtIDcPSll9W0TpjYlTTuISswcMLmQ=;
 b=WaJ3v6Fq0QI2EOJD+XY5P4zvTx8ODsNtKELsPVC7zJttwLyb2JmqXnTyMPVu6hA+WNL/TX
 PkT1X7Onqw2SnaxMWlJMRrCo9LkYFNgHSGnKIbOBUWXWKhCX6CeLRf5pNjanZe706kBQCw
 xUlrC9Uw41TwNt0/MmIp72euGBhEBI0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-AH5FnfSYNmufBk6guIBQyA-1; Mon, 26 Oct 2020 06:56:02 -0400
X-MC-Unique: AH5FnfSYNmufBk6guIBQyA-1
Received: by mail-wr1-f72.google.com with SMTP id t11so8201341wrv.10
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nFpAvnhzKFUahLqtIDcPSll9W0TpjYlTTuISswcMLmQ=;
 b=BgmUhccGta/RdNshCCx1OoUVagx97Yut6N0+gFVoi1cJz9CV0BBl0QHF9pEPmfyo+L
 HU+A/qP5BuJQ+GMLmNf8tujs4U0/TbghKF6O7jy/cfDQdH3nlhgdlM6UvxubU78tqioL
 9L63EviwIc/rQn4vAPLBIQbk/7gmYVF+Hz3GhD5frtU/3u6rRpdEr2DUeSrEMwTbdMuV
 dr+HfzQZYvCKadUGgX9/KKCVAvYLaHZwujHTuhqk0dGwSw35KJmmrcFEOcDcKat7zT+w
 /uJPKS8Ny54L1cXK9/zXseMoOaUhcUT/cqCQF6ikt9w/i7DhHV+WFWc1koqGwjzA3fIa
 PC1Q==
X-Gm-Message-State: AOAM532uDJFzOU+WKhRVQc3abSk1lVk2WaXTSJcGFmB/FPbm+jUOWpeH
 EIcQZ71TudZZj2u2FLv2YuLyelkUXuABtnpuOp7GcUUaWgh/P85LnNMeeY2UXAGAPUlZ2w9C7bj
 8BNCLjWI6vWksBmY=
X-Received: by 2002:adf:a50e:: with SMTP id i14mr17333459wrb.121.1603709760293; 
 Mon, 26 Oct 2020 03:56:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz8GK1OLplsiLuQMJxuiurJRsDQasKsAKfLItgMABPsNy9NlED7VnK9OxF8sRAIiKLQ26jIdA==
X-Received: by 2002:adf:a50e:: with SMTP id i14mr17333431wrb.121.1603709760085; 
 Mon, 26 Oct 2020 03:56:00 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id n6sm22440143wrj.60.2020.10.26.03.55.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:55:59 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 11/19] util/vfio-helpers: Let qemu_vfio_dma_map() propagate
 Error
Date: Mon, 26 Oct 2020 11:54:56 +0100
Message-Id: <20201026105504.4023620-12-philmd@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201026105504.4023620-1-philmd@redhat.com>
References: <20201026105504.4023620-1-philmd@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=philmd@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=216.205.24.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/26 02:39:09
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
 Eric Auger <eric.auger@redhat.com>,
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  2 +-
 block/nvme.c                | 14 +++++++-------
 util/vfio-helpers.c         | 12 +++++++-----
 3 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 4491c8e1a6e..bde9495b254 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -18,7 +18,7 @@ typedef struct QEMUVFIOState QEMUVFIOState;
 QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
 void qemu_vfio_close(QEMUVFIOState *s);
 int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
-                      bool temporary, uint64_t *iova_list);
+                      bool temporary, uint64_t *iova_list, Error **errp);
 int qemu_vfio_dma_reset_temporary(QEMUVFIOState *s);
 void qemu_vfio_dma_unmap(QEMUVFIOState *s, void *host);
 void *qemu_vfio_pci_map_bar(QEMUVFIOState *s, int index,
diff --git a/block/nvme.c b/block/nvme.c
index 3b6d3972ec2..6f1ebdf031f 100644
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
 
@@ -1003,7 +1003,7 @@ try_map:
         r = qemu_vfio_dma_map(s->vfio,
                               qiov->iov[i].iov_base,
                               qiov->iov[i].iov_len,
-                              true, &iova);
+                              true, &iova, NULL);
         if (r == -ENOMEM && retry) {
             retry = false;
             trace_nvme_dma_flush_queue_wait(s);
@@ -1450,7 +1450,7 @@ static void nvme_register_buf(BlockDriverState *bs, void *host, size_t size)
     int ret;
     BDRVNVMeState *s = bs->opaque;
 
-    ret = qemu_vfio_dma_map(s->vfio, host, size, false, NULL);
+    ret = qemu_vfio_dma_map(s->vfio, host, size, false, NULL, NULL);
     if (ret) {
         /* FIXME: we may run out of IOVA addresses after repeated
          * bdrv_register_buf/bdrv_unregister_buf, because nvme_vfio_dma_unmap
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 73f7bfa7540..c03fe0b7156 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -462,7 +462,7 @@ static void qemu_vfio_ram_block_added(RAMBlockNotifier *n,
 {
     QEMUVFIOState *s = container_of(n, QEMUVFIOState, ram_notifier);
     trace_qemu_vfio_ram_block_added(s, host, size);
-    qemu_vfio_dma_map(s, host, size, false, NULL);
+    qemu_vfio_dma_map(s, host, size, false, NULL, NULL);
 }
 
 static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
@@ -477,6 +477,7 @@ static void qemu_vfio_ram_block_removed(RAMBlockNotifier *n,
 
 static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
 {
+    Error *local_err = NULL;
     void *host_addr = qemu_ram_get_host_addr(rb);
     ram_addr_t length = qemu_ram_get_used_length(rb);
     int ret;
@@ -485,10 +486,11 @@ static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
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
@@ -724,7 +726,7 @@ qemu_vfio_find_temp_iova(QEMUVFIOState *s, size_t size, uint64_t *iova)
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


