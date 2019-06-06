Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64F75C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:24:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AE1720657
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:24:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AE1720657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57867 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpZm-00009p-IT
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:24:54 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50081)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRz-0002bd-15
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRx-000275-Mp
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:51 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33643 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1hYpRx-000719-Ap
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:49 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id A947D1A2106;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
	[10.10.13.132])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 731B01A1DC6;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 12:15:25 +0200
Message-Id: <1559816130-17113-4-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 3/8] target/ppc: Optimize emulation of vpkpx
 instruction
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Optimize altivec instruction vpkpx (Vector Pack Pixel).
Rearranges 8 pixels coded in 6-5-5 pattern (4 from each source register)
into contigous array of bits in the destination register.

In each iteration of outer loop we do the 6-5-5 pack for 2 pixels
of each doubleword element of each source register. The first thing
we do in outer loop is choosing which doubleword element of which
register are we using in current iteration and we place it in avr
variable. Then we perform 6-5-5 pack of pixels on avr variable
in inner for loop(2 iterations, 1 for each pixel) and save result
in tmp variable. In the end of outer for loop, we merge result in
variable called result and save it in appropriate doubleword element
of vD if whole doubleword is finished(every second iteration). Outer
loop has 4 iterations.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 93 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 6bd072a..87f69dc 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -593,6 +593,97 @@ static void trans_lvsr(DisasContext *ctx)
 }
 
 /*
+ * vpkpx VRT,VRA,VRB - Vector Pack Pixel
+ *
+ * Rearranges 8 pixels coded in 6-5-5 pattern (4 from each source register)
+ * into contigous array of bits in the destination register.
+ */
+static void trans_vpkpx(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VA = rA(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 shifted = tcg_temp_new_i64();
+    TCGv_i64 avr = tcg_temp_new_i64();
+    TCGv_i64 result = tcg_temp_new_i64();
+    int64_t mask1 = 0x1fULL;
+    int64_t mask2 = 0x1fULL << 5;
+    int64_t mask3 = 0x3fULL << 10;
+    int i, j;
+    /*
+     * In each iteration do the 6-5-5 pack for 2 pixels of each doubleword
+     * element of each source register.
+     */
+    for (i = 0; i < 4; i++) {
+        switch (i) {
+        case 0:
+            /*
+             * Get high doubleword of vA to perfrom 6-5-5 pack of pixels
+             * 1 and 2.
+             */
+            get_avr64(avr, VA, true);
+            tcg_gen_movi_i64(result, 0x0ULL);
+            break;
+        case 1:
+            /*
+             * Get low doubleword of vA to perfrom 6-5-5 pack of pixels
+             * 3 and 4.
+             */
+            get_avr64(avr, VA, false);
+            break;
+        case 2:
+            /*
+             * Get high doubleword of vB to perfrom 6-5-5 pack of pixels
+             * 5 and 6.
+             */
+            get_avr64(avr, VB, true);
+            tcg_gen_movi_i64(result, 0x0ULL);
+            break;
+        case 3:
+            /*
+             * Get low doubleword of vB to perfrom 6-5-5 pack of pixels
+             * 7 and 8.
+             */
+            get_avr64(avr, VB, false);
+            break;
+        }
+        /* Perform the packing for 2 pixels(each iteration for 1). */
+        tcg_gen_movi_i64(tmp, 0x0ULL);
+        for (j = 0; j < 2; j++) {
+            tcg_gen_shri_i64(shifted, avr, (j * 16 + 3));
+            tcg_gen_andi_i64(shifted, shifted, mask1 << (j * 16));
+            tcg_gen_or_i64(tmp, tmp, shifted);
+
+            tcg_gen_shri_i64(shifted, avr, (j * 16 + 6));
+            tcg_gen_andi_i64(shifted, shifted, mask2 << (j * 16));
+            tcg_gen_or_i64(tmp, tmp, shifted);
+
+            tcg_gen_shri_i64(shifted, avr, (j * 16 + 9));
+            tcg_gen_andi_i64(shifted, shifted, mask3 << (j * 16));
+            tcg_gen_or_i64(tmp, tmp, shifted);
+        }
+        if ((i == 0) || (i == 2)) {
+            tcg_gen_shli_i64(tmp, tmp, 32);
+        }
+        tcg_gen_or_i64(result, result, tmp);
+        if (i == 1) {
+            /* Place packed pixels 1:4 to high doubleword of vD. */
+            set_avr64(VT, result, true);
+        }
+        if (i == 3) {
+            /* Place packed pixels 5:8 to low doubleword of vD. */
+            set_avr64(VT, result, false);
+        }
+    }
+
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(avr);
+    tcg_temp_free_i64(result);
+}
+
+/*
  * vsl VRT,VRA,VRB - Vector Shift Left
  *
  * Shifting left 128 bit value of vA by value specified in bits 125-127 of vB.
@@ -813,7 +904,7 @@ GEN_VXFORM_ENV(vpksdus, 7, 21);
 GEN_VXFORM_ENV(vpkshss, 7, 6);
 GEN_VXFORM_ENV(vpkswss, 7, 7);
 GEN_VXFORM_ENV(vpksdss, 7, 23);
-GEN_VXFORM(vpkpx, 7, 12);
+GEN_VXFORM_TRANS(vpkpx, 7, 12);
 GEN_VXFORM_ENV(vsum4ubs, 4, 24);
 GEN_VXFORM_ENV(vsum4sbs, 4, 28);
 GEN_VXFORM_ENV(vsum4shs, 4, 25);
-- 
2.7.4


