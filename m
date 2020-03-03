Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E410BC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:18:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CD121556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:18:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ILZDz+Qt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CD121556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44792 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94d1-0007J8-PG
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52721)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94WO-0008Nd-Nm
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94WN-0006HW-AI
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:28 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:47883
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94WN-0006HJ-7F
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230286;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1ApLhV3uZsOSY6jOtE730X7bpibd0Lku0jFdhIBohtk=;
 b=ILZDz+QtFdfzfdsGyuA9F3wNdVzZVCW+e3iqFGRYjogX5XMpEDlAN0IRiArCAprVd3ZHK+
 T7JMbeCVfvtSEQ0uBwgv2pcturYiQ096TK7KluI42bW0TU0adyqoJ7fxQ5RvgHR+T+U7jH
 BMfztd9T6FKxSVgsDCsl3fL2VSmbfKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-29-lJRPb-mCNJ6QI-vWhftuTg-1; Tue, 03 Mar 2020 05:11:25 -0500
X-MC-Unique: lJRPb-mCNJ6QI-vWhftuTg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB434107ACC7;
 Tue,  3 Mar 2020 10:11:23 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 342EF8B745;
 Tue,  3 Mar 2020 10:11:21 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 17/23] NetRxPkt: fix hash calculation of IPV6 TCP
Date: Tue,  3 Mar 2020 18:10:36 +0800
Message-Id: <1583230242-14597-18-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

When requested to calculate the hash for TCPV6 packet,
ignore overrides of source and destination addresses
in in extension headers.
Use these overrides when new hash type NetPktRssIpV6TcpEx
requested.
Use this type in e1000e hash calculation for IPv6 TCP, which
should take in account overrides of the addresses.

Signed-off-by: Yuri Benditovich <yuri.benditovich@daynix.com>
Acked-by: Dmitry Fleytman <dmitry.fleytman@gmail.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000e_core.c | 2 +-
 hw/net/net_rx_pkt.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/net/e1000e_core.c b/hw/net/e1000e_core.c
index d110c5a..94ea34d 100644
--- a/hw/net/e1000e_core.c
+++ b/hw/net/e1000e_core.c
@@ -582,7 +582,7 @@ e1000e_rss_calc_hash(E1000ECore *core,
         type =3D NetPktRssIpV4Tcp;
         break;
     case E1000_MRQ_RSS_TYPE_IPV6TCP:
-        type =3D NetPktRssIpV6Tcp;
+        type =3D NetPktRssIpV6TcpEx;
         break;
     case E1000_MRQ_RSS_TYPE_IPV6:
         type =3D NetPktRssIpV6;
diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index b2a06bd..1e1c504 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -348,7 +348,7 @@ net_rx_pkt_calc_rss_hash(struct NetRxPkt *pkt,
         assert(pkt->isip6);
         assert(pkt->istcp);
         trace_net_rx_pkt_rss_ip6_tcp();
-        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, true, &rss_length);
+        _net_rx_rss_prepare_ip6(&rss_input[0], pkt, false, &rss_length);
         _net_rx_rss_prepare_tcp(&rss_input[0], pkt, &rss_length);
         break;
     case NetPktRssIpV6:
--=20
2.5.0


