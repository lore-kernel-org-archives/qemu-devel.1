Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19832C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:22:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A903320723
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FreYzMVf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A903320723
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHuH-0003Wu-Uc
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:22:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60922)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHfx-0007XD-41
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:05 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49476
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHfv-00055Z-Bt
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:08:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767282;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bXQcnI6PvYNrc0EdCBus9d90Kc/4/S8iNwGC64RK2O8=;
 b=FreYzMVfiSPcuR9AKj79AzKVKaMjSdErfa3yiGtBIknN6lyO+04pTOSRbOJF2QCGhkrpkC
 xkZTcXwWyTw3jNvIKRlas8UYTk/2JHrEdlMM5cWP6ED5RsrjOgzsbOrVWbhRXIaurHvTmg
 aWOaZFatbz8BGkcN9u6zNnWgwte1Ys0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-484-wLrpC6gKMPuH8GvHWPUkRg-1; Fri, 03 Jul 2020 05:05:13 -0400
X-MC-Unique: wLrpC6gKMPuH8GvHWPUkRg-1
Received: by mail-wm1-f72.google.com with SMTP id q20so24627333wme.3
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:05:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=bXQcnI6PvYNrc0EdCBus9d90Kc/4/S8iNwGC64RK2O8=;
 b=KYUsEPpURYEl1kxDCRnH8i8sU2XYDGtgo5IyB51Itm7+HI2XTdyeoHOcrNmq8vpTnb
 uewUhOuhZxWPtB8zNQ4PHdwLfWRzkX9VG85GlZsXedXL/VsSi2pXnP6wNPmp5cUVQ8Hy
 in1y5aXmE4nF66WRUnzJ9DxnghYoneLlhiJv75Y7nA6LufAFnCgVicDdGxKZv0jHse/5
 Pp3Tb9jvFnP4d9AqfHAkyzLwjZ+qrFOPHiG8KkQ8oxwITdIguxNyH/LTqFQKCiLZoBGP
 i93FaeKG3XoT6xWP82P+b6EoXgjuCMhaqEUQjZbbQX9O8dCz1WxCRLCzbGarqZgjybTS
 TaNQ==
X-Gm-Message-State: AOAM531Tg1H/kSQu7r132vAaIHQYjOjSUaN3pYkUZV/W/UELWJc9mDcH
 D2GXSHifBwDacQlLzaihs6RPGgUuprV1vCqinwf0uZWHr5yLwfll9/q4ybeu/hfyeXMFJ4Yh+EV
 QYH2w9AbGy4PT1m8=
X-Received: by 2002:a1c:1d93:: with SMTP id d141mr34477670wmd.14.1593767112055; 
 Fri, 03 Jul 2020 02:05:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxjpIdA3ZkX/TFOS5m4p7ZaCtC7ekXX+GbpvZSRjFZ+gORBbA3NkH+D1dza128U1TOjWm1J+Q==
X-Received: by 2002:a1c:1d93:: with SMTP id d141mr34477653wmd.14.1593767111833; 
 Fri, 03 Jul 2020 02:05:11 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 d63sm13641669wmc.22.2020.07.03.02.05.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:05:11 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:05:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 38/41] vhost: implement vhost_force_iommu method
Message-ID: <20200703090252.368694-39-mst@redhat.com>
References: <20200703090252.368694-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200703090252.368694-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 02:53:25
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


