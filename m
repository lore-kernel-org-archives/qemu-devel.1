Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D185CC3F2C6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:15:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A02F520863
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OlERbNfv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A02F520863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94aH-0000Tk-NP
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:15:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52619)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94WC-0007ux-7J
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94WB-0006E1-8b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:16 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:59997
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94WB-0006Dv-4b
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BlE0x2fR9K2mXTXTBNzBYeg25MEh6hC6Sfj3IF0JJq8=;
 b=OlERbNfvqo/6sT39WyuYt90D+6CU/VvvRjRXxZ5yrylCZgzl9P/70Z0WND6jpSRp7PZEuT
 /8SRO+CHuF8NPJEHM10QS7iepjfK/Bgl/hJdszneLFQChBWpzOaOMgSvfEEmwI4FWenV5g
 Y1DQPc4jpJcNSuZSALELSuIpojCEsII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-376-kXX60JVdP6Oii_ENnT5SDg-1; Tue, 03 Mar 2020 05:11:12 -0500
X-MC-Unique: kXX60JVdP6Oii_ENnT5SDg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 024BD107ACC7;
 Tue,  3 Mar 2020 10:11:11 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 5ECF98B745;
 Tue,  3 Mar 2020 10:11:09 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 11/23] dp8393x: Clear descriptor in_use field to release
 packet
Date: Tue,  3 Mar 2020 18:10:30 +0800
Message-Id: <1583230242-14597-12-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
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


