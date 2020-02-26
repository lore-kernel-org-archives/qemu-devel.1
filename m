Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD00DC4BA1E
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:51:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A6D52067C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:51:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Q0nzSmba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A6D52067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70pq-00084W-RE
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:51:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nG-0004GW-Qb
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nF-0003YX-Ja
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:22 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38157)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j70nF-0003X5-BQ
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:21 -0500
Received: by mail-wm1-x343.google.com with SMTP id a9so161489wmj.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=r8QR8/6myPTxOG/zE+PYfWVRq8kuB57xhUuFMpl5zoU=;
 b=Q0nzSmbagsa28z8upqGzL53/jCwIGUtuB14n7TTcKheNrFC+dgXIsd2m04f2ZFlFaJ
 sJJRSmBE8EnHgS51EIgMGvBRRpQQw2P4x9sqBnBAf8A2UxxzHbjEUV9ZkeXcv/IYFR+6
 Zqel1MoXFD9gLs+wUUdK6eJ5Toj2ZiSfS9ZZDw3FaAh7BdDJculYfH5TzJ1XiQTc4HA3
 O2UOnROgySfjj3xfNydaj00Y/xkdPxQcBH7H2XOHOjZin2hy4lEHAr5OR7fTbrdxCSmB
 ESLke0z4Pa5ZU+vlRQMK3L4hZ3xkUexchTDxtigD59K2Z2bVvI+VKF+kAfFIW0c5u2pz
 +8Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=r8QR8/6myPTxOG/zE+PYfWVRq8kuB57xhUuFMpl5zoU=;
 b=b96NX9KIBXrrZwD9wllRKfReFDUAopYHGugO/lEqG50bpA2NJc0Jzk++6BtYx09o54
 4Uk0ZWTc5O/5fiAkN9YRGHt2evy+BGqIl3rRBO54H7wY+olM53hRgeGn3H0if0nPscp5
 Cv+Mo7mZekhov91H7b6DxBR/9cEPFXmXDWwA5KqJ4jy30OqTO2EIRAC47KPVX+4xcq/J
 eSalLSy9k/YlPtsyxdBHsM4szDBniDOJYNP4mu1wB46WNjogCZxWNGw6bVGiQQbAYqz7
 yDaj+PM3o8BQAO6ZTYTZ1HnLxEFtD+T2xx8hqRVGdIx8OUGDtlBxsDsc9Xl1NfgoFF2b
 Sr7g==
X-Gm-Message-State: APjAAAUmOiSlAtCbxamzL3QJNBANlJXbPwZfLkvJkCRSE8ORE9ZlTXpa
 OoPVBfWyFIrzamh8XDEasPpof5sQ2gM=
X-Google-Smtp-Source: APXvYqxjPbr1gw1aUsNXO4/FaNzbDnBB2OZ6s9dzD1WDgFo4zEXUe75OGyLhqTWCPEDH6KQGPdh3uQ==
X-Received: by 2002:a1c:2b44:: with SMTP id r65mr49474wmr.72.1582739300028;
 Wed, 26 Feb 2020 09:48:20 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id b21sm3930520wmd.37.2020.02.26.09.48.18
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Feb 2020 09:48:19 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 3/3] virtio-net: implement RX RSS processing
Date: Wed, 26 Feb 2020 19:48:09 +0200
Message-Id: <20200226174809.9675-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226174809.9675-1-yuri.benditovich@daynix.com>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Cc: yan@daynix.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
incoming packets, calculate packet's hash and place the
packet into respective RX virtqueue.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c            | 86 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index c5d21675a9..adf7b88d7a 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "hw/pci/pci.h"
+#include "net_rx_pkt.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -1515,8 +1516,78 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     return 0;
 }
 
+static uint8_t virtio_net_get_hash_type(bool isip4,
+                                        bool isip6,
+                                        bool isudp,
+                                        bool istcp,
+                                        uint32_t types)
+{
+    uint32_t mask;
+    if (isip4) {
+        if (istcp && (types & VIRTIO_NET_RSS_HASH_TYPE_TCPv4)) {
+            return NetPktRssIpV4Tcp;
+        }
+        if (isudp && (types & VIRTIO_NET_RSS_HASH_TYPE_UDPv4)) {
+            return NetPktRssIpV4Udp;
+        }
+        if (types & VIRTIO_NET_RSS_HASH_TYPE_IPv4) {
+            return NetPktRssIpV4;
+        }
+    } else if (isip6) {
+        mask = VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
+        if (istcp && (types & mask)) {
+            return (types & VIRTIO_NET_RSS_HASH_TYPE_TCP_EX) ?
+                NetPktRssIpV6TcpEx : NetPktRssIpV6Tcp;
+        }
+        mask = VIRTIO_NET_RSS_HASH_TYPE_UDP_EX | VIRTIO_NET_RSS_HASH_TYPE_UDPv6;
+        if (isudp && (types & mask)) {
+            return (types & VIRTIO_NET_RSS_HASH_TYPE_UDP_EX) ?
+                NetPktRssIpV6UdpEx : NetPktRssIpV6Udp;
+        }
+        mask = VIRTIO_NET_RSS_HASH_TYPE_IP_EX | VIRTIO_NET_RSS_HASH_TYPE_IPv6;
+        if (types & mask) {
+            return (types & VIRTIO_NET_RSS_HASH_TYPE_IP_EX) ?
+                NetPktRssIpV6Ex : NetPktRssIpV6;
+        }
+    }
+    return 0xff;
+}
+
+static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
+                                  size_t size)
+{
+    VirtIONet *n = qemu_get_nic_opaque(nc);
+    unsigned int index = nc->queue_index, new_index;
+    struct NetRxPkt *pkt = n->rss_data.pkt;
+    uint8_t net_hash_type;
+    uint32_t hash;
+    bool isip4, isip6, isudp, istcp;
+    net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
+                             size - n->host_hdr_len);
+    net_rx_pkt_get_protocols(pkt, &isip4, &isip6, &isudp, &istcp);
+    if (isip4 && (net_rx_pkt_get_ip4_info(pkt)->fragment)) {
+        istcp = isudp = false;
+    }
+    if (isip6 && (net_rx_pkt_get_ip6_info(pkt)->fragment)) {
+        istcp = isudp = false;
+    }
+    net_hash_type = virtio_net_get_hash_type(isip4, isip6, isudp, istcp,
+                                             n->rss_data.hash_types);
+    if (net_hash_type > NetPktRssIpV6UdpEx) {
+        return n->rss_data.default_queue;
+    }
+
+    hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
+    new_index = hash & (n->rss_data.indirections_len - 1);
+    new_index = n->rss_data.indirections[new_index];
+    if (index == new_index) {
+        return -1;
+    }
+    return new_index;
+}
+
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
-                                      size_t size)
+                                      size_t size, bool no_rss)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
     VirtIONetQueue *q = virtio_net_get_subqueue(nc);
@@ -1530,6 +1601,14 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
+    if (!no_rss && n->rss_data.enabled) {
+        int index = virtio_net_process_rss(nc, buf, size);
+        if (index >= 0) {
+            NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
+            return virtio_net_receive_rcu(nc2, buf, size, true);
+        }
+    }
+
     /* hdr_len refers to the header we supply to the guest */
     if (!virtio_net_has_buffers(q, size + n->guest_hdr_len - n->host_hdr_len)) {
         return 0;
@@ -1624,7 +1703,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size);
+    return virtio_net_receive_rcu(nc, buf, size, false);
 }
 
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
@@ -3200,6 +3279,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
+
+    net_rx_pkt_init(&n->rss_data.pkt, false);
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
@@ -3236,6 +3317,7 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
     g_free(n->vqs);
     qemu_del_nic(n->nic);
     virtio_net_rsc_cleanup(n);
+    net_rx_pkt_uninit(n->rss_data.pkt);
     virtio_cleanup(vdev);
 }
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index cf16f5192e..45670dd054 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -209,6 +209,7 @@ struct VirtIONet {
         uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
         uint16_t indirections_len;
         uint16_t default_queue;
+        struct NetRxPkt *pkt;
     } rss_data;
 };
 
-- 
2.17.1


