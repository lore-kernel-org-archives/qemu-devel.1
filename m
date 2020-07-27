Return-Path: <SRS0=cfdO=BG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A93C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:52:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29762206E7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2020 12:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dwIJjcHL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29762206E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k02cd-0000lS-F2
	for qemu-devel@archiver.kernel.org; Mon, 27 Jul 2020 08:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k02br-0008PA-9C
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:52:03 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:53600
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k02bp-0001n8-I9
 for qemu-devel@nongnu.org; Mon, 27 Jul 2020 08:52:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595854320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ziK62NPFE+h1hWBxVnfPWzQnp4NkUiewSsIzh0Y7llY=;
 b=dwIJjcHLlXxlZgnD9Jz4JPkHtUBUj91OPcuDxjYGlX4a9TEq6jAych49+wUmJWGEMHTqHU
 HA2LByaSUft67cPinPyue0cvzAHLxVBEIU652x9tFTlomiJNYh5m37fJCHTe00HGnWa2C9
 oSyJgpKX8ZjE4Wh3UOzxsXd32O3nt4U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-194-RxHKDfm7NBmm8XEoBsrGeA-1; Mon, 27 Jul 2020 08:51:58 -0400
X-MC-Unique: RxHKDfm7NBmm8XEoBsrGeA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA60B1005510
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2020 12:51:57 +0000 (UTC)
Received: from jason-ThinkPad-X1-Carbon-6th.redhat.com
 (ovpn-12-71.pek2.redhat.com [10.72.12.71])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8711710013C0;
 Mon, 27 Jul 2020 12:51:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH V2] virtio-net: check the existence of peer before accessing
 vDPA config
Date: Mon, 27 Jul 2020 20:51:50 +0800
Message-Id: <20200727125150.4687-1-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 01:46:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: cohuck@redhat.com, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We try to check whether a peer is VDPA in order to get config from
there - with no peer, this leads to a NULL
pointer dereference. Add a check before trying to access the peer
type. No peer means not VDPA.

Fixes: 108a64818e69b ("vhost-vdpa: introduce vhost-vdpa backend")
Cc: Cindy Lu <lulu@redhat.com>
Tested-by: Cornelia Huck <cohuck@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
Changes from V1:
- Tweak the log
- Add the comment in the code
---
 hw/net/virtio-net.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4895af1cbe..a1fe9e9285 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -125,6 +125,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_config netcfg;
+    NetClientState *nc = qemu_get_queue(n->nic);
 
     int ret = 0;
     memset(&netcfg, 0 , sizeof(struct virtio_net_config));
@@ -142,13 +143,16 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
                  VIRTIO_NET_RSS_SUPPORTED_HASHES);
     memcpy(config, &netcfg, n->config_size);
 
-    NetClientState *nc = qemu_get_queue(n->nic);
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+    /*
+     * Is this VDPA? No peer means not VDPA: there's no way to
+     * disconnect/reconnect a VDPA peer.
+     */
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
         ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
-                             n->config_size);
-    if (ret != -1) {
-        memcpy(config, &netcfg, n->config_size);
-    }
+                                   n->config_size);
+        if (ret != -1) {
+            memcpy(config, &netcfg, n->config_size);
+        }
     }
 }
 
@@ -156,6 +160,7 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_config netcfg = {};
+    NetClientState *nc = qemu_get_queue(n->nic);
 
     memcpy(&netcfg, config, n->config_size);
 
@@ -166,11 +171,14 @@ static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
     }
 
-    NetClientState *nc = qemu_get_queue(n->nic);
-    if (nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
-        vhost_net_set_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
-                               0, n->config_size,
-                        VHOST_SET_CONFIG_TYPE_MASTER);
+    /*
+     * Is this VDPA? No peer means not VDPA: there's no way to
+     * disconnect/reconnect a VDPA peer.
+     */
+    if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        vhost_net_set_config(get_vhost_net(nc->peer),
+                             (uint8_t *)&netcfg, 0, n->config_size,
+                             VHOST_SET_CONFIG_TYPE_MASTER);
       }
 }
 
-- 
2.20.1


