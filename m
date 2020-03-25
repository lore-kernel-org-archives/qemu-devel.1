Return-Path: <SRS0=PjAl=5K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6FFC54FD0
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ACD4F2077D
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2020 10:07:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=flygoat.com header.i=jiaxun.yang@flygoat.com header.b="D88QaeVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ACD4F2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=flygoat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jH2wT-0003Iw-OW
	for qemu-devel@archiver.kernel.org; Wed, 25 Mar 2020 06:07:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58021)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vR-00023T-HW
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jiaxun.yang@flygoat.com>) id 1jH2vQ-0006nv-Ca
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:17 -0400
Received: from sender3-op-o12.zoho.com.cn ([124.251.121.243]:17977)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1jH2vP-0006l6-K0
 for qemu-devel@nongnu.org; Wed, 25 Mar 2020 06:06:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1585130732; 
 s=mail; d=flygoat.com; i=jiaxun.yang@flygoat.com;
 h=From:To:Cc:Message-ID:Subject:Date:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=qSOKUP5jgt+GUvLRCzrVgQmtfvEOkW4n979u095348A=;
 b=D88QaeVUGD1hLRtMDjwmuAd9yAvgK55zx7/pRcb+tJ8fmbp6+OMmoCSluo3G2FwJ
 mfphID6WC2mHf5VLDCIWFa7AyOaCiIlNHPdt3k8MFs4rG7g0e7f/VBjoHG9qp7hIMKz
 qV7ZG6LaXlJjr4cEXj25duhFWrQxYge3tRM5Fxw4=
Received: from localhost.localdomain (39.155.141.144 [39.155.141.144]) by
 mx.zoho.com.cn with SMTPS id 1585130730450706.2792337116358;
 Wed, 25 Mar 2020 18:05:30 +0800 (CST)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Message-ID: <20200325100520.206210-2-jiaxun.yang@flygoat.com>
Subject: [PATCH 1/3] target/mips: Introduce loongson ext & mmi ASE flags
Date: Wed, 25 Mar 2020 18:05:18 +0800
X-Mailer: git-send-email 2.26.0.rc2
In-Reply-To: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
References: <20200325100520.206210-1-jiaxun.yang@flygoat.com>
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
Cc: chenhc@lemote.com, aleksandar.qemu.devel@gmail.com,
 aleksandar.rikalo@rt-rk.com, aurelien@aurel32.net,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Start from Loongson-3A, loongson treat their extension instructions
as ASE and implemented mips64r2 as their baseline ISA.
Here we simply identify instructions shared between 2F and 3A and
mark them with MMI or EXT flag.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 target/mips/mips-defs.h | 2 ++
 target/mips/translate.c | 9 +++++----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/target/mips/mips-defs.h b/target/mips/mips-defs.h
index a831bb4384..1d25417c76 100644
--- a/target/mips/mips-defs.h
+++ b/target/mips/mips-defs.h
@@ -58,6 +58,8 @@
  */
 #define ASE_MMI           0x0100000000000000ULL
 #define ASE_MXU           0x0200000000000000ULL
+#define ASE_LOONGSON_MMI  0x0400000000000000ULL
+#define ASE_LOONGSON_EXT  0x0800000000000000ULL
=20
 /* MIPS CPU defines. */
 #define CPU_MIPS1       (ISA_MIPS1)
diff --git a/target/mips/translate.c b/target/mips/translate.c
index 25b595a17d..2d556e0dea 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -3421,7 +3421,8 @@ static void gen_ld(DisasContext *ctx, uint32_t opc,
     TCGv t0, t1, t2;
     int mem_idx =3D ctx->mem_idx;
=20
-    if (rt =3D=3D 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2=
F)) {
+    if (rt =3D=3D 0 && ctx->insn_flags & (INSN_LOONGSON2E | INSN_LOONGSON2=
F |
+                                        ASE_LOONGSON_EXT)) {
         /*
          * Loongson CPU uses a load to zero register for prefetch.
          * We emulate it as a NOP. On other CPU we must perform the
@@ -27161,7 +27162,7 @@ static void decode_opc_special2_legacy(CPUMIPSState=
 *env, DisasContext *ctx)
     case OPC_MULTU_G_2F:
     case OPC_MOD_G_2F:
     case OPC_MODU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, INSN_LOONGSON2F | ASE_LOONGSON_EXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
     case OPC_CLO:
@@ -27194,7 +27195,7 @@ static void decode_opc_special2_legacy(CPUMIPSState=
 *env, DisasContext *ctx)
     case OPC_DDIVU_G_2F:
     case OPC_DMOD_G_2F:
     case OPC_DMODU_G_2F:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, INSN_LOONGSON2F | ASE_LOONGSON_EXT);
         gen_loongson_integer(ctx, op1, rd, rs, rt);
         break;
 #endif
@@ -30641,7 +30642,7 @@ static void decode_opc(CPUMIPSState *env, DisasCont=
ext *ctx)
         }
         break;
     case OPC_CP2:
-        check_insn(ctx, INSN_LOONGSON2F);
+        check_insn(ctx, INSN_LOONGSON2F | ASE_LOONGSON_MMI);
         /* Note that these instructions use different fields.  */
         gen_loongson_multimedia(ctx, sa, rd, rt);
         break;
--=20
2.26.0.rc2



