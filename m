Return-Path: <SRS0=aoXf=X5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD97EC47404
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A761721D81
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Oct 2019 13:47:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A761721D81
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iGNvV-0001RG-Mt
	for qemu-devel@archiver.kernel.org; Fri, 04 Oct 2019 09:47:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49165)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iGNtR-0000AY-Be
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:45:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iGNtP-0002kq-Be
 for qemu-devel@nongnu.org; Fri, 04 Oct 2019 09:45:13 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41306 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1iGNtN-00021z-VT; Fri, 04 Oct 2019 09:45:11 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 368EC1A1DCD;
 Fri,  4 Oct 2019 15:44:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 0F9601A212D;
 Fri,  4 Oct 2019 15:44:02 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Subject: [PATCH v2] target/ppc: Fix for optimized vsl/vsr instructions
Date: Fri,  4 Oct 2019 15:43:59 +0200
Message-Id: <1570196639-7025-2-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1570196639-7025-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1570196639-7025-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 89.216.37.149
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
Cc: richard.hendreson@linaro.org, mark.cave-ayland@ilande.co.uk, pc@us.ibm.com,
 amarkovic@wavecomp.com, stefan.brankovic@rt-rk.com, alex.bennee@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In previous implementation, invocation of TCG shift function could request
shift of TCG variable by 64 bits when variable 'sh' is 0, which is not
supported in TCG (values can be shifted by 0 to 63 bits). This patch fixes
this by using two separate invocation of TCG shift functions, with maximum
shift amount of 32.

Name of variable 'shifted' is changed to 'carry' so variable naming
is similar to old helper implementation.

Variables 'avrA' and 'avrB' are replaced with variable 'avr'.

Fixes: 4e6d0920e7547e6af4bbac5ffe9adfe6ea621822
Reported-by: Paul Clark <pc@us.ibm.com>
Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Suggested-by: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 84 ++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 44 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 2472a52..81d5a7a 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -590,40 +590,38 @@ static void trans_vsl(DisasContext *ctx)
     int VT = rD(ctx->opcode);
     int VA = rA(ctx->opcode);
     int VB = rB(ctx->opcode);
-    TCGv_i64 avrA = tcg_temp_new_i64();
-    TCGv_i64 avrB = tcg_temp_new_i64();
+    TCGv_i64 avr = tcg_temp_new_i64();
     TCGv_i64 sh = tcg_temp_new_i64();
-    TCGv_i64 shifted = tcg_temp_new_i64();
+    TCGv_i64 carry = tcg_temp_new_i64();
     TCGv_i64 tmp = tcg_temp_new_i64();
 
-    /* Place bits 125-127 of vB in sh. */
-    get_avr64(avrB, VB, false);
-    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+    /* Place bits 125-127 of vB in 'sh'. */
+    get_avr64(avr, VB, false);
+    tcg_gen_andi_i64(sh, avr, 0x07ULL);
 
     /*
-     * Save highest sh bits of lower doubleword element of vA in variable
-     * shifted and perform shift on lower doubleword.
+     * Save highest 'sh' bits of lower doubleword element of vA in variable
+     * 'carry' and perform shift on lower doubleword.
      */
-    get_avr64(avrA, VA, false);
-    tcg_gen_subfi_i64(tmp, 64, sh);
-    tcg_gen_shr_i64(shifted, avrA, tmp);
-    tcg_gen_andi_i64(shifted, shifted, 0x7fULL);
-    tcg_gen_shl_i64(avrA, avrA, sh);
-    set_avr64(VT, avrA, false);
+    get_avr64(avr, VA, false);
+    tcg_gen_subfi_i64(tmp, 32, sh);
+    tcg_gen_shri_i64(carry, avr, 32);
+    tcg_gen_shr_i64(carry, carry, tmp);
+    tcg_gen_shl_i64(avr, avr, sh);
+    set_avr64(VT, avr, false);
 
     /*
      * Perform shift on higher doubleword element of vA and replace lowest
-     * sh bits with shifted.
+     * 'sh' bits with 'carry'.
      */
-    get_avr64(avrA, VA, true);
-    tcg_gen_shl_i64(avrA, avrA, sh);
-    tcg_gen_or_i64(avrA, avrA, shifted);
-    set_avr64(VT, avrA, true);
+    get_avr64(avr, VA, true);
+    tcg_gen_shl_i64(avr, avr, sh);
+    tcg_gen_or_i64(avr, avr, carry);
+    set_avr64(VT, avr, true);
 
-    tcg_temp_free_i64(avrA);
-    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(avr);
     tcg_temp_free_i64(sh);
-    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(carry);
     tcg_temp_free_i64(tmp);
 }
 
@@ -639,39 +637,37 @@ static void trans_vsr(DisasContext *ctx)
     int VT = rD(ctx->opcode);
     int VA = rA(ctx->opcode);
     int VB = rB(ctx->opcode);
-    TCGv_i64 avrA = tcg_temp_new_i64();
-    TCGv_i64 avrB = tcg_temp_new_i64();
+    TCGv_i64 avr = tcg_temp_new_i64();
     TCGv_i64 sh = tcg_temp_new_i64();
-    TCGv_i64 shifted = tcg_temp_new_i64();
+    TCGv_i64 carry = tcg_temp_new_i64();
     TCGv_i64 tmp = tcg_temp_new_i64();
 
-    /* Place bits 125-127 of vB in sh. */
-    get_avr64(avrB, VB, false);
-    tcg_gen_andi_i64(sh, avrB, 0x07ULL);
+    /* Place bits 125-127 of vB in 'sh'. */
+    get_avr64(avr, VB, false);
+    tcg_gen_andi_i64(sh, avr, 0x07ULL);
 
     /*
-     * Save lowest sh bits of higher doubleword element of vA in variable
-     * shifted and perform shift on higher doubleword.
+     * Save lowest 'sh' bits of higher doubleword element of vA in variable
+     * 'carry' and perform shift on higher doubleword.
      */
-    get_avr64(avrA, VA, true);
-    tcg_gen_subfi_i64(tmp, 64, sh);
-    tcg_gen_shl_i64(shifted, avrA, tmp);
-    tcg_gen_andi_i64(shifted, shifted, 0xfe00000000000000ULL);
-    tcg_gen_shr_i64(avrA, avrA, sh);
-    set_avr64(VT, avrA, true);
+    get_avr64(avr, VA, true);
+    tcg_gen_subfi_i64(tmp, 32, sh);
+    tcg_gen_shli_i64(carry, avr, 32);
+    tcg_gen_shl_i64(carry, carry, tmp);
+    tcg_gen_shr_i64(avr, avr, sh);
+    set_avr64(VT, avr, true);
     /*
      * Perform shift on lower doubleword element of vA and replace highest
-     * sh bits with shifted.
+     * 'sh' bits with 'carry'.
      */
-    get_avr64(avrA, VA, false);
-    tcg_gen_shr_i64(avrA, avrA, sh);
-    tcg_gen_or_i64(avrA, avrA, shifted);
-    set_avr64(VT, avrA, false);
+    get_avr64(avr, VA, false);
+    tcg_gen_shr_i64(avr, avr, sh);
+    tcg_gen_or_i64(avr, avr, carry);
+    set_avr64(VT, avr, false);
 
-    tcg_temp_free_i64(avrA);
-    tcg_temp_free_i64(avrB);
+    tcg_temp_free_i64(avr);
     tcg_temp_free_i64(sh);
-    tcg_temp_free_i64(shifted);
+    tcg_temp_free_i64(carry);
     tcg_temp_free_i64(tmp);
 }
 
-- 
2.7.4


