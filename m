Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3482C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:49:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50D7F20782
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 18:49:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QSSLW0JQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50D7F20782
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaNqU-0003om-WD
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 13:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52422)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjS-00016X-E0
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23010)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kaNjP-00022Y-Vt
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 13:42:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604515323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tvJ0s3bSV9g9bsoYugn7fOSbhCEdSfwOqB79D2kkBqw=;
 b=QSSLW0JQcsLfV8t2b3++I3hq+uDC/IKOJKXXSda0HJaXrATW5hVFxLHzt3OUMY00WuHpST
 yqV7TvuwdxPZG5lW3RJ5K8Bvz9gKf1z6BL4s83ys9bwwjMri1ZYtBeaptT9fyOv0a3cvrW
 QOVvHa+drUCmXuhvo+o5hGvB1xrH0c8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-306-feUFggKJNGSwbSMd1jKBSA-1; Wed, 04 Nov 2020 13:42:01 -0500
X-MC-Unique: feUFggKJNGSwbSMd1jKBSA-1
Received: by mail-wr1-f72.google.com with SMTP id h8so9633889wrt.9
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 10:42:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tvJ0s3bSV9g9bsoYugn7fOSbhCEdSfwOqB79D2kkBqw=;
 b=lm9vumkS8YTvaYJ6kvp8vbkIbzCe7QT6Aag2kXzAg1WWyeloW30E6rDgj7urmCCBJq
 tQwVE5LBIEe1UG9wHtBxQA0I/caxoP0j1mbfMlVUd6ifvPq0s55DC9MgIVwzwxlRuqlq
 u6SSDOfSOD0Wtugji8i41Kfn1UoNDVFg6fIGECaWw2DFjbE6IiVkN5VuNdj4bO5mUXHu
 M+vhPqtOqimNBd7lZVfkA9Wcqgta/d/Ms+OnyPQ9UkSDv4sFSyFUE8r6Gw0S8lvBLvWq
 gHSI0ZchTPSc2EFn63DtXYJ0RVEp4RWESvPyQaZ4Hf9KSk3Lrf3k9xAuwuVxzBfObuVp
 lXdw==
X-Gm-Message-State: AOAM531ou/HpITKp4FDbHNYuuCYbqqoNPce06aBn5EAxxPWvsg00a69+
 coTfin80YKA/DZVEJOl6qFYI1rw1j+2pCjaYgBNS4R+q3wuGavJEogBg1koLvttoTOiO6W1Qov6
 l+PN+wtDVL9oyjwQ=
X-Received: by 2002:a05:6000:1109:: with SMTP id
 z9mr31002987wrw.388.1604515319654; 
 Wed, 04 Nov 2020 10:41:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwrm1KOqxxSjN6AM2Dx+GKzggLqagfQrZuTmNHgqNmliHhSVPKMUq4E0Ef8wPmqoAZG1Ed/mg==
X-Received: by 2002:a05:6000:1109:: with SMTP id
 z9mr31002970wrw.388.1604515319464; 
 Wed, 04 Nov 2020 10:41:59 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id z5sm3862094wrw.87.2020.11.04.10.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2020 10:41:58 -0800 (PST)
Date: Wed, 4 Nov 2020 13:41:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 14/31] virtio-iommu: Store memory region in endpoint struct
Message-ID: <20201104184040.285057-15-mst@redhat.com>
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


