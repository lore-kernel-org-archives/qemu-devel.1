Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C5BC4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5667E207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WNrxndPX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5667E207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA9r-0002Vj-DO
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:34:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57432)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xR-0003Q1-3M
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9xO-0001eL-5D
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:52 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a786MUSR1WUsxT6yLnmGt75QDVKzHhELF+cVxNM9LLE=;
 b=WNrxndPXHsKLi4N5FlDLwFpeQ4LX78DIpghfSx6GdHRMisN+miXdEDa/zPOKII2/AtTcC+
 Xryp2D9wVuO3xfqmB90Fbt0tsIiYH9HqkQjM7uj2nUpqoMnUjuFdzvSTNurr4K2Mrd0Mc+
 g0YQuU4u18O+MblfqJAwEJDJzKQvdGI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-145-iFwJ4_ClNZe3B_2032DZsA-1; Tue, 29 Sep 2020 03:21:44 -0400
X-MC-Unique: iFwJ4_ClNZe3B_2032DZsA-1
Received: by mail-wr1-f71.google.com with SMTP id b2so1353390wrs.7
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=a786MUSR1WUsxT6yLnmGt75QDVKzHhELF+cVxNM9LLE=;
 b=NX+ZsJHRvyF5e9r0kjSoTP9dNlCQIxcMq0fe8vm9+gUrm1c4eUVXDSExEl5FW5/ttQ
 pmNIHkT0oPQp2/vj8wrkkGb4HnOhee1reuxH8LRvnOnfMBi1bklOI2Z8wv6kaT7DyZ7J
 N1dUPuvJ5uYgL3mVwJyEiMvMH2FxRFhHOLpYn+WVcxXSolZ2JwnN+6gXYwTk8I3gyRyT
 hvtuRPnLE4DHX8wL5tF7HXOoBL95179PS/Buw3FhbGYUVOSFFXvfO3eFwZ6QctEQD9pI
 Z4xdFBGEcHLbYtkibjL/nxXDrEo9tB7Ut5qVbywMbShIx3KRlB9MmgyvnGCCUxMXFGTT
 niDQ==
X-Gm-Message-State: AOAM533kKbfCXqOasmBg0FFkQHX/AYiq7nLdDhwzUcCbLt0hPQd62dcR
 yOOtfCyjDU/IKABHw7Etriw/wUOqYJM1qcO4fFNnrQnxbLVD29MyX8HvmI3jNeTsGgXkW9u4SKy
 KZLMcyoNj+ACOgaY=
X-Received: by 2002:adf:e84a:: with SMTP id d10mr2739238wrn.66.1601364102775; 
 Tue, 29 Sep 2020 00:21:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy4Ly6oaV6foSvnNnH2TrkXm0O+KmWY5MpbF5572KH/vwGLIdQI3ZIpT+YIOe2DtmFXyGHRsQ==
X-Received: by 2002:adf:e84a:: with SMTP id d10mr2739217wrn.66.1601364102632; 
 Tue, 29 Sep 2020 00:21:42 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id e1sm4912033wrp.49.2020.09.29.00.21.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:42 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 18/48] vhost-user-vsock-pci: force virtio version 1
Message-ID: <20200929071948.281157-19-mst@redhat.com>
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
Received-SPF: pass client-ip=216.205.24.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/29 02:22:44
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Stefano Garzarella <sgarzare@redhat.com>

Commit 9b3a35ec82 ("virtio: verify that legacy support is not
accidentally on") added a safety check that requires to set
'disable-legacy=on' on vhost-user-vsock-pci device:

    $ ./qemu-system-x86_64 ... \
    -chardev socket,id=char0,reconnect=0,path=/tmp/vhost4.socket \
    -device vhost-user-vsock-pci,chardev=char0
        qemu-system-x86_64: -device vhost-user-vsock-pci,chardev=char0:
        device is modern-only, use disable-legacy=on

virtio-vsock was introduced after the release of VIRTIO 1.0
specifications, so it should be 'modern-only'.

This patch forces virtio version 1 and removes the 'transitional_name'
property, as done for vhost-vsock-pci, removing the need to specify
'disable-legacy=on' on vhost-user-vsock-pci device.

Cc: qemu-stable@nongnu.org
Suggested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20200921122506.82515-4-sgarzare@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-user-vsock-pci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-user-vsock-pci.c b/hw/virtio/vhost-user-vsock-pci.c
index 763f89984e..72a96199cd 100644
--- a/hw/virtio/vhost-user-vsock-pci.c
+++ b/hw/virtio/vhost-user-vsock-pci.c
@@ -41,6 +41,9 @@ static void vhost_user_vsock_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VHostUserVSockPCI *dev = VHOST_USER_VSOCK_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&dev->vdev);
 
+    /* unlike vhost-vsock, we do not need to care about pre-5.1 compat */
+    virtio_pci_force_virtio_1(vpci_dev);
+
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
@@ -69,7 +72,6 @@ static void vhost_user_vsock_pci_instance_init(Object *obj)
 static const VirtioPCIDeviceTypeInfo vhost_user_vsock_pci_info = {
     .base_name             = TYPE_VHOST_USER_VSOCK_PCI,
     .generic_name          = "vhost-user-vsock-pci",
-    .transitional_name     = "vhost-user-vsock-pci-transitional",
     .non_transitional_name = "vhost-user-vsock-pci-non-transitional",
     .instance_size = sizeof(VHostUserVSockPCI),
     .instance_init = vhost_user_vsock_pci_instance_init,
-- 
MST


