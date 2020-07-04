Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5A0C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:42:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08A7520747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:42:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RoUKcmhs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08A7520747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn7C-0007f0-8r
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:42:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40022)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwA-0004kt-6H
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34437
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmw8-0001fy-Ec
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:30:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tXbtGjuArFU0L6axuc9oufytf20N/xVITacNIR/IrnQ=;
 b=RoUKcmhsRME2O4bQGE91dEOBu0dtnB1X6ppyzUjpqSbwBskFBxGyNZBe6RmvNJEQZwsG/C
 2plvaR42ehBN7yQW7+THzZEic4n6UMjAxm6xVDT0uFKlzyJfRNMhC6OxImpz/fNjxnZ2RH
 xUAf0nATo1xThFZ1nxCeaGQmmQRv0tI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-317-kscUJR0WPdyyLSGoAdDuhQ-1; Sat, 04 Jul 2020 14:30:50 -0400
X-MC-Unique: kscUJR0WPdyyLSGoAdDuhQ-1
Received: by mail-wm1-f70.google.com with SMTP id b13so38188537wme.9
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tXbtGjuArFU0L6axuc9oufytf20N/xVITacNIR/IrnQ=;
 b=luv+J1hUyPwGEr2QQArNyxQE/tKd6vsuWFbSXWqnBM2/X7A8C+pTWhhI3GmmiThsni
 kL013wVN05bm9BAIzVgINXiRaSlWbuu8/SbvcUSsC8EatR+DkJV68rp7XMO8QUzekIO5
 y/WuNS8oB8bSGzT/7u8BiAgTsTVwRmlYmdC1zd6RuGUwJX33klKLCYLqJYz9m5wPU6V4
 YNoEBv68badf0YCdGdHmFGUbBochmOjamZ1UfqcNVxzaZD8H6hUyAvaAhwm4M5ZQ83u/
 YF1VizybDbxnpshbLoJu5d2SCUXpV3bgl8B5EvlGdnFV3VIbKr37Pw49MVT45E6Bh+YF
 Cp5w==
X-Gm-Message-State: AOAM5319z2Ir/x+6/m6yEI0TcfZXbp3BSX26mtRetdfG/9FaIqwGjOhp
 kX0FkF9r7ZXaU6a/Qlq5uVU+e8uB734ufw+nF+ZCdj5Hv7saLdr48ZUFGDswdDdI/OYcrdkEqWz
 JaBAK6uzh/4LfB/c=
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr41976162wme.160.1593887448647; 
 Sat, 04 Jul 2020 11:30:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxBuKGuxEfeLC/H05GRf+YECK74aXaYEnnZhF3ewyvZp9MlDzVRN9tfs2+FSdSz14sfgSFA4A==
X-Received: by 2002:a1c:9d07:: with SMTP id g7mr41976153wme.160.1593887448518; 
 Sat, 04 Jul 2020 11:30:48 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 q5sm8115508wrp.60.2020.07.04.11.30.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:48 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 32/41] vhost: check the existence of vhost_set_iotlb_callback
Message-ID: <20200704182750.1088103-33-mst@redhat.com>
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
Received-SPF: pass client-ip=207.211.31.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:14
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

From: Jason Wang <jasowang@redhat.com>

Add the check of vhost_set_iotlb_callback
before calling

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-6-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 5fd25fe520..10304b583e 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1686,8 +1686,9 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
         }
     }
 
-    if (vhost_dev_has_iommu(hdev)) {
-        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
+    if (vhost_dev_has_iommu(hdev) &&
+        hdev->vhost_ops->vhost_set_iotlb_callback) {
+            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
 
         /* Update used ring information for IOTLB to work correctly,
          * vhost-kernel code requires for this.*/
@@ -1730,7 +1731,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
     }
 
     if (vhost_dev_has_iommu(hdev)) {
-        hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+        if (hdev->vhost_ops->vhost_set_iotlb_callback) {
+            hdev->vhost_ops->vhost_set_iotlb_callback(hdev, false);
+        }
         memory_listener_unregister(&hdev->iommu_listener);
     }
     vhost_log_put(hdev, true);
-- 
MST


