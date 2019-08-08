Return-Path: <SRS0=Rh1V=WE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A4C0650F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2DA2173E
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2019 14:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2DA2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hvjXv-00047S-IM
	for qemu-devel@archiver.kernel.org; Thu, 08 Aug 2019 10:37:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56983)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hvjWH-0000IQ-8R
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hvjWG-0005em-8U
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:35:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43164)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1hvjWG-0005e9-3O
 for qemu-devel@nongnu.org; Thu, 08 Aug 2019 10:35:56 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 93C362D0FCE;
 Thu,  8 Aug 2019 14:35:54 +0000 (UTC)
Received: from x1w.redhat.com (unknown [10.40.205.30])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 1D68410016F3;
 Thu,  8 Aug 2019 14:35:51 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu,  8 Aug 2019 16:34:53 +0200
Message-Id: <20190808143457.14111-3-philmd@redhat.com>
In-Reply-To: <20190808143457.14111-1-philmd@redhat.com>
References: <20190808143457.14111-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.29]); Thu, 08 Aug 2019 14:35:54 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [RFC PATCH 2/6] net/colo-compare: Use the tcp_header
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

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
RFC: Verify th_off endianess

 net/colo-compare.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/net/colo-compare.c b/net/colo-compare.c
index 7489840bde..14ee4166ba 100644
--- a/net/colo-compare.c
+++ b/net/colo-compare.c
@@ -161,28 +161,28 @@ static void colo_compare_inconsistency_notify(Compa=
reState *s)
=20
 static gint seq_sorter(Packet *a, Packet *b, gpointer data)
 {
-    struct tcp_hdr *atcp, *btcp;
+    struct tcp_header *atcp, *btcp;
=20
-    atcp =3D (struct tcp_hdr *)(a->transport_header);
-    btcp =3D (struct tcp_hdr *)(b->transport_header);
+    atcp =3D (struct tcp_header *)(a->transport_header);
+    btcp =3D (struct tcp_header *)(b->transport_header);
     return ntohl(atcp->th_seq) - ntohl(btcp->th_seq);
 }
=20
 static void fill_pkt_tcp_info(void *data, uint32_t *max_ack)
 {
     Packet *pkt =3D data;
-    struct tcp_hdr *tcphd;
+    struct tcp_header *tcphd;
=20
-    tcphd =3D (struct tcp_hdr *)pkt->transport_header;
+    tcphd =3D (struct tcp_header *)pkt->transport_header;
=20
     pkt->tcp_seq =3D ntohl(tcphd->th_seq);
     pkt->tcp_ack =3D ntohl(tcphd->th_ack);
     *max_ack =3D *max_ack > pkt->tcp_ack ? *max_ack : pkt->tcp_ack;
     pkt->header_size =3D pkt->transport_header - (uint8_t *)pkt->data
-                       + (tcphd->th_off << 2) - pkt->vnet_hdr_len;
+                       + TCP_HEADER_DATA_OFFSET(tcphd) - pkt->vnet_hdr_l=
en;
     pkt->payload_size =3D pkt->size - pkt->header_size;
     pkt->seq_end =3D pkt->tcp_seq + pkt->payload_size;
-    pkt->flags =3D tcphd->th_flags;
+    pkt->flags =3D TCP_HEADER_FLAGS(tcphd);
 }
=20
 /*
--=20
2.20.1


