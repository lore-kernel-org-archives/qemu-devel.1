Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5680BC10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:45:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20F7220828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:45:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="AzQp7wlG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20F7220828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBE2H-0000wl-5y
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:45:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47274)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsE-0007dl-FQ
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsD-0007MZ-3u
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:54 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:38939)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBDsC-0007Kj-TC
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:53 -0400
Received: by mail-wr1-x442.google.com with SMTP id r15so4817921wrx.6
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 01:34:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=GtBl5NGPRd3fWz+5/kWPEnRPZvuPWKDkS2vvT0gB+Y8=;
 b=AzQp7wlG4j1Vug7B6otwVfXrbmxO6FKa1Hdz1wLgzXVqpnRcBbV4602Fy2km70c9KH
 J5qq6BOgA5QJIfYliiOeFEu3L+00Szawzay6+c43eb4T+TXYccjdU+NcvRMyh69cbAda
 hiY56rTNDMDCWo5UMp5uPNVWFqIXiRbo12Q1BBRcu1mumqIZdVKeRstlqHAkkyav9zSJ
 8n5kgpPgtz1Jff8PBBAOJL4TMCnyFzsl4Ic7Z/bZ64D0hlbMLr5oWFIgSLCQpqbSjJ6J
 QFPmolf26nk8DkVXreRQAMY75ZLcgrutLorLjL+AdcnlDyNYBiTvnknd3yRov2LL3CyG
 EpHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=GtBl5NGPRd3fWz+5/kWPEnRPZvuPWKDkS2vvT0gB+Y8=;
 b=Tit7IXJ+vLBWPDAHydeQRXfzOarPkMgv+93A+yMXIMZeYeTF3jWkGLZ9pj8tR0UbIg
 DtR0RNCrfp/T5Jbn7yVUV4AEAnR8VEijUdFE5ZHlfLTiCR6aCAGkDtRYIB9CPnOgDXSC
 wTqf4XkErwBaRLalq8KsBEbkzJ265BjmIvJtrYqZs/HdHnilVO5XieCl21jh84tQtdPl
 KLNBOCANGSu6zhBV61/qq4o4vMCu9ZyOgQ0sq4ar8pXkI+RA3jKos26aaioZ9mF1/3hh
 10UiOHHy2WhBdSDsZwdVKqd/S5mestn+IlFgvJtYmPRqfrqlRbgLU6EQGJIF8nFeX0HW
 dOUw==
X-Gm-Message-State: ANhLgQ3qhx6VaBwFDfGq84ogDX1ryrC3R2zYI/aoWiUmwnwrC3mEVkBL
 LmpYwaPDpLbnmEocmSz6UD4w2y35UFKZ8A==
X-Google-Smtp-Source: ADFU+vvN56lUur+d0DJwlbJkjVd/SFS8A+y6mIhn3EQOfwCYwlWEdan96nmfk7BGKJBaIuybEoC13w==
X-Received: by 2002:adf:de10:: with SMTP id b16mr18932617wrm.145.1583742891592; 
 Mon, 09 Mar 2020 01:34:51 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id h3sm63749726wrb.23.2020.03.09.01.34.50
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Mar 2020 01:34:51 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 3/4] virtio-net: implement RX RSS processing
Date: Mon,  9 Mar 2020 10:34:37 +0200
Message-Id: <20200309083438.2389-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309083438.2389-1-yuri.benditovich@daynix.com>
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
index 27071eccd2..abc41fdb16 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "hw/pci/pci.h"
+#include "net_rx_pkt.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -1610,8 +1611,78 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
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
@@ -1625,6 +1696,14 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
@@ -1719,7 +1798,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size);
+    return virtio_net_receive_rcu(nc, buf, size, false);
 }
 
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
@@ -3295,6 +3374,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
+
+    net_rx_pkt_init(&n->rss_data.pkt, false);
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
@@ -3331,6 +3412,7 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
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


