Return-Path: <SRS0=U3m5=5X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63054C2BABC
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:24:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D456206C0
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2020 09:24:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Z6+gb5uk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D456206C0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43852 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLkTN-0006lj-Bv
	for qemu-devel@archiver.kernel.org; Tue, 07 Apr 2020 05:24:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1jLkR9-0002Pt-1l
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1jLkR7-0000jU-Bu
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:26 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:53379
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1jLkR5-0000gu-In
 for qemu-devel@nongnu.org; Tue, 07 Apr 2020 05:22:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1586251342;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k6/5yvLUT9256EPgfuT9fAsQePBTrk+RlVT/7aiGcUA=;
 b=Z6+gb5ukhGg8XRz+VTfGQaYwfNVWFI1f+5B8yT3kRF6AGiuESE1uzG+DRfAquFTtO7+ajq
 syOLE0rbb/zJvjyq3rvbEAlK/Ek856s7gTdLmLlH8Oyx4vNlPYelKfBV8bcs7VD4xGZ8an
 mxORPNk6DgQzf9/8BXxNB3exoy6rwG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-507-_98NHsfoMW2Eizg5VhY2_A-1; Tue, 07 Apr 2020 05:22:15 -0400
X-MC-Unique: _98NHsfoMW2Eizg5VhY2_A-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1E99A1005509;
 Tue,  7 Apr 2020 09:22:14 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-60.ams2.redhat.com
 [10.36.113.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id BF4E260BE1;
 Tue,  7 Apr 2020 09:22:09 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 285F517517; Tue,  7 Apr 2020 11:22:07 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/4] ati-vga: Fix checks in ati_2d_blt() to avoid crash
Date: Tue,  7 Apr 2020 11:22:06 +0200
Message-Id: <20200407092207.6079-5-kraxel@redhat.com>
In-Reply-To: <20200407092207.6079-1-kraxel@redhat.com>
References: <20200407092207.6079-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

In some corner cases (that never happen during normal operation but a
malicious guest could program wrong values) pixman functions were
called with parameters that result in a crash. Fix this and add more
checks to disallow such cases.

Reported-by: Ziming Zhang <ezrakiez@gmail.com>
Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: 20200406204029.19559747D5D@zero.eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_2d.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/hw/display/ati_2d.c b/hw/display/ati_2d.c
index 42e82311eb44..23a8ae0cd8ce 100644
--- a/hw/display/ati_2d.c
+++ b/hw/display/ati_2d.c
@@ -53,12 +53,20 @@ void ati_2d_blt(ATIVGAState *s)
             s->vga.vbe_start_addr, surface_data(ds), surface_stride(ds),
             surface_bits_per_pixel(ds),
             (s->regs.dp_mix & GMC_ROP3_MASK) >> 16);
-    int dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                 s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_width);
-    int dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                 s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_height);
+    unsigned dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                      s->regs.dst_x : s->regs.dst_x + 1 - s->regs.dst_widt=
h);
+    unsigned dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                      s->regs.dst_y : s->regs.dst_y + 1 - s->regs.dst_heig=
ht);
     int bpp =3D ati_bpp_from_datatype(s);
+    if (!bpp) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Invalid bpp\n");
+        return;
+    }
     int dst_stride =3D DEFAULT_CNTL ? s->regs.dst_pitch : s->regs.default_=
pitch;
+    if (!dst_stride) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Zero dest pitch\n");
+        return;
+    }
     uint8_t *dst_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
                         s->regs.dst_offset : s->regs.default_offset);
=20
@@ -82,12 +90,16 @@ void ati_2d_blt(ATIVGAState *s)
     switch (s->regs.dp_mix & GMC_ROP3_MASK) {
     case ROP3_SRCCOPY:
     {
-        int src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
-                     s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_width=
);
-        int src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
-                     s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_heigh=
t);
+        unsigned src_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                       s->regs.src_x : s->regs.src_x + 1 - s->regs.dst_wid=
th);
+        unsigned src_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                       s->regs.src_y : s->regs.src_y + 1 - s->regs.dst_hei=
ght);
         int src_stride =3D DEFAULT_CNTL ?
                          s->regs.src_pitch : s->regs.default_pitch;
+        if (!src_stride) {
+            qemu_log_mask(LOG_GUEST_ERROR, "Zero source pitch\n");
+            return;
+        }
         uint8_t *src_bits =3D s->vga.vram_ptr + (DEFAULT_CNTL ?
                             s->regs.src_offset : s->regs.default_offset);
=20
@@ -137,8 +149,10 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds=
));
         }
-        s->regs.dst_x +=3D s->regs.dst_width;
-        s->regs.dst_y +=3D s->regs.dst_height;
+        s->regs.dst_x =3D (s->regs.dp_cntl & DST_X_LEFT_TO_RIGHT ?
+                         dst_x + s->regs.dst_width : dst_x);
+        s->regs.dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     case ROP3_PATCOPY:
@@ -179,7 +193,8 @@ void ati_2d_blt(ATIVGAState *s)
                                     dst_y * surface_stride(ds),
                                     s->regs.dst_height * surface_stride(ds=
));
         }
-        s->regs.dst_y +=3D s->regs.dst_height;
+        s->regs.dst_y =3D (s->regs.dp_cntl & DST_Y_TOP_TO_BOTTOM ?
+                         dst_y + s->regs.dst_height : dst_y);
         break;
     }
     default:
--=20
2.18.2


