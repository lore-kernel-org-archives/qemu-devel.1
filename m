Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 695DBC3F2D2
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:45:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34C29246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:45:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RQHwyG+n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34C29246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8flW-0004gf-6H
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60039)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fh9-0003c4-Gy
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fh8-0003P3-G5
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:55 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:53063
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fh8-0003OP-CM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134854;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JH+RB81HXiuvd/zhpDJS7O/7Rt1VoS75u8d6tZLzezA=;
 b=RQHwyG+nR88rEjCwOFG9V9qJXS4pl6WdY1FPMf8gKMYvBxiufB6whG8/42EQLuNYZpTA1M
 y/aPdChV3HjIt4OcFIeIM26vlybXcNdDkCTuSrRwDcVbAmPx3w87whQQusdSKxZiNj6Obr
 NGOxQ+pEeqIGkV0WGwOiOuvwB3pwp5k=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-141-DQoa_lk_NeKdqnNzs7iQYg-1; Mon, 02 Mar 2020 02:40:50 -0500
X-MC-Unique: DQoa_lk_NeKdqnNzs7iQYg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0C7EE107ACC4;
 Mon,  2 Mar 2020 07:40:49 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 614F060BF3;
 Mon,  2 Mar 2020 07:40:47 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 04/23] dp8393x: Have dp8393x_receive() return the packet size
Date: Mon,  2 Mar 2020 15:40:17 +0800
Message-Id: <1583134836-23991-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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

This function re-uses its 'size' argument as a scratch variable.
Instead, declare a local 'size' variable for that purpose so that the
function result doesn't get messed up.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 1844482..ed57f5f 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -759,20 +759,21 @@ static int dp8393x_receive_filter(dp8393xState *s, co=
nst uint8_t * buf,
 }
=20
 static ssize_t dp8393x_receive(NetClientState *nc, const uint8_t * buf,
-                               size_t size)
+                               size_t pkt_size)
 {
     dp8393xState *s =3D qemu_get_nic_opaque(nc);
     int packet_type;
     uint32_t available, address;
-    int width, rx_len =3D size;
+    int width, rx_len =3D pkt_size;
     uint32_t checksum;
+    int size;
=20
     width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
=20
     s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FA=
ER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
=20
-    packet_type =3D dp8393x_receive_filter(s, buf, size);
+    packet_type =3D dp8393x_receive_filter(s, buf, pkt_size);
     if (packet_type < 0) {
         DPRINTF("packet not for netcard\n");
         return -1;
@@ -868,7 +869,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
     /* Done */
     dp8393x_update_irq(s);
=20
-    return size;
+    return pkt_size;
 }
=20
 static void dp8393x_reset(DeviceState *dev)
--=20
2.5.0


