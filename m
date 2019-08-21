Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D587DC3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:28:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA20F206BA
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 12:28:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA20F206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mail.uni-paderborn.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47974 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Pih-0005ax-O9
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 08:28:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35895)
 by lists.gnu.org with esmtp (Exim 4.90_1) (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeE-0000ZN-Vb
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeD-0008Lk-Om
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:30 -0400
Received: from zuban.uni-paderborn.de ([131.234.189.17]:48772
 helo=mail.uni-paderborn.de)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from
 <SRS0=9d03=721=mail.uni-paderborn.de=kbastian@mail.uni-paderborn.de>)
 id 1i0PeD-0008L9-J0
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 08:23:29 -0400
Received: from magmaria.uni-paderborn.de ([131.234.189.24]
 helo=localhost.localdomain)
 by mail.uni-paderborn.de with esmtp (Exim 4.89 zuban)
 id 1i0PeC-0001F2-Lg; Wed, 21 Aug 2019 14:23:28 +0200
Received: from mail.uni-paderborn.de by magmaria with queue id 3651649-3;
 Wed, 21 Aug 2019 12:23:27 GMT
X-Envelope-From: <kbastian@mail.uni-paderborn.de>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 14:23:14 +0200
Message-Id: <20190821122315.18015-5-kbastian@mail.uni-paderborn.de>
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
Subject: [Qemu-devel] [PATCH v2 4/5] target/tricore: Implement a qemu
 excptions helper
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

this helper is only used to raise qemu specific exceptions. We use this
helper to raise it on breakpoints as well as the TriCore debug insn.

Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
---
 target/tricore/helper.h    |  1 +
 target/tricore/op_helper.c |  7 +++++++
 target/tricore/translate.c | 24 +++++++++++++++++++++---
 3 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/target/tricore/helper.h b/target/tricore/helper.h
index b64780c37d..78176aa17a 100644
--- a/target/tricore/helper.h
+++ b/target/tricore/helper.h
@@ -153,3 +153,4 @@ DEF_HELPER_2(psw_write, void, env, i32)
 DEF_HELPER_1(psw_read, i32, env)
 /* Exceptions */
 DEF_HELPER_3(raise_exception_sync, noreturn, env, i32, i32)
+DEF_HELPER_2(qemu_excp, noreturn, env, i32)
diff --git a/target/tricore/op_helper.c b/target/tricore/op_helper.c
index 9476d10d00..32c2bc1699 100644
--- a/target/tricore/op_helper.c
+++ b/target/tricore/op_helper.c
@@ -107,6 +107,13 @@ static void raise_exception_sync_helper(CPUTriCoreState *env, uint32_t class,
     raise_exception_sync_internal(env, class, tin, pc, 0);
 }
 
+void helper_qemu_excp(CPUTriCoreState *env, uint32_t excp)
+{
+    CPUState *cs = env_cpu(env);
+    cs->exception_index = excp;
+    cpu_loop_exit(cs);
+}
+
 /* Addressing mode helper */
 
 static uint16_t reverse16(uint16_t val)
diff --git a/target/tricore/translate.c b/target/tricore/translate.c
index 5fb42abe35..19a0e4554c 100644
--- a/target/tricore/translate.c
+++ b/target/tricore/translate.c
@@ -3261,6 +3261,15 @@ static void generate_trap(DisasContext *ctx, int class, int tin)
     tcg_temp_free(tintemp);
 }
 
+static void generate_qemu_excp(DisasContext *ctx, int excp)
+{
+    TCGv_i32 tmp = tcg_const_i32(excp);
+    gen_save_pc(ctx->base.pc_next);
+    gen_helper_qemu_excp(cpu_env, tmp);
+    ctx->base.is_jmp = DISAS_NORETURN;
+    tcg_temp_free(tmp);
+}
+
 static inline void gen_branch_cond(DisasContext *ctx, TCGCond cond, TCGv r1,
                                    TCGv r2, int16_t address)
 {
@@ -3928,7 +3937,7 @@ static void decode_sr_system(DisasContext *ctx)
         ctx->base.is_jmp = DISAS_NORETURN;
         break;
     case OPC2_16_SR_DEBUG:
-        /* raise EXCP_DEBUG */
+        generate_qemu_excp(ctx, EXCP_DEBUG);
         break;
     case OPC2_16_SR_FRET:
         gen_fret(ctx);
@@ -8354,7 +8363,7 @@ static void decode_sys_interrupts(DisasContext *ctx)
 
     switch (op2) {
     case OPC2_32_SYS_DEBUG:
-        /* raise EXCP_DEBUG */
+        generate_qemu_excp(ctx, EXCP_DEBUG);
         break;
     case OPC2_32_SYS_DISABLE:
         tcg_gen_andi_tl(cpu_ICR, cpu_ICR, ~MASK_ICR_IE_1_3);
@@ -8808,7 +8817,16 @@ static void tricore_tr_insn_start(DisasContextBase *dcbase, CPUState *cpu)
 static bool tricore_tr_breakpoint_check(DisasContextBase *dcbase, CPUState *cpu,
                                       const CPUBreakpoint *bp)
 {
-    return false;
+    DisasContext *ctx = container_of(dcbase, DisasContext, base);
+    generate_qemu_excp(ctx, EXCP_DEBUG);
+    /*
+     * The address covered by the breakpoint must be included in
+     * [tb->pc, tb->pc + tb->size) in order to for it to be
+     * properly cleared -- thus we increment the PC here so that
+     * the logic setting tb->size below does the right thing.
+     */
+    ctx->base.pc_next += 4;
+    return true;
 }
 
 static void tricore_tr_translate_insn(DisasContextBase *dcbase, CPUState *cpu)
-- 
2.23.0


