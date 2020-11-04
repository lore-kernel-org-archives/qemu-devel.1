Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BBBC2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:12:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99BEA20BED
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 05:12:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TRfWf/GV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99BEA20BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaB62-0003cR-Iu
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 00:12:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmR-0007MZ-8x
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:30074)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaAmO-0004ra-LT
 for qemu-devel@nongnu.org; Tue, 03 Nov 2020 23:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604465535;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvJ0s3bSV9g9bsoYugn7fOSbhCEdSfwOqB79D2kkBqw=;
 b=TRfWf/GVv5nWE4XMD5WGwt+C/uN7MQd5EhyCDN0nxc2vkJ4vIkrXn5vb0lkc7h4XciDFq5
 o1Q5m9RsUbyY6dhDn8Im+g2y/rMHN6eoMXNm8QFJpDEymSHegccamhEMwhXjbpi4zvImW5
 tdoKT3kWuzzpvMnQ7XiKl9B01aCHHIo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-3Ds83iu1MEq-Ii9swDu7qQ-1; Tue, 03 Nov 2020 23:51:24 -0500
X-MC-Unique: 3Ds83iu1MEq-Ii9swDu7qQ-1
Received: by mail-wr1-f69.google.com with SMTP id w3so6590919wrt.11
 for <qemu-devel@nongnu.org>; Tue, 03 Nov 2020 20:51:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tvJ0s3bSV9g9bsoYugn7fOSbhCEdSfwOqB79D2kkBqw=;
 b=gKcErJ+8xhNrwWR/u/v42mlQ5+AB8oQJSAOZFQwbiAiiFcAgaTakgQ3XF5b4JYPdn0
 0P9zhGBvlQypvX+L8vd/S1zAfWNHzaztVd9I3bryejaQwR1hJiIHPs32O2vf7z1GuZIb
 bZ/f64WRVIgZG9z614jX5XU+nKXn5F0ET6tvpNdtGQPU5nzq23ZCYpQZglrdJP+aoZaD
 w1naFOn3rb3yc3pNYgBLVPc2rWLPrem4QUEh0lE+fFaY4yeYqfHa2foI1fz3OLBvfqyo
 zcrm/muUDB2trHgwCwKTLTpdndGXEC3ixbkT1RUdseTuw+kPeNGpi9SNATxzIP5hiBqW
 BMwA==
X-Gm-Message-State: AOAM531xVfehDaxP9y65wmsz2UyQthgoyVvhdlKJXfZDcUCfy/OoohUr
 tnWv/dEpRa3bloIk61Qtn4NvXmA3tiJqXrR/Q2ae2jzDPc0V/qSwAtQXdWs6tsSMzI4TRTleVhl
 kX2zHZm64t766vZY=
X-Received: by 2002:adf:db44:: with SMTP id f4mr3881025wrj.168.1604465482931; 
 Tue, 03 Nov 2020 20:51:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxNJp6EN/fqDWKrMt2U0OWC0ot8m6MY3XbBQ0nz6vZ4E1EgHuzhN+O6RTQKMsZSdOwmIWvn5Q==
X-Received: by 2002:adf:db44:: with SMTP id f4mr3881011wrj.168.1604465482822; 
 Tue, 03 Nov 2020 20:51:22 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y187sm813239wmg.33.2020.11.03.20.51.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Nov 2020 20:51:22 -0800 (PST)
Date: Tue, 3 Nov 2020 23:51:20 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 14/38] virtio-iommu: Store memory region in endpoint struct
Message-ID: <20201104044937.226370-15-mst@redhat.com>
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
 Eric Auger <eric.auger@redhat.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jean-Philippe Brucker <jean-philippe@linaro.org>

Store the memory region associated to each endpoint into the endpoint
structure, to allow efficient memory notification on map/unmap.

Acked-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
Message-Id: <20201030180510.747225-3-jean-philippe@linaro.org>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4c8f3909b7..a5c2d69aad 100644
--- a/hw/virtio/virtio-iommu.c
+++ b/hw/virtio/virtio-iommu.c
@@ -49,6 +49,7 @@ typedef struct VirtIOIOMMUDomain {
 typedef struct VirtIOIOMMUEndpoint {
     uint32_t id;
     VirtIOIOMMUDomain *domain;
+    IOMMUMemoryRegion *iommu_mr;
     QLIST_ENTRY(VirtIOIOMMUEndpoint) next;
 } VirtIOIOMMUEndpoint;
 
@@ -137,16 +138,19 @@ static VirtIOIOMMUEndpoint *virtio_iommu_get_endpoint(VirtIOIOMMU *s,
                                                       uint32_t ep_id)
 {
     VirtIOIOMMUEndpoint *ep;
+    IOMMUMemoryRegion *mr;
 
     ep = g_tree_lookup(s->endpoints, GUINT_TO_POINTER(ep_id));
     if (ep) {
         return ep;
     }
-    if (!virtio_iommu_mr(s, ep_id)) {
+    mr = virtio_iommu_mr(s, ep_id);
+    if (!mr) {
         return NULL;
     }
     ep = g_malloc0(sizeof(*ep));
     ep->id = ep_id;
+    ep->iommu_mr = mr;
     trace_virtio_iommu_get_endpoint(ep_id);
     g_tree_insert(s->endpoints, GUINT_TO_POINTER(ep_id), ep);
     return ep;
@@ -910,9 +914,14 @@ static gboolean reconstruct_endpoints(gpointer key, gpointer value,
     VirtIOIOMMU *s = (VirtIOIOMMU *)data;
     VirtIOIOMMUDomain *d = (VirtIOIOMMUDomain *)value;
     VirtIOIOMMUEndpoint *iter;
+    IOMMUMemoryRegion *mr;
 
     QLIST_FOREACH(iter, &d->endpoint_list, next) {
+        mr = virtio_iommu_mr(s, iter->id);
+        assert(mr);
+
         iter->domain = d;
+        iter->iommu_mr = mr;
         g_tree_insert(s->endpoints, GUINT_TO_POINTER(iter->id), iter);
     }
     return false; /* continue the domain traversal */
-- 
MST


