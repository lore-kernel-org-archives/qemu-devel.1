Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2424C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:32:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BDDCF206C3
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:32:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="eVxhDhIk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BDDCF206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55324 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4dwu-0003BT-RI
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:32:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37846)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dot-0006FW-Rh
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:31 -0400
Received: from mout.gmx.net ([212.227.17.21]:40491)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dor-0002pE-Ng
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950646;
 bh=I/Sx/HdpIxh4i9UsobCMs9UPgI56qxrzVMpyXIjjkEc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=eVxhDhIknvGiPoRm5KPsYrNUo+0Q5NOiNs+j5v35zi/vSfuaeC/eQFGniICKXRJMY
 dsdwJ2FkiNojFbSAbBnkTW12OV0YowyGioxfrkwmkQUMJK/9W/T/cjuMhj6SNOt+o4
 OCB0w0afDJz3jze7nZhmz2CQG6t9J/nOYbazR8qk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MVeI8-1kCRog1tZM-00RXHM; Sun, 09
 Aug 2020 07:24:06 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 07/12] hw/display/artist: Refactor artist_rop8() to avoid
 buffer over-run
Date: Sun,  9 Aug 2020 07:23:57 +0200
Message-Id: <20200809052402.31641-8-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YScZlOdwWjgJVQBCzdbVu/jdcqJkPBsH/htSL4p8dvRElpKbTVQ
 ntEDDW3wEE4Mqj9nR0g2A+CB7liUpcNQToaB3S6SVCSJvRUMX+QyIRM4L7C1ZLS9I+cem4o
 5jc+L98xset1ECH1c3RYW1ygTSNffueBLVRJpJQvzlc30dl9VroIPsLoiJlnNGWBarWaWBY
 Gl+OT3riWfDYT2NvvULmA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ghkL0hrxbN0=:UM69nDC/awEOhKIykyPRXu
 AEiaZewAuN7FHRmzjn76XHjwWhXpiJOmDeVVj217gDdDRap895zBsP3vGqDbCVKS1vsc1XDMu
 zwEPz4Gyk4ZEeWRTVUDe8SR8RASCqC6nfKEP4FZprb4HLR3eV6fn51TO+0e9GNNO/xVBOkb1M
 lQUBJQCcvxVAqHF2xZ5Z/4oj08N4J6jdMOd3Ldp4dVImDLzKvTl6JwlxgbU8AY39P6P+Juz5/
 F9w4eifNlLimrVkZk5d62o17p3Tl4gKRjI2+YO1AZl3KcXRgnY4jhOk8DKYytPYKzJSct4gBS
 xJj33DrHzUb0tj0Kau/Km+NPKK+h71cH/oBlNm7ejETiTZTpxH9y+HD/hQ7KGJ9H1dOKu2Dt6
 G7PRcMzMARPuM+0L0cXzKzvz9kt8JKWRC5RIfRnUxLKNAmWY5l3P431a6ap5R/IDcZwHTnVO2
 Pa77W57D9+EVTt/D5xDLs68exVQtKsc/C+SNAthMLFsXEyhL8MUjp8u0jlYVn5JxedqvLnp0g
 oyMInNHAVlE4ok6yQVhtr06DaLWGlDT+FuvslzEUz1dx4SUyCfQrVTD7K6hVEV+q2vG+DDNsI
 +K1PmsjJaDzBJV/BiOb89DBoa4kRgJ4oJuArGyeMul31jwIKb7H3IkLH02YMbe/wKt1wHLWOZ
 wtmU9I0bFpeZ3IuDa6E5iUdu+hyY0K2uqXi5Pp6JCyTBDa4iPTGW+fGz3BLiAX2cXLpfQQI5h
 jttuduu98NxxnFHr9NCoITpLtzPR+ujZLrKOtldo83QlI6RirtX2pIr4wLWxUOhxpr+Ko2fff
 LE7zbDR4wG6X5HaHyfCkvB+LG/TtBXk3La2rqYsY2J/H2GYOqJsi7ZWO341DDCSnXLTTF4/JC
 LoSvxz0+WQeJbl2IlJQuQX81dpJmIsJE6xn7ekj1BE58H+eobT1htgbHTHHqBOtYiBTwuMFsn
 Pr05TKknA+EiWqY/rJ49uJQFl+cZvIRHeeBvVdXn87JHQykeOFulpmxOUpiMl1gPXXZU1/rdB
 Op4zyfqyFpSMCU85z+2T5KfTCNrMniTkwZXSCEOPE6o7JUpl+y8cqryAX+g3U9nMQC9CmB0+k
 knE1ov2e/+fFaBpJvFa/Xt2yiB6p4464urYluRheYcK5MQZu1RL+yhLxFfCGG8Frrk0G7bnMg
 NkA9HlyDPvV066xBdVWTh6R39hmecPYpThjN3e7xs3/FCHKGwjr1bsmAs+ZXXpixNyVZDeYzk
 a+xISCCjuh0AmetNe
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:24:27
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Invalid I/O writes can craft an offset out of the vram_buffer range.
Instead of passing an unsafe pointer to artist_rop8(), pass the vram_buffe=
r and
the offset. We can now check if the offset is in range before accessing it=
.

We avoid:

  Program terminated with signal SIGSEGV, Segmentation fault.
  284             *dst &=3D ~plane_mask;
  (gdb) bt
  #0  0x000056367b2085c0 in artist_rop8 (s=3D0x56367d38b510, dst=3D0x7f9f9=
72fffff <error: Cannot access memory at address 0x7f9f972fffff>, val=3D0 '=
\000') at hw/display/artist.c:284
  #1  0x000056367b209325 in draw_line (s=3D0x56367d38b510, x1=3D-20480, y1=
=3D-1, x2=3D0, y2=3D17920, update_start=3Dtrue, skip_pix=3D-1, max_pix=3D-=
1) at hw/display/artist.c:646

Reported-by: LLVM libFuzzer
Buglink: https://bugs.launchpad.net/qemu/+bug/1880326
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index a206afe641..47de17b9e9 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -273,11 +273,20 @@ static artist_rop_t artist_get_op(ARTISTState *s)
     return (s->image_bitmap_op >> 8) & 0xf;
 }

-static void artist_rop8(ARTISTState *s, uint8_t *dst, uint8_t val)
+static void artist_rop8(ARTISTState *s, struct vram_buffer *buf,
+                        int offset, uint8_t val)
 {
-
     const artist_rop_t op =3D artist_get_op(s);
-    uint8_t plane_mask =3D s->plane_mask & 0xff;
+    uint8_t plane_mask;
+    uint8_t *dst;
+
+    if (offset < 0 || offset >=3D buf->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "rop8 offset:%d bufsize:%u\n", offset, buf->size);
+        return;
+    }
+    dst =3D buf->data + offset;
+    plane_mask =3D s->plane_mask & 0xff;

     switch (op) {
     case ARTIST_ROP_CLEAR:
@@ -375,7 +384,7 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
         for (i =3D 0; i < pix_count; i++) {
             uint32_t off =3D offset + pix_count - 1 - i;
             if (off < buf->size) {
-                artist_rop8(s, p + off,
+                artist_rop8(s, buf, off,
                             (data & 1) ? (s->plane_mask >> 24) : 0);
             }
             data >>=3D 1;
@@ -395,7 +404,7 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
                 s->vram_bitmask & (1 << (28 + i))) {
                 uint32_t off =3D offset + 3 - i;
                 if (off < buf->size) {
-                    artist_rop8(s, p + off, data8[ROP8OFF(i)]);
+                    artist_rop8(s, buf, off, data8[ROP8OFF(i)]);
                 }
             }
         }
@@ -424,10 +433,10 @@ static void vram_bit_write(ARTISTState *s, int posx,=
 int posy, bool incr_x,
             if (!(s->image_bitmap_op & 0x20000000) ||
                 (vram_bitmask & mask)) {
                 if (data & mask) {
-                    artist_rop8(s, p + offset + i, s->fg_color);
+                    artist_rop8(s, buf, offset + i, s->fg_color);
                 } else {
                     if (!(s->image_bitmap_op & 0x10000002)) {
-                        artist_rop8(s, p + offset + i, s->bg_color);
+                        artist_rop8(s, buf, offset + i, s->bg_color);
                     }
                 }
             }
@@ -505,7 +514,7 @@ static void block_move(ARTISTState *s, int source_x, i=
nt source_y, int dest_x,
             if (dst + column > buf->size || src + column > buf->size) {
                 continue;
             }
-            artist_rop8(s, buf->data + dst + column, buf->data[src + colu=
mn]);
+            artist_rop8(s, buf, dst + column, buf->data[src + column]);
         }
     }

@@ -546,7 +555,7 @@ static void fill_window(ARTISTState *s, int startx, in=
t starty,
         offset =3D y * s->width;

         for (x =3D startx; x < startx + width; x++) {
-            artist_rop8(s, buf->data + offset + x, color);
+            artist_rop8(s, buf, offset + x, color);
         }
     }
     artist_invalidate_lines(buf, starty, height);
@@ -559,7 +568,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, =
int x2, int y2,
     uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
-    uint8_t *p;

     trace_artist_draw_line(x1, y1, x2, y2);

@@ -628,16 +636,18 @@ static void draw_line(ARTISTState *s, int x1, int y1=
, int x2, int y2,
     color =3D artist_get_color(s);

     do {
+        int ofs;
+
         if (c1) {
-            p =3D buf->data + x * s->width + y;
+            ofs =3D x * s->width + y;
         } else {
-            p =3D buf->data + y * s->width + x;
+            ofs =3D y * s->width + x;
         }

         if (skip_pix > 0) {
             skip_pix--;
         } else {
-            artist_rop8(s, p, color);
+            artist_rop8(s, buf, ofs, color);
         }

         if (e > 0) {
@@ -771,10 +781,10 @@ static void font_write16(ARTISTState *s, uint16_t va=
l)
     for (i =3D 0; i < 16; i++) {
         mask =3D 1 << (15 - i);
         if (val & mask) {
-            artist_rop8(s, buf->data + offset + i, color);
+            artist_rop8(s, buf, offset + i, color);
         } else {
             if (!(s->image_bitmap_op & 0x20000000)) {
-                artist_rop8(s, buf->data + offset + i, s->bg_color);
+                artist_rop8(s, buf, offset + i, s->bg_color);
             }
         }
     }
=2D-
2.21.3


