Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28275C2D0EE
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAA9D20784
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:28:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="G7rM3XcQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAA9D20784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJGwB-0002Gi-3X
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:28:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42087)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGqW-0000d3-VG
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGqT-0005uu-Fe
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30921
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGqT-0005ud-AH
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gwuzM2jNqoM564i9vFKMIxyP47Rn9FTVs3Xjz/vfwQI=;
 b=G7rM3XcQhK7YZPsuAHrneUSE/0tBSPEhmh4/BE2Nm/T09WoA4dQ2l+9QyKL3v1c+8KiFrY
 CNXhhqIbdk/RQePyNE8MLPltcFKGax0RJhw32Su3lB8AcnFgG4cvYYtXnSIYoIYYfRmBdy
 Gr9vJ2yg0P33AsT2dRvzNKT353Z4vWw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-395-yYt2IVyPNQCGgPxvnJ3fJA-1; Tue, 31 Mar 2020 09:22:18 -0400
X-MC-Unique: yYt2IVyPNQCGgPxvnJ3fJA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5880B18FF663;
 Tue, 31 Mar 2020 13:22:17 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AA21E1001B28;
 Tue, 31 Mar 2020 13:22:14 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 12/14] net: tulip: check frame size and r/w data length
Date: Tue, 31 Mar 2020 21:21:37 +0800
Message-Id: <1585660899-11228-13-git-send-email-jasowang@redhat.com>
In-Reply-To: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
References: <1585660899-11228-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
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
Cc: Jason Wang <jasowang@redhat.com>, Prasad J Pandit <pjp@fedoraproject.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Prasad J Pandit <pjp@fedoraproject.org>

Tulip network driver while copying tx/rx buffers does not check
frame size against r/w data length. This may lead to OOB buffer
access. Add check to avoid it.

Limit iterations over descriptors to avoid potential infinite
loop issue in tulip_xmit_list_update.

Reported-by: Li Qiang <pangpei.lq@antfin.com>
Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Reported-by: Jason Wang <jasowang@redhat.com>
Tested-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Li Qiang <liq3ea@gmail.com>
Signed-off-by: Prasad J Pandit <pjp@fedoraproject.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/tulip.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/hw/net/tulip.c b/hw/net/tulip.c
index cfac271..1295f51 100644
--- a/hw/net/tulip.c
+++ b/hw/net/tulip.c
@@ -170,6 +170,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct =
tulip_descriptor *desc)
         } else {
             len =3D s->rx_frame_len;
         }
+
+        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
+            return;
+        }
         pci_dma_write(&s->dev, desc->buf_addr1, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -=3D len;
@@ -181,6 +185,10 @@ static void tulip_copy_rx_bytes(TULIPState *s, struct =
tulip_descriptor *desc)
         } else {
             len =3D s->rx_frame_len;
         }
+
+        if (s->rx_frame_len + len > sizeof(s->rx_frame)) {
+            return;
+        }
         pci_dma_write(&s->dev, desc->buf_addr2, s->rx_frame +
             (s->rx_frame_size - s->rx_frame_len), len);
         s->rx_frame_len -=3D len;
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
@@ -275,7 +284,6 @@ static ssize_t tulip_receive_nc(NetClientState *nc,
     return tulip_receive(qemu_get_nic_opaque(nc), buf, size);
 }
=20
-
 static NetClientInfo net_tulip_info =3D {
     .type =3D NET_CLIENT_DRIVER_NIC,
     .size =3D sizeof(NICState),
@@ -558,7 +566,7 @@ static void tulip_tx(TULIPState *s, struct tulip_descri=
ptor *desc)
         if ((s->csr[6] >> CSR6_OM_SHIFT) & CSR6_OM_MASK) {
             /* Internal or external Loopback */
             tulip_receive(s, s->tx_frame, s->tx_frame_len);
-        } else {
+        } else if (s->tx_frame_len <=3D sizeof(s->tx_frame)) {
             qemu_send_packet(qemu_get_queue(s->nic),
                 s->tx_frame, s->tx_frame_len);
         }
@@ -570,23 +578,31 @@ static void tulip_tx(TULIPState *s, struct tulip_desc=
riptor *desc)
     }
 }
=20
-static void tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *=
desc)
+static int tulip_copy_tx_buffers(TULIPState *s, struct tulip_descriptor *d=
esc)
 {
     int len1 =3D (desc->control >> TDES1_BUF1_SIZE_SHIFT) & TDES1_BUF1_SIZ=
E_MASK;
     int len2 =3D (desc->control >> TDES1_BUF2_SIZE_SHIFT) & TDES1_BUF2_SIZ=
E_MASK;
=20
+    if (s->tx_frame_len + len1 > sizeof(s->tx_frame)) {
+        return -1;
+    }
     if (len1) {
         pci_dma_read(&s->dev, desc->buf_addr1,
             s->tx_frame + s->tx_frame_len, len1);
         s->tx_frame_len +=3D len1;
     }
=20
+    if (s->tx_frame_len + len2 > sizeof(s->tx_frame)) {
+        return -1;
+    }
     if (len2) {
         pci_dma_read(&s->dev, desc->buf_addr2,
             s->tx_frame + s->tx_frame_len, len2);
         s->tx_frame_len +=3D len2;
     }
     desc->status =3D (len1 + len2) ? 0 : 0x7fffffff;
+
+    return 0;
 }
=20
 static void tulip_setup_filter_addr(TULIPState *s, uint8_t *buf, int n)
@@ -651,13 +667,15 @@ static uint32_t tulip_ts(TULIPState *s)
=20
 static void tulip_xmit_list_update(TULIPState *s)
 {
+#define TULIP_DESC_MAX 128
+    uint8_t i =3D 0;
     struct tulip_descriptor desc;
=20
     if (tulip_ts(s) !=3D CSR5_TS_SUSPENDED) {
         return;
     }
=20
-    for (;;) {
+    for (i =3D 0; i < TULIP_DESC_MAX; i++) {
         tulip_desc_read(s, s->current_tx_desc, &desc);
         tulip_dump_tx_descriptor(s, &desc);
=20
@@ -675,10 +693,10 @@ static void tulip_xmit_list_update(TULIPState *s)
                 s->tx_frame_len =3D 0;
             }
=20
-            tulip_copy_tx_buffers(s, &desc);
-
-            if (desc.control & TDES1_LS) {
-                tulip_tx(s, &desc);
+            if (!tulip_copy_tx_buffers(s, &desc)) {
+                if (desc.control & TDES1_LS) {
+                    tulip_tx(s, &desc);
+                }
             }
         }
         tulip_desc_write(s, s->current_tx_desc, &desc);
--=20
2.5.0


