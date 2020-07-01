Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D56DC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE2B420722
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 09:30:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sjocm7g1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE2B420722
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54972 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqZ4j-00076a-61
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 05:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqZ3S-0005hr-Cq
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:29:22 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:59126
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jqZ3Q-0005Rc-Lc
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 05:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593595759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OVOMfM+qrBIZg0i/kq0OO3CC+fK4QzA2HrNfy0J9imU=;
 b=Sjocm7g1c0A59BsAgDFo095afP5vhb47h2TPOVQvTDpKFvedbgpXxKVfjy+rvpIWMe9pKD
 A98ywBNoF6e2K9h5PgywvW/GI9dQfdqG/2Q0+fnqGQcYxseQMVwoUbpQ15pz62ShW4wFD3
 Ldn42sg7Ahq5gVyo877q7ZnqrGkuwyY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-321-8dSDFjXjNXCSfmD9p8dSKA-1; Wed, 01 Jul 2020 05:29:18 -0400
X-MC-Unique: 8dSDFjXjNXCSfmD9p8dSKA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0BCA80058A;
 Wed,  1 Jul 2020 09:29:15 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-19.pek2.redhat.com [10.72.12.19])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B98DE105958A;
 Wed,  1 Jul 2020 09:28:55 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v3 08/13] vhost: introduce new VhostOps vhost_vq_get_addr
Date: Wed,  1 Jul 2020 17:24:44 +0800
Message-Id: <20200701092449.17451-9-lulu@redhat.com>
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

This patch introduces new VhostOps vhost_vq_get_addr_op callback to get
the vring addr from the backend

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 include/hw/virtio/vhost-backend.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/hw/virtio/vhost-backend.h b/include/hw/virtio/vhost-backend.h
index b80f344cd6..fa84abac97 100644
--- a/include/hw/virtio/vhost-backend.h
+++ b/include/hw/virtio/vhost-backend.h
@@ -34,6 +34,7 @@ struct vhost_vring_state;
 struct vhost_vring_addr;
 struct vhost_scsi_target;
 struct vhost_iotlb_msg;
+struct vhost_virtqueue;
 
 typedef int (*vhost_backend_init)(struct vhost_dev *dev, void *opaque);
 typedef int (*vhost_backend_cleanup)(struct vhost_dev *dev);
@@ -113,6 +114,10 @@ typedef int (*vhost_set_inflight_fd_op)(struct vhost_dev *dev,
                                         struct vhost_inflight *inflight);
 
 typedef int (*vhost_dev_start_op)(struct vhost_dev *dev, bool started);
+
+typedef int (*vhost_vq_get_addr_op)(struct vhost_dev *dev,
+                    struct vhost_vring_addr *addr,
+                    struct vhost_virtqueue *vq);
 typedef struct VhostOps {
     VhostBackendType backend_type;
     vhost_backend_init vhost_backend_init;
@@ -154,6 +159,7 @@ typedef struct VhostOps {
     vhost_get_inflight_fd_op vhost_get_inflight_fd;
     vhost_set_inflight_fd_op vhost_set_inflight_fd;
     vhost_dev_start_op vhost_dev_start;
+    vhost_vq_get_addr_op  vhost_vq_get_addr;
 } VhostOps;
 
 extern const VhostOps user_ops;
-- 
2.21.1


