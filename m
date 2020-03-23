Return-Path: <SRS0=WkHy=5I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B24C54FCF
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:25:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 81F682076A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Mar 2020 12:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dlwODxvE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 81F682076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33104 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGM98-0000RD-Jb
	for qemu-devel@archiver.kernel.org; Mon, 23 Mar 2020 08:25:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49402)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1jGM7J-0005r0-7h
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1jGM7H-00069k-HB
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:41 -0400
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:22819)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1jGM7H-00069K-Ay
 for qemu-devel@nongnu.org; Mon, 23 Mar 2020 08:23:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584966219;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EFRe3jiDSEV3wwiVm0jYoyJtEG5U0W+CR4coHC6YYZU=;
 b=dlwODxvEmAneS7GJOdB/+OOrhlfXue9FBxEMwIyDigYlI3eBoni+G2NWhWo/ekWpiDdayd
 ovRgyWgnwiTEUjJOs+VnITw/a6tv34KZkOt4wqe2hs0/KbezyBfTZFs6A00FzpQ1ZftG9D
 a7IK4rukUCe9Sn8j7EHy3p/y8wfbY6s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-GbubzWBZNvKnmCJbqpOUXQ-1; Mon, 23 Mar 2020 08:23:36 -0400
X-MC-Unique: GbubzWBZNvKnmCJbqpOUXQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 636F11005516;
 Mon, 23 Mar 2020 12:23:35 +0000 (UTC)
Received: from localhost.localdomain (ovpn-112-176.phx2.redhat.com
 [10.3.112.176])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id B94201001920;
 Mon, 23 Mar 2020 12:23:25 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: [PATCH v6 2/2] net: tulip: add .can_receive routine
Date: Mon, 23 Mar 2020 17:51:00 +0530
Message-Id: <20200323122100.893417-3-ppandit@redhat.com>
In-Reply-To: <20200323122100.893417-1-ppandit@redhat.com>
References: <20200323122100.893417-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 63.128.21.74
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
Cc: Prasad J Pandit <pjp@fedoraproject.org>,
 Stefan Hajnoczi <stefanha@gmail.com>, Sven Schnelle <svens@stackframe.org>,
 Qemu Developers <qemu-devel@nongnu.org>, Li Qiang <pangpei.lq@antfin.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Define .can_receive routine to do sanity checks before receiving
packet data. And call qemu_flush_queued_packets to flush queued
packets once they are read in tulip_receive().

Suggested-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/net/tulip.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

Update v6: merge earlier patch 2 & 3 into one
  -> https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg06868.html

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index fbe40095da..8d8c9519e7 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -229,6 +229,18 @@ static bool tulip_filter_address(TULIPState *s, const =
uint8_t *addr)
     return ret;
 }
=20
+static int
+tulip_can_receive(NetClientState *nc)
+{
+    TULIPState *s =3D qemu_get_nic_opaque(nc);
+
+    if (s->rx_frame_len || tulip_rx_stopped(s)) {
+        return false;
+    }
+
+    return true;
+}
+
 static ssize_t tulip_receive(TULIPState *s, const uint8_t *buf, size_t siz=
e)
 {
     struct tulip_descriptor desc;
@@ -236,7 +248,7 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)
     trace_tulip_receive(buf, size);
=20
     if (size < 14 || size > sizeof(s->rx_frame) - 4
-        || s->rx_frame_len || tulip_rx_stopped(s)) {
+        || !tulip_can_receive(s->nic->ncs)) {
         return 0;
     }
=20
@@ -275,6 +287,8 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)
         tulip_desc_write(s, s->current_rx_desc, &desc);
         tulip_next_rx_descriptor(s, &desc);
     } while (s->rx_frame_len);
+
+    qemu_flush_queued_packets(qemu_get_queue(s->nic));
     return size;
 }
=20
@@ -288,6 +302,7 @@ static NetClientInfo net_tulip_info =3D {
     .type =3D NET_CLIENT_DRIVER_NIC,
     .size =3D sizeof(NICState),
     .receive =3D tulip_receive_nc,
+    .can_receive =3D tulip_can_receive,
 };
=20
 static const char *tulip_reg_name(const hwaddr addr)
--=20
2.25.1


