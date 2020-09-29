Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3E3BC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:31:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45888207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GzK3+ECC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45888207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA6v-00071f-4M
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57380)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xO-0003Mi-G1
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:59095)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xI-0001dy-Jt
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:50 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X1yDyZXpOOWHIzToKkllj4/vreLm2qhWQ36IujdOoK4=;
 b=GzK3+ECCiz6+fSNxE6SmoYiMHK2aFxCCg2gwmWoMdOq2GEK6DccM+0W90Rid7Ax7cnQvGH
 t2Q0zznCOx4CauaL8310MPqDpzvyYCqLuQ/HZZEQ/3UMd6Ii9TFlIrWr8eUzi7o3IWec01
 xBFrdbzDEdClbQoT2D1zQzvkvv7sNIc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-d7Y8n_LcNbu46iElpzZk1w-1; Tue, 29 Sep 2020 03:21:41 -0400
X-MC-Unique: d7Y8n_LcNbu46iElpzZk1w-1
Received: by mail-wm1-f70.google.com with SMTP id b20so3037761wmj.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X1yDyZXpOOWHIzToKkllj4/vreLm2qhWQ36IujdOoK4=;
 b=fiLEyNlgblf8ntoPc4mw37w5Ajw4p71reNN64yy0KqANh/I2jpMZjjZaL2gRW6iKYU
 nfjADORhFnQLIthBrNoKbyfzRCHMPdwHl0/PX+zO1Z0bM+77QbSR0s+h1JxLzn7y3PUM
 qI69nB/w+7+HOwQ0BAdpx1ONAgbjfWpGkkDwMeWmNO3Mky4nmPSkTvJMgmWGSFdrOxkr
 hYJcJrw5ibqQhNnSEeDD1jt87Iw1aPBT9esBhYBV/8pPETKBN2WguTxACwg8rxEUKP+a
 zQ7b7jrDFAkQPqDJjOfmBFR9AaH34nIoxYgTAJa83a/+pFKfBSaOUgDigF7OEfGHMX8m
 44Jw==
X-Gm-Message-State: AOAM530Bum8wPqnIK89UelS9hkqkTDSjdtwgCXLcPmo8ObHqzTrAcJc4
 peEstpUDR5RlSXN6iwdF1ePKVBA9eAYGN9t8jLOQJu9Hk8NFs6KJFondPNmenBPTdzc8ip39dua
 gGtiva6mIfutjHEo=
X-Received: by 2002:a05:600c:24d:: with SMTP id
 13mr3051430wmj.86.1601364099924; 
 Tue, 29 Sep 2020 00:21:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVhUX72Ub6AhqW48ZVjgnWFDZr4wpJcWdx9C8pNrJH0aE6QPeEPw4FQHrXIPeo6yxy7+nIiQ==
X-Received: by 2002:a05:600c:24d:: with SMTP id
 13mr3051412wmj.86.1601364099719; 
 Tue, 29 Sep 2020 00:21:39 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id q68sm2035885wme.25.2020.09.29.00.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:39 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 17/48] vhost-vsock-pci: force virtio version 1
Message-ID: <20200929071948.281157-18-mst@redhat.com>
References: <20200929071948.281157-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200929071948.281157-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/28 22:47:55
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Qinghua Cheng <qcheng@redhat.com>,
 Qian Cai <caiqian@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 9b3a35ec82 ("virtio: verify that legacy support is not
accidentally on") added a safety check that requires to set
'disable-legacy=on' on vhost-vsock-pci device:

    $ ./qemu-system-x86_64 ... -device vhost-vsock-pci,guest-cid=5
        qemu-system-x86_64: -device vhost-vsock-pci,guest-cid=5:
        device is modern-only, use disable-legacy=on

virtio-vsock was introduced after the release of VIRTIO 1.0
specifications, so it should be 'modern-only'.
In addition Cornelia verified that forcing a legacy mode on
vhost-vsock-pci device using x86-64 host and s390x guest, so with
different endianness, produces strange behaviours.

This patch forces virtio version 1 and removes the 'transitional_name'
property removing the need to specify 'disable-legacy=on' on
vhost-vsock-pci device.

To avoid migration issues, we force virtio version 1 only when
legacy check is enabled in the new machine types (>= 5.1).

As the transitional device name is not commonly used, we do not
provide compatibility handling for it.

Cc: qemu-stable@nongnu.org
Reported-by: Qian Cai <caiqian@redhat.com>
Reported-by: Qinghua Cheng <qcheng@redhat.com>
Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1868449
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200921122506.82515-3-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-vsock-pci.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
index e56067b427..205da8d1f5 100644
--- a/hw/virtio/vhost-vsock-pci.c
+++ b/hw/virtio/vhost-vsock-pci.c
@@ -44,6 +44,15 @@ static void vhost_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
 {
     VHostVSockPCI *dev = VHOST_VSOCK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
+    VirtIODevice *virtio_dev = VIRTIO_DEVICE(vdev);
+
+    /*
+     * To avoid migration issues, we force virtio version 1 only when
+     * legacy check is enabled in the new machine types (>= 5.1).
+     */
+    if (!virtio_legacy_check_disabled(virtio_dev)) {
+        virtio_pci_force_virtio_1(vpci_dev);
+    }
 
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
@@ -73,7 +82,6 @@ static void vhost_vsock_pci_instance_init(Object *obj)
 static const VirtioPCIDeviceTypeInfo vhost_vsock_pci_info = {
     .base_name             = TYPE_VHOST_VSOCK_PCI,
     .generic_name          = "vhost-vsock-pci",
-    .transitional_name     = "vhost-vsock-pci-transitional",
     .non_transitional_name = "vhost-vsock-pci-non-transitional",
     .instance_size = sizeof(VHostVSockPCI),
     .instance_init = vhost_vsock_pci_instance_init,
-- 
MST


