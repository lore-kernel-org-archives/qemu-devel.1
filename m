Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF09C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:30:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31EC120737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:30:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="A+vKLUnO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31EC120737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47132 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB30D-0001Y6-5k
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:30:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k8-0008Pv-Hf
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:49659)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k4-0002VJ-CP
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476430;
 bh=I/Sx/HdpIxh4i9UsobCMs9UPgI56qxrzVMpyXIjjkEc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=A+vKLUnOpQ8X4wj95o2osoyVxTUBPi55V+WfpbTpAe56kEX8HL9+NlCmqjqSfgPEU
 +Ly4hkp1ykhR1YomL4g7PleckDtb/utm2hzJg8Ej+wkl0xm5RHNT+ODAFM6J0myJzu
 WR5h4uv1LNsTl452rMX7o91svid1W4WVBabJLABA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTABT-1k33D72ged-00UbbQ; Wed, 26
 Aug 2020 23:13:50 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 07/12] hw/display/artist: Refactor artist_rop8() to avoid
 buffer over-run
Date: Wed, 26 Aug 2020 23:13:40 +0200
Message-Id: <20200826211345.14295-8-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1wsxwE5Kyx6k5ZylHw+ntUtZ/CN38mykVpUhyKA6ikXr5QqiNjg
 Ll81nhsBVUd4s+X9YzG/fuY0auc/Sq9b7bmPEo2e5y98Jar5Oxkj25VFAy/2pLdDdLS2a2C
 XkOYvCKRp8/tUEbdaDYJp76hkHH+BwuzK7rDRccdi8/KztXlbb3lWvPKNdhlywduk96zq1p
 oPAiH/ZdgS+rfenNABSQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7zjeJTmAIHk=:GY+8UDZslxVdg9Ku+ouMwy
 ozag1WM3nY7GX3bcceneYSgKqVlzgOEw7Pw58wnqxV+hn/3Lvf7VNMmrStQr1RG9Y59k45df1
 VYF/IA/OYY9LpMCVQc1RuyYJRQFY3/KdVHU3xKZzbNNZP3zy4O4gU/OxCjTRp5gSr/VCiFUED
 lnLsJIzzESYNl6WENMhgidqj5Aci3i1Tv1+gQ2EBg/NF9Mkdy4u3XP8VUs4uj/m0an+v0GKYS
 eY/gYh6aJ0b4w/IigjGffehesexzT2UCogcvzX/d1+tPdIiuwA9Hw8zRDvihLCAnwFD9U+hsI
 shQzFAEWMyd2qfBLa+Tkd4HgmeK1eEWlfhEfzb8Wp62ju5uTJ3N/XnGUyUZOj4Ooc27jOat2C
 gdqbjFA3DJsmmLw/tQG66M0ZfCvY94iyfwHX52gxPBajbMYQTCot5yAFxRPjHBksvsfsSnWRy
 yebQ3etyUXYc2tsDYyAqChgDkMR01Tue0lNm45Vv3BUx+OsQPRMTm7NaXftp0oCdPOpSxDzX7
 QwLkUkLxRtFsgxqt3qHg1EsKDRiJttlqFWEhM2UVKlF9cLAKfauFF1vQAnxf3U9fRiMt1e3df
 o+z7cngLEIf09NP62FXcP6eA+ClcLSZgj18EU6lKa72VFDqJhMFuu0fGi8AqVLvAFMDlwCrgm
 e3X2RVKd7aqIdLZKdNm0Cmh5UjaSJp86G7TPIeM/U++N9h7/Q3e8C/xnOzQwgNakB/rlsqZwj
 1NiJkcqa3+Fun1twOuXA1mK0iQTQB9MpaD+3EDP/pjjtSPsaRlS/Yk5tzUpE8AZtYoSqVg1z7
 RLe7mJ0pz8xjlES3aS2qQVNEoL1ubShrL9ZZR76gZmGmvaZ+wkZ/kReTHDS2ElfFAnFeVYlQF
 iZTQaS/6f+lOuTlFihNDNFoP9M2sU0XGqVN6s4uQpg9okuaXZBPbhWRXS9RitvksB0UKcX/Gy
 2795XbWhdpggLQ7u77YBNe/mxzL738VsGiWreHOIff7VrcMwD/S8pSbyaf/Y/PX+uniSo+X2y
 LMeUOADAGL9Z3LPV8ibjX/eSAiR6qEcpP8IYRzT+t7b7prosvfZvGqhfxEYyYdbbadqi5+/0Q
 7Trlw9p0qKc6fUQS+DxGMMXYh2kDC7GjwwzLfbvX5XRQ0zgGlGFyJpjRvMJlPXSc0PDNdkZ8w
 s/9gKW+scktGlVdVG59rnGXE1iYYXuUDHNweN3VwD7UoQKAW2shpbqF+W3kKTBW6S9TBVciNS
 5Ss/XW7vEYyZutPtR
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 17:13:54
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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


