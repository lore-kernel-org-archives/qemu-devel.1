Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D44BC433E0
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:10:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50FBF2065D
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:10:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pneo5J47"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50FBF2065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeNf-0003qj-Fm
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:10:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49984)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHy-0003Kt-B2
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44123
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHu-0001C9-GO
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=poFCkMJ9GLH/8zD3IQqPm0BcWHJBKBklxLNfIpn8S+c=;
 b=Pneo5J47LL3Ts4GtsBePAjd5u9PR0taoTkl309wQjXjEtmkd1ysFfeyUASU8wy7c3YuO5v
 U7a/vkJxLOOOg30X/lzb89UA5O8sf7XTt23B3aH/ncCf85KutLnLQhXt2XVtQ5Hw8qeNEm
 MbKz9yQw/OoR9AW2F5mOoCCxkKsgc8I=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-378-P6IbOCF7OSixRYHdKjGJZg-1; Wed, 01 Jul 2020 11:04:35 -0400
X-MC-Unique: P6IbOCF7OSixRYHdKjGJZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16DCE802ED4;
 Wed,  1 Jul 2020 15:04:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA2D67168D;
 Wed,  1 Jul 2020 15:04:30 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A637831E89; Wed,  1 Jul 2020 17:04:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 10/13] ati-vga: Support unaligned access to hardware cursor
 registers
Date: Wed,  1 Jul 2020 17:04:22 +0200
Message-Id: <20200701150425.13739-11-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
References: <20200701150425.13739-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=205.139.110.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/30 22:25:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
Cc: qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

This fixes horizontal mouse movement and pointer color with MacOS that
writes these registers with access size less than 4 so previously only
the last portion of access was effective overwriting previous partial
writes.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: ba1d5ba97f246e8807f86f1243c2bdc6497dc8f2.1592737958.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati.c | 85 ++++++++++++++++++++++++++++++++----------------
 1 file changed, 57 insertions(+), 28 deletions(-)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index 7216f7e08f87..245130d52f33 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -389,22 +389,28 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case 0xf00 ... 0xfff:
         val = pci_default_read_config(&s->dev, addr - 0xf00, size);
         break;
-    case CUR_OFFSET:
-        val = s->regs.cur_offset;
+    case CUR_OFFSET ... CUR_OFFSET + 3:
+        val = ati_reg_read_offs(s->regs.cur_offset, addr - CUR_OFFSET, size);
         break;
-    case CUR_HORZ_VERT_POSN:
-        val = s->regs.cur_hv_pos;
-        val |= s->regs.cur_offset & BIT(31);
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
@@ -679,48 +685,71 @@ static void ati_mm_write(void *opaque, hwaddr addr,
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
2.18.4


