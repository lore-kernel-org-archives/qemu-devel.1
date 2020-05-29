Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC10DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A8FC62073B
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DfKrkok2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A8FC62073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46494 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeg1L-00012T-N2
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55640)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefi5-0004cq-Eu
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:10:09 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:55962
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jefi4-0005mJ-Ff
 for qemu-devel@nongnu.org; Fri, 29 May 2020 10:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590761407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JLuZSoaS7Bp6RBxB/Y5YH+sIMS4ZomLIm+8NA1SmnyY=;
 b=DfKrkok2lxqUlUO7BQsqmLZ9bHrdOJGoKDzB3/t/4cjq2V5gWUiAisFrd/CjkG6FmNQL7v
 rvT56KsQkELEoFivTMIGeryEGb4EaHfGz8LL0FYR/On+7VBDFsFo08NxgWoCBlIWtgX632
 efyX1rr8JWBVxfJ3FYXBQp5ARe8odac=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-0s0ghNJFO_yIo--ompjaaw-1; Fri, 29 May 2020 10:10:05 -0400
X-MC-Unique: 0s0ghNJFO_yIo--ompjaaw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EC9CD80B700;
 Fri, 29 May 2020 14:10:02 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-84.pek2.redhat.com [10.72.13.84])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7C4565D9D5;
 Fri, 29 May 2020 14:09:45 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v3 5/8] vhost: introduce vhost_set_vring_ready method
Date: Fri, 29 May 2020 22:06:17 +0800
Message-Id: <20200529140620.28759-6-lulu@redhat.com>
In-Reply-To: <20200529140620.28759-1-lulu@redhat.com>
References: <20200529140620.28759-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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

From: Jason Wang <jasowang@redhat.com>

Vhost-vdpa introduces VHOST_VDPA_SET_VRING_ENABLE which complies the
semantic of queue_enable defined in virtio spec. This method can be
used for preventing device from executing request for a specific
virtqueue. This patch introduces the vhost_ops for this.

Note that, we've already had vhost_set_vring_enable which has different
semantic which allows to enable or disable a specific virtqueue for
some kinds of vhost backends. E.g vhost-user use this to changes the
number of active queue pairs.

Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/vhost_net-stub.c |  4 ++++
 hw/net/vhost_net.c      | 11 ++++++++++-
 include/net/vhost_net.h |  1 +
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/net/vhost_net-stub.c b/hw/net/vhost_net-stub.c
index aac0e98228..43e93e1a9a 100644
--- a/hw/net/vhost_net-stub.c
+++ b/hw/net/vhost_net-stub.c
@@ -86,6 +86,10 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
     return 0;
 }
 
+int vhost_set_vring_ready(NetClientState *nc)
+{
+    return 0;
+}
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     return 0;
diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index d1d421e3d9..e2bc7de2eb 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -344,7 +344,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
             goto err_start;
         }
 
-        if (ncs[i].peer->vring_enable) {
+        if (peer->vring_enable) {
             /* restore vring enable state */
             r = vhost_set_vring_enable(peer, peer->vring_enable);
 
@@ -455,6 +455,15 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
     return 0;
 }
 
+int vhost_set_vring_ready(NetClientState *nc)
+{
+    VHostNetState *net = get_vhost_net(nc);
+    const VhostOps *vhost_ops = net->dev.vhost_ops;
+    if (vhost_ops && vhost_ops->vhost_set_vring_ready) {
+        return vhost_ops->vhost_set_vring_ready(&net->dev);
+    }
+    return 0;
+}
 int vhost_net_set_mtu(struct vhost_net *net, uint16_t mtu)
 {
     const VhostOps *vhost_ops = net->dev.vhost_ops;
diff --git a/include/net/vhost_net.h b/include/net/vhost_net.h
index 77e47398c4..8a6f208189 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -35,6 +35,7 @@ int vhost_net_notify_migration_done(VHostNetState *net, char* mac_addr);
 VHostNetState *get_vhost_net(NetClientState *nc);
 
 int vhost_set_vring_enable(NetClientState * nc, int enable);
+int vhost_set_vring_ready(NetClientState *nc);
 
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
-- 
2.21.1


