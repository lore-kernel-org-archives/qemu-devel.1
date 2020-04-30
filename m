Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6F4AC47255
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6126208D5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 13:51:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="p0fxPmCd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6126208D5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jU9bK-0003be-QI
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 09:51:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9TN-0001DL-Cl
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:45:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <dimastep@yandex-team.ru>) id 1jU9Qe-0008Hn-De
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 09:43:29 -0400
Received: from forwardcorp1o.mail.yandex.net ([95.108.205.193]:47496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dimastep@yandex-team.ru>)
 id 1jU9NP-0001td-No; Thu, 30 Apr 2020 09:37:21 -0400
Received: from mxbackcorp1j.mail.yandex.net (mxbackcorp1j.mail.yandex.net
 [IPv6:2a02:6b8:0:1619::162])
 by forwardcorp1o.mail.yandex.net (Yandex) with ESMTP id 9E9442E14E4;
 Thu, 30 Apr 2020 16:37:16 +0300 (MSK)
Received: from myt4-18a966dbd9be.qloud-c.yandex.net
 (myt4-18a966dbd9be.qloud-c.yandex.net [2a02:6b8:c00:12ad:0:640:18a9:66db])
 by mxbackcorp1j.mail.yandex.net (mxbackcorp/Yandex) with ESMTP id
 GX0Aiw5eLv-bDWC24Y5; Thu, 30 Apr 2020 16:37:16 +0300
Precedence: bulk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; 
 t=1588253836; bh=5FKUZYsWXSmWGJbzPGJ+rs4aPqD/ORGDojQy3boMTtI=;
 h=In-Reply-To:In-Reply-To:Message-Id:References:References:Date:
 Subject:To:From:Cc;
 b=p0fxPmCdL9FwkOg0YTayXa1Va0q3FxG8Y16hf0JDiXp9Hd41Ga21u+uS3i6qQU2GK
 qb6GWYHYANeAz80Mlgg4x9tDLZzjTA/H3ZzyOGsXhxq0Ni1sq8UgZIjqzC96vdr7cK
 glGQ17a8sEtQhQO7bML6D2VBoATooMcuIxZu7AZE=
Authentication-Results: mxbackcorp1j.mail.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Received: from dynamic-vpn.dhcp.yndx.net (dynamic-vpn.dhcp.yndx.net
 [2a02:6b8:b080:7108::1:9])
 by myt4-18a966dbd9be.qloud-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id
 tZ29y7t6r8-bDWKtTr9; Thu, 30 Apr 2020 16:37:13 +0300
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
 (Client certificate not present)
From: Dima Stepanov <dimastep@yandex-team.ru>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 4/5] vhost: check vring address before calling unmap
Date: Thu, 30 Apr 2020 16:36:19 +0300
Message-Id: <2d4952df2cc246f7421b4b9023a581b22210fc41.1588252862.git.dimastep@yandex-team.ru>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1588252861.git.dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
In-Reply-To: <cover.1588252861.git.dimastep@yandex-team.ru>
References: <cover.1588252861.git.dimastep@yandex-team.ru>
Received-SPF: pass client-ip=95.108.205.193;
 envelope-from=dimastep@yandex-team.ru; helo=forwardcorp1o.mail.yandex.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/30 09:37:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 95.108.205.193
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: fam@euphon.net, kwolf@redhat.com, yc-core@yandex-team.ru,
 qemu-block@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 dgilbert@redhat.com, mreitz@redhat.com, arei.gonglei@huawei.com,
 fengli@smartx.com, stefanha@redhat.com, marcandre.lureau@redhat.com,
 pbonzini@redhat.com, raphael.norwitz@nutanix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since disconnect can happen at any time during initialization not all
vring buffers (for instance used vring) can be intialized successfully.
If the buffer was not initialized then vhost_memory_unmap call will lead
to SIGSEGV. Add checks for the vring address value before calling unmap.
Also add assert() in the vhost_memory_unmap() routine.

Signed-off-by: Dima Stepanov <dimastep@yandex-team.ru>
---
 hw/virtio/vhost.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
index ddbdc53..3ee50c4 100644
--- a/hw/virtio/vhost.c
+++ b/hw/virtio/vhost.c
@@ -314,6 +314,8 @@ static void vhost_memory_unmap(struct vhost_dev *dev, void *buffer,
                                hwaddr len, int is_write,
                                hwaddr access_len)
 {
+    assert(buffer);
+
     if (!vhost_dev_has_iommu(dev)) {
         cpu_physical_memory_unmap(buffer, len, is_write, access_len);
     }
@@ -1132,12 +1134,25 @@ static void vhost_virtqueue_stop(struct vhost_dev *dev,
                                                 vhost_vq_index);
     }
 
-    vhost_memory_unmap(dev, vq->used, virtio_queue_get_used_size(vdev, idx),
-                       1, virtio_queue_get_used_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->avail, virtio_queue_get_avail_size(vdev, idx),
-                       0, virtio_queue_get_avail_size(vdev, idx));
-    vhost_memory_unmap(dev, vq->desc, virtio_queue_get_desc_size(vdev, idx),
-                       0, virtio_queue_get_desc_size(vdev, idx));
+    /*
+     * Since the vhost-user disconnect can happen during initialization
+     * check if vring was initialized, before making unmap.
+     */
+    if (vq->used) {
+        vhost_memory_unmap(dev, vq->used,
+                           virtio_queue_get_used_size(vdev, idx),
+                           1, virtio_queue_get_used_size(vdev, idx));
+    }
+    if (vq->avail) {
+        vhost_memory_unmap(dev, vq->avail,
+                           virtio_queue_get_avail_size(vdev, idx),
+                           0, virtio_queue_get_avail_size(vdev, idx));
+    }
+    if (vq->desc) {
+        vhost_memory_unmap(dev, vq->desc,
+                           virtio_queue_get_desc_size(vdev, idx),
+                           0, virtio_queue_get_desc_size(vdev, idx));
+    }
 }
 
 static void vhost_eventfd_add(MemoryListener *listener,
-- 
2.7.4


