Return-Path: <SRS0=1sPN=D3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C2D4C4363A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:26:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D7C2222D
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2020 17:26:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WSVgmUKJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D7C2222D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUvPD-0008Qa-LP
	for qemu-devel@archiver.kernel.org; Tue, 20 Oct 2020 13:26:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34682)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNa-0006A9-Sp
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:25:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kUvNU-0007uV-A8
 for qemu-devel@nongnu.org; Tue, 20 Oct 2020 13:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603214690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLSFcjIN9fsyM4mYIkd/q8ZNCzz/MCojLmiYxvbAHJQ=;
 b=WSVgmUKJD3uOU0NzYT5SadSMVZZSpynSLhK7jAyqy6ijPjbVJUUMm8AQ3AbiB0TYNNU8O5
 ZcGnl/LgC/7mRPh0z6aramWO9hvBUa+0MEcv/HrL4mHjMrDDjZfbijDN4qpMLps1Hzko3O
 HVLrhmY7/nIz8tVrv8gY5NSIaIXKStQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-162-ZUmhjPJZN2Kg7NtrtIFeAw-1; Tue, 20 Oct 2020 13:24:47 -0400
X-MC-Unique: ZUmhjPJZN2Kg7NtrtIFeAw-1
Received: by mail-wr1-f72.google.com with SMTP id m20so1068814wrb.21
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2020 10:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=RLSFcjIN9fsyM4mYIkd/q8ZNCzz/MCojLmiYxvbAHJQ=;
 b=XnYoVK45a9K7oz1MlE5FXQ3gDMEiiAxM9/2nHxmO8YakV1chKOhp8Oo/0egA3m/uan
 CA9qZrgLL6jWkzonGDuKzPcMhk7ad14cbkG16/gOyzb6O1Wenp8Iv6FQB1dMzTvYUhJc
 wtaAILKDaE8YeiiMQOqkQP8k48LUp4FQAEOkcAULqRh/oF3iATc6lWzkaFWGpFgEhfta
 QZkaqYO2Det0+S1BwQzRdkyWKEKll60QyrmePRa2mkrmtLbXwHxDtRpN111XdG5FAlDj
 BzHs06V0KeUiBHrO78UTHuZ8g8KGYSOUvY7F7cQRpohOOgUleIhms1I5gw6DWh4NW4/3
 Zi7w==
X-Gm-Message-State: AOAM532/idDPuw4k1XgI54fzVCZmhk4M9EekD6h4/0Vj5CYRlrbiFMsU
 Dd6vGac6CoDHE5ZcVu/o/ctIYQdadwi41hlY+8//7sZjZYqVjqhTv+VxWJbW1VZKyo2QBin4AB+
 lupVjyrWYcKUSY5U=
X-Received: by 2002:a7b:c384:: with SMTP id s4mr4059799wmj.77.1603214686177;
 Tue, 20 Oct 2020 10:24:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwtblf+EuY7iAK651HJztXrNpt21m7DLZ5Exq2EIzgtnesmNJ8R78rTO0MX31ZTDrbiuYeEWw==
X-Received: by 2002:a7b:c384:: with SMTP id s4mr4059778wmj.77.1603214685932;
 Tue, 20 Oct 2020 10:24:45 -0700 (PDT)
Received: from x1w.redhat.com (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id e5sm3846294wrw.93.2020.10.20.10.24.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Oct 2020 10:24:45 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 03/16] util/vfio-helpers: Pass minimum page size to
 qemu_vfio_open_pci()
Date: Tue, 20 Oct 2020 19:24:15 +0200
Message-Id: <20201020172428.2220726-4-philmd@redhat.com>
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

The block driver asks for a minimum page size, but it might not
match the minimum IOMMU requirement.
In the next commit qemu_vfio_init_pci() will be able to report
the minimum IOMMU page size back to the block driver.
In preparation, pass the minimum page size as argument to
qemu_vfio_open_pci().

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h | 3 ++-
 block/nvme.c                | 5 +++--
 util/vfio-helpers.c         | 8 +++++++-
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index 4491c8e1a6e..5cb346d8e67 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -15,7 +15,8 @@
 
 typedef struct QEMUVFIOState QEMUVFIOState;
 
-QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
+QEMUVFIOState *qemu_vfio_open_pci(const char *device, size_t *min_page_size,
+                                  Error **errp);
 void qemu_vfio_close(QEMUVFIOState *s);
 int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                       bool temporary, uint64_t *iova_list);
diff --git a/block/nvme.c b/block/nvme.c
index 029694975b9..8335f5d70dd 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -690,6 +690,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     uint64_t deadline, now;
     Error *local_err = NULL;
     volatile NvmeBar *regs = NULL;
+    size_t min_page_size = 4096;
 
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
@@ -702,7 +703,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         return ret;
     }
 
-    s->vfio = qemu_vfio_open_pci(device, errp);
+    s->vfio = qemu_vfio_open_pci(device, &min_page_size, errp);
     if (!s->vfio) {
         ret = -EINVAL;
         goto out;
@@ -724,7 +725,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         goto out;
     }
 
-    s->page_size = MAX(4096, 1u << (12 + NVME_CAP_MPSMIN(cap)));
+    s->page_size = MAX(min_page_size, 1u << (12 + NVME_CAP_MPSMIN(cap)));
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
     timeout_ms = MIN(500 * NVME_CAP_TO(cap), 30000);
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 14a549510fe..a2b084c69c1 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -488,8 +488,14 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
 
 /**
  * Open a PCI device, e.g. "0000:00:01.0".
+ *
+ * @min_page_size: Pointer holding the minimum page size requested
+ *
+ * If the IOMMU can not be configured with @min_page_size, the minimum
+ * page size is stored in @min_page_size and -EINVAL is returned.
  */
-QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp)
+QEMUVFIOState *qemu_vfio_open_pci(const char *device, size_t *min_page_size,
+                                  Error **errp)
 {
     int r;
     QEMUVFIOState *s = g_new0(QEMUVFIOState, 1);
-- 
2.26.2


