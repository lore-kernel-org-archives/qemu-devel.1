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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 861F0C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:24:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D3AC20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 21:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="lD+Obou9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D3AC20737
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37222 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB2tm-0005dC-8d
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 17:24:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35320)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k9-0008R4-V1
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:05 -0400
Received: from mout.gmx.net ([212.227.17.21]:48933)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1kB2k4-0002Vh-D2
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 17:14:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1598476430;
 bh=yi/ZvGbDbrIWKgg46+4OlOrFcTrRqKN6hBd0HkJl3lk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lD+Obou9dgM78uYPyFhvtU20D3F910URQ1hRk/Pk00EN1zxSJaZZv1zv/pm9Lc8Od
 JxXDFWOcLK/GxAqVj7G7vPSl+PJrxk/NeTR1/CbyrH9s/VQI7su8P1tivbnNJ25saj
 tTK/l+HYGmMxdSe+k7uFjNBBG2NH+0hc3ICqp/pY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.186.77]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mirng-1knOEU1qJo-00etNX; Wed, 26
 Aug 2020 23:13:50 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v5 06/12] hw/display/artist: Check offset in draw_line to avoid
 buffer over-run
Date: Wed, 26 Aug 2020 23:13:39 +0200
Message-Id: <20200826211345.14295-7-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200826211345.14295-1-deller@gmx.de>
References: <20200826211345.14295-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3BX/k/m9DiLy0krgzyvVx+tmnvMqKnTXB2++vxhDWiWURsNv/Dx
 xM07gXS3cw5rTmZK6uEJ6uRIIslANWdA6rI4bgGDdmpLxSpAvNcfdLMyUd075pgORDoE7xa
 /fUMqeFYoh9V3j7oSqNw7S9MHmaUElCFk2Idc8hcOs3Y7FwKNaJrrNkMb7wjl62wYu4uwgW
 buAwM5YIihpaU9dXGqSgA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jjLw4FqLnV4=:NPo750Jp+QkRIZ9Geo8+WA
 nIY4pv10QSy0NyEDLl9aOPU7vTxYTJPJZmFktWEMuEKUE8BTup+/ZLfr9PCVQK8qdjjcOhJSi
 9MpL2x1bAc4KktbyxLUND4UvbC42/HsuDe4vELYnZrKUSvbR7q+ObN+/HXvjryauVOEYKgy1e
 NvkfjvdYmIhwu87c4whUme4+zNn138IbR4/JNokjJfaPgyXdtlEejuXCtlZkTPkUKYtBhR96n
 7K/rw/zvw8VFGmSfDlxLECUgGUeHyUE72wAB67YhaMibkmmgO24l7owlSa9w/PfVg3fykPfoG
 lZWde1XB/FtKm6cDmMgFLwnG1w5Lrg3Fba2nzdReTLORN7ETxifWRF3HdZG5osv0QNDyLeEk5
 18IswpQsGeS3pVLVuZhbeL/M+4ngYi18hGaqLhAZBKyHKEpcmCWhNZx3kTOeTHr/2L3R67Yyv
 o9RPoiAq/59d+M4T1sKlL25CDXikmZc56mr2RVsl6dhnJJDm2yRWaR/7ruROhopV3cQbxTvAq
 xm3M3x7sgvFQ1Hxf0MQxAIM84BlNjSPDlVSWsTnb8efX5AqYal2W/YcQp+RfDrW3CW1w7lPd8
 m6xDFEDwC3Zb/lXqXRWLf3PIl50uTeFIo1Wg6AThKoyzoLtS+Df+2NvnvafSTEyZI/xwHkQhI
 kVqUf/m+zk3gFgnlu1o7TiRhkbOdU86OiQdGID0/rdzBrzXB+ujurvgvBK3hUybTd6Sg7Phul
 OZvT2rlQ4qv9GldZwNg+idmVf/jDGmapAi/Xt2OmrU80Ksc0Z33Z0ACVo53kS7osooxqDKXSS
 0Y215+x1d0R2m4d76aAqMya8c31OHQarIzigsD60H0ojwHl/1F5RcTr9CtEtzThkt+SftktAN
 n8pcNgifElUaR3Kk7ceL4NefTIB25vtlQUmKtR3uDqdJ/h5cPMvLdVR9ylmSkdPriu5NTUlIB
 7eNXXs2HwMwzWsjiEP/vjwP/F+/l/wASdWTD5tUSGDS+H40XMrvJjWFTlbLe+r4t1X20qqZpC
 FCwMTQFADYkj5rpRoWxY2qUylHdS56a10pUdsR+MelajtXg6Vx6+QvOy02ptaY+RpPPqOLm+U
 E2bhFiwxDGRtWYqa5PhU4lvhVOf1MbBpIHafvrueMyv/u2eRTeM4VaFtCDGPJaiQSq2QU6aX1
 jibCVfhNFWs3z0JpLkzAu1FDIsOxDde+kip1NPDcLy+Zw+InDzGY7Ngc0itgAx46q6PQ8H6EN
 +coMq5Bd6ec9p25VD
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

We avoid:

  Program terminated with signal SIGSEGV, Segmentation fault.
  284             *dst &=3D ~plane_mask;
  (gdb) bt
  #0  0x000055d5dccdc5c0 in artist_rop8 (s=3D0x55d5defee510, dst=3D0x7f8e8=
4ed8216 <error: Cannot access memory at address 0x7f8e84ed8216>, val=3D0 '=
\000') at hw/display/artist.c:284
  #1  0x000055d5dccdcf83 in fill_window (s=3D0x55d5defee510, startx=3D22, =
starty=3D5674, width=3D65, height=3D5697) at hw/display/artist.c:551
  #2  0x000055d5dccddfb9 in artist_reg_write (opaque=3D0x55d5defee510, add=
r=3D1051140, val=3D4265537, size=3D4) at hw/display/artist.c:902
  #3  0x000055d5dcb42a7c in memory_region_write_accessor (mr=3D0x55d5defee=
a10, addr=3D1051140, value=3D0x7ffe57db08c8, size=3D4, shift=3D0, mask=3D4=
294967295, attrs=3D...) at memory.c:483

Reported-by: LLVM libFuzzer
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Helge Deller <deller@gmx.de>
=2D--
 hw/display/artist.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/hw/display/artist.c b/hw/display/artist.c
index de56200dbf..a206afe641 100644
=2D-- a/hw/display/artist.c
+++ b/hw/display/artist.c
@@ -555,7 +555,7 @@ static void fill_window(ARTISTState *s, int startx, in=
t starty,
 static void draw_line(ARTISTState *s, int x1, int y1, int x2, int y2,
                       bool update_start, int skip_pix, int max_pix)
 {
-    struct vram_buffer *buf;
+    struct vram_buffer *buf =3D &s->vram_buffer[ARTIST_BUFFER_AP];
     uint8_t color;
     int dx, dy, t, e, x, y, incy, diago, horiz;
     bool c1;
@@ -563,6 +563,12 @@ static void draw_line(ARTISTState *s, int x1, int y1,=
 int x2, int y2,

     trace_artist_draw_line(x1, y1, x2, y2);

+    if (x1 * y1 >=3D buf->size || x2 * y2 >=3D buf->size) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "draw_line (%d,%d) (%d,%d)\n", x1, y1, x2, y2);
+        return;
+    }
+
     if (update_start) {
         s->vram_start =3D (x2 << 16) | y2;
     }
@@ -620,7 +626,6 @@ static void draw_line(ARTISTState *s, int x1, int y1, =
int x2, int y2,
     x =3D x1;
     y =3D y1;
     color =3D artist_get_color(s);
-    buf =3D &s->vram_buffer[ARTIST_BUFFER_AP];

     do {
         if (c1) {
=2D-
2.21.3


