Return-Path: <SRS0=ZyMj=EB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29340C4363A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:12:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98C732067B
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2020 11:12:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WmFoSbhq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98C732067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kX0QK-0002BT-Ck
	for qemu-devel@archiver.kernel.org; Mon, 26 Oct 2020 07:12:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51398)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Av-0008Mq-04
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:52765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <philmd@redhat.com>) id 1kX0Ar-00006I-HH
 for qemu-devel@nongnu.org; Mon, 26 Oct 2020 06:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603709784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UchhDxvfvK9mvljYS5+MFH11t7RpYY2MHNXuIXgkVCI=;
 b=WmFoSbhqEzWpB1uV4QnWWNT07jNzoBdLJgujKNGpHZm9JuvdTJJrR2bnD36p2sdcn5tr3j
 XCPL9RB3JTnNulLVpqZorAr5DvLvImDnTa+SyBRcE8Nxr90f4TBIi6cqSI/ilYc/RB8FlJ
 IHELs31E0JzdkbLodYUZJi+QtLUDRJE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-380-C6nYZDcMPg2MNr-ORblXjQ-1; Mon, 26 Oct 2020 06:56:21 -0400
X-MC-Unique: C6nYZDcMPg2MNr-ORblXjQ-1
Received: by mail-wr1-f70.google.com with SMTP id 47so8217483wrc.19
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2020 03:56:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=UchhDxvfvK9mvljYS5+MFH11t7RpYY2MHNXuIXgkVCI=;
 b=QQ6YrTCy5K5X/YaMghssAlQqj5g/of1LE18SfeKEo/V3thwR5Xi1On8G7+WsP6Didq
 Cke6nk5lK9bqWGHkJ9uDppylVZRAXmNl1iMKi0QCtP0MCafd4LjCEFj45iCxCxhXIkjC
 0hWhQhpD6nxCQD/IbL3R27g5C6nYWZ3gnxxaBTqySE7jAnaK9J/S1pwY/bCPA2r5YdqJ
 JknNT+wix05RRBK0Si/lBPSxk6PGuFkeV5FBWvam1R5iE7zTk1d5pi6P+JZYiAP0VesY
 oGB53jG5ve3Tb8QhN2IQzdvz3Qg4ezaCi/cfqhjpG8unyxWQbiGCEV1+AW651dQUQjCz
 zFgg==
X-Gm-Message-State: AOAM530LoLYNPrMR2MCEl8glxq+4I9hiSy08q5W+Ax7GezqJ55wCTbjf
 +Yemzg56ddycxgHiy+ElCRyamztTvsx9VSnFJpXvNg62iMHN3IlN9BBav8txk85CmaABrSL5vyA
 YijKltu3H2tPVX34=
X-Received: by 2002:a7b:c3d3:: with SMTP id t19mr10792121wmj.139.1603709779454; 
 Mon, 26 Oct 2020 03:56:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxK+reWy6GKPqc0RXEbvbCmYmcLuekj14GSWO7nIOUhrD91W9ScTna0LeoOJcD4rgpvatBiKA==
X-Received: by 2002:a7b:c3d3:: with SMTP id t19mr10792101wmj.139.1603709779242; 
 Mon, 26 Oct 2020 03:56:19 -0700 (PDT)
Received: from localhost.localdomain (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id z15sm10503227wmk.4.2020.10.26.03.56.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Oct 2020 03:56:18 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/19] util/vfio-helpers: Report error when IOMMU page size
 is not supported
Date: Mon, 26 Oct 2020 11:55:00 +0100
Message-Id: <20201026105504.4023620-16-philmd@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=philmd@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/25 21:03:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>,
 Eric Auger <eric.auger@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This driver uses the host page size to align its memory regions,
but this size is not always compatible with the IOMMU. Add a
check if the size matches, and bails out providing a hint what
is the minimum page size the driver should use.

Suggested-by: Alex Williamson <alex.williamson@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 util/vfio-helpers.c | 28 ++++++++++++++++++++++++++--
 util/trace-events   |  1 +
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 5e288dfa113..874d76c2a2a 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -11,6 +11,7 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/cutils.h"
 #include <sys/ioctl.h>
 #include <linux/vfio.h>
 #include "qapi/error.h"
@@ -288,7 +289,7 @@ static void collect_usable_iova_ranges(QEMUVFIOState *s, void *buf)
 }
 
 static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
-                              Error **errp)
+                              size_t *requested_page_size, Error **errp)
 {
     int ret;
     int i;
@@ -299,6 +300,8 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
     struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
     char *group_file = NULL;
 
+    assert(requested_page_size && is_power_of_2(*requested_page_size));
+
     s->usable_iova_ranges = NULL;
 
     /* Create a new container */
@@ -373,6 +376,27 @@ static int qemu_vfio_init_pci(QEMUVFIOState *s, const char *device,
         ret = -errno;
         goto fail;
     }
+    if (!(iommu_info->flags & VFIO_IOMMU_INFO_PGSIZES)) {
+        error_setg(errp, "Failed to get IOMMU page size info");
+        ret = -EINVAL;
+        goto fail;
+    }
+    trace_qemu_vfio_iommu_iova_pgsizes(iommu_info->iova_pgsizes);
+    if (!(iommu_info->iova_pgsizes & *requested_page_size)) {
+        g_autofree char *req_page_size_str = size_to_str(*requested_page_size);
+        g_autofree char *min_page_size_str = NULL;
+        uint64_t pgsizes_masked;
+
+        pgsizes_masked = MAKE_64BIT_MASK(0, ctz64(*requested_page_size));
+        *requested_page_size = 1U << ctz64(iommu_info->iova_pgsizes
+                                           & ~pgsizes_masked);
+        min_page_size_str = size_to_str(*requested_page_size);
+        error_setg(errp, "Unsupported IOMMU page size: %s", req_page_size_str);
+        error_append_hint(errp, "Minimum IOMMU page size: %s\n",
+                          min_page_size_str);
+        ret = -EINVAL;
+        goto fail;
+    }
 
     /*
      * if the kernel does not report usable IOVA regions, choose
@@ -520,7 +544,7 @@ QEMUVFIOState *qemu_vfio_open_pci(const char *device, size_t *min_page_size,
     int r;
     QEMUVFIOState *s = g_new0(QEMUVFIOState, 1);
 
-    r = qemu_vfio_init_pci(s, device, errp);
+    r = qemu_vfio_init_pci(s, device, min_page_size, errp);
     if (r) {
         g_free(s);
         return NULL;
diff --git a/util/trace-events b/util/trace-events
index 7faad2a718c..3c36def9f30 100644
--- a/util/trace-events
+++ b/util/trace-events
@@ -87,6 +87,7 @@ qemu_vfio_do_mapping(void *s, void *host, uint64_t iova, size_t size) "s %p host
 qemu_vfio_dma_map(void *s, void *host, size_t size, bool temporary, uint64_t *iova) "s %p host %p size 0x%zx temporary %d &iova %p"
 qemu_vfio_dma_mapped(void *s, void *host, uint64_t iova, size_t size) "s %p host %p <-> iova 0x%"PRIx64" size 0x%zx"
 qemu_vfio_dma_unmap(void *s, void *host) "s %p host %p"
+qemu_vfio_iommu_iova_pgsizes(uint64_t iova_pgsizes) "iommu page size bitmask: 0x%08"PRIx64
 qemu_vfio_pci_read_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "read cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_pci_write_config(void *buf, int ofs, int size, uint64_t region_ofs, uint64_t region_size) "write cfg ptr %p ofs 0x%x size %d (region ofs 0x%"PRIx64" size %"PRId64")"
 qemu_vfio_region_info(const char *desc, uint64_t offset, uint64_t size, uint32_t cap_offset) "region '%s' ofs 0x%"PRIx64" size %"PRId64" cap_ofs %"PRId32
-- 
2.26.2


