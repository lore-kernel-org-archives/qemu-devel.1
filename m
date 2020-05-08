Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02837C4724C
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9216214D8
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TWesI5F3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9216214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX60Z-0003mT-TN
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33572)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5zQ-0001xT-24
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:36:44 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:60426
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5zO-0007nC-Vs
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:36:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588955802;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0+UijJbg4+qyAryZoZTlBXF6cXTGUPho1cE100TLt24=;
 b=TWesI5F3rEOv51+uX0l7Nu1dXm0l9BlIZpA0zz3gigGoFjTgqV3fKr5qFrcXNIa/mPvVxE
 uBwcpMj14LZYuGK+b9cHDXub65qMdqQB7pz8O01JAsLnFhNA44W6xDEDtNSB8jx6C0FXuH
 ALeJbOaDJpa1+mcFXJzy79f7BR+/GaA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-8N2YBCf-Pimh3P9VqZQ1Zw-1; Fri, 08 May 2020 12:36:40 -0400
X-MC-Unique: 8N2YBCf-Pimh3P9VqZQ1Zw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 69E4C464;
 Fri,  8 May 2020 16:36:37 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E9AF86AD0A;
 Fri,  8 May 2020 16:36:19 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v2 9/9] vhost: introduce vhost_set_vring_ready method
Date: Sat,  9 May 2020 00:32:18 +0800
Message-Id: <20200508163218.22592-10-lulu@redhat.com>
In-Reply-To: <20200508163218.22592-1-lulu@redhat.com>
References: <20200508163218.22592-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 11:31:41
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
index eff9ec9177..6911282a0a 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -375,7 +375,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
             goto err_start;
         }
 
-        if (ncs[i].peer->vring_enable) {
+        if (peer->vring_enable) {
             /* restore vring enable state */
             r = vhost_set_vring_enable(peer, peer->vring_enable);
 
@@ -496,6 +496,15 @@ int vhost_set_vring_enable(NetClientState *nc, int enable)
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
index b47844bf29..247432a3b2 100644
--- a/include/net/vhost_net.h
+++ b/include/net/vhost_net.h
@@ -35,6 +35,7 @@ int vhost_net_notify_migration_done(VHostNetState *net, char* mac_addr);
 VHostNetState *get_vhost_net(NetClientState *nc);
 
 int vhost_set_vring_enable(NetClientState * nc, int enable);
+int vhost_set_vring_ready(NetClientState *nc);
 
 uint64_t vhost_net_get_acked_features(VHostNetState *net);
 
-- 
2.21.1


