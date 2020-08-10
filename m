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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221A5C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:39:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1022206E9
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2020 13:39:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="HUHCKXgR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1022206E9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58174 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k581E-0000e5-V0
	for qemu-devel@archiver.kernel.org; Mon, 10 Aug 2020 09:39:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nf-00010w-FV
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:15 -0400
Received: from mout.gmx.net ([212.227.15.15]:59221)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k57nd-0008Gp-BW
 for qemu-devel@nongnu.org; Mon, 10 Aug 2020 09:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1597065886;
 bh=yi/ZvGbDbrIWKgg46+4OlOrFcTrRqKN6hBd0HkJl3lk=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=HUHCKXgRdSa+imSJ3Lgh2FRZbmqaocN8r0oYQJY/NPT5Oko171yqWRno5qL7Q0dfA
 Qpgr5aqSTS6HEclHo2iJ3+OvA2lvm3aRJ5dh41sS+Fb070CKpL0V+xUCh9jKw2aE5i
 sU1pfFdpDBpZS5M84cJF1UU6FSsB/4pE3X2kbz8g=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.174.37]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MJE6L-1kP7W12eiJ-00Khut; Mon, 10
 Aug 2020 15:24:46 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PULL v2 06/12] hw/display/artist: Check offset in draw_line to avoid
 buffer over-run
Date: Mon, 10 Aug 2020 15:24:35 +0200
Message-Id: <20200810132441.16551-7-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200810132441.16551-1-deller@gmx.de>
References: <20200810132441.16551-1-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3GKF/FZrMDQ70PKgV+veTcMUezCbI4C4/rIyut5g7/QAA7fuA86
 IsJU2qyk4v7VhfCpuz5B/PDjQGBdMbb83Pv2wUNEnF6UIa6QJQIDQ64vA2EbrK1P3WNvpMC
 PTNTsYP9yUw6zsYsz3MaA5wUMT4c3IlylWz4U0NgPT8V7cb4DbzqMJir/c+tLslfek51gAg
 JgBdT1Uiw/M7bUUjdFxYQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3XUKvdk5Uwk=:3A9AFBPCiKIcNlgnriqTBF
 66OSodLdw1m+lxQvgVE+yMBkSdc0/qfKUMzdG707xoNuWdg74DhnO/BEEyxPWjXtTOUU6/0pP
 7UEVUDxfpF/9tp9hKLhO2JhYwjZEuzTVkcsPw/XvifGIIbivEuEr1p56rDlE1uHBiGpqLPUSd
 X3kMeoTan3301p2S1VxZUnPrGmB2z34ATYJo/JynJpFJOPaEncop9ww+35b4dzEQpsk7pgGU1
 rwEqDXhs1C8Dfx/rDu2Ncpto/EGYUDBzoxfVXpZRhzRx4g2YZiwvg0ncKz9647UNBec+IAvoZ
 RhHTi9ZK1sA1sbpbCxq3snb1Ada7Ba7uGjJ/vS60cWSkndx7q3I+QKqpx7KRaQFAgTnTg05o5
 dMQz4JYCo4uEoL3L71tsprzgoNSMg3IaOJBovF7Tl/PZQOhkOjOzQqflBVcNoUmnmWeeI+MFf
 u2y/mM+FVdNFGGaY4gaUeL44eGvJaM8OBDaFKOdgD6QyCJDrMyZ01b6lyz+yWv4aIujsZJgAW
 wISulUa81xToIfl9TDhT/VfUEpNeD7CPqx7h3uSpsgMgbNxT6JqH9EM9g71rwM6W73G3X9DJy
 hRJ3ij2t6OsXCaoyWDB+eAPZzpVWtkjEq+1lnHC28YgkFjd1odgyZv+IGIrDlvrxs7RnDdp2R
 vT9jeexohITma1cvCTFs75PJpT19RKGfHStrJ8LLCiBFo4Vm3Hpz7FWEs7ynyBlkNbm4wZj4v
 sF3TJKHSe1OV9wWiLoRc5mxznYkFv3LprhaUtL3P/51U7tft5sq7vE6z8f+cXkp90Bmw8K8z0
 f3fSrbHm9ut6Gzlqk+xeTGXtinXnON3wLhsAjM87naE5ZLvtTv3xAJtfrIyw0pCxLBlFmZKl/
 ZAq2peWwWuv4MhZZLhMg4nUh2Q5pX1n7/9lE8Q7mQh/q7/7d096oR5JuA7i1eLL0nn1tDi6HU
 EEnYa4C9/g81ePwLd//uApa+m4E7YyphRbMzpXyZ8yG04JjBiMd1pVBS2UesX/aRgli2vSsT2
 jbNgPnWANqCfzwTCE8YkofR2bJ2f5YTFXLJFquSXeiMKBQcEjRwZKqO5KSFKVC1DqMTTFKLTw
 nZSoJJc3heYnZGcc6EHfaNxJRRcQSwdYTXwvPk0ZeJTdpRGzOF+qstsx2xzG24FMUzihg4uC7
 angGz5dqft2lY5CoBSvIiwbogJjjjTpnkWrkBNL3uiaSEAW63JH5eCXBStU4+qwhlYFs2kvIj
 hp53nBg54M3EJbaKB
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


