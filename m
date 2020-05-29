Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 543B3C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:27:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCF22073B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:27:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F8Tc+b85"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCF22073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefzI-0006oF-Ai
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:27:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55270)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefhJ-0002xa-Ut
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:09:21 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:43331
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefhJ-0005PI-2y
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590761360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3shp0XrYaKpb9hMzB2A57hUh8YA904iG+XnZeberkms=;
 b=F8Tc+b8553pZkBazlPSFgW1x3miW/6whVtkdHwpMgVQbclpcENGfCK+YPafbvE+U26MMI4
 JD4YEE51MwEFIxPr+WOm1pDMsQYWn66iN+b7hTZ+Czpv107PEcDnnxydXXww1SDpuFaauI
 YxArhK53LyLewrYsSysmKemy+mk6NGo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-40-6vqfYBHnMPSWwvwsBr3REw-1; Fri, 29 May 2020 10:09:18 -0400
X-MC-Unique: 6vqfYBHnMPSWwvwsBr3REw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C60E1052512;
 Fri, 29 May 2020 14:09:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-84.pek2.redhat.com [10.72.13.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D46A55DA30;
 Fri, 29 May 2020 14:08:31 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v3 3/8] virtio-bus: introduce queue_enabled method
Date: Fri, 29 May 2020 22:06:15 +0800
Message-Id: <20200529140620.28759-4-lulu@redhat.com>
In-Reply-To: <20200529140620.28759-1-lulu@redhat.com>
References: <20200529140620.28759-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

This patch introduces queue_enabled() method which allows the
transport to implement its own way to report whether or not a queue is
enabled.

Signed-off-by: Jason Wang <jasowang@redhat.com>

0005-virtio-bus-introduce-queue_enabled-method.patch
---
 hw/virtio/virtio.c             | 6 ++++++
 include/hw/virtio/virtio-bus.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index b6c8ef5bc0..445a4ed760 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -3285,6 +3285,12 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
 
 bool virtio_queue_enabled(VirtIODevice *vdev, int n)
 {
+    BusState *qbus = qdev_get_parent_bus(DEVICE(vdev));
+    VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(qbus);
+
+    if (k->queue_enabled) {
+        return k->queue_enabled(qbus->parent, n);
+    }
     return virtio_queue_get_desc_addr(vdev, n) != 0;
 }
 
diff --git a/include/hw/virtio/virtio-bus.h b/include/hw/virtio/virtio-bus.h
index 38c9399cd4..0f6f215925 100644
--- a/include/hw/virtio/virtio-bus.h
+++ b/include/hw/virtio/virtio-bus.h
@@ -83,6 +83,10 @@ typedef struct VirtioBusClass {
      */
     int (*ioeventfd_assign)(DeviceState *d, EventNotifier *notifier,
                             int n, bool assign);
+    /*
+     * Whether queue number n is enabled.
+     */
+    bool (*queue_enabled)(DeviceState *d, int n);
     /*
      * Does the transport have variable vring alignment?
      * (ie can it ever call virtio_queue_set_align()?)
-- 
2.21.1


