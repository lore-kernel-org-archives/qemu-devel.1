Return-Path: <SRS0=M7c2=5J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 845CFC4332B
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:28:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B7920719
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2020 12:28:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="eZ4cUNv7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B7920719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47996 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jGife-0004uq-WD
	for qemu-devel@archiver.kernel.org; Tue, 24 Mar 2020 08:28:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41635)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jGibF-0008S3-7T
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:24:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jGibD-0000cg-Ov
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:24:05 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17872)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jGibA-0000YW-0A
 for qemu-devel@nongnu.org; Tue, 24 Mar 2020 08:24:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585052553; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=Te1pLNktjmg6b1Q72s5fbp/U+T2zhe94qT7V+emS51Y=;
 b=eZ4cUNv7+5uASgdgEKKlf6D1/p3TiRXCDG/m5S5+RJ6hzPf5lkdwD7l0nHwCbFYB
 6HM8J4wvThe8W11O0eGkBSkpZklz3OIgypb6VCRPGmr1jLkQIDB9vE6jGmiR5eylcQi
 pjTX1YWObV0qbUE6S4PT9YkzWOXOPd3aDIX1WY7M=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by
 mx.zoho.com.cn with SMTPS id 1585052548839456.6551251032387;
 Tue, 24 Mar 2020 20:22:28 +0800 (CST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Message-ID: <20200324122212.11156-1-jiaxun.yang@flygoat.com>
Subject: [PATCH for-5.0,
 v1] target/mips: Fix loongson multimedia condition instructions
Date: Tue, 24 Mar 2020 20:22:12 +0800
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
Cc: richard.henderson@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 aleksandar.qemu.devel@gmail.com, Huacai Chen <chenhc@lemote.com>,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Loongson multimedia condition instructions were previously implemented as
write 0 to rd due to lack of documentation. So I just confirmed with Loongs=
on
about their encoding and implemented them correctly.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Acked-by: Huacai Chen <chenhc@lemote.com>
---
v1: Use deposit opreations according to Richard's suggestion.
---
 target/mips/translate.c | 35 +++++++++++++++++++++++++++++++----
 1 file changed, 31 insertions(+), 4 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index d745bd2803..25b595a17d 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5529,6 +5529,7 @@ static void gen_loongson_multimedia(DisasContext *ctx=
, int rd, int rs, int rt)
 {
     uint32_t opc, shift_max;
     TCGv_i64 t0, t1;
+    TCGCond cond;
=20
     opc =3D MASK_LMI(ctx->opcode);
     switch (opc) {
@@ -5862,14 +5863,39 @@ static void gen_loongson_multimedia(DisasContext *c=
tx, int rd, int rs, int rt)
=20
     case OPC_SEQU_CP2:
     case OPC_SEQ_CP2:
+        cond =3D TCG_COND_EQ;
+        goto do_cc_cond;
+        break;
     case OPC_SLTU_CP2:
+        cond =3D TCG_COND_LTU;
+        goto do_cc_cond;
+        break;
     case OPC_SLT_CP2:
+        cond =3D TCG_COND_LT;
+        goto do_cc_cond;
+        break;
     case OPC_SLEU_CP2:
+        cond =3D TCG_COND_LEU;
+        goto do_cc_cond;
+        break;
     case OPC_SLE_CP2:
-        /*
-         * ??? Document is unclear: Set FCC[CC].  Does that mean the
-         * FD field is the CC field?
-         */
+        cond =3D TCG_COND_LE;
+    do_cc_cond:
+        {
+            int cc =3D (ctx->opcode >> 8) & 0x7;
+            TCGv_i64 t64 =3D tcg_temp_new_i64();
+            TCGv_i32 t32 =3D tcg_temp_new_i32();
+
+            tcg_gen_setcond_i64(cond, t64, t0, t1);
+            tcg_gen_extrl_i64_i32(t32, t64);
+            tcg_gen_deposit_i32(fpu_fcr31, fpu_fcr31, t32,
+                                get_fp_bit(cc), 1);
+
+            tcg_temp_free_i32(t32);
+            tcg_temp_free_i64(t64);
+        }
+        goto no_rd;
+        break;
     default:
         MIPS_INVAL("loongson_cp2");
         generate_exception_end(ctx, EXCP_RI);
@@ -5878,6 +5904,7 @@ static void gen_loongson_multimedia(DisasContext *ctx=
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



