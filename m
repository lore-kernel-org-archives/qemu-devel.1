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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4774C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:06:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 79257208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:06:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FD9sHxKp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79257208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xaC-0003Xv-HA
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:06:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVQ-0000qI-NO
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:28 -0400
Received: from mout.gmx.net ([212.227.15.15]:34825)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVO-00039L-Mv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596549659;
 bh=y9/0kXDAkWHkYY6NN8um6Z2aRXFPdGg7kDlpxDyaF8A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=FD9sHxKpybhF6JzY0tAiS7lFioMC7iwyDzs8/0SihmNV5IYsjzlZdXID3KPaCgzj5
 Xe2keQdrOPpL2ooqEt79N8+vlVwXb4BLb2NorACcEdda4ISXCI++C1EBGDBQx57QFx
 BRCul3AzwuOFzB11EgQ28AhXQGz0VRWncTdtKC10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5fMe-1k5iNd2Fas-007B6l; Tue, 04
 Aug 2020 16:00:59 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 4/8] hw/display/artist.c: fix out of bounds check
Date: Tue,  4 Aug 2020 16:00:52 +0200
Message-Id: <20200804140056.7690-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804140056.7690-1-deller@gmx.de>
References: <20200804140056.7690-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xxkvc81/3YA1k8mzHxwz97o/FeuTD5eQ3lPnvUIHF6TIOcuh86R
 tN1VlCTnPBAyWdK8s61b1h/EoExnS7XLlawqhJPEKbM5yjcBxB4tpy61NVcmXrkIqmm+8HS
 /YKqvkeDoohps3HVlPPwtOyb0hLPMYPT97TjjpOuNGpJx28agOg/UM9R1Abiw3/960MvCpG
 V2UhDiD8oB9IeCQGT3deA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:llVXWnup/xQ=:NPf8Cv/VzrbB+gMcM+Pp7X
 4EIztvpa0MvhZm26GOxGUzJwItXhVPIGc9YOvWwyqOo+L+sb/ZXwFNCGHLvVMnKz51UGHSyMD
 cFJoFbq1CR6UpzXcNzq4hlp+xkrfNrvXXUU6CaVb36W8GJgvdODBi8GCWD35Muh6h9LTuLZij
 /9UA8x+L9PzUPUlrMt15X9RVrfsuCZldvB9str316BIGftuKU7c3qHHk0cjQZxzDqwL0n2dJl
 EzLWea+baBWjXxIuD2fOZOBmgzVuLLCqM3bMLg9ieLWJUa2BnL9PKelDgiUizxQ1wHGpBjqCd
 iFaKvvhOv3Zr43iobPgtFz/U0BnTFmyCqkoT5alhPHLQ7W1z+poqGXrbT5v+VNw3FYGYp0HEN
 mnYQJ6Uvan+J9a1wIfCPpiOkQSaRVhOy7O3FKv/10P0OwouORL6QONSKtFDcYnzF/AYnUzn79
 zjKTGC3wgMRewoBCf6MJpez7SjkSsswrZLgow33URzcFnThazGvxVnrvOu43JK0KjOsJO5pGx
 t+av600VNAqXGU7+IS2W4ql8Gdyw4MQ0bLajyaa9eLQQL7xxMKJDTLl5sofIQNi+CY9hCY+Rz
 jwcZLpYwx4N7QJDlOZekQlgw7mPpKYpuUhoiyjvNv4DrFAkWbnCmsjqPnt+6tiF6wM7okdsnD
 4LJILGhpV5bGfo8P+tmNJ78mA2psKf50A8QoltRFpDNBJxvOCk5SB0Vr4YqKMgcDWep7Za9Y7
 2Vofm3oM4FaHSNW7ke592JJiHYupZ6LGxmQGWDUJjMj5D3ces2QQelmrmXHAY5PdfBvciWC9M
 qCvIUgcRrSSJVdw0rHgLGnfDYXm9jzBrTeot64V3AteigZvoS2rpWpw3u2P6XrGT5hC8g+IDD
 h05w7OPKZHBzEj1ypPAmpwHCinNFBUutlxEkYFmUTSJ8GbzLqAm+urBsFOoQbSFMDZX+j+Qjr
 w8r7rNLh7XBvfwAsryHVNMEC3YYrEN4jRFFmUi/4BQTuP53W1QjtX3fo+WdDOTRBfkKn4hz9E
 3poYAUOpqVHeOoxjQL0FtSB9k2DewMBldSLuFypXUowXee+pPryh5+m1nGVX31/qChv7EA4HT
 L7Fo+Lo0v8DjCtp1nvfdnshYKyyFINLiyJgFK29sIq5ryaND8NTs/kJms293VIFK0MI1yPS6n
 quLjwB2WSmoLBINdwlXkUOmrG1q/1+IkenwMGqVEBnR20L99ETCJLv4N10oJjX2PaD6S3uo9h
 1DCLd3sNk21lEP0g2
Received-SPF: pass client-ip=212.227.15.15; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 08:28:01
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


