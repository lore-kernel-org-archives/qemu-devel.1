Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2234BC4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:50:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1D2E20801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Z3LhaOKO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D2E20801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70pN-0007Q2-Um
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:50:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57712)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nG-0004G5-CL
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nE-0003Wz-L5
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:22 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:46432)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j70nE-0003Us-EA
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:20 -0500
Received: by mail-wr1-x441.google.com with SMTP id j7so4138495wrp.13
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=diw+JS49+LbjrCNUzMh7AJLEbY4phRKQDrtBj2e3Vcg=;
 b=Z3LhaOKO0znyoZHeArm0eyi6w7B/PcsLdsvFnzEGXcIOC7uJEbQ4oMgxy69gMlW4sk
 9npE2FtbvaCodcom4H2YrfWNqOHs5WWQuBfl9K6lOC9XK8EEOPNRrQK0pm0DuNnUVy4m
 8kDEOlpFqMkyDkABX/apGJRb3gdLABBjQ9v6EHPOxmTlkVi7VKpqH0KsFNLzw303faXi
 UOfxld2WIJ/bCC3ryj13kjuYdjn3P0Sr/l8VhjA3btVnObb7yjrFFyKs7rF8Zm5/XGOp
 aYC/kS8F7DAhI8eOqI7cFRnjMcEAfW1ootRgVq8FKDZwnwKgPDoZ3JmKIbJmaQCls3TP
 a/fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=diw+JS49+LbjrCNUzMh7AJLEbY4phRKQDrtBj2e3Vcg=;
 b=Hx/tvzOjpshubWLjcRoXljl1adUDv7aBgLn1KRO4SVHxHsIpF0qlpFc/u28va1OJuK
 Z/SZN4ZXJu06wnKV8nnoUq1Ra2IKAm6Snkk0AZqcNEYJa9nTpED5515wzncS1lCN+zBc
 5kTAnyd+/hJppD0oxq0l3XgqB5NGfJ35hVNGtPfOjZ17p2bkxN6WrGptYNmeqbXQnKGk
 gr3xFBcLyfqf116Re0zTa7D/nI1w8is4dTxp8UmW+gSTA5R7XtyZk0hOsRxDgQfRefco
 yQWTdNo7jMo/uWxgYDzoHoEVRJJSoR4k5bKQayRIKHj7qxM6YJshkRtVQiinfYt5RnpU
 Xoaw==
X-Gm-Message-State: APjAAAUpeI7LL5IYFZgwyDzRRfnIulaj9AiszLPTuVGdv+BUtlrVraKh
 5Uoyj+3EY4pjjPRGP3SuJ3WdJiFD7Lw=
X-Google-Smtp-Source: APXvYqzYI+qciAZMwIUrFqnoJH3YwAKSdZZQQeLPP4zI0r1VRn3XaC8Kp2vhlQ1jjrl1cFTwrF0r2w==
X-Received: by 2002:adf:ea4a:: with SMTP id j10mr6490245wrn.119.1582739298862; 
 Wed, 26 Feb 2020 09:48:18 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id b21sm3930520wmd.37.2020.02.26.09.48.17
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Feb 2020 09:48:18 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 2/3] virtio-net: implement RSS configuration command
Date: Wed, 26 Feb 2020 19:48:08 +0200
Message-Id: <20200226174809.9675-3-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226174809.9675-1-yuri.benditovich@daynix.com>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
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
index 4939321493..0f47b7c450 100644
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
index d7d3ad6dc7..c5d21675a9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -77,6 +77,16 @@
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
 
@@ -108,6 +118,8 @@ static VirtIOFeature feature_sizes[] = {
      .end = endof(struct virtio_net_config, mtu)},
     {.flags = 1ULL << VIRTIO_NET_F_SPEED_DUPLEX,
      .end = endof(struct virtio_net_config, duplex)},
+    {.flags = 1ULL << VIRTIO_NET_F_RSS,
+     .end = endof(struct virtio_net_config, supported_hash_types)},
     {}
 };
 
@@ -138,6 +150,11 @@ static void virtio_net_get_config(VirtIODevice *vdev, uint8_t *config)
     memcpy(netcfg.mac, n->mac, ETH_ALEN);
     virtio_stl_p(vdev, &netcfg.speed, n->net_conf.speed);
     netcfg.duplex = n->net_conf.duplex;
+    netcfg.rss_max_key_size = VIRTIO_NET_RSS_MAX_KEY_SIZE;
+    virtio_stw_p(vdev, &netcfg.rss_max_indirection_table_length,
+        VIRTIO_NET_RSS_MAX_TABLE_LEN);
+    virtio_stl_p(vdev, &netcfg.supported_hash_types,
+        VIRTIO_NET_RSS_SUPPORTED_HASHES);
     memcpy(config, &netcfg, n->config_size);
 }
 
@@ -701,6 +718,7 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
+    virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
     features = vhost_net_get_features(get_vhost_net(nc->peer), features);
     vdev->backend_features = features;
 
@@ -860,6 +878,7 @@ static void virtio_net_set_features(VirtIODevice *vdev, uint64_t features)
     }
 
     virtio_net_set_multiqueue(n,
+                              virtio_has_feature(features, VIRTIO_NET_F_RSS) ||
                               virtio_has_feature(features, VIRTIO_NET_F_MQ));
 
     virtio_net_set_mrg_rx_bufs(n,
@@ -1136,25 +1155,134 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
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
@@ -3209,6 +3337,8 @@ static Property virtio_net_properties[] = {
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


