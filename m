Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 438E1C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A54BA207F7
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:34:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bx2r1afU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A54BA207F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNA9D-0001bP-N7
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:34:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9x3-0002qH-PI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60295)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kN9x1-0001bB-K9
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:21:29 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364087;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QGEKUXK8Ua+eb00vBAjJ3dQj8Co+dbRWsNgAI1iqUvA=;
 b=Bx2r1afUSNgmL/HeAkpayWYZXAe6yje5Yz715OcOXGscBvvGWSenAjDQit2xaeODSHIr9T
 26OO7J+2nPBXDDLSHXd0ZHkoxL4ntLtzUKLl3Z72DK4ajk5e3Oow0zPFEnyejEuHrIXacd
 mOPwR9VUSyuxXu0J2LQQ7hAwgTl2scU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-527-ZMQvi_pTO6KU44nDIjDM-g-1; Tue, 29 Sep 2020 03:21:24 -0400
X-MC-Unique: ZMQvi_pTO6KU44nDIjDM-g-1
Received: by mail-wr1-f69.google.com with SMTP id g6so1375287wrv.3
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:21:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=QGEKUXK8Ua+eb00vBAjJ3dQj8Co+dbRWsNgAI1iqUvA=;
 b=Ugjhi6C+dZXmDReCjoyiYHi4FXMiCP0HA7IRscP4FmMdKXfXF3Bm/UX1ZaRhsBQdg8
 Te2rM32A4NA4PHamoDY4LyUyaRK+eWjNEJ8Dc5TDEr9Owi3XEby0v4GBWb+yMNv5lYLU
 EoFyUeT5wnTYrNJGMumr3vT/areJfzeYAp+0/dOXJoLrvYEmUN2MTcYpGfSfgLJTyO1f
 i1DzQqsVrbQ8bpk8gB3KhH1D1cNHapoOe192ts0944GDPgDVaSv92Q2qUNk9Wa8M7wWH
 xz2TCkATCfvAjESkmtg39P27XylZcyh3iDaFIEY6/LSBw1rh2B9z5wfD7TNFYR6qdpFq
 Y9hw==
X-Gm-Message-State: AOAM530y3wHiTd8NIxfUQjSH73vX3WaubWVVRIRYsQmLDfoH3BBK6Nnh
 wdf+tpnmgwu4KmL6IKHClHVKmSnJmjSFn30hf5ZDuJJh3a9FPJOCSAeXiKATq5CSxzFp9EbF2Ku
 xbwwcqKEXNiwzjjA=
X-Received: by 2002:a05:600c:22d2:: with SMTP id
 18mr2815479wmg.145.1601364083096; 
 Tue, 29 Sep 2020 00:21:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw0D/0f+slEw7fZfoa7tvO1mjRj2B5kNz4tJmAQkgs7Wn4UNshq1/unqaEX8zmKRTw3aWLN+A==
X-Received: by 2002:a05:600c:22d2:: with SMTP id
 18mr2815465wmg.145.1601364082890; 
 Tue, 29 Sep 2020 00:21:22 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id 91sm4917714wrq.9.2020.09.29.00.21.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:21:22 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:21:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 11/48] virtio-iommu-pci: force virtio version 1
Message-ID: <20200929071948.281157-12-mst@redhat.com>
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


