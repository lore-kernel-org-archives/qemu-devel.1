Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C752C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:36:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5688720CC7
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 16:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CiQi9jbO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5688720CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX5yt-000104-GD
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 12:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5wl-0007Tw-PY
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:34:01 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39017
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jX5wk-00065d-Gu
 for qemu-devel@nongnu.org; Fri, 08 May 2020 12:33:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1588955637;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=skuyGgsJUoIoU9Um/NUc1NTgtGUTH2qtntoWXyeA5eA=;
 b=CiQi9jbORetfn4kG6fUPgW5p4+BCYHjvvS77v7P0SNbEc7Shj9nrS5iWNZVsTSjHr8dnLF
 inM23pz++6RB9baBDRmPhZbOPxwCkCtqSiKaUwMAcLpG8u+sCDtzpKuaKgN3BoUtjTJLe2
 ZihxoN8UgE8M2I84Ei8vYiNkNM1lhls=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-7ouM8NXwNZucpKj05OPm0g-1; Fri, 08 May 2020 12:33:55 -0400
X-MC-Unique: 7ouM8NXwNZucpKj05OPm0g-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31A8E107ACCA;
 Fri,  8 May 2020 16:33:53 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-75.pek2.redhat.com [10.72.12.75])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE436ACF5;
 Fri,  8 May 2020 16:33:32 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v2 2/9] net: use the function qemu_get_peer
Date: Sat,  9 May 2020 00:32:11 +0800
Message-Id: <20200508163218.22592-3-lulu@redhat.com>
In-Reply-To: <20200508163218.22592-1-lulu@redhat.com>
References: <20200508163218.22592-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/08 01:34:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

user the qemu_get_peer to replace the old process

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/vhost_net.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b82803fa7..d1d421e3d9 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     BusState *qbus = BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus = VIRTIO_BUS(qbus);
     VirtioBusClass *k = VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *net;
     int r, e, i;
+    NetClientState *peer;
 
     if (!k->set_guest_notifiers) {
         error_report("binding does not support guest notifiers");
@@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     }
 
     for (i = 0; i < total_queues; i++) {
-        struct vhost_net *net;
 
-        net = get_vhost_net(ncs[i].peer);
+        peer = qemu_get_peer(ncs, i);
+        net = get_vhost_net(peer);
         vhost_net_set_vq_index(net, i * 2);
 
         /* Suppress the masking guest notifiers on vhost user
@@ -335,7 +337,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     }
 
     for (i = 0; i < total_queues; i++) {
-        r = vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
+        peer = qemu_get_peer(ncs, i);
+        r = vhost_net_start_one(get_vhost_net(peer), dev);
 
         if (r < 0) {
             goto err_start;
@@ -343,7 +346,7 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
 
         if (ncs[i].peer->vring_enable) {
             /* restore vring enable state */
-            r = vhost_set_vring_enable(ncs[i].peer, ncs[i].peer->vring_enable);
+            r = vhost_set_vring_enable(peer, peer->vring_enable);
 
             if (r < 0) {
                 goto err_start;
@@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
 
 err_start:
     while (--i >= 0) {
-        vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
+        peer = qemu_get_peer(ncs , i);
+        vhost_net_stop_one(get_vhost_net(peer), dev);
     }
     e = k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
     if (e < 0) {
-- 
2.21.1


