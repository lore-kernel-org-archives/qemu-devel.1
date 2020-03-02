Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF4CC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:48:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65E40246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:48:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="buzsa9kb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65E40246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56074 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8foK-0008GQ-Fj
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:48:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60169)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fhP-0004DH-L1
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fhO-0003cM-Hr
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34332
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fhO-0003c6-Dw
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134870;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlE0x2fR9K2mXTXTBNzBYeg25MEh6hC6Sfj3IF0JJq8=;
 b=buzsa9kb7NFgzHquk6sKXMweUiaYpDHcbtTlWgbWyX+ZVnCLmNuYsgNU6d1ruNE8EQUvt6
 JaQwFiWXMMs2qFCRS3ciEsiwgh6XmKCdRgjF3vfjLmiEiOLYjFvAdyxsHUArqNh97oxHwA
 2Bi1kznmt4cFC1z5r0WmZ2FZwxiOlZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-238-920iXU6NOdCayOD-QaRAfw-1; Mon, 02 Mar 2020 02:41:07 -0500
X-MC-Unique: 920iXU6NOdCayOD-QaRAfw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 13B3618FE860;
 Mon,  2 Mar 2020 07:41:06 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 6D60460BF3;
 Mon,  2 Mar 2020 07:41:04 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 11/23] dp8393x: Clear descriptor in_use field to release packet
Date: Mon,  2 Mar 2020 15:40:24 +0800
Message-Id: <1583134836-23991-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
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

When the SONIC receives a packet into the last available descriptor, it
retains ownership of that descriptor for as long as necessary.

Section 3.4.7 of the datasheet says,

    When the system appends more descriptors, the SONIC releases ownership
    of the descriptor after writing 0000h to the RXpkt.in_use field.

The packet can now be processed by the host, so raise a PKTRX interrupt,
just like the normal case.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 22b4d36..08194a4 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -811,7 +811,17 @@ static ssize_t dp8393x_receive(NetClientState *nc, con=
st uint8_t * buf,
             return -1;
         }
         /* Link has been updated by host */
+
+        /* Clear in_use */
+        size =3D sizeof(uint16_t) * width;
+        address =3D dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        dp8393x_put(s, width, 0, 0);
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, size, 1);
+
+        /* Move to next descriptor */
         s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
+        s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
     }
=20
     /* Save current position */
--=20
2.5.0


