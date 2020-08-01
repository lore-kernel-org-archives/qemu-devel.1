Return-Path: <SRS0=xT3E=BL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869F2C433E0
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:17:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53A622087C
	for <qemu-devel@archiver.kernel.org>; Sat,  1 Aug 2020 13:17:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="I6Plpe41"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53A622087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1rOA-00084C-8g
	for qemu-devel@archiver.kernel.org; Sat, 01 Aug 2020 09:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38486)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rKy-0006B9-KU
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:08 -0400
Received: from mout.gmx.net ([212.227.15.15]:53951)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k1rKw-0003uI-Pv
 for qemu-devel@nongnu.org; Sat, 01 Aug 2020 09:14:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596287640;
 bh=etFg3+StLqfzOdelI3cESVmOqkDQ4a3cmEicqnLG+gk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=I6Plpe41XhT2Ylyk1hTzrboFSkra1t7ozgP08h6+yDEVJaE6PWudDLEpNjRtYP7a8
 vxjpiquzf8GZ9mHr13qww+DcJ1m2czn5sV0ANJGQihpEfbfvhderG9zyVpDumMbM5a
 C8QqGsPxgcQ5lV3wlUv3mMB4vYDBZUB7iJ26HRNo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.162.176]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MGz1V-1jxiTT0jMh-00E4oT; Sat, 01
 Aug 2020 15:14:00 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PATCH v2 4/4] hw/display/artist.c: fix out of bounds check
Date: Sat,  1 Aug 2020 15:13:57 +0200
Message-Id: <20200801131357.17379-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200801131357.17379-1-deller@gmx.de>
References: <20200801131357.17379-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:njv7tqexMyNbrMNn86E9YFp9RkiX30uhc2lvd+KK+I3KjEz5ct6
 Hyk4NdkEsxdXnNUBSOEkSp+g94cdiAY0I6IAnRjQF8FcQwZTWo1fimi52rmNQBSJZVEwRLR
 El0tU3RCPpwCGGb0NIfgY8DkCgk3Q8tQW/UeNVM2uOHV6KBhpAiBmLSXiMdxG3I2LSwpJhV
 5sqPt8EipOM//8Rxu0sZw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QvHX9IehykM=:FV43a9TWk/12EKDqGBB0uu
 H1AWb2JnogT1iJ3eUZBpRJpMHGFHlb9ykYT+bOKp2/sWsO53iC77rX2vGWhAP//L8/IZQBQg2
 kZyA4dB8xdsFY04faxZIdvXceqUYYSmcZSYnxtrxONx7R/xiAyVK2Blo3YPD5S6ILPLeKSsf4
 n+B2bLn5VYUzpu4H+yTqk99odSVLZ8yoek+Tk+mpQeAeSMMLaqo0TqTNIlIkNn0faImXq6iWW
 9PZgSNJ41sh9Etu35efO+PnvyeXXwGHRXDshMoDIZYjxQSfmQPazLarGzbvu3tIDxGiO3vWPx
 cXRCnkVU4hMy2pScJS3PNTOCUlMO2mbHtcCMyGAblw3Rd2rEJU1udYqyMyLQ0Y9sCIIuayxQ/
 lKb3yOzeo8nf7Di4+GAEh5YBWdABRPvgxONFmMf7oNxhqesgPPzGJLnBB3SznMXSlyiKWrehX
 073ylA3H0MuejOnq6dw2O/3tKY9yY4Zf/irJLJRhvrCVA4t10SEHAdO/WZl02ncSeB3X9U8zM
 A0qnKQ/rDZihJFOgdS3NYUJkB05jj7OLMO7lxdlZBCHvZqh52bgEIMrqnLrLyWBgR0YsEUM3E
 8CeSkkXIZYWTWtvLU3XLS/wy99QmyqlmjwvHWHPL3fgmaDtK9g11mzb/rGRLkALiLqU5wwaR9
 HEitB7EPEqbu6N3zJyTH5lTuyc3WCs8jKljPxa4C3lZ5h+gbKAuDhSLYPt7I8iGVxyDJY4ylH
 M/vBhGXlumfuunHYGrEDgxpm9wrbWTZuGa2TJaQ6989TMuTcdeYW5e+sKL3XSCURLHwKDlGoG
 7qbVVyJJqGDlVew7nNKKFr7xQHoRYQ7lyKNIUseT6/U/EFKJplQiZxXNjOyLcKJHFWwSl02e7
 Dc+hQlLkZkw/zYGeyERpUqj5FJ4iN8eK+5yd8eKxQCdNaPsCSlR28Q0qzisdnlv1Xe+pjJ+uL
 GLPe67SbLQX35ML/AkPzc/qQokKewSixgIUtQMU/XFmx2z/s3dIi63RRNYzEU8MrlPVRHR+nD
 Cs2yvyv6W6EhBGmeKLwVXXTboIllj4ywUydRHVhYgqtjiUwsRy2cSDJhAPSDsmat++M3Ysn32
 vlH9LWhB8hBdmjQgojMTvqLvCBzRISlkI1dWcGfe1Q54DslB3FOYO2FqbzdEBgQPX+KvbsrcI
 XxMmtoYfjmY5OqhuXONXPqcXRAhtNqaZxM2SXVoqDzs6amoYSZAGYzIdonzepD0VT6K27raaw
 R2LqXApe1m7Ho0/KP
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/01 09:14:03
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
Cc: Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

Signed-off-by: Sven Schnelle <svens@stackframe.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 24 +++++++++++-------------
 1 file changed, 11 insertions(+), 13 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index 6261bfe65b..de56200dbf 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -340,14 +340,13 @@ static void vram_bit_write(ARTISTState *s, int posx,=
 int posy, bool incr_x,
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask =3D s->vram_bitmask;
-    int mask, i, pix_count, pix_length, offset, height, width;
+    int mask, i, pix_count, pix_length, offset, width;
     uint8_t *data8, *p;

     pix_count =3D vram_write_pix_per_transfer(s);
     pix_length =3D vram_pixel_length(s);

     buf =3D vram_write_buffer(s);
-    height =3D buf->height;
     width =3D buf->width;

     if (s->cmap_bm_access) {
@@ -367,13 +366,6 @@ static void vram_bit_write(ARTISTState *s, int posx, =
int posy, bool incr_x,
         pix_count =3D size * 8;
     }

-    if (posy * width + posx + pix_count > buf->size) {
-        qemu_log("write outside bounds: wants %dx%d, max size %dx%d\n",
-                 posx, posy, width, height);
-        return;
-    }
-
-
     switch (pix_length) {
     case 0:
         if (s->image_bitmap_op & 0x20000000) {
@@ -381,8 +373,11 @@ static void vram_bit_write(ARTISTState *s, int posx, =
int posy, bool incr_x,
         }

         for (i =3D 0; i < pix_count; i++) {
-            artist_rop8(s, p + offset + pix_count - 1 - i,
-                        (data & 1) ? (s->plane_mask >> 24) : 0);
+            uint32_t off =3D offset + pix_count - 1 - i;
+            if (off < buf->size) {
+                artist_rop8(s, p + off,
+                            (data & 1) ? (s->plane_mask >> 24) : 0);
+            }
             data >>=3D 1;
         }
         memory_region_set_dirty(&buf->mr, offset, pix_count);
@@ -398,7 +393,10 @@ static void vram_bit_write(ARTISTState *s, int posx, =
int posy, bool incr_x,
         for (i =3D 3; i >=3D 0; i--) {
             if (!(s->image_bitmap_op & 0x20000000) ||
                 s->vram_bitmask & (1 << (28 + i))) {
-                artist_rop8(s, p + offset + 3 - i, data8[ROP8OFF(i)]);
+                uint32_t off =3D offset + 3 - i;
+                if (off < buf->size) {
+                    artist_rop8(s, p + off, data8[ROP8OFF(i)]);
+                }
             }
         }
         memory_region_set_dirty(&buf->mr, offset, 3);
@@ -420,7 +418,7 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
             break;
         }

-        for (i =3D 0; i < pix_count; i++) {
+        for (i =3D 0; i < pix_count && offset + i < buf->size; i++) {
             mask =3D 1 << (pix_count - 1 - i);

             if (!(s->image_bitmap_op & 0x20000000) ||
=2D-
2.21.3


