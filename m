Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71805C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:03:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D162420BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:03:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YPXPvp09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D162420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50914 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAwv-0007x4-Qj
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:03:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59362)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlr-0006OV-4B
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45233)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlp-0004fB-4L
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FzlYUeG8X4vs91S4tquZq9KM016eO3pXrdQjhhAV7O0=;
 b=YPXPvp09k27SqIkhY7wuAMzEKcr3zkmquEIe7Rh/Ihy7mopj1SOi8DjZPHXlHlPphIbJKS
 rjrH+ZfdyIFcdKAhj6s1KOX507IrlTxRApUgS/5BMQolf1DEUDr0xdctUiULuFp07CF6x0
 wWof07T2I4Mdz6bZiZLUfdBzYNTRjAI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-235-1J3OIQa2N6aVHf2Acg8SRw-1; Tue, 03 Nov 2020 23:51:37 -0500
X-MC-Unique: 1J3OIQa2N6aVHf2Acg8SRw-1
Received: by mail-wr1-f72.google.com with SMTP id t14so8789228wrs.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=FzlYUeG8X4vs91S4tquZq9KM016eO3pXrdQjhhAV7O0=;
 b=ky9BuMmB4St7F4gSAUB9OYWi8UADuhdjQHmsHMsRbrlFnYgp6iDzQQ8kEzQdP1sOd+
 6E9qmnQo0xtMsIthSQRtUxN8JfTzFXVi1w0Q3N6PI4zlmXQan+kJQvxkml3Qbu17iGXO
 3E27tibW5ccWJv7rDxBhZDeH1ujTvxhzZ6YRva7RHDMHTx8/lUPR08NdKv84cgJ2aFoC
 e7UsZM41yT68XGtf4Zp6pLrUGtv3tk9mKUkPZYggCp8/q6wLCeKaHiRBEdsQ//Xbunr6
 YiCw1DU9Ly360CyQ66vvML8KjVrLFhWAhHLXgR9tarG3CZIpVsYy0rrdwZzCHd2WV0pB
 OYWQ==
X-Gm-Message-State: AOAM5322+lv+8SHSEe++oOF4J3Y3s1EfPa3kiM9FXm1UE7+A+MyQBbnL
 cAu4q9DJzdSopN5qKM4DILAf6TuH5NMn9IRM17I0uouocj0mFTZQn5qs9HAyKYgYms3QBh9ahJU
 GVeyOD1pa6q3hs+Y=
X-Received: by 2002:a1c:2087:: with SMTP id g129mr2415211wmg.158.1604465496085; 
 Tue, 03 Nov 2020 20:51:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJysWBFSIyYKEG6jpUrYK3pJvYS/CVP/UTpks7SE+B5QQz0HFn48HRexZm4r80M/85++NR9M2Q==
X-Received: by 2002:a1c:2087:: with SMTP id g129mr2415197wmg.158.1604465495929; 
 Tue, 03 Nov 2020 20:51:35 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id c2sm793532wmf.47.2020.11.03.20.51.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:35 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 19/38] memory: Add interface to set iommu page size mask
Message-ID: <20201104044937.226370-20-mst@redhat.com>
References: <20201104044937.226370-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104044937.226370-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 00:03:41
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>, Peter Xu <peterx@redhat.com>,
 Eric Auger <eric.auger@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Bharat Bhushan <bbhushan2@marvell.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Allow to set the page size mask supported by an iommu memory region.
This enables a vIOMMU to communicate the page size granule supported by
an assigned device, on hosts that use page sizes greater than 4kB.

Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-8-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/exec/memory.h | 38 ++++++++++++++++++++++++++++++++++++++
 softmmu/memory.c      | 13 +++++++++++++
 2 files changed, 51 insertions(+)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index aff6ef7605..0f3e6bcd5e 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -397,6 +397,32 @@ struct IOMMUMemoryRegionClass {
      * @iommu: the IOMMUMemoryRegion
      */
     int (*num_indexes)(IOMMUMemoryRegion *iommu);
+
+    /**
+     * @iommu_set_page_size_mask:
+     *
+     * Restrict the page size mask that can be supported with a given IOMMU
+     * memory region. Used for example to propagate host physical IOMMU page
+     * size mask limitations to the virtual IOMMU.
+     *
+     * Optional method: if this method is not provided, then the default global
+     * page mask is used.
+     *
+     * @iommu: the IOMMUMemoryRegion
+     *
+     * @page_size_mask: a bitmask of supported page sizes. At least one bit,
+     * representing the smallest page size, must be set. Additional set bits
+     * represent supported block sizes. For example a host physical IOMMU that
+     * uses page tables with a page size of 4kB, and supports 2MB and 4GB
+     * blocks, will set mask 0x40201000. A granule of 4kB with indiscriminate
+     * block sizes is specified with mask 0xfffffffffffff000.
+     *
+     * Returns 0 on success, or a negative error. In case of failure, the error
+     * object must be created.
+     */
+     int (*iommu_set_page_size_mask)(IOMMUMemoryRegion *iommu,
+                                     uint64_t page_size_mask,
+                                     Error **errp);
 };
 
 typedef struct CoalescedMemoryRange CoalescedMemoryRange;
@@ -1409,6 +1435,18 @@ int memory_region_iommu_attrs_to_index(IOMMUMemoryRegion *iommu_mr,
  */
 int memory_region_iommu_num_indexes(IOMMUMemoryRegion *iommu_mr);
 
+/**
+ * memory_region_iommu_set_page_size_mask: set the supported page
+ * sizes for a given IOMMU memory region
+ *
+ * @iommu_mr: IOMMU memory region
+ * @page_size_mask: supported page size mask
+ * @errp: pointer to Error*, to store an error if it happens.
+ */
+int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
+                                           uint64_t page_size_mask,
+                                           Error **errp);
+
 /**
  * memory_region_name: get a memory region's name
  *
diff --git a/softmmu/memory.c b/softmmu/memory.c
index 21d533d8ed..71951fe4dc 100644
--- a/softmmu/memory.c
+++ b/softmmu/memory.c
@@ -1841,6 +1841,19 @@ static int memory_region_update_iommu_notify_flags(IOMMUMemoryRegion *iommu_mr,
     return ret;
 }
 
+int memory_region_iommu_set_page_size_mask(IOMMUMemoryRegion *iommu_mr,
+                                           uint64_t page_size_mask,
+                                           Error **errp)
+{
+    IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_GET_CLASS(iommu_mr);
+    int ret = 0;
+
+    if (imrc->iommu_set_page_size_mask) {
+        ret = imrc->iommu_set_page_size_mask(iommu_mr, page_size_mask, errp);
+    }
+    return ret;
+}
+
 int memory_region_register_iommu_notifier(MemoryRegion *mr,
                                           IOMMUNotifier *n, Error **errp)
 {
-- 
MST


