Return-Path: <SRS0=nn+c=C3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588FBC43464
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:23:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9B7C2388B
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Sep 2020 15:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NeZVnsIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9B7C2388B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44278 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJIEE-00005t-Mr
	for qemu-devel@archiver.kernel.org; Fri, 18 Sep 2020 11:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47526)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHyD-0006fv-Dl
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51484)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kJHyA-0000ah-NI
 for qemu-devel@nongnu.org; Fri, 18 Sep 2020 11:06:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600441596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGEKUXK8Ua+eb00vBAjJ3dQj8Co+dbRWsNgAI1iqUvA=;
 b=NeZVnsIrpnP/XQWRYJ1xHWrZXKpZH+so6cYyMl2fZ+1txseg1Wo3gsDVcKjS+CKR7O/u+2
 Tb1OBaoP11LSn3dFN6HFfU+qwrgCkELxEHmsaPj88kXJpUIGC3A3Uct/4gxGzkrh2sg4Ie
 WA0A7OCGp12WCpX5yyTii3KqpJqlWIw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-38-bm7ZJQf7POyMs3VSJQNITQ-1; Fri, 18 Sep 2020 11:06:34 -0400
X-MC-Unique: bm7ZJQf7POyMs3VSJQNITQ-1
Received: by mail-wm1-f71.google.com with SMTP id a7so2171438wmc.2
 for <qemu-devel@nongnu.org>; Fri, 18 Sep 2020 08:06:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QGEKUXK8Ua+eb00vBAjJ3dQj8Co+dbRWsNgAI1iqUvA=;
 b=rlyvz7IMz3zcCRXBTOO+eANg0IEIRycBWwEkH8ilIzDvEsCxJh/TivzB30TX5mkCRt
 Dap6ay7BPS8FWn9y6M3hnVQYl3/3kDV7oorVzemiAcGprCGrcNiautnAzVioYhiDOBZm
 sdD7dpcaCwoZU0TTwSefYl3cLg0O3RNacy4diqu5MPzEGPMrOGhU4tguajaIp/p8D5fI
 TpuHSxIc27ixb4TbdhFctm6KHH8g5O48U0+vSLNMuvTBA+UpxEkK/cQKJas8gBvoTV2K
 NKSYy31VBR25tS+9nHi9dVGUdrPXnhFiXkTEgDnb5LOwbKo/u/EA3u4OWk7/x1kPhhu8
 4A7w==
X-Gm-Message-State: AOAM530fHkUrRlg1ed8bAxAZainGSru3edxwWKV/yk0ETRewiCv2pjbN
 2rspDyeBJJJwFpuTJaiuP0D5KYLlsinSdKa2ZTn1IainySnp0hOcnzMj+25EMPGlodn3YzHEZj6
 d3SKDprWFO/9Lw/0=
X-Received: by 2002:a1c:c2c6:: with SMTP id
 s189mr16051077wmf.146.1600441592404; 
 Fri, 18 Sep 2020 08:06:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzAEOS/BBEWrJMYQOiz2DkCRKhUo5RxBL81EK1YAj3GfFxLw58Rgfxlr9Xapd149ErFZQ6SJw==
X-Received: by 2002:a1c:c2c6:: with SMTP id
 s189mr16051058wmf.146.1600441592234; 
 Fri, 18 Sep 2020 08:06:32 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id i16sm5638753wrq.73.2020.09.18.08.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2020 08:06:31 -0700 (PDT)
Date: Fri, 18 Sep 2020 11:06:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/15] virtio-iommu-pci: force virtio version 1
Message-ID: <20200918150506.286890-16-mst@redhat.com>
References: <20200918150506.286890-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200918150506.286890-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/18 00:20:40
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>,
 qemu-stable@nongnu.org, Eric Auger <eric.auger@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Eric Auger <eric.auger@redhat.com>

Commit 9b3a35ec82 ("virtio: verify that legacy support is not
accidentally on") added a safety check that requires to set
'disable-legacy=on' on virtio-iommu-pci:

qemu-system-aarch64: -device virtio-iommu-pci: device is modern-only,
use disable-legacy=on

virtio-iommu was introduced after the release of VIRTIO 1.0
specifications, so it should be 'modern-only'.

This patch forces virtio version 1 and removes the 'transitional_name'
property removing the need to specify 'disable-legacy=on' on
virtio-iommu-pci device.

Cc: qemu-stable@nongnu.org
Signed-off-by: Eric Auger <eric.auger@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>

Message-Id: <20200908193309.20569-3-eric.auger@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/virtio-iommu-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index 76540e57b1..378f63b210 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -69,6 +69,7 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     object_property_set_link(OBJECT(dev), "primary-bus",
                              OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
                              &error_abort);
+    virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
@@ -98,7 +99,6 @@ static void virtio_iommu_pci_instance_init(Object *obj)
 static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
     .base_name             = TYPE_VIRTIO_IOMMU_PCI,
     .generic_name          = "virtio-iommu-pci",
-    .transitional_name     = "virtio-iommu-pci-transitional",
     .non_transitional_name = "virtio-iommu-pci-non-transitional",
     .instance_size = sizeof(VirtIOIOMMUPCI),
     .instance_init = virtio_iommu_pci_instance_init,
-- 
MST


