Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CA7C3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:48:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5CA4246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PIsib9Bz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5CA4246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8foP-0008Ss-1S
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60262)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fhc-0004jA-Kt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fhb-0003lX-FA
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:24 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:54645
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fhb-0003l4-Ay
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=M/7mhrmkDMgWbya6uQPhNZ02yGNhHjKbCLFNhsQU/Mo=;
 b=PIsib9Bz1KLPGcm/X3Ez+yVfZo/0ogR1BebFlQIsuspzRi0shaUdqgWhsHT/0++gvqFPor
 uz9GRdgkBUhh2nLNqhQ5RNMBbmKE7qlfwYEFp+XTJ9j0lTLRXgQgYKMuKCoN2yWJCQaPO4
 RLK4I9xkjviCRskUrzLpXFXYgUKQhxA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-305-1JrqLK4IOFK_Q9zcppZikw-1; Mon, 02 Mar 2020 02:41:20 -0500
X-MC-Unique: 1JrqLK4IOFK_Q9zcppZikw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E60C8017CC;
 Mon,  2 Mar 2020 07:41:19 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C513560C05;
 Mon,  2 Mar 2020 07:41:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 16/23] NetRxPkt: Introduce support for additional hash types
Date: Mon,  2 Mar 2020 15:40:29 +0800
Message-Id: <1583134836-23991-17-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Yuri Benditovich <yuri.benditovich@daynix.com>,
 Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Yuri Benditovich <yuri.benditovich@daynix.com>

Add support for following hash types:
IPV6 TCP with extension headers
IPV4 UDP
IPV6 UDP
IPV6 UDP with extension headers

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Acked-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_rx_pkt.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 hw/net/net_rx_pkt.h |  6 +++++-
 hw/net/trace-events |  4 ++++
 3 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 98a5030..b2a06bd 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -307,6 +307,20 @@ _net_rx_rss_prepare_tcp(uint8_t *rss_input,
                           &tcphdr->th_dport, sizeof(uint16_t));
 }
=20
+static inline void
+_net_rx_rss_prepare_udp(uint8_t *rss_input,
+                        struct NetRxPkt *pkt,
+                        size_t *bytes_written)
+{
+    struct udp_header *udphdr =3D &pkt->l4hdr_info.hdr.udp;
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
index 7adf0fa..048e346 100644
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
=20
 /**
diff --git a/hw/net/trace-events b/hw/net/trace-events
index 42066fc..a1da98a 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -92,9 +92,13 @@ net_rx_pkt_l3_csum_validate_csum(size_t l3hdr_off, uint3=
2_t csl, uint32_t cntr,
=20
 net_rx_pkt_rss_ip4(void) "Calculating IPv4 RSS  hash"
 net_rx_pkt_rss_ip4_tcp(void) "Calculating IPv4/TCP RSS  hash"
+net_rx_pkt_rss_ip4_udp(void) "Calculating IPv4/UDP RSS  hash"
 net_rx_pkt_rss_ip6_tcp(void) "Calculating IPv6/TCP RSS  hash"
+net_rx_pkt_rss_ip6_udp(void) "Calculating IPv6/UDP RSS  hash"
 net_rx_pkt_rss_ip6(void) "Calculating IPv6 RSS  hash"
 net_rx_pkt_rss_ip6_ex(void) "Calculating IPv6/EX RSS  hash"
+net_rx_pkt_rss_ip6_ex_tcp(void) "Calculating IPv6/EX/TCP RSS  hash"
+net_rx_pkt_rss_ip6_ex_udp(void) "Calculating IPv6/EX/UDP RSS  hash"
 net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash for %z=
u bytes: 0x%X"
 net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset) "Add=
 RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
=20
--=20
2.5.0


