Return-Path: <SRS0=8p31=3Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3834C33CB7
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:54:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83EA220716
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2020 11:54:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="FvwT9+en"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83EA220716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43716 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iw2ym-0007OS-Mj
	for qemu-devel@archiver.kernel.org; Mon, 27 Jan 2020 06:54:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58079)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iw2y7-0006b8-QX
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:54:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <yuri.benditovich@daynix.com>) id 1iw2y6-0007CP-Ka
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:54:15 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:35037)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <yuri.benditovich@daynix.com>)
 id 1iw2y6-0007B1-8e
 for qemu-devel@nongnu.org; Mon, 27 Jan 2020 06:54:14 -0500
Received: by mail-wm1-x344.google.com with SMTP id p17so6757952wmb.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2020 03:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id;
 bh=CBQWlQ+e9xHpvFgCMnkhKOFdTaOlhA9b2acXy9cEd68=;
 b=FvwT9+enG8MTe8OqRI7Fyf4qr0V1vV2/cgN60daAO5vdIjWjVQPrT3NWfrcgXk6cBj
 q7eTbF0si5zPuHvYyxjogZVytB/kTIHQhYNjddea7O1+cZhUgDnhvtt8IWT/dTYrJbip
 zF03lRDCmH8B90nj1Sp9cXVijkDvaYyELhf370NzEavX8kNICJQvtiWOzgpgIsaGUXl2
 JdLcoVwVo3opfxOCPSPIdE2A/TmE3JW53azApMWXngHZlL4Z99TkAyVE1pYKTYOCIZnl
 YkL/ojqX5ZXvRJc47ZfKTaAEZ4INDnRqhBpnBG9ARVzRBX+SYwG/d2UFhfeWHprNiD8n
 +BLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=CBQWlQ+e9xHpvFgCMnkhKOFdTaOlhA9b2acXy9cEd68=;
 b=tM4iWg6p53oxDx2dmS5oW9XLepzUwQBPobGQuGP2oWDXMRWx0Q0woAXrt2KSZyPxpc
 7brPk+CFu8BLBTtl8qcKWtHDqOR6Lz2vrGZeCLtRovZQGUdwBs2yoc867/BRmMQCbQ0R
 cnCN56V872/r4vWdnvxC7LGTCMNE3NkPY/eVf0M9XPzw30XOFmpJnD+DLIHtUKzWmrH+
 XmWSp8n9Wl6VdiAUhfkn6o9+cfrH98NzGd6QyUNn0keN2ucQ6fh3ElAZvhkCAiPymTP2
 HQanSRYCLYPwIt6X7cKvv84GEMBqKWxyuT6RR3N6JSrEAQPdnOj3uy6kI0dJR+2bxrsb
 vO3Q==
X-Gm-Message-State: APjAAAXRU0zGNP/gwBaPUtDZWBO7HsF613/vt0i//Q5U5mQ+bUXdFGwT
 hcqkUOe4XDjTQ2FogtBtZLBQBA==
X-Google-Smtp-Source: APXvYqzs7Eu5FW5Q7MAFuQ+alsnfSo2Xrc7+/DmQbVd3thnhq66GTyV4fhfbru02Esp21gCndzvGsg==
X-Received: by 2002:a1c:791a:: with SMTP id l26mr8404349wme.58.1580126052778; 
 Mon, 27 Jan 2020 03:54:12 -0800 (PST)
Received: from f2.redhat.com (bzq-79-177-42-131.red.bezeqint.net.
 [79.177.42.131])
 by smtp.gmail.com with ESMTPSA id s16sm20866490wrn.78.2020.01.27.03.54.11
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 27 Jan 2020 03:54:12 -0800 (PST)
From: Yuri Benditovich <yuri.benditovich@daynix.com>
To: dmitry.fleytman@gmail.com,
	jasowang@redhat.com,
	qemu-devel@nongnu.org
Subject: [PATCH 1/2] NetRxPkt: Introduce support for additional hash types
Date: Mon, 27 Jan 2020 13:54:04 +0200
Message-Id: <20200127115405.13459-1-yuri.benditovich@daynix.com>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

Add support for following hash types:
IPV6 TCP with extension headers
IPV4 UDP
IPV6 UDP
IPV6 UDP with extension headers

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
---
 hw/net/net_rx_pkt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/net_rx_pkt.h |  6 +++++-
 hw/net/trace-events |  4 ++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 98a5030ace..b2a06bd27d 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -307,6 +307,20 @@ _net_rx_rss_prepare_tcp(uint8_t *rss_input,
                           &tcphdr->th_dport, sizeof(uint16_t));
 }
 
+static inline void
+_net_rx_rss_prepare_udp(uint8_t *rss_input,
+                        struct NetRxPkt *pkt,
+                        size_t *bytes_written)
+{
+    struct udp_header *udphdr = &pkt->l4hdr_info.hdr.udp;
+
+    _net_rx_rss_add_chunk(rss_input, bytes_written,
+                          &udphdr->uh_sport, sizeof(uint16_t));
+
+    _net_rx_rss_add_chunk(rss_input, bytes_written,
+                          &udphdr->uh_dport, sizeof(uint16_t));
+}
+
 uint32_t
 net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
                          NetRxPktRssType type,
@@ -347,6 +361,34 @@ net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
         trace_net_rx_pkt_rss_ip6_ex();
         _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, &rss_length);
         break;
+    case NetPktRssIpV6TcpEx:
+        assert(pkt->isip6);
+        assert(pkt->istcp);
+        trace_net_rx_pkt_rss_ip6_ex_tcp();
+        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, &rss_length);
+        _net_rx_rss_prepare_tcp(&rss_input[0], pkt, &rss_length);
+        break;
+    case NetPktRssIpV4Udp:
+        assert(pkt->isip4);
+        assert(pkt->isudp);
+        trace_net_rx_pkt_rss_ip4_udp();
+        _net_rx_rss_prepare_ip4(&rss_input[0], pkt, &rss_length);
+        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
+        break;
+    case NetPktRssIpV6Udp:
+        assert(pkt->isip6);
+        assert(pkt->isudp);
+        trace_net_rx_pkt_rss_ip6_udp();
+        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, false, &rss_length);
+        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
+        break;
+    case NetPktRssIpV6UdpEx:
+        assert(pkt->isip6);
+        assert(pkt->isudp);
+        trace_net_rx_pkt_rss_ip6_ex_udp();
+        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, &rss_length);
+        _net_rx_rss_prepare_udp(&rss_input[0], pkt, &rss_length);
+        break;
     default:
         assert(false);
         break;
diff --git a/hw/net/net_rx_pkt.h b/hw/net/net_rx_pkt.h
index 7adf0fad51..048e3461f0 100644
--- a/hw/net/net_rx_pkt.h
+++ b/hw/net/net_rx_pkt.h
@@ -133,7 +133,11 @@ typedef enum {
     NetPktRssIpV4Tcp,
     NetPktRssIpV6Tcp,
     NetPktRssIpV6,
-    NetPktRssIpV6Ex
+    NetPktRssIpV6Ex,
+    NetPktRssIpV6TcpEx,
+    NetPktRssIpV4Udp,
+    NetPktRssIpV6Udp,
+    NetPktRssIpV6UdpEx,
 } NetRxPktRssType;
 
 /**
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 6f990ede87..73d4558f7e 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -92,9 +92,13 @@ net_rx_pkt_l3_csum_validate_csum(size_t l3hdr_off, uint32_t csl, uint32_t cntr,
 
 net_rx_pkt_rss_ip4(void) "Calculating IPv4 RSS  hash"
 net_rx_pkt_rss_ip4_tcp(void) "Calculating IPv4/TCP RSS  hash"
+net_rx_pkt_rss_ip4_udp(void) "Calculating IPv4/UDP RSS  hash"
 net_rx_pkt_rss_ip6_tcp(void) "Calculating IPv6/TCP RSS  hash"
+net_rx_pkt_rss_ip6_udp(void) "Calculating IPv6/UDP RSS  hash"
 net_rx_pkt_rss_ip6(void) "Calculating IPv6 RSS  hash"
 net_rx_pkt_rss_ip6_ex(void) "Calculating IPv6/EX RSS  hash"
+net_rx_pkt_rss_ip6_ex_tcp(void) "Calculating IPv6/EX/TCP RSS  hash"
+net_rx_pkt_rss_ip6_ex_udp(void) "Calculating IPv6/EX/UDP RSS  hash"
 net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash for %zu bytes: 0x%X"
 net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset) "Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
 
-- 
2.17.1


