Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2DB4C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:21:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59FD2206E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:21:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59FD2206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57834 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpWr-0006Uy-DY
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:21:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50049)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRx-0002ad-MS
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRw-0001zI-96
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33649 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1hYpRv-00071L-TR
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id A8B731A2105;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
	[10.10.13.132])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 802741A1DE5;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 12:15:26 +0200
Message-Id: <1559816130-17113-5-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 4/8] target/ppc: Optimize emulation of vgbbd
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

Optimize altivec instruction vgbbd (Vector Gather Bits by Bytes by Doubleword)
All ith bits (i in range 1 to 8) of each byte of doubleword element in
source register are concatenated and placed into ith byte of appropriate
doubleword element in destination register.

Following solution is done for every doubleword element of source register
(placed in shifted variable):
We gather bits in 2x8 iterations.
In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of byte 8 are
in their final spots so we just and avr with mask. For every next iteration,
we have to shift right both shifted(7 places) and mask(8 places), so we get
bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in right places so we and
shifted with new value of mask... After first 8 iteration(first for loop) we
have all first bits in their final place all second bits but second bit from
eight byte in their place,... only 1 eight bit from eight byte is in it's
place), so we and result1 with mask1 to save those bits that are at right
place and save them in result1. In second loop we do all operations
symetrical, so we get other half of bits on their final spots, and save
result in result2. Or of result1 and result2 is placed in appropriate
doubleword element of vD. We repeat this 2 times.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 99 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 87f69dc..010f337 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -780,6 +780,103 @@ static void trans_vsr(DisasContext *ctx)
     tcg_temp_free_i64(tmp);
 }
 
+/*
+ * vgbbd VRT,VRB - Vector Gather Bits by Bytes by Doubleword
+ *
+ * All ith bits (i in range 1 to 8) of each byte of doubleword element in source
+ * register are concatenated and placed into ith byte of appropriate doubleword
+ * element in destination register.
+ *
+ * Following solution is done for every doubleword element of source register
+ * (placed in shifted variable):
+ * We gather bits in 2x8 iterations.
+ * In first iteration bit 1 of byte 1, bit 2 of byte 2,... bit 8 of byte 8 are
+ * in their final spots so we just and avr with mask. For every next iteration,
+ * we have to shift right both shifted(7 places) and mask(8 places), so we get
+ * bit 1 of byte 2, bit 2 of byte 3.. bit 7 of byte 8 in right places so we and
+ * shifted with new value of mask... After first 8 iteration(first for loop) we
+ * have all first bits in their final place all second bits but second bit from
+ * eight byte in their place,... only 1 eight bit from eight byte is in it's
+ * place), so we and result1 with mask1 to save those bits that are at right
+ * place and save them in result1. In second loop we do all operations
+ * symetrical, so we get other half of bits on their final spots, and save
+ * result in result2. Or of result1 and result2 is placed in appropriate
+ * doubleword element of vD. We repeat this 2 times.
+ */
+static void trans_vgbbd(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 avr = tcg_temp_new_i64();
+    TCGv_i64 shifted = tcg_temp_new_i64();
+    TCGv_i64 result1 = tcg_temp_new_i64();
+    TCGv_i64 result2 = tcg_temp_new_i64();
+    uint64_t mask = 0x8040201008040201ULL;
+    uint64_t mask1 = 0x80c0e0f0f8fcfeffULL;
+    uint64_t mask2 = 0x7f3f1f0f07030100ULL;
+    int i;
+
+    get_avr64(avr, VB, true);
+    tcg_gen_movi_i64(result1, 0x0ULL);
+    tcg_gen_mov_i64(shifted, avr);
+    for (i = 0; i < 8; i++) {
+        tcg_gen_andi_i64(tmp, shifted, mask);
+        tcg_gen_or_i64(result1, result1, tmp);
+
+        tcg_gen_shri_i64(shifted, shifted, 7);
+        mask = mask >> 8;
+    }
+    tcg_gen_andi_i64(result1, result1, mask1);
+
+    mask = 0x8040201008040201ULL;
+    tcg_gen_movi_i64(result2, 0x0ULL);
+    for (i = 0; i < 8; i++) {
+        tcg_gen_andi_i64(tmp, avr, mask);
+        tcg_gen_or_i64(result2, result2, tmp);
+
+        tcg_gen_shli_i64(avr, avr, 7);
+        mask = mask << 8;
+    }
+    tcg_gen_andi_i64(result2, result2, mask2);
+
+    tcg_gen_or_i64(result2, result2, result1);
+    set_avr64(VT, result2, true);
+
+    mask = 0x8040201008040201ULL;
+    get_avr64(avr, VB, false);
+    tcg_gen_movi_i64(result1, 0x0ULL);
+    tcg_gen_mov_i64(shifted, avr);
+    for (i = 0; i < 8; i++) {
+        tcg_gen_andi_i64(tmp, shifted, mask);
+        tcg_gen_or_i64(result1, result1, tmp);
+
+        tcg_gen_shri_i64(shifted, shifted, 7);
+        mask = mask >> 8;
+    }
+    tcg_gen_andi_i64(result1, result1, mask1);
+
+    mask = 0x8040201008040201ULL;
+    tcg_gen_movi_i64(result2, 0x0ULL);
+    for (i = 0; i < 8; i++) {
+        tcg_gen_andi_i64(tmp, avr, mask);
+        tcg_gen_or_i64(result2, result2, tmp);
+
+        tcg_gen_shli_i64(avr, avr, 7);
+        mask = mask << 8;
+    }
+    tcg_gen_andi_i64(result2, result2, mask2);
+
+    tcg_gen_or_i64(result2, result2, result1);
+    set_avr64(VT, result2, false);
+
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(avr);
+    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(result1);
+    tcg_temp_free_i64(result2);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -1319,7 +1416,7 @@ GEN_VXFORM_DUAL(vclzd, PPC_NONE, PPC2_ALTIVEC_207, \
                 vpopcntd, PPC_NONE, PPC2_ALTIVEC_207)
 GEN_VXFORM(vbpermd, 6, 23);
 GEN_VXFORM(vbpermq, 6, 21);
-GEN_VXFORM_NOA(vgbbd, 6, 20);
+GEN_VXFORM_TRANS(vgbbd, 6, 20);
 GEN_VXFORM(vpmsumb, 4, 16)
 GEN_VXFORM(vpmsumh, 4, 17)
 GEN_VXFORM(vpmsumw, 4, 18)
-- 
2.7.4


