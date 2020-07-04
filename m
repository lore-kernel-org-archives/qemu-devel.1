Return-Path: <SRS0=gOAu=AP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF361C433DF
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:43:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98A7120747
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Jul 2020 18:43:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="evCOB0cd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98A7120747
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrn8Z-0002Yr-TN
	for qemu-devel@archiver.kernel.org; Sat, 04 Jul 2020 14:43:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40078)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwK-000589-8e
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:04 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40285
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1jrmwI-0001hc-FK
 for qemu-devel@nongnu.org; Sat, 04 Jul 2020 14:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593887461;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3ExkqCYE+MZcrtgAoyxaOOvh3MgXkaeP71bTYP6/+H0=;
 b=evCOB0cdPgO60WCkiW8HzHpq/hYceWzOkBGAp82PNzRFMPV6I63WzJILMZhT93SAHG4GXG
 u9PWtRe2kPEIDmMPtT+cumoFOPfhXabp7mlNMUFZh7l2/0xAR1zxOVT0K6jzBi6FUCubLS
 U3Jq7MEBQwj8ZLbMWpFOr4BVuIHlfsw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-6Dh6bSz6N8Svkzqnd9HSxQ-1; Sat, 04 Jul 2020 14:31:00 -0400
X-MC-Unique: 6Dh6bSz6N8Svkzqnd9HSxQ-1
Received: by mail-wm1-f69.google.com with SMTP id z11so40160250wmg.5
 for <qemu-devel@nongnu.org>; Sat, 04 Jul 2020 11:30:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3ExkqCYE+MZcrtgAoyxaOOvh3MgXkaeP71bTYP6/+H0=;
 b=jGqgQmwA6Pw8Z1ln9VuiQt4jX7HTN5IxeMz6OoxX9pbnQVanf3QOzIR7tD3Cr5guY8
 Ltm9CtF7BvSYnbK7Th7uK/HKHwBjJVooM/ym9P9dV3gCB5Hn5VxP8OfJDr3BDcqW0dJT
 blCH8DqV29bv4R0V4+qqcKS1nL6dIaIvZcfdUZFqXTX+I8avsCwnJwdXxfbpQTTBHH9Z
 1ylIRV27nAyA+/PPfg+IKcp5+skbizBvCnsioYsGxs4Eo0oBovdy1x4tWE1RI2EHDXmQ
 pIalZOqDm6xvPWbfOrk+w+c1lHn1higmA0vUJrbL+kijMYI027tlUa13aB+y7wxoaI+D
 vS6w==
X-Gm-Message-State: AOAM531/McHNFDKuFhm643qrhF9w5JJD6KOYw37LBfqQAMApXsk+Cnry
 Urki4MwLn+aR7GffQhz7Uk9PEuPvEKcc8AET8fXJanQNtCJmoqzzo6Fy2/y1nwFf43oZ0wssbg5
 uJB/nCDiX1IVnyTo=
X-Received: by 2002:adf:f60c:: with SMTP id t12mr44996601wrp.198.1593887458330; 
 Sat, 04 Jul 2020 11:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwTreTBt+rQeyH1JQJqPgS1oL5zFWDdXRhmi55K32zByg3AFpyyawPDOLXm6AfNfancG+IciA==
X-Received: by 2002:adf:f60c:: with SMTP id t12mr44996594wrp.198.1593887458171; 
 Sat, 04 Jul 2020 11:30:58 -0700 (PDT)
Received: from redhat.com (bzq-79-182-31-92.red.bezeqint.net. [79.182.31.92])
 by smtp.gmail.com with ESMTPSA id
 v11sm54224641wmb.3.2020.07.04.11.30.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2020 11:30:57 -0700 (PDT)
Date: Sat, 4 Jul 2020 14:30:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 36/41] vhost: implement vhost_vq_get_addr method
Message-ID: <20200704182750.1088103-37-mst@redhat.com>
References: <20200704182750.1088103-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200704182750.1088103-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Received-SPF: pass client-ip=205.139.110.120; envelope-from=mst@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/04 11:39:15
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Cindy Lu <lulu@redhat.com>

use vhost_vq_get_addr callback to get the vq address from backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
Message-Id: <20200701145538.22333-10-lulu@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
---
 include/hw/virtio/vhost-backend.h |  4 ++++
 hw/virtio/vhost.c                 | 28 +++++++++++++++++++---------
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index fa84abac97..bfc24207e2 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -118,6 +118,9 @@ typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
 typedef int (*vhost_vq_get_addr_op)(struct vhost_dev *dev,
                     struct vhost_vring_addr *addr,
                     struct vhost_virtqueue *vq);
+
+typedef int (*vhost_get_device_id_op)(struct vhost_dev *dev, uint32_t *dev_id);
+
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -160,6 +163,7 @@ typedef struct VhostOps {
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
     vhost_dev_start_op vhost_dev_start;
     vhost_vq_get_addr_op  vhost_vq_get_addr;
+    vhost_get_device_id_op vhost_get_device_id;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index 32809e54b5..1e083a8976 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -773,15 +773,25 @@ static int vhost_virtqueue_set_addr(struct vhost_dev *dev,
                                     struct vhost_virtqueue *vq,
                                     unsigned idx, bool enable_log)
 {
-    struct vhost_vring_addr addr = {
-        .index = idx,
-        .desc_user_addr = (uint64_t)(unsigned long)vq->desc,
-        .avail_user_addr = (uint64_t)(unsigned long)vq->avail,
-        .used_user_addr = (uint64_t)(unsigned long)vq->used,
-        .log_guest_addr = vq->used_phys,
-        .flags = enable_log ? (1 << VHOST_VRING_F_LOG) : 0,
-    };
-    int r = dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
+    struct vhost_vring_addr addr;
+    int r;
+    memset(&addr, 0, sizeof(struct vhost_vring_addr));
+
+    if (dev->vhost_ops->vhost_vq_get_addr) {
+        r = dev->vhost_ops->vhost_vq_get_addr(dev, &addr, vq);
+        if (r < 0) {
+            VHOST_OPS_DEBUG("vhost_vq_get_addr failed");
+            return -errno;
+        }
+    } else {
+        addr.desc_user_addr = (uint64_t)(unsigned long)vq->desc;
+        addr.avail_user_addr = (uint64_t)(unsigned long)vq->avail;
+        addr.used_user_addr = (uint64_t)(unsigned long)vq->used;
+    }
+    addr.index = idx;
+    addr.log_guest_addr = vq->used_phys;
+    addr.flags = enable_log ? (1 << VHOST_VRING_F_LOG) : 0;
+    r = dev->vhost_ops->vhost_set_vring_addr(dev, &addr);
     if (r < 0) {
         VHOST_OPS_DEBUG("vhost_set_vring_addr failed");
         return -errno;
-- 
MST


