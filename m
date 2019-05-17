Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 122E0C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:09:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D979920818
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 09:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D979920818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44907 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRYrN-0005re-Uv
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 05:09:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:34752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRYpY-0004Tl-4D
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:07:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1hRYpW-0003iS-4X
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:07:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41426)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1hRYpV-0003i6-Va
	for qemu-devel@nongnu.org; Fri, 17 May 2019 05:07:06 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9C860308FBB1;
	Fri, 17 May 2019 09:07:04 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-157.pek2.redhat.com
	[10.72.12.157])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 51A7260BE0;
	Fri, 17 May 2019 09:07:01 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Date: Fri, 17 May 2019 17:06:54 +0800
Message-Id: <1558084017-15947-2-git-send-email-jasowang@redhat.com>
In-Reply-To: <1558084017-15947-1-git-send-email-jasowang@redhat.com>
References: <1558084017-15947-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.43]);
	Fri, 17 May 2019 09:07:04 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/4] vhost_net: don't set backend for the
 uninitialized virtqueue
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We used to set backend unconditionally, this won't work for some
guests (e.g windows driver) who may not initialize all virtqueues. For
kernel backend, this will fail since it may try to validate the rings
during setting backend.

Fixing this by simply skipping the backend set when we find desc is
not ready.

Reviewed-by: Michael S. Tsirkin<mst@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net.c         | 10 ++++++++++
 hw/virtio/virtio.c         |  5 +++++
 include/hw/virtio/virtio.h |  1 +
 3 files changed, 16 insertions(+)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index be3cc88..a6b7190 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -244,6 +244,11 @@ static int vhost_net_start_one(struct vhost_net *net,
         qemu_set_fd_handler(net->backend, NULL, NULL, NULL);
         file.fd = net->backend;
         for (file.index = 0; file.index < net->dev.nvqs; ++file.index) {
+            if (!virtio_queue_enabled(dev, net->dev.vq_index +
+                                      file.index)) {
+                /* Queue might not be ready for start */
+                continue;
+            }
             r = vhost_net_set_backend(&net->dev, &file);
             if (r < 0) {
                 r = -errno;
@@ -256,6 +261,11 @@ fail:
     file.fd = -1;
     if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
         while (file.index-- > 0) {
+            if (!virtio_queue_enabled(dev, net->dev.vq_index +
+                                      file.index)) {
+                /* Queue might not be ready for start */
+                continue;
+            }
             int r = vhost_net_set_backend(&net->dev, &file);
             assert(r >= 0);
         }
diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
index 2626a89..28056a7 100644
--- a/hw/virtio/virtio.c
+++ b/hw/virtio/virtio.c
@@ -2318,6 +2318,11 @@ hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n)
     return vdev->vq[n].vring.desc;
 }
 
+bool virtio_queue_enabled(VirtIODevice *vdev, int n)
+{
+    return virtio_queue_get_desc_addr(vdev, n) != 0;
+}
+
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n)
 {
     return vdev->vq[n].vring.avail;
diff --git a/include/hw/virtio/virtio.h b/include/hw/virtio/virtio.h
index ce95162..7140381 100644
--- a/include/hw/virtio/virtio.h
+++ b/include/hw/virtio/virtio.h
@@ -282,6 +282,7 @@ typedef struct VirtIORNGConf VirtIORNGConf;
                       VIRTIO_F_IOMMU_PLATFORM, false)
 
 hwaddr virtio_queue_get_desc_addr(VirtIODevice *vdev, int n);
+bool virtio_queue_enabled(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_avail_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_used_addr(VirtIODevice *vdev, int n);
 hwaddr virtio_queue_get_desc_size(VirtIODevice *vdev, int n);
-- 
2.5.0


