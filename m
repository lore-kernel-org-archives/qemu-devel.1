Return-Path: <SRS0=wc0w=5G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07830C4332B
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 04:58:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C185320732
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Mar 2020 04:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="deadmpRS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C185320732
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33344 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jFWDn-0006XJ-Tq
	for qemu-devel@archiver.kernel.org; Sat, 21 Mar 2020 00:58:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57589)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jFWCo-00068n-Q2
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 00:57:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jFWCn-0002WX-El
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 00:57:54 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17944)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jFWCm-0002Ti-Mh
 for qemu-devel@nongnu.org; Sat, 21 Mar 2020 00:57:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1584766587; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=IrUwZYDlVUl0Cso7UDd732bv2cTTBb46bBm2xsgiVCA=;
 b=deadmpRSZMNQtFKUGREd/I3whbl2fC3pACYjsGJJS+MnhwbxQfg9IQjqX7itgXC+
 vDYrtaNAUf4o15D9JJyvTrl6Qr3C3ITgv+WOIb5Y3RcMcvfkqsM0ZBr0376YM6oQoa2
 Q2BprLhFsmWDXNPuXjCXgoFDgg2AoPMzavxrZdys=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by
 mx.zoho.com.cn with SMTPS id 1584766586393694.3311398142279;
 Sat, 21 Mar 2020 12:56:26 +0800 (CST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Message-ID: <20200321045621.2139953-1-jiaxun.yang@flygoat.com>
Subject: [PATCH] target/mips: Fix loongson multimedia condition instructions
Date: Sat, 21 Mar 2020 12:56:21 +0800
X-Mailer: git-send-email 2.26.0.rc2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoCNMailClient: External
Content-Type: text/plain; charset=utf8
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 124.251.121.243
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
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson multimedia condition instructions were previously implemented as
write 0 to rd due to lack of documentation. So I just confirmed with Loongs=
on
about their encoding and implemented them correctly.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/translate.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d745bd2803..43be8d27b5 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5529,6 +5529,8 @@ static void gen_loongson_multimedia(DisasContext *ctx=
, int rd, int rs, int rt)
 {
     uint32_t opc, shift_max;
     TCGv_i64 t0, t1;
+    TCGCond cond;
+    TCGLabel *lab;
=20
     opc =3D MASK_LMI(ctx->opcode);
     switch (opc) {
@@ -5816,7 +5818,7 @@ static void gen_loongson_multimedia(DisasContext *ctx=
, int rd, int rs, int rt)
     case OPC_DADD_CP2:
         {
             TCGv_i64 t2 =3D tcg_temp_new_i64();
-            TCGLabel *lab =3D gen_new_label();
+            lab =3D gen_new_label();
=20
             tcg_gen_mov_i64(t2, t0);
             tcg_gen_add_i64(t0, t1, t2);
@@ -5837,7 +5839,7 @@ static void gen_loongson_multimedia(DisasContext *ctx=
, int rd, int rs, int rt)
     case OPC_DSUB_CP2:
         {
             TCGv_i64 t2 =3D tcg_temp_new_i64();
-            TCGLabel *lab =3D gen_new_label();
+            lab =3D gen_new_label();
=20
             tcg_gen_mov_i64(t2, t0);
             tcg_gen_sub_i64(t0, t1, t2);
@@ -5862,14 +5864,39 @@ static void gen_loongson_multimedia(DisasContext *c=
tx, int rd, int rs, int rt)
=20
     case OPC_SEQU_CP2:
     case OPC_SEQ_CP2:
+        cond =3D TCG_COND_EQ;
+        goto do_cc_cond;
+        break;
+
     case OPC_SLTU_CP2:
+        cond =3D TCG_COND_LTU;
+        goto do_cc_cond;
+        break;
+
     case OPC_SLT_CP2:
+        cond =3D TCG_COND_LT;
+        goto do_cc_cond;
+        break;
+
     case OPC_SLEU_CP2:
+        cond =3D TCG_COND_LEU;
+        goto do_cc_cond;
+        break;
+
     case OPC_SLE_CP2:
-        /*
-         * ??? Document is unclear: Set FCC[CC].  Does that mean the
-         * FD field is the CC field?
-         */
+        cond =3D TCG_COND_LE;
+    do_cc_cond:
+        {
+            int cc =3D (ctx->opcode >> 8) & 0x7;
+            lab =3D gen_new_label();
+            tcg_gen_ori_i32(fpu_fcr31, fpu_fcr31, 1 << get_fp_bit(cc));
+            tcg_gen_brcond_i64(cond, t0, t1, lab);
+            tcg_gen_xori_i32(fpu_fcr31, fpu_fcr31, 1 << get_fp_bit(cc));
+            gen_set_label(lab);
+        }
+        goto no_rd;
+        break;
+
     default:
         MIPS_INVAL("loongson_cp2");
         generate_exception_end(ctx, EXCP_RI);
@@ -5878,6 +5905,7 @@ static void gen_loongson_multimedia(DisasContext *ctx=
, int rd, int rs, int rt)
=20
     gen_store_fpr64(ctx, t0, rd);
=20
+no_rd:
     tcg_temp_free_i64(t0);
     tcg_temp_free_i64(t1);
 }
--=20
2.26.0.rc2



