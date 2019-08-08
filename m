Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E551C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C7272184E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C7272184E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjXo-0003iQ-Je
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57146)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvjX8-0001zB-Fx
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:36:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvjX7-00062t-9Q
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:36:50 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42208)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvjX5-00061v-Ax
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:36:47 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 68E0330A00DC;
 Thu,  8 Aug 2019 14:36:46 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F31E51001956;
 Thu,  8 Aug 2019 14:36:20 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 16:34:55 +0200
Message-Id: <20190808143457.14111-5-philmd@redhat.com>
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
References: <20190808143457.14111-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.43]); Thu, 08 Aug 2019 14:36:46 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 4/6] hw/net/vmxnet3: Use the tcp_header
 structure
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
Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Li Zhijian <lizhijian@cn.fujitsu.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Zhang Chen <chen.zhang@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The tcp_header structure comes convenient macros to avoid
manipulating the TCP header flags/offset bits manually.
Replace the tcp_hdr structure by the tcp_header equivalent,
and use the macros.

Since we will remove the duplicated TCP_FLAG_ACK definition
in the next commit, replace its use now.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC: Verify th_off endianess

 hw/net/net_rx_pkt.c | 2 +-
 hw/net/net_tx_pkt.c | 7 ++++---
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/net_rx_pkt.c b/hw/net/net_rx_pkt.c
index 98a5030ace..7558f0646a 100644
--- a/hw/net/net_rx_pkt.c
+++ b/hw/net/net_rx_pkt.c
@@ -376,7 +376,7 @@ bool net_rx_pkt_is_tcp_ack(struct NetRxPkt *pkt)
     assert(pkt);
=20
     if (pkt->istcp) {
-        return TCP_HEADER_FLAGS(&pkt->l4hdr_info.hdr.tcp) & TCP_FLAG_ACK=
;
+        return TCP_HEADER_FLAGS(&pkt->l4hdr_info.hdr.tcp) & TH_ACK;
     }
=20
     return false;
diff --git a/hw/net/net_tx_pkt.c b/hw/net/net_tx_pkt.c
index 162f802dd7..fc4514416c 100644
--- a/hw/net/net_tx_pkt.c
+++ b/hw/net/net_tx_pkt.c
@@ -307,7 +307,7 @@ func_exit:
 void net_tx_pkt_build_vheader(struct NetTxPkt *pkt, bool tso_enable,
     bool csum_enable, uint32_t gso_size)
 {
-    struct tcp_hdr l4hdr;
+    struct tcp_header l4hdr;
     assert(pkt);
=20
     /* csum has to be enabled if tso is. */
@@ -330,7 +330,8 @@ void net_tx_pkt_build_vheader(struct NetTxPkt *pkt, b=
ool tso_enable,
     case VIRTIO_NET_HDR_GSO_TCPV6:
         iov_to_buf(&pkt->vec[NET_TX_PKT_PL_START_FRAG], pkt->payload_fra=
gs,
                    0, &l4hdr, sizeof(l4hdr));
-        pkt->virt_hdr.hdr_len =3D pkt->hdr_len + l4hdr.th_off * sizeof(u=
int32_t);
+        pkt->virt_hdr.hdr_len =3D pkt->hdr_len
+                            + TCP_HEADER_DATA_OFFSET(&l4hdr) * sizeof(ui=
nt32_t);
         pkt->virt_hdr.gso_size =3D gso_size;
         break;
=20
@@ -343,7 +344,7 @@ void net_tx_pkt_build_vheader(struct NetTxPkt *pkt, b=
ool tso_enable,
         case IP_PROTO_TCP:
             pkt->virt_hdr.flags =3D VIRTIO_NET_HDR_F_NEEDS_CSUM;
             pkt->virt_hdr.csum_start =3D pkt->hdr_len;
-            pkt->virt_hdr.csum_offset =3D offsetof(struct tcp_hdr, th_su=
m);
+            pkt->virt_hdr.csum_offset =3D offsetof(struct tcp_header, th=
_sum);
             break;
         case IP_PROTO_UDP:
             pkt->virt_hdr.flags =3D VIRTIO_NET_HDR_F_NEEDS_CSUM;
--=20
2.20.1


