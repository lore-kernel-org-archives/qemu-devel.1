Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D57BC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:24:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 63FAE20842
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 21:24:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="CnEBirUU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63FAE20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k34QD-0003Fz-DI
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 17:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37492)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k34MZ-0002VD-Qc
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:20:47 -0400
Received: from mout.gmx.net ([212.227.17.20]:39111)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k34MW-0003FB-F5
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 17:20:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596576022;
 bh=kX2r0RHOt/eUy3H4Z96xMoQ52HQB8dJj9ZLu5DI0mpU=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=CnEBirUUH4YqPY32vTQJ1FC/SkskXrcfAmJXHvl6m7Qn0aCHu6R51UEsp8PLkV+I8
 oSo+HzNW/DkDSBorohBAuhJc6YVi34KX9j+5welyV/Lo/0r7BVpTcJMgSlANnroIuR
 AqB9C34TNI7VaTerk/k7XfMDXuxuwEOjSq6Fi6ko=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M59GG-1k4Aok0xnw-001Bsd; Tue, 04
 Aug 2020 23:20:22 +0200
Date: Tue, 4 Aug 2020 23:20:19 +0200
From: Helge Deller <deller@gmx.de>
To: Alexander Bulekov <alxndr@bu.edu>
Subject: Re: [PATCH v3 7/8] hw/display/artist: Refactor artist_rop8() to
 avoid buffer over-run
Message-ID: <20200804212019.GA876@ls3530.fritz.box>
References: <20200804140056.7690-1-deller@gmx.de>
 <20200804140056.7690-8-deller@gmx.de>
 <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200804163954.4dzistybjwby7pzx@mozz.bu.edu>
X-Provags-ID: V03:K1:7xkno99Ih4kjX65eDnrWbYWR6zrpSH3w+ROz/p0sO2PL5JCBXDY
 Bc5EPknCSOr2a1dyRkYaY8XG+Jav7m2JNuDm93Q/FBfMs7NXrA6mbXdLbWJvHd7rrGv1O1D
 frQCKFgwOs6hYUO3cUcperNmZ5LNNbr87A0A8IkhXXamqcdUCjTb2HKIZVvoCqZjmQHkRc/
 L5rKElMfZX9IT8HgWeWRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:BQBlOJDiDKc=:6luLTSQB3COLfx5l1pclCt
 OxBZzNEAYBvcaPXx7BYL2pxeYF8pwpSSAHBjDJOg3XQtd/oVZiIw1ovhCyl1vBphjxex8RVk9
 Fjxr9EFtz0I3Q7x1IA+PbaDlgHrs5HvcGFkcito8vT0eUuyzH5/2OKC7cO9eRb6OwKz5iBD+2
 C2SAuYC4wA7STtsQAlgccLsVr9Mc1nNRHXa2oFsnpNkRx7SC6oOTJcd/i5aYE1H1k1p9eTxwH
 1ZEz6vcIymD5sDTGgZm7nQ0buvTf6QyX4lQPSTZ6NTHA7+viU88enBXx+ncZmJjvULoLdrtTE
 yCgE0CP0bjy3AUpl8ktW48+xN3E+DO/50LHrdQIBWxY4w4LJ3CO+gxTiGv7h0GnYOWPgbgfEr
 lV7KGJ781Q22cE7HWhrtPWqpV+QK3TqX1mXu/PZdmKsVVjmBLsQhQSkVcuT/5GpDcbwtCVYxX
 MhON46VVXuUiey16n85XzrT8DWN0T7H4mI3JvYw4aHAuuYI6feZtg/s+XD+2h32PUnXlalk+v
 DU9tI4rQ1H5Af1cdGrFmLXcWC6eYGRHlGnVsBUm49x4n6wH3L2Mk/PnD3HQgsc9r49PoikDkc
 DPwm/+5W03WCk2IEOL8BkAzRRmmhX5x8AIjcy9RPM5a5eKnB3piilAdZwXfdThULufFU/BmQU
 quPH3Oa8EX+CUCzkvPhs0nQd+va9rpRn9hbqDNr0Ga1HnDdXD4EMOV96wF/n7oJ8aNWEpal30
 bygj2VbtI27ZwUsBrCKYynw3FNxqxj+yqWgazByKOEufJNbT16VKv4bleZpn+R4uN2qJ1yiqO
 n71c/0GGVC8qWEG5qzow9ChDjq1ljA9/nMuFiqsRHH1ms3IyrDEbwPFLEKW9cfGba5CZAffMD
 ywh8utwTGEy3GymxmI/e67HcpvEe2f2SruCyj5EVI8LMPeMHINsGTxGTWjF7LwdHhP5ak2LGG
 P2MwJkSRCrAvCctSf8Vk8JHY87WWaMPfQj2vWNymX8vdxWRrWcLq9AuhFZzymKxx0lliN+Ld1
 JsvlqK4916H94NcvVTKLeIKbhJ29ER2/4tNjGA6DtqsjtaHGT5j4kW6z9l7QYP5oVSx3B0nzU
 wAcqHP4ernYa2jCNWKnPz/AOzKrhiKoZL05zPju6p4/sEB5SMZBe2tNFTYouw5X1Y0K04kurl
 Hsd9rCpFmuVl4gIpnCJ3g4HwDLfuQC38NaqKko6A8t88D/IBi3trw3h5OXMcKct+tRVPeM0uM
 fV5Rj90K43xaLGa5T
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 17:20:41
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
Cc: Richard Henderson <rth@twiddle.net>, qemu-devel@nongnu.org,
 Philippe =?iso-8859-15?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Alexander,

* Alexander Bulekov <alxndr@bu.edu>:
> I applied this series and it fixes most of the problems I saw before.
> I still see a few crashes - I made issues for them on launchpad:
> https://bugs.launchpad.net/qemu/+bug/1890310
> https://bugs.launchpad.net/qemu/+bug/1890311
> https://bugs.launchpad.net/qemu/+bug/1890312

Thanks for testing!
Below is the updated patch which fixes all of the issues you reported so
far. Can you please test again?
If you like you can pull all changes from
https://github.com/hdeller/qemu-hppa/commits/target-hppa

Thanks!
Helge

=2D--------------

=46rom ee31d3aa9dd91cde3a4df8fce97239a0ff26f7cc Mon Sep 17 00:00:00 2001
From: Helge Deller <deller@gmx.de>
Date: Tue, 4 Aug 2020 15:35:38 +0200
Subject: [PATCH] hw/display/artist: Prevent out of VRAM buffer accesses

Simplify bounds checks by changing some parameters like row or column
numbers to become unsigned instead of signed.
With that we can check if the calculated offset is bigger than the size
of the VRAM region and bail out if not.

Reported-by: LLVM libFuzzer
Reported-by: Alexander Bulekov <alxndr@bu.edu>
Buglink: https://bugs.launchpad.net/qemu/+bug/1880326
Buglink: https://bugs.launchpad.net/qemu/+bug/1890310
Buglink: https://bugs.launchpad.net/qemu/+bug/1890311
Buglink: https://bugs.launchpad.net/qemu/+bug/1890312
Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 47de17b9e9..66a230bbd5 100644
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
@@ -203,14 +203,18 @@ static int16_t artist_get_y(uint32_t reg)
 }

 static void artist_invalidate_lines(struct vram_buffer *buf,
-                                    int starty, int height)
+                                    unsigned int starty, unsigned int hei=
ght)
 {
-    int start =3D starty * buf->width;
-    int size =3D height * buf->width;
+    unsigned int start, size;

-    if (start + size <=3D buf->size) {
-        memory_region_set_dirty(&buf->mr, start, size);
+    if (starty >=3D buf->height) {
+        return;
     }
+
+    start =3D starty * buf->width;
+    size =3D MIN(height * buf->width, buf->size - start);
+
+    memory_region_set_dirty(&buf->mr, start, size);
 }

 static int vram_write_pix_per_transfer(ARTISTState *s)
@@ -274,15 +278,15 @@ static artist_rop_t artist_get_op(ARTISTState *s)
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
@@ -294,8 +298,7 @@ static void artist_rop8(ARTISTState *s, struct vram_bu=
ffer *buf,
         break;

     case ARTIST_ROP_COPY:
-        *dst &=3D ~plane_mask;
-        *dst |=3D val & plane_mask;
+        *dst =3D (*dst & ~plane_mask) | (val & plane_mask);
         break;

     case ARTIST_ROP_XOR:
@@ -349,7 +352,8 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask =3D s->vram_bitmask;
-    int mask, i, pix_count, pix_length, offset, width;
+    int mask, i, pix_count, pix_length;
+    unsigned int offset, width;
     uint8_t *data8, *p;

     pix_count =3D vram_write_pix_per_transfer(s);
@@ -394,7 +398,9 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
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
@@ -464,12 +470,14 @@ static void vram_bit_write(ARTISTState *s, int posx,=
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

@@ -481,6 +489,12 @@ static void block_move(ARTISTState *s, int source_x, =
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
@@ -507,24 +521,27 @@ static void block_move(ARTISTState *s, int source_x,=
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
@@ -561,7 +578,9 @@ static void fill_window(ARTISTState *s, int startx, in=
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
@@ -636,7 +655,7 @@ static void draw_line(ARTISTState *s, int x1, int y1, =
int x2, int y2,
     color =3D artist_get_color(s);

     do {
-        int ofs;
+        unsigned int ofs;

         if (c1) {
             ofs =3D x * s->width + y;
@@ -768,13 +787,13 @@ static void font_write16(ARTISTState *s, uint16_t va=
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
+    if (offset + 16 >=3D buf->size) {
         return;
     }

@@ -1138,7 +1157,7 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
     struct vram_buffer *buf;
     int posy =3D (addr >> 11) & 0x3ff;
     int posx =3D addr & 0x7ff;
-    uint32_t offset;
+    unsigned int offset;
     trace_artist_vram_write(size, addr, val);

     if (s->cmap_bm_access) {
@@ -1161,16 +1180,22 @@ static void artist_vram_write(void *opaque, hwaddr=
 addr, uint64_t val,
     offset =3D posy * buf->width + posx;
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

