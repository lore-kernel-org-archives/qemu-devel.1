Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1455C433E2
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:50:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2724C20768
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:50:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Azqu/qlR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2724C20768
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37840 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEir-0001ub-7H
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:50:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54212)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFEiD-00014H-4A
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:49:25 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:57020
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFEiB-0005Za-C5
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599475762;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BvulEHqay9wA5dsX54rFHJ+xBQUVLlTyV6TCxPMHgz4=;
 b=Azqu/qlRCw7XcgKyPXHSPAOTCOCFNZK6Y9jnu8gU1Xt3im3/IkCFsopjVvDlEcrQtobHuq
 bgzhOkwwQrdiui3aiz64CFAR4HRS/hTMTSiWXWx/YK3QhF6O+XJ6h6Tvcq+HsrG35rjmcH
 hlpTaTgZQVnXb6JWGe6ufkEfX2ldYNg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-8tb6Vb7UO6imPWlqSq0zmQ-1; Mon, 07 Sep 2020 06:49:20 -0400
X-MC-Unique: 8tb6Vb7UO6imPWlqSq0zmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC9DA1007466;
 Mon,  7 Sep 2020 10:49:19 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-108.pek2.redhat.com [10.72.12.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id A2CF910013C4;
 Mon,  7 Sep 2020 10:49:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 3/3] vhost-vdpa: batch updating IOTLB mappings
Date: Mon,  7 Sep 2020 18:49:03 +0800
Message-Id: <20200907104903.31551-4-jasowang@redhat.com>
In-Reply-To: <20200907104903.31551-1-jasowang@redhat.com>
References: <20200907104903.31551-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/06 22:29:02
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: elic@nvidia.com, Jason Wang <jasowang@redhat.com>, lulu@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To speed up the memory mapping updating between vhost-vDPA and vDPA
device driver, this patch passes the IOTLB batching flags via IOTLB
API. Two new flags was introduced, VHOST_IOTLB_BATCH_BEGIN is a hint
that a bathced IOTLB updating may be initiated from the
userspace. VHOST_IOTLB_BATCH_END is a hint that userspace has finished
the updating:

VHOST_IOTLB_BATCH_BEGIN
VHOST_IOTLB_UPDATE/VHOST_IOTLB_INVALIDATE
...
VHOST_IOTLB_BATCH_END

Vhost-vDPA can then know that all mappings has been set and can do
optimization like passing all the mappings to the vDPA device driver.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/virtio/vhost-vdpa.c         | 66 ++++++++++++++++++++++++++++++++++
 include/hw/virtio/vhost-vdpa.h |  1 +
 2 files changed, 67 insertions(+)

diff --git a/hw/virtio/vhost-vdpa.c b/hw/virtio/vhost-vdpa.c
index 4580f3efd8..ba1ae3ea44 100644
--- a/hw/virtio/vhost-vdpa.c
+++ b/hw/virtio/vhost-vdpa.c
@@ -78,6 +78,46 @@ static int vhost_vdpa_dma_unmap(struct vhost_vdpa *v, hwaddr iova,
     return ret;
 }
 
+static void vhost_vdpa_listener_begin(MemoryListener *listener)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    struct vhost_dev *dev = v->dev;
+    struct vhost_msg_v2 msg;
+    int fd = v->device_fd;
+
+    if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
+        return;
+    }
+
+    msg.type = v->msg_type;
+    msg.iotlb.type = VHOST_IOTLB_BATCH_BEGIN;
+
+    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
+        error_report("failed to write, fd=%d, errno=%d (%s)",
+                     fd, errno, strerror(errno));
+    }
+}
+
+static void vhost_vdpa_listener_commit(MemoryListener *listener)
+{
+    struct vhost_vdpa *v = container_of(listener, struct vhost_vdpa, listener);
+    struct vhost_dev *dev = v->dev;
+    struct vhost_msg_v2 msg;
+    int fd = v->device_fd;
+
+    if (!(dev->backend_cap & (0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH))) {
+        return;
+    }
+
+    msg.type = v->msg_type;
+    msg.iotlb.type = VHOST_IOTLB_BATCH_END;
+
+    if (write(fd, &msg, sizeof(msg)) != sizeof(msg)) {
+        error_report("failed to write, fd=%d, errno=%d (%s)",
+                     fd, errno, strerror(errno));
+    }
+}
+
 static void vhost_vdpa_listener_region_add(MemoryListener *listener,
                                            MemoryRegionSection *section)
 {
@@ -191,6 +231,8 @@ static void vhost_vdpa_listener_region_del(MemoryListener *listener,
  * depends on the addnop().
  */
 static const MemoryListener vhost_vdpa_memory_listener = {
+    .begin = vhost_vdpa_listener_begin,
+    .commit = vhost_vdpa_listener_commit,
     .region_add = vhost_vdpa_listener_region_add,
     .region_del = vhost_vdpa_listener_region_del,
 };
@@ -226,6 +268,7 @@ static int vhost_vdpa_init(struct vhost_dev *dev, void *opaque)
     assert(dev->vhost_ops->backend_type == VHOST_BACKEND_TYPE_VDPA);
 
     v = opaque;
+    v->dev = dev;
     dev->opaque =  opaque ;
     vhost_vdpa_call(dev, VHOST_GET_FEATURES, &features);
     dev->backend_features = features;
@@ -280,6 +323,28 @@ static int vhost_vdpa_set_features(struct vhost_dev *dev,
     return !(status & VIRTIO_CONFIG_S_FEATURES_OK);
 }
 
+static int vhost_vdpa_set_backend_cap(struct vhost_dev *dev)
+{
+    uint64_t features;
+    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2 |
+        0x1ULL << VHOST_BACKEND_F_IOTLB_BATCH;
+    int r;
+
+    if (vhost_vdpa_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
+        return 0;
+    }
+
+    features &= f;
+    r = vhost_vdpa_call(dev, VHOST_SET_BACKEND_FEATURES, &features);
+    if (r) {
+        return 0;
+    }
+
+    dev->backend_cap = features;
+
+    return 0;
+}
+
 int vhost_vdpa_get_device_id(struct vhost_dev *dev,
                                    uint32_t *device_id)
 {
@@ -452,6 +517,7 @@ const VhostOps vdpa_ops = {
         .vhost_set_vring_kick = vhost_vdpa_set_vring_kick,
         .vhost_set_vring_call = vhost_vdpa_set_vring_call,
         .vhost_get_features = vhost_vdpa_get_features,
+        .vhost_set_backend_cap = vhost_vdpa_set_backend_cap,
         .vhost_set_owner = vhost_vdpa_set_owner,
         .vhost_set_vring_endian = NULL,
         .vhost_backend_memslots_limit = vhost_vdpa_memslots_limit,
diff --git a/include/hw/virtio/vhost-vdpa.h b/include/hw/virtio/vhost-vdpa.h
index 6455663388..9b81a409da 100644
--- a/include/hw/virtio/vhost-vdpa.h
+++ b/include/hw/virtio/vhost-vdpa.h
@@ -18,6 +18,7 @@ typedef struct vhost_vdpa {
     int device_fd;
     uint32_t msg_type;
     MemoryListener listener;
+    struct vhost_dev *dev;
 } VhostVDPA;
 
 extern AddressSpace address_space_memory;
-- 
2.20.1


