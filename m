Return-Path: <SRS0=NBT7=6W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E37C38A2A
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE6F424969
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2020 13:08:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="x6WmMK7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE6F424969
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50170 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jX2jl-0006px-V2
	for qemu-devel@archiver.kernel.org; Fri, 08 May 2020 09:08:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53848)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Ww-0007Nf-FN
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:06 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36635)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jX2Wv-0003LP-5T
 for qemu-devel@nongnu.org; Fri, 08 May 2020 08:55:06 -0400
Received: by mail-wr1-x442.google.com with SMTP id z8so1729037wrw.3
 for <qemu-devel@nongnu.org>; Fri, 08 May 2020 05:55:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=touW0hq6McA5DWWhPyvzubKbZLnGrRP3iQtMaqPPHa8=;
 b=x6WmMK7yyHgfpwjvKXT60wf+bV0LYm8umtvZKE2rEbBTOPhB7t13CSJRlW5o+Q8j8l
 BzsLMvlbk7bVcylWjJ3Eo44sJq3l0hmLbeoAU36U3zj10t1ArSl3hZgjKfhfgtggy5/q
 xTf+qRom/WKKMYcaKbml9X8kFm2Y1h1t7tkRKkrpZhlssk+H7eg9/erw9jvJTKqrvzO8
 TOMdoPmmhHhJcPGGBmQQWvBRYJ0L5JbdCqj9crjTBgkw4Ra6b9yPB68cuKvFTVFVS+LV
 oo90hQi2kzFfPK7cVjzlcfdqAk1nq6RAmET1yxn0b3e2VnabB1wVV9WRMBr/puaHS6L3
 XlMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=touW0hq6McA5DWWhPyvzubKbZLnGrRP3iQtMaqPPHa8=;
 b=Q6u8yx1wFhNxndORDEq3Mr9cEpq0rSY20yK9LL/aVvc2kc4J3M9rg+oNUK3X/CSP9d
 tPgdPZlesq+wD2crhSmeYgrFRrRQk+jInT78kJTTlBygnTYBrAstMYwR5noeR4jBiJVc
 0MNcc9Cdoc7W20/0YdCHK6FcAUIPEDXF58DGSTUXHShhrw4lob79QR4quIONnyZxjyu7
 /tS2YcRG1d/gEdvOmHmCvqlk4Tc+eSSXumMszXVHG+4MaYgpSpnZFE3/qSHv6oc1FKX4
 auAzVehcf365OokBjiQO4zPZPy/RKY3aNJq4nfOLIMQZBM7hJAgR810cOxjxmPjzSqyr
 ElWg==
X-Gm-Message-State: AGi0PuYO7dh4NKK2cxKFtohWtooZ2p8KT0AuVn6Zfsitj1fqcadm/jR3
 5pmBAeCJ3liE0sOYv8qQMYtyxXNS/Jwisw==
X-Google-Smtp-Source: APiQypL3/NhaOWyOjAU6/JfmQNj9pNngWmUqKl6TjA+uHV/xeNvCUycTvRIcqdGCtOGzzGYsMZV0uw==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr2898530wrs.350.1588942502461; 
 Fri, 08 May 2020 05:55:02 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-19-16.red.bezeqint.net.
 [79.183.19.16])
 by smtp.gmail.com with ESMTPSA id a8sm2852375wrg.85.2020.05.08.05.55.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
 Fri, 08 May 2020 05:55:02 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH 2/7] virtio-net: implement RX RSS processing
Date: Fri,  8 May 2020 15:54:47 +0300
Message-Id: <20200508125452.7802-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508125452.7802-1-yuri.benditovich@daynix.com>
References: <20200508125452.7802-1-yuri.benditovich@daynix.com>
Received-SPF: none client-ip=2a00:1450:4864:20::442;
 envelope-from=yuri.benditovich@daynix.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
index 75e9769f79..3511ea6c13 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -42,6 +42,7 @@
 #include "trace.h"
 #include "monitor/qdev.h"
 #include "hw/pci/pci.h"
+#include "net_rx_pkt.h"
 
 #define VIRTIO_NET_VM_VERSION    11
 
@@ -1533,8 +1534,80 @@ static int receive_filter(VirtIONet *n, const uint8_t *buf, int size)
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
+    new_index = n->rss_data.indirections_table[new_index];
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
@@ -1548,6 +1621,14 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
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
@@ -1642,7 +1723,7 @@ static ssize_t virtio_net_do_receive(NetClientState *nc, const uint8_t *buf,
 {
     RCU_READ_LOCK_GUARD();
 
-    return virtio_net_receive_rcu(nc, buf, size);
+    return virtio_net_receive_rcu(nc, buf, size, false);
 }
 
 static void virtio_net_rsc_extract_unit4(VirtioNetRscChain *chain,
@@ -3221,6 +3302,8 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     QTAILQ_INIT(&n->rsc_chains);
     n->qdev = dev;
+
+    net_rx_pkt_init(&n->rx_pkt, false);
 }
 
 static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
@@ -3258,6 +3341,7 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
     qemu_del_nic(n->nic);
     virtio_net_rsc_cleanup(n);
     g_free(n->rss_data.indirections_table);
+    net_rx_pkt_uninit(n->rx_pkt);
     virtio_cleanup(vdev);
 }
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index d3fad7c8f3..5081f3c52a 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -212,6 +212,7 @@ struct VirtIONet {
     DeviceListener primary_listener;
     Notifier migration_state;
     VirtioNetRssData rss_data;
+    struct NetRxPkt *rx_pkt;
 };
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
-- 
2.17.1


