Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F12C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:22:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12CE6233A2
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 10:22:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mail.uni-paderborn.de header.i=@mail.uni-paderborn.de header.b="NzoaWSnp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12CE6233A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0kF7-0007G2-1k
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 06:22:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60994)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDL-0005u9-R5
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kbastian@mail.uni-paderborn.de>) id 1i0kDK-0005c3-Mq
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:07 -0400
Received: from telepax.uni-paderborn.de ([131.234.189.14]:43960)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
 id 1i0kDK-0005az-DD
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 06:21:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=mail.uni-paderborn.de; s=20170601; h=Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sAfZKs3HXjlWqyQKXWkeuMVNCnEjK93bR+6+xewVvnQ=; b=NzoaWSnppenv4SfSQc7bEs1grC
 k4ASidRu8f0uSj7XK78VjA7PvHtERkBf4rjQbZ63y0vv9hcYWnGgEOkKTABN/e5ofQ2na4uZh4bu7
 uovTEOYj+aiaDHNmNCi7/TBfgtZwYWBbhIk4Mh1txntFByPwJTVHv0695VBUu3C69nKw=;
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 12:20:46 +0200
Message-Id: <20190822102046.8765-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
References: <20190822102046.8765-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-IMT-Spam-Score: 0.0 ()
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.8.22.101216, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.8.13.5630000
X-IMT-Authenticated-Sender: uid=kbastian,ou=People,o=upb,c=de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.14
Subject: [Qemu-devel] [PULL 5/5] target/tricore: Fix
 tricore_tr_translate_insn
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
Cc: peter.maydell@linaro.org, Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

we now fetch 2 bytes first, check whether we have a 32 bit insn, and only then
fetch another 2 bytes. We also make sure that a 16 bit insn that still fits
into the current page does not end up in the next page.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 47 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 88b2840ad1..4f10407477 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -8781,17 +8781,9 @@ static void decode_32Bit_opc(DisasContext *ctx)
     }
 }
 
-static void decode_opc(DisasContext *ctx)
+static bool tricore_insn_is_16bit(uint32_t insn)
 {
-    /* 16-Bit Instruction */
-    if ((ctx->opcode & 0x1) == 0) {
-        ctx->pc_succ_insn = ctx->base.pc_next + 2;
-        decode_16Bit_opc(ctx);
-    /* 32-Bit Instruction */
-    } else {
-        ctx->pc_succ_insn = ctx->base.pc_next + 4;
-        decode_32Bit_opc(ctx);
-    }
+    return (insn & 0x1) == 0;
 }
 
 static void tricore_tr_init_disas_context(DisasContextBase *dcbase,
@@ -8829,20 +8821,49 @@ static bool tricore_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
     return true;
 }
 
+static bool insn_crosses_page(CPUTriCoreState *env, DisasContext *ctx)
+{
+    /*
+     * Return true if the insn at ctx->base.pc_next might cross a page boundary.
+     * (False positives are OK, false negatives are not.)
+     * Our caller ensures we are only called if dc->base.pc_next is less than
+     * 4 bytes from the page boundary, so we cross the page if the first
+     * 16 bits indicate that this is a 32 bit insn.
+     */
+    uint16_t insn = cpu_lduw_code(env, ctx->base.pc_next);
+
+    return !tricore_insn_is_16bit(insn);
+}
+
+
 static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
 {
     DisasContext *ctx = container_of(dcbase, DisasContext, base);
     CPUTriCoreState *env = cpu->env_ptr;
+    uint16_t insn_lo;
+    bool is_16bit;
 
-    ctx->opcode = cpu_ldl_code(env, ctx->base.pc_next);
-    decode_opc(ctx);
+    insn_lo = cpu_lduw_code(env, ctx->base.pc_next);
+    is_16bit = tricore_insn_is_16bit(insn_lo);
+    if (is_16bit) {
+        ctx->opcode = insn_lo;
+        ctx->pc_succ_insn = ctx->base.pc_next + 2;
+        decode_16Bit_opc(ctx);
+    } else {
+        uint32_t insn_hi = cpu_lduw_code(env, ctx->base.pc_next + 2);
+        ctx->opcode = insn_hi << 16 | insn_lo;
+        ctx->pc_succ_insn = ctx->base.pc_next + 4;
+        decode_32Bit_opc(ctx);
+    }
     ctx->base.pc_next = ctx->pc_succ_insn;
 
     if (ctx->base.is_jmp == DISAS_NEXT) {
         target_ulong page_start;
 
         page_start = ctx->base.pc_first & TARGET_PAGE_MASK;
-        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE) {
+        if (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE
+            || (ctx->base.pc_next - page_start >= TARGET_PAGE_SIZE - 3
+                && insn_crosses_page(env, ctx))) {
             ctx->base.is_jmp = DISAS_TOO_MANY;
         }
     }
-- 
2.23.0


