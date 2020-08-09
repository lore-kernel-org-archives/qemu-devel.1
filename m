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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD78C433DF
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:38:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E854020768
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:38:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="evWdac4r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E854020768
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4e2K-0007an-1T
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37918)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp5-0006Mc-FN
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:43 -0400
Received: from mout.gmx.net ([212.227.17.20]:35139)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp0-0002qz-92
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950647;
 bh=cbiLnhkb9NPE7dlaOjXJVH749JoMVI1ICQAu8ZMsEhQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=evWdac4r3tJr54p1DVhogiL1vP+WxkxsBeTgGmzC/2PBiC2islW4JmpPAAo+8mX72
 XgJULC2LK9qYUDjC5cNJrf8XhOSZWuO6CB/b8xNh8PuprsD7btFgfBPzvBlWk/qOPp
 qHLuxEKDEb/yMvpcCx8T1JHJlO+O/Fl5C5ErEleQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXUN-1kKOJM0Jvj-00JWWR; Sun, 09
 Aug 2020 07:24:07 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 09/12] hw/display/artist: Prevent out of VRAM buffer
 accesses
Date: Sun,  9 Aug 2020 07:23:59 +0200
Message-Id: <20200809052402.31641-10-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YowXxE0dJlpHex+8Hm5W/S+lLb1zYPn1yVoMUstCKUHVCcw+F0I
 dhTY9iFArE/Ve6Vyiyc/ZMwCQo12bC5Q7LAW/nPZwIRLWG5gCqnLw54+m2jBxA0htnJDC7p
 sAHBtmW8Wj+bJLLsZq5gYLjIYjYoKNRdqJJpfQM2dNk22cOKLp0KU9fP7t53JN1ntVv+uhf
 PW3t5jgVJRuGEHQ18sYiw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:guo3vyP+ufo=:riLI5PCTcAFO1niskVhxlt
 QWa3sktKZkj0lsVogRw2vjwrMU2LkQ9/bW3rdCz/7oicECqK/fA6Rc5Q69HeJTSsV95K2Etox
 j6HcNr3F9eJ+d8aUmfxOqdMJGv1F9qEZ5+XOct+jGZ+wpLyVAH5DXKtJ3uG2LBsv28YNthfuc
 Bryk0Aafe382OnHjiTxv3zOk13xH1LlxhxGLOV5Y3ssY59OVEKGlIxb1MHoirqVSc16ruYbaV
 o/WztHPqUcs+vMItZjnpXBowTLLaD9WhTFyrm2O5DrAO8ZDB9fV328I8WY7+uKoZzCdTftb+A
 86JdHvPs4uvCUFRRyXwyZdxLYKrTZevU5G02OmelE4Jb14WKCwWLAJutYhHu1VNMX76mzrhjF
 BJt9iMBIEPzlhQDTXowHEJrsXTmTGfO25jFqHD/ufbwlZnBjvb8r8k8Vto8ZrUkV+KcZAC/U+
 k6ZNVAhF0wVofej55o1cWsGFBkc50e6Ec7mtd9gUVZ16XxkZJhogekw2s0yuRq2zeixPgyO04
 edUBS03Nb0CZXmzoiCk+d8QOCGkjwxL1yXJ8ePjhwSYjMnX5X6AN4XpW0imcGd0toWIrFixpM
 ZadOgBXCN0E5k3H5FcQ1MVsLk8zWqYG4p6cWhR3ftPRip3LXK60V1m+2yqkl6tpmhXs1eJ2Rl
 R6GGGLqWwd/bkbLYoV3Ca3VQf2iLJDtsoAe9KOstMcbMA/+YS4cQK4gbHMOfUXU/UoS5FiDGP
 OqQ85ll85r+6aSxr7DvARNsPqUk9fA4ZhXcPnMG/AWt0p6xyrH9xLL2mjVwMgNpZOM6M5KRFW
 9R9z4/DYjjyFu+sae40vPB20ldg9fFz6BzSUnQsG3/DhdCVFn+wlIDHj6ml/ue0AW7we2GsqH
 /9htmI3uYiceE0PpoQHX++kUfD1YLx36ebabAqlC8T61dhOxXvea2r9vJ6ek7oUwVwYCKGfJA
 LK7RFXfnoTD3lyQjKg3kHD+od8CwXGlZanf1zK+OL04PJfxgdoQb4AYysSe1yS8OKe3MCcDCr
 uKZgUz7NuM3OKKrLmJUy9hMWOXd8PrjZ+tnOIBzoMruKiOHvGjz75ahBhv0BoDlXXqKKM2eNt
 Gk7nyML/MPjF+gOoVCLa+tY9NDBl90/j9pYOlOqtEihdrrcmXcS2kSNFRmbPoNlBloKJMqCZs
 tO6AlQDmUotDSWc5nRoVakF+bRRKUqxhjMJxijZaYUGsLGPaKDIwhBYVuZ20BxI7H9hMt9gWg
 7CIigM82+pvPRkLg0
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:24:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
Cc: Alexander Bulekov <alxndr@bu.edu>, Helge Deller <deller@gmx.de>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify various bounds checks by changing parameters like row and column
numbers to become unsigned instead of signed.
With that we can check if the calculated offset is bigger than the size of=
 the
VRAM region and bail out if not.

Reported-by: LLVM libFuzzer
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1880326
Buglink: https://bugs.launchpad.net/qemu/+bug/1890310
Buglink: https://bugs.launchpad.net/qemu/+bug/1890311
Buglink: https://bugs.launchpad.net/qemu/+bug/1890312
Buglink: https://bugs.launchpad.net/qemu/+bug/1890370
Acked-by: Alexander Bulekov <alxndr@bu.edu>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 103 +++++++++++++++++++++++++++-----------------
 1 file changed, 64 insertions(+), 39 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index f37aa9eb49..904a955aff 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -35,9 +35,9 @@
 struct vram_buffer {
     MemoryRegion mr;
     uint8_t *data;
-    int size;
-    int width;
-    int height;
+    unsigned int size;
+    unsigned int width;
+    unsigned int height;
 };

 typedef struct ARTISTState {
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
@@ -294,8 +294,7 @@ static void artist_rop8(ARTISTState *s, struct vram_bu=
ffer *buf,
         break;

     case ARTIST_ROP_COPY:
-        *dst &=3D ~plane_mask;
-        *dst |=3D val & plane_mask;
+        *dst =3D (*dst & ~plane_mask) | (val & plane_mask);
         break;

     case ARTIST_ROP_XOR:
@@ -349,7 +348,8 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask =3D s->vram_bitmask;
-    int mask, i, pix_count, pix_length, offset, width;
+    int mask, i, pix_count, pix_length;
+    unsigned int offset, width;
     uint8_t *data8, *p;

     pix_count =3D vram_write_pix_per_transfer(s);
@@ -364,8 +364,7 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
         offset =3D posy * width + posx;
     }

-    if (!buf->size) {
-        qemu_log("write to non-existent buffer\n");
+    if (!buf->size || offset >=3D buf->size) {
         return;
     }

@@ -394,7 +393,9 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,

     case 3:
         if (s->cmap_bm_access) {
-            *(uint32_t *)(p + offset) =3D data;
+            if (offset + 3 < buf->size) {
+                *(uint32_t *)(p + offset) =3D data;
+            }
             break;
         }
         data8 =3D (uint8_t *)&data;
@@ -464,12 +465,14 @@ static void vram_bit_write(ARTISTState *s, int posx,=
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

@@ -481,6 +484,12 @@ static void block_move(ARTISTState *s, int source_x, =
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
@@ -507,24 +516,27 @@ static void block_move(ARTISTState *s, int source_x,=
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
+            if (dst >=3D buf->size || src >=3D buf->size) {
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
@@ -561,7 +573,9 @@ static void fill_window(ARTISTState *s, int startx, in=
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
@@ -571,12 +585,12 @@ static void draw_line(ARTISTState *s, int x1, int y1=
, int x2, int y2,

     trace_artist_draw_line(x1, y1, x2, y2);

-    if (x1 * y1 >=3D buf->size || x2 * y2 >=3D buf->size) {
-        qemu_log_mask(LOG_GUEST_ERROR,
-                      "draw_line (%d,%d) (%d,%d)\n", x1, y1, x2, y2);
-        return;
+    if ((x1 >=3D buf->width && x2 >=3D buf->width) ||
+        (y1 >=3D buf->height && y2 >=3D buf->height)) {
+	return;
     }

+
     if (update_start) {
         s->vram_start =3D (x2 << 16) | y2;
     }
@@ -633,7 +647,7 @@ static void draw_line(ARTISTState *s, int x1, int y1, =
int x2, int y2,
     color =3D artist_get_color(s);

     do {
-        int ofs;
+        unsigned int ofs;

         if (c1) {
             ofs =3D x * s->width + y;
@@ -765,13 +779,14 @@ static void font_write16(ARTISTState *s, uint16_t va=
l)
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

-    if (offset + 16 > buf->size) {
+    if (startx >=3D buf->width || starty >=3D buf->height ||
+        offset + 16 >=3D buf->size) {
         return;
     }

@@ -1135,7 +1150,7 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
     struct vram_buffer *buf;
     int posy =3D (addr >> 11) & 0x3ff;
     int posx =3D addr & 0x7ff;
-    uint32_t offset;
+    unsigned int offset;
     trace_artist_vram_write(size, addr, val);

     if (s->cmap_bm_access) {
@@ -1156,18 +1171,28 @@ static void artist_vram_write(void *opaque, hwaddr=
 addr, uint64_t val,
     }

     offset =3D posy * buf->width + posx;
+    if (offset >=3D buf->size) {
+        return;
+    }
+
     switch (size) {
     case 4:
-        *(uint32_t *)(buf->data + offset) =3D be32_to_cpu(val);
-        memory_region_set_dirty(&buf->mr, offset, 4);
+        if (offset + 3 < buf->size) {
+            *(uint32_t *)(buf->data + offset) =3D be32_to_cpu(val);
+            memory_region_set_dirty(&buf->mr, offset, 4);
+        }
         break;
     case 2:
-        *(uint16_t *)(buf->data + offset) =3D be16_to_cpu(val);
-        memory_region_set_dirty(&buf->mr, offset, 2);
+        if (offset + 1 < buf->size) {
+            *(uint16_t *)(buf->data + offset) =3D be16_to_cpu(val);
+            memory_region_set_dirty(&buf->mr, offset, 2);
+        }
         break;
     case 1:
-        *(uint8_t *)(buf->data + offset) =3D val;
-        memory_region_set_dirty(&buf->mr, offset, 1);
+        if (offset < buf->size) {
+            *(uint8_t *)(buf->data + offset) =3D val;
+            memory_region_set_dirty(&buf->mr, offset, 1);
+        }
         break;
     default:
         break;
=2D-
2.21.3


