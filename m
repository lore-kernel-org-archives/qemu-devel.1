Return-Path: <SRS0=tzYv=CQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 599F3C43461
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:52:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3A88206D4
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Sep 2020 10:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mlgz+7S/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3A88206D4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43364 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFEks-0004Cz-PG
	for qemu-devel@archiver.kernel.org; Mon, 07 Sep 2020 06:52:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFEiC-000137-7a
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:49:24 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:20401
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1kFEiA-0005ZV-DA
 for qemu-devel@nongnu.org; Mon, 07 Sep 2020 06:49:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599475761;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=E6wG+GIqq8r+ZxSdY2D1jPYW7AgSbitjyZuIlVMy/wE=;
 b=Mlgz+7S//JF4uwCGsCb/AhPWPOClyffrzwP0d7Q/xUYFafaHf067qVPAr+gEVlB1l03krX
 YZzEb80SXh6dQ7c0rGpD77Yhi0b4S6NBij26z7ixCaMo7xb6fw1Kbni+nnR2yckzrhDkvO
 W0ml7q9tsUyEpUvr07LRIFtqKd9sUF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-ieDkzXYQMsWbSgFRN7c10g-1; Mon, 07 Sep 2020 06:49:17 -0400
X-MC-Unique: ieDkzXYQMsWbSgFRN7c10g-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 109941074662;
 Mon,  7 Sep 2020 10:49:17 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-108.pek2.redhat.com [10.72.12.108])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DBE6610013C4;
 Mon,  7 Sep 2020 10:49:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 2/3] vhost: switch to use IOTLB v2 format
Date: Mon,  7 Sep 2020 18:49:02 +0800
Message-Id: <20200907104903.31551-3-jasowang@redhat.com>
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
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/07 03:05:01
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Cc: elic@nvidia.com, Jason Wang <jasowang@redhat.com>, lulu@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

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
---
 hw/virtio/vhost-backend.c         | 86 +++++++++++++++++++++++++------
 hw/virtio/vhost.c                 | 10 ++++
 include/hw/virtio/vhost-backend.h |  2 +
 include/hw/virtio/vhost.h         |  1 +
 4 files changed, 83 insertions(+), 16 deletions(-)

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
+    if (dev->backend_cap &
+        (0x1ULL << VHOST_BACKEND_F_IOTLB_MSG_V2)) {
+        struct vhost_msg_v2 msg;
+
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
         }
-        if (msg.type != VHOST_IOTLB_MSG) {
-            error_report("Unknown vhost iotlb message type");
-            break;
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
         }
-
-        vhost_backend_handle_iotlb_msg(dev, &msg.iotlb);
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
index 1a1384e7a6..e986bf53e4 100644
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
-- 
2.20.1


