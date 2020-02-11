Return-Path: <SRS0=pnX7=37=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EDD7C352A3
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:43:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DED27206D7
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2020 07:43:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EZQ9pR+M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DED27206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44520 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1QCj-0005co-W5
	for qemu-devel@archiver.kernel.org; Tue, 11 Feb 2020 02:43:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ppandit@redhat.com>) id 1j1QC0-0005BA-8A
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:42:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ppandit@redhat.com>) id 1j1QBz-0000XA-2s
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:42:48 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:57666
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ppandit@redhat.com>) id 1j1QBy-0000Wo-Vp
 for qemu-devel@nongnu.org; Tue, 11 Feb 2020 02:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581406966;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=8F/BAAYFcKW0VXoZQXNoaYG3hhN8chrdqR63Lje/DZg=;
 b=EZQ9pR+M53WGvfiIVGxntOCQDsMdP5ql8o/aFh/43Q4rFXnp85dGyDfxxW6WVWkSqOs26G
 BX20qm42I7jvbEqwhjycjwcVK9qKOWXkXJPogRdxSiTl7CzUsHqwvWO/kViYDsK0resvUV
 uLPuMI2W6C8yBblZGI/7ExnXmTX0FFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-braiVIj3NhKK_4jwHNvYeQ-1; Tue, 11 Feb 2020 02:41:38 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 064BE8010CB;
 Tue, 11 Feb 2020 07:41:37 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-122.phx2.redhat.com
 [10.3.116.122])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EC823196AE;
 Tue, 11 Feb 2020 07:41:33 +0000 (UTC)
From: P J P <ppandit@redhat.com>
To: Qemu Developers <qemu-devel@nongnu.org>
Subject: [PATCH] net: tulip: check frame size and r/w data length
Date: Tue, 11 Feb 2020 13:09:30 +0530
Message-Id: <20200211073930.224024-1-ppandit@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: braiVIj3NhKK_4jwHNvYeQ-1
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
Cc: Li Qiang <pangpei.lq@antfin.com>, Jason Wang <jasowang@redhat.com>,
 Sven Schnelle <svens@stackframe.org>, Prasad J Pandit <pjp@fedoraproject.org>,
 Ziming Zhang <ezrakiez@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Tulip network driver while copying tx/rx buffers does not check
frame size against r/w data length. This may lead to OOB buffer
access. Add check to avoid it.

Reported-by: Li Qiang <pangpei.lq@antfin.com>
Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
---
 hw/net/tulip.c | 55 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index cfac2719d3..aca2a3f17f 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -164,27 +164,35 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct=
 tulip_descriptor *desc)
     int len2 =3D (desc->control >> RDES1_BUF2_SIZE_SHIFT) & RDES1_BUF2_SIZ=
E_MASK;
     int len;
=20
-    if (s->rx_frame_len && len1) {
-        if (s->rx_frame_len > len1) {
-            len =3D len1;
-        } else {
-            len =3D s->rx_frame_len;
-        }
-        pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
-            (s->rx_frame_size - s->rx_frame_len), len);
-        s->rx_frame_len -=3D len;
+    if (!len1 || !len2 || !s->rx_frame_len) {
+        return;
     }
=20
-    if (s->rx_frame_len && len2) {
-        if (s->rx_frame_len > len2) {
-            len =3D len2;
-        } else {
-            len =3D s->rx_frame_len;
-        }
-        pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
-            (s->rx_frame_size - s->rx_frame_len), len);
-        s->rx_frame_len -=3D len;
+    if (s->rx_frame_len > len1) {
+        len =3D len1;
+    } else {
+        len =3D s->rx_frame_len;
     }
+
+    if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
+        return;
+    }
+    pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
+        (s->rx_frame_size - s->rx_frame_len), len);
+    s->rx_frame_len -=3D len;
+
+    if (s->rx_frame_len > len2) {
+        len =3D len2;
+    } else {
+        len =3D s->rx_frame_len;
+    }
+
+    if (s->rx_frame_len + len >=3D sizeof(s->rx_frame)) {
+        return;
+    }
+    pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
+        (s->rx_frame_size - s->rx_frame_len), len);
+    s->rx_frame_len -=3D len;
 }
=20
 static bool tulip_filter_address(TULIPState *s, const uint8_t *addr)
@@ -227,7 +235,8 @@ static ssize_t tulip_receive(TULIPState *s, const uint8=
_t *buf, size_t size)
=20
     trace_tulip_receive(buf, size);
=20
-    if (size < 14 || size > 2048 || s->rx_frame_len || tulip_rx_stopped(s)=
) {
+    if (size < 14 || size > sizeof(s->rx_frame) - 4
+        || s->rx_frame_len || tulip_rx_stopped(s)) {
         return 0;
     }
=20
@@ -558,7 +567,7 @@ static void tulip_tx(TULIPState *s, struct tulip_descri=
ptor *desc)
         if ((s->csr[6] >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
             /* Internal or external Loopback */
             tulip_receive(s, s->tx_frame, s->tx_frame_len);
-        } else {
+        } else if (s->tx_frame_len < sizeof(s->tx_frame)) {
             qemu_send_packet(qemu_get_queue(s->nic),
                 s->tx_frame, s->tx_frame_len);
         }
@@ -575,12 +584,18 @@ static void tulip_copy_tx_buffers(TULIPState *s, stru=
ct tulip_descriptor *desc)
     int len1 =3D (desc->control >> TDES1_BUF1_SIZE_SHIFT) & TDES1_BUF1_SIZ=
E_MASK;
     int len2 =3D (desc->control >> TDES1_BUF2_SIZE_SHIFT) & TDES1_BUF2_SIZ=
E_MASK;
=20
+    if (s->tx_frame_len + len1 >=3D sizeof(s->tx_frame)) {
+        return;
+    }
     if (len1) {
         pci_dma_read(&s->dev, desc->buf_addr1,
             s->tx_frame + s->tx_frame_len, len1);
         s->tx_frame_len +=3D len1;
     }
=20
+    if (s->tx_frame_len + len2 >=3D sizeof(s->tx_frame)) {
+        return;
+    }
     if (len2) {
         pci_dma_read(&s->dev, desc->buf_addr2,
             s->tx_frame + s->tx_frame_len, len2);
--=20
2.24.1


