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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC32C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:26:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3128B208A9
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 14:26:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Y+fI5Rl8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3128B208A9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2xtc-0000Z2-8T
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 10:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40570)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVV-0000v3-Qd
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:52565)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k2xVT-0003Ao-MU
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 10:01:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596549660;
 bh=yi/ZvGbDbrIWKgg46+4OlOrFcTrRqKN6hBd0HkJl3lk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=Y+fI5Rl87pyQCVEWX2znhKFXA2Czc1AwdTpS4EOoI6TDyUJdTvlioC+h+lseVxXrM
 H4kUrCMuJGYKJ5L/9foPgJkai4ee4cMMMtXS8dDPcd2EE/TP9vZTVJcR4OS6eOwBNx
 8Q3mjy4noyvx0ExpbilG5LWJFqICAIIH9IbgRy10=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.144.148]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M5QF5-1k3myk3Xlt-001NXs; Tue, 04
 Aug 2020 16:00:59 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v3 6/8] hw/display/artist: Check offset in draw_line to avoid
 buffer over-run
Date: Tue,  4 Aug 2020 16:00:54 +0200
Message-Id: <20200804140056.7690-7-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200804140056.7690-1-deller@gmx.de>
References: <20200804140056.7690-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3RUhxfg8BVSAOOK7oGVqe8lfZ5ETiQvbvhUzD60aTvUziIpFNXk
 /dcpHuBqQhg8TC7i4bgJ1gTkHFWzWK/WdDH4DSRgw8MRb20to3J+CYdwXT5u+waiVb5UcR8
 akHhwg9AYFQyKfZ/D9f1YU+NBH+tAsKTgfCo0iu7cT7d7OPJOSouaSI3u63rE+ZPOoGbf90
 hx3yCOpFEZ2Kp3zsy06gg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:SMXB6POInEM=:v9NJrjwUvyj2r5uqNGyYvE
 rIkRuuZ6A198aOO74Dv6UnGLtaiWmOVdkty7WmPYMVOzEVelHO2gdo/y3biO+KXMe+lEvnWRj
 OxehxdqnCCjrLT5aW9dnCdk1y12r4mU4re82DEgHVzXKNGy57N3YUz+mp1twj7bGTj0QhnlOC
 xKKuQuO+XZZ3w7fpXZtWEOAAdp8FqwfskoeaXE+G1nWELCxo3BETy09mOR+CQ3qwtgDQqhgVM
 yI6JG7QFjDbDTmmnQxfpBe80Ivwwueuqj8zkIBfmEqnsmWZHvsu4o8c54NAp9UwX+WW6CZzAk
 EEmie2kzF1/+ObEkrhzWzYHFyDhI2SiWZiOJg8luncwF6E+WPEqv6cGKgrozUeTWonxqKNilh
 mPa1v/uIPi6uSAk73zQOP5+gIPzP92oH5Yf5OdxvBkkvz2yebGVr7k8+SigllvndgG/N4jzx9
 6qGKeG4g0zT8KcUJOO/wwWyjTmVsDu2cef91tbbKcS3Q70XWjSMXjs+ODOAczfyzHtGkpf5oe
 ziIL8IV8GOWSbYiozqtRTi/jw48n/1oQOXYW/7l9uRZ1ptFcycKTX7+w4832MZvK56GNk0wlS
 2PzVjBg3qi2flkcg86nN6OWfOOVDTvxWyQNpzUNEo/QP0RIG8DEqu5YgGEY9XrRw4lnLwV9P5
 7V2SARb1VD+wF6bO1tw3htA93nfbkMNH53LRn6c2HAInTMHwTXXBQks1MC88B/jjXas2bz2gq
 sZ6Ftm3q9W/NyjGlU87QsblFNWIS+6Q6TmYmEa6WK9XYJxqZAi3DwztDeBTS7gCmkXNqtGtnO
 jnu02IN+9NBlR7nLBytlkCwrQ4xiLRDmZTotW+I6KotFFKQR3dqE0Yjus0fhVr0ziXNHKNcSF
 TEX9+40wmFGsnZAUMsYwfk1Hm00X8Lu5hl/6EA0TL9WKIHb2S+HIrJlxw9ImdEhbRuWrCpyR6
 +lKYoVl/HNp61AAJJM3guz8lrAgR321/C5KyXZNHbMWPTY/opbWpkBI6tYVa1qfT8eBeVIvXL
 gFPQua1HM8DbtYBUyglqY5UHuaqG4iCj3HgYPcHyV3YXgfsRDluQnhaS7cKW1FtNgfGBVwbZc
 g5FRXfRa409Lw026dXCATAQlDu2zbL7GSJ62TKZwCP+bZsiZiAeuLQQ093fkHtNZPwLfFcGTK
 KBqJTn0Q2ItOlcFSkPHBnIhk95dEPsM4YAk8aHeg5sChim23n6uSIs9d8Ygm/1tt8/rTK7n6b
 47Z3KquaA0mjiRmM8
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/04 10:01:30
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


