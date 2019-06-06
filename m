Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68828C28EB2
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:23:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FDAE20657
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:23:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FDAE20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57861 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpYi-00080e-FP
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:23:48 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50057)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRx-0002ar-Uk
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRw-0001zv-Cl
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:49 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41537 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1hYpRw-0001tp-0v
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:48 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 1417A1A1DE5;
	Thu,  6 Jun 2019 12:15:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
	[10.10.13.132])
	by mail.rt-rk.com (Postfix) with ESMTPSA id EB2251A1E45;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 12:15:30 +0200
Message-Id: <1559816130-17113-9-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 8/8] target/ppc: Refactor emulation of vmrgew
 and vmrgow instructions
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

Since I found this two instructions implemented with tcg, I refactored
them so they are consistent with other similar implementations that
I introduced in this patch.

Also had to add new dual macro GEN_VXFORM_TRANS_DUAL. We use this macro
if one instruction is realized with direct translation, and second one
with helper.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 62 ++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 8535a31..46c6f34 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -350,6 +350,24 @@ static void glue(gen_, name0##_##name1)(DisasContext *ctx)             \
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
@@ -431,20 +449,13 @@ GEN_VXFORM(vmrglb, 6, 4);
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
@@ -462,21 +473,14 @@ static void gen_vmrgew(DisasContext *ctx)
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
@@ -1213,14 +1217,14 @@ GEN_VXFORM_ENV(vminfp, 5, 17);
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


