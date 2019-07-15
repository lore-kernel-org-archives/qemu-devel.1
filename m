Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77E78C76191
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:25:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53D842053B
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53D842053B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39352 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn1vQ-0007XH-FA
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:25:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32915)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hn1ti-0008St-M9
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:24:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hn1tg-0002Yq-Kg
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:24:10 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:36902 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hn1tg-0002Xl-A4
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:24:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 677DF1A2081;
 Mon, 15 Jul 2019 16:23:02 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 1D1C71A20A2;
 Mon, 15 Jul 2019 16:23:02 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Mon, 15 Jul 2019 16:22:52 +0200
Message-Id: <1563200574-11098-7-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1563200574-11098-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v5 6/8] target/ppc: Optimize emulation of vclzw
 instruction
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

Optimize Altivec instruction vclzw (Vector Count Leading Zeros Word).
This instruction counts the number of leading zeros of each word element
in source register and places result in the appropriate word element of
destination register.

Counting is to be performed in four iterations of for loop(one for each
word elemnt of source register vB). Every iteration consists of loading
appropriate word element from source register, counting leading zeros
with tcg_gen_clzi_i32, and saving the result in appropriate word element
of destination register.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  1 -
 target/ppc/int_helper.c             |  3 ---
 target/ppc/translate/vmx-impl.inc.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index 3b92e3b..595241c 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -305,7 +305,6 @@ DEF_HELPER_4(vctsxs, void, env, avr, avr, i32)
 
 DEF_HELPER_2(vclzb, void, avr, avr)
 DEF_HELPER_2(vclzh, void, avr, avr)
-DEF_HELPER_2(vclzw, void, avr, avr)
 DEF_HELPER_2(vctzb, void, avr, avr)
 DEF_HELPER_2(vctzh, void, avr, avr)
 DEF_HELPER_2(vctzw, void, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 3134798..82cb12e 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1802,15 +1802,12 @@ VUPK(lsw, s64, s32, UPKLO)
 
 #define clzb(v) ((v) ? clz32((uint32_t)(v) << 24) : 8)
 #define clzh(v) ((v) ? clz32((uint32_t)(v) << 16) : 16)
-#define clzw(v) clz32((v))
 
 VGENERIC_DO(clzb, u8)
 VGENERIC_DO(clzh, u16)
-VGENERIC_DO(clzw, u32)
 
 #undef clzb
 #undef clzh
-#undef clzw
 
 #define ctzb(v) ((v) ? ctz32(v) : 8)
 #define ctzh(v) ((v) ? ctz32(v) : 16)
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index 75c5c8c..456666a 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -840,6 +840,32 @@ static void trans_vgbbd(DisasContext *ctx)
 }
 
 /*
+ * vclzw VRT,VRB - Vector Count Leading Zeros Word
+ *
+ * Counting the number of leading zero bits of each word element in source
+ * register and placing result in appropriate word element of destination
+ * register.
+ */
+static void trans_vclzw(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i32 tmp = tcg_temp_new_i32();
+    int i;
+
+    /* Perform count for every word element using tcg_gen_clzi_i32. */
+    for (i = 0; i < 4; i++) {
+        tcg_gen_ld_i32(tmp, cpu_env,
+            offsetof(CPUPPCState, vsr[32 + VB].u64[0]) + i * 4);
+        tcg_gen_clzi_i32(tmp, tmp, 32);
+        tcg_gen_st_i32(tmp, cpu_env,
+            offsetof(CPUPPCState, vsr[32 + VT].u64[0]) + i * 4);
+    }
+
+    tcg_temp_free_i32(tmp);
+}
+
+/*
  * vclzd VRT,VRB - Vector Count Leading Zeros Doubleword
  *
  * Counting the number of leading zero bits of each doubleword element in source
@@ -1380,7 +1406,7 @@ GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23)
 
 GEN_VXFORM_NOA(vclzb, 1, 28)
 GEN_VXFORM_NOA(vclzh, 1, 29)
-GEN_VXFORM_NOA(vclzw, 1, 30)
+GEN_VXFORM_TRANS(vclzw, 1, 30)
 GEN_VXFORM_TRANS(vclzd, 1, 31)
 GEN_VXFORM_NOA_2(vnegw, 1, 24, 6)
 GEN_VXFORM_NOA_2(vnegd, 1, 24, 7)
-- 
2.7.4


