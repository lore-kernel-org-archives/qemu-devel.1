Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597E6C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:59:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2ECCC20702
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 14:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BdtAKQdL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECCC20702
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeCh-0003rH-Ca
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 10:59:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqeBR-0002aN-Ni
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:57:57 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:45235
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqeBQ-0007lM-1p
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 10:57:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZesxalmhCuhZ6jk8xrSJ4YUFbv16yFo2IwkNdXZRec=;
 b=BdtAKQdLoLu0XgFhtJD0BBGWfSO3LXzktmJH+WujHZqNlHMmO3nR+sVCmXz82wmSVDt0Pr
 6bIsQs/pgAhASkBrVTucqWbig7Ku27GAOCFh7J0Miqp+uyEj9YISYx0JtttuSHAJss51op
 MLCJ1plv9+rEPdsWCLyENThtVLIl9Lw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-18-xaMy-i3PM0aAduXHaX6xlA-1; Wed, 01 Jul 2020 10:57:49 -0400
X-MC-Unique: xaMy-i3PM0aAduXHaX6xlA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 701D81005513;
 Wed,  1 Jul 2020 14:57:46 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0DA4A73FC5;
 Wed,  1 Jul 2020 14:57:27 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v4 04/14] virtio-pci: implement queue_enabled method
Date: Wed,  1 Jul 2020 22:55:28 +0800
Message-Id: <20200701145538.22333-5-lulu@redhat.com>
In-Reply-To: <20200701145538.22333-1-lulu@redhat.com>
References: <20200701145538.22333-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
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
Cc: mhabets@solarflare.com, qemu-devel@nongnu.org, rob.miller@broadcom.com,
 saugatm@xilinx.com, lulu@redhat.com, hanand@xilinx.com, hch@infradead.org,
 eperezma@redhat.com, jgg@mellanox.com, shahafs@mellanox.com,
 kevin.tian@intel.com, parav@mellanox.com, vmireyno@marvell.com,
 cunming.liang@intel.com, gdawar@xilinx.com, jiri@mellanox.com,
 xiao.w.wang@intel.com, stefanha@redhat.com, zhihong.wang@intel.com,
 aadam@redhat.com, rdunlap@infradead.org, maxime.coquelin@redhat.com,
 lingshan.zhu@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

With version 1, we can detect whether a queue is enabled via
queue_enabled.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/virtio-pci.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/hw/virtio/virtio-pci.c b/hw/virtio/virtio-pci.c
index 7bc8c1c056..8554cf2a03 100644
--- a/hw/virtio/virtio-pci.c
+++ b/hw/virtio/virtio-pci.c
@@ -1107,6 +1107,18 @@ static AddressSpace *virtio_pci_get_dma_as(DeviceState *d)
     return pci_get_address_space(dev);
 }
 
+static bool virtio_pci_queue_enabled(DeviceState *d, int n)
+{
+    VirtIOPCIProxy *proxy = VIRTIO_PCI(d);
+    VirtIODevice *vdev = virtio_bus_get_device(&proxy->bus);
+
+    if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
+        return proxy->vqs[vdev->queue_sel].enabled;
+    }
+
+    return virtio_queue_enabled(vdev, n);
+}
+
 static int virtio_pci_add_mem_cap(VirtIOPCIProxy *proxy,
                                    struct virtio_pci_cap *cap)
 {
@@ -2064,6 +2076,7 @@ static void virtio_pci_bus_class_init(ObjectClass *klass, void *data)
     k->ioeventfd_enabled = virtio_pci_ioeventfd_enabled;
     k->ioeventfd_assign = virtio_pci_ioeventfd_assign;
     k->get_dma_as = virtio_pci_get_dma_as;
+    k->queue_enabled = virtio_pci_queue_enabled;
 }
 
 static const TypeInfo virtio_pci_bus_info = {
-- 
2.21.1


