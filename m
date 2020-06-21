Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63E56C433E2
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:18:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C42D24834
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 11:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C42D24834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmxzn-0002su-Fk
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 07:18:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34402)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmxyp-0001UD-89
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:17:43 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:36619)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1jmxym-0007hP-JL
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 07:17:42 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id E684E74633D;
 Sun, 21 Jun 2020 13:17:37 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 65EF974632C; Sun, 21 Jun 2020 13:17:37 +0200 (CEST)
Message-Id: <ba1d5ba97f246e8807f86f1243c2bdc6497dc8f2.1592737958.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1592737958.git.balaton@eik.bme.hu>
References: <cover.1592737958.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Subject: [PATCH 1/3] ati-vga: Support unaligned access to hardware cursor
 registers
Date: Sun, 21 Jun 2020 13:12:38 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: qemu-devel@nongnu.org
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/21 07:17:37
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This fixes horizontal mouse movement and pointer color with MacOS that
writes these registers with access size less than 4 so previously only
the last portion of access was effective overwriting previous partial
writes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c | 87 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 58 insertions(+), 29 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index d45127a976..21ae36c535 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -389,22 +389,28 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case 0xf00 ... 0xfff:
         val = pci_default_read_config(&s->dev, addr - 0xf00, size);
         break;
-    case CUR_OFFSET:
-        val = s->regs.cur_offset;
-        break;
-    case CUR_HORZ_VERT_POSN:
-        val = s->regs.cur_hv_pos;
-        val |= s->regs.cur_offset & BIT(31);
+    case CUR_OFFSET ... CUR_OFFSET + 3:
+        val = ati_reg_read_offs(s->regs.cur_offset, addr - CUR_OFFSET, size);
+        break;
+    case CUR_HORZ_VERT_POSN ... CUR_HORZ_VERT_POSN + 3:
+        val = ati_reg_read_offs(s->regs.cur_hv_pos,
+                                addr - CUR_HORZ_VERT_POSN, size);
+        if (addr + size > CUR_HORZ_VERT_POSN + 3) {
+            val |= (s->regs.cur_offset & BIT(31)) >> (4 - size);
+        }
         break;
-    case CUR_HORZ_VERT_OFF:
-        val = s->regs.cur_hv_offs;
-        val |= s->regs.cur_offset & BIT(31);
+    case CUR_HORZ_VERT_OFF ... CUR_HORZ_VERT_OFF + 3:
+        val = ati_reg_read_offs(s->regs.cur_hv_offs,
+                                addr - CUR_HORZ_VERT_OFF, size);
+        if (addr + size > CUR_HORZ_VERT_OFF + 3) {
+            val |= (s->regs.cur_offset & BIT(31)) >> (4 - size);
+        }
         break;
-    case CUR_CLR0:
-        val = s->regs.cur_color0;
+    case CUR_CLR0 ... CUR_CLR0 + 3:
+        val = ati_reg_read_offs(s->regs.cur_color0, addr - CUR_CLR0, size);
         break;
-    case CUR_CLR1:
-        val = s->regs.cur_color1;
+    case CUR_CLR1 ... CUR_CLR1 + 3:
+        val = ati_reg_read_offs(s->regs.cur_color1, addr - CUR_CLR1, size);
         break;
     case DST_OFFSET:
         val = s->regs.dst_offset;
@@ -693,48 +699,71 @@ static void ati_mm_write(void *opaque, hwaddr addr,
     case 0xf00 ... 0xfff:
         /* read-only copy of PCI config space so ignore writes */
         break;
-    case CUR_OFFSET:
-        if (s->regs.cur_offset != (data & 0x87fffff0)) {
-            s->regs.cur_offset = data & 0x87fffff0;
+    case CUR_OFFSET ... CUR_OFFSET + 3:
+    {
+        uint32_t t = s->regs.cur_offset;
+
+        ati_reg_write_offs(&t, addr - CUR_OFFSET, data, size);
+        t &= 0x87fffff0;
+        if (s->regs.cur_offset != t) {
+            s->regs.cur_offset = t;
             ati_cursor_define(s);
         }
         break;
-    case CUR_HORZ_VERT_POSN:
-        s->regs.cur_hv_pos = data & 0x3fff0fff;
-        if (data & BIT(31)) {
-            s->regs.cur_offset |= data & BIT(31);
+    }
+    case CUR_HORZ_VERT_POSN ... CUR_HORZ_VERT_POSN + 3:
+    {
+        uint32_t t = s->regs.cur_hv_pos | (s->regs.cur_offset & BIT(31));
+
+        ati_reg_write_offs(&t, addr - CUR_HORZ_VERT_POSN, data, size);
+        s->regs.cur_hv_pos = t & 0x3fff0fff;
+        if (t & BIT(31)) {
+            s->regs.cur_offset |= t & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
             s->regs.cur_offset &= ~BIT(31);
             ati_cursor_define(s);
         }
         if (!s->cursor_guest_mode &&
-            (s->regs.crtc_gen_cntl & CRTC2_CUR_EN) && !(data & BIT(31))) {
+            (s->regs.crtc_gen_cntl & CRTC2_CUR_EN) && !(t & BIT(31))) {
             dpy_mouse_set(s->vga.con, s->regs.cur_hv_pos >> 16,
                           s->regs.cur_hv_pos & 0xffff, 1);
         }
         break;
+    }
     case CUR_HORZ_VERT_OFF:
-        s->regs.cur_hv_offs = data & 0x3f003f;
-        if (data & BIT(31)) {
-            s->regs.cur_offset |= data & BIT(31);
+    {
+        uint32_t t = s->regs.cur_hv_offs | (s->regs.cur_offset & BIT(31));
+
+        ati_reg_write_offs(&t, addr - CUR_HORZ_VERT_OFF, data, size);
+        s->regs.cur_hv_offs = t & 0x3f003f;
+        if (t & BIT(31)) {
+            s->regs.cur_offset |= t & BIT(31);
         } else if (s->regs.cur_offset & BIT(31)) {
             s->regs.cur_offset &= ~BIT(31);
             ati_cursor_define(s);
         }
         break;
-    case CUR_CLR0:
-        if (s->regs.cur_color0 != (data & 0xffffff)) {
-            s->regs.cur_color0 = data & 0xffffff;
+    }
+    case CUR_CLR0 ... CUR_CLR0 + 3:
+    {
+        uint32_t t = s->regs.cur_color0;
+
+        ati_reg_write_offs(&t, addr - CUR_CLR0, data, size);
+        t &= 0xffffff;
+        if (s->regs.cur_color0 != t) {
+            s->regs.cur_color0 = t;
             ati_cursor_define(s);
         }
         break;
-    case CUR_CLR1:
+    }
+    case CUR_CLR1 ... CUR_CLR1 + 3:
         /*
          * Update cursor unconditionally here because some clients set up
          * other registers before actually writing cursor data to memory at
          * offset so we would miss cursor change unless always updating here
          */
-        s->regs.cur_color1 = data & 0xffffff;
+        ati_reg_write_offs(&s->regs.cur_color1, addr - CUR_CLR1, data, size);
+        s->regs.cur_color1 &= 0xffffff;
         ati_cursor_define(s);
         break;
     case DST_OFFSET:
-- 
2.21.3


