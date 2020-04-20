Return-Path: <SRS0=IvAo=6E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99569C3815B
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:43:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63EC120857
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2020 13:43:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZeCtimIr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63EC120857
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jQWhc-0004HD-Gp
	for qemu-devel@archiver.kernel.org; Mon, 20 Apr 2020 09:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44082 helo=eggs1p.gnu.org)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQSpT-00040n-HV
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:35:03 -0400
Received: from Debian-exim by eggs1p.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <lulu@redhat.com>) id 1jQSpS-0004Rs-Vx
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:35:03 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27016
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1jQSpS-0004Qu-JE
 for qemu-devel@nongnu.org; Mon, 20 Apr 2020 05:35:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1587375302;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=moQA5ztc3Yw+N49069KRQBO7QJ36CZ0pzA0Cdh1gfLI=;
 b=ZeCtimIrh4hD+TRZpNZtOFA9tlHYq/mPTC4+CeQNhLjfQdHTFR/Jq4hjtK1XKjaRM8Z91S
 comgChy83mdG+3Jh+J5CN3jGD7qHcXwl6cynvzRK3be9Jv6IzvhqPe2AE8M4s9hBXkudNr
 9/bJ4glQdS/L9ej3MQ/x6jIALv4clsQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-13-f4RZ7gWQPvWfQGERoX3QSA-1; Mon, 20 Apr 2020 05:33:31 -0400
X-MC-Unique: f4RZ7gWQPvWfQGERoX3QSA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29A3A1902EA2;
 Mon, 20 Apr 2020 09:33:29 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-12-243.pek2.redhat.com [10.72.12.243])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8D7E092FA1;
 Mon, 20 Apr 2020 09:33:11 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com, armbru@redhat.com, eblake@redhat.com, cohuck@redhat.com,
 jasowang@redhat.com
Subject: [RFC v1 1/4] net: Introduce qemu_get_peer
Date: Mon, 20 Apr 2020 17:32:38 +0800
Message-Id: <20200420093241.4238-2-lulu@redhat.com>
In-Reply-To: <20200420093241.4238-1-lulu@redhat.com>
References: <20200420093241.4238-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs1p.gnu.org: First seen = 2020/04/20
 01:47:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Received-From: 207.211.31.81
X-Mailman-Approved-At: Mon, 20 Apr 2020 09:36:04 -0400
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

This is a small function  that can get the peer from given NetClientState a=
nd queue_index

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/vhost_net.c | 16 ++++++++++------
 include/net/net.h  |  1 +
 net/net.c          |  6 ++++++
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 6b82803fa7..4096d64aaf 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -306,7 +306,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *=
ncs,
     BusState *qbus =3D BUS(qdev_get_parent_bus(DEVICE(dev)));
     VirtioBusState *vbus =3D VIRTIO_BUS(qbus);
     VirtioBusClass *k =3D VIRTIO_BUS_GET_CLASS(vbus);
+    struct vhost_net *net;
     int r, e, i;
+    NetClientState *peer;
=20
     if (!k->set_guest_notifiers) {
         error_report("binding does not support guest notifiers");
@@ -314,9 +316,9 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *=
ncs,
     }
=20
     for (i =3D 0; i < total_queues; i++) {
-        struct vhost_net *net;
=20
-        net =3D get_vhost_net(ncs[i].peer);
+        peer =3D qemu_get_peer(ncs, i);
+        net =3D get_vhost_net(peer);
         vhost_net_set_vq_index(net, i * 2);
=20
         /* Suppress the masking guest notifiers on vhost user
@@ -335,15 +337,16 @@ int vhost_net_start(VirtIODevice *dev, NetClientState=
 *ncs,
     }
=20
     for (i =3D 0; i < total_queues; i++) {
-        r =3D vhost_net_start_one(get_vhost_net(ncs[i].peer), dev);
+        peer =3D qemu_get_peer(ncs, i);
+        r =3D vhost_net_start_one(get_vhost_net(peer), dev);
=20
         if (r < 0) {
             goto err_start;
         }
=20
-        if (ncs[i].peer->vring_enable) {
+        if (peer->vring_enable) {
             /* restore vring enable state */
-            r =3D vhost_set_vring_enable(ncs[i].peer, ncs[i].peer->vring_e=
nable);
+            r =3D vhost_set_vring_enable(peer, peer->vring_enable);
=20
             if (r < 0) {
                 goto err_start;
@@ -355,7 +358,8 @@ int vhost_net_start(VirtIODevice *dev, NetClientState *=
ncs,
=20
 err_start:
     while (--i >=3D 0) {
-        vhost_net_stop_one(get_vhost_net(ncs[i].peer), dev);
+        peer =3D qemu_get_peer(ncs , i);
+        vhost_net_stop_one(get_vhost_net(peer), dev);
     }
     e =3D k->set_guest_notifiers(qbus->parent, total_queues * 2, false);
     if (e < 0) {
diff --git a/include/net/net.h b/include/net/net.h
index e175ba9677..0a74324ccd 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -175,6 +175,7 @@ void hmp_info_network(Monitor *mon, const QDict *qdict)=
;
 void net_socket_rs_init(SocketReadState *rs,
                         SocketReadStateFinalize *finalize,
                         bool vnet_hdr);
+NetClientState *qemu_get_peer(NetClientState *nc, int queue_index);
=20
 /* NIC info */
=20
diff --git a/net/net.c b/net/net.c
index 84aa6d8d00..ac5080dda1 100644
--- a/net/net.c
+++ b/net/net.c
@@ -324,6 +324,12 @@ void *qemu_get_nic_opaque(NetClientState *nc)
=20
     return nic->opaque;
 }
+NetClientState *qemu_get_peer(NetClientState *nc, int queue_index)
+{
+    NetClientState *ncs  =3D  nc + queue_index;
+    assert(ncs !=3D NULL);
+    return ncs->peer;
+}
=20
 static void qemu_cleanup_net_client(NetClientState *nc)
 {
--=20
2.21.1


