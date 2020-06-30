Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E15D7C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:55:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 329CF2065D
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 17:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLMXA8oY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 329CF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqKTt-0005XL-KH
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 13:55:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50914)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqKS6-0002ki-IG
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:53:50 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30950
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqKS4-0001bp-T4
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 13:53:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593539628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rzqmVmfhl66aGJWNJW3FOBoJ8+40iEgl1UFIrB9hhGk=;
 b=TLMXA8oYH6NYLNy6+WVP5t2PsNoyxDrqaYj69E0p9ghef/PsAUILebsbNHsWnGbMYq8S4d
 OkBIvqaUBXPoKNjSrvfWBTspdI0QOkLhTlpGrwEoUDwdfu9iwDKhAvtm5TNlo/Bp4chP7S
 53N2iml35hmp0hRo10o96EcvZtTYV3g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-mgSUvT7rOaCVO-a_CdV-2Q-1; Tue, 30 Jun 2020 13:53:46 -0400
X-MC-Unique: mgSUvT7rOaCVO-a_CdV-2Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D482D80058A;
 Tue, 30 Jun 2020 17:53:43 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B299D61100;
 Tue, 30 Jun 2020 17:53:22 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v2 09/12] vhost: implement vhost_vq_get_addr method
Date: Wed,  1 Jul 2020 01:49:33 +0800
Message-Id: <20200630174937.25560-10-lulu@redhat.com>
In-Reply-To: <20200630174937.25560-1-lulu@redhat.com>
References: <20200630174937.25560-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 00:34:33
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
 hw/virtio/vhost.c | 28 +++++++++++++++++++---------
 1 file changed, 19 insertions(+), 9 deletions(-)

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
2.21.1


