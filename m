Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C051C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:45:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67C4A20771
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:45:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DqsPYe1p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67C4A20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35168 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrnAB-0006AH-Nt
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:45:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40118)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwR-0005Nl-TM
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:11 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:47218
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwQ-0001iG-0G
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bXQcnI6PvYNrc0EdCBus9d90Kc/4/S8iNwGC64RK2O8=;
 b=DqsPYe1pGOWsxNUlZTDqpfhKfgg0LLFvRX5aXHgpXSqAGAJLffJs/07QrQt7/zYjILPeop
 kquk4RsTqnaD3S5mqcqbgMjtZ8BSetTnkFOy1/x5rGMeECFBJif2pRfwCms5ozdDUVQime
 /bp6yaOL9lEDNx5G7kq+2Kt55ugK/7A=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-TQuGDHkIPA2ACPiEORkUFA-1; Sat, 04 Jul 2020 14:31:04 -0400
X-MC-Unique: TQuGDHkIPA2ACPiEORkUFA-1
Received: by mail-wr1-f70.google.com with SMTP id b14so36495575wrp.0
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bXQcnI6PvYNrc0EdCBus9d90Kc/4/S8iNwGC64RK2O8=;
 b=V9626T96YR6r/CbrPNvh5uLzOnuBoVlzlMlwDrSe2EWMAviWLG3BweP8KQWJVIpU5/
 RUHenAlgEpkwXJD6kR1Q/JeWZPXVHSvlceR1QLSF/ueUYMIt8I9xXuYBqWL//ZTpYt8V
 Wpg99VfR1tcGiZ2wOvxCXJCbamW0qDdftUfqsliq5DIR/EoDOVrJ5rX6lENoVkZC1lAz
 isk4Fl0OLvph3R8JaqYYCS1FaZMr1VrZn5DCwAxXVpZWZTQsRTBKQfGodTMu3wtdTZhu
 2e9YYcfH6SrQ7XJRq5BpEXXy35NNHy48ZhJhUS09xH5XroGWWzV0TiiQIER2G+4uHvQ7
 c3sg==
X-Gm-Message-State: AOAM532mkRIJoqxCqmfA0K1rRAnqo0WpChWAR+M0zeYFNkvnBtWQntQJ
 CtQfj7Z7tk+CA7f/GHWjQfivuJWwUGsnmGueob0AlDa0L/4dvSY69LrPVn/8JYUf2zPHneYZuNg
 x1i4hW13S9K5pM5o=
X-Received: by 2002:a5d:6912:: with SMTP id t18mr41081832wru.411.1593887462976; 
 Sat, 04 Jul 2020 11:31:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyu/tTGeWJsYhj0Mcg34Kyyo5pdZZFzN1ONJp3PYv0w110/HS05zTw3svSK1EkwmbP5ZFIjxg==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr41081828wru.411.1593887462840; 
 Sat, 04 Jul 2020 11:31:02 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 u8sm17007683wrt.28.2020.07.04.11.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:31:02 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:31:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 38/41] vhost: implement vhost_force_iommu method
Message-ID: <20200704182750.1088103-39-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

use the vhost_force_iommu callback to force enable feature bit VIRTIO_F_IOMMU_PLATFORM

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-12-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 1e083a8976..1a1384e7a6 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -810,6 +810,11 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
     if (!vhost_dev_has_iommu(dev)) {
         features &= ~(0x1ULL << VIRTIO_F_IOMMU_PLATFORM);
     }
+    if (dev->vhost_ops->vhost_force_iommu) {
+        if (dev->vhost_ops->vhost_force_iommu(dev) == true) {
+            features |= 0x1ULL << VIRTIO_F_IOMMU_PLATFORM;
+       }
+    }
     r = dev->vhost_ops->vhost_set_features(dev, features);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_features failed");
-- 
MST


