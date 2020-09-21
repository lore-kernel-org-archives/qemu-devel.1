Return-Path: <SRS0=MAm8=C6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E294C43463
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:33:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210AB20874
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2020 11:33:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BnSF1k50"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210AB20874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34788 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kKK4w-00070c-Dz
	for qemu-devel@archiver.kernel.org; Mon, 21 Sep 2020 07:33:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42470)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK11-0002YI-7j
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25928)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1kKK0z-0000ed-4E
 for qemu-devel@nongnu.org; Mon, 21 Sep 2020 07:29:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600687788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qmTXxwrSFY2mMpUUnscQSUtPOEOWVGicMQRRdIRDUlc=;
 b=BnSF1k50NScTm05TP4P95yATDWAdAkng0yaBn8mEsAkTeozVIW9bvv6HeDehQ71agwjwYL
 nbVcorvF5trPSZ7m0JUGtlzNz6gwdkmXMaiyFiC7RaeKWByabUh/wBfHmfcUVWv81yzf8i
 4Tt1GH4LfuZ+kjRnURAtN4ttxwl1X8Q=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-EEaxqOFlM_yGv_jdXnr2Ag-1; Mon, 21 Sep 2020 07:29:46 -0400
X-MC-Unique: EEaxqOFlM_yGv_jdXnr2Ag-1
Received: by mail-wm1-f72.google.com with SMTP id w3so3625749wmg.4
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2020 04:29:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qmTXxwrSFY2mMpUUnscQSUtPOEOWVGicMQRRdIRDUlc=;
 b=UJyn9ONy/MmY9lxAphM132eYbhVE9M93PEsatOfacfE7pvbix5YGcTtEpfwADzCbiH
 JfVqepLfKHeme1AfB1WJzz8wd0MMNKagLA5vm/gedCwO3YohVvId9+uewcCDfxYKi27M
 jPEp7jsop+6rz1fnenUzRWqMeyrXO6SLGdx42mAivTHCgTjE6S8Cy4nfeHl6aqjVeibo
 5zle+O9OVuxpST1FKpGPmVHDQylUZuh1gaf3qXt8SkiodDht93kTjHTCLQdUbWFryiIZ
 wFsA+yUb3bpedJ+RJkT6qksVx+D39YoBdjs4L+vGc2Kor1yZ1NEieqwiBaZdeXErujH0
 RYzQ==
X-Gm-Message-State: AOAM533c7JB/4F+D4CBrwCYaaDIT/W5fqnmWkg7EX+OtwN0p8bszl+4w
 F2xrSGJZGdyPIuIlwvv4pzo5eSrX2POCQSU8KM1XUP+INzt/YVbLziUIiVJMOke9csazSg2Jolb
 VHYO+MylFmpnRabQ=
X-Received: by 2002:adf:ec87:: with SMTP id z7mr55881462wrn.57.1600687784581; 
 Mon, 21 Sep 2020 04:29:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzqs/CTxguv/+NxE7QCwkPsQ4zBlqJ0Eo9TBQJTDDEgG3mfwBQHOjCRzrkwHjzthPEXCFRucQ==
X-Received: by 2002:adf:ec87:: with SMTP id z7mr55881446wrn.57.1600687784386; 
 Mon, 21 Sep 2020 04:29:44 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id u66sm35327317wme.1.2020.09.21.04.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2020 04:29:43 -0700 (PDT)
Date: Mon, 21 Sep 2020 07:29:41 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v3 02/15] vhost: switch to use IOTLB v2 format
Message-ID: <20200921112913.555392-3-mst@redhat.com>
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
 
-- 
MST


