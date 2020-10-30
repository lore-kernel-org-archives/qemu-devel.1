Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF73DC4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:09:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A66C206E5
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:09:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vU4qTx3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A66C206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48866 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYYps-0001N5-U3
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmp-00058l-Kj
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:05 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:36204)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1kYYmd-0004p4-E4
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:06:01 -0400
Received: by mail-wm1-x343.google.com with SMTP id e2so3756362wme.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Mw5vfUgd3GO54+QgLOqJSliaESKLNNhHaEh4i2r3qrc=;
 b=vU4qTx3GvdgOkCNTIIx8G8HEwOfAcbWYzevJTZmgD3BOBeKslRw82JU1nDk02rEF+k
 ZYa5ClthndZBW++m6t8gDMRjsco/Zxyp/gt1ZRXF5cFikHjy8cz+Yk8FH9StNOHRlQrs
 fVX4MWIFxDgMi9tUOXfgF2xe+C8mBErSZnIOJ3axK1WGM4BwsyEYOlojI8xojTxFQ02J
 36EnOS3JX+rQbbbn/1528tC0zu21tLo2NqEp6k4/Ncwg7UDmQlcg0VbyJFzscTglU38k
 /qW5KQnwZwDfcOkjnL/EERo9EwxW93GohF/a8QQSbgRmp1EDXkSdjSRP8J9GRC4CKkLL
 YZ3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Mw5vfUgd3GO54+QgLOqJSliaESKLNNhHaEh4i2r3qrc=;
 b=gePScHTyP8XtJvjlPKAthhummKu0ULCAihhtdTmeWCFBdYN7tb2216AXnYMV1n6oER
 jUKN7fjAO1a28aGMhz2XJUu5x6iLtc2tQBMC+tJxUGy+m/BJb6gwWmoJVohLnpnokFXD
 RUy2g5KR6J8t9UJu7yOtyHygHgs1hkDDWMhKz05+TmFt3lzCR3uOXAdz5WQXxBEFG9HT
 m0ml6iVAuudjoycl6jYbvq8+WgyCxJW54hmKnWcme49pLPNbgD3iPnkYGMl/T7RtbPjh
 7G4sHq0qAZMf2YONNo+rX4xRN5BcCW7bIXfjW0ju/ZrmwO4PT4OUvROg+wka904Zi9Vf
 H24w==
X-Gm-Message-State: AOAM530NHaEao2iop8d71Ia2d/OCeAvpuHyDPpCRr7LdJhks2OdNVGQf
 LyTi9a+SRx3g9qnaSdDB3o+pAw==
X-Google-Smtp-Source: ABdhPJycaSUvMA0vq1XbEp92k9sEHPAbzzxILM/X75UZiZBl/B9AI8GhaB8Ui0Ahr43m9G5ZFwSM/g==
X-Received: by 2002:a7b:c00b:: with SMTP id c11mr4036924wmb.96.1604081148980; 
 Fri, 30 Oct 2020 11:05:48 -0700 (PDT)
Received: from localhost.localdomain
 ([2001:1715:4e26:a7e0:116c:c27a:3e7f:5eaf])
 by smtp.gmail.com with ESMTPSA id u3sm10044438wro.33.2020.10.30.11.05.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 11:05:48 -0700 (PDT)
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: eric.auger@redhat.com,
	alex.williamson@redhat.com
Subject: [PATCH v11 02/10] virtio-iommu: Store memory region in endpoint struct
Date: Fri, 30 Oct 2020 19:05:02 +0100
Message-Id: <20201030180510.747225-3-jean-philippe@linaro.org>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201030180510.747225-1-jean-philippe@linaro.org>
References: <20201030180510.747225-1-jean-philippe@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 qemu-devel@nongnu.org, peterx@redhat.com, pbonzini@redhat.com,
 bbhushan2@marvell.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Store the memory region associated to each endpoint into the endpoint
structure, to allow efficient memory notification on map/unmap.

Acked-by: Eric Auger <eric.auger@redhat.com>
Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
---
 hw/virtio/virtio-iommu.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu.c b/hw/virtio/virtio-iommu.c
index 4c8f3909b7d..a5c2d69aad6 100644
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
2.29.1


