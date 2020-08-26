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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AC2DC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:43:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D85520738
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:43:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="TkO6nj77"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D85520738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB3CT-0007zY-AZ
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k9-0008Qt-QD
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:05 -0400
Received: from mout.gmx.net ([212.227.17.22]:34849)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k4-0002VD-Br
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476430;
 bh=y9/0kXDAkWHkYY6NN8um6Z2aRXFPdGg7kDlpxDyaF8A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=TkO6nj77j2FUD9A4c5wUD47Kkz26y37v9UMM6d2xDnwFYDnV2wuwpXJBBYpdk6lc+
 DmJX1gRquUdQmI8kM71meM8FiH6ICHAvZvuNej5Rnw3nqGNJNHEVE6Uslg0LFIexmf
 t6/LUh+6EWCPZnivumRx8R8ZnggYVg/XIFJF4r0E=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiaYJ-1kn7Np0A1n-00fiSS; Wed, 26
 Aug 2020 23:13:50 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 04/12] hw/display/artist.c: fix out of bounds check
Date: Wed, 26 Aug 2020 23:13:37 +0200
Message-Id: <20200826211345.14295-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VujHakdGPa5cfqBtYEonFTf/9ibq7uMked4h3U8iAZphYotzOXF
 Ssf6QumpUoAtvJSu++9jE+JOEzZaNRxWwa6ivI1Bzz2VziOTanW/BvUBIw8PZuxVlUq7loP
 03//SBroxsupw6bZ7gS+lncqDMOFG0szCH4TVrq/6UA+4Uzxf7W2sTyLyYSxNi6TLi7noZj
 XZtN+Z+bNs09XvavCbJ0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lHhDCNbL020=:txMaE+s0XALRojr65BD40q
 jWn49a9vq29fQtFPchaMYUmlWbr9UXFddsOOWCUFXGgvI7okhjvzo5EK0lX3s3GGbeIsLOvny
 wsLBSbilK5f0Gz+b3MBvQRUvvFE8UEhbRW+Cp+jQZwhbqYaeFB8uqoQBLve+211D16+Atvx9m
 LO5tICG9Etzo38jFyVskgNuZtcFAoeU8nRUC49UpYFRvNkVH3b5Z/fnr3bobsmoyvK3lzwzFD
 wlzMQRbqIBEqDRdv9mAo3vb3O1zZ6qLV8VuZvdylro8Sb79GWHImG0RbwKNYFZLPAkvzWkj4g
 tUIvx+BUNcX2oi6jsxy540k/GisW69TwPZSegiHhmW1sxNX64oRAt5ZW8eikXbaS+jDCYFMYv
 /zq+BvcWH6gBOQrF6G2gofvLKiFmM85B28u2T4ZnXLZl2UThoE5PNd8AlJGbGL2iTzZVfjcXc
 xlcUdTmR01RKIFJnf8Nh/Psd+DNPT/r153LFanzTu2yHAGu9oBjno9HSS2yrJNtbBh+G9n3jl
 mzH7l8Huyn2eMxI0Mxny7tSR9ICexESVAiqXIduxHLPBoHkcbx66i4NXU3UUwjPNn5db7p/W+
 Vs7nFAhWblQXoDGsetZISPv/qLR//BPzCRErtqN7ANI3yKTYOUsc8DspremCtNAiPCfF5mLy3
 Xb3UAe+BS5061WWoWOS+57PmOECXwJ2FN2zOJyYgSbawUVE+ztndQ5PxIDP/YH2BYwTn5QReV
 WRx1OKgWu86MehzvVxAkh+qKwEBgIBLY5VQX9S7atBYZUQJsZv8Kxx9HYYTBSOd25bC+J2t5N
 s/lNImgIfkjqweg8t45JBpchgLbDNvHWDoNazIbWGx+15zZ2FCIDsSeeR0y/M43HwzYgij/KF
 aUvTTgnofzTJ7hVaSsmPUADkeEj+zTkwvhxDHRZbmjFkeONcQ/9FcGhIfIR75SY4Of6Agoj/9
 zIJE7/Md/tdCqWQFjEbKAUkOJ6g+ELa4t3eOrw/BRPgW9FZNMylgr6CV2LakTDWddDaEuHTed
 iSYA0/d2DlxMYIKAICugO4iuJpjIbtRUrHv7lH/W4oojQwxWKxOZBeCgnKu/MFdZ4J5/Btgm8
 RSxpHAaNFaDnN8SnLgHueLmDhe0ANM7YrwmfxlfMzbpCLsSBlaq8UYre3yWccWFJr4Y70khMs
 87eYbgVgBnzSYOWeMPMGNTYLRD3GTH4TUgIbANNG2spkCsjMBm5RPgxmw95ruR18nX6g2M9MQ
 lvY54q8e44LY0v12h
Received-SPF: pass client-ip=212.227.17.22; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 16:12:45
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>, Sven Schnelle <svens@stackframe.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Sven Schnelle <svens@stackframe.org>

Fix the following runtime warning with artist framebuffer:
"write outside bounds: wants 1256x1023, max size 1280x1024"

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
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


