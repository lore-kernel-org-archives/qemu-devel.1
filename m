Return-Path: <SRS0=TsRd=ZO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E44C43215
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:50:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C794820714
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2019 11:50:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YSvtjI5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C794820714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49962 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iY7SU-0000Eg-TR
	for qemu-devel@archiver.kernel.org; Fri, 22 Nov 2019 06:50:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42220)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iY7QM-0006pv-2t
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:48:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iY7QK-0003GG-E8
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:48:29 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:31429
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iY7QK-0003G5-9u
 for qemu-devel@nongnu.org; Fri, 22 Nov 2019 06:48:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574423307;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QJo8jhqK4p02P9ausgPE3S4br+YCpnwPXMXAqK+QVpo=;
 b=YSvtjI5lkXQkAU9PfIW8u0bhFXV5elZc121V1mdYmYd2Cgl3ikaCTfG/D42R0wFVYhqN1+
 ai/milMR8380gJ9+USts4b+qTwF5eKOYfJhOLJ1a44pBQQidV0X0koLKlZGQE5usQHA4Un
 NyfcKjSF6axMPe5SwODbWpsC3oP6qKs=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-21-rB_XHrWEM6iSOP-7sC-RTA-1; Fri, 22 Nov 2019 06:48:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id w4so3753115wro.10
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2019 03:48:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=pXU0eOzjPDHHUuPPl2ULX7QanNUbzTHlAhzsh9+ZHYM=;
 b=IqI0Qbk8ikdEI2X2smWh9x7EjTMa0ve3ISowbLzC/Kcfx4rfyMudqb0BS8x2+r7Zpg
 2B9Vu/Lxn314kfM8D5BEQjcbdIXy5FPD+JAqKTABjBQJmNnZA7AXp5QdcCJT6DW1gAgO
 EXTBdPNTFM9HCPPr7OrHhEgn+k2Vtb5efZwDaYbr+PF65dT4sct0hZDkUL9yiwYIYhJW
 j7i4/pDE+rw6cMrovcgCQrquaAyGJ5aHS3zp+ZNAdMF59EilWaE9x/0QjAZFtnAep/Ij
 FjYq3dzu0nriyPoJWgGyqDKb3mM4L8x8a3TwqPVcf+1HWLw2pLxnD89jEb/zHVH9AUtx
 AZBQ==
X-Gm-Message-State: APjAAAVNHgVBQjrfh1yiQkOHBVeJSIvl2o2oQ1ZZdNCaQASxRjhAod+v
 2RZigtbcD46JDYYcyGMv45wCPol4enci5jDXTTmcEX7JqvhYyGda4UW+3C1CAx8jYxxFVO6o+1N
 bpqsZFqDPRcmwvDk=
X-Received: by 2002:a1c:3d8a:: with SMTP id k132mr1397283wma.144.1574423302072; 
 Fri, 22 Nov 2019 03:48:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqy78XAT1JHw9KpbFMw4FJ5BBPZDeMdn6OtDsNbbA9CS+ipc9WrzQJRLXj8PWhYX5TiHJ2qsCg==
X-Received: by 2002:a1c:3d8a:: with SMTP id k132mr1397265wma.144.1574423301817; 
 Fri, 22 Nov 2019 03:48:21 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id p25sm3085995wma.20.2019.11.22.03.48.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 Nov 2019 03:48:21 -0800 (PST)
Subject: Re: [PATCH v35 09/13] target/avr: Add instruction translation - CPU
 main translation function
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org
References: <20191029212430.20617-1-mrolnik@gmail.com>
 <20191029212430.20617-10-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9c36b2d2-fea1-0cb5-dbea-49af8ec6c7e3@redhat.com>
Date: Fri, 22 Nov 2019 12:48:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029212430.20617-10-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: rB_XHrWEM6iSOP-7sC-RTA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: thuth@redhat.com, Joaquin de Andres <me@xcancerberox.com.ar>,
 richard.henderson@linaro.org, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/29/19 10:24 PM, Michael Rolnik wrote:
> Co-developed-by: Richard Henderson <richard.henderson@linaro.org>

This misses a:
"Signed-off-by: Richard Henderson <richard.henderson@linaro.org>"

> Co-developed-by: Michael Rolnik <mrolnik@gmail.com>
>=20
> Signed-off-by: Michael Rolnik <mrolnik@gmail.com>

Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

> ---
>   target/avr/translate.c | 234 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 234 insertions(+)
>=20
> diff --git a/target/avr/translate.c b/target/avr/translate.c
> index 30ba13bdd7..fdf4e11f58 100644
> --- a/target/avr/translate.c
> +++ b/target/avr/translate.c
> @@ -2792,3 +2792,237 @@ static bool trans_WDR(DisasContext *ctx, arg_WDR =
*a)
>  =20
>       return true;
>   }
> +
> +
> +void avr_cpu_tcg_init(void)
> +{
> +    int i;
> +
> +#define AVR_REG_OFFS(x) offsetof(CPUAVRState, x)
> +    cpu_pc =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(pc_w), "pc")=
;
> +    cpu_Cf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregC), "Cf"=
);
> +    cpu_Zf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregZ), "Zf"=
);
> +    cpu_Nf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregN), "Nf"=
);
> +    cpu_Vf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregV), "Vf"=
);
> +    cpu_Sf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregS), "Sf"=
);
> +    cpu_Hf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregH), "Hf"=
);
> +    cpu_Tf =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregT), "Tf"=
);
> +    cpu_If =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sregI), "If"=
);
> +    cpu_rampD =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampD), "=
rampD");
> +    cpu_rampX =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampX), "=
rampX");
> +    cpu_rampY =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampY), "=
rampY");
> +    cpu_rampZ =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(rampZ), "=
rampZ");
> +    cpu_eind =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(eind), "ei=
nd");
> +    cpu_sp =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(sp), "sp");
> +    cpu_skip =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(skip), "sk=
ip");
> +
> +    for (i =3D 0; i < NO_CPU_REGISTERS; i++) {
> +        cpu_r[i] =3D tcg_global_mem_new_i32(cpu_env, AVR_REG_OFFS(r[i]),
> +                                          reg_names[i]);
> +    }
> +#undef AVR_REG_OFFS
> +}
> +
> +static void translate(DisasContext *ctx)
> +{
> +    uint32_t opcode =3D next_word(ctx);
> +
> +    if (!decode_insn(ctx, opcode)) {
> +        gen_helper_unsupported(cpu_env);
> +        ctx->bstate =3D DISAS_NORETURN;
> +    }
> +}
> +
> +/* Standardize the cpu_skip condition to NE.  */
> +static bool canonicalize_skip(DisasContext *ctx)
> +{
> +    switch (ctx->skip_cond) {
> +    case TCG_COND_NEVER:
> +        /* Normal case: cpu_skip is known to be false.  */
> +        return false;
> +
> +    case TCG_COND_ALWAYS:
> +        /*
> +         * Breakpoint case: cpu_skip is known to be true, via TB_FLAGS_S=
KIP.
> +         * The breakpoint is on the instruction being skipped, at the st=
art
> +         * of the TranslationBlock.  No need to update.
> +         */
> +        return false;
> +
> +    case TCG_COND_NE:
> +        if (ctx->skip_var1 =3D=3D NULL) {
> +            tcg_gen_mov_tl(cpu_skip, ctx->skip_var0);
> +        } else {
> +            tcg_gen_xor_tl(cpu_skip, ctx->skip_var0, ctx->skip_var1);
> +            ctx->skip_var1 =3D NULL;
> +        }
> +        break;
> +
> +    default:
> +        /* Convert to a NE condition vs 0. */
> +        if (ctx->skip_var1 =3D=3D NULL) {
> +            tcg_gen_setcondi_tl(ctx->skip_cond, cpu_skip, ctx->skip_var0=
, 0);
> +        } else {
> +            tcg_gen_setcond_tl(ctx->skip_cond, cpu_skip,
> +                               ctx->skip_var0, ctx->skip_var1);
> +            ctx->skip_var1 =3D NULL;
> +        }
> +        ctx->skip_cond =3D TCG_COND_NE;
> +        break;
> +    }
> +    if (ctx->free_skip_var0) {
> +        tcg_temp_free(ctx->skip_var0);
> +        ctx->free_skip_var0 =3D false;
> +    }
> +    ctx->skip_var0 =3D cpu_skip;
> +    return true;
> +}
> +
> +void gen_intermediate_code(CPUState *cs, TranslationBlock *tb, int max_i=
nsns)
> +{
> +    CPUAVRState *env =3D cs->env_ptr;
> +    DisasContext ctx =3D {
> +        .tb =3D tb,
> +        .cs =3D cs,
> +        .env =3D env,
> +        .memidx =3D 0,
> +        .bstate =3D DISAS_NEXT,
> +        .skip_cond =3D TCG_COND_NEVER,
> +        .singlestep =3D cs->singlestep_enabled,
> +    };
> +    target_ulong pc_start =3D tb->pc / 2;
> +    int num_insns =3D 0;
> +
> +    if (tb->flags & TB_FLAGS_FULL_ACCESS) {
> +        /*
> +         * This flag is set by ST/LD instruction we will regenerate it O=
NLY
> +         * with mem/cpu memory access instead of mem access
> +         */
> +        max_insns =3D 1;
> +    }
> +    if (ctx.singlestep) {
> +        max_insns =3D 1;
> +    }
> +
> +    gen_tb_start(tb);
> +
> +    ctx.npc =3D pc_start;
> +    if (tb->flags & TB_FLAGS_SKIP) {
> +        ctx.skip_cond =3D TCG_COND_ALWAYS;
> +        ctx.skip_var0 =3D cpu_skip;
> +    }
> +
> +    do {
> +        TCGLabel *skip_label =3D NULL;
> +
> +        /* translate current instruction */
> +        tcg_gen_insn_start(ctx.npc);
> +        num_insns++;
> +
> +        /*
> +         * this is due to some strange GDB behavior
> +         * let's assume main has address 0x100
> +         * b main   - sets breakpoint at address 0x00000100 (code)
> +         * b *0x100 - sets breakpoint at address 0x00800100 (data)
> +         */
> +        if (unlikely(!ctx.singlestep &&
> +                (cpu_breakpoint_test(cs, OFFSET_CODE + ctx.npc * 2, BP_A=
NY) ||
> +                 cpu_breakpoint_test(cs, OFFSET_DATA + ctx.npc * 2, BP_A=
NY)))) {
> +            canonicalize_skip(&ctx);
> +            tcg_gen_movi_tl(cpu_pc, ctx.npc);
> +            gen_helper_debug(cpu_env);
> +            goto done_generating;
> +        }
> +
> +        /* Conditionally skip the next instruction, if indicated.  */
> +        if (ctx.skip_cond !=3D TCG_COND_NEVER) {
> +            skip_label =3D gen_new_label();
> +            if (ctx.skip_var0 =3D=3D cpu_skip) {
> +                /*
> +                 * Copy cpu_skip so that we may zero it before the branc=
h.
> +                 * This ensures that cpu_skip is non-zero after the labe=
l
> +                 * if and only if the skipped insn itself sets a skip.
> +                 */
> +                ctx.free_skip_var0 =3D true;
> +                ctx.skip_var0 =3D tcg_temp_new();
> +                tcg_gen_mov_tl(ctx.skip_var0, cpu_skip);
> +                tcg_gen_movi_tl(cpu_skip, 0);
> +            }
> +            if (ctx.skip_var1 =3D=3D NULL) {
> +                tcg_gen_brcondi_tl(ctx.skip_cond, ctx.skip_var0, 0, skip=
_label);
> +            } else {
> +                tcg_gen_brcond_tl(ctx.skip_cond, ctx.skip_var0,
> +                                  ctx.skip_var1, skip_label);
> +                ctx.skip_var1 =3D NULL;
> +            }
> +            if (ctx.free_skip_var0) {
> +                tcg_temp_free(ctx.skip_var0);
> +                ctx.free_skip_var0 =3D false;
> +            }
> +            ctx.skip_cond =3D TCG_COND_NEVER;
> +            ctx.skip_var0 =3D NULL;
> +        }
> +
> +        translate(&ctx);
> +
> +        if (skip_label) {
> +            canonicalize_skip(&ctx);
> +            gen_set_label(skip_label);
> +            if (ctx.bstate =3D=3D DISAS_NORETURN) {
> +                ctx.bstate =3D DISAS_CHAIN;
> +            }
> +        }
> +    } while (ctx.bstate =3D=3D DISAS_NEXT
> +             && num_insns < max_insns
> +             && (ctx.npc - pc_start) * 2 < TARGET_PAGE_SIZE - 4
> +             && !tcg_op_buf_full());
> +
> +    if (tb->cflags & CF_LAST_IO) {
> +        gen_io_end();
> +    }
> +
> +    bool nonconst_skip =3D canonicalize_skip(&ctx);
> +
> +    switch (ctx.bstate) {
> +    case DISAS_NORETURN:
> +        assert(!nonconst_skip);
> +        break;
> +    case DISAS_NEXT:
> +    case DISAS_TOO_MANY:
> +    case DISAS_CHAIN:
> +        if (!nonconst_skip) {
> +            /* Note gen_goto_tb checks singlestep.  */
> +            gen_goto_tb(&ctx, 1, ctx.npc);
> +            break;
> +        }
> +        tcg_gen_movi_tl(cpu_pc, ctx.npc);
> +        /* fall through */
> +    case DISAS_LOOKUP:
> +        if (!ctx.singlestep) {
> +            tcg_gen_lookup_and_goto_ptr();
> +            break;
> +        }
> +        /* fall through */
> +    case DISAS_EXIT:
> +        if (ctx.singlestep) {
> +            gen_helper_debug(cpu_env);
> +        } else {
> +            tcg_gen_exit_tb(NULL, 0);
> +        }
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +done_generating:
> +    gen_tb_end(tb, num_insns);
> +
> +    tb->size =3D (ctx.npc - pc_start) * 2;
> +    tb->icount =3D num_insns;
> +}
> +
> +void restore_state_to_opc(CPUAVRState *env, TranslationBlock *tb,
> +                            target_ulong *data)
> +{
> +    env->pc_w =3D data[0];
> +}
>=20


