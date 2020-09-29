Return-Path: <SRS0=JiPe=DG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FB04C4346E
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:53:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67ECA2076A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2020 07:53:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jJJ8lylv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67ECA2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50548 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kNASK-0001lN-BZ
	for qemu-devel@archiver.kernel.org; Tue, 29 Sep 2020 03:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59064)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA10-0007o5-01
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49020)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kNA0x-0002Oy-S4
 for qemu-devel@nongnu.org; Tue, 29 Sep 2020 03:25:33 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601364331;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sR23DDCTXejgPQyS2mHHsS1AyYrJcpslkuBoXwtVJYw=;
 b=jJJ8lylvsEQkkbIoZekmqs3tm2Ul9YKjQRO33WWjC6Cqm0UJ+I+C31zj4ioX0kYGEZFWLN
 6oA3ZuRmmBY3Ftjo9kVaKCiyOi39PIhP+aMGkFQ1ra8xNSg9wepawkUrOqpTkPSM27v9+S
 1Zf/SRMTYab06SQL/m6tjOkNWUIQi+8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-365-TaVO7sn1Mf6tNFr0ghyWkg-1; Tue, 29 Sep 2020 03:25:29 -0400
X-MC-Unique: TaVO7sn1Mf6tNFr0ghyWkg-1
Received: by mail-wr1-f71.google.com with SMTP id l9so1348628wrq.20
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2020 00:25:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sR23DDCTXejgPQyS2mHHsS1AyYrJcpslkuBoXwtVJYw=;
 b=uXW+mpj1q6nAvZOoaP4L0tMroPw0gt4KJ+fOPfl0Lyp5POOj4d+eOtWLMp+T7g5hau
 gdtf0tuNQkQABP4oFxgj6Ch3U/WosDaw8HRvsD+LvgkTrK3whXSZGXpYUpZb+BLaJfEM
 7JQ5VFalAW3Q0RrnhaBFKvvrYclRwOf+2tdeVgFsak0B825ZSSMe3IkWx41/GUM2WLgK
 GjqVuiFcx+p5Y4QXNIya/f83gDh5AeVz7/wnK+cdJnGUIj6Y0yeA1ryud13hQ5/3sgx4
 Z0unXADAZtUtSsV6G9EN6ET7LHFgDw25X/VdIn4hAp/8vssup0MTFT3tujZD5tbyi6um
 1kgA==
X-Gm-Message-State: AOAM530mXu5V05VER47Bobrr4TLKof53oaoDFHXPQQUulwL0yWCnFBT7
 kz4bHm4MJiFBTxUH4n0fQScK/JFzM7xpR+Y4TA7jKLf4xXyFe/nifLcb70mqzxhKlQnaXkEeI4L
 TCVeib+qHxuUrZyo=
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr2856099wmj.19.1601364327294; 
 Tue, 29 Sep 2020 00:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCNQwnXlDloCsYw0dTYhDUbxzC+4G8atY/mp2BmXU3c/s8dw8B7ug83fqRLGuRN6hEFzib8Q==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr2856077wmj.19.1601364327017; 
 Tue, 29 Sep 2020 00:25:27 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id t4sm4769356wrr.26.2020.09.29.00.25.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2020 00:25:26 -0700 (PDT)
Date: Tue, 29 Sep 2020 03:25:25 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v4 02/48] vhost: switch to use IOTLB v2 format
Message-ID: <20200929071948.281157-3-mst@redhat.com>
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

This patch tries to switch to use new kernel IOTLB format V2. Previous
version may have inconsistent ABI between 32bit and 64bit machines
because of the hole after type field. Refer kernel commit
("429711aec282 vhost: switch to use new message format") for more
information.

To enable this feature, qemu need to use a new ioctl
VHOST_SET_BACKEND_FEATURE with VHOST_BACKEND_F_IOTLB_MSG_V2 bit. A new
vhost setting backend features ops was introduced. And when we try to
set features for vhost dev, we will examine the support of new IOTLB
format and enable it. This process is total transparent to guest,
which means we can have different IOTLB message type in src and dst
during migration.

The conversion of IOTLB message is straightforward, just check the
type and behave accordingly.

Signed-off-by: Jason Wang <jasowang@redhat.com>
Message-Id: <20200907104903.31551-3-jasowang@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/hw/virtio/vhost-backend.h |  2 +
 include/hw/virtio/vhost.h         |  1 +
 hw/virtio/vhost-backend.c         | 88 +++++++++++++++++++++++++------
 hw/virtio/vhost.c                 | 10 ++++
 4 files changed, 84 insertions(+), 17 deletions(-)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 8825bd278f..8a6f8e2a7a 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -74,6 +74,7 @@ typedef int (*vhost_set_features_op)(struct vhost_dev *dev,
                                      uint64_t features);
 typedef int (*vhost_get_features_op)(struct vhost_dev *dev,
                                      uint64_t *features);
+typedef int (*vhost_set_backend_cap_op)(struct vhost_dev *dev);
 typedef int (*vhost_set_owner_op)(struct vhost_dev *dev);
 typedef int (*vhost_reset_device_op)(struct vhost_dev *dev);
 typedef int (*vhost_get_vq_index_op)(struct vhost_dev *dev, int idx);
@@ -146,6 +147,7 @@ typedef struct VhostOps {
     vhost_set_vring_busyloop_timeout_op vhost_set_vring_busyloop_timeout;
     vhost_set_features_op vhost_set_features;
     vhost_get_features_op vhost_get_features;
+    vhost_set_backend_cap_op vhost_set_backend_cap;
     vhost_set_owner_op vhost_set_owner;
     vhost_reset_device_op vhost_reset_device;
     vhost_get_vq_index_op vhost_get_vq_index;
diff --git a/include/hw/virtio/vhost.h b/include/hw/virtio/vhost.h
index 767a95ec0b..94585067f7 100644
--- a/include/hw/virtio/vhost.h
+++ b/include/hw/virtio/vhost.h
@@ -79,6 +79,7 @@ struct vhost_dev {
     uint64_t backend_features;
     uint64_t protocol_features;
     uint64_t max_queues;
+    uint64_t backend_cap;
     bool started;
     bool log_enabled;
     uint64_t log_size;
diff --git a/hw/virtio/vhost-backend.c b/hw/virtio/vhost-backend.c
index 782b1d67d9..88c8ecc9e0 100644
--- a/hw/virtio/vhost-backend.c
+++ b/hw/virtio/vhost-backend.c
@@ -156,6 +156,28 @@ static int vhost_kernel_set_features(struct vhost_dev *dev,
     return vhost_kernel_call(dev, VHOST_SET_FEATURES, &features);
 }
 
+static int vhost_kernel_set_backend_cap(struct vhost_dev *dev)
+{
+    uint64_t features;
+    uint64_t f = 0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2;
+    int r;
+
+    if (vhost_kernel_call(dev, VHOST_GET_BACKEND_FEATURES, &features)) {
+        return 0;
+    }
+
+    features &= f;
+    r = vhost_kernel_call(dev, VHOST_SET_BACKEND_FEATURES,
+                              &features);
+    if (r) {
+        return 0;
+    }
+
+    dev->backend_cap = features;
+
+    return 0;
+}
+
 static int vhost_kernel_get_features(struct vhost_dev *dev,
                                      uint64_t *features)
 {
@@ -195,34 +217,65 @@ static int vhost_kernel_vsock_set_running(struct vhost_dev *dev, int start)
 static void vhost_kernel_iotlb_read(void *opaque)
 {
     struct vhost_dev *dev = opaque;
-    struct vhost_msg msg;
     ssize_t len;
 
-    while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
-        if (len < sizeof msg) {
-            error_report("Wrong vhost message len: %d", (int)len);
-            break;
-        }
-        if (msg.type != VHOST_IOTLB_MSG) {
-            error_report("Unknown vhost iotlb message type");
-            break;
-        }
+    if (dev->backend_cap &
+        (0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
+        struct vhost_msg_v2 msg;
 
-        vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
+        while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
+            if (len < sizeof msg) {
+                error_report("Wrong vhost message len: %d", (int)len);
+                break;
+            }
+            if (msg.type != VHOST_IOTLB_MSG_V2) {
+                error_report("Unknown vhost iotlb message type");
+                break;
+            }
+
+            vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
+        }
+    } else {
+        struct vhost_msg msg;
+
+        while ((len = read((uintptr_t)dev->opaque, &msg, sizeof msg)) > 0) {
+            if (len < sizeof msg) {
+                error_report("Wrong vhost message len: %d", (int)len);
+                break;
+            }
+            if (msg.type != VHOST_IOTLB_MSG) {
+                error_report("Unknown vhost iotlb message type");
+                break;
+            }
+
+            vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
+        }
     }
 }
 
 static int vhost_kernel_send_device_iotlb_msg(struct vhost_dev *dev,
                                               struct vhost_iotlb_msg *imsg)
 {
-    struct vhost_msg msg;
+    if (dev->backend_cap & (1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
+        struct vhost_msg_v2 msg;
 
-    msg.type = VHOST_IOTLB_MSG;
-    msg.iotlb = *imsg;
+        msg.type = VHOST_IOTLB_MSG_V2;
+        msg.iotlb = *imsg;
 
-    if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
-        error_report("Fail to update device iotlb");
-        return -EFAULT;
+        if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
+            error_report("Fail to update device iotlb");
+            return -EFAULT;
+        }
+    } else {
+        struct vhost_msg msg;
+
+        msg.type = VHOST_IOTLB_MSG;
+        msg.iotlb = *imsg;
+
+        if (write((uintptr_t)dev->opaque, &msg, sizeof msg) != sizeof msg) {
+            error_report("Fail to update device iotlb");
+            return -EFAULT;
+        }
     }
 
     return 0;
@@ -260,6 +313,7 @@ static const VhostOps kernel_ops = {
                                 vhost_kernel_set_vring_busyloop_timeout,
         .vhost_set_features = vhost_kernel_set_features,
         .vhost_get_features = vhost_kernel_get_features,
+        .vhost_set_backend_cap = vhost_kernel_set_backend_cap,
         .vhost_set_owner = vhost_kernel_set_owner,
         .vhost_reset_device = vhost_kernel_reset_device,
         .vhost_get_vq_index = vhost_kernel_get_vq_index,
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 0119516254..8087f200e9 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -818,7 +818,17 @@ static int vhost_dev_set_features(struct vhost_dev *dev,
     r = dev->vhost_ops->vhost_set_features(dev, features);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_features failed");
+        goto out;
     }
+    if (dev->vhost_ops->vhost_set_backend_cap) {
+        r = dev->vhost_ops->vhost_set_backend_cap(dev);
+        if (r < 0) {
+            VHOST_OPS_DEBUG("vhost_set_backend_cap failed");
+            goto out;
+        }
+    }
+
+out:
     return r < 0 ? -errno : 0;
 }
 
-- 
MST


