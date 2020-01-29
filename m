Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F148C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:43:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 231212070E
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 09:43:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 231212070E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=telegraphics.com.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43396 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwjsl-0001WJ-D9
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 04:43:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51779)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjlP-0004N2-4m
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:36:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>) id 1iwjlN-0001EA-Nh
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 04:35:59 -0500
Received: from kvm5.telegraphics.com.au ([98.124.60.144]:50036)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <fthain@telegraphics.com.au>)
 id 1iwjlN-0000jX-Im; Wed, 29 Jan 2020 04:35:57 -0500
Received: by kvm5.telegraphics.com.au (Postfix, from userid 502)
 id 48069299BD; Wed, 29 Jan 2020 04:35:35 -0500 (EST)
To: Jason Wang <jasowang@redhat.com>,
    qemu-devel@nongnu.org
Message-Id: <402b2340dadff0925d91ebea1fb1f9486886f7da.1580290069.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1580290069.git.fthain@telegraphics.com.au>
References: <cover.1580290069.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH v4 03/14] dp8393x: Clean up endianness hacks
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date: Wed, 29 Jan 2020 20:27:49 +1100
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 98.124.60.144
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

According to the datasheet, section 3.4.4, "in 32-bit mode ... the SONIC
always writes long words".

Therefore, use the same technique for the 'in_use' field that is used
everywhere else, and write the full long word.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
Changed since v1:
 - Use existing 'address' variable rather than declare a new one.

Laurent tells me that a similar clean-up has been tried before.
He referred me to commit c744cf7879 ("dp8393x: fix dp8393x_receive()")
and commit 409b52bfe1 ("net/dp8393x: correctly reset in_use field").
I believe the underlying issue has been fixed by the preceding patch,
as this no longer breaks NetBSD 5.1.
---
 hw/net/dp8393x.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index b2fd44bc2f..2d2ace2549 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -776,8 +776,6 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
         return -1;
     }
=20
-    /* XXX: Check byte ordering */
-
     /* Check for EOL */
     if (s->regs[SONIC_LLFA] & SONIC_DESC_EOL) {
         /* Are we still in resource exhaustion? */
@@ -847,15 +845,12 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
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
-        address_space_rw(&s->as, offset, MEMTXATTRS_UNSPECIFIED,
-                         (uint8_t *)s->data, sizeof(uint16_t), 1);
+        /* Clear in_use */
+        size =3D sizeof(uint16_t) * width;
+        address =3D dp8393x_crda(s) + sizeof(uint16_t) * 6 * width;
+        dp8393x_put(s, width, 0, 0);
+        address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
+                         (uint8_t *)s->data, size, 1);
         s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
         s->regs[SONIC_RSC] =3D (s->regs[SONIC_RSC] & 0xff00) | (((s->reg=
s[SONIC_RSC] & 0x00ff) + 1) & 0x00ff);
--=20
2.24.1


