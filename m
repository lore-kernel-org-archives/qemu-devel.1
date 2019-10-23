Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 432C9CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:05:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14D6420650
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 11:05:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14D6420650
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60416 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNESj-0003xa-Ua
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 07:05:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43042)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iNDpz-00010k-Ug
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:25:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1iNDpx-00032E-WF
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:25:55 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:35870 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1iNDpv-0002yq-Lt
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 06:25:53 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 685961A1E62;
 Wed, 23 Oct 2019 12:24:43 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id B1A2C1A219A;
 Wed, 23 Oct 2019 12:24:00 +0200 (CEST)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v7 14/14] target/mips: Demacro LMI decoder
Date: Wed, 23 Oct 2019 12:23:47 +0200
Message-Id: <1571826227-10583-15-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1571826227-10583-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1571826227-10583-1-git-send-email-aleksandar.markovic@rt-rk.com>
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
Cc: aleksandar.rikalo@rt-rk.com, Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aleksandar Markovic <amarkovic@wavecomp.com>

This makes searches for instances of opcode usages easier.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 target/mips/translate.c | 247 +++++++++++++++++++++++++++++++++---------------
 1 file changed, 173 insertions(+), 74 deletions(-)

diff --git a/target/mips/translate.c b/target/mips/translate.c
index b8e2707..36f57b1 100644
--- a/target/mips/translate.c
+++ b/target/mips/translate.c
@@ -5548,78 +5548,180 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
     gen_load_fpr64(ctx, t0, rs);
     gen_load_fpr64(ctx, t1, rt);
 
-#define LMI_HELPER(UP, LO) \
-    case OPC_##UP: gen_helper_##LO(t0, t0, t1); break
-#define LMI_HELPER_1(UP, LO) \
-    case OPC_##UP: gen_helper_##LO(t0, t0); break
-#define LMI_DIRECT(UP, LO, OP) \
-    case OPC_##UP: tcg_gen_##OP##_i64(t0, t0, t1); break
-
     switch (opc) {
-    LMI_HELPER(PADDSH, paddsh);
-    LMI_HELPER(PADDUSH, paddush);
-    LMI_HELPER(PADDH, paddh);
-    LMI_HELPER(PADDW, paddw);
-    LMI_HELPER(PADDSB, paddsb);
-    LMI_HELPER(PADDUSB, paddusb);
-    LMI_HELPER(PADDB, paddb);
-
-    LMI_HELPER(PSUBSH, psubsh);
-    LMI_HELPER(PSUBUSH, psubush);
-    LMI_HELPER(PSUBH, psubh);
-    LMI_HELPER(PSUBW, psubw);
-    LMI_HELPER(PSUBSB, psubsb);
-    LMI_HELPER(PSUBUSB, psubusb);
-    LMI_HELPER(PSUBB, psubb);
-
-    LMI_HELPER(PSHUFH, pshufh);
-    LMI_HELPER(PACKSSWH, packsswh);
-    LMI_HELPER(PACKSSHB, packsshb);
-    LMI_HELPER(PACKUSHB, packushb);
-
-    LMI_HELPER(PUNPCKLHW, punpcklhw);
-    LMI_HELPER(PUNPCKHHW, punpckhhw);
-    LMI_HELPER(PUNPCKLBH, punpcklbh);
-    LMI_HELPER(PUNPCKHBH, punpckhbh);
-    LMI_HELPER(PUNPCKLWD, punpcklwd);
-    LMI_HELPER(PUNPCKHWD, punpckhwd);
-
-    LMI_HELPER(PAVGH, pavgh);
-    LMI_HELPER(PAVGB, pavgb);
-    LMI_HELPER(PMAXSH, pmaxsh);
-    LMI_HELPER(PMINSH, pminsh);
-    LMI_HELPER(PMAXUB, pmaxub);
-    LMI_HELPER(PMINUB, pminub);
-
-    LMI_HELPER(PCMPEQW, pcmpeqw);
-    LMI_HELPER(PCMPGTW, pcmpgtw);
-    LMI_HELPER(PCMPEQH, pcmpeqh);
-    LMI_HELPER(PCMPGTH, pcmpgth);
-    LMI_HELPER(PCMPEQB, pcmpeqb);
-    LMI_HELPER(PCMPGTB, pcmpgtb);
-
-    LMI_HELPER(PSLLW, psllw);
-    LMI_HELPER(PSLLH, psllh);
-    LMI_HELPER(PSRLW, psrlw);
-    LMI_HELPER(PSRLH, psrlh);
-    LMI_HELPER(PSRAW, psraw);
-    LMI_HELPER(PSRAH, psrah);
-
-    LMI_HELPER(PMULLH, pmullh);
-    LMI_HELPER(PMULHH, pmulhh);
-    LMI_HELPER(PMULHUH, pmulhuh);
-    LMI_HELPER(PMADDHW, pmaddhw);
-
-    LMI_HELPER(PASUBUB, pasubub);
-    LMI_HELPER_1(BIADD, biadd);
-    LMI_HELPER_1(PMOVMSKB, pmovmskb);
-
-    LMI_DIRECT(PADDD, paddd, add);
-    LMI_DIRECT(PSUBD, psubd, sub);
-    LMI_DIRECT(XOR_CP2, xor, xor);
-    LMI_DIRECT(NOR_CP2, nor, nor);
-    LMI_DIRECT(AND_CP2, and, and);
-    LMI_DIRECT(OR_CP2, or, or);
+    case OPC_PADDSH:
+        gen_helper_paddsh(t0, t0, t1);
+        break;
+    case OPC_PADDUSH:
+        gen_helper_paddush(t0, t0, t1);
+        break;
+    case OPC_PADDH:
+        gen_helper_paddh(t0, t0, t1);
+        break;
+    case OPC_PADDW:
+        gen_helper_paddw(t0, t0, t1);
+        break;
+    case OPC_PADDSB:
+        gen_helper_paddsb(t0, t0, t1);
+        break;
+    case OPC_PADDUSB:
+        gen_helper_paddusb(t0, t0, t1);
+        break;
+    case OPC_PADDB:
+        gen_helper_paddb(t0, t0, t1);
+        break;
+
+    case OPC_PSUBSH: gen_helper_psubsh(t0, t0, t1);
+        break;
+    case OPC_PSUBUSH:
+        gen_helper_psubush(t0, t0, t1);
+        break;
+    case OPC_PSUBH:
+        gen_helper_psubh(t0, t0, t1);
+        break;
+    case OPC_PSUBW:
+        gen_helper_psubw(t0, t0, t1);
+        break;
+    case OPC_PSUBSB:
+        gen_helper_psubsb(t0, t0, t1);
+        break;
+    case OPC_PSUBUSB:
+        gen_helper_psubusb(t0, t0, t1);
+        break;
+    case OPC_PSUBB:
+        gen_helper_psubb(t0, t0, t1);
+        break;
+
+    case OPC_PSHUFH:
+        gen_helper_pshufh(t0, t0, t1);
+        break;
+    case OPC_PACKSSWH:
+        gen_helper_packsswh(t0, t0, t1);
+        break;
+    case OPC_PACKSSHB:
+        gen_helper_packsshb(t0, t0, t1);
+        break;
+    case OPC_PACKUSHB:
+        gen_helper_packushb(t0, t0, t1);
+        break;
+
+    case OPC_PUNPCKLHW:
+        gen_helper_punpcklhw(t0, t0, t1);
+        break;
+    case OPC_PUNPCKHHW:
+        gen_helper_punpckhhw(t0, t0, t1);
+        break;
+    case OPC_PUNPCKLBH:
+        gen_helper_punpcklbh(t0, t0, t1);
+        break;
+    case OPC_PUNPCKHBH:
+        gen_helper_punpckhbh(t0, t0, t1);
+        break;
+    case OPC_PUNPCKLWD:
+        gen_helper_punpcklwd(t0, t0, t1);
+        break;
+    case OPC_PUNPCKHWD:
+        gen_helper_punpckhwd(t0, t0, t1);
+        break;
+
+    case OPC_PAVGH:
+        gen_helper_pavgh(t0, t0, t1);
+        break;
+    case OPC_PAVGB:
+        gen_helper_pavgb(t0, t0, t1);
+        break;
+    case OPC_PMAXSH:
+        gen_helper_pmaxsh(t0, t0, t1);
+        break;
+    case OPC_PMINSH:
+        gen_helper_pminsh(t0, t0, t1);
+        break;
+    case OPC_PMAXUB:
+        gen_helper_pmaxub(t0, t0, t1);
+        break;
+    case OPC_PMINUB:
+        gen_helper_pminub(t0, t0, t1);
+        break;
+
+    case OPC_PCMPEQW:
+        gen_helper_pcmpeqw(t0, t0, t1);
+        break;
+    case OPC_PCMPGTW:
+        gen_helper_pcmpgtw(t0, t0, t1);
+        break;
+    case OPC_PCMPEQH:
+        gen_helper_pcmpeqh(t0, t0, t1);
+        break;
+    case OPC_PCMPGTH:
+        gen_helper_pcmpgth(t0, t0, t1);
+        break;
+    case OPC_PCMPEQB:
+        gen_helper_pcmpeqb(t0, t0, t1);
+        break;
+    case OPC_PCMPGTB:
+        gen_helper_pcmpgtb(t0, t0, t1);
+        break;
+
+    case OPC_PSLLW:
+        gen_helper_psllw(t0, t0, t1);
+        break;
+    case OPC_PSLLH:
+        gen_helper_psllh(t0, t0, t1);
+        break;
+    case OPC_PSRLW:
+        gen_helper_psrlw(t0, t0, t1);
+        break;
+    case OPC_PSRLH:
+        gen_helper_psrlh(t0, t0, t1);
+        break;
+    case OPC_PSRAW:
+        gen_helper_psraw(t0, t0, t1);
+        break;
+    case OPC_PSRAH:
+        gen_helper_psrah(t0, t0, t1);
+        break;
+
+    case OPC_PMULLH:
+        gen_helper_pmullh(t0, t0, t1);
+        break;
+    case OPC_PMULHH:
+        gen_helper_pmulhh(t0, t0, t1);
+        break;
+    case OPC_PMULHUH:
+        gen_helper_pmulhuh(t0, t0, t1);
+        break;
+    case OPC_PMADDHW:
+        gen_helper_pmaddhw(t0, t0, t1);
+        break;
+
+    case OPC_PASUBUB:
+        gen_helper_pasubub(t0, t0, t1);
+        break;
+    case OPC_BIADD:
+        gen_helper_biadd(t0, t0);
+        break;
+    case OPC_PMOVMSKB:
+        gen_helper_pmovmskb(t0, t0);
+        break;
+
+    case OPC_PADDD:
+        tcg_gen_add_i64(t0, t0, t1);
+        break;
+    case OPC_PSUBD:
+        tcg_gen_sub_i64(t0, t0, t1);
+        break;
+    case OPC_XOR_CP2:
+        tcg_gen_xor_i64(t0, t0, t1);
+        break;
+    case OPC_NOR_CP2:
+        tcg_gen_nor_i64(t0, t0, t1);
+        break;
+    case OPC_AND_CP2:
+        tcg_gen_and_i64(t0, t0, t1);
+        break;
+    case OPC_OR_CP2:
+        tcg_gen_or_i64(t0, t0, t1);
+        break;
 
     case OPC_PANDN:
         tcg_gen_andc_i64(t0, t1, t0);
@@ -5772,9 +5874,6 @@ static void gen_loongson_multimedia(DisasContext *ctx, int rd, int rs, int rt)
         return;
     }
 
-#undef LMI_HELPER
-#undef LMI_DIRECT
-
     gen_store_fpr64(ctx, t0, rd);
 
     tcg_temp_free_i64(t0);
-- 
2.7.4


