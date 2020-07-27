Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECCBC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:59:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9334206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 11:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B3zH143O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9334206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52988 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k01nS-0007Ai-Vb
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 07:59:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59502)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1k01ms-0006lu-2R
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:59:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:29138
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1k01mq-0003DR-Gt
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 07:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595851159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Qt5Tb2HrcOv0LyaNKI1IabVKX75f/G4v4dtogCiKlIQ=;
 b=B3zH143Oth5neEQIBL73JeVhiHdLKTG/kYkUWqi9QxBBapWrhFR1GUuIs51OIMHq41NHAL
 lwaLynof0SCjFI8hc+U5VmxSR8IzKlNZcfY2u6lEKpFtWqUka+EZpOVotBlp/27/WoNZsE
 j62h36/TxtGjC4upRuMa5Lpg+mxnWMw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-109-g-tv4XWqMV2evDkAIN3CEg-1; Mon, 27 Jul 2020 07:59:17 -0400
X-MC-Unique: g-tv4XWqMV2evDkAIN3CEg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A92D818C63CE
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 11:59:16 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-48.ams2.redhat.com [10.36.114.48])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 75159712C2;
 Mon, 27 Jul 2020 11:59:07 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2] virtio-mem-pci: force virtio version 1
Date: Mon, 27 Jul 2020 13:59:05 +0200
Message-Id: <20200727115905.129397-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=david@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 03:37:14
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Trying to run simple virtio-mem-pci examples currently fails with
    qemu-system-x86_64: -device virtio-mem-pci,id=vm0,memdev=mem0,node=0,
    requested-size=300M: device is modern-only, use disable-legacy=on
due to the added safety checks in 9b3a35ec8236 ("virtio: verify that legacy
support is not accidentally on").

As noted by Conny, we have to force virtio version 1. While at it, use
qdev_realize() to set the parent bus and realize - like most other
virtio-*-pci implementations.

Fixes: 0b9a2443a48b ("virtio-pci: Proxy for virtio-mem")
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Cc: Cornelia Huck <cohuck@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 hw/virtio/virtio-mem-pci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/virtio/virtio-mem-pci.c b/hw/virtio/virtio-mem-pci.c
index d375280ee1..590cec041b 100644
--- a/hw/virtio/virtio-mem-pci.c
+++ b/hw/virtio/virtio-mem-pci.c
@@ -21,8 +21,8 @@ static void virtio_mem_pci_realize(VirtIOPCIProxy *vpci_dev, Error **errp)
     VirtIOMEMPCI *mem_pci = VIRTIO_MEM_PCI(vpci_dev);
     DeviceState *vdev = DEVICE(&mem_pci->vdev);
 
-    qdev_set_parent_bus(vdev, BUS(&vpci_dev->bus));
-    object_property_set_bool(OBJECT(vdev), "realized", true, errp);
+    virtio_pci_force_virtio_1(vpci_dev);
+    qdev_realize(vdev, BUS(&vpci_dev->bus), errp);
 }
 
 static void virtio_mem_pci_set_addr(MemoryDeviceState *md, uint64_t addr,
-- 
2.26.2


