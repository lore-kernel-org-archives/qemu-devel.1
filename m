Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFB6C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:39:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2836820828
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="kRExvKYe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2836820828
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDwv-0001Gp-Bd
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:39:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47263)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsD-0007bv-Or
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsC-0007KH-36
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:53 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46629)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBDsB-0007JS-Rs
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:52 -0400
Received: by mail-wr1-x441.google.com with SMTP id n15so9835079wrw.13
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 01:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=sQsNWCobnmXTK/R2xUJv6I/7W7Ysw1UAgVvh6gnFET8=;
 b=kRExvKYe2hGBZH4xZqZ0bUVX0y73JNC2Luwxfu8jcozwKhHjzxX7OhcFMAbEpgqvLf
 oFbWzEfRfLw+u4eLBmQXWEaoanDPGaFb2cSsGPAEvfGbqN1b/5b2s9UjlP7fKDPXh+hV
 rnWZu9hw3aKe7jYNfglhs0WSd2M6NXE7rIivmFhEQyaJaXc6uyHKfZAofafu52LXDwEA
 tFvKycoQQKRgSEa6CPPxq13KIb2CEqnDWMXV87qbnNPN0Pi9E3rteOApgd1xLcz/GwcA
 HRHY0+MlF2GwQL/bgqjxstsPUU5aLXPrpi+Kk9uza0iS8qy22CGxc+Tx53EtpnqLTG7u
 +0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=sQsNWCobnmXTK/R2xUJv6I/7W7Ysw1UAgVvh6gnFET8=;
 b=I5jOk3fpJz5oHLl7qc0eaeqokg6Q7iLHV6jYBBICGDcCnQdVJXqkfmOSFrevA1pRY8
 0E/k+I/0AfpX9iGomLIqQ7DbIR1ZfMCTGzJVgXk8DUfnpOreNu5zEdj+9FZRtV6VFQ5k
 8sgEKOznjf1BOmEcGv2e1p4tqB48AMes82m7OeXFPZsuKrk1F8O7DjBV5w4rOz3E9IRz
 eGTG/mm75n/F0kbVEL40EcR6f9W0t4QS2ahoyPA74usN1+qMbY0JgV23vp9N0m1SYjMK
 prFflgOkjbLC7fXDI9cdMcUeSxnhFi6AJ8ovhtymxEyNgQoIDHzy5I55otepwB5yKBHJ
 9IhA==
X-Gm-Message-State: ANhLgQ1uR36WcI/AkmHE/zuaf1Jw7IyE7XXb9NDrwK6qshlWY9JxBXyO
 ZuSdU7UJTNetYKXON2D5UEV3lKMpUatn5Q==
X-Google-Smtp-Source: ADFU+vtN51Kz2IboCKPentUkhFuNfSxQyhFoFGOoF5J7DSPyT5v791LHAiVEfBbg3HlSIAxu43wHew==
X-Received: by 2002:adf:f9cd:: with SMTP id w13mr19463345wrr.406.1583742890451; 
 Mon, 09 Mar 2020 01:34:50 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id h3sm63749726wrb.23.2020.03.09.01.34.49
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Mar 2020 01:34:49 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 2/4] virtio-net: implement RSS configuration command
Date: Mon,  9 Mar 2020 10:34:36 +0200
Message-Id: <20200309083438.2389-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309083438.2389-1-yuri.benditovich@daynix.com>
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Optionally report RSS feature.
Handle RSS configuration command and keep RSS parameters
in virtio-net device context.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/trace-events            |   3 +
 hw/net/virtio-net.c            | 148 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |  11 +++
 3 files changed, 153 insertions(+), 9 deletions(-)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index a1da98a643..9823480d91 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -371,6 +371,9 @@ virtio_net_announce_notify(void) ""
 virtio_net_announce_timer(int round) "%d"
 virtio_net_handle_announce(int round) "%d"
 virtio_net_post_load_device(void)
+virtio_net_rss_disable(void)
+virtio_net_rss_error(int error_case) "case %d"
+virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes 0x%x, table of %d, key of %d"
 
 # tulip.c
 tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t val) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 9545b0e84f..27071eccd2 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -172,6 +172,16 @@ struct virtio_net_rss_config {
    tso/gso/gro 'off'. */
 #define VIRTIO_NET_RSC_DEFAULT_INTERVAL 300000
 
+#define VIRTIO_NET_RSS_SUPPORTED_HASHES (VIRTIO_NET_RSS_HASH_TYPE_IPv4 | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv4 | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv4 | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_IPv6 | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_TCPv6 | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_UDPv6 | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_IP_EX | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_TCP_EX | \
+                                         VIRTIO_NET_RSS_HASH_TYPE_UDP_EX)
+
 /* temporary until standard header include it */
 #if !defined(VIRTIO_NET_HDR_F_RSC_INFO)
 
@@ -203,6 +213,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, mtu)},
     {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
      .end = endof(struct virtio_net_config, duplex)},
+    {.flags = 1ULL << VIRTIO_NET_F_RSS,
+     .end = endof(struct virtio_net_config, supported_hash_types)},
     {}
 };
 
@@ -233,6 +245,11 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
     virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
     netcfg.duplex = n->net_conf.duplex;
+    netcfg.rss_max_key_size = VIRTIO_NET_RSS_MAX_KEY_SIZE;
+    virtio_stw_p(vdev, &netcfg.rss_max_indirection_table_length,
+                 VIRTIO_NET_RSS_MAX_TABLE_LEN);
+    virtio_stl_p(vdev, &netcfg.supported_hash_types,
+                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
     memcpy(config, &netcfg, n->config_size);
 }
 
@@ -796,6 +813,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
+    virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -955,6 +973,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     }
 
     virtio_net_set_multiqueue(n,
+                              virtio_has_feature(features, VIRTIO_NET_F_RSS) ||
                               virtio_has_feature(features, VIRTIO_NET_F_MQ));
 
     virtio_net_set_mrg_rx_bufs(n,
@@ -1231,25 +1250,134 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
     }
 }
 
+static void virtio_net_disable_rss(VirtIONet *n)
+{
+    if (n->rss_data.enabled) {
+        trace_virtio_net_rss_disable();
+    }
+    n->rss_data.enabled = false;
+}
+
+static uint16_t virtio_net_handle_rss(VirtIONet *n,
+                                      struct iovec *iov, unsigned int iov_cnt)
+{
+    VirtIODevice *vdev = VIRTIO_DEVICE(n);
+    struct virtio_net_rss_config cfg;
+    size_t s, offset = 0, size_get;
+    uint16_t queues, i;
+    struct {
+        uint16_t us;
+        uint8_t b;
+    } QEMU_PACKED temp;
+    int err;
+
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_RSS)) {
+        err = 1;
+        goto error;
+    }
+    size_get = offsetof(struct virtio_net_rss_config, indirection_table);
+    s = iov_to_buf(iov, iov_cnt, offset, &cfg, size_get);
+    if (s != size_get) {
+        err = 2;
+        goto error;
+    }
+    n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
+    n->rss_data.indirections_len =
+        virtio_lduw_p(vdev, &cfg.indirection_table_mask);
+    n->rss_data.indirections_len++;
+    if (!is_power_of_2(n->rss_data.indirections_len)) {
+        err = 3;
+        goto error;
+    }
+    if (n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+        err = 4;
+        goto error;
+    }
+    n->rss_data.default_queue =
+        virtio_lduw_p(vdev, &cfg.unclassified_queue);
+    if (n->rss_data.default_queue >= n->max_queues) {
+        err = 5;
+        goto error;
+    }
+    offset += size_get;
+    size_get = sizeof(uint16_t) * n->rss_data.indirections_len;
+    s = iov_to_buf(iov, iov_cnt, offset, n->rss_data.indirections, size_get);
+    if (s != size_get) {
+        err = 10;
+        goto error;
+    }
+    for (i = 0; i < n->rss_data.indirections_len; ++i) {
+        uint16_t val = n->rss_data.indirections[i];
+        n->rss_data.indirections[i] = virtio_lduw_p(vdev, &val);
+    }
+    offset += size_get;
+    size_get = sizeof(temp);
+    s = iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
+    if (s != size_get) {
+        err = 11;
+        goto error;
+    }
+    queues = virtio_lduw_p(vdev, &temp.us);
+    if (queues == 0 || queues > n->max_queues) {
+        err = 12;
+        goto error;
+    }
+    if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
+        err = 13;
+        goto error;
+    }
+    if (!temp.b && n->rss_data.hash_types) {
+        err = 20;
+        goto error;
+    }
+    if (!temp.b && !n->rss_data.hash_types) {
+        virtio_net_disable_rss(n);
+        return queues;
+    }
+    offset += size_get;
+    size_get = temp.b;
+    s = iov_to_buf(iov, iov_cnt, offset, n->rss_data.key, size_get);
+    if (s != size_get) {
+        err = 21;
+        goto error;
+    }
+    n->rss_data.enabled = true;
+    trace_virtio_net_rss_enable(n->rss_data.hash_types,
+                                n->rss_data.indirections_len,
+                                temp.b);
+    return queues;
+error:
+    warn_report("%s: error_case %d", __func__, err);
+    trace_virtio_net_rss_error(err);
+    virtio_net_disable_rss(n);
+    return 0;
+}
+
 static int virtio_net_handle_mq(VirtIONet *n, uint8_t cmd,
                                 struct iovec *iov, unsigned int iov_cnt)
 {
     VirtIODevice *vdev = VIRTIO_DEVICE(n);
-    struct virtio_net_ctrl_mq mq;
-    size_t s;
     uint16_t queues;
 
-    s = iov_to_buf(iov, iov_cnt, 0, &mq, sizeof(mq));
-    if (s != sizeof(mq)) {
-        return VIRTIO_NET_ERR;
-    }
+    virtio_net_disable_rss(n);
+    if (cmd == VIRTIO_NET_CTRL_MQ_RSS_CONFIG) {
+        queues = virtio_net_handle_rss(n, iov, iov_cnt);
+    } else if (cmd == VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
+        struct virtio_net_ctrl_mq mq;
+        size_t s;
+        if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_MQ)) {
+            return VIRTIO_NET_ERR;
+        }
+        s = iov_to_buf(iov, iov_cnt, 0, &mq, sizeof(mq));
+        if (s != sizeof(mq)) {
+            return VIRTIO_NET_ERR;
+        }
+        queues = virtio_lduw_p(vdev, &mq.virtqueue_pairs);
 
-    if (cmd != VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET) {
+    } else {
         return VIRTIO_NET_ERR;
     }
 
-    queues = virtio_lduw_p(vdev, &mq.virtqueue_pairs);
-
     if (queues < VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN ||
         queues > VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX ||
         queues > n->max_queues ||
@@ -3304,6 +3432,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
     DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
+    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
+                    VIRTIO_NET_F_RSS, false),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 96c68d4a92..cf16f5192e 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -126,6 +126,9 @@ typedef struct VirtioNetRscChain {
 /* Maximum packet size we can receive from tap device: header + 64k */
 #define VIRTIO_NET_MAX_BUFSIZE (sizeof(struct virtio_net_hdr) + (64 * KiB))
 
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
+#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
+
 typedef struct VirtIONetQueue {
     VirtQueue *rx_vq;
     VirtQueue *tx_vq;
@@ -199,6 +202,14 @@ struct VirtIONet {
     bool failover;
     DeviceListener primary_listener;
     Notifier migration_state;
+    struct {
+        bool    enabled;
+        uint32_t hash_types;
+        uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+        uint16_t indirections[VIRTIO_NET_RSS_MAX_TABLE_LEN];
+        uint16_t indirections_len;
+        uint16_t default_queue;
+    } rss_data;
 };
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
-- 
2.17.1


