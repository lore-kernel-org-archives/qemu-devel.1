Return-Path: <SRS0=QLzr=44=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67802C10F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36AC8208E4
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2020 12:36:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="joJOcC0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36AC8208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jC0bL-000650-Cd
	for qemu-devel@archiver.kernel.org; Wed, 11 Mar 2020 08:36:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45173)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aD-0004T2-Hi
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jC0aC-0002ns-7G
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:33 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38075)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jC0aC-0002mn-0h
 for qemu-devel@nongnu.org; Wed, 11 Mar 2020 08:35:32 -0400
Received: by mail-wm1-x341.google.com with SMTP id n2so1929481wmc.3
 for <qemu-devel@nongnu.org>; Wed, 11 Mar 2020 05:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MD48WZYaJiiFtb9BWvJPqIeuYzfyj+64eoP1t2H2QsM=;
 b=joJOcC0LAv5jCnUop5hEuWrtd8CWLsaD/OeS/nxgdmAGz7UjIRufR2EMBltl3JOiLj
 SWUv9LrRWmuUeAO2WoldYcFRpOP+kQ2jfK10HXSXtehXLuQYad/dLKvHGIQthrvbjcdN
 xDTULmDH+6YX/O6ql1K3WHcqzobvxiCPlnewg7KzGRygGWWyle8I2G86NSNSHKYeJ5uV
 zJGTrC3cJjJoFmqLmOLeV87d2N/JXVvfjCCkNCT5uf29GwB6TCva/4fFqEs/RqDWti5V
 Y2PL9Yrd08VaYpOIm4/Us018UtcWOPWQouRbjzXY45YGyPma+A1tZHWQ/WnYzRv7DeQz
 GE/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MD48WZYaJiiFtb9BWvJPqIeuYzfyj+64eoP1t2H2QsM=;
 b=f7EIjhPUmDLGFMQjuaRngtqTiJAjD6DbxZZ3jgOwKBQ/t4cmNeqZAHdOMmyxj40TVE
 doZb5pMRA48UArridINhEK4GyKcWW7cjo+Bz4SBY21KgS+RqhaAV7Lch7LLkIVB2cA4n
 y69PkDt8QSCpvDxOnJdMTrONw+f/+f26YXY2u2dUg7JwlbQBljqlE/vZTjGts87SNk90
 WTu1CKqX1BYNIcb/qFZ/tNLui+HiPVEDxVrAB8XRqH8WNGtdeWlaJBaxGSZ6CY7ZEH3i
 kxs5flVJiRIiY7XGEO4+mRGCt60ffOOp7dywMMU2U5etfvYaZ2ta7sdLz/2JIvU0V/8G
 Kfyw==
X-Gm-Message-State: ANhLgQ2nezuXHUz24QZTjDZjIMZ6sVKtkgoRlOtk6WnYBh4ELlcw9c8k
 vkhTYXPxweFPQqJRejBOrugannG1fdxXgg==
X-Google-Smtp-Source: ADFU+vudVPemo5RGiBsa8QZWAJGa4nHmVI0LmTEAjJZCP4LVzlUag1p6oPeqy5vK1poMQtVmQQCk4Q==
X-Received: by 2002:a05:600c:2c10:: with SMTP id
 q16mr3713973wmg.69.1583930129350; 
 Wed, 11 Mar 2020 05:35:29 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-183-43-120.red.bezeqint.net.
 [79.183.43.120])
 by smtp.gmail.com with ESMTPSA id o11sm61480696wrn.6.2020.03.11.05.35.28
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 11 Mar 2020 05:35:28 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v3 1/6] virtio-net: introduce RSS and hash report features
Date: Wed, 11 Mar 2020 14:35:13 +0200
Message-Id: <20200311123518.4025-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200311123518.4025-1-yuri.benditovich@daynix.com>
References: <20200311123518.4025-1-yuri.benditovich@daynix.com>
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
 hw/net/virtio-net.c | 95 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
index 3627bb1717..9545b0e84f 100644
--- a/hw/net/virtio-net.c
+++ b/hw/net/virtio-net.c
@@ -71,6 +71,101 @@
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
+#define __le16 uint16_t
+#define __le32 uint32_t
+#define __u8   uint8_t
+#define __u16  uint16_t
+#define __u32  uint32_t
+
+struct virtio_net_config_with_rss {
+    /* The config defining mac address (if VIRTIO_NET_F_MAC) */
+    __u8 mac[ETH_ALEN];
+    /* See VIRTIO_NET_F_STATUS and VIRTIO_NET_S_* above */
+    __u16 status;
+    /*
+     * Maximum number of each of transmit and receive queues;
+     * see VIRTIO_NET_F_MQ and VIRTIO_NET_CTRL_MQ.
+     * Legal values are between 1 and 0x8000
+     */
+    __u16 max_virtqueue_pairs;
+    /* Default maximum transmit unit advice */
+    __u16 mtu;
+    /*
+     * speed, in units of 1Mb. All values 0 to INT_MAX are legal.
+     * Any other value stands for unknown.
+     */
+    __u32 speed;
+    /*
+     * 0x00 - half duplex
+     * 0x01 - full duplex
+     * Any other value stands for unknown.
+     */
+    __u8 duplex;
+    /* maximum size of RSS key */
+    __u8 rss_max_key_size;
+    /* maximum number of indirection table entries */
+    __le16 rss_max_indirection_table_length;
+    /* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+    __le32 supported_hash_types;
+} __attribute__((packed));
+
+#define virtio_net_config virtio_net_config_with_rss
+
+struct virtio_net_hdr_v1_hash {
+    struct virtio_net_hdr_v1 hdr;
+    __le32 hash_value;
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
+    __le16 hash_report;
+    __le16 padding;
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
+    __le32 hash_types;
+    __le16 indirection_table_mask;
+    __le16 unclassified_queue;
+    __le16 indirection_table[1/* + indirection_table_mask */];
+    __le16 max_tx_vq;
+    __u8 hash_key_length;
+    __u8 hash_key_data[/* hash_key_length */];
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


