Return-Path: <SRS0=nktx=5V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89761C2BA15
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:54:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E0B120659
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2020 18:54:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com header.i=@daynix-com.20150623.gappssmtp.com header.b="Hg8IcxJ2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E0B120659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLAPJ-0006w7-Gd
	for qemu-devel@archiver.kernel.org; Sun, 05 Apr 2020 14:54:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35949)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <andrew@daynix.com>) id 1jLANw-0005m4-DN
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 14:52:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <andrew@daynix.com>) id 1jLANv-0006SM-6o
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 14:52:44 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:45784)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <andrew@daynix.com>) id 1jLANv-0006Qv-0M
 for qemu-devel@nongnu.org; Sun, 05 Apr 2020 14:52:43 -0400
Received: by mail-lj1-x243.google.com with SMTP id t17so12287572ljc.12
 for <qemu-devel@nongnu.org>; Sun, 05 Apr 2020 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3sA8pH7seALF2QzJV8GVxLt5pHkKdiNBdLQFXUpSj3k=;
 b=Hg8IcxJ2MIxnIkWg3HhKy3PcilnLSXVmV4xPk9fzzJ1pxletmybu5nDOHvVLAVuyAR
 YkJFmSXxrQ9/kChCpK96XUhoPVWQBrbQpji0OYwSN43+Wyaj8zShr0FvwGrExOvA82Es
 HXHtgptxlrS0O46UrUlXG+qAxf/l1vzVmhoHUKcA7ZxJO61M58Xw06BHj/x6qdftq9XM
 JYDYzEnB8Op8+B+WggTZErXCqIRaQF/sdI1XHajAl9IJh0HvvhZXDC2fRgCtDzi5IWXC
 wQnkCREc5IMYSUt26bFJegVIOH5joNxkC72ojmDbBdyN1J15rmNc/BfginFgW6hhfGqP
 IoHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=3sA8pH7seALF2QzJV8GVxLt5pHkKdiNBdLQFXUpSj3k=;
 b=Z1jLJzdehoLe7mTCN3Dy1IuFc1TnSNcyj4lY4+uspn3rqugONwQ83iO3OtWiIlkT0K
 qX5jJXY7A17SfQ+kC7Q8d1SeZ9ZdWOh9O6SjjR2jWbD/ZYefBG1+R8urjt1LwZEODgKl
 KONJ9klcgr5sqgJ5OEUajELD4mQvSgJaGwXSqjt9QCsJiPDZcePzmhRTUaYvjAcEj8ey
 hJP2wFKAUCsNVqU3WhxXpkPsJu4jsHBk0tWsV7lUp8wScRtwC7smUzwoavzS2ZalI3v3
 zKV/c3PSbaixjooFYNRlhaJfOKfccYCF7IOGwaX2OK3G64ZsBGhvAlg6uUT7v2piXFt7
 iKBQ==
X-Gm-Message-State: AGi0PubVsUpeSSZox5uzsCylMD+Gs2jxlqkx4ZVFpOYoyA1H9Y2gvct2
 oLaILH6gaOuzNlS0UZSoxQUY+2NGCfs=
X-Google-Smtp-Source: APiQypLt1mMoKHvuiGaLkfnGSXKBfWxzn8cvEesKEcem7B0cqpQEH/6nHBgY2KQJ+EoBfA6X0vOwKA==
X-Received: by 2002:a2e:b5bc:: with SMTP id f28mr10503744ljn.191.1586112761307; 
 Sun, 05 Apr 2020 11:52:41 -0700 (PDT)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id m7sm12182060lfh.54.2020.04.05.11.52.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Apr 2020 11:52:40 -0700 (PDT)
From: andrew@daynix.com
To: qemu-devel@nongnu.org
Subject: [PATCH] Fixed IPv6 payload lenght without jumbo option
Date: Sun,  5 Apr 2020 22:19:40 +0300
Message-Id: <20200405191940.866972-1-andrew@daynix.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
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
e1000e driver doesn't sets 'plen' field for IPv6 for big packets
if TSO is enabled. Jumbo option isn't added yet, until
qemu supports packets greater than 64K.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
---
 hw/net/e1000e_core.c |  1 +
 hw/net/net_tx_pkt.c  | 31 +++++++++++++++++++++++++++++++
 hw/net/net_tx_pkt.h  |  7 +++++++
 include/net/eth.h    |  1 +
 4 files changed, 40 insertions(+)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d5676871fa..a1ec55598b 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -656,6 +656,7 @@ e1000e_tx_pkt_send(E1000ECore *core, struct e1000e_tx *tx, int queue_index)
     NetClientState *queue = qemu_get_subqueue(core->owner_nic, target_queue);
 
     e1000e_setup_tx_offloads(core, tx);
+    net_tx_pkt_fix_ip6_payload_len(tx->tx_pkt);
 
     net_tx_pkt_dump(tx->tx_pkt);
 
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 162f802dd7..b05d554ac3 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -635,3 +635,34 @@ bool net_tx_pkt_send_loopback(struct NetTxPkt *pkt, NetClientState *nc)
 
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
2.24.1


