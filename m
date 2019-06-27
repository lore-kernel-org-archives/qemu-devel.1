Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80812C48BD7
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:59:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BBE02085A
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:59:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BBE02085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgS7p-0004Kv-Kj
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:59:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55778)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5v-0001ya-UQ
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5u-0001fJ-5n
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:35 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53722 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hgS5t-0000ev-Ra
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 95D121A4588;
 Thu, 27 Jun 2019 12:56:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 638E71A4548;
 Thu, 27 Jun 2019 12:56:29 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 12:56:14 +0200
Message-Id: <1561632985-24866-3-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 02/13] target/ppc: Optimize emulation of vsl
 and vsr instructions
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
Cc: stefan.brankovic@rt-rk.com, hsp.cat7@gmail.com,
 richard.henderson@linaro.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Optimization of altivec instructions vsl and vsr(Vector Shift Left/Rigt).
Perform shift operation (left and right respectively) on 128 bit value of
register vA by value specified in bits 125-127 of register vB. Lowest 3
bits in each byte element of register vB must be identical or result is
undefined.

For vsl instruction, the first step is bits 125-127 of register vB have
to be saved in variable sh. Then, the highest sh bits of the lower
doubleword element of register vA are saved in variable shifted,
in order not to lose those bits when shift operation is performed on
the lower doubleword element of register vA, which is the next
step. After shifting the lower doubleword element shift operation
is performed on higher doubleword element of vA, with replacement of
the lowest sh bits(that are now 0) with bits saved in shifted.

For vsr instruction, firstly, the bits 125-127 of register vB have
to be saved in variable sh. Then, the lowest sh bits of the higher
doubleword element of register vA are saved in variable shifted,
in odred not to lose those bits when the shift operation is
performed on the higher doubleword element of register vA, which is
the next step. After shifting higher doubleword element, shift operation
is performed on lower doubleword element of vA, with replacement of
highest sh bits(that are now 0) with bits saved in shifted.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  2 -
 target/ppc/int_helper.c             | 35 -------------
 target/ppc/translate/vmx-impl.inc.c | 99 ++++++++++++++++++++++++++++++++++++-
 3 files changed, 97 insertions(+), 39 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index c82105e..33dad6a 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -213,8 +213,6 @@ DEF_HELPER_3(vrlb, void, avr, avr, avr)
 DEF_HELPER_3(vrlh, void, avr, avr, avr)
 DEF_HELPER_3(vrlw, void, avr, avr, avr)
 DEF_HELPER_3(vrld, void, avr, avr, avr)
-DEF_HELPER_3(vsl, void, avr, avr, avr)
-DEF_HELPER_3(vsr, void, avr, avr, avr)
 DEF_HELPER_4(vsldoi, void, avr, avr, avr, i32)
 DEF_HELPER_3(vextractub, void, avr, avr, i32)
 DEF_HELPER_3(vextractuh, void, avr, avr, i32)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 9505f4c..a23853e 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1738,41 +1738,6 @@ VEXTU_X_DO(vextuhrx, 16, 0)
 VEXTU_X_DO(vextuwrx, 32, 0)
 #undef VEXTU_X_DO
 
-/*
- * The specification says that the results are undefined if all of the
- * shift counts are not identical.  We check to make sure that they
- * are to conform to what real hardware appears to do.
- */
-#define VSHIFT(suffix, leftp)                                           \
-    void helper_vs##suffix(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)    \
-    {                                                                   \
-        int shift = b->VsrB(15) & 0x7;                                  \
-        int doit = 1;                                                   \
-        int i;                                                          \
-                                                                        \
-        for (i = 0; i < ARRAY_SIZE(r->u8); i++) {                       \
-            doit = doit && ((b->u8[i] & 0x7) == shift);                 \
-        }                                                               \
-        if (doit) {                                                     \
-            if (shift == 0) {                                           \
-                *r = *a;                                                \
-            } else if (leftp) {                                         \
-                uint64_t carry = a->VsrD(1) >> (64 - shift);            \
-                                                                        \
-                r->VsrD(0) = (a->VsrD(0) << shift) | carry;             \
-                r->VsrD(1) = a->VsrD(1) << shift;                       \
-            } else {                                                    \
-                uint64_t carry = a->VsrD(0) << (64 - shift);            \
-                                                                        \
-                r->VsrD(1) = (a->VsrD(1) >> shift) | carry;             \
-                r->VsrD(0) = a->VsrD(0) >> shift;                       \
-            }                                                           \
-        }                                                               \
-    }
-VSHIFT(l, 1)
-VSHIFT(r, 0)
-#undef VSHIFT
-
 void helper_vslv(ppc_avr_t *r, ppc_avr_t *a, ppc_avr_t *b)
 {
     int i;
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index a9fe3c7..62108ca 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -570,6 +570,101 @@ static void trans_lvsr(DisasContext *ctx)
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
+    tcg_gen_subfi_i64(tmp, 64, sh);
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
+    tcg_gen_subfi_i64(tmp, 64, sh);
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
@@ -682,11 +777,11 @@ GEN_VXFORM(vrld, 2, 3);
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


