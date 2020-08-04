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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE579C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:04:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D052086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="g7MMXjMv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D052086A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50464 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xYj-0002Wg-OI
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:04:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40538)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVS-0000r7-5T
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:30 -0400
Received: from mout.gmx.net ([212.227.15.18]:54969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVP-00039S-SJ
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596549660;
 bh=fd53MIvF+mI/863INqxQ4nfU2W+adUWDkO8VnWiY+Kk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=g7MMXjMvEDbguZfA/glP49DAPweyB+bukS71vXxYzNJrPXszM3z/uVnnQpHxgdwzz
 +npyEpmv6ECltKYCXVaSa8ykITOXrWa/TF596V8VhL+RQuYev+I0XdVkNb5Gdt2Yiq
 Rln6veA/VgK479M0otRDDO/SKrptuLObxtG8dvd0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJVHe-1kIHSO0mV6-00JsQv; Tue, 04
 Aug 2020 16:01:00 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 8/8] hw/display/artist: Prevent out of VRAM buffer accesses
Date: Tue,  4 Aug 2020 16:00:56 +0200
Message-Id: <20200804140056.7690-9-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804140056.7690-1-deller@gmx.de>
References: <20200804140056.7690-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5dpQW0TdgCJ1RbRHLwuxpRBvMklZq+kB4FJLMznKdzp99tAejdT
 S9Krfkxo46p2IOEeqBCFqbdBd5m5FL7/WCJFbbY2ShrS2mXc6tCImH3iJ7eN9ZZ0EXRO14B
 GCk5oi4z7Bq7lPgKesrgeTgHOpFq8ucWu3wsmf3SNQmAytuJmIFuU7u0OVDDDMzLLBX3Vo8
 RPTFUG3igIZhQ3g7x0/9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:63HyxUxLTlQ=:xupcuFGHwi+Otc8TTBYbbo
 sv6kHf7pHHtyaN1RuqeDzJG3eovy7Jg6xijTTC6x314bfHGlYOU3r/VZZgeDzCBX7pDxjw1Dp
 JGk6mjMunSkYDtGIrH4FnK1qrszvGoZX05jV5CjPDemZF8IKmJ4Opgn9noT6EfjyH6Bje2SL6
 Udvy87BwPXZNf9Nt2WjcssJ2Yzbf5gI6uUpxAf28WhRprOgIuRE0j5KThKTyKs/1a8tX3tF+C
 8mBMUHgFvE3pIVcy7Ao7+YfWJcgVysSbsjuOHP31DgmlBI2eeAH7iVd+Mo7u63d5OEKCGNdu8
 Gas7R6sc3gZnUESXD3fxnWH55cOD8SipAJYiMcB7YCEJ/tlU6ghjv7PN+RgffZbz4x4vGHLN+
 c2jTd+NK5kqlmGF/mjVl9AosS3rQspyiQz3IDOxHc0Up3kq3GkwWJGBm+fP5sft9PtlVm0GrI
 OXSNbCqICWH7GAZ5rtZd8JBRdmX6gCnJd2+DXK9FsvxVu9tXXRhnMjqz2JIcG9sDlRM+iWXV+
 jhcmianVEZQlPkmvbVTccp0JVU66r4HkwVuu4VZZiALbcSQurjD9okIHtTF4blbWsGrejnoEn
 X3UT+YvJ9CoJ06xLlh8URV+fFUuZkTr1BDX9xg1B1WJHPGSgrYBtmYz6WRSpgOzOJaR+O1cSV
 y6BCR8gqBUwGRxLtiCUQrr2NyqCAkiNNHolSsPpfUd67ZctzDX+lIX25nARsPkp/YDpanbwwr
 vThGkSuwWmmUz3NrKrlJk9iXGbJOkUHdxdCi+CCEwAzVRPvj4wzJC5oOKio/+ZzOT1zJC8+kt
 UsKGWR6oWqCiEYYrXL7NyXCzLeXNbcBs1J4n6UtwXnp3pvHytwsIeKKYVZ/qAE+Q7fRxY8zlQ
 1ihgLiPQm6oOthQURt8Jj6VHww3fGLc0K3Hg0atFhANONDvhYsh8hc9OYaiVAzsas+KVdZESN
 Ej22bpL1EGi0oGO7g+TTlGQsZQU0V4A3JWahbngCgKqanv/vQMMvYpHIBWOSW73yPD8c1kjhP
 R5e+Fe5KbnL2kvCaLFgmmCMiUFI17nXkrGduSllY2SLu/XyzIIM7R3bec9xxNgOCtYf+gnA5u
 uR3MQ6DEWAA3HXPmdi7ewBzhhu4Bx0zV5/yb08jNlpEpKBll0VSZ7wGx50+hXeb/QAgZrbF+u
 aFHxprWKoIk7URkupdN17QWSQkqMEoGOcPCLT7jka2AaIjMrT28jY+ZqyOpFA//Kz9/TTAe3F
 mwNyrQNtAeGoCxQ2y
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
Cc: Helge Deller <deller@gmx.de>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify bounds checks by changing some parameters like row or column
numbers to become unsigned instead of signed.
With that we can check if the calculated offset is bigger than the size
of the VRAM region and bail out if not.

Reported-by: LLVM libFuzzer
Buglink: https://bugs.launchpad.net/qemu/+bug/1880326
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 59 +++++++++++++++++++++++++++------------------
 1 file changed, 36 insertions(+), 23 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 47de17b9e9..c2fa097020 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -203,12 +203,12 @@ static int16_t artist_get_y(uint32_t reg)
 }

 static void artist_invalidate_lines(struct vram_buffer *buf,
-                                    int starty, int height)
+                                    unsigned int starty, unsigned int hei=
ght)
 {
-    int start =3D starty * buf->width;
-    int size =3D height * buf->width;
+    unsigned int start =3D starty * buf->width;
+    unsigned int size =3D height * buf->width;

-    if (start + size <=3D buf->size) {
+    if (start + size < buf->size) {
         memory_region_set_dirty(&buf->mr, start, size);
     }
 }
@@ -274,15 +274,15 @@ static artist_rop_t artist_get_op(ARTISTState *s)
 }

 static void artist_rop8(ARTISTState *s, struct vram_buffer *buf,
-                        int offset, uint8_t val)
+                        unsigned int offset, uint8_t val)
 {
     const artist_rop_t op =3D artist_get_op(s);
     uint8_t plane_mask;
     uint8_t *dst;

-    if (offset < 0 || offset >=3D buf->size) {
+    if (offset >=3D buf->size) {
         qemu_log_mask(LOG_GUEST_ERROR,
-                      "rop8 offset:%d bufsize:%u\n", offset, buf->size);
+                      "rop8 offset:%u bufsize:%u\n", offset, buf->size);
         return;
     }
     dst =3D buf->data + offset;
@@ -464,12 +464,14 @@ static void vram_bit_write(ARTISTState *s, int posx,=
 int posy, bool incr_x,
     }
 }

-static void block_move(ARTISTState *s, int source_x, int source_y, int de=
st_x,
-                       int dest_y, int width, int height)
+static void block_move(ARTISTState *s,
+                       unsigned int source_x, unsigned int source_y,
+                       unsigned int dest_x,   unsigned int dest_y,
+                       unsigned int width,    unsigned int height)
 {
     struct vram_buffer *buf;
     int line, endline, lineincr, startcolumn, endcolumn, columnincr, colu=
mn;
-    uint32_t dst, src;
+    unsigned int dst, src;

     trace_artist_block_move(source_x, source_y, dest_x, dest_y, width, he=
ight);

@@ -481,6 +483,12 @@ static void block_move(ARTISTState *s, int source_x, =
int source_y, int dest_x,
     }

     buf =3D &s->vram_buffer[ARTIST_BUFFER_AP];
+    if (height > buf->height) {
+        height =3D buf->height;
+    }
+    if (width > buf->width) {
+        width =3D buf->width;
+    }

     if (dest_y > source_y) {
         /* move down */
@@ -507,24 +515,27 @@ static void block_move(ARTISTState *s, int source_x,=
 int source_y, int dest_x,
     }

     for ( ; line !=3D endline; line +=3D lineincr) {
-        src =3D source_x + ((line + source_y) * buf->width);
-        dst =3D dest_x + ((line + dest_y) * buf->width);
+        src =3D source_x + ((line + source_y) * buf->width) + startcolumn=
;
+        dst =3D dest_x + ((line + dest_y) * buf->width) + startcolumn;

         for (column =3D startcolumn; column !=3D endcolumn; column +=3D c=
olumnincr) {
-            if (dst + column > buf->size || src + column > buf->size) {
+            if (dst > buf->size || src > buf->size) {
                 continue;
             }
-            artist_rop8(s, buf, dst + column, buf->data[src + column]);
+            artist_rop8(s, buf, dst, buf->data[src]);
+            src +=3D columnincr;
+            dst +=3D columnincr;
         }
     }

     artist_invalidate_lines(buf, dest_y, height);
 }

-static void fill_window(ARTISTState *s, int startx, int starty,
-                        int width, int height)
+static void fill_window(ARTISTState *s,
+                        unsigned int startx, unsigned int starty,
+                        unsigned int width,  unsigned int height)
 {
-    uint32_t offset;
+    unsigned int offset;
     uint8_t color =3D artist_get_color(s);
     struct vram_buffer *buf;
     int x, y;
@@ -561,7 +572,9 @@ static void fill_window(ARTISTState *s, int startx, in=
t starty,
     artist_invalidate_lines(buf, starty, height);
 }

-static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
+static void draw_line(ARTISTState *s,
+                      unsigned int x1, unsigned int y1,
+                      unsigned int x2, unsigned int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
     struct vram_buffer *buf =3D &s->vram_buffer[ARTIST_BUFFER_AP];
@@ -636,7 +649,7 @@ static void draw_line(ARTISTState *s, int x1, int y1, =
int x2, int y2,
     color =3D artist_get_color(s);

     do {
-        int ofs;
+        unsigned int ofs;

         if (c1) {
             ofs =3D x * s->width + y;
@@ -768,9 +781,9 @@ static void font_write16(ARTISTState *s, uint16_t val)
     uint16_t mask;
     int i;

-    int startx =3D artist_get_x(s->vram_start);
-    int starty =3D artist_get_y(s->vram_start) + s->font_write_pos_y;
-    int offset =3D starty * s->width + startx;
+    unsigned int startx =3D artist_get_x(s->vram_start);
+    unsigned int starty =3D artist_get_y(s->vram_start) + s->font_write_p=
os_y;
+    unsigned int offset =3D starty * s->width + startx;

     buf =3D &s->vram_buffer[ARTIST_BUFFER_AP];

@@ -1138,7 +1151,7 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
     struct vram_buffer *buf;
     int posy =3D (addr >> 11) & 0x3ff;
     int posx =3D addr & 0x7ff;
-    uint32_t offset;
+    unsigned int offset;
     trace_artist_vram_write(size, addr, val);

     if (s->cmap_bm_access) {
=2D-
2.21.3


