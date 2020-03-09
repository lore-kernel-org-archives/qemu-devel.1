Return-Path: <SRS0=hU7S=42=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E731C10F27
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:38:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B09A2072A
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2020 08:38:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="cOiMMd/f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B09A2072A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jBDvL-0006Bg-IA
	for qemu-devel@archiver.kernel.org; Mon, 09 Mar 2020 04:38:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47253)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsC-0007Zn-VK
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1jBDsB-0007Jf-K3
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:52 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:46630)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1jBDsB-0007Ib-Dh
 for qemu-devel@nongnu.org; Mon, 09 Mar 2020 04:34:51 -0400
Received: by mail-wr1-x443.google.com with SMTP id n15so9834985wrw.13
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2020 01:34:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=MD48WZYaJiiFtb9BWvJPqIeuYzfyj+64eoP1t2H2QsM=;
 b=cOiMMd/fFhW+XVawA2sXDUUPZiw7x2HFB7voEIJqUQIe6fpLtX64cUq4rwJdrHuuj4
 lAafYGrCVF2WUbrJ3QV4ltf4goi+Q2VeuII2oUerejOBeadRjSZJS2M/AsAi1j8eEs2c
 ahBP0obtlrZ89agupANcru8baXLqViRwAIOipocfQQahIibWoFwv1YrSpx+aNa5oKEZp
 P4zKJ4BmGeR8lQfXa67DIi47wdV4Z1QLnccc/0nlppEyTWZUElcW0yiNLZbi2eSFqrCl
 dPoKP0W50n5fvt/gm0Q86r1vxzQjaCxSasYEfHXuq8ZZv1HOrK0Poh7P/hv5IgS9S2eH
 6WqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=MD48WZYaJiiFtb9BWvJPqIeuYzfyj+64eoP1t2H2QsM=;
 b=GlTu1P0Pm5PrAkJGnZjat/e4FLYMR1S3OhYIqcPNXabWK8cgcK/hd/YjeLOid9lUUl
 QCZePo9zjkQJffNYOcyLEtUYgVy4y1kUfUQ9SgVyrE+ILraROJu6MbRLtezjeS9uH48s
 oPri6XgwqzLDZ26liKBwuK11MGVFUpz6SLUJQVxJBhf238ZDwhKxnmnnR5Oi2oKm7zFe
 3el6iYe10N/e0yTDvY6byq+1ZCea349mesawlk1wgjGTeXmEmXdPFrc6zyMsUDDbxHik
 zhQd+WjcDu6ap1tp4VHKSSS94T1g9SeYrPoZgGR7kRsxL2faaM/S+rcNKahd/vkirgPJ
 4XRg==
X-Gm-Message-State: ANhLgQ2EDSv0/6E4tgPV/KNOn4iL48vS3vAmEdQsGvllcI/MSR0/jeXA
 C0K1QIK2pEohB432k0ZPkeYYMSJ+oA4sCQ==
X-Google-Smtp-Source: ADFU+vtRGnbbMYemX9B1Gp/bPQ2JHkdwh+fltXhVAzgewEbbHYwtwtnhwq3Mgd91fB567vU2/kHBvA==
X-Received: by 2002:a5d:65c5:: with SMTP id e5mr3545340wrw.161.1583742889160; 
 Mon, 09 Mar 2020 01:34:49 -0700 (PDT)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id h3sm63749726wrb.23.2020.03.09.01.34.48
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 09 Mar 2020 01:34:48 -0700 (PDT)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH v2 1/4] virtio-net: introduce RSS and hash report features
Date: Mon,  9 Mar 2020 10:34:35 +0200
Message-Id: <20200309083438.2389-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200309083438.2389-1-yuri.benditovich@daynix.com>
References: <20200309083438.2389-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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


