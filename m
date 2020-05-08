Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A6EC38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A1A520CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:37:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RmUB1dsb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A1A520CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45024 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX60Y-0003j8-SO
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60978)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5x8-0007qC-5O
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:34:22 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:36766
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5x7-0007hE-6P
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588955660;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0nhH79L1o1AT2y6BnT9L+LpqnN5izFGzVarE8zoLWM=;
 b=RmUB1dsbndlukau4SR89GL5ob2f7EAIv6DMG7wkAa3EqOgbqWmCrqpPZahprCMix4R5pmK
 k71tFVYpa5rpfuT5Q6aicaYlqqBBt5LpUEcqj0LGgwjkwR4p7girTLasdeKpx9pa6/tu86
 7g/HDwqgy4lv3ESTrrAsRDYoPPNP6oQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-F90NuD-8NG-P-xGlaLTciQ-1; Fri, 08 May 2020 12:34:18 -0400
X-MC-Unique: F90NuD-8NG-P-xGlaLTciQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 449B7872FE0;
 Fri,  8 May 2020 16:34:13 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 79FD96ACEF;
 Fri,  8 May 2020 16:33:55 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v2 3/9] virtio_net: introduce vhost_set_state
Date: Sat,  9 May 2020 00:32:12 +0800
Message-Id: <20200508163218.22592-4-lulu@redhat.com>
In-Reply-To: <20200508163218.22592-1-lulu@redhat.com>
References: <20200508163218.22592-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 08:00:48
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
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

Introduce a function to set the state to the vhost driver.
vDPA need to sync the driver's state to NIC

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/vhost_net.c                | 9 +++++++++
 hw/net/virtio-net.c               | 9 +++++++++
 include/hw/virtio/vhost-backend.h | 2 ++
 include/net/vhost_net.h           | 2 +-
 4 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index d1d421e3d9..63b2a85d6e 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -465,3 +465,12 @@ int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 
     return vhost_ops->vhost_net_set_mtu(&net->dev, mtu);
 }
+int vhost_set_state(NetClientState *nc, uint8_t state)
+{
+    struct vhost_net *net = get_vhost_net(nc);
+    struct vhost_dev *hdev = &net->dev;
+        if (hdev->vhost_ops->vhost_set_state) {
+                return hdev->vhost_ops->vhost_set_state(hdev, state);
+        }
+    return 0;
+}
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index db3d7c38e6..1bddb4b4af 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -206,6 +206,9 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     NetClientState *nc = qemu_get_queue(n->nic);
     int queues = n->multiqueue ? n->max_queues : 1;
+    NetClientState *peer = qemu_get_peer(nc, 0);
+    uint8_t status_set  = vdev->status ;
+    uint8_t vhost_started_pre = n->vhost_started;
 
     if (!get_vhost_net(nc->peer)) {
         return;
@@ -245,6 +248,7 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
                 return;
             }
         }
+        status_set = status_set | VIRTIO_CONFIG_S_DRIVER_OK;
 
         n->vhost_started = 1;
         r = vhost_net_start(vdev, n->nic->ncs, queues);
@@ -252,11 +256,16 @@ static void virtio_net_vhost_status(VirtIONet *n, uint8_t status)
             error_report("unable to start vhost net: %d: "
                          "falling back on userspace virtio", -r);
             n->vhost_started = 0;
+            status_set = status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
         }
     } else {
         vhost_net_stop(vdev, n->nic->ncs, queues);
+        status_set = status_set & ~VIRTIO_CONFIG_S_DRIVER_OK;
         n->vhost_started = 0;
     }
+    if (vhost_started_pre != n->vhost_started) {
+            vhost_set_state(peer, status_set);
+    }
 }
 
 static int virtio_net_set_vnet_endian_one(VirtIODevice *vdev,
diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index 6f6670783f..f823055167 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -112,6 +112,7 @@ typedef int (*vhost_get_inflight_fd_op)(struct vhost_dev *dev,
 typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
                                         struct vhost_inflight *inflight);
 
+typedef int (*vhost_set_state_op)(struct vhost_dev *dev, uint8_t state);
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -152,6 +153,7 @@ typedef struct VhostOps {
     vhost_backend_mem_section_filter_op vhost_backend_mem_section_filter;
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
+    vhost_set_state_op vhost_set_state;
 } VhostOps;
 
 extern const VhostOps user_ops;
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 77e47398c4..6548a5a105 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -39,5 +39,5 @@ int vhost_set_vring_enable(NetClientState * nc, int enable);
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu);
-
+int vhost_set_state(NetClientState *nc, uint8_t state);
 #endif
-- 
2.21.1


