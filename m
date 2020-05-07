Return-Path: <SRS0=s5cl=6V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69704C38A2A
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:58:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E43220575
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2020 18:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="GmWsce8E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E43220575
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jWljK-0003m7-FI
	for qemu-devel@archiver.kernel.org; Thu, 07 May 2020 14:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jWliW-0002uq-Nd
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:57:56 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jWliV-0002eS-De
 for qemu-devel@nongnu.org; Thu, 07 May 2020 14:57:56 -0400
Received: by mail-lj1-x241.google.com with SMTP id b2so7519276ljp.4
 for <qemu-devel@nongnu.org>; Thu, 07 May 2020 11:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LsVs+UsQIjHZMQl25S3zDulz6Qmj285VlDy8dl+rNG0=;
 b=GmWsce8ErBabQ/OoCGV4BDBVsbYME/cgsZ41tfG7MowvUrdUguSKv07I56Wu9qQiPW
 4Hg/AKhsle6hF2XxFBX6HUIOUoA6oAPRp78VZE0G4z2d22ydBytEZnXKu0KtrqN9Fmov
 Z3lTpAXWX4zG0tkQTPPdPxCyxrH/+WewmGlxIhIE3iOZZUe/O4HQgskpgjvGNbZZRP1r
 bMV3GWp6mMT3eE1/kIffucRiMPVY/fn5uS1fxBlK6/BHSNcj16eD01VDbbXZ4ZxdeUsT
 Og0uRSMymAiR17kVW+TYH2A+MjeLainRRHOFuGl+sEM6t5KLMBlWoKQe8+eH6O7vDS4K
 4m5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LsVs+UsQIjHZMQl25S3zDulz6Qmj285VlDy8dl+rNG0=;
 b=mXGkJrqC9aUJ/5eoqr3AFsCCETHGdIJXOUtY/avK4baKiAutIs09daG6wRiX3z2gA6
 wdUj5EhlOexEYiNJvd1NJnDumf0i/hUZH8egVkM5W5f236XnTWOmv3h+31bSZowKkIVz
 EgkKNGhU3ppRxEJEewMCXAyl7PjlFHrW84AYv9z5LKDnQfyUysRgmtBfd2m0w/4JpH5f
 c2k3n6oJ+80wnz1CdnmFtdjPkrS+/1cxihivMF3ir2GC2E6/aEf7ft2OhdJ+jPn3QtHk
 KuBL99el/Ln+HTXSpBjXI9g8rzRblYOhLkQX0VEE2p1lmVjVYj/G5r9cMmmvndjzIppO
 d8mA==
X-Gm-Message-State: AGi0PuauVPj4lXmbGTtRz4ZTABeWCZSAolf5KvZmaLW/r4Vifd+hrN6/
 lJF20B9quR4Ii7CQV0Pm4ScHI1fQ71ay3Q==
X-Google-Smtp-Source: APiQypJeLceoWSPZGgNyDxav0aRkGJvGgprmWGV7Uj1vdh6prpo2pROzRy6FHSifVBblhyNEl2zewA==
X-Received: by 2002:a05:651c:385:: with SMTP id
 e5mr9236246ljp.208.1588877873283; 
 Thu, 07 May 2020 11:57:53 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id f9sm4464065lfm.62.2020.05.07.11.57.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2020 11:57:52 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH 1/1] hw/net: Added basic IPv6 fragmentation. Fixed IPv6
 payload length. Fixed CSO for IPv6.
Date: Thu,  7 May 2020 22:25:41 +0300
Message-Id: <20200507192541.1046225-2-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200507192541.1046225-1-andrew@daynix.com>
References: <20200507192541.1046225-1-andrew@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::241;
 envelope-from=andrew@daynix.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew Melnychenko <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1708065
Overall, there was an issue that big frames of IPv6 doesn't sent.
With network backend with 'virtual header' - there was an issue
in 'plen' field. Overall, during TSO, 'plen' would be changed,
but with 'vheader' this field should be set to the size of the
payload itself instead of '0'.
For software offload - there is added basic IPv6 fragmentation.
Also fixed checksum offload for IPv6.
The basic IPv6 fragmentation - adding 'frag' extension to
the packet, overall shares some logic with IPv4. It works,
but there are still issues with a combination of
extensions - in the future, it would require refactoring
work to implement workflow with IPv6 and extension.
e1000e driver doesn't set the 'plen' field for IPv6 for big packets
if TSO is enabled. "Jumbo option" isn't added yet, until
qemu supports packets greater than 64K.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/net_tx_pkt.c | 54 ++++++++++++++++++++++++---
 hw/net/net_tx_pkt.h |  7 ++++
 include/net/eth.h   | 15 ++++++--
 net/eth.c           | 89 ++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 151 insertions(+), 14 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 162f802dd7..895effecb9 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -468,8 +468,8 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt *pkt)
     /* num of iovec without vhdr */
     uint32_t iov_len = pkt->payload_frags + NET_TX_PKT_PL_START_FRAG - 1;
     uint16_t csl;
-    struct ip_header *iphdr;
     size_t csum_offset = pkt->virt_hdr.csum_start + pkt->virt_hdr.csum_offset;
+    uint16_t l3_proto = eth_get_l3_proto(iov, 1, iov->iov_len);
 
     /* Put zero to checksum field */
     iov_from_buf(iov, iov_len, csum_offset, &csum, sizeof csum);
@@ -477,9 +477,18 @@ static void net_tx_pkt_do_sw_csum(struct NetTxPkt *pkt)
     /* Calculate L4 TCP/UDP checksum */
     csl = pkt->payload_len;
 
+    csum_cntr = 0;
+    cso = 0;
     /* add pseudo header to csum */
-    iphdr = pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base;
-    csum_cntr = eth_calc_ip4_pseudo_hdr_csum(iphdr, csl, &cso);
+    if (l3_proto == ETH_P_IP) {
+        csum_cntr = eth_calc_ip4_pseudo_hdr_csum(
+                pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
+                csl, &cso);
+    } else if (l3_proto == ETH_P_IPV6) {
+        csum_cntr = eth_calc_ip6_pseudo_hdr_csum(
+                pkt->vec[NET_TX_PKT_L3HDR_FRAG].iov_base,
+                csl, pkt->l4proto, &cso);
+    }
 
     /* data checksum */
     csum_cntr +=
@@ -580,10 +589,11 @@ static bool net_tx_pkt_do_sw_fragmentation(struct NetTxPkt *pkt,
 
         more_frags = (fragment_offset + fragment_len < pkt->payload_len);
 
-        eth_setup_ip4_fragmentation(l2_iov_base, l2_iov_len, l3_iov_base,
-            l3_iov_len, fragment_len, fragment_offset, more_frags);
+        eth_setup_ip_fragmentation(l2_iov_base, l2_iov_len, l3_iov_base,
+            &l3_iov_len, ETH_MAX_IP_DGRAM_LEN,
+            fragment_len, fragment_offset, more_frags);
 
-        eth_fix_ip4_checksum(l3_iov_base, l3_iov_len);
+        fragment[NET_TX_PKT_FRAGMENT_L3_HDR_POS].iov_len = l3_iov_len;
 
         net_tx_pkt_sendv(pkt, nc, fragment, dst_idx);
 
@@ -617,6 +627,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
 
     if (pkt->has_virt_hdr ||
         pkt->virt_hdr.gso_type == VIRTIO_NET_HDR_GSO_NONE) {
+        net_tx_pkt_fix_ip6_payload_len(pkt);
         net_tx_pkt_sendv(pkt, nc, pkt->vec,
             pkt->payload_frags + NET_TX_PKT_PL_START_FRAG);
         return true;
@@ -635,3 +646,34 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt, NetClientState *nc)
 
     return res;
 }
+
+void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
+{
+    /*
+     * If ipv6 payload length field is 0 - then there should be Hop-by-Hop
+     * option for packets greater than 65,535.
+     * For packets with payload less than 65,535: fix 'plen' field.
+     * For now, qemu drops every packet with size greater 64K
+     * (see net_tx_pkt_send()) so, there is no reason to add jumbo option to ip6
+     * hop-by-hop extension if it's missed
+     */
+
+    struct iovec *l2 = &pkt->vec[NET_TX_PKT_L2HDR_FRAG];
+    if (eth_get_l3_proto(l2, 1, l2->iov_len) == ETH_P_IPV6) {
+        struct ip6_header *ip6 = (struct ip6_header *) pkt->l3_hdr;
+        /*
+         * TODO: if qemu would support >64K packets - add jumbo option check
+         * something like that:
+         * 'if (ip6->ip6_plen == 0 && !has_jumbo_option(ip6)) {'
+         */
+        if (ip6->ip6_plen == 0) {
+            if (pkt->payload_len <= ETH_MAX_IP_DGRAM_LEN) {
+                ip6->ip6_plen = htons(pkt->payload_len);
+            }
+            /*
+             * TODO: if qemu would support >64K packets
+             * add jumbo option for packets greater then 65,535 bytes
+             */
+        }
+    }
+}
diff --git a/hw/net/net_tx_pkt.h b/hw/net/net_tx_pkt.h
index 212ecc62fc..912d56ef13 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -187,4 +187,11 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
 */
 bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
 
+/**
+ * Fix IPv6 'plen' field.
+ *
+ * @pkt            packet
+ */
+void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
+
 #endif
diff --git a/include/net/eth.h b/include/net/eth.h
index 7f45c678e7..05c75ac9fc 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -139,6 +139,14 @@ struct ip6_ext_hdr_routing {
     uint8_t     rsvd[4];
 };
 
+struct ip6_ext_hdr_fragment {
+    uint8_t     nxt;
+    uint8_t     res0;
+    uint16_t    off;
+    uint32_t    id;
+};
+
+
 struct ip6_option_hdr {
 #define IP6_OPT_PAD1   (0x00)
 #define IP6_OPT_HOME   (0xC9)
@@ -186,6 +194,7 @@ struct tcp_hdr {
 
 #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
 #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
+#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
 
 #define PKT_GET_ETH_HDR(p)        \
     ((struct eth_header *)(p))
@@ -398,9 +407,9 @@ void eth_get_protocols(const struct iovec *iov, int iovcnt,
                        eth_ip4_hdr_info *ip4hdr_info,
                        eth_l4_hdr_info  *l4hdr_info);
 
-void eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
-                                 void *l3hdr, size_t l3hdr_len,
-                                 size_t l3payload_len,
+void eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
+                                 void *l3hdr, size_t *l3hdr_len,
+                                 size_t l3hdr_max_len, size_t l3payload_len,
                                  size_t frag_offset, bool more_frags);
 
 void
diff --git a/net/eth.c b/net/eth.c
index 0c1d413ee2..21ec5dc33d 100644
--- a/net/eth.c
+++ b/net/eth.c
@@ -314,10 +314,62 @@ eth_strip_vlan_ex(const struct iovec *iov, int iovcnt, size_t iovoff,
     return 0;
 }
 
+static bool eth_is_ip6_extension_header_type(uint8_t hdr_type);
+
+static void *eth_ip6_find_ext(struct ip6_header *ip6, uint8_t ext_type)
+{
+    uint8_t curr_ext_hdr_type = ip6->ip6_nxt;
+    struct ip6_ext_hdr *ext_hdr = (struct ip6_ext_hdr *)(ip6 + 1);
+    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
+        if (curr_ext_hdr_type == ext_type) {
+            return ext_hdr;
+        }
+        curr_ext_hdr_type = ext_hdr->ip6r_nxt;
+        ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
+                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
+    }
+
+    return NULL;
+}
+
+/*
+ * To add an extension - there is should be
+ * enough memory 'behind' the ip6 header.
+ */
+static void *eth_ip6_add_ext_nonsafe(struct ip6_header *ip6, uint8_t ext_type)
+{
+    uint8_t curr_ext_hdr_type = ip6->ip6_nxt;
+    struct ip6_ext_hdr *ext_hdr = (struct ip6_ext_hdr *)(ip6 + 1);
+    struct ip6_ext_hdr *ext_hdr_prev = NULL;
+
+    if (!eth_is_ip6_extension_header_type(curr_ext_hdr_type)) {
+        ext_hdr->ip6r_nxt = ip6->ip6_nxt;
+        ip6->ip6_nxt = ext_type;
+        return ext_hdr;
+    }
+
+    ext_hdr_prev = ext_hdr;
+    curr_ext_hdr_type = ext_hdr->ip6r_nxt;
+    ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
+            + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
+
+    for (; eth_is_ip6_extension_header_type(curr_ext_hdr_type);) {
+        ext_hdr_prev = ext_hdr;
+        curr_ext_hdr_type = ext_hdr->ip6r_nxt;
+        ext_hdr = (struct ip6_ext_hdr *)(((uint8_t *)ext_hdr)
+                + (ext_hdr->ip6r_len + 1) * IP6_EXT_GRANULARITY);
+    }
+
+    ext_hdr->ip6r_nxt = ext_hdr_prev->ip6r_nxt;
+    ext_hdr_prev->ip6r_nxt = ext_type;
+
+    return ext_hdr;
+}
+
 void
-eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
-                            void *l3hdr, size_t l3hdr_len,
-                            size_t l3payload_len,
+eth_setup_ip_fragmentation(const void *l2hdr, size_t l2hdr_len,
+                            void *l3hdr, size_t *l3hdr_len,
+                            size_t l3hdr_max_len, size_t l3payload_len,
                             size_t frag_offset, bool more_frags)
 {
     const struct iovec l2vec = {
@@ -325,7 +377,9 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
         .iov_len = l2hdr_len
     };
 
-    if (eth_get_l3_proto(&l2vec, 1, l2hdr_len) == ETH_P_IP) {
+    uint16_t l3_proto = eth_get_l3_proto(&l2vec, 1, l2hdr_len);
+
+    if (l3_proto == ETH_P_IP) {
         uint16_t orig_flags;
         struct ip_header *iphdr = (struct ip_header *) l3hdr;
         uint16_t frag_off_units = frag_offset / IP_FRAG_UNIT_SIZE;
@@ -337,7 +391,32 @@ eth_setup_ip4_fragmentation(const void *l2hdr, size_t l2hdr_len,
         orig_flags = be16_to_cpu(iphdr->ip_off) & ~(IP_OFFMASK|IP_MF);
         new_ip_off = frag_off_units | orig_flags  | (more_frags ? IP_MF : 0);
         iphdr->ip_off = cpu_to_be16(new_ip_off);
-        iphdr->ip_len = cpu_to_be16(l3payload_len + l3hdr_len);
+        iphdr->ip_len = cpu_to_be16(l3payload_len + *l3hdr_len);
+
+        eth_fix_ip4_checksum(l3hdr, *l3hdr_len);
+    } else if (l3_proto == ETH_P_IPV6) {
+        struct ip6_header *ip6 = (struct ip6_header *) l3hdr;
+
+        struct ip6_ext_hdr_fragment *frag_ext = NULL;
+
+        /* Find frag extension */
+        frag_ext = eth_ip6_find_ext(ip6, IP6_FRAGMENT);
+        if (frag_ext == NULL) {
+            /* No frag extension? Add one */
+            if (*l3hdr_len + sizeof(*frag_ext) > l3hdr_max_len) {
+                return; /* TODO: request to reallocate l3hdr */
+            }
+            frag_ext = eth_ip6_add_ext_nonsafe(ip6, IP6_FRAGMENT);
+            *l3hdr_len += sizeof(*frag_ext);
+            static uint32_t s_id = 0x71656d75; /* 'qemu' */
+            frag_ext->id = cpu_to_be32(s_id);
+            ++s_id;
+        }
+
+        frag_ext->off = cpu_to_be16((frag_offset / IP_FRAG_UNIT_SIZE) << 3
+                | (uint16_t)!!more_frags);
+
+        ip6->ip6_plen = cpu_to_be16(l3payload_len + *l3hdr_len - sizeof(*ip6));
     }
 }
 
-- 
2.24.1


