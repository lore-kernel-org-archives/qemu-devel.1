Return-Path: <SRS0=2IDT=CR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2CFC433E2
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:34:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB88C2137B
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2020 19:34:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="elr1elKG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB88C2137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFjNr-00069R-Nf
	for qemu-devel@archiver.kernel.org; Tue, 08 Sep 2020 15:34:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kFjMw-0004xN-8p
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:33:30 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:56141
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1kFjMu-0000SJ-OA
 for qemu-devel@nongnu.org; Tue, 08 Sep 2020 15:33:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599593607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+59cI4E9/qIJU5u488kXPTd+uOKa1mqmTgdzUsZCitU=;
 b=elr1elKGDA2hiBSLD0VBO7hT8M+rhiNWVu3Im1s6LndmtzlwdvUnpW9ZDhZ4MzyFPGUwxz
 JBeb8+dH/46vInxgdv2HkThvl6eapDR4W5f1CCZbFPLmvjb2ObL82dKzxa/m/GdJAn+sQ4
 Ul59yzq29C7Ojv+JJwQCWzMBx+Za+xY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-254-E-uZKU8KPfSAl-v56ycrSg-1; Tue, 08 Sep 2020 15:33:26 -0400
X-MC-Unique: E-uZKU8KPfSAl-v56ycrSg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 438AF1DDEF;
 Tue,  8 Sep 2020 19:33:25 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-115-123.ams2.redhat.com [10.36.115.123])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 56A7F9CBA;
 Tue,  8 Sep 2020 19:33:23 +0000 (UTC)
From: Eric Auger <eric.auger@redhat.com>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, qemu-devel@nongnu.org,
 cohuck@redhat.com, mst@redhat.com, qemu-stable@nongnu.org
Subject: [PATCH v2 2/2] virtio-iommu-pci: force virtio version 1
Date: Tue,  8 Sep 2020 21:33:09 +0200
Message-Id: <20200908193309.20569-3-eric.auger@redhat.com>
In-Reply-To: <20200908193309.20569-1-eric.auger@redhat.com>
References: <20200908193309.20569-1-eric.auger@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eric.auger@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/08 02:10:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: jean-philippe@linaro.org, thuth@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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

---
v1 -> v2:
- Added Connie's R-b
---
 hw/virtio/virtio-iommu-pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/virtio-iommu-pci.c b/hw/virtio/virtio-iommu-pci.c
index ba62d60a0a..3b6f7a11c6 100644
--- a/hw/virtio/virtio-iommu-pci.c
+++ b/hw/virtio/virtio-iommu-pci.c
@@ -68,6 +68,7 @@ static void virtio_iommu_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     object_property_set_link(OBJECT(dev), "primary-bus",
                              OBJECT(pci_get_bus(&vpci_dev->pci_dev)),
                              &error_abort);
+    virtio_pci_force_virtio_1(vpci_dev);
     qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
@@ -97,7 +98,6 @@ static void virtio_iommu_pci_instance_init(Object *obj)
 static const VirtioPCIDeviceTypeInfo virtio_iommu_pci_info = {
     .base_name             = TYPE_VIRTIO_IOMMU_PCI,
     .generic_name          = "virtio-iommu-pci",
-    .transitional_name     = "virtio-iommu-pci-transitional",
     .non_transitional_name = "virtio-iommu-pci-non-transitional",
     .instance_size = sizeof(VirtIOIOMMUPCI),
     .instance_init = virtio_iommu_pci_instance_init,
-- 
2.21.3


