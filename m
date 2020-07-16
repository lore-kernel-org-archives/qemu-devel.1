Return-Path: <SRS0=z35Y=A3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0212FC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:24:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEFC7205CB
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2020 03:24:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="ixTD+W8R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEFC7205CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40538 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvuW2-0003ih-0p
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 23:24:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47020)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jvuVP-0003HY-R2
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:24:19 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:41223)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1jvuVN-0000yL-UZ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 23:24:19 -0400
Received: by mail-lj1-x241.google.com with SMTP id z24so5389824ljn.8
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2020 20:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a7u1Ij1MelKzsNucC0SNKnQ17KYi/uecqZBTYZr/WKA=;
 b=ixTD+W8Rrdhh86mi5Py1bZK4HeGNcObuAOzpXU9BNwfmblCoF7pCj+5TMJLDajPEmf
 xBDI0CfqFnhA1XS5FesNS7sZKA/C2hH8/9nRuiIxV7Z+amktqRmI/L9VW05lvP19QAlX
 Xd+e9/EDp+rYehZN1IDY08T2I0f9zKu0GXhNW9wJmhIma8F9Ohsw2VLzswm5yuahJ0zo
 IaZLx0z9nLUxwUceXyVcPrFmt+C1u85OACzzS9+XFKJrrAYDfB+laGlqj1hLRvictv/+
 +gDb2RCFguyJg2+6u2gMfr6SuheFNSuZhCNk5nw/r4yN9g353bhkn258OrovSKzRM8hR
 lQzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=a7u1Ij1MelKzsNucC0SNKnQ17KYi/uecqZBTYZr/WKA=;
 b=R5itUXdjMPD+jcNKvjXt+xmQppQU/N7o52MOnn+XFLOAUOYVll31a6YsRd7o6UdYSp
 Rwbpr0rdsHWP6y9QXy6OR8ERhVdjO7kbxKgSzr7NVUd1S1Q/s4V0o2z8dJlJiW74U9Z3
 n3gH/bYij2SZ+sWO5p6N7E+iJvoAzX1lsTJP1MMVwEJudaZiR/b2cx4DJSGHh+bMg2jS
 NgZO4/7Y7yua2BO0pjIX9k62q0dbxZq5vpASieqoyqkxJGBJhY/L7x5vuMQ4FgIQU8Vx
 HnadIl8mzns++V0C5ns/M8LXuSVxES5neZYrWcZPTo4u7aWmJ1JYYvHX+WjJLAWCN4FQ
 AOVg==
X-Gm-Message-State: AOAM533qpw8l33TcLKHrX4J1IFSZfWLiUjqN+n3EwhybA+A1P9Zn1w8d
 VAaB92w8HCUBy0dz4qoHaP7Ff7zGGJsU9Q==
X-Google-Smtp-Source: ABdhPJwMn61+tx889eLjuf34pVtBVBC5b5V2CPN6unUG79n8zJjnPFvIusjn6vr8fDtAwVZe9O6wNg==
X-Received: by 2002:a2e:a375:: with SMTP id i21mr1007716ljn.403.1594869855034; 
 Wed, 15 Jul 2020 20:24:15 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id o1sm774772ljj.82.2020.07.15.20.24.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2020 20:24:14 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH v3 1/2] hw/net: Added plen fix for IPv6
Date: Thu, 16 Jul 2020 06:53:24 +0300
Message-Id: <20200716035325.1406919-1-andrew@daynix.com>
X-Mailer: git-send-email 2.27.0
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
Cc: jasowang@redhat.com, dmitry.fleytman@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=1708065
With network backend with 'virtual header' - there was an issue
in 'plen' field. Overall, during TSO, 'plen' would be changed,
but with 'vheader' this field should be set to the size of the
payload itself instead of '0'.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/net_tx_pkt.c | 23 +++++++++++++++++++++++
 hw/net/net_tx_pkt.h | 14 ++++++++++++++
 include/net/eth.h   |  1 +
 3 files changed, 38 insertions(+)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 331c73cfc0..9560e4a49e 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -626,6 +626,7 @@ bool net_tx_pkt_send(struct NetTxPkt *pkt, NetClientState *nc)
 
     if (pkt->has_virt_hdr ||
         pkt->virt_hdr.gso_type == VIRTIO_NET_HDR_GSO_NONE) {
+        net_tx_pkt_fix_ip6_payload_len(pkt);
         net_tx_pkt_sendv(pkt, nc, pkt->vec,
             pkt->payload_frags + NET_TX_PKT_PL_START_FRAG);
         return true;
@@ -644,3 +645,25 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt, NetClientState *nc)
 
     return res;
 }
+
+void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt)
+{
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
index 212ecc62fc..4ec8bbe9bd 100644
--- a/hw/net/net_tx_pkt.h
+++ b/hw/net/net_tx_pkt.h
@@ -187,4 +187,18 @@ bool net_tx_pkt_parse(struct NetTxPkt *pkt);
 */
 bool net_tx_pkt_has_fragments(struct NetTxPkt *pkt);
 
+/**
+ * Fix IPv6 'plen' field.
+ * If ipv6 payload length field is 0 - then there should be Hop-by-Hop
+ * option for packets greater than 65,535.
+ * For packets with a payload less than 65,535: fix 'plen' field.
+ * For backends with vheader, we need just one packet with proper
+ * payload size. For now, qemu drops every packet with size greater 64K
+ * (see net_tx_pkt_send()) so, there is no reason to add jumbo option to ip6
+ * hop-by-hop extension if it's missed
+ *
+ * @pkt            packet
+ */
+void net_tx_pkt_fix_ip6_payload_len(struct NetTxPkt *pkt);
+
 #endif
diff --git a/include/net/eth.h b/include/net/eth.h
index 7f45c678e7..0671be6916 100644
--- a/include/net/eth.h
+++ b/include/net/eth.h
@@ -186,6 +186,7 @@ struct tcp_hdr {
 
 #define ip6_nxt      ip6_ctlun.ip6_un1.ip6_un1_nxt
 #define ip6_ecn_acc  ip6_ctlun.ip6_un3.ip6_un3_ecn
+#define ip6_plen     ip6_ctlun.ip6_un1.ip6_un1_plen
 
 #define PKT_GET_ETH_HDR(p)        \
     ((struct eth_header *)(p))
-- 
2.27.0


