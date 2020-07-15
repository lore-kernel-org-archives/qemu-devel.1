Return-Path: <SRS0=mmJ2=A2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CC10C433E2
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:56:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4B10A20657
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2020 13:56:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dR+7hIng"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B10A20657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37982 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvhtG-0007Z0-J5
	for qemu-devel@archiver.kernel.org; Wed, 15 Jul 2020 09:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40584)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqt-0002pV-AJ
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:39 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:46500
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <jasowang@redhat.com>)
 id 1jvhqr-0005KF-Ni
 for qemu-devel@nongnu.org; Wed, 15 Jul 2020 09:53:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1594821217;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=RNCgE96fDYOzx5n6sI6hbRMfVSc2P45tRV6eEOJvkhE=;
 b=dR+7hIngeDyJ6Ob8K9+i269ZdFeOejO7GWuYmpWy9AmJrNfsVoPE2B9MKbayyAE178j4Lc
 sB93jkmrto78zKssHGBbWz5oe/IwurLifmB9qTKejQ5u2IdLIsSS70SmmA5TFq+x1IyFc9
 /zLfl8vmUCy7/jUqjy/mYRwRq+k5SfQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-128-sKqTKsxuPiKcrNTIxeA6tw-1; Wed, 15 Jul 2020 09:53:34 -0400
X-MC-Unique: sKqTKsxuPiKcrNTIxeA6tw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C8A4518C63D2;
 Wed, 15 Jul 2020 13:53:33 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-28.pek2.redhat.com
 [10.72.12.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0FE855C57D;
 Wed, 15 Jul 2020 13:53:31 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 2/7] hw/net: Added CSO for IPv6
Date: Wed, 15 Jul 2020 21:53:16 +0800
Message-Id: <1594821201-3708-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
References: <1594821201-3708-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=jasowang@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/15 02:37:05
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Jason Wang <jasowang@redhat.com>, Andrew <andrew@daynix.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Andrew <andrew@daynix.com>

Added fix for checksum offload for IPv6 if a backend doesn't
have a virtual header.
This patch is a part of IPv6 fragmentation.

Signed-off-by: Andrew Melnychenko <andrew@daynix.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/net_tx_pkt.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 162f802..331c73c 100644
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
-- 
2.5.0


