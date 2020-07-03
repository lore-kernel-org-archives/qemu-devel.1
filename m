Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64603C433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:18:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E8DA20836
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 09:18:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gCrlKEeg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E8DA20836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56796 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrHqP-0004iZ-FX
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 05:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHd5-00015l-Sc
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:07 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55550
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrHd4-0004bi-7t
 for qemu-devel@nongnu.org; Fri, 03 Jul 2020 05:05:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593767105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WXw9VMdMEtGhEWjld76yv/MTPIVm1m5S/D9V6O7qby8=;
 b=gCrlKEegnx9a1QfYol3Mw/yI/PJGkqU2nZFQE0OGro6OaPVyzQwzGWxozEA68FXCIBtETY
 hNscuc+XrGjqVj2BP4kRIhSSNw4kB+xMwcF3ZUzSMg9lsCjkI7TQAgJORW28OSnYd6sMH7
 C2byOwNf0gasy86shmmOdyVEd/IRy+0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-178-k56v560xOQaC4XH4_FmF5w-1; Fri, 03 Jul 2020 05:05:03 -0400
X-MC-Unique: k56v560xOQaC4XH4_FmF5w-1
Received: by mail-wr1-f72.google.com with SMTP id o25so31021611wro.16
 for <qemu-devel@nongnu.org>; Fri, 03 Jul 2020 02:05:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=WXw9VMdMEtGhEWjld76yv/MTPIVm1m5S/D9V6O7qby8=;
 b=cU5cWk/8IRtGhSTIqvJ1BdDiIH9yUnPiOlPgkvtpT1cQTrIzLG1EQLHoCxgHAtnT6i
 t3CfIyzOVrSpRnTivL7v5vc79psjUzSS7g/GkH0gjiWcf+LPjKmza0DBZRTXR4cdgdez
 X2ZjCvHtLylersIHvabCtKq2ZGrthhYM32gTKhAuI3hhkapnpM55DYh4oUsI8WY2xlA4
 +rSGx7G/GuKmVdLgiCQOtNTE0Sj8GAZBD+zxHy8BaPYTch+hRk+a2GKWMd8WP8a0g3nt
 6MXHYiJMMifBJ2ApnXD7ZzA2ebW5ypDvsgsxejOhcRzRU6QdTGRCwWlbxjb5ULasvG08
 z5uw==
X-Gm-Message-State: AOAM533KeoVYfVnBwmMfGDkHKXRMBOpxl6DeDq8A/2r88MX7merrHwhZ
 Jou/UqfRK6XQIV8aUO9uKNZJB6jmvSdPsiIjWnoIQaYhdXbYbaYg4p1gckPWBEEYx/vRo2Zexe6
 56lokCuENS3Yn6mU=
X-Received: by 2002:a5d:4751:: with SMTP id o17mr11948189wrs.345.1593767102457; 
 Fri, 03 Jul 2020 02:05:02 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzPEHcRrWOVqdpTOOiVsH6IspwJ2fyFXiaqK05R5HzNSazW2jxfT2SklWqKUuspvWQ0vZ3G9Q==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr11948177wrs.345.1593767102331; 
 Fri, 03 Jul 2020 02:05:02 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 2sm12493814wmo.44.2020.07.03.02.05.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Jul 2020 02:05:01 -0700 (PDT)
Date: Fri, 3 Jul 2020 05:05:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 34/41] vhost: implement vhost_dev_start method
Message-ID: <20200703090252.368694-35-mst@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 03:38:32
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

use the vhost_dev_start callback to send the status to backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-8-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 10304b583e..32809e54b5 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -1685,7 +1685,12 @@ int vhost_dev_start(struct vhost_dev *hdev, VirtIODevice *vdev)
             goto fail_log;
         }
     }
-
+    if (hdev->vhost_ops->vhost_dev_start) {
+        r = hdev->vhost_ops->vhost_dev_start(hdev, true);
+        if (r) {
+            goto fail_log;
+        }
+    }
     if (vhost_dev_has_iommu(hdev) &&
         hdev->vhost_ops->vhost_set_iotlb_callback) {
             hdev->vhost_ops->vhost_set_iotlb_callback(hdev, true);
@@ -1723,6 +1728,9 @@ void vhost_dev_stop(struct vhost_dev *hdev, VirtIODevice *vdev)
     /* should only be called after backend is connected */
     assert(hdev->vhost_ops);
 
+    if (hdev->vhost_ops->vhost_dev_start) {
+        hdev->vhost_ops->vhost_dev_start(hdev, false);
+    }
     for (i = 0; i < hdev->nvqs; ++i) {
         vhost_virtqueue_stop(hdev,
                              vdev,
-- 
MST


