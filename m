Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 499FBC3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:41:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10EF0246A1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 07:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SxL6mobP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10EF0246A1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8fi3-0005PM-6T
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 02:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j8fh5-0003V1-Fv
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j8fh4-0003MU-Dt
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:51 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56111
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j8fh4-0003MO-A9
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 02:40:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583134850;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4OQLIIsu9IUkx4F4aWeIGd+dq+m+Lo5MX36L6VEBCAk=;
 b=SxL6mobP4TZhGuUHfW4hi0dpsMOOEvldtXxZjawGeBF78FL1M+IAzB6zsHUWmys2QfZ0xA
 9D5KGxD5knGF6p9+xPO25TiH9RwyqfSSEs5lUqpYMZXopt8H4aAVTEhDF52YijzruWPyrP
 YP2e8TKbx46yzMg2ryHG5l+Upec9M1w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-152-lFYRWfAQPmu32vzU114OhQ-1; Mon, 02 Mar 2020 02:40:47 -0500
X-MC-Unique: lFYRWfAQPmu32vzU114OhQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D60B418FE860;
 Mon,  2 Mar 2020 07:40:46 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-58.pek2.redhat.com
 [10.72.12.58])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3791160BF3;
 Mon,  2 Mar 2020 07:40:44 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL 03/23] dp8393x: Clean up endianness hacks
Date: Mon,  2 Mar 2020 15:40:16 +0800
Message-Id: <1583134836-23991-4-git-send-email-jasowang@redhat.com>
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

According to the datasheet, section 3.4.4, "in 32-bit mode ... the SONIC
always writes long words".

Therefore, use the same technique for the 'in_use' field that is used
everywhere else, and write the full long word.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 51b71da..1844482 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -778,8 +778,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, cons=
t uint8_t * buf,
         return -1;
     }
=20
-    /* XXX: Check byte ordering */
-
     /* Check for EOL */
     if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* Are we still in resource exhaustion? */
@@ -851,15 +849,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
         /* EOL detected */
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
     } else {
-        /* Clear in_use, but it is always 16bit wide */
-        int offset =3D dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
-        if (s->big_endian && width =3D=3D 2) {
-            /* we need to adjust the offset of the 16bit field */
-            offset +=3D sizeof(uint16_t);
-        }
-        s->data[0] =3D 0;
-        address_space_write(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                            s->data, sizeof(uint16_t));
+        /* Clear in_use */
+        size =3D sizeof(uint16_t) * width;
+        address =3D dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        dp8393x_put(s, width, 0, 0);
+        address_space_write(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                            s->data, size);
         s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->regs[=
SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
--=20
2.5.0


