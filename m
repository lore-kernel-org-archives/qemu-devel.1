Return-Path: <SRS0=clLO=73=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97063C433DF
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 09:35:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 61C4D206D7
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2020 09:35:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sFUDKqIN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 61C4D206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkP3R-0001QT-K5
	for qemu-devel@archiver.kernel.org; Sun, 14 Jun 2020 05:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48892)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkP2i-0000up-RT
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 05:35:09 -0400
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:37805)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aleksandar.qemu.devel@gmail.com>)
 id 1jkP2f-0003rw-V9
 for qemu-devel@nongnu.org; Sun, 14 Jun 2020 05:35:08 -0400
Received: by mail-wm1-x341.google.com with SMTP id y20so11905445wmi.2
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2020 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=FK/nAYkrwWGQ0ifdU5wzx5p962C1PNsZc8gb/xYT1HQ=;
 b=sFUDKqINcyqPna8zs0ln50jVHYyPzFyk77SI9NfEQHmmETOLs0mwPGnzVnLsn3Rmvq
 Dd+SHIDM1icQk6Xff5FBfn7ilW14AdccLPwGAx7dbKWXzMIgOiz0nVETRcaW0+2YSSTv
 dStBtv3FInFTuaMkr50xIdCElqmzX7s2D1AhD2L9o7vv+MI68qC7KPpGsdZ5oDIm+OdP
 SvYLE/4S6vDTUf7JgjHf33lfWZhk4icMAGZMs37MYuYG9jiAmZpv679Bu7UZ5f2p0c9H
 dxKCyUJBHfRW6aP80VoYGGJfdoIyMgSWvhI3jKiE/pvPyLzEm0s11eFL3PAKFXzbheKN
 o0yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FK/nAYkrwWGQ0ifdU5wzx5p962C1PNsZc8gb/xYT1HQ=;
 b=cGA9vwa7U6IguCtiiglO+bZZ+f+KtAT1V/TFGesGykhpr1Igl44yG5KkDlns1xeSFZ
 29sqEyQ0emcuGi+L8Y4BobslJVpANgVPkB380wd83+jatxSaTlzBWtbZv+f+fsHRBVcb
 q+UeldKRT7CYjcuYQa33s56QDrHs69ZOkMge2ixESMXvkNS1W2K7ty2iuu2Cx9Iis25D
 PHQ9P4NFh0QZj0Xj/Yo4Ns5LbXjG0X9U7VqcQ++T1hIDyBaE2ARMvuMCK6lm887uuXDS
 DUcGMH2LdHfJeyDm+ZbZcIwDrh40aOoLHWRMBD71BNBdyNm/6jytbiMcDMEBsUU9vIhS
 EmkQ==
X-Gm-Message-State: AOAM530ll8/kmfXWR5m4QruFy7wTjZezaueNyNhNRHooGzgYFPTKd4R/
 xASsXbbkm4w117hN/8zNznh0MMw3BrK64lSZPzQ=
X-Google-Smtp-Source: ABdhPJw0S6GvWQEhzQJ94GNNIP89RRgQjhL7C8Z8x7Y3D8YXuSiK0gtj28Eg+sVZnxknwhWy8XIKw0ShtA+HGV8Rf9c=
X-Received: by 2002:a1c:cc0d:: with SMTP id h13mr8184243wmb.168.1592127298566; 
 Sun, 14 Jun 2020 02:34:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200614080049.31134-1-jiaxun.yang@flygoat.com>
 <20200614080049.31134-4-jiaxun.yang@flygoat.com>
In-Reply-To: <20200614080049.31134-4-jiaxun.yang@flygoat.com>
From: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Date: Sun, 14 Jun 2020 11:34:46 +0200
Message-ID: <CAHiYmc5oqVsgtBp+c3zcc+u-aH2uCq_nUMKT33Ur5VmFvmc-zA@mail.gmail.com>
Subject: Re: [PATCH 3/4] target/mips: Add loongson ext lsdc2 instrustions
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::341;
 envelope-from=aleksandar.qemu.devel@gmail.com; helo=mail-wm1-x341.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

=D0=BD=D0=B5=D0=B4, 14. =D1=98=D1=83=D0=BD 2020. =D1=83 10:02 Jiaxun Yang <=
jiaxun.yang@flygoat.com> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=BE/=D0=BB=D0=B0:
>
> LDC2/SDC2 opcodes have been rewritten as "load & store with offset"
> instructions by loongson-ext ASE.
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---

Please use "group of instructions" instead of just "instructions" in the ti=
tle.

>  target/mips/translate.c | 176 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 176 insertions(+)
>
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index e49f32f6ae..8b45ff37e6 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -460,6 +460,24 @@ enum {
>      R6_OPC_SCD         =3D 0x27 | OPC_SPECIAL3,
>  };
>
> +/* Loongson EXT LDC2/SDC2 opcodes */
> +#define MASK_LOONGSON_LSDC2(op)           (MASK_OP_MAJOR(op) | (op & 0x7=
))
> +
> +enum {
> +    OPC_GSLBX      =3D 0x0 | OPC_LDC2,
> +    OPC_GSLHX      =3D 0x1 | OPC_LDC2,
> +    OPC_GSLWX      =3D 0x2 | OPC_LDC2,
> +    OPC_GSLDX      =3D 0x3 | OPC_LDC2,
> +    OPC_GSLWXC1    =3D 0x6 | OPC_LDC2,
> +    OPC_GSLDXC1    =3D 0x7 | OPC_LDC2,
> +    OPC_GSSBX      =3D 0x0 | OPC_SDC2,
> +    OPC_GSSHX      =3D 0x1 | OPC_SDC2,
> +    OPC_GSSWX      =3D 0x2 | OPC_SDC2,
> +    OPC_GSSDX      =3D 0x3 | OPC_SDC2,
> +    OPC_GSSWXC1    =3D 0x6 | OPC_SDC2,
> +    OPC_GSSDXC1    =3D 0x7 | OPC_SDC2,
> +};
> +
>  /* BSHFL opcodes */
>  #define MASK_BSHFL(op)              (MASK_SPECIAL3(op) | (op & (0x1F << =
6)))
>
> @@ -5910,6 +5928,162 @@ no_rd:
>      tcg_temp_free_i64(t1);
>  }
>
> +/* Loongson EXT LDC2/SDC2 */
> +static void gen_loongson_lsdc2(DisasContext *ctx, int rt,
> +                                int rs, int rd)
> +{
> +    int offset =3D (int8_t)(ctx->opcode >> 3);
> +    uint32_t opc =3D MASK_LOONGSON_LSDC2(ctx->opcode);
> +    TCGv t0, t1;
> +    TCGv_i32 fp0;
> +
> +    /* Pre-conditions */
> +    switch (opc) {
> +    case OPC_GSLBX:
> +    case OPC_GSLHX:
> +    case OPC_GSLWX:
> +    case OPC_GSLDX:
> +        /* prefetch, implement as NOP */
> +        if (rt =3D=3D 0) {
> +            return;
> +        }
> +        break;
> +    case OPC_GSSBX:
> +    case OPC_GSSHX:
> +    case OPC_GSSWX:
> +    case OPC_GSSDX:
> +        break;
> +    case OPC_GSLWXC1:
> +    case OPC_GSSWXC1:
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSLDXC1:
> +    case OPC_GSSDXC1:
> +#endif
> +        check_cp1_enabled(ctx);
> +        /* Check prefetch for CP1 load instructions */
> +        if ((opc =3D=3D OPC_GSLDXC1 || opc =3D=3D  OPC_GSLWXC1)
> +            && rt =3D=3D 0) {
> +            return;
> +        }
> +        break;

I think the segment for the last four instructions got needlessly
complicated and harder to read. Wouldn't this be simpler and clearer,
if written as:

    case OPC_GSLWXC1:
#if defined(TARGET_MIPS64)
    case OPC_GSLDXC1:
#endif
        check_cp1_enabled(ctx);
        if (rt =3D=3D 0) {
            return;
        }
        break;
    case OPC_GSSWXC1:
#if defined(TARGET_MIPS64)
    case OPC_GSSDXC1:
#endif
        check_cp1_enabled(ctx);
        break;

Please, Jiaxun, convert this segment to the simpler-to-read form I proposed=
.

The same applies to other similar cases in 3/4 and 4/4 patches, if any.

Thanks,
Aleksandar

> +    default:
> +        MIPS_INVAL("loongson_lsdc2");
> +        generate_exception_end(ctx, EXCP_RI);
> +        return;
> +        break;
> +    }
> +
> +    t0 =3D tcg_temp_new();
> +
> +    gen_base_offset_addr(ctx, t0, rs, offset);
> +    gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +
> +    switch (opc) {
> +    case OPC_GSLBX:
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_SB);
> +        gen_store_gpr(t0, rt);
> +        break;
> +    case OPC_GSLHX:
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESW |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, rt);
> +        break;
> +    case OPC_GSLWX:
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TESL |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, rt);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSLDX:
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_gpr(t0, rt);
> +        break;
> +#endif
> +    case OPC_GSLWXC1:
> +        check_cp1_enabled(ctx);
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        fp0 =3D tcg_temp_new_i32();
> +        tcg_gen_qemu_ld_i32(fp0, t0, ctx->mem_idx, MO_TESL |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_fpr32(ctx, fp0, rt);
> +        tcg_temp_free_i32(fp0);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSLDXC1:
> +        check_cp1_enabled(ctx);
> +        gen_base_offset_addr(ctx, t0, rs, offset);
> +        if (rd) {
> +            gen_op_addr_add(ctx, t0, cpu_gpr[rd], t0);
> +        }
> +        tcg_gen_qemu_ld_tl(t0, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        gen_store_fpr64(ctx, t0, rt);
> +        break;
> +#endif
> +    case OPC_GSSBX:
> +        t1 =3D tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_SB);
> +        tcg_temp_free(t1);
> +        break;
> +    case OPC_GSSHX:
> +        t1 =3D tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUW |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +    case OPC_GSSWX:
> +        t1 =3D tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEUL |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSSDX:
> +        t1 =3D tcg_temp_new();
> +        gen_load_gpr(t1, rt);
> +        tcg_gen_qemu_st_tl(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +#endif
> +    case OPC_GSSWXC1:
> +        fp0 =3D tcg_temp_new_i32();
> +        gen_load_fpr32(ctx, fp0, rt);
> +        tcg_gen_qemu_st_i32(fp0, t0, ctx->mem_idx, MO_TEUL |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free_i32(fp0);
> +        break;
> +#if defined(TARGET_MIPS64)
> +    case OPC_GSSDXC1:
> +        t1 =3D tcg_temp_new();
> +        gen_load_fpr64(ctx, t1, rt);
> +        tcg_gen_qemu_st_i64(t1, t0, ctx->mem_idx, MO_TEQ |
> +                            ctx->default_tcg_memop_mask);
> +        tcg_temp_free(t1);
> +        break;
> +#endif
> +    default:
> +        break;
> +    }
> +
> +    tcg_temp_free(t0);
> +}
> +
>  /* Traps */
>  static void gen_trap(DisasContext *ctx, uint32_t opc,
>                       int rs, int rt, int16_t imm)
> @@ -30635,6 +30809,8 @@ static void decode_opc(CPUMIPSState *env, DisasCo=
ntext *ctx)
>                  /* OPC_JIC, OPC_JIALC */
>                  gen_compute_compact_branch(ctx, op, 0, rt, imm);
>              }
> +        } else if (ctx->insn_flags & ASE_LEXT) {
> +            gen_loongson_lsdc2(ctx, rt, rs, rd);
>          } else {
>              /* OPC_LWC2, OPC_SWC2 */
>              /* COP2: Not implemented. */
> --
> 2.27.0

