Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10110C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:45:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 589C320780
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:45:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cZ3vF2HC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 589C320780
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNn7-00075K-3h
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:45:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52454)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjV-0001B0-AJ
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:54295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjT-00022q-3X
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2pTrzfIlEtuFgKli+YZx2cSmkYnPe9QRNfZXCU2zweM=;
 b=cZ3vF2HCKtQntqgCDd5vb+EWifsF0jNsCZ3AwB64ZufiSgPujdseq/0zE5A7hGko1vBMG6
 lIEF++iIjkxUWqnFjEaTITN0L2qYelrTDQDU5w5Qw3AUgtH7ClMsDA+wBfoOO5le1mn1nh
 WokKejqZrOimigG6e7zJ86HV0yv9MJQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-573-srUypeYDPhu4YyjNO7UwNQ-1; Wed, 04 Nov 2020 13:42:04 -0500
X-MC-Unique: srUypeYDPhu4YyjNO7UwNQ-1
Received: by mail-wm1-f69.google.com with SMTP id b68so935657wme.5
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=2pTrzfIlEtuFgKli+YZx2cSmkYnPe9QRNfZXCU2zweM=;
 b=Igyc8atdaKHHoOfvvpxg2Y5G0qSDQIYWncOMFyz8uvIKiRz4SpR4PiRqJ3A/sQuKyP
 dyAF6ROFWY2tIsFdCIq4/7nqU3A0oqg2nIJENEZ2hNXh0JrKNnlDYkO23noBsmuL4anV
 NFSh8kw06T2FINBcr/k0AaOOEixGauZz9kDMknM5Bo0h4FORCRIh1ePgmMrBobFdHYNY
 eVwOFKNtiOD4JIK+Xka8ZbbSVvnCqxSltBBpSBUfeY8h4HNm2MtEXQCK1IuqsQy+W9xg
 8Db3S8eDkv5pSIQKdllsxlkt9XrRNh/+Id2VPuiDn0ZwZ0jkVbLzAWXlj26uex/PD9pb
 xFtA==
X-Gm-Message-State: AOAM533eYAzBk5pRxTEjAAtF5OlFqA/rIO8ZVw35dzL7nafJ+andIs0L
 kZRyFyK/PynNtloAAHhjvzhgwbWcnVZyk5str+T3QQYi7vO1ghAt1BzXuwmy1rLOBOV2/wXGjLj
 +VE9QnUo7BxBQijc=
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr6130271wmg.18.1604515322415; 
 Wed, 04 Nov 2020 10:42:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx9alEUfDA2spCSmp2WbOKx3dYz18jI494EiudIwOA/3w9Ccp/B6z3/vUoruwqPU2EsQjclkQ==
X-Received: by 2002:a7b:cf1a:: with SMTP id l26mr6130253wmg.18.1604515322242; 
 Wed, 04 Nov 2020 10:42:02 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id 90sm3953924wrl.30.2020.11.04.10.42.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:01 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 15/31] virtio-iommu: Add memory notifiers for map/unmap
Message-ID: <20201104184040.285057-16-mst@redhat.com>
References: <20201104184040.285057-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20201104184040.285057-1-mst@redhat.com>
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


