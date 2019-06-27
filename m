Return-Path: <SRS0=nUPg=U2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E782BC48BD6
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:59:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C407B2086D
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Jun 2019 10:59:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C407B2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hgS7o-0004HA-2M
	for qemu-devel@archiver.kernel.org; Thu, 27 Jun 2019 06:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55775)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5v-0001yZ-NP
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <stefan.brankovic@rt-rk.com>) id 1hgS5u-0001fX-8b
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:35 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53864 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <stefan.brankovic@rt-rk.com>)
 id 1hgS5t-0000fP-Th
 for qemu-devel@nongnu.org; Thu, 27 Jun 2019 06:57:34 -0400
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id B5B211A453F;
 Thu, 27 Jun 2019 12:56:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw870-lin.domain.local (rtrkw870-lin.domain.local
 [10.10.13.132])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 79C621A454D;
 Thu, 27 Jun 2019 12:56:29 +0200 (CEST)
From: Stefan Brankovic <stefan.brankovic@rt-rk.com>
To: qemu-devel@nongnu.org
Date: Thu, 27 Jun 2019 12:56:16 +0200
Message-Id: <1561632985-24866-5-git-send-email-stefan.brankovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
References: <1561632985-24866-1-git-send-email-stefan.brankovic@rt-rk.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 89.216.37.149
Subject: [Qemu-devel] [PATCH v4 04/13] target/ppc: Optimize emulation of
 vclzd instruction
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
Cc: stefan.brankovic@rt-rk.com, hsp.cat7@gmail.com,
 richard.henderson@linaro.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Optimize Altivec instruction vclzd (Vector Count Leading Zeros Doubleword).
This instruction counts the number of leading zeros of each doubleword element
in source register and places result in the appropriate doubleword element of
destination register.

Using tcg-s count leading zeros instruction two times(once for each
doubleword element of source register vB) and placing result in
appropriate doubleword element of destination register vD.

Signed-off-by: Stefan Brankovic <stefan.brankovic@rt-rk.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/ppc/helper.h                 |  1 -
 target/ppc/int_helper.c             |  3 ---
 target/ppc/translate/vmx-impl.inc.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 27 insertions(+), 5 deletions(-)

diff --git a/target/ppc/helper.h b/target/ppc/helper.h
index cf1af51..57a954c 100644
--- a/target/ppc/helper.h
+++ b/target/ppc/helper.h
@@ -307,7 +307,6 @@ DEF_HELPER_4(vctsxs, void, env, avr, avr, i32)
 DEF_HELPER_2(vclzb, void, avr, avr)
 DEF_HELPER_2(vclzh, void, avr, avr)
 DEF_HELPER_2(vclzw, void, avr, avr)
-DEF_HELPER_2(vclzd, void, avr, avr)
 DEF_HELPER_2(vctzb, void, avr, avr)
 DEF_HELPER_2(vctzh, void, avr, avr)
 DEF_HELPER_2(vctzw, void, avr, avr)
diff --git a/target/ppc/int_helper.c b/target/ppc/int_helper.c
index 87e3062..210e8be 100644
--- a/target/ppc/int_helper.c
+++ b/target/ppc/int_helper.c
@@ -1824,17 +1824,14 @@ VUPK(lsw, s64, s32, UPKLO)
 #define clzb(v) ((v) ? clz32((uint32_t)(v) << 24) : 8)
 #define clzh(v) ((v) ? clz32((uint32_t)(v) << 16) : 16)
 #define clzw(v) clz32((v))
-#define clzd(v) clz64((v))
 
 VGENERIC_DO(clzb, u8)
 VGENERIC_DO(clzh, u16)
 VGENERIC_DO(clzw, u32)
-VGENERIC_DO(clzd, u64)
 
 #undef clzb
 #undef clzh
 #undef clzw
-#undef clzd
 
 #define ctzb(v) ((v) ? ctz32(v) : 8)
 #define ctzh(v) ((v) ? ctz32(v) : 16)
diff --git a/target/ppc/translate/vmx-impl.inc.c b/target/ppc/translate/vmx-impl.inc.c
index d9b346b..50d906b 100644
--- a/target/ppc/translate/vmx-impl.inc.c
+++ b/target/ppc/translate/vmx-impl.inc.c
@@ -740,6 +740,32 @@ static void trans_vgbbd(DisasContext *ctx)
     tcg_temp_free_i64(avr[1]);
 }
 
+/*
+ * vclzd VRT,VRB - Vector Count Leading Zeros Doubleword
+ *
+ * Counting the number of leading zero bits of each doubleword element in source
+ * register and placing result in appropriate doubleword element of destination
+ * register.
+ */
+static void trans_vclzd(DisasContext *ctx)
+{
+    int VT = rD(ctx->opcode);
+    int VB = rB(ctx->opcode);
+    TCGv_i64 avr = tcg_temp_new_i64();
+
+    /* high doubleword */
+    get_avr64(avr, VB, true);
+    tcg_gen_clzi_i64(avr, avr, 64);
+    set_avr64(VT, avr, true);
+
+    /* low doubleword */
+    get_avr64(avr, VB, false);
+    tcg_gen_clzi_i64(avr, avr, 64);
+    set_avr64(VT, avr, false);
+
+    tcg_temp_free_i64(avr);
+}
+
 GEN_VXFORM(vmuloub, 4, 0);
 GEN_VXFORM(vmulouh, 4, 1);
 GEN_VXFORM(vmulouw, 4, 2);
@@ -1256,7 +1282,7 @@ GEN_VAFORM_PAIRED(vmaddfp, vnmsubfp, 23)
 GEN_VXFORM_NOA(vclzb, 1, 28)
 GEN_VXFORM_NOA(vclzh, 1, 29)
 GEN_VXFORM_NOA(vclzw, 1, 30)
-GEN_VXFORM_NOA(vclzd, 1, 31)
+GEN_VXFORM_TRANS(vclzd, 1, 31)
 GEN_VXFORM_NOA_2(vnegw, 1, 24, 6)
 GEN_VXFORM_NOA_2(vnegd, 1, 24, 7)
 GEN_VXFORM_NOA_2(vextsb2w, 1, 24, 16)
-- 
2.7.4


