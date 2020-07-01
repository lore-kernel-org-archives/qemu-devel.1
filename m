Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B99C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:32:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE5512074D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:31:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CylzhP2x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE5512074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZ5z-0000H3-6e
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:31:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqZ3o-0006P5-4y
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:29:48 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:29503
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqZ3l-0005Sn-VM
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:29:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593595781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwskrW3XFwrVWGs/QVMYlsKMibfgJslHMALI+9PlK84=;
 b=CylzhP2xMozyW+SC0aILLkbA59PzWXXT/jsdXRI5Hq8cvEr1xCxT4UZSgreSb89qLJ8zPy
 4IZshDqGtFCq2q7tA6KKsXrVKOHXKBnvaD4mD1XFwaj+1+neEXSywaWkt2gyHLw/wJgffv
 an7BKqyYOjNJoIUyW43eGKFUJTr4atk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-147-QLBur3n9NtGEmzYIw8sC0Q-1; Wed, 01 Jul 2020 05:29:39 -0400
X-MC-Unique: QLBur3n9NtGEmzYIw8sC0Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C5E9107ACF9;
 Wed,  1 Jul 2020 09:29:37 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 74578100164D;
 Wed,  1 Jul 2020 09:29:17 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v3 09/13] vhost: implement vhost_vq_get_addr method
Date: Wed,  1 Jul 2020 17:24:45 +0800
Message-Id: <20200701092449.17451-10-lulu@redhat.com>
In-Reply-To: <20200701092449.17451-1-lulu@redhat.com>
References: <20200701092449.17451-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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

use vhost_vq_get_addr callback to get the vq address from backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/virtio/vhost.c                 | 28 +++++++++++++++++++---------
 include/hw/virtio/vhost-backend.h |  4 ++++
 2 files changed, 23 insertions(+), 9 deletions(-)

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
-- 
2.21.1


