Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32265C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:45:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F1CAB246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Eg5nUBCP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F1CAB246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56038 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8fld-0004um-3b
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:45:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60057)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fhD-0003mR-CL
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:41:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fhC-0003TX-9a
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:59 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20507
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fhC-0003TL-5s
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134857;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLeEvUPLf1ASw7k0eneICf5PRY5hECMtvvSErcxRnew=;
 b=Eg5nUBCPlZrvVwJbxPMQk7J1miGpGQRJlyTzlqDC0UNpINCm7QoYMSxYhnfuOs2JCscQXN
 xPpNOf07yGdNJeHGKP0jR1VvT9gEA/fG/inzcL2y1XEr4G0nrfGgFl9epS+r1x8W/h/vRI
 /bcsz9tsjSftQZ0rslJ7yLsYlsO24lY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-Mbg52s_6OFynNou0Bxq2zg-1; Mon, 02 Mar 2020 02:40:52 -0500
X-MC-Unique: Mbg52s_6OFynNou0Bxq2zg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 32838100550E;
 Mon,  2 Mar 2020 07:40:51 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 89AC360BF3;
 Mon,  2 Mar 2020 07:40:49 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 05/23] dp8393x: Update LLFA and CRDA registers from rx
 descriptor
Date: Mon,  2 Mar 2020 15:40:18 +0800
Message-Id: <1583134836-23991-6-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
References: <1583134836-23991-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
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


