Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BAF9C3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FCB021556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:14:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="b3pFItTW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FCB021556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44706 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94Zd-0007R8-Dn
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:14:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52531)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94W6-0007gm-E0
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94W5-0006BZ-Dx
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:10 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33353
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94W4-0006B9-2N
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230267;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DMwzVglu3CHcRggvEoML/ZAZCqWueorRpeSh5bBDNn8=;
 b=b3pFItTWa6EiOAytFQn0VeacYJCTFTICjilW2uQW5QyRmqiFDE/98jVz0uSGSvlnSWP0gJ
 ycRVbfnkvkQlBTv+jUQjIveBoW99FAJ/V+JFurFFkdwMt1fv8nOXyGVyi98E1HXM5jX4d8
 KWdbL9VNMjF7HTUoaHx83HGbKZnv8HI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-373-u5-z6_tmNCiK4fPBWeozYg-1; Tue, 03 Mar 2020 05:11:03 -0500
X-MC-Unique: u5-z6_tmNCiK4fPBWeozYg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 72407189F764;
 Tue,  3 Mar 2020 10:11:02 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CF1268B745;
 Tue,  3 Mar 2020 10:11:00 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 07/23] dp8393x: Implement packet size limit and RBAE
 interrupt
Date: Tue,  3 Mar 2020 18:10:26 +0800
Message-Id: <1583230242-14597-8-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

Add a bounds check to prevent a large packet from causing a buffer
overflow. This is defensive programming -- I haven't actually tried
sending an oversized packet or a jumbo ethernet frame.

The SONIC handles packets that are too big for the buffer by raising
the RBAE interrupt and dropping them. Linux uses that interrupt to
count dropped packets.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b5a9c6a..911f59e 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -137,6 +137,7 @@ do { printf("sonic ERROR: %s: " fmt, __func__ , ## __VA=
_ARGS__); } while (0)
 #define SONIC_TCR_CRCI   0x2000
 #define SONIC_TCR_PINT   0x8000
=20
+#define SONIC_ISR_RBAE   0x0010
 #define SONIC_ISR_RBE    0x0020
 #define SONIC_ISR_RDE    0x0040
 #define SONIC_ISR_TC     0x0080
@@ -772,6 +773,14 @@ static ssize_t dp8393x_receive(NetClientState *nc, con=
st uint8_t * buf,
     s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FA=
ER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
=20
+    if (pkt_size + 4 > dp8393x_rbwc(s) * 2) {
+        DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
+        s->regs[SONIC_ISR] |=3D SONIC_ISR_RBAE;
+        dp8393x_update_irq(s);
+        dp8393x_do_read_rra(s);
+        return pkt_size;
+    }
+
     packet_type =3D dp8393x_receive_filter(s, buf, pkt_size);
     if (packet_type < 0) {
         DPRINTF("packet not for netcard\n");
--=20
2.5.0


