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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F277C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:39:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1F0AE206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:39:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="iBUs5QGH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F0AE206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k581D-0000cu-4Y
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:39:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46180)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nQ-0000wc-EC
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:00 -0400
Received: from mout.gmx.net ([212.227.15.15]:42589)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nN-0008FI-HH
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065886;
 bh=y9/0kXDAkWHkYY6NN8um6Z2aRXFPdGg7kDlpxDyaF8A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=iBUs5QGH1TKVWI61hjNiyZW/8UYDSHlRaUcULsxoMdffFvRnVv7ubnvZF3KfE9Wic
 Fmojmd4AVkMdJap949xUdQktD+JzdcYklTGWNO45tyOqY48a8rSuNop+qpMua2YxCL
 drJ9NSkxrM5e9kH1/uStwKF1Cv7251esIhZ7QR9c=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mj8qd-1kauIl18Mf-00f7sb; Mon, 10
 Aug 2020 15:24:46 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 04/12] hw/display/artist.c: fix out of bounds check
Date: Mon, 10 Aug 2020 15:24:33 +0200
Message-Id: <20200810132441.16551-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Bk8DEdfUxtHHGkT3v+o3irbZvNCt4NZ178lL+SCf8EF1Kkmwn8s
 tHKTZ2Te5zQiOzihqasD+z0WOUFQxB8+9KK59OU6wJPdHMBDY1zj5Hb2VpA9E6dduTvDgiP
 a781sMAOfFvWkLEOZOluD4O9B6KJJfv6mQ+x+piCEIpG1sxnArrCGDhnEAAZ05QGWOv40VH
 LdwMdLK+SuQV+bt+2P5NQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JXDMovOsgEI=:FBRVI8MfOX2N8WpB7EQHBf
 hg4fbL5vAYO8RCnkI5ExAfTgUIGnAXv8c+PHfhUGsGnZ7t0xAyTbGIhiMGguPcqdBQMuWEx1C
 k7MhF1kPfzqdc/TGqbAve+DghmAiNeVjG/r34szIEtFkmlnZqXrmz+XaebWuwZ7dZ9uxIFF0p
 DPd5VnML8f11kLhUu9gZyC0OMZcD/XFmq0zDYI4MCV16VRT2NuvotypULAgqlXFH5WvT/Rd4+
 mxpW44mhPlJ/s0q/YobF5o5PAutYnfWsLPqRpVphQGE5XwV8sXAkuWJ1s4wDZL5l/1ffVaeKu
 iUQbSMw29+c/03pAtJv8aHOFJ/+E5vLuSzkx2a4gjsTpYxwfOhvNj3x0X/LR5k1YCRe+sfHn9
 RUIDCu4dEQtLb2x1RrnkEcskv242c21rmvQSQDrU9kFDQsVNuIjKIT0pDMER2XqgN1QRKoKoo
 b5qMdlT4hJm52P80GARGnEQErXbUNVKX3eoEyQdOrC7JEr0/f8YXM/tHgykh3HvME2fqRemDz
 RVurJYB3dMpKx2xWG5clMEP2M/canAgvZBtmXqEMJ2lw7rP+9bbGmnOmd0f9qCGYdDLO69FI0
 tH+XKFNtd5jsfvU5xwGlQDDaV/fyoLG07mv/nqWfuppozhgZCeRe6xD0m3SU6YqsbavtaVpCs
 3wCZIWlbcafM7K2xvACfH9x0NWpebq8+AntSbEvDRxJCGH+JH8S4ORZQCYEie7hRjgb9TQPDo
 Nb8YJwPSHVoIEEHsrHexEzNsu2APH2iuosYHGSChCFtkB45qcyjqdjXu+KtCJqUWER5ArG01I
 BhRVifhjp24tDRkvT+wJ17r5xL3dLIGeOmjIDzebk+1LqriBfSsbHinfujfYIb1GH1wwcnbNA
 DBtDPofV3/HQ/+04KSj27gzBDv3NwtfEHq12NVfLxIuqmNHsfhgyz9pM9A70MACwSAx9RZLpm
 hcOZds/qOmzgdIFuEzkggfdpW5l/cUplXcF/JBMMgrLIW2haPtP2hjjg8HvX2Cjf13uuzqc1v
 VueT1B7ctrqflNFTbSMA9DpqkBIxoNZbUXNE3L0kY+ZmxmI0pfbcJrsHiRVFUvoA2g0cqhos0
 r3yUnOM1kors9JX8uaUeJwgCW2GMCUmzZ5zJCMlwGI06+hpUpDhLVrfy9kXpcGbjnZ4+IQD30
 76shxf0DaVipxaS/u/2QcXslwOd07aTcuRoVKUYY2sBZ4JaAi3VQtRuETxCZ5YnJhuNOTeeVH
 LIBdb16ls+OznG2Ud
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


