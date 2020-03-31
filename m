Return-Path: <SRS0=xFA2=5Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13875C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:35:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85D7D2071A
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2020 13:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XK4II3Km"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85D7D2071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38178 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJH3A-0004Nq-Ji
	for qemu-devel@archiver.kernel.org; Tue, 31 Mar 2020 09:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42111)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1jJGqZ-0000hD-6Y
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1jJGqY-0005yG-47
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:27 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:23412
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1jJGqX-0005xU-WC
 for qemu-devel@nongnu.org; Tue, 31 Mar 2020 09:22:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1585660945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e2MtJXqXrK00L/Pg7ncr4ONHm/ufHOeDphL4A31MD7k=;
 b=XK4II3KmupQ9QldskIz3TequTmVzdJELICFdFO0eZlP/F98KehM4qA+SBoVrT84VPoJ5o6
 LtL8l/JLJOvsja9xUPfRd4zxUgS3tVTeR9MFNyA2JIKuJYiUJ8DC1rajDD8f0ZlVGpg7Qk
 V7UV4ACuoXbYTCUgqpfeAoY6Sp5HYlg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-8kQxrIl1O6CN6riw5Hu-sg-1; Tue, 31 Mar 2020 09:22:20 -0400
X-MC-Unique: 8kQxrIl1O6CN6riw5Hu-sg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3FD45107B267;
 Tue, 31 Mar 2020 13:22:19 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-118.pek2.redhat.com
 [10.72.12.118])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D72801001B28;
 Tue, 31 Mar 2020 13:22:17 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL V2 13/14] hw/net/allwinner-sun8i-emac.c: Fix REG_ADDR_HIGH/LOW
 reads
Date: Tue, 31 Mar 2020 21:21:38 +0800
Message-Id: <1585660899-11228-14-git-send-email-jasowang@redhat.com>
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
Cc: Jason Wang <jasowang@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Peter Maydell <peter.maydell@linaro.org>

Coverity points out (CID 1421926) that the read code for
REG_ADDR_HIGH reads off the end of the buffer, because it does a
32-bit read from byte 4 of a 6-byte buffer.

The code also has an endianness issue for both REG_ADDR_HIGH and
REG_ADDR_LOW, because it will do the wrong thing on a big-endian
host.

Rewrite the read code to use ldl_le_p() and lduw_le_p() to fix this;
the write code is not incorrect, but for consistency we make it use
stl_le_p() and stw_le_p().

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Tested-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Reviewed-by: Niek Linnenbank <nieklinnenbank@gmail.com>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/allwinner-sun8i-emac.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/hw/net/allwinner-sun8i-emac.c b/hw/net/allwinner-sun8i-emac.c
index 033eaa8..28637ff 100644
--- a/hw/net/allwinner-sun8i-emac.c
+++ b/hw/net/allwinner-sun8i-emac.c
@@ -611,10 +611,10 @@ static uint64_t allwinner_sun8i_emac_read(void *opaqu=
e, hwaddr offset,
         value =3D s->mii_data;
         break;
     case REG_ADDR_HIGH:         /* MAC Address High */
-        value =3D *(((uint32_t *) (s->conf.macaddr.a)) + 1);
+        value =3D lduw_le_p(s->conf.macaddr.a + 4);
         break;
     case REG_ADDR_LOW:          /* MAC Address Low */
-        value =3D *(uint32_t *) (s->conf.macaddr.a);
+        value =3D ldl_le_p(s->conf.macaddr.a);
         break;
     case REG_TX_DMA_STA:        /* Transmit DMA Status */
         break;
@@ -728,14 +728,10 @@ static void allwinner_sun8i_emac_write(void *opaque, =
hwaddr offset,
         s->mii_data =3D value;
         break;
     case REG_ADDR_HIGH:         /* MAC Address High */
-        s->conf.macaddr.a[4] =3D (value & 0xff);
-        s->conf.macaddr.a[5] =3D (value & 0xff00) >> 8;
+        stw_le_p(s->conf.macaddr.a + 4, value);
         break;
     case REG_ADDR_LOW:          /* MAC Address Low */
-        s->conf.macaddr.a[0] =3D (value & 0xff);
-        s->conf.macaddr.a[1] =3D (value & 0xff00) >> 8;
-        s->conf.macaddr.a[2] =3D (value & 0xff0000) >> 16;
-        s->conf.macaddr.a[3] =3D (value & 0xff000000) >> 24;
+        stl_le_p(s->conf.macaddr.a, value);
         break;
     case REG_TX_DMA_STA:        /* Transmit DMA Status */
     case REG_TX_CUR_DESC:       /* Transmit Current Descriptor */
--=20
2.5.0


