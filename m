Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72949C3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:15:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40C2D20863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:15:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C8yn3x27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40C2D20863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44712 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94a0-0008F0-A9
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:15:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52587)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94W9-0007oB-DR
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94W8-0006Cy-6E
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:13 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55181
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94W8-0006Cm-3E
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230271;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XbaZZadeEkAqeV8qb2+C5LgL/ogdsMt/MVvvFGwr/Ao=;
 b=C8yn3x27AyqkEyx7/zXw1P6Bh3t2PnsOTxcU6Kh6xkMbGSsobzcovh7UbLGJDkessm6cf8
 cCJ1zLJ/MBrG5uuzo+/vdUqhgrmgmtqFzfF68iQvd9kCypLdnh5rKaWyaD09pN7Y+WEbnj
 V3teAcmYBfwjbo1g1pume1hvRyGFFgk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-ZkTBH3oqNHuzqx8u8Wr0WA-1; Tue, 03 Mar 2020 05:11:09 -0500
X-MC-Unique: ZkTBH3oqNHuzqx8u8Wr0WA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D5816189F767;
 Tue,  3 Mar 2020 10:11:08 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3E4398D56B;
 Tue,  3 Mar 2020 10:11:06 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 10/23] dp8393x: Pad frames to word or long word boundary
Date: Tue,  3 Mar 2020 18:10:29 +0800
Message-Id: <1583230242-14597-11-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.120
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

The existing code has a bug where the Remaining Buffer Word Count (RBWC)
is calculated with a truncating division, which gives the wrong result
for odd-sized packets.

Section 1.4.1 of the datasheet says,

    Once the end of the packet has been reached, the serializer will
    fill out the last word (16-bit mode) or long word (32-bit mode)
    if the last byte did not end on a word or long word boundary
    respectively. The fill byte will be 0FFh.

Implement buffer padding so that buffer limits are correctly enforced.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 39 ++++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 11 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index d8bf248..22b4d36 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -768,16 +768,23 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     dp8393xState *s =3D qemu_get_nic_opaque(nc);
     int packet_type;
     uint32_t available, address;
-    int width, rx_len =3D pkt_size;
+    int width, rx_len, padded_len;
     uint32_t checksum;
     int size;
=20
-    width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
-
     s->regs[SONIC_RCR] &=3D ~(SONIC_RCR_PRX | SONIC_RCR_LBK | SONIC_RCR_FA=
ER |
         SONIC_RCR_CRCR | SONIC_RCR_LPKT | SONIC_RCR_BC | SONIC_RCR_MC);
=20
-    if (pkt_size + 4 > dp8393x_rbwc(s) * 2) {
+    rx_len =3D pkt_size + sizeof(checksum);
+    if (s->regs[SONIC_DCR] & SONIC_DCR_DW) {
+        width =3D 2;
+        padded_len =3D ((rx_len - 1) | 3) + 1;
+    } else {
+        width =3D 1;
+        padded_len =3D ((rx_len - 1) | 1) + 1;
+    }
+
+    if (padded_len > dp8393x_rbwc(s) * 2) {
         DPRINTF("oversize packet, pkt_size is %d\n", pkt_size);
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RBAE;
         dp8393x_update_irq(s);
@@ -812,22 +819,32 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     s->regs[SONIC_TRBA0] =3D s->regs[SONIC_CRBA0];
=20
     /* Calculate the ethernet checksum */
-    checksum =3D cpu_to_le32(crc32(0, buf, rx_len));
+    checksum =3D cpu_to_le32(crc32(0, buf, pkt_size));
=20
     /* Put packet into RBA */
     DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
     address =3D dp8393x_crba(s);
     address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                        buf, rx_len);
-    address +=3D rx_len;
+                        buf, pkt_size);
+    address +=3D pkt_size;
+
+    /* Put frame checksum into RBA */
     address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
-                        &checksum, 4);
-    address +=3D 4;
-    rx_len +=3D 4;
+                        &checksum, sizeof(checksum));
+    address +=3D sizeof(checksum);
+
+    /* Pad short packets to keep pointers aligned */
+    if (rx_len < padded_len) {
+        size =3D padded_len - rx_len;
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+            (uint8_t *)"\xFF\xFF\xFF", size, 1);
+        address +=3D size;
+    }
+
     s->regs[SONIC_CRBA1] =3D address >> 16;
     s->regs[SONIC_CRBA0] =3D address & 0xffff;
     available =3D dp8393x_rbwc(s);
-    available -=3D rx_len / 2;
+    available -=3D padded_len >> 1;
     s->regs[SONIC_RBWC1] =3D available >> 16;
     s->regs[SONIC_RBWC0] =3D available & 0xffff;
=20
--=20
2.5.0


