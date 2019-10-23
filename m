Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD38CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:09:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34D2721906
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 14:09:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34D2721906
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37080 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNHKl-0000LA-Aa
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 10:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51798)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iNHBK-0002ZL-2x
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:00:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1iNHBH-0004pB-F4
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:00:09 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46601 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1iNHBG-0004mh-Vh
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 10:00:07 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B7DAA1A227A;
 Wed, 23 Oct 2019 16:00:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.14.77])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 706481A21DB;
 Wed, 23 Oct 2019 16:00:02 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v9 1/3] target/ppc: Optimize emulation of vclzh and vclzb
 instructions
Date: Wed, 23 Oct 2019 15:59:54 +0200
Message-Id: <1571839196-1739-2-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571839196-1739-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1571839196-1739-1-git-send-email-stefan.brankovic@rt-rk.com>
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
Cc: aleksandar.markovic@rt-rk.com, stefan.brankovic@rt-rk.com,
 richard.henderson@linaro.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Optimize emulation of Altivec instructions vclzh (Vector Count Leading Zeros
Halfword) and vclzb (Vector Count Leading Zeros Byte).This instructions
count the number of leading zeros of each halfword/byte element in source
register and place result in the appropriate halfword/byte element of the
destination register.

Emulation of vclzh instruction is implemented in two 'for' loops.
In each iteration of the outer 'for' loop count operation is performed on
one doubleword element of source register vB. In the first iteration, a
higher doubleword element of vB is placed in variable 'avr', and then counting
for every halfword element is performed by using 'tcg_gen_clzi_i64'.
Since it counts leading zeros on 64 bit lenght, ith halword element has to
be moved to the highest 16 bits of variable 'tmp', or-ed with 'mask'(in order
to get all ones in the lowest 48 bits), then perform 'tcg_gen_clzi_i64' and
move it's result in the appropriate halfword element of variable 'result'.
This is done in inner 'for' loop. After the operation is finished, the 'result'
is saved in the appropriate doubleword element of the destination register vD.
The same sequence of orders is to be applied again to the lower doubleword
element of vB.

Emulation of vclzb instruction is implemented in two 'for' loops.
In each iteration of the outer 'for' loop count operation is performed on
one doubleword element of source register vB. In the first iteration, the
higher doubleword element of vB is placed in variable 'avr', and then counting
for every byte element is performed using 'tcg_gen_clzi_i64'. Since it counts
leading zeros on 64 bit length, ith byte element has to be moved to the
highest 8 bits of variable 'tmp', or-ed with 'mask'(in order to get all ones
in the lowest 56 bits), then perform 'tcg_gen_clzi_i64' and move it's result
in the appropriate byte element of variable 'result'. This is done in inner
'for' loop. After the operation is finished, the 'result' is saved in the
appropriate doubleword element of the destination register vD. The same sequence
of orders is to be applied again for the lower doubleword element of vB.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/helper.h                 |   2 -
 target/ppc/int_helper.c             |   9 ---
 target/ppc/translate/vmx-impl.inc.c | 132 +++++++++++++++++++++++++++++++++++-
 3 files changed, 130 insertions(+), 13 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index f843814..281e54f 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -308,8 +308,6 @@ DEF_HELPER_4(vcfsx, void, env, avr, avr, i32)
 DEF_HELPER_4(vctuxs, void, env, avr, avr, i32)
 DEF_HELPER_4(vctsxs, void, env, avr, avr, i32)
 
-DEF_HELPER_2(vclzb, void, avr, avr)
-DEF_HELPER_2(vclzh, void, avr, avr)
 DEF_HELPER_2(vctzb, void, avr, avr)
 DEF_HELPER_2(vctzh, void, avr, avr)
 DEF_HELPER_2(vctzw, void, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 6d238b9..cd00f5e 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1817,15 +1817,6 @@ VUPK(lsw, s64, s32, UPKLO)
         }                                                               \
     }
 
-#define clzb(v) ((v) ? clz32((uint32_t)(v) << 24) : 8)
-#define clzh(v) ((v) ? clz32((uint32_t)(v) << 16) : 16)
-
-VGENERIC_DO(clzb, u8)
-VGENERIC_DO(clzh, u16)
-
-#undef clzb
-#undef clzh
-
 #define ctzb(v) ((v) ? ctz32(v) : 8)
 #define ctzh(v) ((v) ? ctz32(v) : 16)
 #define ctzw(v) ctz32((v))
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 2472a52..8f68e41 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -751,6 +751,134 @@ static void trans_vgbbd(DisasContext *ctx)
 }
 
 /*
+ * vclzb VRT,VRB - Vector Count Leading Zeros Byte
+ *
+ * Counting the number of leading zero bits of each byte element in source
+ * register and placing result in appropriate byte element of destination
+ * register.
+ */
+static void trans_vclzb(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 avr = tcg_temp_new_i64();
+    TCGv_i64 result = tcg_temp_new_i64();
+    TCGv_i64 result1 = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 mask = tcg_const_i64(0xffffffffffffffULL);
+    int i, j;
+
+    for (i = 0; i < 2; i++) {
+        if (i == 0) {
+            /* Get high doubleword of vB in 'avr'. */
+            get_avr64(avr, VB, true);
+        } else {
+            /* Get low doubleword of vB in 'avr'. */
+            get_avr64(avr, VB, false);
+        }
+        /*
+         * Perform count for every byte element using 'tcg_gen_clzi_i64'.
+         * Since it counts leading zeros on 64 bit lenght, we have to move
+         * ith byte element to highest 8 bits of 'tmp', or it with mask(so we
+         * get all ones in lowest 56 bits), then perform 'tcg_gen_clzi_i64' and
+         * move it's result in appropriate byte element of result.
+         */
+        /* count leading zeroes for bits 0..7 */
+        tcg_gen_shli_i64(tmp, avr, 56);
+        tcg_gen_or_i64(tmp, tmp, mask);
+        tcg_gen_clzi_i64(result, tmp, 64);
+        for (j = 1; j < 7; j++) {
+            /* count leading zeroes for bits 8*j..8*j+7  */
+            tcg_gen_shli_i64(tmp, avr, (7 - j) * 8);
+            tcg_gen_or_i64(tmp, tmp, mask);
+            tcg_gen_clzi_i64(tmp, tmp, 64);
+            tcg_gen_deposit_i64(result, result, tmp, j * 8, 8);
+        }
+        /* count leading zeroes for bits 56..63  */
+        tcg_gen_or_i64(tmp, avr, mask);
+        tcg_gen_clzi_i64(tmp, tmp, 64);
+        tcg_gen_deposit_i64(result, result, tmp, 56, 8);
+        if (i == 0) {
+            /* Place result in high doubleword element of vD. */
+            tcg_gen_mov_i64(result1, result);
+        }
+    }
+
+    set_avr64(VT, result1, true);
+    set_avr64(VT, result, false);
+
+    tcg_temp_free_i64(avr);
+    tcg_temp_free_i64(result);
+    tcg_temp_free_i64(result1);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(mask);
+}
+
+/*
+ * vclzh VRT,VRB - Vector Count Leading Zeros Halfword
+ *
+ * Counting the number of leading zero bits of each halfword element in source
+ * register and placing result in appropriate halfword element of destination
+ * register.
+ */
+static void trans_vclzh(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 avr = tcg_temp_new_i64();
+    TCGv_i64 result = tcg_temp_new_i64();
+    TCGv_i64 result1 = tcg_temp_new_i64();
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 mask = tcg_const_i64(0xffffffffffffULL);
+    int i, j;
+
+    for (i = 0; i < 2; i++) {
+        if (i == 0) {
+            /* Get high doubleword element of vB in 'avr'. */
+            get_avr64(avr, VB, true);
+        } else {
+            /* Get low doubleword element of vB in 'avr'. */
+            get_avr64(avr, VB, false);
+        }
+        /*
+         * Perform count for every halfword element using 'tcg_gen_clzi_i64'.
+         * Since it counts leading zeros on 64 bit lenght, we have to move
+         * ith byte element to highest 16 bits of 'tmp', or it with mask(so we
+         * get all ones in lowest 48 bits), then perform 'tcg_gen_clzi_i64' and
+         * move it's result in appropriate halfword element of result.
+         */
+        /* count leading zeroes for bits 0..15 */
+        tcg_gen_shli_i64(tmp, avr, 48);
+        tcg_gen_or_i64(tmp, tmp, mask);
+        tcg_gen_clzi_i64(result, tmp, 64);
+        for (j = 1; j < 3; j++) {
+            /* count leading zeroes for bits 16*j..16*j+15  */
+            tcg_gen_shli_i64(tmp, avr, (3 - j) * 16);
+            tcg_gen_or_i64(tmp, tmp, mask);
+            tcg_gen_clzi_i64(tmp, tmp, 64);
+            tcg_gen_deposit_i64(result, result, tmp, j * 16, 16);
+        }
+        /* count leading zeroes for bits 48..63  */
+        tcg_gen_or_i64(tmp, avr, mask);
+        tcg_gen_clzi_i64(tmp, tmp, 64);
+        tcg_gen_deposit_i64(result, result, tmp, 48, 16);
+        if (i == 0) {
+            /* Place result in high doubleword element of vD. */
+            tcg_gen_mov_i64(result1, result);
+        }
+    }
+
+    set_avr64(VT, result1, true);
+    set_avr64(VT, result, false);
+
+    tcg_temp_free_i64(avr);
+    tcg_temp_free_i64(result);
+    tcg_temp_free_i64(result1);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(mask);
+}
+
+/*
  * vclzw VRT,VRB - Vector Count Leading Zeros Word
  *
  * Counting the number of leading zero bits of each word element in source
@@ -1315,8 +1443,8 @@ GEN_VAFORM_PAIRED(vmsumshm, vmsumshs, 20)
 GEN_VAFORM_PAIRED(vsel, vperm, 21)
 GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23)
 
-GEN_VXFORM_NOA(vclzb, 1, 28)
-GEN_VXFORM_NOA(vclzh, 1, 29)
+GEN_VXFORM_TRANS(vclzb, 1, 28)
+GEN_VXFORM_TRANS(vclzh, 1, 29)
 GEN_VXFORM_TRANS(vclzw, 1, 30)
 GEN_VXFORM_TRANS(vclzd, 1, 31)
 GEN_VXFORM_NOA_2(vnegw, 1, 24, 6)
-- 
2.7.4


