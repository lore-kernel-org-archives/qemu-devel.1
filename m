Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43677C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:08:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A8E2224A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:08:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gjdd9PqG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A8E2224A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42968 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0MX-0004of-Fk
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:08:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51352)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Ap-0008Kg-9q
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34873)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Al-0008VH-A3
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UF5uHhXgkWDHbzk6PtUz47NRa7jF7pKRdhEOKMwbuvA=;
 b=gjdd9PqGqmZoTZPJQ3lh4l+hmL61KuokV2rgNp2zQxpJnq4JV4R1dbpiXA3zqnw0s8cDYk
 x7V7Y7rlXC5gDdRfK3eOYK4XbhGKXfUA7SAUiFYVBSOLDYtq9AzD3mF5y5fqe5KhUlLFKB
 F+DW3i5tdv/4PXxUK1ws1eZhAlXm7f8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-585-X3HoYiYgNDap-0OSVto8Hw-1; Mon, 26 Oct 2020 06:56:16 -0400
X-MC-Unique: X3HoYiYgNDap-0OSVto8Hw-1
Received: by mail-wr1-f71.google.com with SMTP id t17so8211348wrm.13
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UF5uHhXgkWDHbzk6PtUz47NRa7jF7pKRdhEOKMwbuvA=;
 b=a+HbVQwb5nPZh1AfEL8t8lnE3+IpsYQNptFOEQuqtlD1b9v76QopLkQHX0uxRR8ofX
 WEglbdNxw1hS6NcVoHl2xKYezByNbE0kDCxc+JzcnXnrUL/8ITylzjRPrq25CbnCRyRK
 znW7yFiJ1p+xcIOieSFrAboxnJ//CVgNfTEjlN+N5ednFfTHjGWYnXcAfAihh8o9R3pa
 JENyrA3FvZOj8wNnyIBsp/nlYuX2l/osSeqFwSafuwMsI7MAltzGdgWKXKLP1GbAj1Jz
 DGt7SnmW1UMi0kG9uPvvbjonhrXRev3+zACd0Ipz+JgfbBkM2/pOR3zx2mGeNU2smJ/S
 aoTQ==
X-Gm-Message-State: AOAM532k6/U6ibx2Q2A9zHtzShWrWRucXKgPMWox1b+Au/c4gshDXOSI
 mh3eq8CqmvqB7Jub1BjfKspcYfbnGdDO2cIt6OFzCg5CFvK6jOT7+9dKiQd6OBTGYZBuIlVwwIZ
 29Jz0l4nCDDTE2Og=
X-Received: by 2002:adf:f88a:: with SMTP id u10mr17132043wrp.1.1603709774610; 
 Mon, 26 Oct 2020 03:56:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz9JCsH/KUKoyBhse/sZJWxBtqDn9/yrz4mU+ECSJwOjgtXkz/k0SG8tlYRPFwdQ4Guuu6T8Q==
X-Received: by 2002:adf:f88a:: with SMTP id u10mr17132029wrp.1.1603709774381; 
 Mon, 26 Oct 2020 03:56:14 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id w7sm24667479wre.9.2020.10.26.03.56.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:56:13 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 14/19] util/vfio-helpers: Pass minimum page size to
 qemu_vfio_open_pci()
Date: Mon, 26 Oct 2020 11:54:59 +0100
Message-Id: <20201026105504.4023620-15-philmd@redhat.com>
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

The block driver asks for a minimum page size, but it might not
match the minimum IOMMU requirement.

In the next commit qemu_vfio_init_pci() will be able to report
the minimum IOMMU page size back to the block driver.
In preparation, pass the minimum page size as argument to
qemu_vfio_open_pci(). Add a check to be sure the IOMMU minimum
page size is in range with our NVMe device maximum page size.

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 include/qemu/vfio-helpers.h |  3 ++-
 block/nvme.c                | 14 +++++++++++++-
 util/vfio-helpers.c         |  8 +++++++-
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/qemu/vfio-helpers.h b/include/qemu/vfio-helpers.h
index bde9495b254..4b97a904e93 100644
--- a/include/qemu/vfio-helpers.h
+++ b/include/qemu/vfio-helpers.h
@@ -15,7 +15,8 @@
 
 typedef struct QEMUVFIOState QEMUVFIOState;
 
-QEMUVFIOState *qemu_vfio_open_pci(const char *device, Error **errp);
+QEMUVFIOState *qemu_vfio_open_pci(const char *device, size_t *min_page_size,
+                                  Error **errp);
 void qemu_vfio_close(QEMUVFIOState *s);
 int qemu_vfio_dma_map(QEMUVFIOState *s, void *host, size_t size,
                       bool temporary, uint64_t *iova_list, Error **errp);
diff --git a/block/nvme.c b/block/nvme.c
index 6f1ebdf031f..46b09b3a3a7 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -691,6 +691,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     Error *local_err = NULL;
     volatile NvmeBar *regs = NULL;
     size_t device_page_size_min;
+    size_t device_page_size_max;
     size_t iommu_page_size_min = 4096;
 
     qemu_co_mutex_init(&s->dma_map_lock);
@@ -704,7 +705,7 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
         return ret;
     }
 
-    s->vfio = qemu_vfio_open_pci(device, errp);
+    s->vfio = qemu_vfio_open_pci(device, &iommu_page_size_min, errp);
     if (!s->vfio) {
         ret = -EINVAL;
         goto out;
@@ -737,6 +738,17 @@ static int nvme_init(BlockDriverState *bs, const char *device, int namespace,
     }
 
     device_page_size_min = 1u << (12 + NVME_CAP_MPSMIN(cap));
+    device_page_size_max = 1u << (12 + NVME_CAP_MPSMAX(cap));
+    if (iommu_page_size_min > device_page_size_max) {
+        g_autofree char *iommu_page_size_s = size_to_str(iommu_page_size_min);
+        g_autofree char *device_page_size_s = size_to_str(device_page_size_max);
+
+        error_setg(errp, "IOMMU minimum page size (%s)"
+                         " too big for device (max %s)",
+                   iommu_page_size_s, device_page_size_s);
+        ret = -EINVAL;
+        goto out;
+    }
     s->page_size = MAX(iommu_page_size_min, device_page_size_min);
     s->doorbell_scale = (4 << NVME_CAP_DSTRD(cap)) / sizeof(uint32_t);
     bs->bl.opt_mem_alignment = s->page_size;
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 488ddfca2a9..5e288dfa113 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -508,8 +508,14 @@ static void qemu_vfio_open_common(QEMUVFIOState *s)
 
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


