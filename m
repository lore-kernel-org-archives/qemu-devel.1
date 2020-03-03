Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632EDC3F2CD
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:13:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35E56214DB
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:13:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QHKRQN/5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35E56214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44688 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94Ym-0005Q6-AP
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:13:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52475)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94W1-0007bX-LN
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94W0-0006A8-FG
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31746
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94W0-00069K-0S
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230262;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLeEvUPLf1ASw7k0eneICf5PRY5hECMtvvSErcxRnew=;
 b=QHKRQN/57yRlYsAKgv2Teo0F+5ki+jk3ccGnHZQ7AS2ykUETMz1mq4UZMZCXUBxq8vX+hv
 2vnON2iZHjnWpJZhwKmZ4b3wqjsMD/o3S7nY7v6byqZLQfSD3uW1EWVbUXDaSRJKOC/Nte
 nf0B1x4FBEGWu/OXtQ6emavuetZaC7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-426-zBQlWz5nNouJc7h6h_hLRw-1; Tue, 03 Mar 2020 05:10:59 -0500
X-MC-Unique: zBQlWz5nNouJc7h6h_hLRw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3038E8017DF;
 Tue,  3 Mar 2020 10:10:58 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8F67A8B745;
 Tue,  3 Mar 2020 10:10:56 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 05/23] dp8393x: Update LLFA and CRDA registers from rx
 descriptor
Date: Tue,  3 Mar 2020 18:10:24 +0800
Message-Id: <1583230242-14597-6-git-send-email-jasowang@redhat.com>
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

Follow the algorithm given in the National Semiconductor DP83932C
datasheet in section 3.4.7:

    At the next reception, the SONIC re-reads the last RXpkt.link field,
    and updates its CRDA register to point to the next descriptor.

The chip is designed to allow the host to provide a new list of
descriptors in this way.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index ed57f5f..9604623 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -786,12 +786,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
         address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_read(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                            s->data, size);
-        if (dp8393x_get(s, width, 0) & SONIC_DESC_EOL) {
+        s->regs[SONIC_LLFA] =3D dp8393x_get(s, width, 0);
+        if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
             /* Still EOL ; stop reception */
             return -1;
-        } else {
-            s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
         }
+        /* Link has been updated by host */
+        s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
     }
=20
     /* Save current position */
@@ -840,7 +841,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
                         MEMTXATTRS_UNSPECIFIED,
                         s->data, size);
=20
-    /* Move to next descriptor */
+    /* Check link field */
     size =3D sizeof(uint16_t) * width;
     address_space_read(&s->as,
                        dp8393x_crda(s) + sizeof(uint16_t) * 5 * width,
@@ -856,6 +857,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
         dp8393x_put(s, width, 0, 0);
         address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                             s->data, size);
+
+        /* Move to next descriptor */
         s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[=
SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
--=20
2.5.0


