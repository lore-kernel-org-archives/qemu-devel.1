Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3ECA3C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:11:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECD93206F6
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:11:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="QMeYTymJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ECD93206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIZbH-0001IM-1P
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 11:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38435)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZi-0007kH-LQ
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZg-0006jo-Qy
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:10 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:37972)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jIZZg-0006jV-K1
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:08 -0400
Received: by mail-wm1-x342.google.com with SMTP id f6so11732752wmj.3
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 08:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=hzTgDmc2l99dgxfuy3BlzwK5Gs4fbq/Tfv23wV/AqwI=;
 b=QMeYTymJzeHsBFFxkcsD4WPEluZ6wRYoekEY1Ev8WmtZALu2UusrYtT9H4hOoF5mA5
 EkTqS/aXm9qEYl7MLkv4dr50UqYfz5za47qMqpf7OySOypODY0/UETR4mnmW5vR21+Em
 ho/F7S0qSHt0tc8/m3ywrnfhaq+SmfLx8BNa2dv6e+FvGchbBsO+scHvJIMbqb++y5Kq
 dilzl37mDdg6WZKlPAv1BLlTcelTKLDjxOXrwp18cJZ0DkzaoHstFAH3tbMgAc96K+Vx
 yoTCrmdg+GY3BiAgCwkLxSwOx/LU+qKYi+Rvza44xnbYPXK3nICMMhrM2pjKYwKYJkLm
 xoFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=hzTgDmc2l99dgxfuy3BlzwK5Gs4fbq/Tfv23wV/AqwI=;
 b=dsH4uJLZmUfZsbhGlqIGsSU4qk423vOcla8BdWe6zDMHtG3sMXAHgELwpczedvlNHV
 C7NDlNLV5RjyZOelB1fjHCWLPT0n946TLdxF4qtrcthyRDV36jPGcRsjG/6ofTnTf4AZ
 e3jgK/C7LmgW6aLZo9+e5Vo2SrgT9ZWYNIrNQ4R+HtlkWEq9hs+3V0xizkYo+dcFTUln
 CpFrjy6nlBxPmKRPhhhh9sojsQadRI/MhTgf/DTKCNLpV8SKJTfW2BKeLcU3u44MjIld
 OlRY7tPZexu0b+vlWJmFN1hRQAaCCjUWJfQ5xvQ/Szq0ZraRPg/2gd41FoebVEbspJLi
 6pAw==
X-Gm-Message-State: ANhLgQ3zqD+kN+xkBbPr6n1/8Vj9AjPgr+hf6jrgPDzvJi65rC4tUUId
 2moDWYL/h1e9PqPuTdwZQIhN49BiS9JrpQ==
X-Google-Smtp-Source: ADFU+vuQjKpS3ZNihhbLv/DutmxBw1J7s+ajX6ewKF464SSNDbaK9rOyXTedFf4INqfQS6/PTEc0Pw==
X-Received: by 2002:a1c:f70a:: with SMTP id v10mr8610588wmh.72.1585494607262; 
 Sun, 29 Mar 2020 08:10:07 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-67-107.red.bezeqint.net.
 [79.183.67.107])
 by smtp.gmail.com with ESMTPSA id s2sm5477874wmh.37.2020.03.29.08.10.06
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 29 Mar 2020 08:10:06 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v7 2/7] virtio-net: implement RSS configuration command
Date: Sun, 29 Mar 2020 18:09:48 +0300
Message-Id: <20200329150953.23812-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329150953.23812-1-yuri.benditovich@daynix.com>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::342
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
 hw/net/virtio-net.c            | 189 +++++++++++++++++++++++++++++----
 include/hw/virtio/virtio-net.h |  13 +++
 3 files changed, 185 insertions(+), 20 deletions(-)

diff --git a/hw/net/trace-events b/hw/net/trace-events
index a1da98a643..a84b9c3d9f 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -371,6 +371,9 @@ virtio_net_announce_notify(void) ""
 virtio_net_announce_timer(int round) "%d"
 virtio_net_handle_announce(int round) "%d"
 virtio_net_post_load_device(void)
+virtio_net_rss_disable(void)
+virtio_net_rss_error(const char *msg, uint32_t value) "%s, value 0x%08x"
+virtio_net_rss_enable(uint32_t p1, uint16_t p2, uint8_t p3) "hashes 0x%x, table of %d, key of %d"
 
 # tulip.c
 tulip_reg_write(uint64_t addr, const char *name, int size, uint64_t val) "addr 0x%02"PRIx64" (%s) size %d value 0x%08"PRIx64
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 90b01221e9..6d21922746 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -142,6 +142,16 @@ struct virtio_net_rss_config {
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
 
@@ -173,6 +183,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, mtu)},
     {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
      .end = endof(struct virtio_net_config, duplex)},
+    {.flags = 1ULL << VIRTIO_NET_F_RSS,
+     .end = endof(struct virtio_net_config_with_rss, supported_hash_types)},
     {}
 };
 
@@ -195,28 +207,33 @@ static int vq2q(int queue_index)
 static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
-    struct virtio_net_config netcfg;
-
-    virtio_stw_p(vdev, &netcfg.status, n->status);
-    virtio_stw_p(vdev, &netcfg.max_virtqueue_pairs, n->max_queues);
-    virtio_stw_p(vdev, &netcfg.mtu, n->net_conf.mtu);
-    memcpy(netcfg.mac, n->mac, ETH_ALEN);
-    virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
-    netcfg.duplex = n->net_conf.duplex;
+    struct virtio_net_config_with_rss netcfg;
+
+    virtio_stw_p(vdev, &netcfg.cfg.status, n->status);
+    virtio_stw_p(vdev, &netcfg.cfg.max_virtqueue_pairs, n->max_queues);
+    virtio_stw_p(vdev, &netcfg.cfg.mtu, n->net_conf.mtu);
+    memcpy(netcfg.cfg.mac, n->mac, ETH_ALEN);
+    virtio_stl_p(vdev, &netcfg.cfg.speed, n->net_conf.speed);
+    netcfg.cfg.duplex = n->net_conf.duplex;
+    netcfg.rss_max_key_size = VIRTIO_NET_RSS_MAX_KEY_SIZE;
+    virtio_stw_p(vdev, &netcfg.rss_max_indirection_table_length,
+                 VIRTIO_NET_RSS_MAX_TABLE_LEN);
+    virtio_stl_p(vdev, &netcfg.supported_hash_types,
+                 VIRTIO_NET_RSS_SUPPORTED_HASHES);
     memcpy(config, &netcfg, n->config_size);
 }
 
 static void virtio_net_set_config(VirtIODevice *vdev, const uint8_t *config)
 {
     VirtIONet *n = VIRTIO_NET(vdev);
-    struct virtio_net_config netcfg = {};
+    struct virtio_net_config_with_rss netcfg = {};
 
     memcpy(&netcfg, config, n->config_size);
 
     if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_CTRL_MAC_ADDR) &&
         !virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1) &&
-        memcmp(netcfg.mac, n->mac, ETH_ALEN)) {
-        memcpy(n->mac, netcfg.mac, ETH_ALEN);
+        memcmp(netcfg.cfg.mac, n->mac, ETH_ALEN)) {
+        memcpy(n->mac, netcfg.cfg.mac, ETH_ALEN);
         qemu_format_nic_info_str(qemu_get_queue(n->nic), n->mac);
     }
 }
@@ -766,6 +783,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
+    virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -925,6 +943,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     }
 
     virtio_net_set_multiqueue(n,
+                              virtio_has_feature(features, VIRTIO_NET_F_RSS) ||
                               virtio_has_feature(features, VIRTIO_NET_F_MQ));
 
     virtio_net_set_mrg_rx_bufs(n,
@@ -1201,25 +1220,152 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
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
+    const char *err_msg = "";
+    uint32_t err_value = 0;
+
+    if (!virtio_vdev_has_feature(vdev, VIRTIO_NET_F_RSS)) {
+        err_msg = "RSS is not negotiated";
+        goto error;
+    }
+    size_get = offsetof(struct virtio_net_rss_config, indirection_table);
+    s = iov_to_buf(iov, iov_cnt, offset, &cfg, size_get);
+    if (s != size_get) {
+        err_msg = "Short command buffer";
+        err_value = (uint32_t)s;
+        goto error;
+    }
+    n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
+    n->rss_data.indirections_len =
+        virtio_lduw_p(vdev, &cfg.indirection_table_mask);
+    n->rss_data.indirections_len++;
+    if (!is_power_of_2(n->rss_data.indirections_len)) {
+        err_msg = "Invalid size of indirection table";
+        err_value = n->rss_data.indirections_len;
+        goto error;
+    }
+    if (n->rss_data.indirections_len > VIRTIO_NET_RSS_MAX_TABLE_LEN) {
+        err_msg = "Too large indirection table";
+        err_value = n->rss_data.indirections_len;
+        goto error;
+    }
+    n->rss_data.default_queue =
+        virtio_lduw_p(vdev, &cfg.unclassified_queue);
+    if (n->rss_data.default_queue >= n->max_queues) {
+        err_msg = "Invalid default queue";
+        err_value = n->rss_data.default_queue;
+        goto error;
+    }
+    offset += size_get;
+    size_get = sizeof(uint16_t) * n->rss_data.indirections_len;
+    g_free(n->rss_data.indirections_table);
+    n->rss_data.indirections_table = g_malloc(size_get);
+    if (!n->rss_data.indirections_table) {
+        err_msg = "Can't allocate indirections table";
+        err_value = n->rss_data.indirections_len;
+        goto error;
+    }
+    s = iov_to_buf(iov, iov_cnt, offset,
+                   n->rss_data.indirections_table, size_get);
+    if (s != size_get) {
+        err_msg = "Short indirection table buffer";
+        err_value = (uint32_t)s;
+        goto error;
+    }
+    for (i = 0; i < n->rss_data.indirections_len; ++i) {
+        uint16_t val = n->rss_data.indirections_table[i];
+        n->rss_data.indirections_table[i] = virtio_lduw_p(vdev, &val);
+    }
+    offset += size_get;
+    size_get = sizeof(temp);
+    s = iov_to_buf(iov, iov_cnt, offset, &temp, size_get);
+    if (s != size_get) {
+        err_msg = "Can't get queues";
+        err_value = (uint32_t)s;
+        goto error;
+    }
+    queues = virtio_lduw_p(vdev, &temp.us);
+    if (queues == 0 || queues > n->max_queues) {
+        err_msg = "Invalid number of queues";
+        err_value = queues;
+        goto error;
+    }
+    if (temp.b > VIRTIO_NET_RSS_MAX_KEY_SIZE) {
+        err_msg = "Invalid key size";
+        err_value = temp.b;
+        goto error;
+    }
+    if (!temp.b && n->rss_data.hash_types) {
+        err_msg = "No key provided";
+        err_value = 0;
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
+        err_msg = "Can get key buffer";
+        err_value = (uint32_t)s;
+        goto error;
+    }
+    n->rss_data.enabled = true;
+    trace_virtio_net_rss_enable(n->rss_data.hash_types,
+                                n->rss_data.indirections_len,
+                                temp.b);
+    return queues;
+error:
+    trace_virtio_net_rss_error(err_msg, err_value);
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
@@ -3173,6 +3319,7 @@ static void virtio_net_device_unrealize(DeviceState *dev, Error **errp)
     g_free(n->vqs);
     qemu_del_nic(n->nic);
     virtio_net_rsc_cleanup(n);
+    g_free(n->rss_data.indirections_table);
     virtio_cleanup(vdev);
 }
 
@@ -3274,6 +3421,8 @@ static Property virtio_net_properties[] = {
     DEFINE_PROP_BIT64("ctrl_guest_offloads", VirtIONet, host_features,
                     VIRTIO_NET_F_CTRL_GUEST_OFFLOADS, true),
     DEFINE_PROP_BIT64("mq", VirtIONet, host_features, VIRTIO_NET_F_MQ, false),
+    DEFINE_PROP_BIT64("rss", VirtIONet, host_features,
+                    VIRTIO_NET_F_RSS, false),
     DEFINE_PROP_BIT64("guest_rsc_ext", VirtIONet, host_features,
                     VIRTIO_NET_F_RSC_EXT, false),
     DEFINE_PROP_UINT32("rsc_interval", VirtIONet, rsc_timeout,
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index 96c68d4a92..d3fad7c8f3 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -126,6 +126,18 @@ typedef struct VirtioNetRscChain {
 /* Maximum packet size we can receive from tap device: header + 64k */
 #define VIRTIO_NET_MAX_BUFSIZE (sizeof(struct virtio_net_hdr) + (64 * KiB))
 
+#define VIRTIO_NET_RSS_MAX_KEY_SIZE     40
+#define VIRTIO_NET_RSS_MAX_TABLE_LEN    128
+
+typedef struct VirtioNetRssData {
+    bool    enabled;
+    uint32_t hash_types;
+    uint8_t key[VIRTIO_NET_RSS_MAX_KEY_SIZE];
+    uint16_t indirections_len;
+    uint16_t *indirections_table;
+    uint16_t default_queue;
+} VirtioNetRssData;
+
 typedef struct VirtIONetQueue {
     VirtQueue *rx_vq;
     VirtQueue *tx_vq;
@@ -199,6 +211,7 @@ struct VirtIONet {
     bool failover;
     DeviceListener primary_listener;
     Notifier migration_state;
+    VirtioNetRssData rss_data;
 };
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
-- 
2.17.1


