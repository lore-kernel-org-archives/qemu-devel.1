Return-Path: <SRS0=QvPl=BU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51565C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:39:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 054C8206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:39:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WIA20f4g"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 054C8206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58448 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k581R-0000lB-3N
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46390)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57ni-00013E-Fi
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:18 -0400
Received: from mout.gmx.net ([212.227.15.19]:33401)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nf-0008HN-Hn
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065887;
 bh=FteAIEPVuJTC5Kttr/SwW6t9UCyjdQt5PIs/OZjkss4=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WIA20f4gL/qlpsaiMwFXZlsqZI4GJhNp1IOVW52sQ8VKlXOsnjceSGghPL8VyS5zj
 fjmgfZ7mFyGThCuzbPDI+cPA1Rs0OQWhMiTdjMvehQGNfqK0V+jEwX0Miw1yY5q2Z2
 WN9hZ1MuJq1tH8K4CxdWlsp9x5R4wkr4Zk/LTXhI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1kXsyV1C24-00kNkW; Mon, 10
 Aug 2020 15:24:47 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 09/12] hw/display/artist: Prevent out of VRAM buffer accesses
Date: Mon, 10 Aug 2020 15:24:38 +0200
Message-Id: <20200810132441.16551-10-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:sCF5fIzdSNPy6joOil02thubFvlOinwQ7zWHyL4vHntrU/KGOpc
 taOdAq3fqChvkCmpIwGJhJqIlGIgA0FL1zganf0su1VgnCXhfD2bEQZ0jeaZRFt0s41X0Pj
 UGa7IiN6x6Hf+SkK78PLP73APU3YOYXw8nCMxeaJZ0scUVDaFh9K8S+OlGC6zsqnrv6t0/Z
 UemL2DVEeXUdgF5NLUDSQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t3i3CRmaNJE=:5kYkKnfQBpFsrvigf3jWCa
 48Hs8AM7L6pP4LeMIkwUKFEw0tcD+3sIV0yBQjargnv6OPa6F9bsWfjcZv3d7CIrha+mYi8ye
 EfBxOsx5pn19bitt7n0IVRs8cu7NbsuK7pYxe+3fOyRE0MN5L/wLlGw1UfSY4HCzzkCswtBCN
 9G+3lNTAVS6BRNuzGGnv6f755VxamQYytQ2MEI/QHTYr7L7uw2Bcb4zlaAQqRH/nCaiDhiVn7
 geFYg4iw/ZWU7SVg+Sc/QPoPF1kvyt6CE6NKmltfTO65Du6mHw2nk/EQwNmgHkSG8NQbikL8w
 3373WjiTMW3AXvdCQOpQ1FHDXTu9sTZCGV3vWxgeheARaJWZU72nFKkxQyXv74TJyWOfI2/bB
 8L5NHlzlymX4HexRcOCPhnc89jk0PFc/++PpuYlwsBHtLbBrazdeOZlZsp4zRlwUwVd2RQ4I5
 jcSqKRE3XT5xoILelHvhU++cpF0Yafb0ju8asVURVj0B+N5++Vj6EnYOlsftOJ7H6lE5p9r14
 ov0v6GLHLdach7toY3ARPUn/H82+VfsLdPyyCLBi2NIbJeje3BSeOl+g8ZQXx1BIDwWUH/QOx
 o0FE0RKPSBh5hY4D9VBZQ3WvI+44lR9XulKxuEveTt0aEH45hLJHfPGvoL+lAflf+jIXOTeUI
 xYOJhPum7cpaZL0vj+EI/IFjPhU8RKlFeWi/9XiawvLewAgVvkLCXHjkmSJS9CjmMh878pMxI
 yxvVGo3WJ3THqEvPImxNvW5MK5IZp7VvUnaFfcmuooNsR0CqBEbnXLg4EpbM0wk0sQvrArttI
 la6sVTad9h8lS7EFDbQD9xDDCCCKufNNQqyhxeW1ADwjlZ47B68xrG58uvZE5Fu3IErtrIOU4
 3WBQrqmv/pp7ezqmsLfWC1L8AOHL+aka/SOCvsZJDzi/+hr+q+14qn1Mhs74LzMEDZ45qkXgU
 U3lDnFVzdPY1o8btIrmLgYVlRoGBiiRyTx50FL6e2ExK5D/UL6L4k0cBg1MX5B47eCq4nKJby
 F0FH3sS1/sE9l1eYxJLnNOuSzeeWg2z4eXH1pdlWVMmdLN3Z/+uu8dpe0FSUZoyuVMk1CBzER
 qzNnctPXQDhzkOmN2DlsxVIBU9yZireA6VlCx6m7v+OQZmT4cqrmj5+D08xwZD3qta82IxLgN
 B+PYyt1XXjA03kIE8fjL/LDLKAHJurDBcY6e6SxA0MD48wSLL9/sd5B158aGU265Y0wKMv3Ws
 xo2gKeqIQ9wodi5We
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:25:05
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
 hw/display/artist.c | 110 +++++++++++++++++++++++++++-----------------
 1 file changed, 69 insertions(+), 41 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index f37aa9eb49..46eaa10dae 100644
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
@@ -1183,9 +1208,12 @@ static uint64_t artist_vram_read(void *opaque, hwad=
dr addr, unsigned size)

     if (s->cmap_bm_access) {
         buf =3D &s->vram_buffer[ARTIST_BUFFER_CMAP];
-        val =3D *(uint32_t *)(buf->data + addr);
+        val =3D 0;
+        if (addr < buf->size && addr + 3 < buf->size) {
+            val =3D *(uint32_t *)(buf->data + addr);
+        }
         trace_artist_vram_read(size, addr, 0, 0, val);
-        return 0;
+        return val;
     }

     buf =3D vram_read_buffer(s);
=2D-
2.21.3


