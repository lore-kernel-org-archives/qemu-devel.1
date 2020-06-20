Return-Path: <SRS0=xv8e=AB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4B80C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:06:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFDA62081A
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jun 2020 21:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFDA62081A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmkgk-0007qw-OA
	for qemu-devel@archiver.kernel.org; Sat, 20 Jun 2020 17:06:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53484)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmkfR-0005NG-AO
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:04:49 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:54115)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmkfO-0001mL-M1
 for qemu-devel@nongnu.org; Sat, 20 Jun 2020 17:04:48 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 9B0FE748DC8;
 Sat, 20 Jun 2020 23:04:33 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id E2C97748DDE; Sat, 20 Jun 2020 23:04:32 +0200 (CEST)
Message-Id: <f0b64bf047e343f8b2e91baeccb4753bc26b17cc.1592686588.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592686588.git.balaton@eik.bme.hu>
References: <cover.1592686588.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH v3 9/9] sm501: Fix and optimize overlap check
Date: Sat, 20 Jun 2020 22:56:28 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/20 17:04:33
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Sebastian Bauer <mail@sebastianbauer.info>,
 Magnus Damm <magnus.damm@gmail.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

When doing reverse blit we need to check if source and dest overlap
but it is not trivial due to possible different base and pitch of
source and dest. Do rectangle overlap if base and pitch match,
otherwise just check if memory area containing the rects overlaps so
rects could possibly overlap.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/sm501.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/hw/display/sm501.c b/hw/display/sm501.c
index 2db347dcbc..e7c69bf7fd 100644
--- a/hw/display/sm501.c
+++ b/hw/display/sm501.c
@@ -690,6 +690,7 @@ static void sm501_2d_operation(SM501State *s)
     unsigned int dst_pitch = (s->twoD_pitch >> 16) & 0x1FFF;
     int crt = (s->dc_crt_control & SM501_DC_CRT_CONTROL_SEL) ? 1 : 0;
     int fb_len = get_width(s, crt) * get_height(s, crt) * get_bpp(s, crt);
+    bool overlap = false;
 
     if ((s->twoD_stretch >> 16) & 0xF) {
         qemu_log_mask(LOG_UNIMP, "sm501: only XY addressing is supported.\n");
@@ -784,16 +785,21 @@ static void sm501_2d_operation(SM501State *s)
                          ldn_he_p(&s->local_mem[src_base + si], bypp));
                 break;
             }
-            /* Check for overlaps, this could be made more exact */
-            uint32_t sb, se, db, de;
-            sb = src_base + src_x + src_y * (width + src_pitch);
-            se = sb + width + height * (width + src_pitch);
-            db = dst_base + dst_x + dst_y * (width + dst_pitch);
-            de = db + width + height * (width + dst_pitch);
-            if (rtl && ((db >= sb && db <= se) || (de >= sb && de <= se))) {
-                /* regions may overlap: copy via temporary */
-                int llb = width * bypp;
-                int tmp_stride = DIV_ROUND_UP(llb, sizeof(uint32_t));
+            /* If reverse blit do simple check for overlaps */
+            if (rtl && src_base == dst_base && src_pitch == dst_pitch) {
+                overlap = (src_x < dst_x + width && src_x + width > dst_x &&
+                           src_y < dst_y + height && src_y + height > dst_y);
+            } else if (rtl) {
+                unsigned int sb, se, db, de;
+                sb = src_base + (src_x + src_y * src_pitch) * bypp;
+                se = sb + (width + height * src_pitch) * bypp;
+                db = dst_base + (dst_x + dst_y * dst_pitch) * bypp;
+                de = db + (width + height * dst_pitch) * bypp;
+                overlap = (db >= sb && db <= se) || (de >= sb && de <= se);
+            }
+            if (overlap) {
+                /* pixman can't do reverse blit: copy via temporary */
+                int tmp_stride = DIV_ROUND_UP(width * bypp, sizeof(uint32_t));
                 uint32_t *tmp = tmp_buf;
 
                 if (tmp_stride * sizeof(uint32_t) * height > sizeof(tmp_buf)) {
-- 
2.21.3


