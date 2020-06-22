Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B38CC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:40:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 435F8206EB
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 15:40:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FT8eoR4B"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 435F8206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnOZ2-00082o-Er
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 11:40:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58884)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOXS-0005Xx-Iu
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:39:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:43203
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jnOXR-0003PU-0b
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 11:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592840352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6j1pA8flFXxKFgGD7KGcZegLUTAz9cG1BpLNQLqPNk0=;
 b=FT8eoR4BZCQ6kVFhqvMUSn/xuF3DO2G9o1PELzTp6Je7ZXhX6M9lmGenrPW128aH+SWBeb
 Lsxj4QIklWlYCsvWEdIRQyv0K3hGrXsqDpQwCEptJanUXcDzCYlpZv1O5+8JpQWmxhAN/f
 7C2G2qt2ds9kn2DGOO0qx+dSUaQ5Qzo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-j4mNxZEmNR2FIK0oYu3SfA-1; Mon, 22 Jun 2020 11:39:10 -0400
X-MC-Unique: j4mNxZEmNR2FIK0oYu3SfA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C20AF1883607;
 Mon, 22 Jun 2020 15:39:07 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-110.pek2.redhat.com [10.72.13.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 55C6171679;
 Mon, 22 Jun 2020 15:38:44 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [PATCH v1 02/10] vhost_net: use the function qemu_get_peer
Date: Mon, 22 Jun 2020 23:37:48 +0800
Message-Id: <20200622153756.19189-3-lulu@redhat.com>
In-Reply-To: <20200622153756.19189-1-lulu@redhat.com>
References: <20200622153756.19189-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.120; envelope-from=lulu@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 01:27:42
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

user the qemu_get_peer to replace the old process

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/vhost_net.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b82803fa7..4096d64aaf 100644
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
@@ -335,15 +337,16 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *ncs,
     }
 
     for (i = 0; i < total_queues; i++) {
-        r = vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
+        peer = qemu_get_peer(ncs, i);
+        r = vhost_net_start_one(get_vhost_net(peer), dev);
 
         if (r < 0) {
             goto err_start;
         }
 
-        if (ncs[i].peer->vring_enable) {
+        if (peer->vring_enable) {
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


