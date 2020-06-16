Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 187E1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:50:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D564D2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X/bll8ma"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D564D2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5Qi-0006p4-36
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:50:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5MB-0001TO-Gw
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:04 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54957
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5M8-0005Xa-Qg
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=SmCH46ekmE2CGGxJ9qoqWU+gNaRRz5t6QABzW7n9E7c=;
 b=X/bll8maStV5FR/g+DCmL5wFby80BsO3dNbd2ABYNqT6GiUyFNrLC9rZLXtJpR0im8MLvY
 rJPGa5wZiEMlEESjUqjaR7zTXF6f8OUD73etZTwel/prTn8tIfpaChk2upmdPY/XWrYBF3
 wceZNkPgWO3/dEcgjVLqBND5X9XDE7U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-IsFxkZCqO9q3-WJbDIGuNg-1; Tue, 16 Jun 2020 02:45:55 -0400
X-MC-Unique: IsFxkZCqO9q3-WJbDIGuNg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CB681138302;
 Tue, 16 Jun 2020 06:45:54 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF82B8202D;
 Tue, 16 Jun 2020 06:45:52 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 02/33] virtio-net: implement RX RSS processing
Date: Tue, 16 Jun 2020 14:45:13 +0800
Message-Id: <1592289944-13727-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=jasowang@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:57
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

If VIRTIO_NET_F_RSS negotiated and RSS is enabled, process
incoming packets, calculate packet's hash and place the
packet into respective RX virtqueue.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c            | 88 +++++++++++++++++++++++++++++++++++++++++-
 include/hw/virtio/virtio-net.h |  1 +
 2 files changed, 87 insertions(+), 2 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index e803b0a..556f221 100644
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
 
 static void virtio_net_device_unrealize(DeviceState *dev)
@@ -3258,6 +3341,7 @@ static void virtio_net_device_unrealize(DeviceState *dev)
     qemu_del_nic(n->nic);
     virtio_net_rsc_cleanup(n);
     g_free(n->rss_data.indirections_table);
+    net_rx_pkt_uninit(n->rx_pkt);
     virtio_cleanup(vdev);
 }
 
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index d3fad7c..5081f3c 100644
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
2.5.0


