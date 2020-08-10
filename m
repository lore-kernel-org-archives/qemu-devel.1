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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16C02C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8603206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:34:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="QUGz5Pdo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8603206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52090 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k57wf-0006RE-RW
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nh-00012T-Lv
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:17 -0400
Received: from mout.gmx.net ([212.227.15.15]:55933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nf-0008HJ-Bd
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065887;
 bh=I/Sx/HdpIxh4i9UsobCMs9UPgI56qxrzVMpyXIjjkEc=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=QUGz5PdoKSGFSh5g2NcspKqIguTDf5/TPb3Fv9vL2khrXbD8bfkujnvwdjTPpe/AM
 7kZiO/CJDoYQ66neLDip4Rzkb1aIDGTfMog0GFL0/mh6OyMulJRWDjRnhGEN2wozTb
 mbCWeULOBhhSjHyCYFnAfMgMFKAGFta8prgqDVvg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmULr-1kVQ8V3R5N-00iRoH; Mon, 10
 Aug 2020 15:24:46 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 07/12] hw/display/artist: Refactor artist_rop8() to avoid
 buffer over-run
Date: Mon, 10 Aug 2020 15:24:36 +0200
Message-Id: <20200810132441.16551-8-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RBu5uyb0LyB0fIjkGoRK+8FIq++UNiCPVdyM4IdmGZLULo/w7gf
 FK5j3GqW9v7KhapleBxE/vRZY8f7J+OtDG4iWS+amk1FNUdW39CsmIgRWyfAoF/Km8KGB9u
 i5qJePyGKiPXb7ileYsgU266Wd6ACFm9AcNF3m1xM3ekrljSbR3GWKHqv686WzM7vIfefxl
 nw0VcCBXc2y2tePlSrXJg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WNSW+elqNjQ=:10J1AmZlGAi02C34ET5y1o
 urno0IEZgWy1vbREuo1T2XGfqr5obtgIv9dr0hSiXhf1Q7EgKqcHH+VFXvOWGLWWT0D9iA2Xb
 DC5q6wVasgTGPgPRDvNOeNtNse/70RCeWzAFXix0gUDjlVkDsRDixTG4NbLorG1vWFA4E1RlJ
 TN5E9YU52oZo4t03c9fJ09R5F6tl583hi1IivNkVwrIhqaL6mOBT9ABaHdvhr2feEHmv5T2Si
 IBFofSRLYNeH3xdQ6gw+rD1lN8ic+LGy+wnr71yqAOolhP61fg/+m9Loqznt1ccqYT5tpKUQ/
 Cqw1yql2DvanxlO0aDy3c5wKhvXZckml4tThLPHs7wthrzj5Gw2xk4X90PyiyG86FS2k62CRA
 z6rjEUki3uR0XPGxTyr8mSzODbA1mqml0HLNhkZawS0xW9Bw9qmD0y9hcPpbLyGxYZQorWZFN
 kAzVZkUSWvLPT6ZOYYhnyQ/u9sLYqmYhCTy2WoxLrfwmoEmQhMRUA1/c/IjMAcVya34WkPlOB
 fe8SJ43R01QfEQdvyuUXiiwKIKzDDz1Igyg3ThxmfSMHSVaiTHWY9NzawAx/9SVBtQ2O8KK2K
 il7/bZQyeCOk1IFNYYDiyg17ZSJOQEYes4LE97poSPVkAazTsQyOREfcI9K8pKUi+rs3Gv1li
 fuCmCgYz0Vad+IxTdgltTSEPr8z/N4Ec6ZosREuJa6QzZ0AyD3mACQNuPXD35cL3hutBJ7z30
 4zpud6aGipumyqUkv6ZN7edDEnVAHeIrn1UOAmytM8pG2+sHS8HVCRAXxC/dTTdo5IrwV2F2n
 L9NYMLzU/MBCzwXjbO5mFOqzvleJXhAimiGVgAaXJaN4zFKbc8ABeUT2uz1qvKC7JUW7iO/+l
 QaWZCj/Q+ATV1a82h24VUsfEF7KgHTS1Be84kScIH9m0nVlG1BNDflcSNywee0yTvbbi1phlx
 aAIL+hTjmzYgViWMyDgfXQsmqNCveKwu64oWRKXFW2LUOkUk18eAJNGZo7ucbvHmgYIRISNBU
 fLPhOP2cuZ4cpdDdAi01fgRBMl6v1apE3wnlsIojRmhsKwOM6shy5tDzxCo2tyVp+lcwlGN1C
 4enIYkdyAUB/Qh8Pt22Y2C/8NVkaP6IU3BLA8KEd7k04hiMjTmkJyJzFwIPrTyep+4GN2k+rg
 AzjurROXUncZ0TOHYnIhewP3ijSXYvbFpPOS5BITuenmvyby4tlh5oP3tYpEzfWQt3+x0f7iv
 yqVSBbxgbN7TRQLcf
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/10 09:24:50
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


