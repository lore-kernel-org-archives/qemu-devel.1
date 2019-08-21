Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7752C3A5A0
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:25:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD9C7206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:25:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD9C7206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47952 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0PgI-0002j5-QR
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 08:25:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35911)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeG-0000ab-Ac
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeF-0008Mg-64
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:32 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:48786
 helo=mail.uni-paderborn.de)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeF-0008M8-01
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:31 -0400
Received: from magmaria.uni-paderborn.de ([131.234.189.24]
 helo=localhost.localdomain)
 by mail.uni-paderborn.de with esmtp (Exim 4.89 zuban)
 id 1i0PeE-0001FM-Jj; Wed, 21 Aug 2019 14:23:30 +0200
Received: from mail.uni-paderborn.de by magmaria with queue id 3651650-3;
 Wed, 21 Aug 2019 12:23:28 GMT
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:15 +0200
Message-Id: <20190821122315.18015-6-kbastian@mail.uni-paderborn.de>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
References: <20190821122315.18015-1-kbastian@mail.uni-paderborn.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-PMX-Version: 6.4.7.2805085, Antispam-Engine: 2.7.2.2107409,
 Antispam-Data: 2019.8.21.121517, AntiVirus-Engine: 5.63.0,
 AntiVirus-Data: 2019.8.13.5630000
X-IMT-Spam-Score: 0.0 ()
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 131.234.189.17
Subject: [Qemu-devel] [PATCH v2 5/5] target/tricore: Fix
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
Cc: kbastian@mail.uni-paderborn.de, david.brenken@efs-auto.de,
 richard.henderson@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

we now fetch 2 bytes first, check whether we have a 32 bit insn, and only then
fetch another 2 bytes. We also make sure that a 16 bit insn that still fits
into the current page does not end up in the next page.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/translate.c | 47 +++++++++++++++++++++++++++-----------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 19a0e4554c..3ffcf0440e 100644
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


