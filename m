Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5606C46470
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:18:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723C720868
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 10:18:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723C720868
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57777 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYpU2-0003lP-LG
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 06:18:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50007)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRw-0002Zt-AV
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.brankovic@rt-rk.com>) id 1hYpRu-0001rb-SN
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:48 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:33631 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
	id 1hYpRu-0006zl-Hz
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 06:16:46 -0400
Received: from localhost (localhost [127.0.0.1])
	by mail.rt-rk.com (Postfix) with ESMTP id 829061A1FC1;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
	[10.10.13.132])
	by mail.rt-rk.com (Postfix) with ESMTPSA id 552FF1A1E51;
	Thu,  6 Jun 2019 12:15:36 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu,  6 Jun 2019 12:15:23 +0200
Message-Id: <1559816130-17113-2-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1559816130-17113-1-git-send-email-stefan.brankovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH 1/8] target/ppc: Optimize emulation of lvsl and
 lvsr instructions
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

Adding simple macro that is calling tcg implementation of appropriate
instruction if altivec support is active.

Optimization of altivec instruction lvsl (Load Vector for Shift Left).
Place bytes sh:sh+15 of value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1F
in destination register. Sh is calculated by adding 2 source registers an=
d
getting bits 60-63 of result.

First we place bits [28-31] of EA to variable sh. After that
we create bytes sh:(sh+7) of X(from description) in for loop
(by incrementing sh in each iteration and placing it in
appropriate byte of variable result) and save them in higher
doubleword element of vD. We repeat this once again for lower
doubleword element of vD by creating bytes (sh+8):(sh+15) in
a for loop and saving result.

Optimization of altivec instruction lvsr (Load Vector for Shift Right).
Place bytes 16-sh:31-sh of value 0x00 || 0x01 || 0x02 || ... || 0x1E ||
0x1F in destination register. Sh is calculated by adding 2 source
registers and getting bits 60-63 of result.

First we place bits [28-31] of EA to variable sh. After that
we create bytes (16-sh):(23-sh) of X(from description) in for loop
(by incrementing sh in each iteration and placing it in
appropriate byte of variable result) and save them in higher
doubleword element of vD. We repeat this once again for lower
doubleword element of vD by creating bytes (24-sh):(32-sh) in
a for loop and saving result.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
---
 target/ppc/translate/vmx-impl.inc.c | 143 ++++++++++++++++++++++++++++--=
------
 1 file changed, 111 insertions(+), 32 deletions(-)

diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/v=
mx-impl.inc.c
index bd3ff40..140bb05 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -142,38 +142,6 @@ GEN_VR_STVE(bx, 0x07, 0x04, 1);
 GEN_VR_STVE(hx, 0x07, 0x05, 2);
 GEN_VR_STVE(wx, 0x07, 0x06, 4);
=20
-static void gen_lvsl(DisasContext *ctx)
-{
-    TCGv_ptr rd;
-    TCGv EA;
-    if (unlikely(!ctx->altivec_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VPU);
-        return;
-    }
-    EA =3D tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
-    rd =3D gen_avr_ptr(rD(ctx->opcode));
-    gen_helper_lvsl(rd, EA);
-    tcg_temp_free(EA);
-    tcg_temp_free_ptr(rd);
-}
-
-static void gen_lvsr(DisasContext *ctx)
-{
-    TCGv_ptr rd;
-    TCGv EA;
-    if (unlikely(!ctx->altivec_enabled)) {
-        gen_exception(ctx, POWERPC_EXCP_VPU);
-        return;
-    }
-    EA =3D tcg_temp_new();
-    gen_addr_reg_index(ctx, EA);
-    rd =3D gen_avr_ptr(rD(ctx->opcode));
-    gen_helper_lvsr(rd, EA);
-    tcg_temp_free(EA);
-    tcg_temp_free_ptr(rd);
-}
-
 static void gen_mfvscr(DisasContext *ctx)
 {
     TCGv_i32 t;
@@ -316,6 +284,16 @@ static void glue(gen_, name)(DisasContext *ctx)     =
                    \
     tcg_temp_free_ptr(rd);                                              =
\
 }
=20
+#define GEN_VXFORM_TRANS(name, opc2, opc3)                              =
\
+static void glue(gen_, name)(DisasContext *ctx)                         =
\
+{                                                                       =
\
+    if (unlikely(!ctx->altivec_enabled)) {                              =
\
+        gen_exception(ctx, POWERPC_EXCP_VPU);                           =
\
+        return;                                                         =
\
+    }                                                                   =
\
+    trans_##name(ctx);                                                  =
\
+}
+
 #define GEN_VXFORM_ENV(name, opc2, opc3)                                =
\
 static void glue(gen_, name)(DisasContext *ctx)                         =
\
 {                                                                       =
\
@@ -515,6 +493,105 @@ static void gen_vmrgow(DisasContext *ctx)
     tcg_temp_free_i64(avr);
 }
=20
+/*
+ * lvsl VRT,RA,RB - Load Vector for Shift Left
+ *
+ * Let the EA be the sum (rA|0)+(rB). Let sh=3DEA[28=E2=80=9331].
+ * Let X be the 32-byte value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1=
F.
+ * Bytes sh:sh+15 of X are placed into vD.
+ */
+static void trans_lvsl(DisasContext *ctx)
+{
+    int VT =3D rD(ctx->opcode);
+    TCGv_i64 result =3D tcg_temp_new_i64();
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+    TCGv_i64 sh =3D tcg_temp_new_i64();
+    TCGv_i64 EA =3D tcg_temp_new();
+    int i;
+
+    /* Get sh(from description) by anding EA with 0xf. */
+    gen_addr_reg_index(ctx, EA);
+    tcg_gen_andi_i64(sh, EA, 0xfULL);
+    /*
+     * Create bytes sh:sh+7 of X(from description) and place them in
+     * higher doubleword of vD.
+     */
+    tcg_gen_addi_i64(result, sh, 7);
+    for (i =3D 7; i >=3D 1; i--) {
+        tcg_gen_shli_i64(tmp, sh, i * 8);
+        tcg_gen_or_i64(result, result, tmp);
+        tcg_gen_addi_i64(sh, sh, 1);
+    }
+    set_avr64(VT, result, true);
+    /*
+     * Create bytes sh+8:sh+15 of X(from description) and place them in
+     * lower doubleword of vD.
+     */
+    tcg_gen_addi_i64(result, sh, 8);
+    for (i =3D 7; i >=3D 1; i--) {
+        tcg_gen_addi_i64(sh, sh, 1);
+        tcg_gen_shli_i64(tmp, sh, i * 8);
+        tcg_gen_or_i64(result, result, tmp);
+    }
+    set_avr64(VT, result, false);
+
+    tcg_temp_free_i64(result);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(sh);
+    tcg_temp_free(EA);
+}
+
+/*
+ * lvsr VRT,RA,RB - Load Vector for Shift Right
+ *
+ * Let the EA be the sum (rA|0)+(rB). Let sh=3DEA[28=E2=80=9331].
+ * Let X be the 32-byte value 0x00 || 0x01 || 0x02 || ... || 0x1E || 0x1=
F.
+ * Bytes (16-sh):(31-sh) of X are placed into vD.
+ */
+static void trans_lvsr(DisasContext *ctx)
+{
+    int VT =3D rD(ctx->opcode);
+    TCGv_i64 result =3D tcg_temp_new_i64();
+    TCGv_i64 tmp =3D tcg_temp_new_i64();
+    TCGv_i64 sh =3D tcg_temp_new_i64();
+    TCGv_i64 EA =3D tcg_temp_new();
+    int i;
+
+    /* Get sh(from description) by anding EA with 0xf. */
+    gen_addr_reg_index(ctx, EA);
+    tcg_gen_andi_i64(sh, EA, 0xfULL);
+    /* Make (16-sh) and save it in sh. */
+    tcg_gen_subi_i64(sh, sh, 0x10ULL);
+    tcg_gen_neg_i64(sh, sh);
+    /*
+     * Create bytes (16-sh):(23-sh) of X(from description) and place the=
m in
+     * higher doubleword of vD.
+     */
+    tcg_gen_addi_i64(result, sh, 7);
+    for (i =3D 7; i >=3D 1; i--) {
+        tcg_gen_shli_i64(tmp, sh, i * 8);
+        tcg_gen_or_i64(result, result, tmp);
+        tcg_gen_addi_i64(sh, sh, 1);
+    }
+    set_avr64(VT, result, true);
+    /*
+     * Create bytes (24-sh):(32-sh) of X(from description) and place the=
m in
+     * lower doubleword of vD.
+     */
+    tcg_gen_addi_i64(result, sh, 8);
+    for (i =3D 7; i >=3D 1; i--) {
+        tcg_gen_addi_i64(sh, sh, 1);
+        tcg_gen_shli_i64(tmp, sh, i * 8);
+        tcg_gen_or_i64(result, result, tmp);
+    }
+    set_avr64(VT, result, false);
+
+    tcg_temp_free_i64(result);
+    tcg_temp_free_i64(tmp);
+    tcg_temp_free_i64(sh);
+    tcg_temp_free(EA);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -657,6 +734,8 @@ GEN_VXFORM_DUAL(vmrgow, PPC_NONE, PPC2_ALTIVEC_207,
 GEN_VXFORM_HETRO(vextubrx, 6, 28)
 GEN_VXFORM_HETRO(vextuhrx, 6, 29)
 GEN_VXFORM_HETRO(vextuwrx, 6, 30)
+GEN_VXFORM_TRANS(lvsl, 6, 31)
+GEN_VXFORM_TRANS(lvsr, 6, 32)
 GEN_VXFORM_DUAL(vmrgew, PPC_NONE, PPC2_ALTIVEC_207, \
                 vextuwrx, PPC_NONE, PPC2_ISA300)
=20
--=20
2.7.4


