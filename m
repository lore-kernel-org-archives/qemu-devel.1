Return-Path: <SRS0=f7ls=75=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A23DC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:53:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D838A2074D
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2020 06:52:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hloeTlRP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D838A2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60028 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jl5St-0001zt-1c
	for qemu-devel@archiver.kernel.org; Tue, 16 Jun 2020 02:52:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41844)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5MH-0001Ti-D4
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50593
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jl5MB-0005Xq-2q
 for qemu-devel@nongnu.org; Tue, 16 Jun 2020 02:46:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592289962;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=/3oFfb/3XrFuq5KHOcw9d1Fe65y+I7hDIOqdJEpidsI=;
 b=hloeTlRPLve+sQAvQOLWJkXL0/cOb+5Nazo6EdO7upaFGz1/GII4dY55Y690Au3Ae1TP+u
 kPWyJ9055GHPuwJOPYgnZj+CGhRyVjGGn/7GrHDSvIpDcXA7Vr9cIiFLtH0BGNXNb/KmNP
 sxyEb7UiVDdUgg1ciPuWJt3+Si4NDs4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-354-RYbvt3fXMrmzlcIGitkRVQ-1; Tue, 16 Jun 2020 02:45:59 -0400
X-MC-Unique: RYbvt3fXMrmzlcIGitkRVQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BD2888035E4;
 Tue, 16 Jun 2020 06:45:58 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-13-222.pek2.redhat.com
 [10.72.13.222])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 265B58202D;
 Tue, 16 Jun 2020 06:45:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 04/33] virtio-net: reference implementation of hash report
Date: Tue, 16 Jun 2020 14:45:15 +0800
Message-Id: <1592289944-13727-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
References: <1592289944-13727-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/16 02:45:54
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

Suggest VIRTIO_NET_F_HASH_REPORT if specified in device
parameters.
If the VIRTIO_NET_F_HASH_REPORT is set,
the device extends configuration space. If the feature
is negotiated, the packet layout is extended to
accomodate the hash information. In this case deliver
packet's hash value and report type in virtio header
extension.
Use for configuration the same procedure as already
used for RSS. We add two fields in rss_data that
controls what the device does with the calculated hash
if rss_data.enabled is set. If field 'populate' is set
the hash is set in the packet, if field 'redirect' is
set the hash is used to decide the queue to place the
packet to.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/virtio-net.c            | 99 +++++++++++++++++++++++++++++++++---------
 include/hw/virtio/virtio-net.h |  2 +
 2 files changed, 81 insertions(+), 20 deletions(-)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 556f221..6ff3cc3 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -119,7 +119,7 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, mtu)},
     {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
      .end = endof(struct virtio_net_config, duplex)},
-    {.flags = 1ULL << VIRTIO_NET_F_RSS,
+    {.flags = (1ULL << VIRTIO_NET_F_RSS) | (1ULL << VIRTIO_NET_F_HASH_REPORT),
      .end = endof(struct virtio_net_config, supported_hash_types)},
     {}
 };
@@ -153,7 +153,8 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     netcfg.duplex = n->net_conf.duplex;
     netcfg.rss_max_key_size = VIRTIO_NET_RSS_MAX_KEY_SIZE;
     virtio_stw_p(vdev, &netcfg.rss_max_indirection_table_length,
-                 VIRTIO_NET_RSS_MAX_TABLE_LEN);
+                 virtio_host_has_feature(vdev, VIRTIO_NET_F_RSS) ?
+                 VIRTIO_NET_RSS_MAX_TABLE_LEN : 1);
     virtio_stl_p(vdev, &netcfg.supported_hash_types,
                  VIRTIO_NET_RSS_SUPPORTED_HASHES);
     memcpy(config, &netcfg, n->config_size);
@@ -579,7 +580,7 @@ static int peer_has_ufo(VirtIONet *n)
 }
 
 static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
-                                       int version_1)
+                                       int version_1, int hash_report)
 {
     int i;
     NetClientState *nc;
@@ -587,7 +588,10 @@ static void virtio_net_set_mrg_rx_bufs(VirtIONet *n, int mergeable_rx_bufs,
     n->mergeable_rx_bufs = mergeable_rx_bufs;
 
     if (version_1) {
-        n->guest_hdr_len = sizeof(struct virtio_net_hdr_mrg_rxbuf);
+        n->guest_hdr_len = hash_report ?
+            sizeof(struct virtio_net_hdr_v1_hash) :
+            sizeof(struct virtio_net_hdr_mrg_rxbuf);
+        n->rss_data.populate_hash = !!hash_report;
     } else {
         n->guest_hdr_len = n->mergeable_rx_bufs ?
             sizeof(struct virtio_net_hdr_mrg_rxbuf) :
@@ -708,6 +712,8 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO4);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_TSO6);
         virtio_clear_feature(&features, VIRTIO_NET_F_GUEST_ECN);
+
+        virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
     }
 
     if (!peer_has_vnet_hdr(n) || !peer_has_ufo(n)) {
@@ -720,6 +726,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
     }
 
     virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
+    virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -886,12 +893,15 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
                                virtio_has_feature(features,
                                                   VIRTIO_NET_F_MRG_RXBUF),
                                virtio_has_feature(features,
-                                                  VIRTIO_F_VERSION_1));
+                                                  VIRTIO_F_VERSION_1),
+                               virtio_has_feature(features,
+                                                  VIRTIO_NET_F_HASH_REPORT));
 
     n->rsc4_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
         virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO4);
     n->rsc6_enabled = virtio_has_feature(features, VIRTIO_NET_F_RSC_EXT) &&
         virtio_has_feature(features, VIRTIO_NET_F_GUEST_TSO6);
+    n->rss_data.redirect = virtio_has_feature(features, VIRTIO_NET_F_RSS);
 
     if (n->has_vnet_hdr) {
         n->curr_guest_offloads =
@@ -1165,7 +1175,9 @@ static void virtio_net_disable_rss(VirtIONet *n)
 }
 
 static uint16_t virtio_net_handle_rss(VirtIONet *n,
-                                      struct iovec *iov, unsigned int iov_cnt)
+                                      struct iovec *iov,
+                                      unsigned int iov_cnt,
+                                      bool do_rss)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
     struct virtio_net_rss_config cfg;
@@ -1178,10 +1190,14 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
     const char *err_msg = "";
     uint32_t err_value = 0;
 
-    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_RSS)) {
+    if (do_rss && !virtio_vdev_has_feature(vdev, VIRTIO_NET_F_RSS)) {
         err_msg = "RSS is not negotiated";
         goto error;
     }
+    if (!do_rss && !virtio_vdev_has_feature(vdev, VIRTIO_NET_F_HASH_REPORT)) {
+        err_msg = "Hash report is not negotiated";
+        goto error;
+    }
     size_get = offsetof(struct virtio_net_rss_config, indirection_table);
     s = iov_to_buf(iov, iov_cnt, offset, &cfg, size_get);
     if (s != size_get) {
@@ -1193,6 +1209,9 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
     n->rss_data.indirections_len++;
+    if (!do_rss) {
+        n->rss_data.indirections_len = 1;
+    }
     if (!is_power_of_2(n->rss_data.indirections_len)) {
         err_msg = "Invalid size of indirection table";
         err_value = n->rss_data.indirections_len;
@@ -1203,8 +1222,8 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = n->rss_data.indirections_len;
         goto error;
     }
-    n->rss_data.default_queue =
-        virtio_lduw_p(vdev, &cfg.unclassified_queue);
+    n->rss_data.default_queue = do_rss ?
+        virtio_lduw_p(vdev, &cfg.unclassified_queue) : 0;
     if (n->rss_data.default_queue >= n->max_queues) {
         err_msg = "Invalid default queue";
         err_value = n->rss_data.default_queue;
@@ -1238,7 +1257,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
-    queues = virtio_lduw_p(vdev, &temp.us);
+    queues = do_rss ? virtio_lduw_p(vdev, &temp.us) : n->curr_queues;
     if (queues == 0 || queues > n->max_queues) {
         err_msg = "Invalid number of queues";
         err_value = queues;
@@ -1284,8 +1303,12 @@ static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
     uint16_t queues;
 
     virtio_net_disable_rss(n);
+    if (cmd == VIRTIO_NET_CTRL_MQ_HASH_CONFIG) {
+        queues = virtio_net_handle_rss(n, iov, iov_cnt, false);
+        return queues ? VIRTIO_NET_OK : VIRTIO_NET_ERR;
+    }
     if (cmd == VIRTIO_NET_CTRL_MQ_RSS_CONFIG) {
-        queues = virtio_net_handle_rss(n, iov, iov_cnt);
+        queues = virtio_net_handle_rss(n, iov, iov_cnt, true);
     } else if (cmd == VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
         struct virtio_net_ctrl_mq mq;
         size_t s;
@@ -1572,15 +1595,34 @@ static uint8_t virtio_net_get_hash_type(bool isip4,
     return 0xff;
 }
 
+static void virtio_set_packet_hash(const uint8_t *buf, uint8_t report,
+                                   uint32_t hash)
+{
+    struct virtio_net_hdr_v1_hash *hdr = (void *)buf;
+    hdr->hash_value = hash;
+    hdr->hash_report = report;
+}
+
 static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
                                   size_t size)
 {
     VirtIONet *n = qemu_get_nic_opaque(nc);
-    unsigned int index = nc->queue_index, new_index;
+    unsigned int index = nc->queue_index, new_index = index;
     struct NetRxPkt *pkt = n->rx_pkt;
     uint8_t net_hash_type;
     uint32_t hash;
     bool isip4, isip6, isudp, istcp;
+    static const uint8_t reports[NetPktRssIpV6UdpEx + 1] = {
+        VIRTIO_NET_HASH_REPORT_IPv4,
+        VIRTIO_NET_HASH_REPORT_TCPv4,
+        VIRTIO_NET_HASH_REPORT_TCPv6,
+        VIRTIO_NET_HASH_REPORT_IPv6,
+        VIRTIO_NET_HASH_REPORT_IPv6_EX,
+        VIRTIO_NET_HASH_REPORT_TCPv6_EX,
+        VIRTIO_NET_HASH_REPORT_UDPv4,
+        VIRTIO_NET_HASH_REPORT_UDPv6,
+        VIRTIO_NET_HASH_REPORT_UDPv6_EX
+    };
 
     net_rx_pkt_set_protocols(pkt, buf + n->host_hdr_len,
                              size - n->host_hdr_len);
@@ -1594,16 +1636,24 @@ static int virtio_net_process_rss(NetClientState *nc, const uint8_t *buf,
     net_hash_type = virtio_net_get_hash_type(isip4, isip6, isudp, istcp,
                                              n->rss_data.hash_types);
     if (net_hash_type > NetPktRssIpV6UdpEx) {
-        return n->rss_data.default_queue;
+        if (n->rss_data.populate_hash) {
+            virtio_set_packet_hash(buf, VIRTIO_NET_HASH_REPORT_NONE, 0);
+        }
+        return n->rss_data.redirect ? n->rss_data.default_queue : -1;
     }
 
     hash = net_rx_pkt_calc_rss_hash(pkt, net_hash_type, n->rss_data.key);
-    new_index = hash & (n->rss_data.indirections_len - 1);
-    new_index = n->rss_data.indirections_table[new_index];
-    if (index == new_index) {
-        return -1;
+
+    if (n->rss_data.populate_hash) {
+        virtio_set_packet_hash(buf, reports[net_hash_type], hash);
     }
-    return new_index;
+
+    if (n->rss_data.redirect) {
+        new_index = hash & (n->rss_data.indirections_len - 1);
+        new_index = n->rss_data.indirections_table[new_index];
+    }
+
+    return (index == new_index) ? -1 : new_index;
 }
 
 static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
@@ -1679,6 +1729,11 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
             }
 
             receive_header(n, sg, elem->in_num, buf, size);
+            if (n->rss_data.populate_hash) {
+                offset = sizeof(mhdr);
+                iov_from_buf(sg, elem->in_num, offset,
+                             buf + offset, n->host_hdr_len - sizeof(mhdr));
+            }
             offset = n->host_hdr_len;
             total += n->guest_hdr_len;
             guest_offset = n->guest_hdr_len;
@@ -2671,7 +2726,9 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     trace_virtio_net_post_load_device();
     virtio_net_set_mrg_rx_bufs(n, n->mergeable_rx_bufs,
                                virtio_vdev_has_feature(vdev,
-                                                       VIRTIO_F_VERSION_1));
+                                                       VIRTIO_F_VERSION_1),
+                               virtio_vdev_has_feature(vdev,
+                                                       VIRTIO_NET_F_HASH_REPORT));
 
     /* MAC_TABLE_ENTRIES may be different from the saved image */
     if (n->mac_table.in_use > MAC_TABLE_ENTRIES) {
@@ -3290,7 +3347,7 @@ static void virtio_net_device_realize(DeviceState *dev, Error **errp)
 
     n->vqs[0].tx_waiting = 0;
     n->tx_burst = n->net_conf.txburst;
-    virtio_net_set_mrg_rx_bufs(n, 0, 0);
+    virtio_net_set_mrg_rx_bufs(n, 0, 0, 0);
     n->promisc = 1; /* for compatibility */
 
     n->mac_table.macs = g_malloc0(MAC_TABLE_ENTRIES * ETH_ALEN);
@@ -3445,6 +3502,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
     DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
                     VIRTIO_NET_F_RSS, false),
+    DEFINE_PROP_BIT64("hash", VirtIONet, host_features,
+                    VIRTIO_NET_F_HASH_REPORT, false),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 5081f3c..a45ef82 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -131,6 +131,8 @@ typedef struct VirtioNetRscChain {
 
 typedef struct VirtioNetRssData {
     bool    enabled;
+    bool    redirect;
+    bool    populate_hash;
     uint32_t hash_types;
     uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
     uint16_t indirections_len;
-- 
2.5.0


