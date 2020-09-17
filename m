Return-Path: <SRS0=BocF=C2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C0F4C43461
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:05:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D952C222E8
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2020 16:05:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M09V2maw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D952C222E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38612 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIwPq-0001dM-LE
	for qemu-devel@archiver.kernel.org; Thu, 17 Sep 2020 12:05:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43808)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kIwLZ-0005mM-Gd
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:01:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:32064
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <lulu@redhat.com>) id 1kIwLW-00041V-3p
 for qemu-devel@nongnu.org; Thu, 17 Sep 2020 12:01:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600358474;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=QhwIIq6a0+YfK49f4JaAdTt9eTSDxK2rVduNej4Utns=;
 b=M09V2mawHtjLpSBMCsjyNQUmz7qZG0MBFiCBcuwx0iVW0vRJViMXzu+Yveb9IWEKwQMaeS
 iec7WTft0LMJULsWNP5fv6pk6E3/ey6WysQLa+Hdk/oHNE73w8tWWBECNVuQUB8w/Rd9eC
 Gp6PWypXes5/8BBAqC8nIJ6qAz0qVb0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-394-5ra3zn8IMfehHKEjckcxRw-1; Thu, 17 Sep 2020 12:00:02 -0400
X-MC-Unique: 5ra3zn8IMfehHKEjckcxRw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BEFC08BF159;
 Thu, 17 Sep 2020 16:00:01 +0000 (UTC)
Received: from laptop.redhat.com (ovpn-13-113.pek2.redhat.com [10.72.13.113])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D4CF2610F2;
 Thu, 17 Sep 2020 15:59:56 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: mst@redhat.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 1/3] virtio-net: Set mac address to hardware if the peer is
 vdpa
Date: Thu, 17 Sep 2020 23:58:49 +0800
Message-Id: <20200917155851.20636-1-lulu@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lulu@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=lulu@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/17 03:47:35
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
Cc: qemu-stable@nongnu.org, Cindy Lu <lulu@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If the peer's type is vdpa,set the mac address to NIC in virtio_net_device_realize,
Also sometime vdpa get an all 0 macaddress from the hardware, this will cause the traffic down
So we add the check for this part.
if we get an 0 mac address we will use the default mac address instead

Signed-off-by: Cindy Lu <lulu@redhat.com>
---
 hw/net/virtio-net.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index cb0d27084c..7db9da1482 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -126,6 +126,7 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     VirtIONet *n = VIRTIO_NET(vdev);
     struct virtio_net_config netcfg;
     NetClientState *nc = qemu_get_queue(n->nic);
+    static const MACAddr zero = { .a = { 0, 0, 0, 0, 0, 0 } };
 
     int ret = 0;
     memset(&netcfg, 0 , sizeof(struct virtio_net_config));
@@ -151,7 +152,11 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
         ret = vhost_net_get_config(get_vhost_net(nc->peer), (uint8_t *)&netcfg,
                                    n->config_size);
         if (ret != -1) {
-            memcpy(config, &netcfg, n->config_size);
+            if (memcmp(&netcfg.mac, &zero, sizeof(zero)) != 0) {
+                memcpy(config, &netcfg, n->config_size);
+        } else {
+                error_report("Get an all zero mac address from hardware");
+            }
         }
     }
 }
@@ -3399,6 +3404,11 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
     nc = qemu_get_queue(n->nic);
     nc->rxfilter_notify_enabled = 1;
 
+   if (nc->peer && nc->peer->info->type == NET_CLIENT_DRIVER_VHOST_VDPA) {
+        struct virtio_net_config netcfg = {};
+        memcpy(&netcfg.mac, &n->nic_conf.macaddr, ETH_ALEN);
+        virtio_net_set_config(vdev, (uint8_t *)&netcfg);
+    }
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
 
-- 
2.21.3


