Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10024C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:51:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D13BA206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:51:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MuLaLznV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D13BA206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeI0a-0004xd-1q
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:51:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33772)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHmB-0002Sr-Jo
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:47 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40691
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHm7-0005NW-59
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=alJWWguzMdAxzeeZpfBMp4t+t9rEX1QSKuKtB7IIv5E=;
 b=MuLaLznVahQ31texZ5QnalElOdTj0/3a71rltmXwcR5hs8nobjojtb0YYPvYNjVRFiWG3a
 oEZNRKDXry7I0S70yNJYlr5Nn6puh79dZBoyPD6alBHYluybptmxVWKE9ltNgPhU+ZVIOm
 iYWpZIlabnhEvHU8GM+r/qJgJcObjj4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-278-JuWgx9MlNF20MyKJL9fEuA-1; Thu, 28 May 2020 08:36:22 -0400
X-MC-Unique: JuWgx9MlNF20MyKJL9fEuA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BFD301855A10;
 Thu, 28 May 2020 12:36:20 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7179A60FC2;
 Thu, 28 May 2020 12:36:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 871139D54; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 05/21] hw/display/cirrus_vga: Use qemu_log_mask(ERROR) instead
 of debug printf
Date: Thu, 28 May 2020 14:35:53 +0200
Message-Id: <20200528123609.27362-6-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Replace some debug printf() calls by qemu_log_mask(LOG_GUEST_ERROR).

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200526062252.19852-6-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cirrus_vga.c | 77 ++++++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 44 deletions(-)

diff --git a/hw/display/cirrus_vga.c b/hw/display/cirrus_vga.c
index f9f837b8508c..76e2dc5bb604 100644
--- a/hw/display/cirrus_vga.c
+++ b/hw/display/cirrus_vga.c
@@ -978,9 +978,8 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
 	s->cirrus_blt_pixelwidth = 4;
 	break;
     default:
-#ifdef DEBUG_BITBLT
-	printf("cirrus: bitblt - pixel width is unknown\n");
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: bitblt - pixel width is unknown\n");
 	goto bitblt_ignore;
     }
     s->cirrus_blt_mode &= ~CIRRUS_BLTMODE_PIXELWIDTHMASK;
@@ -1037,7 +1036,9 @@ static void cirrus_bitblt_start(CirrusVGAState * s)
         } else {
 	    if (s->cirrus_blt_mode & CIRRUS_BLTMODE_TRANSPARENTCOMP) {
 		if (s->cirrus_blt_pixelwidth > 2) {
-		    printf("src transparent without colorexpand must be 8bpp or 16bpp\n");
+            qemu_log_mask(LOG_GUEST_ERROR,
+                          "cirrus: src transparent without colorexpand "
+                          "must be 8bpp or 16bpp\n");
 		    goto bitblt_ignore;
 		}
 		if (s->cirrus_blt_mode & CIRRUS_BLTMODE_BACKWARDS) {
@@ -1135,10 +1136,9 @@ static uint32_t cirrus_get_bpp16_depth(CirrusVGAState * s)
 	ret = 16;
 	break;			/* XGA HiColor */
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: invalid DAC value %x in 16bpp\n",
-	       (s->cirrus_hidden_dac_data & 0xf));
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: invalid DAC value 0x%x in 16bpp\n",
+                      (s->cirrus_hidden_dac_data & 0xf));
 	ret = 15;		/* XXX */
 	break;
     }
@@ -1307,11 +1307,9 @@ static int cirrus_vga_read_sr(CirrusVGAState * s)
 #endif
 	return s->vga.sr[s->vga.sr_index];
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: inport sr_index %02x\n", s->vga.sr_index);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: inport sr_index 0x%02x\n", s->vga.sr_index);
 	return 0xff;
-	break;
     }
 }
 
@@ -1400,10 +1398,9 @@ static void cirrus_vga_write_sr(CirrusVGAState * s, uint32_t val)
         cirrus_update_memory_access(s);
         break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: outport sr_index %02x, sr_value %02x\n",
-               s->vga.sr_index, val);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: outport sr_index 0x%02x, sr_value 0x%02x\n",
+                      s->vga.sr_index, val);
 	break;
     }
 }
@@ -1501,9 +1498,8 @@ static int cirrus_vga_read_gr(CirrusVGAState * s, unsigned reg_index)
     if (reg_index < 0x3a) {
 	return s->vga.gr[reg_index];
     } else {
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: inport gr_index %02x\n", reg_index);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: inport gr_index 0x%02x\n", reg_index);
 	return 0xff;
     }
 }
@@ -1590,10 +1586,9 @@ cirrus_vga_write_gr(CirrusVGAState * s, unsigned reg_index, int reg_value)
 	cirrus_write_bitblt(s, reg_value);
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: outport gr_index %02x, gr_value %02x\n", reg_index,
-	       reg_value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: outport gr_index 0x%02x, gr_value 0x%02x\n",
+                      reg_index, reg_value);
 	break;
     }
 }
@@ -1648,9 +1643,8 @@ static int cirrus_vga_read_cr(CirrusVGAState * s, unsigned reg_index)
 	return s->vga.ar_index & 0x3f;
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: inport cr_index %02x\n", reg_index);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: inport cr_index 0x%02x\n", reg_index);
 	return 0xff;
     }
 }
@@ -1721,10 +1715,9 @@ static void cirrus_vga_write_cr(CirrusVGAState * s, int reg_value)
 	break;
     case 0x25:			// Part Status
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: outport cr_index %02x, cr_value %02x\n",
-               s->vga.cr_index, reg_value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: outport cr_index 0x%02x, cr_value 0x%02x\n",
+                      s->vga.cr_index, reg_value);
 	break;
     }
 }
@@ -1834,9 +1827,8 @@ static uint8_t cirrus_mmio_blt_read(CirrusVGAState * s, unsigned address)
 	value = cirrus_vga_read_gr(s, 0x31);
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: mmio read - address 0x%04x\n", address);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mmio read - address 0x%04x\n", address);
 	break;
     }
 
@@ -1946,10 +1938,9 @@ static void cirrus_mmio_blt_write(CirrusVGAState * s, unsigned address,
 	cirrus_vga_write_gr(s, 0x31, value);
 	break;
     default:
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: mmio write - addr 0x%04x val 0x%02x (ignored)\n",
-	       address, value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mmio write - addr 0x%04x val 0x%02x (ignored)\n",
+                      address, value);
 	break;
     }
 }
@@ -2047,9 +2038,8 @@ static uint64_t cirrus_vga_mem_read(void *opaque,
 	}
     } else {
 	val = 0xff;
-#ifdef DEBUG_CIRRUS
-	printf("cirrus: mem_readb " TARGET_FMT_plx "\n", addr);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mem_readb 0x" TARGET_FMT_plx "\n", addr);
     }
     return val;
 }
@@ -2112,10 +2102,9 @@ static void cirrus_vga_mem_write(void *opaque,
 	    cirrus_mmio_blt_write(s, addr & 0xff, mem_value);
 	}
     } else {
-#ifdef DEBUG_CIRRUS
-        printf("cirrus: mem_writeb " TARGET_FMT_plx " value 0x%02" PRIu64 "\n", addr,
-               mem_value);
-#endif
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "cirrus: mem_writeb 0x" TARGET_FMT_plx " "
+                      "value 0x%02" PRIu64 "\n", addr, mem_value);
     }
 }
 
-- 
2.18.4


