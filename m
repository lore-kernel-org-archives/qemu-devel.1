Return-Path: <SRS0=N3Ri=EI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51E44C00A89
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:22:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1D12222B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Nov 2020 18:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="xUkk56Ra"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1D12222B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45940 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kZeTC-0003QZ-Ov
	for qemu-devel@archiver.kernel.org; Mon, 02 Nov 2020 13:22:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40910)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeR4-0001Z6-8J
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:06 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39298)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1kZeQy-0006ic-7W
 for qemu-devel@nongnu.org; Mon, 02 Nov 2020 13:20:05 -0500
Received: by mail-lf1-x144.google.com with SMTP id 184so18647048lfd.6
 for <qemu-devel@nongnu.org>; Mon, 02 Nov 2020 10:19:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=EFtkV8vk9mojAwXkn433NVuLfi5G+E0yJnsXG3+z/Cg=;
 b=xUkk56RaLggvLvpA4i/rbOe3nBZt+mgqu5QHEZ/3QKs26JSMzF8OX0EgTakeFolGAD
 yIePVz3XNvU+5WgJhGsM+8tiE03pU13ZbLan0KXas70beYh5LRHTOldaZaQIQN12TEsj
 tZJ47h2Pd7/EKECiGz1Q/mheiYzJlHipSsKIpjxnvRJPkWzdWiUvvCO7HXoXid32AfQe
 Awinnvi+gqH1g4cpGlRCa+w2RLdBvftZmU+szd7kFOqv7lTLyXvYkWk7TYHW0s36pUXA
 DiKzLodj1t4E9tPYfJbzKJse8amjxdJgje5cQ9keAire3rgKYblX0Q0KosmBERpbz6dT
 4DOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=EFtkV8vk9mojAwXkn433NVuLfi5G+E0yJnsXG3+z/Cg=;
 b=Z7v+pDpL9UpAeIsdKf3jZ0fe5vQJ29XIBMqD2Sa4JdZ2UDzuDlgDbezfy9ueEQCnBk
 Syz+v+oVsq4RHMC18nO4o6Pt6K/fMy1WtssMJBFAz95YqwJ4fMQjFbP6yAskEICv86jc
 1camp1eDpAoMLu8qnhXT+okMMELFB/s88Fadv1Sw8pBdFZgLBw2Q1tK2ZS9TnToHrc36
 TSSB72gv1rRM1slPSjP2JFN0oYRUF7jfjzz0mRjUZ8irxR+ubTCCzY31lMa8dpkpB5NO
 sybxwJhzFxwH3e5oEbGFO3j5ELkQT8S5NBEvsEHzYAbpF0O9Tp3wIyfEQkO8gcmXjjyG
 eFPA==
X-Gm-Message-State: AOAM532QSm0m4+gPc1mue1Vls0+w0OCKFiFUFw/LM780W3/0CeRBFyaK
 onBrUDYr5RB4fa+7pt3039Bxwg==
X-Google-Smtp-Source: ABdhPJyILR/U8PvhT/LO24ZoIKzdnGYff+Gj5TxAQybWNZEtqicLTx/EeL/2AR5FrvqT3q3bkfU0Nw==
X-Received: by 2002:ac2:5973:: with SMTP id h19mr5835910lfp.458.1604341197079; 
 Mon, 02 Nov 2020 10:19:57 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id c6sm2527007lfm.226.2020.11.02.10.19.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 10:19:56 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com,
	mst@redhat.com
Subject: [RFC PATCH 5/6] virtio-net: Added eBPF RSS to virtio-net.
Date: Mon,  2 Nov 2020 20:51:15 +0200
Message-Id: <20201102185115.7425-6-andrew@daynix.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201102185115.7425-1-andrew@daynix.com>
References: <20201102185115.7425-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::144;
 envelope-from=andrew@daynix.com; helo=mail-lf1-x144.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Cc: yan@daynix.com, yuri.benditovich@daynix.com, Andrew <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

When RSS is enabled the device tries to load the eBPF program
to select RX virtqueue in the TUN. If eBPF can be loaded
the RSS will function also with vhost (works with kernel 5.8 and later).
Software RSS is used as a fallback with vhost=off when eBPF can't be loaded
or when hash population requested by the guest.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/vhost_net.c             |   2 +
 hw/net/virtio-net.c            | 120 +++++++++++++++++++++++++++++++--
 include/hw/virtio/virtio-net.h |   4 ++
 net/vhost-vdpa.c               |   2 +
 4 files changed, 124 insertions(+), 4 deletions(-)

diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
index 24d555e764..16124f99c3 100644
--- a/hw/net/vhost_net.c
+++ b/hw/net/vhost_net.c
@@ -71,6 +71,8 @@ static const int user_feature_bits[] = {
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
+    VIRTIO_NET_F_RSS,
+    VIRTIO_NET_F_HASH_REPORT,
 
     /* This bit implies RARP isn't sent by QEMU out of band */
     VIRTIO_NET_F_GUEST_ANNOUNCE,
diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 277289d56e..afcc3032ec 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -698,6 +698,19 @@ static void virtio_net_set_queues(VirtIONet *n)
 
 static void virtio_net_set_multiqueue(VirtIONet *n, int multiqueue);
 
+static uint64_t fix_ebpf_vhost_features(uint64_t features)
+{
+    /* If vhost=on & CONFIG_EBPF doesn't set - disable RSS feature */
+    uint64_t ret = features;
+#ifndef CONFIG_EBPF
+    virtio_clear_feature(&ret, VIRTIO_NET_F_RSS);
+#endif
+    /* for now, there is no solution for populating the hash from eBPF */
+    virtio_clear_feature(&ret, VIRTIO_NET_F_HASH_REPORT);
+
+    return ret;
+}
+
 static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
                                         Error **errp)
 {
@@ -732,9 +745,9 @@ static uint64_t virtio_net_get_features(VirtIODevice *vdev, uint64_t features,
         return features;
     }
 
-    virtio_clear_feature(&features, VIRTIO_NET_F_RSS);
-    virtio_clear_feature(&features, VIRTIO_NET_F_HASH_REPORT);
-    features = vhost_net_get_features(get_vhost_net(nc->peer), features);
+    features = fix_ebpf_vhost_features(
+            vhost_net_get_features(get_vhost_net(nc->peer), features));
+
     vdev->backend_features = features;
 
     if (n->mtu_bypass_backend &&
@@ -1169,12 +1182,75 @@ static int virtio_net_handle_announce(VirtIONet *n, uint8_t cmd,
     }
 }
 
+static void virtio_net_unload_epbf_rss(VirtIONet *n);
+
 static void virtio_net_disable_rss(VirtIONet *n)
 {
     if (n->rss_data.enabled) {
         trace_virtio_net_rss_disable();
     }
     n->rss_data.enabled = false;
+
+    if (!n->rss_data.enabled_software_rss && ebpf_rss_is_loaded(&n->ebpf_rss)) {
+        virtio_net_unload_epbf_rss(n);
+    }
+}
+
+static bool virtio_net_attach_steering_ebpf(NICState *nic, int prog_fd)
+{
+    NetClientState *nc = qemu_get_peer(qemu_get_queue(nic), 0);
+    if (nc == NULL || nc->info->set_steering_ebpf == NULL) {
+        return false;
+    }
+
+    return nc->info->set_steering_ebpf(nc, prog_fd);
+}
+
+static void rss_data_to_rss_config(struct VirtioNetRssData *data,
+                                   struct EBPFRSSConfig *config)
+{
+    config->redirect = data->redirect;
+    config->populate_hash = data->populate_hash;
+    config->hash_types = data->hash_types;
+    config->indirections_len = data->indirections_len;
+    config->default_queue = data->default_queue;
+}
+
+static bool virtio_net_load_epbf_rss(VirtIONet *n)
+{
+    struct EBPFRSSConfig config = {};
+
+    if (!n->rss_data.enabled) {
+        if (ebpf_rss_is_loaded(&n->ebpf_rss)) {
+            ebpf_rss_unload(&n->ebpf_rss);
+        }
+        return true;
+    }
+
+    if (!ebpf_rss_is_loaded(&n->ebpf_rss) && !ebpf_rss_load(&n->ebpf_rss)) {
+        return false;
+    }
+
+    rss_data_to_rss_config(&n->rss_data, &config);
+
+    if (!ebpf_rss_set_all(&n->ebpf_rss, &config,
+                          n->rss_data.indirections_table, n->rss_data.key)) {
+        ebpf_rss_unload(&n->ebpf_rss);
+        return false;
+    }
+
+    if (!virtio_net_attach_steering_ebpf(n->nic, n->ebpf_rss.program_fd)) {
+        ebpf_rss_unload(&n->ebpf_rss);
+        return false;
+    }
+
+    return true;
+}
+
+static void virtio_net_unload_epbf_rss(VirtIONet *n)
+{
+    virtio_net_attach_steering_ebpf(n->nic, -1);
+    ebpf_rss_unload(&n->ebpf_rss);
 }
 
 static uint16_t virtio_net_handle_rss(VirtIONet *n,
@@ -1208,6 +1284,7 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         err_value = (uint32_t)s;
         goto error;
     }
+    n->rss_data.enabled_software_rss = false;
     n->rss_data.hash_types = virtio_ldl_p(vdev, &cfg.hash_types);
     n->rss_data.indirections_len =
         virtio_lduw_p(vdev, &cfg.indirection_table_mask);
@@ -1289,9 +1366,30 @@ static uint16_t virtio_net_handle_rss(VirtIONet *n,
         goto error;
     }
     n->rss_data.enabled = true;
+
+    if (!n->rss_data.populate_hash) {
+        /* load EBPF RSS */
+        if (!virtio_net_load_epbf_rss(n)) {
+            /* EBPF mast be loaded for vhost */
+            if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+                warn_report("Can't load eBPF RSS for vhost");
+                goto error;
+            }
+            /* fallback to software RSS */
+            warn_report("Can't load eBPF RSS - fallback to software RSS");
+            n->rss_data.enabled_software_rss = true;
+        }
+    } else {
+        /* use software RSS for hash populating */
+        /* and unload eBPF if was loaded before */
+        virtio_net_unload_epbf_rss(n);
+        n->rss_data.enabled_software_rss = true;
+    }
+
     trace_virtio_net_rss_enable(n->rss_data.hash_types,
                                 n->rss_data.indirections_len,
                                 temp.b);
+
     return queues;
 error:
     trace_virtio_net_rss_error(err_msg, err_value);
@@ -1674,7 +1772,7 @@ static ssize_t virtio_net_receive_rcu(NetClientState *nc, const uint8_t *buf,
         return -1;
     }
 
-    if (!no_rss && n->rss_data.enabled) {
+    if (!no_rss && n->rss_data.enabled && n->rss_data.enabled_software_rss) {
         int index = virtio_net_process_rss(nc, buf, size);
         if (index >= 0) {
             NetClientState *nc2 = qemu_get_subqueue(n->nic, index);
@@ -2780,6 +2878,18 @@ static int virtio_net_post_load_device(void *opaque, int version_id)
     }
 
     if (n->rss_data.enabled) {
+        n->rss_data.enabled_software_rss = n->rss_data.populate_hash;
+        if (!n->rss_data.populate_hash) {
+            if (!virtio_net_load_epbf_rss(n)) {
+                if (get_vhost_net(qemu_get_queue(n->nic)->peer)) {
+                    error_report("Can't post-load eBPF RSS for vhost");
+                } else {
+                    warn_report("Can't post-load eBPF RSS - fallback to software RSS");
+                    n->rss_data.enabled_software_rss = true;
+                }
+            }
+        }
+
         trace_virtio_net_rss_enable(n->rss_data.hash_types,
                                     n->rss_data.indirections_len,
                                     sizeof(n->rss_data.key));
@@ -3453,6 +3563,8 @@ static void virtio_net_instance_init(Object *obj)
     device_add_bootindex_property(obj, &n->nic_conf.bootindex,
                                   "bootindex", "/ethernet-phy@0",
                                   DEVICE(n));
+
+    ebpf_rss_init(&n->ebpf_rss);
 }
 
 static int virtio_net_pre_save(void *opaque)
diff --git a/include/hw/virtio/virtio-net.h b/include/hw/virtio/virtio-net.h
index f4852ac27b..4d29a577eb 100644
--- a/include/hw/virtio/virtio-net.h
+++ b/include/hw/virtio/virtio-net.h
@@ -21,6 +21,8 @@
 #include "qemu/option_int.h"
 #include "qom/object.h"
 
+#include "ebpf/ebpf_rss.h"
+
 #define TYPE_VIRTIO_NET "virtio-net-device"
 OBJECT_DECLARE_SIMPLE_TYPE(VirtIONet, VIRTIO_NET)
 
@@ -130,6 +132,7 @@ typedef struct VirtioNetRscChain {
 
 typedef struct VirtioNetRssData {
     bool    enabled;
+    bool    enabled_software_rss;
     bool    redirect;
     bool    populate_hash;
     uint32_t hash_types;
@@ -214,6 +217,7 @@ struct VirtIONet {
     Notifier migration_state;
     VirtioNetRssData rss_data;
     struct NetRxPkt *rx_pkt;
+    struct EBPFRSSContext ebpf_rss;
 };
 
 void virtio_net_set_netclient_name(VirtIONet *n, const char *name,
diff --git a/net/vhost-vdpa.c b/net/vhost-vdpa.c
index 99c476db8c..feb5fa8624 100644
--- a/net/vhost-vdpa.c
+++ b/net/vhost-vdpa.c
@@ -54,6 +54,8 @@ const int vdpa_feature_bits[] = {
     VIRTIO_NET_F_MTU,
     VIRTIO_F_IOMMU_PLATFORM,
     VIRTIO_F_RING_PACKED,
+    VIRTIO_NET_F_RSS,
+    VIRTIO_NET_F_HASH_REPORT,
     VIRTIO_NET_F_GUEST_ANNOUNCE,
     VIRTIO_NET_F_STATUS,
     VHOST_INVALID_FEATURE_BIT
-- 
2.28.0


