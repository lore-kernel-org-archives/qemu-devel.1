Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5393C28D1E
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:18:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6A8206E0
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:18:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6A8206E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57775 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpU0-0003jy-Mf
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:18:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRw-0002Zn-7L
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRu-0001ro-TA
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:48 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33644 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1hYpRu-00071C-Im
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 975251A1E51;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
	[10.10.13.132])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 6659F1A1FC6;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 12:15:24 +0200
Message-Id: <1559816130-17113-3-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 2/8] target/ppc: Optimize emulation of vsl and
 vsr instructions
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

Optimization of altivec instructions vsl and vsr(Vector Shift Left/Rigt).
Perform shift operation (left and right respectively) on 128 bit value of
register vA by value specified in bits 125-127 of register vB. Lowest 3
bits in each byte element of register vB must be identical or result is
undefined.

For vsl instruction we do this by first saving bits 125-127
of register  vB in variable sh. Then we save highest sh bits
of lower doubleword element of register vA in variable shifted,
so we don't lose those bits when we perform shift operation on
lower doubleword element of register vA, which is our next
step. After shifting lower doubleword element we perform shift
operation on higher doubleword element of vA and replace
lowest sh bits(that are now 0) with bits saved in shifted.

For vsr instruction we do this by first saving bits 125-127
of register  vB in variable sh. Then we save lowest sh bits
of higher doubleword element of register vA in variable shifted,
so we don't lose those bits when we perform shift operation on
higher doubleword element of register vA, which is our next step.
After shifting higher doubleword element we perform shift
operation on lower doubleword element of vA and replace
highest sh bits(that are now 0) with bits saved in shifted.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 101 +++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 2 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 140bb05..6bd072a 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -592,6 +592,103 @@ static void trans_lvsr(DisasContext *ctx)
     tcg_temp_free(EA);
 }
 
+/*
+ * vsl VRT,VRA,VRB - Vector Shift Left
+ *
+ * Shifting left 128 bit value of vA by value specified in bits 125-127 of vB.
+ * Lowest 3 bits in each byte element of register vB must be identical or
+ * result is undefined.
+ */
+static void trans_vsl(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VA = rA(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 avrA = tcg_temp_new_i64();
+    TCGv_i64 avrB = tcg_temp_new_i64();
+    TCGv_i64 sh = tcg_temp_new_i64();
+    TCGv_i64 shifted = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    /* Place bits 125-127 of vB in sh. */
+    get_avr64(avrB, VB, false);
+    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+
+    /*
+     * Save highest sh bits of lower doubleword element of vA in variable
+     * shifted and perform shift on lower doubleword.
+     */
+    get_avr64(avrA, VA, false);
+    tcg_gen_subi_i64(tmp, sh, 64);
+    tcg_gen_neg_i64(tmp, tmp);
+    tcg_gen_shr_i64(shifted, avrA, tmp);
+    tcg_gen_shl_i64(avrA, avrA, sh);
+    set_avr64(VT, avrA, false);
+
+    /*
+     * Perform shift on higher doubleword element of vA and replace lowest
+     * sh bits with shifted.
+     */
+    get_avr64(avrA, VA, true);
+    tcg_gen_shl_i64(avrA, avrA, sh);
+    tcg_gen_or_i64(avrA, avrA, shifted);
+    set_avr64(VT, avrA, true);
+
+    tcg_temp_free_i64(avrA);
+    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(sh);
+    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(tmp);
+}
+
+/*
+ * vsr VRT,VRA,VRB - Vector Shift Right
+ *
+ * Shifting right 128 bit value of vA by value specified in bits 125-127 of vB.
+ * Lowest 3 bits in each byte element of register vB must be identical or
+ * result is undefined.
+ */
+static void trans_vsr(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VA = rA(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 avrA = tcg_temp_new_i64();
+    TCGv_i64 avrB = tcg_temp_new_i64();
+    TCGv_i64 sh = tcg_temp_new_i64();
+    TCGv_i64 shifted = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+
+    /* Place bits 125-127 of vB in sh. */
+    get_avr64(avrB, VB, false);
+    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+
+    /*
+     * Save lowest sh bits of higher doubleword element of vA in variable
+     * shifted and perform shift on higher doubleword.
+     */
+    get_avr64(avrA, VA, true);
+    tcg_gen_subi_i64(tmp, sh, 64);
+    tcg_gen_neg_i64(tmp, tmp);
+    tcg_gen_shl_i64(shifted, avrA, tmp);
+    tcg_gen_shr_i64(avrA, avrA, sh);
+    set_avr64(VT, avrA, true);
+    /*
+     * Perform shift on lower doubleword element of vA and replace highest
+     * sh bits with shifted.
+     */
+    get_avr64(avrA, VA, false);
+    tcg_gen_shr_i64(avrA, avrA, sh);
+    tcg_gen_or_i64(avrA, avrA, shifted);
+    set_avr64(VT, avrA, false);
+
+    tcg_temp_free_i64(avrA);
+    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(sh);
+    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(tmp);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -699,11 +796,11 @@ GEN_VXFORM(vrld, 2, 3);
 GEN_VXFORM(vrldmi, 2, 3);
 GEN_VXFORM_DUAL(vrld, PPC_NONE, PPC2_ALTIVEC_207, \
                 vrldmi, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vsl, 2, 7);
+GEN_VXFORM_TRANS(vsl, 2, 7);
 GEN_VXFORM(vrldnm, 2, 7);
 GEN_VXFORM_DUAL(vsl, PPC_ALTIVEC, PPC_NONE, \
                 vrldnm, PPC_NONE, PPC2_ISA300)
-GEN_VXFORM(vsr, 2, 11);
+GEN_VXFORM_TRANS(vsr, 2, 11);
 GEN_VXFORM_ENV(vpkuhum, 7, 0);
 GEN_VXFORM_ENV(vpkuwum, 7, 1);
 GEN_VXFORM_ENV(vpkudum, 7, 17);
-- 
2.7.4


