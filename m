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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C180DC433E0
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:35:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4FB20729
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Aug 2020 05:35:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="WQpov7z2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4FB20729
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59312 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k4dzg-0005Uy-Mb
	for qemu-devel@archiver.kernel.org; Sun, 09 Aug 2020 01:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37946)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp6-0006Nx-VH
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:44 -0400
Received: from mout.gmx.net ([212.227.17.20]:35413)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1k4dp1-0002r5-B2
 for qemu-devel@nongnu.org; Sun, 09 Aug 2020 01:24:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
 s=badeba3b8450; t=1596950646;
 bh=y9/0kXDAkWHkYY6NN8um6Z2aRXFPdGg7kDlpxDyaF8A=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WQpov7z2Us2Qb9qD4MRsCllLnXwsvwt+rlio5Oq34CHgCfhaul1uS5lBuD/BATOVb
 lqQuboCsGciAFL6rgiE0gqUrAz8RpRzAOqbdAZQY3uVT1S8D9u/vfB3YEROZnjyogm
 mEe4F5i62oLdWwgFLThVPFer/ZDA8DhRsGXadNYo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from ls3530.fritz.box ([92.116.185.161]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1McH5Q-1kaOjJ3nn2-00ciMq; Sun, 09
 Aug 2020 07:24:05 +0200
From: Helge Deller <deller@gmx.de>
To: peter.maydell@linaro.org,
	qemu-devel@nongnu.org
Subject: [PATCH v4 04/12] hw/display/artist.c: fix out of bounds check
Date: Sun,  9 Aug 2020 07:23:54 +0200
Message-Id: <20200809052402.31641-5-deller@gmx.de>
X-Mailer: git-send-email 2.21.3
In-Reply-To: <20200809052402.31641-1-deller@gmx.de>
References: <20200809052402.31641-1-deller@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:3c92bI+CktRAAFPxY2RQTjjZAyxwkJ9DyAg7Y6ORw5UlX+KY5+R
 Y/cjPALRetnKbNy/0ho5CMxbXVvXWcJkvBeXDhZQX7q/NNhu8jCfCDLNchWi+ax9hvJSHXP
 L7fnRqENLnDCqlFbh3xlNdIOy9tlil+NWhr/mTWjIrhV4ac9IdLNJ+M0gut7Kt+Wc9V1kM4
 MVWp/blrQKzckLIJe0nrw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7kJPakGR2Q8=:L3RRXgZGxV+c09MCYuH295
 zVXa983wpKNrUSyjh0fXbTyx91IXWlOt0DHITRufGi/2qc7A4HgMbXPodzzcfCMTgkIdesT8v
 5IJQAT4wFLpazTeVsLE3nk0gIjeTlgDNk4ElqbV5GeX/MqMZTS5+phvYma15W36qdXwcvvwlf
 Ncd8ix0uUY7qs+DuMaFqpdtECufwTGT2qH+77j+VMbM2zpjDbMJURtWwZ51bIuAMDjQSbpTAl
 RlAuCG8sb/1gGRhkVmMrHkanviVuvRHIoTpaNHRb61i3VwkgzD+eV6Nr40MuawlXOil+AzjoL
 x2TIlMj/aN2JeU7cREzeSJkqgQzLQ6WSTDoYQNkAmUhyCHBiKuDh5/+HRWixT8JBInj5xVLaN
 Wb8QyM9mrXVG0NoqfLoO/mxYkmriI7aLaer0aclyR6NtlaJtCXUO4QeSOgFX0Gxlm1WL0VDQc
 RpiQ9zvgZS4XUwvq0UGPiueQEayp+loZEcIVRflvK0AnB+PjmaIu3Y7pOLN9p+0pETdAFPSsb
 JMQBuNJbQvxavmaDqsPnmJA3IfAOLnEtjrWIiTh4zi7kZnSqRbDqzzcrH56yD/2KuWVE0ovkF
 Lrvl29iuBsdYKxfJxLOUmSNN043gedXvymOUMochJzDmHCos66biFIgb3TbbaDoHGp6y3ykVN
 11dm/uj7/KAsSEj5jmwnIi8utdY40M0wpW+xioijVcItagRqXcWLcPaedABFGL6ckL+xyOy7/
 5VsWaqkneAQmYrHoWvt1KcgBxsWU0Im00QYJPLDF0J7Q3mLLdidm3xbyZjDDKKxgf//3gP7gZ
 0dTCv+popivD0g6/8xaJX7k7XIi/EeswNxc/Al0i1IFuXVswId1Ikc0dWAGBeDDy00FUJVGoq
 JslqdMTJWm9ldYIHBuipea+STVXApqL7Zo1AgR+TNmqPsS5uuKOqt+IVt0IWNrt3fcIBqpEHE
 9U76iKp4fUKIYuKaNUkbXNFXFPccAdB0NAgtQ/M6VvijfkL6bzQdXHGUDe7Ely7hxjcDqXfhu
 ES+JxkXcWCI0nsEVluG2/j7V9mfew1tXpebh8s4yHKgjqQnXFJJbiD45sIj1V8n3s4TDGNA3N
 vZfLhD0rTbQ5jwRxXMdtwUZQxr7n+3gQ/uRLUhLmGjfahWIYyWwUjCM3H7MvD7DhDVkJp79h2
 mVS8Gk3eoEySAKtm8ZfWkDL/MuYruI87GXyg3pM/lNtjXEhGC8Mqrlpq44kSJ/TylnRyQT+w7
 cdFCZTNZODJiuJYod
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/09 01:24:22
X-ACL-Warn: Detected OS   = Linux 3.11 and newer
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


