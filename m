Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6210FC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:00:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83C420BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:00:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HlmwABTD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83C420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaAub-0004VQ-RD
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:00:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59348)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAln-0006IY-1z
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58515)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAll-0004co-6m
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:51:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465496;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vj2K5KfIjYgXaS/HA+9u99+5hxZOJUDzQMD8f8h61Sg=;
 b=HlmwABTDthLEqCT869/1qGu6+AMdLu5w8QWyXI1abwOWBp9g52QB+TZeGQXsH7x7pvbUnE
 VuphOymjRSGIIyB3SXyPHSx00G5gysBxCesuDNm8b9EpioKjmL0YBHMTrVzbLtP0ZIKBSv
 oKHwcTD3QPYP4ybygHiFUQGQCUXWNIQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-TdhQxQgjO5OcY40vAajX4Q-1; Tue, 03 Nov 2020 23:51:32 -0500
X-MC-Unique: TdhQxQgjO5OcY40vAajX4Q-1
Received: by mail-wm1-f72.google.com with SMTP id y187so737355wmy.3
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Vj2K5KfIjYgXaS/HA+9u99+5hxZOJUDzQMD8f8h61Sg=;
 b=ZmEwzvM+k+CJ0x35EJ5ftw37qZsGWYuItBFV/1rkJLJIcLCHzuBiOHWysZ0O+TPwUj
 P/hXo1/qZZyvcbyMcbV/rYN6EyAl07Slx/PwcPMxzf8ytkMDS9ZgTmDdHF70e/jwByW6
 r845aocyYhq8WdT1D30srM6bZNb1Wf6MpcWFNTMCyYG5XbaoHvPp8sT2qaOAVl4Ud8r2
 gE0tCesPAyc+EHck4TaXjp7A9gqfFWZLfZIfRz6HvNNS6tCQlF7Q0INCcHU5rY0yAVTG
 br7G2ipJkVqH5tNA1/4HXwhMLgLIjkwGaux/oJ44j2hmuhh4hbbk3VmYO20AUrx6j6j+
 bz5Q==
X-Gm-Message-State: AOAM533s0LJfKAxGkgrVdKBr5U/KP/aXIjg7hAWLNgrHZVXk1HAkX/5B
 ZEiGHxqcwEAc+MqdQyPHssqDRnHFoyDwDRaQ3nqyL3IpmSG5uNTYymhECJTKEqwmN4qt5fK83Qd
 ERGxnCNyGKBwCg7A=
X-Received: by 2002:adf:e351:: with SMTP id n17mr4770347wrj.308.1604465490689; 
 Tue, 03 Nov 2020 20:51:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+DQZnCtkejDjT38+1iy7yd8lYE/5YTyRA9Bs3ELkJ8Cm7dS4QCEHKCn7g1Ae6g2LFg/6r5A==
X-Received: by 2002:adf:e351:: with SMTP id n17mr4770338wrj.308.1604465490569; 
 Tue, 03 Nov 2020 20:51:30 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id l16sm895622wrx.5.2020.11.03.20.51.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:29 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 17/38] virtio-iommu: Add replay() memory region callback
Message-ID: <20201104044937.226370-18-mst@redhat.com>
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
 Bharat Bhushan <bbhushan2@marvell.com>, Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Implement the replay callback to setup all mappings for a new memory
region.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-6-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/virtio/trace-events   |  1 +
 2 files changed, 41 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7b64892351..985257c88f 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -847,6 +847,45 @@ static gint int_cmp(gconstpointer a, gconstpointer b, gpointer user_data)
     return (ua > ub) - (ua < ub);
 }
 
+static gboolean virtio_iommu_remap(gpointer key, gpointer value, gpointer data)
+{
+    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    trace_virtio_iommu_remap(mr->parent_obj.name, interval->low, interval->high,
+                             mapping->phys_addr);
+    virtio_iommu_notify_map(mr, interval->low, interval->high,
+                            mapping->phys_addr, mapping->flags);
+    return false;
+}
+
+static void virtio_iommu_replay(IOMMUMemoryRegion *mr, IOMMUNotifier *n)
+{
+    IOMMUDevice *sdev = container_of(mr, IOMMUDevice, iommu_mr);
+    VirtIOIOMMU *s = sdev->viommu;
+    uint32_t sid;
+    VirtIOIOMMUEndpoint *ep;
+
+    sid = virtio_iommu_get_bdf(sdev);
+
+    qemu_mutex_lock(&s->mutex);
+
+    if (!s->endpoints) {
+        goto unlock;
+    }
+
+    ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(sid));
+    if (!ep || !ep->domain) {
+        goto unlock;
+    }
+
+    g_tree_foreach(ep->domain->mappings, virtio_iommu_remap, mr);
+
+unlock:
+    qemu_mutex_unlock(&s->mutex);
+}
+
 static void virtio_iommu_device_realize(DeviceState *dev, Error **errp)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
@@ -1076,6 +1115,7 @@ static void virtio_iommu_memory_region_class_init(ObjectClass *klass,
     IOMMUMemoryRegionClass *imrc = IOMMU_MEMORY_REGION_CLASS(klass);
 
     imrc->translate = virtio_iommu_translate;
+    imrc->replay = virtio_iommu_replay;
 }
 
 static const TypeInfo virtio_iommu_info = {
diff --git a/hw/virtio/trace-events b/hw/virtio/trace-events
index b87a397406..ea3c3b25ad 100644
--- a/hw/virtio/trace-events
+++ b/hw/virtio/trace-events
@@ -108,6 +108,7 @@ virtio_iommu_report_fault(uint8_t reason, uint32_t flags, uint32_t endpoint, uin
 virtio_iommu_fill_resv_property(uint32_t devid, uint8_t subtype, uint64_t start, uint64_t end) "dev= %d, type=%d start=0x%"PRIx64" end=0x%"PRIx64
 virtio_iommu_notify_map(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start, uint32_t flags) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64" flags=%d"
 virtio_iommu_notify_unmap(const char *name, uint64_t virt_start, uint64_t virt_end) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64
+virtio_iommu_remap(const char *name, uint64_t virt_start, uint64_t virt_end, uint64_t phys_start) "mr=%s virt_start=0x%"PRIx64" virt_end=0x%"PRIx64" phys_start=0x%"PRIx64
 
 # virtio-mem.c
 virtio_mem_send_response(uint16_t type) "type=%" PRIu16
-- 
MST


