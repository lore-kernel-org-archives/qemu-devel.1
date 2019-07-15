Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2774C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:25:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC07621537
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:25:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC07621537
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39335 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1uq-0004mX-7W
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:25:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hn1ti-0008SX-In
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hn1tg-0002ZH-S1
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:24:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36913 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hn1tg-0002YJ-FR
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:24:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 818691A209C;
 Mon, 15 Jul 2019 16:23:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 3C3891A2096;
 Mon, 15 Jul 2019 16:23:02 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 16:22:54 +0200
Message-Id: <1563200574-11098-9-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 8/8] target/ppc: Refactor emulation of
 vmrgew and vmrgow instructions
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
Cc: stefan.brankovic@rt-rk.com, richard.henderson@linaro.org,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Since I found this two instructions implemented with tcg, I refactored
them so they are consistent with other similar implementations that
I introduced in this patch.

Also, a new dual macro GEN_VXFORM_TRANS_DUAL is added. This macro is
used if one instruction is realized with direct translation, and second
one with a helper.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 66 +++++++++++++++++++++----------------
 1 file changed, 37 insertions(+), 29 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index e8a0fb6..6af9c73 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -350,6 +350,28 @@ static void glue(gen_, name0##_##name1)(DisasContext *ctx)             \
     }                                                                  \
 }
 
+/*
+ * We use this macro if one instruction is realized with direct
+ * translation, and second one with helper.
+ */
+#define GEN_VXFORM_TRANS_DUAL(name0, flg0, flg2_0, name1, flg1, flg2_1)\
+static void glue(gen_, name0##_##name1)(DisasContext *ctx)             \
+{                                                                      \
+    if ((Rc(ctx->opcode) == 0) &&                                      \
+        ((ctx->insns_flags & flg0) || (ctx->insns_flags2 & flg2_0))) { \
+        if (unlikely(!ctx->altivec_enabled)) {                         \
+            gen_exception(ctx, POWERPC_EXCP_VPU);                      \
+            return;                                                    \
+        }                                                              \
+        trans_##name0(ctx);                                            \
+    } else if ((Rc(ctx->opcode) == 1) &&                               \
+        ((ctx->insns_flags & flg1) || (ctx->insns_flags2 & flg2_1))) { \
+        gen_##name1(ctx);                                              \
+    } else {                                                           \
+        gen_inval_exception(ctx, POWERPC_EXCP_INVAL_INVAL);            \
+    }                                                                  \
+}
+
 /* Adds support to provide invalid mask */
 #define GEN_VXFORM_DUAL_EXT(name0, flg0, flg2_0, inval0,                \
                             name1, flg1, flg2_1, inval1)                \
@@ -431,20 +453,13 @@ GEN_VXFORM(vmrglb, 6, 4);
 GEN_VXFORM(vmrglh, 6, 5);
 GEN_VXFORM(vmrglw, 6, 6);
 
-static void gen_vmrgew(DisasContext *ctx)
+static void trans_vmrgew(DisasContext *ctx)
 {
-    TCGv_i64 tmp;
-    TCGv_i64 avr;
-    int VT, VA, VB;
-    if (unlikely(!ctx->altivec_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VPU);
-        return;
-    }
-    VT = rD(ctx->opcode);
-    VA = rA(ctx->opcode);
-    VB = rB(ctx->opcode);
-    tmp = tcg_temp_new_i64();
-    avr = tcg_temp_new_i64();
+    int VT = rD(ctx->opcode);
+    int VA = rA(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 tmp = tcg_temp_new_i64();
+    TCGv_i64 avr = tcg_temp_new_i64();
 
     get_avr64(avr, VB, true);
     tcg_gen_shri_i64(tmp, avr, 32);
@@ -462,21 +477,14 @@ static void gen_vmrgew(DisasContext *ctx)
     tcg_temp_free_i64(avr);
 }
 
-static void gen_vmrgow(DisasContext *ctx)
+static void trans_vmrgow(DisasContext *ctx)
 {
-    TCGv_i64 t0, t1;
-    TCGv_i64 avr;
-    int VT, VA, VB;
-    if (unlikely(!ctx->altivec_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VPU);
-        return;
-    }
-    VT = rD(ctx->opcode);
-    VA = rA(ctx->opcode);
-    VB = rB(ctx->opcode);
-    t0 = tcg_temp_new_i64();
-    t1 = tcg_temp_new_i64();
-    avr = tcg_temp_new_i64();
+    int VT = rD(ctx->opcode);
+    int VA = rA(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 t0 = tcg_temp_new_i64();
+    TCGv_i64 t1 = tcg_temp_new_i64();
+    TCGv_i64 avr = tcg_temp_new_i64();
 
     get_avr64(t0, VB, true);
     get_avr64(t1, VA, true);
@@ -1165,14 +1173,14 @@ GEN_VXFORM_ENV(vminfp, 5, 17);
 GEN_VXFORM_HETRO(vextublx, 6, 24)
 GEN_VXFORM_HETRO(vextuhlx, 6, 25)
 GEN_VXFORM_HETRO(vextuwlx, 6, 26)
-GEN_VXFORM_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
+GEN_VXFORM_TRANS_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
                 vextuwlx, PPC_NONE, PPC2_ISA300)
 GEN_VXFORM_HETRO(vextubrx, 6, 28)
 GEN_VXFORM_HETRO(vextuhrx, 6, 29)
 GEN_VXFORM_HETRO(vextuwrx, 6, 30)
 GEN_VXFORM_TRANS(lvsl, 6, 31)
 GEN_VXFORM_TRANS(lvsr, 6, 32)
-GEN_VXFORM_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207, \
+GEN_VXFORM_TRANS_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207,
                 vextuwrx, PPC_NONE, PPC2_ISA300)
 
 #define GEN_VXRFORM1(opname, name, str, opc2, opc3)                     \
-- 
2.7.4


