Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CB5C4741F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10F6420782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DUDnYRb5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10F6420782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45220 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNqW-0003tC-S3
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:49:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjW-0001Ey-Qx
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59399)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjV-00024L-2i
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CO5kV6TOgl7VkllXO+Cj7QHVQ3FQj45OIYdaYC1hBZU=;
 b=DUDnYRb5dlNZEUo1kejlk8cKALQkv4EIJ/XM61VULaaDkssG1pGJZRFqujvzeYX9JJANHA
 dDiJpW+sRxt+8P0eb1LrB7OMig0nj3hVvvwdcJeKyL9ghdDs48GWLcYLS0MFxvWxJSLpI4
 VBWrKSids7I4xmt9+oivVXpcqgAFnn8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-aXbbKZ2lOfWTzlk-zCGouQ-1; Wed, 04 Nov 2020 13:42:06 -0500
X-MC-Unique: aXbbKZ2lOfWTzlk-zCGouQ-1
Received: by mail-wr1-f69.google.com with SMTP id i1so9580059wrb.18
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CO5kV6TOgl7VkllXO+Cj7QHVQ3FQj45OIYdaYC1hBZU=;
 b=md0nMy27Y6IjYzpvPLG6+U9sFZFg3/5p9nxdKv22NRrI0p+3JqXcmxmRlcXfTGTrKR
 ZSVN4Y/xZEsAQa3ehQv4TGcpaJNv3Tc1+cD9S2Vt3qz1LPgXXL51ED7N5+KY9rocYSk7
 gJpJBwUV1n+3wd2rN5+NwCOBYEWYhJwF5EBvCpHY095IxJxzstJ5q2aSqsdb3czAzxgo
 HQV06J0Jrel/4ZvXH/X9/HDBOHNoBRLKj7AZ+RcoSpJxk2TuEvkX1/W4w2t0/YWdTPkA
 PJ6CJqGmA8Sn1pJQv2TzKSwX1/YnPKoNJyxozTWI9IrRlr08PB1It1xCpKWCEGmbJ9Rc
 KtUQ==
X-Gm-Message-State: AOAM532rzNVAZSyG7mdPKlwr9qCjU4EWO19DbkYeTT60VLn8LScnEeKd
 ewLR7dn8GCV11gHBxKgXpVjoPt6oc3UIt5Tu05T7Qkm43iav+PbtD8SP9i7faqNmhflaDoL210t
 zRw4urVHGX+Q4oLA=
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr35830536wrt.175.1604515325236; 
 Wed, 04 Nov 2020 10:42:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz6Dy0F6GR6UnqLZn65rM3HddEm7KF9VRexPdu3AzmNkvreR//Gh71T88/RO8sqh10JPmWtog==
X-Received: by 2002:a5d:60c4:: with SMTP id x4mr35830517wrt.175.1604515325041; 
 Wed, 04 Nov 2020 10:42:05 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id l1sm4146616wrb.1.2020.11.04.10.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:42:04 -0800 (PST)
Date: Wed, 4 Nov 2020 13:42:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 16/31] virtio-iommu: Call memory notifiers in attach/detach
Message-ID: <20201104184040.285057-17-mst@redhat.com>
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
 Bharat Bhushan <bbhushan2@marvell.com>, Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Bharat Bhushan <bbhushan2@marvell.com>

Call the memory notifiers when attaching an endpoint to a domain, to
replay existing mappings, and when detaching the endpoint, to remove all
mappings.

Signed-off-by: Bharat Bhushan <bbhushan2@marvell.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-5-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 7dd15c5eac..7b64892351 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -170,11 +170,39 @@ static void virtio_iommu_notify_unmap(IOMMUMemoryRegion *mr, hwaddr virt_start,
     memory_region_notify_iommu(mr, 0, entry);
 }
 
+static gboolean virtio_iommu_notify_unmap_cb(gpointer key, gpointer value,
+                                             gpointer data)
+{
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_unmap(mr, interval->low, interval->high);
+
+    return false;
+}
+
+static gboolean virtio_iommu_notify_map_cb(gpointer key, gpointer value,
+                                           gpointer data)
+{
+    VirtIOIOMMUMapping *mapping = (VirtIOIOMMUMapping *) value;
+    VirtIOIOMMUInterval *interval = (VirtIOIOMMUInterval *) key;
+    IOMMUMemoryRegion *mr = (IOMMUMemoryRegion *) data;
+
+    virtio_iommu_notify_map(mr, interval->low, interval->high,
+                            mapping->phys_addr, mapping->flags);
+
+    return false;
+}
+
 static void virtio_iommu_detach_endpoint_from_domain(VirtIOIOMMUEndpoint *ep)
 {
+    VirtIOIOMMUDomain *domain = ep->domain;
+
     if (!ep->domain) {
         return;
     }
+    g_tree_foreach(domain->mappings, virtio_iommu_notify_unmap_cb,
+                   ep->iommu_mr);
     QLIST_REMOVE(ep, next);
     ep->domain = NULL;
 }
@@ -317,6 +345,10 @@ static int virtio_iommu_attach(VirtIOIOMMU *s,
 
     ep->domain = domain;
 
+    /* Replay domain mappings on the associated memory region */
+    g_tree_foreach(domain->mappings, virtio_iommu_notify_map_cb,
+                   ep->iommu_mr);
+
     return VIRTIO_IOMMU_S_OK;
 }
 
-- 
MST


