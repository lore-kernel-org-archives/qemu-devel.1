Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 503CFC43464
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:34:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE93B20874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:34:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O9cpXkze"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE93B20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKK5t-00081f-P1
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:34:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK13-0002bd-Ak
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40705)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK11-0000f8-Br
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600687790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GXFOFA+oBpG8V2C34lkq5FMQCHgmci5cClagY+iuF1U=;
 b=O9cpXkzeaa5BF0fmdvEPpsrX4BwFfWw1Z3lfvIfYYgElz3QW7TCkZwGhiOzPOUgIdjCLUz
 7qMLUcNxDlHZ2fbjTyvI7N1rhqGiOwVGsZrIvSMaUF3NVJln3JL13Ue74rV15S/XYWE7WE
 EMRMSf586SMJqpjptDZ2bP14WjBQ5GE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-sX9q3ZvbO36GwUVOj-VtCg-1; Mon, 21 Sep 2020 07:29:48 -0400
X-MC-Unique: sX9q3ZvbO36GwUVOj-VtCg-1
Received: by mail-wr1-f71.google.com with SMTP id d9so5738016wrv.16
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GXFOFA+oBpG8V2C34lkq5FMQCHgmci5cClagY+iuF1U=;
 b=rs+YIsrFM4DfBPHR0P4gyXfeZK7+qaoh+q1+nRgsXNI3LVNoRID0dDfKCyzZYX4nhH
 6iE5+Z5BGtUBa5P1rpnCazphCmgIY+UlLz4RVmFN7Toyx++nCSqI1e5D5gpZ6Op21LXi
 WKns7QwL7EXTpfeI4L3r+uWsCdw/WKLsrzg9Uw+68fv5D8P4HmuTMy7jmZh/qCqDJqid
 imSt1ulXt41O25G32id2s/sQHAsXkGaxKoHPveBxpFY+RURo1aeZaZ4rbtRQql6PdDGX
 c8UA1bQNudEUypGnd27IK2CvN/QV0xUZ7RKdOdBrixDojuJlicd85O6zgkq/AZ9VmR8k
 gLAg==
X-Gm-Message-State: AOAM532h6+aNLHOdxV5Pm1TjkvYTgFj+2YEWWjrKPTxLamvc3xxeTSYY
 IEx4heYGAO7IEoqISeW0WgyhF0za1fDSncEuaTKrofs8jwc3MOnGl82ObBP8u1Co+HZT1OAl2HX
 U3Pb2jqEUh3sRBhk=
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr29124719wma.75.1600687787125; 
 Mon, 21 Sep 2020 04:29:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpya+pyFUyghfzVS7wej2xaR4dSlxXZn9zuk7Z0R+La0vIrpCn4qzDRaUtKHnBsV39ykgSGA==
X-Received: by 2002:a1c:4b13:: with SMTP id y19mr29124694wma.75.1600687786905; 
 Mon, 21 Sep 2020 04:29:46 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id q18sm21048565wre.78.2020.09.21.04.29.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 04:29:46 -0700 (PDT)
Date: Mon, 21 Sep 2020 07:29:44 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 03/15] vhost-vdpa: batch updating IOTLB mappings
Message-ID: <20200921112913.555392-4-mst@redhat.com>
References: <20200921112913.555392-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200921112913.555392-1-mst@redhat.com>
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
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/21 01:43:11
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.455,
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Jason Wang <jasowang@redhat.com>

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
Message-Id: <20200907104903.31551-4-jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-vdpa.h |  1 +
 hw/virtio/vhost-vdpa.c         | 66 ++++++++++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

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
-- 
MST


