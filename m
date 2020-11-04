Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE988C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:59:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DAB20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 04:59:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KAF3SUM+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DAB20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAt4-00013S-7H
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 23:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59326)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlj-00069j-5O
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:46171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAlg-0004aR-Ql
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pTrzfIlEtuFgKli+YZx2cSmkYnPe9QRNfZXCU2zweM=;
 b=KAF3SUM+RpNMMtQvX4DxqwELOj6AiaB69aT96A7moLUkoouIuKV9mfRxjTc9faZ1VPbmlP
 hkLfpPkXUb0rLmvczOhfrz/jALAOMuu3mziGgSYgmRcL4mvylHLb12HbjSwZxGJdv0OAoe
 4qCVk9LpXcFWgaJ19JVgd4J992YspF8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-W2bCENTVN12aa6GuU-eHLw-1; Tue, 03 Nov 2020 23:51:27 -0500
X-MC-Unique: W2bCENTVN12aa6GuU-eHLw-1
Received: by mail-wm1-f69.google.com with SMTP id u207so735580wmu.4
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2pTrzfIlEtuFgKli+YZx2cSmkYnPe9QRNfZXCU2zweM=;
 b=l2LugV5Yj+4tFMMQVrmAtA9xxR6+1aTQEk39KtXcuyE96i5lE100M9tpobijxXJvuS
 c+TuOJ5Kt24w9AOrvInPDzK8LRm5QEN72s8jkVMOHSy/o2vlCiXqpbyJ8DZ+IQdvbnX2
 k9YPctqF+juvAEbzJQP2fNxoH4AdqpAXbroefMjKuO1HhaVcGGrKMVsWCDOOH9Uu3o2N
 /d5WV9iBLizZaXXSuBZ/70p5yuRtoL6qfy6W5fij02QSvAWJJzZX5BHM194MNlrAb+Qw
 Dx1lrcTxZCvkAwKHvUByC0c9vzU2P15EUoCC4UcdpTl7l5cIqSmjtkVU8CqLDa7SfQQi
 8NYQ==
X-Gm-Message-State: AOAM533R/qWwBMr2zfZIW6HMFp75hJ8nhIxNubotCC6ZRSkTB9/ZeaaZ
 S18ow94n/b2hyM8CHA02TPQUhtYTAQncIUiC78gcjNbQXqmaTQOcyJ72bQSCe4XSS/kWWTME6N3
 5kQrU1l07TdakuPI=
X-Received: by 2002:a1c:5585:: with SMTP id j127mr2555723wmb.90.1604465485508; 
 Tue, 03 Nov 2020 20:51:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxAqMzYKxy7CXs0nvHxEwzZ34mDQojQEUVKk00cMP7QX/YZ5G5HwEjnbS8aSVR+x3dAc3tuag==
X-Received: by 2002:a1c:5585:: with SMTP id j127mr2555712wmb.90.1604465485359; 
 Tue, 03 Nov 2020 20:51:25 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z11sm848463wrr.66.2020.11.03.20.51.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:24 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 15/38] virtio-iommu: Add memory notifiers for map/unmap
Message-ID: <20201104044937.226370-16-mst@redhat.com>
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
Received-SPF: pass client-ip=63.128.21.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 22:09:52
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Bharat Bhushan <bbhushan2@marvell.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Extend VIRTIO_IOMMU_T_MAP/UNMAP request to notify memory listeners. It
will call VFIO notifier to map/unmap regions in the physical IOMMU.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-4-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 56 ++++++++++++++++++++++++++++++++++++++++
 hw/virtio/trace-events   |  2 ++
 2 files changed, 58 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index a5c2d69aad..7dd15c5eac 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -125,6 +125,51 @@ static gint interval_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     }
 }
 
+static void virtio_iommu_notify_map(IOMMUMemoryRegion *mr, hwaddr virt_start,
+                                    hwaddr virt_end, hwaddr paddr,
+                                    uint32_t flags)
+{
+    IOMMUTLBEntry entry;
+    IOMMUAccessFlags perm = IOMMU_ACCESS_FLAG(flags & VIRTIO_IOMMU_MAP_F_READ,
+                                              flags & VIRTIO_IOMMU_MAP_F_WRITE);
+
+    if (!(mr->iommu_notify_flags & IOMMU_NOTIFIER_MAP) ||
+        (flags & VIRTIO_IOMMU_MAP_F_MMIO) || !perm) {
+        return;
+    }
+
+    trace_virtio_iommu_notify_map(mr->parent_obj.name, virt_start, virt_end,
+                                  paddr, perm);
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = virt_end - virt_start;
+    entry.iova = virt_start;
+    entry.perm = perm;
+    entry.translated_addr = paddr;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
+static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr virt_start,
+                                      hwaddr virt_end)
+{
+    IOMMUTLBEntry entry;
+
+    if (!(mr->iommu_notify_flags & IOMMU_NOTIFIER_UNMAP)) {
+        return;
+    }
+
+    trace_virtio_iommu_notify_unmap(mr->parent_obj.name, virt_start, virt_end);
+
+    entry.target_as = &address_space_memory;
+    entry.addr_mask = virt_end - virt_start;
+    entry.iova = virt_start;
+    entry.perm = IOMMU_NONE;
+    entry.translated_addr = 0;
+
+    memory_region_notify_iommu(mr, 0, entry);
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
 {
     if (!ep->domain) {
@@ -315,6 +360,7 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
     VirtIOIOMMUDomain *domain;
     VirtIOIOMMUInterval *interval;
     VirtIOIOMMUMapping *mapping;
+    VirtIOIOMMUEndpoint *ep;
 
     if (flags & ~VIRTIO_IOMMU_MAP_F_MASK) {
         return VIRTIO_IOMMU_S_INVAL;
@@ -344,6 +390,11 @@ static int virtio_iommu_map(VirtIOIOMMU *s,
 
     g_tree_insert(domain->mappings, interval, mapping);
 
+    QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+        virtio_iommu_notify_map(ep->iommu_mr, virt_start, virt_end, phys_start,
+                                flags);
+    }
+
     return VIRTIO_IOMMU_S_OK;
 }
 
@@ -356,6 +407,7 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
     VirtIOIOMMUMapping *iter_val;
     VirtIOIOMMUInterval interval, *iter_key;
     VirtIOIOMMUDomain *domain;
+    VirtIOIOMMUEndpoint *ep;
     int ret = VIRTIO_IOMMU_S_OK;
 
     trace_virtio_iommu_unmap(domain_id, virt_start, virt_end);
@@ -373,6 +425,10 @@ static int virtio_iommu_unmap(VirtIOIOMMU *s,
         uint64_t current_high = iter_key->high;
 
         if (interval.low <= current_low && interval.high >= current_high) {
+            QLIST_FOREACH(ep, &domain->endpoint_list, next) {
+                virtio_iommu_notify_unmap(ep->iommu_mr, current_low,
+                                          current_high);
+            }
             g_tree_remove(domain->mappings, iter_key);
             trace_virtio_iommu_unmap_done(domain_id, current_low, current_high);
         } else {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index cf1e59de30..b87a397406 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -106,6 +106,8 @@ virtio_iommu_put_domain(uint32_t domain_id) "Free domain=%d"
 virtio_iommu_translate_out(uint64_t virt_addr, uint64_t phys_addr, uint32_t sid) "0x%"PRIx64" -> 0x%"PRIx64 " for sid=%d"
 virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uint64_t addr) "FAULT reason=%d flags=%d endpoint=%d address =0x%"PRIx64
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
+virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
+virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
MST


