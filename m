Return-Path: <SRS0=d88l=CM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F692C433E2
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FEA320716
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2020 16:11:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="f0Ij6uIv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FEA320716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42308 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDrpt-0001Jt-2j
	for qemu-devel@archiver.kernel.org; Thu, 03 Sep 2020 12:11:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35786)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmb-0007xk-Mn
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:17 -0400
Received: from mout.gmx.net ([212.227.17.20]:47577)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kDrmZ-0007lr-NN
 for qemu-devel@nongnu.org; Thu, 03 Sep 2020 12:08:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1599149272;
 bh=nnNlK5lEXtZIws7ZcRwRHZ3YQMN8yoczHrA5VaeDSoM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=f0Ij6uIvE2Dsjqk+ukhETOI5LaUq6S2RNWFVSj4eagMp5IObAu/BVm6IamlgWHoAb
 6TXeZLRXFW1pvqgxF++8nasQwKU9E0wfTaWRCsxtdOAPb4CZkPXoTTVOBWNQMGtNtK
 auIiU/m5w1ORX8kWhQB+dbEZ4VkykJfRryLSnVqg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.138.28]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MC30P-1kPjLu3e6n-00CO9z; Thu, 03
 Sep 2020 18:07:51 +0200
From: Helge Deller <deller@gmx.de>
To: qemu-devel@nongnu.org,
	peter.maydell@linaro.org
Subject: [PULL 09/10] hw/display/artist: Refactor x/y coordination extraction
Date: Thu,  3 Sep 2020 18:07:45 +0200
Message-Id: <20200903160746.27491-10-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200903160746.27491-1-deller@gmx.de>
References: <20200903160746.27491-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:bYMNUoqq2uXBXRY2opA4yyv42Gwoehc/zZeiIgvhvkAuY1hwyRl
 L5/rJEQYO0H0ZDdxkif9+/9Bo2bL3LLATGkZsGY0+yF8hwEUrsiYEFBsafCsM+BgAL4uPjO
 gySRodY5OIZkeM/uI8zpGxioxXN+eOyS9bgtSJRaIhmHPokXRY8KVwerwlbR8B6+kUoyHwL
 omEJJ/cThQZF3O1fGK0aQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:8oU2QUbsdJo=:On3kD3+7GnYIsig5nMyeGB
 N7/nurklVd2VGmDmsK/FwOqS6+cPQsEILpHHQ1hSs4T0pV2nw9U1ufPECgy2hDSGf+O2e3hOX
 0yj9w6cnWnq8rjd3yICbOUhTV1oNh3xCyluwF02JJ2LyiFzW8qAO5d69de5X1kfl9DarcW7P2
 FZYn5fUlJJaCeiayrqNTDlj+9vijNMkG839uQBfQqBqw1Vok5UEZFG1qKThGq9gNwvddhGHqh
 UJI8kqIy1AnmT4OZp+DpY8LOyy4fQRp189czXHdYvF/rN9wflNEohweKsCtSqw8A5OJnTfhHx
 qXiEz8loLdOzjDBHGmMulAtqLJwOksXEUsHzC72tWUv2XULcFzrTGqekpvklkjJYDpUILWNkY
 pnY4gqJvz44q1MH2g8eQY8+tuZM6NUVCmqcEMng2xojna5SmY7kN007Y4xH7FLtbTb/k9yfpF
 EEOLhI2S4c0MRXJBtbb9s4OdVU52cKh3B/GYzIvKl2Zt5E04qnWRVupFBfapHub8niMIUlJ51
 NkfvTFhxZPowp/yIpIIePNM2B+4UJRz5hB35U0i9zrQ2jP1vdHg8lE9pEQMyfvMkrrFYKQX5s
 XfJ1Tzv6SMtv6PMZTDCW03+W+WHeHmzwXNETBUMsegDg0aR9hprJYohl/KG4BVrgwcZd2olVr
 PYc/buEPEd+DoFrAoxYK0R3YBvqCodYOIcnSQIwQJw6S/ev2uH4DnQ3BTfFC0AD0EbR/kRu9h
 ilrAUbchkZlpl3P8nDI7G3bW68LsRFtSqtebQy9z6QnI7lMLzdayXD6f7y25hWwpqghBYF+CW
 78s2/OPps/NbNavklmUradWZy+KOp6bxSNXqba8meA+7x0gYXfDWz6hctst8NNyYInmhe1lh/
 8oVuUSw/aDYI4zt2GbJ+hI0kwb3GVN5r4mZCMDeyarIX3byxZMWB9t5nu28n28d9OY5DT4H9W
 rXb9XUf/658zGAMajqZUqDABdMDxsH0fQrlGtVfL3xeqHJz9AkAzaKnNqwIw6V5DfGsGmVbH9
 9YjX6Nl7OuaYtcJzazMpy9RuFXHQaafFUc7v4gbG2JaLvQZLhT2NQbHbHs3wTtXTUjkWeOIl7
 50jmIcmEcfNP97Snye+PZJpsBYzzAU7kkH4rE/ETXBW2scsyu00gnObjxgAYbK+4uD/P2MbyL
 5SIWnPshO8iPFaJxCREVB3a3ae6oqK7DBnNmrcmEBFf7ZXOKrjN25Ez9fqxf1e/iYStrl3kc0
 p4F2GniHpqgaAmgD8
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/03 12:08:01
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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
 Richard Henderson <richard.henderson@linaro.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify the code by using new introduced ADDR_TO_Y() and ADDR_TO_X()
macros. Those macros extract the x/y-coordinate from the given uint32.

As further simplification the extraction of the x/y coordinates for
VRAM_WRITE_INCR_Y and VRAM_WRITE_INCR_X can be done centrally in
vram_bit_write(), so move this code up into the function.

ADDR_TO_Y() is still limited to 10 bits which allow to address up to of
1024 lines - this will be increased in a follow-up patch.

Signed-off-by: Helge Deller <deller@gmx.de>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
=2D--
 hw/display/artist.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index ff1532fdc1..16d85c65f8 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -192,6 +192,10 @@ static const char *artist_reg_name(uint64_t addr)
 }
 #undef REG_NAME

+/* artist has a fixed line length of 2048 bytes. */
+#define ADDR_TO_Y(addr) extract32(addr, 11, 10)
+#define ADDR_TO_X(addr) extract32(addr, 0, 11)
+
 static int16_t artist_get_x(uint32_t reg)
 {
     return reg >> 16;
@@ -348,13 +352,13 @@ static void artist_invalidate_cursor(ARTISTState *s)
                             y, s->cursor_height);
 }

-static void vram_bit_write(ARTISTState *s, int posx, int posy, bool incr_=
x,
+static void vram_bit_write(ARTISTState *s, int posy, bool incr_x,
                            int size, uint32_t data)
 {
     struct vram_buffer *buf;
     uint32_t vram_bitmask =3D s->vram_bitmask;
     int mask, i, pix_count, pix_length;
-    unsigned int offset, width;
+    unsigned int posx, offset, width;
     uint8_t *data8, *p;

     pix_count =3D vram_write_pix_per_transfer(s);
@@ -366,6 +370,8 @@ static void vram_bit_write(ARTISTState *s, int posx, i=
nt posy, bool incr_x,
     if (s->cmap_bm_access) {
         offset =3D s->vram_pos;
     } else {
+        posx =3D ADDR_TO_X(s->vram_pos >> 2);
+        posy +=3D ADDR_TO_Y(s->vram_pos >> 2);
         offset =3D posy * width + posx;
     }

@@ -858,7 +864,6 @@ static void artist_reg_write(void *opaque, hwaddr addr=
, uint64_t val,
                              unsigned size)
 {
     ARTISTState *s =3D opaque;
-    int posx, posy;
     int width, height;

     trace_artist_reg_write(size, addr, artist_reg_name(addr & ~3ULL), val=
);
@@ -881,16 +886,12 @@ static void artist_reg_write(void *opaque, hwaddr ad=
dr, uint64_t val,
         break;

     case VRAM_WRITE_INCR_Y:
-        posx =3D (s->vram_pos >> 2) & 0x7ff;
-        posy =3D (s->vram_pos >> 13) & 0x3ff;
-        vram_bit_write(s, posx, posy + s->vram_char_y++, false, size, val=
);
+        vram_bit_write(s, s->vram_char_y++, false, size, val);
         break;

     case VRAM_WRITE_INCR_X:
     case VRAM_WRITE_INCR_X2:
-        posx =3D (s->vram_pos >> 2) & 0x7ff;
-        posy =3D (s->vram_pos >> 13) & 0x3ff;
-        vram_bit_write(s, posx, posy + s->vram_char_y, true, size, val);
+        vram_bit_write(s, s->vram_char_y, true, size, val);
         break;

     case VRAM_IDX:
@@ -1156,8 +1157,7 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
 {
     ARTISTState *s =3D opaque;
     struct vram_buffer *buf;
-    int posy =3D (addr >> 11) & 0x3ff;
-    int posx =3D addr & 0x7ff;
+    unsigned int posy, posx;
     unsigned int offset;
     trace_artist_vram_write(size, addr, val);

@@ -1170,6 +1170,9 @@ static void artist_vram_write(void *opaque, hwaddr a=
ddr, uint64_t val,
     }

     buf =3D vram_write_buffer(s);
+    posy =3D ADDR_TO_Y(addr);
+    posx =3D ADDR_TO_X(addr);
+
     if (!buf->size) {
         return;
     }
@@ -1212,7 +1215,7 @@ static uint64_t artist_vram_read(void *opaque, hwadd=
r addr, unsigned size)
     ARTISTState *s =3D opaque;
     struct vram_buffer *buf;
     uint64_t val;
-    int posy, posx;
+    unsigned int posy, posx;

     if (s->cmap_bm_access) {
         buf =3D &s->vram_buffer[ARTIST_BUFFER_CMAP];
@@ -1229,8 +1232,8 @@ static uint64_t artist_vram_read(void *opaque, hwadd=
r addr, unsigned size)
         return 0;
     }

-    posy =3D (addr >> 13) & 0x3ff;
-    posx =3D (addr >> 2) & 0x7ff;
+    posy =3D ADDR_TO_Y(addr);
+    posx =3D ADDR_TO_X(addr);

     if (posy > buf->height || posx > buf->width) {
         return 0;
=2D-
2.21.3


