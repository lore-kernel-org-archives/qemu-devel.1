Return-Path: <SRS0=IkQf=EJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47C05C2D0A3
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:47:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B914C2242C
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Nov 2020 14:47:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BEa0oNxD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B914C2242C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZxb3-0003DF-LQ
	for qemu-devel@archiver.kernel.org; Tue, 03 Nov 2020 09:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33168)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOc-0004Sp-Ex
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59244)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kZxOa-0006Sj-GC
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 09:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604414087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pTrzfIlEtuFgKli+YZx2cSmkYnPe9QRNfZXCU2zweM=;
 b=BEa0oNxDy6k8PCxfgx0Gdwef6wlTPJ9lyCnadc0SSpBtuGqW/kE0hS+TaxbOjZBx/ZGI9d
 PpKFF1WyerqJb+C2umxzjg+SdIUuws6l+dajMGVEqhBNZlRJrQXIkNDrPSiKpxFYc/SRM8
 vO7rF9ye3mWvovMZyheiLaC+97pIgIA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-kIHWBnKVOleuADpvZ2kHIA-1; Tue, 03 Nov 2020 09:34:44 -0500
X-MC-Unique: kIHWBnKVOleuADpvZ2kHIA-1
Received: by mail-wr1-f70.google.com with SMTP id t14so7948888wrs.2
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 06:34:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2pTrzfIlEtuFgKli+YZx2cSmkYnPe9QRNfZXCU2zweM=;
 b=Vbs69UYseOFYCQM5DMZnHoWxu5RR6L3/8pkaXGxKkTsh+P9ovpvIRJeoPL6380EJE4
 UxKmx+khai0Ufr9HQZxbbMBv8OPtCzvbU0h/iO/yCh7dCldEmX4Bf7Nx9epRmc6i66i9
 nXrxnhmbmaDjWOYxY16+Oek5laDtY9gEaHtD/NZ65nvKSFH1clny/2DTOb5tqGYKHWiZ
 mkoFpkvqBOT/yhE9JLNs+VFunzTeiqsJX0WvoHeYtqiWyyzSlL2HbfKW6Xq57y6YMcD6
 NtvnREw/ncssU7Kd2aESeANgXeabLym4OO8f3z9IWfh7qs1++Uaq1eQH+IfI/JgOdWTk
 47PA==
X-Gm-Message-State: AOAM530Iuuh2Km2PberKNX22zws0bc+pScN8Qj9N40D7VrVgBVqwvlhu
 9VPsS46lm5g/Iq7hVvf3z3gBy6XYuJQSLwPlmEorUu65hxuo28YgUZ4HxcpXrdy0vxIVDJEwQ4q
 NvqJNWRSWtVXtUKY=
X-Received: by 2002:a5d:5106:: with SMTP id s6mr25823728wrt.51.1604414082839; 
 Tue, 03 Nov 2020 06:34:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxEURiwTIaVPyJm6L/A8QQpo9yfQbld4Pda93fnz4ZnCdyHPXxk4NEGjhkQoUKSEsLRLZHiEg==
X-Received: by 2002:a5d:5106:: with SMTP id s6mr25823709wrt.51.1604414082595; 
 Tue, 03 Nov 2020 06:34:42 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id v19sm3011422wmj.31.2020.11.03.06.34.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 06:34:41 -0800 (PST)
Date: Tue, 3 Nov 2020 09:34:40 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/38] virtio-iommu: Add memory notifiers for map/unmap
Message-ID: <20201103142306.71782-16-mst@redhat.com>
References: <20201103142306.71782-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201103142306.71782-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/03 01:02:05
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


