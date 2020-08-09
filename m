Return-Path: <SRS0=L55N=BT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA75C433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DFDAA206C3
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:32:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="JRYkPuaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDAA206C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55076 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4dwl-00034w-VR
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:32:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37836)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dos-0006ES-B4
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:47543)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4doq-0002p1-4g
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950646;
 bh=yi/ZvGbDbrIWKgg46+4OlOrFcTrRqKN6hBd0HkJl3lk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JRYkPuaD2t7dqG4ecFr2GYHv5M9M2WS1/tOY1ow8INwa2mh1Uuw9BQO/uM8nJo06b
 QoUy+N9xduUPzVneZkQWnLdi3FBxeQpSzM8W3GleUe/wHjzie0gjdx56ozB9qnSsjD
 SlQLo8ekVA+usV/jJX9TaXhMg10StdCccnu6bEMc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1k4doU1BSK-0004lI; Sun, 09
 Aug 2020 07:24:06 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 06/12] hw/display/artist: Check offset in draw_line to
 avoid buffer over-run
Date: Sun,  9 Aug 2020 07:23:56 +0200
Message-Id: <20200809052402.31641-7-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VZ0dI0PCpQDgStnc0PZaNLSTTXlOddNN6t773ICTQSqad9c7XB+
 wjAZdQYIkH3mkAHsbqHIkmwD19WUR3qb3zLuk4Wc3lLD/BpHBXEfSCNTs3LLfAEk3MLC2E5
 u/WzKxImw58kXO5Spb3CHoE/2QmWsXvIDpmXvQggEX8AlNMZCsaUgupfPt5YBcQZHu45bM1
 OF6jcerbc9AlmD5Iw75ww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/Z98zWAS98o=:HE0fPEW+L7ljsN3KYaJ/DS
 0qfk+VKtrLsH8WEe1hH0VXHKsulrPWoa9SJvNsYdW6LzFMDEFTm7MhkrC3r3ceWWpAlwugLMc
 onpnbnA7njZZLguyQKzAzVyJsXKUkPyyVGy3ubbNSFMlvHL09RB8OB9uqrxpa+TTwQlQzPfvF
 EECL5PNxiDbeZRaM0euPkHtpPFz/iQqRAAwd7RrgrLNzyG/VDLvb+l0BO5X6MY+R+PXhPfp1W
 teS+0y0kWIyKGuQBRsCAZLrM0RWv7Ayf02WBaolJrF+34s+WAXIu3z6WnpjL1W/5PdoB+Fv0e
 4lW7NM+dOEtfH+TjVVCAaSS3T3Y8JYRf1YAMCM14tD0VecYOvJ30A1ebkrgZAxAnBnNXqs9Mx
 oQXMcxqCAdqfbz5BiLuhGvIczgnD+dGClMYuylM4gVx7/DtIuaoJJMBGOuPghvm4+v2JcmWdS
 Sk99GcCzBj6UgZCpCk/IRk1O76o1NfZ40sWtZOlmDJp6O2iq9rDejKsP3uTM2aSOOoPSiFZ39
 tSqz1npNEqbpabdj3FAmzO0bbOz9P2KWRutQbh/1fPywOm9mbThRMHM8Km87T+PSXtKgrJRCx
 DYdPyIuk0zccg8kEQWm94/CyBrkDfBF/DcRZCap+xjBraAQfUuHwco2ddtjo6oin1CKhZIDj2
 CWRmnGJbSeBQg7RkeQ3beNPjc5LJszA3ISi2cAJWdaOKbJyD4sEnY+fCO35dUcbxyMERyQHuX
 dLx81jh0bLIvyIXcN0N96vMQIFsfaDTlm4UyhZOnZ9nQXfwd1O+Ebip/bqwjaWHbdCDJErjrm
 O3+tHVIprntbLywvqHmUJ4vmNMwQtIVkwzCvnrRtVdMztcQoLcwlHSUt46+6GM3Z5v7BAQM7c
 jkVTCBJYWyq606qFrLO163Abg0U98bzFjYzxwfgyH49c5VMpb3N3LuxQHF2cbeplzMB/symzW
 +yBFUYY2Hk9gni9aOWM1QSyC+bdSyzQ+4lrlxEpZl3BmuuFyKti3k0tYGQLvl7Jy+9PzVJqcC
 l7dO7xuYN5DdLBWTXJ7gF10Xvt00ejNz+FllrF+3GFt9/L409Je056y4C89goEPejILqyzOA8
 d0qsuB0NRW59vhqL0hmAWzcqsKozJUDfm+Ub+TLZW9SEd9ylan5fEE1N5BaI3UNl4iuyWIviq
 l5jTsJYiwptynF5oaAc79DZ46CSuaYPAQmIWdGkIzEAcjxMe5WOoQNkuwhJ/pC9O2AC//tV40
 M03vHuXgyI/MklEcY
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:24:27
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


