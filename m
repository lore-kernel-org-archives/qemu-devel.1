Return-Path: <SRS0=sDSq=3P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E04AC2D0DB
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 23:01:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1410620702
	for <qemu-devel@archiver.kernel.org>; Sun, 26 Jan 2020 23:01:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1410620702
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=rt-rk.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ivquT-0005lY-5f
	for qemu-devel@archiver.kernel.org; Sun, 26 Jan 2020 18:01:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33404)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ivqpo-0005Xr-G5
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.markovic@rt-rk.com>) id 1ivqpm-0000Qb-Mh
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:52 -0500
Received: from mx2.rt-rk.com ([89.216.37.149]:37951 helo=mail.rt-rk.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
 id 1ivqpm-0000PX-AM
 for qemu-devel@nongnu.org; Sun, 26 Jan 2020 17:56:50 -0500
Received: from localhost (localhost [127.0.0.1])
 by mail.rt-rk.com (Postfix) with ESMTP id 462441A1DAF;
 Sun, 26 Jan 2020 23:56:03 +0100 (CET)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw774-lin.domain.local (rtrkw774-lin.domain.local
 [10.10.14.106])
 by mail.rt-rk.com (Postfix) with ESMTPSA id 27C141A1D62;
 Sun, 26 Jan 2020 23:56:03 +0100 (CET)
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To: qemu-devel@nongnu.org
Subject: [PATCH rc3 14/30] target/avr: Add instruction translation - CPU main
 translation function
Date: Sun, 26 Jan 2020 23:54:55 +0100
Message-Id: <1580079311-20447-15-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Michael Rolnik <mrolnik@gmail.com>

Co-developed-by: Richard Henderson <richard.henderson@linaro.org>
Co-developed-by: Michael Rolnik <mrolnik@gmail.com>

Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
---
 target/avr/translate.c | 234 +++++++++++++++++++++++++++++++++++++++++++=
++++++
 1 file changed, 234 insertions(+)

diff --git a/target/avr/translate.c b/target/avr/translate.c
index 4c68007..af88bb2 100644
--- a/target/avr/translate.c
+++ b/target/avr/translate.c
@@ -2749,3 +2749,237 @@ static bool trans_WDR(DisasContext *ctx, arg_WDR =
*a)
=20
     return true;
 }
+
+
+void avr_cpu_tcg_init(void)
+{
+    int i;
+
+#define AVR_REG_OFFS(x) offsetof(CPUAVRState, x)
+    cpu_pc =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(pc_w), "pc")=
;
+    cpu_Cf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregC), "Cf"=
);
+    cpu_Zf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregZ), "Zf"=
);
+    cpu_Nf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregN), "Nf"=
);
+    cpu_Vf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregV), "Vf"=
);
+    cpu_Sf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregS), "Sf"=
);
+    cpu_Hf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregH), "Hf"=
);
+    cpu_Tf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregT), "Tf"=
);
+    cpu_If =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregI), "If"=
);
+    cpu_rampD =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampD), "=
rampD");
+    cpu_rampX =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampX), "=
rampX");
+    cpu_rampY =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampY), "=
rampY");
+    cpu_rampZ =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampZ), "=
rampZ");
+    cpu_eind =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(eind), "ei=
nd");
+    cpu_sp =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sp), "sp");
+    cpu_skip =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(skip), "sk=
ip");
+
+    for (i =3D 0; i < NUMBER_OF_CPU_REGISTERS; i++) {
+        cpu_r[i] =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(r[i]),
+                                          reg_names[i]);
+    }
+#undef AVR_REG_OFFS
+}
+
+static void translate(DisasContext *ctx)
+{
+    uint32_t opcode =3D next_word(ctx);
+
+    if (!decode_insn(ctx, opcode)) {
+        gen_helper_unsupported(cpu_env);
+        ctx->bstate =3D DISAS_NORETURN;
+    }
+}
+
+/* Standardize the cpu_skip condition to NE.  */
+static bool canonicalize_skip(DisasContext *ctx)
+{
+    switch (ctx->skip_cond) {
+    case TCG_COND_NEVER:
+        /* Normal case: cpu_skip is known to be false.  */
+        return false;
+
+    case TCG_COND_ALWAYS:
+        /*
+         * Breakpoint case: cpu_skip is known to be true, via TB_FLAGS_S=
KIP.
+         * The breakpoint is on the instruction being skipped, at the st=
art
+         * of the TranslationBlock.  No need to update.
+         */
+        return false;
+
+    case TCG_COND_NE:
+        if (ctx->skip_var1 =3D=3D NULL) {
+            tcg_gen_mov_tl(cpu_skip, ctx->skip_var0);
+        } else {
+            tcg_gen_xor_tl(cpu_skip, ctx->skip_var0, ctx->skip_var1);
+            ctx->skip_var1 =3D NULL;
+        }
+        break;
+
+    default:
+        /* Convert to a NE condition vs 0. */
+        if (ctx->skip_var1 =3D=3D NULL) {
+            tcg_gen_setcondi_tl(ctx->skip_cond, cpu_skip, ctx->skip_var0=
, 0);
+        } else {
+            tcg_gen_setcond_tl(ctx->skip_cond, cpu_skip,
+                               ctx->skip_var0, ctx->skip_var1);
+            ctx->skip_var1 =3D NULL;
+        }
+        ctx->skip_cond =3D TCG_COND_NE;
+        break;
+    }
+    if (ctx->free_skip_var0) {
+        tcg_temp_free(ctx->skip_var0);
+        ctx->free_skip_var0 =3D false;
+    }
+    ctx->skip_var0 =3D cpu_skip;
+    return true;
+}
+
+void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_i=
nsns)
+{
+    CPUAVRState *env =3D cs->env_ptr;
+    DisasContext ctx =3D {
+        .tb =3D tb,
+        .cs =3D cs,
+        .env =3D env,
+        .memidx =3D 0,
+        .bstate =3D DISAS_NEXT,
+        .skip_cond =3D TCG_COND_NEVER,
+        .singlestep =3D cs->singlestep_enabled,
+    };
+    target_ulong pc_start =3D tb->pc / 2;
+    int num_insns =3D 0;
+
+    if (tb->flags & TB_FLAGS_FULL_ACCESS) {
+        /*
+         * This flag is set by ST/LD instruction we will regenerate it O=
NLY
+         * with mem/cpu memory access instead of mem access
+         */
+        max_insns =3D 1;
+    }
+    if (ctx.singlestep) {
+        max_insns =3D 1;
+    }
+
+    gen_tb_start(tb);
+
+    ctx.npc =3D pc_start;
+    if (tb->flags & TB_FLAGS_SKIP) {
+        ctx.skip_cond =3D TCG_COND_ALWAYS;
+        ctx.skip_var0 =3D cpu_skip;
+    }
+
+    do {
+        TCGLabel *skip_label =3D NULL;
+
+        /* translate current instruction */
+        tcg_gen_insn_start(ctx.npc);
+        num_insns++;
+
+        /*
+         * this is due to some strange GDB behavior
+         * let's assume main has address 0x100
+         * b main   - sets breakpoint at address 0x00000100 (code)
+         * b *0x100 - sets breakpoint at address 0x00800100 (data)
+         */
+        if (unlikely(!ctx.singlestep &&
+                (cpu_breakpoint_test(cs, OFFSET_CODE + ctx.npc * 2, BP_A=
NY) ||
+                 cpu_breakpoint_test(cs, OFFSET_DATA + ctx.npc * 2, BP_A=
NY)))) {
+            canonicalize_skip(&ctx);
+            tcg_gen_movi_tl(cpu_pc, ctx.npc);
+            gen_helper_debug(cpu_env);
+            goto done_generating;
+        }
+
+        /* Conditionally skip the next instruction, if indicated.  */
+        if (ctx.skip_cond !=3D TCG_COND_NEVER) {
+            skip_label =3D gen_new_label();
+            if (ctx.skip_var0 =3D=3D cpu_skip) {
+                /*
+                 * Copy cpu_skip so that we may zero it before the branc=
h.
+                 * This ensures that cpu_skip is non-zero after the labe=
l
+                 * if and only if the skipped insn itself sets a skip.
+                 */
+                ctx.free_skip_var0 =3D true;
+                ctx.skip_var0 =3D tcg_temp_new();
+                tcg_gen_mov_tl(ctx.skip_var0, cpu_skip);
+                tcg_gen_movi_tl(cpu_skip, 0);
+            }
+            if (ctx.skip_var1 =3D=3D NULL) {
+                tcg_gen_brcondi_tl(ctx.skip_cond, ctx.skip_var0, 0, skip=
_label);
+            } else {
+                tcg_gen_brcond_tl(ctx.skip_cond, ctx.skip_var0,
+                                  ctx.skip_var1, skip_label);
+                ctx.skip_var1 =3D NULL;
+            }
+            if (ctx.free_skip_var0) {
+                tcg_temp_free(ctx.skip_var0);
+                ctx.free_skip_var0 =3D false;
+            }
+            ctx.skip_cond =3D TCG_COND_NEVER;
+            ctx.skip_var0 =3D NULL;
+        }
+
+        translate(&ctx);
+
+        if (skip_label) {
+            canonicalize_skip(&ctx);
+            gen_set_label(skip_label);
+            if (ctx.bstate =3D=3D DISAS_NORETURN) {
+                ctx.bstate =3D DISAS_CHAIN;
+            }
+        }
+    } while (ctx.bstate =3D=3D DISAS_NEXT
+             && num_insns < max_insns
+             && (ctx.npc - pc_start) * 2 < TARGET_PAGE_SIZE - 4
+             && !tcg_op_buf_full());
+
+    if (tb->cflags & CF_LAST_IO) {
+        gen_io_end();
+    }
+
+    bool nonconst_skip =3D canonicalize_skip(&ctx);
+
+    switch (ctx.bstate) {
+    case DISAS_NORETURN:
+        assert(!nonconst_skip);
+        break;
+    case DISAS_NEXT:
+    case DISAS_TOO_MANY:
+    case DISAS_CHAIN:
+        if (!nonconst_skip) {
+            /* Note gen_goto_tb checks singlestep.  */
+            gen_goto_tb(&ctx, 1, ctx.npc);
+            break;
+        }
+        tcg_gen_movi_tl(cpu_pc, ctx.npc);
+        /* fall through */
+    case DISAS_LOOKUP:
+        if (!ctx.singlestep) {
+            tcg_gen_lookup_and_goto_ptr();
+            break;
+        }
+        /* fall through */
+    case DISAS_EXIT:
+        if (ctx.singlestep) {
+            gen_helper_debug(cpu_env);
+        } else {
+            tcg_gen_exit_tb(NULL, 0);
+        }
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+done_generating:
+    gen_tb_end(tb, num_insns);
+
+    tb->size =3D (ctx.npc - pc_start) * 2;
+    tb->icount =3D num_insns;
+}
+
+void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
+                            target_ulong *data)
+{
+    env->pc_w =3D data[0];
+}
--=20
2.7.4


