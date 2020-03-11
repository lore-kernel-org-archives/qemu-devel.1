Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72650C10F29
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 43278208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="qHWMv3w/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 43278208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0d6-00016d-F8
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45189)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aE-0004T5-EI
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aD-0002q0-2Z
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:34 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40048)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jC0aC-0002o4-Rz
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:33 -0400
Received: by mail-wr1-x443.google.com with SMTP id p2so2391376wrw.7
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zArtgZUYsJa+PnubPQn1wsJ3yIzET/oT3p8qfcQh/w4=;
 b=qHWMv3w/NCuc2N5snbqHo2yLzgBfJwgPAkn5FxTn53Zf8927/i+Is4OVkJ0RWCp4E9
 y13ZeNHy5ZKj20pAaZO6ZX4yWc60zDWsLjJS0U59Z2DF+f0NXTJrKG2RIouPrW0+Zn1k
 urNf+yYw5jSd2o9g4nfKarPM9JEDN0f650YH0D8BzPBH/hxblnpw4yvVKe+qyNtou9WD
 8+C8Yj3YUcgVOhZyq/XrTX7lxrp7jd4jqwPLQgk+sK5xZu2pmspokxQGVGpu3GVYIgiK
 rnka/c1+k6F1ZDnWYJA/WoP61XLnKiBUbSSGr04qUDctxoBr1W2BPJ3K10EJTKopejtZ
 5nNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zArtgZUYsJa+PnubPQn1wsJ3yIzET/oT3p8qfcQh/w4=;
 b=ejyMn/10es3fg9GvDbNnZBhGS0vGhd3Oj1WtrLWA0Wu9w5eGpK63UEjXHcGT/gO2W6
 3K/U6G5/9N1CBMmCI7+w93Hq0RtzSygZAo/oS2GKVL1x1+otgJ2LiorVKO3ASRxHV3lS
 qPtrraGefXlzNl81SQ0xSKzvsrlktoi3TfT/qbGrHSHwSZGeUKcZmkZJQMPdVsgDfUMm
 a5s3Oo9fCE+SPeO/0f1QibV6GB/LIBmJ5hwdpcGQ4Zc0rSiyoRWRp17vgOT+Ut8UHIiA
 0MxO6YTztycd6NTGfliWzIi9Mk9Ch3V3qdTO+TYqBZemfvCqu9yl5Oa6zEHyTjJAmBQa
 r8tw==
X-Gm-Message-State: ANhLgQ1c2aUzyqx1QI8rWbkDi7DadBTPPdukwmCkfnS2ldKxU+i4ksD+
 LayKeFZ0kS2Gq+8gyVKpNAWedERgcuRJYA==
X-Google-Smtp-Source: ADFU+vuMP9l5tPVqgaTgmUpLNj1nnjvYdjW2+5dgp8INuMCqlMAxf4PxLo3tKkenWltr397OzZ6ZZQ==
X-Received: by 2002:a05:6000:12d2:: with SMTP id
 l18mr4175837wrx.240.1583930131534; 
 Wed, 11 Mar 2020 05:35:31 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id o11sm61480696wrn.6.2020.03.11.05.35.30
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 05:35:31 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 3/6] virtio-net: implement RX RSS processing
Date: Wed, 11 Mar 2020 14:35:15 +0200
Message-Id: <20200311123518.4025-4-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311123518.4025-1-yuri.benditovich@daynix.com>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
 hw/net/virtio-net.c            | 88 +++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 1747b8dca7..b9654cce91 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "hw/pci/pci.h"
+#include "net_rx_pkt.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -1620,8 +1621,80 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
     return 0;
 }
 
+static uint8_t virtio_net_get_hash_type(bool isip4,
+                                        bool isip6,
+                                        bool isudp,
+                                        bool istcp,
+                                        uint32_t types)
+{
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
+        uint32_t mask = VIRTIO_NET_RSS_HASH_TYPE_TCP_EX |
+                        VIRTIO_NET_RSS_HASH_TYPE_TCPv6;
+
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
+    struct NetRxPkt *pkt = n->rx_pkt;
+    uint8_t net_hash_type;
+    uint32_t hash;
+    bool isip4, isip6, isudp, istcp;
+
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
@@ -1635,6 +1708,14 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
@@ -1729,7 +1810,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size);
+    return virtio_net_receive_rcu(nc, buf, size, false);
 }
 
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
@@ -3305,6 +3386,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
+
+    net_rx_pkt_init(&n->rx_pkt, false);
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
@@ -3341,6 +3424,7 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
     g_free(n->vqs);
     qemu_del_nic(n->nic);
     virtio_net_rsc_cleanup(n);
+    net_rx_pkt_uninit(n->rx_pkt);
     virtio_cleanup(vdev);
 }
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index ebd81e29eb..0fd960b1a0 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -215,6 +215,7 @@ struct VirtIONet {
         VirtioNetRssData rss_data;
         uint8_t rss_data_migration[sizeof(VirtioNetRssData)];
     };
+    struct NetRxPkt *rx_pkt;
 };
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
-- 
2.17.1


