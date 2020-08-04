Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D902FC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:12:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AACFD21744
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="GsuY0oBc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AACFD21744
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33400 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xfy-0007TQ-M4
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:12:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40516)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVP-0000pB-1N
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:27 -0400
Received: from mout.gmx.net ([212.227.15.18]:38249)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVM-000399-PW
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596549660;
 bh=I/Sx/HdpIxh4i9UsobCMs9UPgI56qxrzVMpyXIjjkEc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=GsuY0oBcmKBWs5mT80+7yrgWGDEPxRtYnx0bGq+2XaZRHJVb5qshhtGk7JFL0WWpn
 1WPgvmOEfT5kD1PjVHUh7I7gLOhdFm+QB0Z+eTwbpu80f1ba8c1ZFH0dRXP6mJjHzn
 t1JLnlWHlRpJ3IUnq0ykk2ZDLRV2rvnCKVdjAamY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mqb1W-1kXsTL48mG-00maPV; Tue, 04
 Aug 2020 16:01:00 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to avoid
 buffer over-run
Date: Tue,  4 Aug 2020 16:00:55 +0200
Message-Id: <20200804140056.7690-8-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804140056.7690-1-deller@gmx.de>
References: <20200804140056.7690-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yxMdJuG8/FfppgKDF8Hy9ctFW09MWRERHbwz3/K646kKa4vJdBa
 dVSGG0Wjp0KzOBzNx9UnXzms7e+OIfsHUQtlT4nZvO2RO56aWKTMmyNxZBL62vvEi7cSW9G
 zmAuccqEk1TcsMLgODS6ffQzWTG31aQbATSr09Tiq1jyqWlCiYaYZoiFH/+AxEPoE5XIS4k
 ym9RaaScbtobxqdoHbXvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mBOMpodSzkc=:1/D9+IgkGlc3KdhncNXAAB
 +gZp7Z7MbNjG0CKcHzlS9y8c3l1R4OVvHGUdEYtG7FTMMFPFMdlKIJzVN/oHf5NUu7ZGpUux6
 PxoBGmSQ8STs7SJ9bw3ZRW6MeiMZ7WJ0gDY4wvau7c1cmvHX2ofKxW130DzLK/6IHOkIDKBP/
 Bztxj01PGTsNl4eGTZAB6xy+AQZvmxtaGBMBzOEyFYY2M4M3uxXa+j3/FQ7zB9nWEcrCzKyA0
 oJC2hTYtN3Vj/ST+l0QqNFQJL8+HaqcoKm3g6X7dkaf75cxfEl1RGLJlloSqB8f8NrtZoI6SD
 nPZqp00MWDB3k8uQmfaGmL1LpuC7+hEGilNPnEcdiM2V4PJdvOMpPS4iSIFnGv96Z+C6Lc+tK
 QWcB7fE6cRxfJmm6SKH6Q2j7UhQAjYTf9KUFQcK6+aeP4GkvoE3BlMJM2MXdpr4aIqyVBKstC
 sFQgOpQEwONU4xHdKEMrSGUpBnq2kJy8eyRnaRnSIQZBqHxH4kbDBd3JHVbU1J3Y4lTq4HCC7
 ofHyHl/6gfxL7vU7UM4g4245cHwc85WoZF+zRoCnDNRTj4y9ddzXCNErWD1Cig7qCJT5CWLxj
 vyGpAikkSv+JdWcg9aN6z8S8Om7beZIhmlphd23u1+qfPc4E2c1QTfGfs+CXhaScZ95wDlAnf
 V8yOnTAaaIrzVfHTNzaEU+h1pRQf9FPhFOfSVcx+SA0fJNcfsnZ0warDbclFzba4qFNTZmH/8
 gh582q1mqtGHJR9CqdK43fAOUalytWRJJJtTNsOi5G5M0yw5V5VwEm/IoPb3WRVXqHYPX6rwI
 g4S7CsF7pDSGMrdXqd4bvoaAKyBw2NHckIMRyX8kig9uk9bYjiDyn1LzDgL5YqeuZ782sE2uu
 rdj6oX7nANu0hoQ+IdTkS3pEBv8hc3qOgnPk4vz1OBMwhS2lqQMWbLPNeRcBnhGaXwbItm9az
 lZ3od/TISJz0BYWNT4jyBykUodrY8TmhGM8ol9/l4enbhRvAwZ3z1fPkxWbqtJSayOgyKrb9F
 PkxBdVWZd4drg2ZDv7oKf70dWxE6reCO0dvFVyz+sLQ9ew4kJJHco3m2j8rnSI+QUdVcHeDfj
 mHtJmaDlIytpyoOFfHyJOHX0lodzcmN8pxozzS3Mo1sRZZWfMxVh9qpbUJpmoKFwCfXKoGmSB
 HcVKI0mCuyq8BliCXfLtLLCe6tVloGvXb61zOMQHqm5VDacnE5xo3Zz4smjQJDlKqeSTHc/AK
 i2wbINVYkoBNimKf1
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 09:08:36
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


