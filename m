Return-Path: <SRS0=qvFP=5O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44575C43331
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:11:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 13A40206F6
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Mar 2020 15:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="coKMMCyL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 13A40206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38510 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jIZb7-000174-89
	for qemu-devel@archiver.kernel.org; Sun, 29 Mar 2020 11:11:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZg-0007hk-Jz
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jIZZf-0006ik-HU
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:08 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39821)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jIZZf-0006iT-Bs
 for qemu-devel@nongnu.org; Sun, 29 Mar 2020 11:10:07 -0400
Received: by mail-wr1-x444.google.com with SMTP id p10so17868821wrt.6
 for <qemu-devel@nongnu.org>; Sun, 29 Mar 2020 08:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=O0gbhhNXKqovD8z2owZu41rSHwkPJ8sCWBwXndaIn/A=;
 b=coKMMCyLiayixMsGIiKDBVR/3Y/gX40JNOYnknkXe4Wct0gSa7OemQwlmC6oSJyCsg
 UwejKNMISwqLDbGsy8q+4f8+mg7uI/K1RM9uWPWz4WKhGYYyJiNN0TkujIdRapIXI/6r
 J38bGsgZSPHrd8VwKNMwaMk5nT+gFQ9stRVEGBA3Z0EgC9a7tWomZ5ClqyEA5h6G9V+T
 QzSBU8wPlJAcaaF3s+BVVyl0pykmz07/udBW9PpTvPEUzcOl7ZM/7if2Ehk85X53niju
 2jx6OF1aBs98OIbedABRoy3BTn+XuMgGG+iAnsG4Nc5TfGa/pXZr8iuGbMPTtD+zTPa7
 x3Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=O0gbhhNXKqovD8z2owZu41rSHwkPJ8sCWBwXndaIn/A=;
 b=B2ZCgDtU+DJ3eR+HPk9BhGO9TpJc7JWubJyi44hJk59kkbQ4n4DAqSg5msz3SQyyG2
 JOx8ldBfVVm5Q7kOZ4NFTqMZnabCxXJs1qSvyJ6GhUT7verZYfvRj1jPDftvpkIcJ/yF
 ZARemMD0wfyGzYGCUArmEHC8BNnmx5q9YNRtKuE8Hq1j7E4EZvOxlKEKe1eGJRezoajP
 rDsEJLvmfFCncN+wFdUcZzl/7yiKyT4ix5ZIqOFgCPxPmGf50LPVMelUbIij3+gNIOdz
 kd3kkvxDxay0kkNBX0ciOV5LvD5PrZRO5kg+IbhQhJ4Kq1bFwJnxWhO0nlg4Dvcr/R8K
 0yCg==
X-Gm-Message-State: ANhLgQ0P3dS2U4E/vvoLSAeLfFkgCYiGBDWQPPOiYEY6AtpocydvAIDJ
 B0VAKDhaJpv3qBvMOXNqqmXA6PuqxpT1Qw==
X-Google-Smtp-Source: ADFU+vvModLcf/7y28bcWnXCZC+3CTilc6VaRlEzC7lS9xSiXL5ZIm4h6V2ck65w8/K3EKnXMzaGKA==
X-Received: by 2002:adf:82c5:: with SMTP id 63mr10055848wrc.312.1585494606061; 
 Sun, 29 Mar 2020 08:10:06 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-67-107.red.bezeqint.net.
 [79.183.67.107])
 by smtp.gmail.com with ESMTPSA id s2sm5477874wmh.37.2020.03.29.08.10.04
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Sun, 29 Mar 2020 08:10:05 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v7 1/7] virtio-net: introduce RSS and hash report features
Date: Sun, 29 Mar 2020 18:09:47 +0300
Message-Id: <20200329150953.23812-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200329150953.23812-1-yuri.benditovich@daynix.com>
References: <20200329150953.23812-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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


