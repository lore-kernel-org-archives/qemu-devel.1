Return-Path: <SRS0=zj/5=4O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE96C4BA18
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:49:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4110720801
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2020 17:49:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="becty6s6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110720801
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j70oH-0005X3-Cs
	for qemu-devel@archiver.kernel.org; Wed, 26 Feb 2020 12:49:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57684)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nE-0004EB-8R
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1j70nD-0003Tw-4l
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:20 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:43575)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1j70nC-0003Ro-Un
 for qemu-devel@nongnu.org; Wed, 26 Feb 2020 12:48:19 -0500
Received: by mail-wr1-x442.google.com with SMTP id c13so3426459wrq.10
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2020 09:48:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=zQeuKwZcZJtFN51AuoWn1tzXUO2w2XK219Hx5VK9dDM=;
 b=becty6s6zXK4X46476UGZjUW+eHEuoh6TBoUhiqJXC/v6K+k3NXuDv2Q9VtRtBCrHg
 G4xrJwIFZxG8r1X/TT82v871tUde9j425cFjsWwF+/BfygYV/Rp1DDYev8md/TKdZESx
 jh9cXCrFO7n+vH/7C+FCgGKeVbXwEIb0POemmUImhFCsqOG5nDqix9ufgujdIx0H3sNV
 WMzzL/b4Kay4tw+1rVcS4S+AtNwzrHsLSY09INiNLvUaV4KQU5HIe0QAUjikRdXXxjn4
 PjTSXprpQqRU2bhnoos6i9LX8sASZb4gZoBQ9/HkHDGtC1wPc5k5FcJ0whjStE9tacPB
 +2iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=zQeuKwZcZJtFN51AuoWn1tzXUO2w2XK219Hx5VK9dDM=;
 b=sreAiYyYhGHMYtCdpmYqj16ib/uk6UrIz/Y0n5vX/biDi1HTgfG2hmsA8qJRwGWAc4
 vOC5fcJU5ctFievZxiEbNx8HPjdetmm1RFk+i0gvMLxEL/cC9XAXI3WuypkwPPWbVN74
 2LBxW46RHp1NkOKU8de9VbOlxHYW4ej409HKXF5yCCFBzRkuA/OQXtb2mgW3b8POn13P
 RSfGYSPU2PCPId0pqXAdU1m6JmgGDOByyf38srNxeAY9e+3th7MA1ihEc+c4LIRWqnU/
 G8bDmB94LKXsR6ZUd4LVD4AjIkBlCb0S9N+x2B/5hQfEj/EGW4P70H6nWC+67Y9rX2md
 JeAg==
X-Gm-Message-State: APjAAAWnQ6Q9Xm38nYKFHnOTv8tEiLiWF9gMeUqTfIglsY0yc1acaTZr
 qZxwt82DldT7MgA4VyJtMYFZGHEaJFQ=
X-Google-Smtp-Source: APXvYqwBq64IryB9WziasFH1cKya2C1doINUXwrAol1IeEzI26G9p6Jw+ClPc6H4xBNHtjMdGOUTWw==
X-Received: by 2002:a5d:66c6:: with SMTP id k6mr2841961wrw.343.1582739297794; 
 Wed, 26 Feb 2020 09:48:17 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id b21sm3930520wmd.37.2020.02.26.09.48.16
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Wed, 26 Feb 2020 09:48:17 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: qemu-devel@nongnu.org,
	mst@redhat.com,
	jasowang@redhat.com
Subject: [PATCH 1/3] virtio-net: introduce RSS RX steering feature
Date: Wed, 26 Feb 2020 19:48:07 +0200
Message-Id: <20200226174809.9675-2-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200226174809.9675-1-yuri.benditovich@daynix.com>
References: <20200226174809.9675-1-yuri.benditovich@daynix.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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
 include/standard-headers/linux/virtio_net.h | 37 +++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
index 260c3681d7..3bc100afe3 100644
--- a/include/standard-headers/linux/virtio_net.h
+++ b/include/standard-headers/linux/virtio_net.h
@@ -57,6 +57,7 @@
 					 * Steering */
 #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
 
+#define VIRTIO_NET_F_RSS    	  60	/* Supports RSS RX steering */
 #define VIRTIO_NET_F_STANDBY	  62	/* Act as standby for another device
 					 * with the same MAC.
 					 */
@@ -69,6 +70,16 @@
 #define VIRTIO_NET_S_LINK_UP	1	/* Link is up */
 #define VIRTIO_NET_S_ANNOUNCE	2	/* Announcement is needed */
 
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv4              (1 << 0)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv4             (1 << 1)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv4             (1 << 2)
+#define VIRTIO_NET_RSS_HASH_TYPE_IPv6              (1 << 3)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCPv6             (1 << 4)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDPv6             (1 << 5)
+#define VIRTIO_NET_RSS_HASH_TYPE_IP_EX             (1 << 6)
+#define VIRTIO_NET_RSS_HASH_TYPE_TCP_EX            (1 << 7)
+#define VIRTIO_NET_RSS_HASH_TYPE_UDP_EX            (1 << 8)
+
 struct virtio_net_config {
 	/* The config defining mac address (if VIRTIO_NET_F_MAC) */
 	uint8_t mac[ETH_ALEN];
@@ -92,6 +103,14 @@ struct virtio_net_config {
 	 * Any other value stands for unknown.
 	 */
 	uint8_t duplex;
+
+	/* maximal size of RSS key */
+	uint8_t rss_max_key_size;
+	/* maximal number of indirection table entries */
+	uint16_t rss_max_indirection_table_length;
+	/* bitmask of supported VIRTIO_NET_RSS_HASH_ types */
+	uint32_t supported_hash_types;
+
 } QEMU_PACKED;
 
 /*
@@ -237,15 +256,29 @@ struct virtio_net_ctrl_mac {
  * Accordingly, driver should not transmit new packets  on virtqueues other than
  * specified.
  */
+#define VIRTIO_NET_CTRL_MQ   4
+ #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
+ #define VIRTIO_NET_CTRL_MQ_RSS_CONFIG          1
+
+/* for VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET */
 struct virtio_net_ctrl_mq {
 	__virtio16 virtqueue_pairs;
 };
 
-#define VIRTIO_NET_CTRL_MQ   4
- #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_SET        0
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MIN        1
  #define VIRTIO_NET_CTRL_MQ_VQ_PAIRS_MAX        0x8000
 
+/* for VIRTIO_NET_CTRL_MQ_RSS_CONFIG */
+struct virtio_net_rss_config {
+    uint32_t hash_types;
+    uint16_t indirection_table_mask;
+    uint16_t unclassified_queue;
+    uint16_t indirection_table[1/* + indirection_table_mask*/];
+    uint16_t max_tx_vq;
+    uint8_t hash_key_length;
+    uint8_t hash_key_data[/*hash_key_length*/];
+};
+
 /*
  * Control network offloads
  *
-- 
2.17.1


