Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68832C3F2D8
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:13:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2D821556
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 10:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JQPWDQVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2D821556
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44686 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j94YX-0004m1-BT
	for qemu-devel@archiver.kernel.org; Tue, 03 Mar 2020 05:13:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52426)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jasowang@redhat.com>) id 1j94Vw-0007XS-70
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jasowang@redhat.com>) id 1j94Vu-00068F-RB
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:11:00 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:58038
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1j94Vt-00066V-Dc
 for qemu-devel@nongnu.org; Tue, 03 Mar 2020 05:10:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583230256;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NOSw7EGr/gTqFXbozjor71abeAKmizCcurOBJO2SyhU=;
 b=JQPWDQVXMqoXoQCbFWyETHTEcmdqtdCB95mIxd1nY/+cZ+PyypcQPgN/ds7dz8lC14043o
 YgduRzlTioMYxCTant9ou4Qfuhrg1WKSwnoCIeijVpoWtCiOLcT43oYYqD7ivhfvcqWMqj
 y+bloz0fs6SwdhDhK0+XFiPR1cEa4zs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-Y_HpQjyCOaq4zYyi0fk0-g-1; Tue, 03 Mar 2020 05:10:53 -0500
X-MC-Unique: Y_HpQjyCOaq4zYyi0fk0-g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C9CD08010F5;
 Tue,  3 Mar 2020 10:10:51 +0000 (UTC)
Received: from jason-ThinkPad-T430s.redhat.com (ovpn-12-98.pek2.redhat.com
 [10.72.12.98])
 by smtp.corp.redhat.com (Postfix) with ESMTP id F2B1D8D55E;
 Tue,  3 Mar 2020 10:10:48 +0000 (UTC)
From: Jason Wang <jasowang@redhat.com>
To: peter.maydell@linaro.org
Subject: [PULL V2 02/23] dp8393x: Always use 32-bit accesses
Date: Tue,  3 Mar 2020 18:10:21 +0800
Message-Id: <1583230242-14597-3-git-send-email-jasowang@redhat.com>
In-Reply-To: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
References: <1583230242-14597-1-git-send-email-jasowang@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org,
 Finn Thain <fthain@telegraphics.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Finn Thain <fthain@telegraphics.com.au>

The DP83932 and DP83934 have 32 data lines. The datasheet says,

    Data Bus: These bidirectional lines are used to transfer data on the
    system bus. When the SONIC is a bus master, 16-bit data is transferred
    on D15-D0 and 32-bit data is transferred on D31-D0. When the SONIC is
    accessed as a slave, register data is driven onto lines D15-D0.
    D31-D16 are held TRI-STATE if SONIC is in 16-bit mode. If SONIC is in
    32-bit mode, they are driven, but invalid.

Always use 32-bit accesses both as bus master and bus slave.

Force the MSW to zero in bus master mode.

This gets the Linux 'jazzsonic' driver working, and avoids the need for
prior hacks to make the NetBSD 'sn' driver work.

Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 47 +++++++++++++++++++++++++++++------------------
 1 file changed, 29 insertions(+), 18 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 216d44b..51b71da 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -246,9 +246,19 @@ static void dp8393x_put(dp8393xState *s, int width, in=
t offset,
                         uint16_t val)
 {
     if (s->big_endian) {
-        s->data[offset * width + width - 1] =3D cpu_to_be16(val);
+        if (width =3D=3D 2) {
+            s->data[offset * 2] =3D 0;
+            s->data[offset * 2 + 1] =3D cpu_to_be16(val);
+        } else {
+            s->data[offset] =3D cpu_to_be16(val);
+        }
     } else {
-        s->data[offset * width] =3D cpu_to_le16(val);
+        if (width =3D=3D 2) {
+            s->data[offset * 2] =3D cpu_to_le16(val);
+            s->data[offset * 2 + 1] =3D 0;
+        } else {
+            s->data[offset] =3D cpu_to_le16(val);
+        }
     }
 }
=20
@@ -590,7 +600,7 @@ static uint64_t dp8393x_read(void *opaque, hwaddr addr,=
 unsigned int size)
=20
     DPRINTF("read 0x%04x from reg %s\n", val, reg_names[reg]);
=20
-    return val;
+    return s->big_endian ? val << 16 : val;
 }
=20
 static void dp8393x_write(void *opaque, hwaddr addr, uint64_t data,
@@ -598,13 +608,14 @@ static void dp8393x_write(void *opaque, hwaddr addr, =
uint64_t data,
 {
     dp8393xState *s =3D opaque;
     int reg =3D addr >> s->it_shift;
+    uint32_t val =3D s->big_endian ? data >> 16 : data;
=20
-    DPRINTF("write 0x%04x to reg %s\n", (uint16_t)data, reg_names[reg]);
+    DPRINTF("write 0x%04x to reg %s\n", (uint16_t)val, reg_names[reg]);
=20
     switch (reg) {
         /* Command register */
         case SONIC_CR:
-            dp8393x_do_command(s, data);
+            dp8393x_do_command(s, val);
             break;
         /* Prevent write to read-only registers */
         case SONIC_CAP2:
@@ -617,36 +628,36 @@ static void dp8393x_write(void *opaque, hwaddr addr, =
uint64_t data,
         /* Accept write to some registers only when in reset mode */
         case SONIC_DCR:
             if (s->regs[SONIC_CR] & SONIC_CR_RST) {
-                s->regs[reg] =3D data & 0xbfff;
+                s->regs[reg] =3D val & 0xbfff;
             } else {
                 DPRINTF("writing to DCR invalid\n");
             }
             break;
         case SONIC_DCR2:
             if (s->regs[SONIC_CR] & SONIC_CR_RST) {
-                s->regs[reg] =3D data & 0xf017;
+                s->regs[reg] =3D val & 0xf017;
             } else {
                 DPRINTF("writing to DCR2 invalid\n");
             }
             break;
         /* 12 lower bytes are Read Only */
         case SONIC_TCR:
-            s->regs[reg] =3D data & 0xf000;
+            s->regs[reg] =3D val & 0xf000;
             break;
         /* 9 lower bytes are Read Only */
         case SONIC_RCR:
-            s->regs[reg] =3D data & 0xffe0;
+            s->regs[reg] =3D val & 0xffe0;
             break;
         /* Ignore most significant bit */
         case SONIC_IMR:
-            s->regs[reg] =3D data & 0x7fff;
+            s->regs[reg] =3D val & 0x7fff;
             dp8393x_update_irq(s);
             break;
         /* Clear bits by writing 1 to them */
         case SONIC_ISR:
-            data &=3D s->regs[reg];
-            s->regs[reg] &=3D ~data;
-            if (data & SONIC_ISR_RBE) {
+            val &=3D s->regs[reg];
+            s->regs[reg] &=3D ~val;
+            if (val & SONIC_ISR_RBE) {
                 dp8393x_do_read_rra(s);
             }
             dp8393x_update_irq(s);
@@ -659,17 +670,17 @@ static void dp8393x_write(void *opaque, hwaddr addr, =
uint64_t data,
         case SONIC_REA:
         case SONIC_RRP:
         case SONIC_RWP:
-            s->regs[reg] =3D data & 0xfffe;
+            s->regs[reg] =3D val & 0xfffe;
             break;
         /* Invert written value for some registers */
         case SONIC_CRCT:
         case SONIC_FAET:
         case SONIC_MPT:
-            s->regs[reg] =3D data ^ 0xffff;
+            s->regs[reg] =3D val ^ 0xffff;
             break;
         /* All other registers have no special contrainst */
         default:
-            s->regs[reg] =3D data;
+            s->regs[reg] =3D val;
     }
=20
     if (reg =3D=3D SONIC_WT0 || reg =3D=3D SONIC_WT1) {
@@ -680,8 +691,8 @@ static void dp8393x_write(void *opaque, hwaddr addr, ui=
nt64_t data,
 static const MemoryRegionOps dp8393x_ops =3D {
     .read =3D dp8393x_read,
     .write =3D dp8393x_write,
-    .impl.min_access_size =3D 2,
-    .impl.max_access_size =3D 2,
+    .impl.min_access_size =3D 4,
+    .impl.max_access_size =3D 4,
     .endianness =3D DEVICE_NATIVE_ENDIAN,
 };
=20
--=20
2.5.0


