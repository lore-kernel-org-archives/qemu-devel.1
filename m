Return-Path: <SRS0=L+nc=BH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14F74C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:11:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7C5D20759
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2020 09:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Lwx908Mb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D7C5D20759
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50804 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k0LeA-0007aG-4r
	for qemu-devel@archiver.kernel.org; Tue, 28 Jul 2020 05:11:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60014)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Ld8-0006Lt-2K
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:10:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:36863
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1k0Ld6-0007Ca-CZ
 for qemu-devel@nongnu.org; Tue, 28 Jul 2020 05:10:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1595927435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=n03KLV8sGAHwM3z7JXtuYCSL1E+BbALjV9c8F3Y1sHs=;
 b=Lwx908MbaQtwyENLmdp7Hip0p3sBm0A3p/WKFIpBumKI2vPIOsrxOw0vjPpunoSqJDCQkd
 1uJLzVJ4Rt7nCCVWC+BZ+pTUT+Jl9Fib9czyS6w/T/HsE67oB61btbcfrVX+RVB5AF/8KA
 nojAxuz+jV4Hiu+Z+Bz6ZbYYYUeBn4I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-JSKjLX9DPJSsIbZeVtrOrw-1; Tue, 28 Jul 2020 05:10:33 -0400
X-MC-Unique: JSKjLX9DPJSsIbZeVtrOrw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E08B31DE2;
 Tue, 28 Jul 2020 09:10:32 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-214.pek2.redhat.com
 [10.72.12.214])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 24EE890E6D;
 Tue, 28 Jul 2020 09:10:30 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 2/3] virtio-net: check the existence of peer before
 accessing vDPA config
Date: Tue, 28 Jul 2020 17:10:18 +0800
Message-Id: <1595927419-27346-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1595927419-27346-1-git-send-email-jasowang@redhat.com>
References: <1595927419-27346-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/27 23:55:28
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Cindy Lu <lulu@redhat.com>
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
 hw/net/virtio-net.c | 30 +++++++++++++++++++-----------
 1 file changed, 19 insertions(+), 11 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 4895af1..a1fe9e9 100644
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
2.7.4


