Return-Path: <SRS0=a3Gm=5D=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC2FC10DCE
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:16:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44DFE2076D
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2020 09:16:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Dw59BCmz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44DFE2076D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47410 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jEUoe-000412-BU
	for qemu-devel@archiver.kernel.org; Wed, 18 Mar 2020 05:16:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39561)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUni-0003Ca-1N
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jEUnf-0004Jx-Tx
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:45 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jEUnf-0004FH-N4
 for qemu-devel@nongnu.org; Wed, 18 Mar 2020 05:15:43 -0400
Received: by mail-wm1-x341.google.com with SMTP id c187so1030586wme.1
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2020 02:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O0gbhhNXKqovD8z2owZu41rSHwkPJ8sCWBwXndaIn/A=;
 b=Dw59BCmzSPI+59GOxbUFxTZHpic7buzKM5DcEoKdtNT5S+QlAbmSY9vku+G+fyX3Sq
 nDkr40B+L/6CeTd7AzfxEyqwQ/HOT1RQ0oq7vxz1d6cDfhfs2El3Lw1WugVg8wEyjWQM
 OQHa2pvEOQ/Re3ao44yqxGxa+XYEtSIREY2lV0TSh6/Fd9ZlRXZWsQRUQ7CiC93VHRj+
 ZmF+OiLUf1Vj9rduI8lR0jnY8qzC01dko4drE6e7KFXzvq6chbfv4begm0wmmMLGqhKw
 PcYcpHAIMy+zYqkaKWrFVAIMQhKnVqWKglXFy4ycyMoTrT6L0j/wBu5L0eI2R4nIuaod
 CNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O0gbhhNXKqovD8z2owZu41rSHwkPJ8sCWBwXndaIn/A=;
 b=AHRVvcmF895rOdMt6brI4zuNyAxkUJLohV/UKxI2n/OHOLXGv1N8sYxOrhQ1ANICJg
 eUFI5MI9w3ryT6Ebae1IoKrDeJwMkqWsyBoTiC6DroB3FScBdcyAcZ5xsecHffwfzwjV
 PCNf8wvYi7qB4ROdAM2fVWgEKJuoFnMQYFD3DiLpsl06rz9R9P2p+Mnj8QBVWSflQWA7
 lm2LFQ3fS2uK0cgTOWXwnFFwrSQfNH5+4Q2oXPbRnreXD7oElp/mqGHKjcOhwdu8CXJr
 6bIH/qWNJI52HkgH6712EZ0V4tzXAds6gmJDqvKgRK/xxZcwmCjHP+WkXt8PsOi7aQ9P
 DzdQ==
X-Gm-Message-State: ANhLgQ3LqUg8faaM7Ca3NfVbjMlhySbwA+oDf5kglW+YO3QC+QMbTRNI
 EBVEGutWHnpYGUQMRWaPxhUllQz+nqLIgw==
X-Google-Smtp-Source: ADFU+vtf2ahG1VuiUWmzvCj40ATa/7SJBSCn5V7/hv+RjBtTF1JTweG52YU6jyAqGeuXUs5k1mdkRw==
X-Received: by 2002:a1c:8097:: with SMTP id b145mr4339935wmd.159.1584522941959; 
 Wed, 18 Mar 2020 02:15:41 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id z22sm3062342wmi.1.2020.03.18.02.15.40
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 18 Mar 2020 02:15:41 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com,
 quintela@redhat.com, dgilbert@redhat.com
Subject: [PATCH v5 1/7] virtio-net: introduce RSS and hash report features
Date: Wed, 18 Mar 2020 11:15:19 +0200
Message-Id: <20200318091525.27044-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200318091525.27044-1-yuri.benditovich@daynix.com>
References: <20200318091525.27044-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::341
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

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/virtio-net.c | 65 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3627bb1717..90b01221e9 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -71,6 +71,71 @@
 #define VIRTIO_NET_IP6_ADDR_SIZE   32      /* ipv6 saddr + daddr */
 #define VIRTIO_NET_MAX_IP6_PAYLOAD VIRTIO_NET_MAX_TCP_PAYLOAD
 
+/* TODO: remove after virtio-net header update */
+#if !defined(VIRTIO_NET_RSS_HASH_TYPE_IPv4)
+#define VIRTIO_NET_F_HASH_REPORT    57  /* Supports hash report */
+#define VIRTIO_NET_F_RSS            60  /* Supports RSS RX steering */
+
+/* supported/enabled hash types */
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv4          (1 << 0)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4         (1 << 1)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4         (1 << 2)
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv6          (1 << 3)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6         (1 << 4)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6         (1 << 5)
+#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX         (1 << 6)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX        (1 << 7)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX        (1 << 8)
+
+struct virtio_net_config_with_rss {
+    struct virtio_net_config cfg;
+    /* maximum size of RSS key */
+    uint8_t rss_max_key_size;
+    /* maximum number of indirection table entries */
+    uint16_t rss_max_indirection_table_length;
+    /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+    uint32_t supported_hash_types;
+} QEMU_PACKED;
+
+struct virtio_net_hdr_v1_hash {
+    struct virtio_net_hdr_v1 hdr;
+    uint32_t hash_value;
+#define VIRTIO_NET_HASH_REPORT_NONE            0
+#define VIRTIO_NET_HASH_REPORT_IPv4            1
+#define VIRTIO_NET_HASH_REPORT_TCPv4           2
+#define VIRTIO_NET_HASH_REPORT_UDPv4           3
+#define VIRTIO_NET_HASH_REPORT_IPv6            4
+#define VIRTIO_NET_HASH_REPORT_TCPv6           5
+#define VIRTIO_NET_HASH_REPORT_UDPv6           6
+#define VIRTIO_NET_HASH_REPORT_IPv6_EX         7
+#define VIRTIO_NET_HASH_REPORT_TCPv6_EX        8
+#define VIRTIO_NET_HASH_REPORT_UDPv6_EX        9
+    uint16_t hash_report;
+    uint16_t padding;
+};
+
+/*
+ * The command VIRTIO_NET_CTRL_MQ_RSS_CONFIG has the same effect as
+ * VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET does and additionally configures
+ * the receive steering to use a hash calculated for incoming packet
+ * to decide on receive virtqueue to place the packet. The command
+ * also provides parameters to calculate a hash and receive virtqueue.
+ */
+struct virtio_net_rss_config {
+    uint32_t hash_types;
+    uint16_t indirection_table_mask;
+    uint16_t unclassified_queue;
+    uint16_t indirection_table[1/* + indirection_table_mask */];
+    uint16_t max_tx_vq;
+    uint8_t hash_key_length;
+    uint8_t hash_key_data[/* hash_key_length */];
+};
+
+#define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
+#define VIRTIO_NET_CTRL_MQ_HASH_CONFIG         2
+
+#endif
+
 /* Purge coalesced packets timer interval, This value affects the performance
    a lot, and should be tuned carefully, '300000'(300us) is the recommended
    value to pass the WHQL test, '50000' can gain 2x netperf throughput with
-- 
2.17.1


