Return-Path: <SRS0=hj7J=4C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D95C6C352A3
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 01:33:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FF852082F
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2020 01:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p7srO0n9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FF852082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j2Pqq-0002Wz-Nf
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 20:33:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53515)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j2Poi-0001XX-T1
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 20:30:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j2Pog-0000fX-6a
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 20:30:51 -0500
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:34466)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j2Pof-0000Kl-S6; Thu, 13 Feb 2020 20:30:50 -0500
Received: by mail-lj1-x242.google.com with SMTP id x7so8862657ljc.1;
 Thu, 13 Feb 2020 17:30:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=PqbS4KN6MLHZBYiZ0ntFOT+RStZcZCTFa2j29iozm7g=;
 b=p7srO0n9jDlI3j+MWTjAG6mmhk2SaaVUYKAR44bhyVBE/LRs+CLnA6ElbIZks+nXRm
 Z+Vrx3ROC2TwPKTtufay+wKDTP5hwEJHPYO+wQ7SSKyMlENwKrpqBQJnpE/fxht3LjuI
 WiMk9XRaVdSIt50rU+fsmxOZGbZRP9GUM4zU1Hkzb2iFnDceIHo2M4vmKD/KTfZM0m1w
 lzUbETc6ExCfwLDyCq6/bjdYXJFrA2zpyWFi9ZX78NaN0WP7zUZZXRwCB+kHqDRgKwih
 L8/hhoRCkUZSR5M9eLhvhKVhok/6HwZNYHdJwzkQDAmQUTNc1SUEGoRmdb9OLuwN5bOW
 AwMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=PqbS4KN6MLHZBYiZ0ntFOT+RStZcZCTFa2j29iozm7g=;
 b=aJRkq8pXMgB3iVctduNl9lEz1zH3wnXp+fzI3ZsqcaDwBXANbyK3CD1DTkNoqLfBR9
 NwyUe1I+LvtfoVO0j6zEVZdT89p72c1E/sPdYYbHqc4p5W35W1j6qgI9xsMuTr2lNsi3
 mEeZ7vapqYl1aH87l6oHraMmMydB9yGVMikHyPzgkvJyoiimcu4gKbG0qT3iYduPvrmC
 bLmLIgYyNemMr6gX1hBnFJ3yTr0+awe5PLjwYxSRbzE121aHH04bdCwAjf9s2spcprhK
 zEIoXZhtlNq3xIbLzATXbN6Z6ClTvFzB1uQjeVevNQsq+QSaUh7q7OKrBo6nef+1g8ZC
 o8zA==
X-Gm-Message-State: APjAAAUzL3GTGjUOFSPgvJalA3lX8Pp4VOleaW9dxclezs73YB07KyqN
 a45XZWQ9X6ZYwOpcuPsmE5BKx1tRP5RFXE2MujI=
X-Google-Smtp-Source: APXvYqxMRUMlHIZ3RbDAI9JLyvik1fq+e0P4MJtOgpwwXy1kEeV9CcZeigMA54HddTuue7vUeGFwkWQu4qteLsE9uhY=
X-Received: by 2002:a2e:7609:: with SMTP id r9mr376130ljc.238.1581643842692;
 Thu, 13 Feb 2020 17:30:42 -0800 (PST)
MIME-Version: 1.0
References: <20200213225109.13120-1-alex.bennee@linaro.org>
 <20200213225109.13120-15-alex.bennee@linaro.org>
In-Reply-To: <20200213225109.13120-15-alex.bennee@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 13 Feb 2020 17:23:24 -0800
Message-ID: <CAKmqyKNj2De1hRz3XU88rVnkZ4TytwcDTNuWXYB-Wa38rWv48Q@mail.gmail.com>
Subject: Re: [PATCH v2 14/19] target/riscv: progressively load the instruction
 during decode
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
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
Cc: Fam Zheng <fam@euphon.net>,
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>, robert.foley@linaro.org,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, stefanb@linux.vnet.ibm.com,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 robhenry@microsoft.com,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 aaron@os.amperecomputing.com, "Emilio G. Cota" <cota@braap.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, peter.puhov@linaro.org,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Aurelien Jarno <aurelien@aurel32.net>,
 kuhn.chenqun@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Feb 13, 2020 at 3:08 PM Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>
> The plugin system would throw up a harmless warning when it detected
> that a disassembly of an instruction didn't use all it's bytes. Fix
> the riscv decoder to only load the instruction bytes it needs as it
> needs them.
>
> This drops opcode from the ctx in favour if passing the appropriately
> sized opcode down a few levels of the decode.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

>
> ---
> v2
>   - use extract16 for uint16_t opcodes
>
> squash! target/riscv: progressively load the instruction during decode
> ---
>  target/riscv/instmap.h   |  8 ++++----
>  target/riscv/translate.c | 40 +++++++++++++++++++++-------------------
>  2 files changed, 25 insertions(+), 23 deletions(-)
>
> diff --git a/target/riscv/instmap.h b/target/riscv/instmap.h
> index f8ad7d60fd5..40b6d2b64de 100644
> --- a/target/riscv/instmap.h
> +++ b/target/riscv/instmap.h
> @@ -344,8 +344,8 @@ enum {
>  #define GET_C_LW_IMM(inst)          ((extract32(inst, 6, 1) << 2) \
>                                      | (extract32(inst, 10, 3) << 3) \
>                                      | (extract32(inst, 5, 1) << 6))
> -#define GET_C_LD_IMM(inst)          ((extract32(inst, 10, 3) << 3) \
> -                                    | (extract32(inst, 5, 2) << 6))
> +#define GET_C_LD_IMM(inst)          ((extract16(inst, 10, 3) << 3) \
> +                                    | (extract16(inst, 5, 2) << 6))
>  #define GET_C_J_IMM(inst)           ((extract32(inst, 3, 3) << 1) \
>                                      | (extract32(inst, 11, 1) << 4) \
>                                      | (extract32(inst, 2, 1) << 5) \
> @@ -363,7 +363,7 @@ enum {
>  #define GET_C_RD(inst)              GET_RD(inst)
>  #define GET_C_RS1(inst)             GET_RD(inst)
>  #define GET_C_RS2(inst)             extract32(inst, 2, 5)
> -#define GET_C_RS1S(inst)            (8 + extract32(inst, 7, 3))
> -#define GET_C_RS2S(inst)            (8 + extract32(inst, 2, 3))
> +#define GET_C_RS1S(inst)            (8 + extract16(inst, 7, 3))
> +#define GET_C_RS2S(inst)            (8 + extract16(inst, 2, 3))
>
>  #endif
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index 14dc71156be..d5de7f468a7 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -44,7 +44,6 @@ typedef struct DisasContext {
>      /* pc_succ_insn points to the instruction following base.pc_next */
>      target_ulong pc_succ_insn;
>      target_ulong priv_ver;
> -    uint32_t opcode;
>      uint32_t mstatus_fs;
>      uint32_t misa;
>      uint32_t mem_idx;
> @@ -492,45 +491,45 @@ static void gen_set_rm(DisasContext *ctx, int rm)
>      tcg_temp_free_i32(t0);
>  }
>
> -static void decode_RV32_64C0(DisasContext *ctx)
> +static void decode_RV32_64C0(DisasContext *ctx, uint16_t opcode)
>  {
> -    uint8_t funct3 =3D extract32(ctx->opcode, 13, 3);
> -    uint8_t rd_rs2 =3D GET_C_RS2S(ctx->opcode);
> -    uint8_t rs1s =3D GET_C_RS1S(ctx->opcode);
> +    uint8_t funct3 =3D extract16(opcode, 13, 3);
> +    uint8_t rd_rs2 =3D GET_C_RS2S(opcode);
> +    uint8_t rs1s =3D GET_C_RS1S(opcode);
>
>      switch (funct3) {
>      case 3:
>  #if defined(TARGET_RISCV64)
>          /* C.LD(RV64/128) -> ld rd', offset[7:3](rs1')*/
>          gen_load_c(ctx, OPC_RISC_LD, rd_rs2, rs1s,
> -                 GET_C_LD_IMM(ctx->opcode));
> +                 GET_C_LD_IMM(opcode));
>  #else
>          /* C.FLW (RV32) -> flw rd', offset[6:2](rs1')*/
>          gen_fp_load(ctx, OPC_RISC_FLW, rd_rs2, rs1s,
> -                    GET_C_LW_IMM(ctx->opcode));
> +                    GET_C_LW_IMM(opcode));
>  #endif
>          break;
>      case 7:
>  #if defined(TARGET_RISCV64)
>          /* C.SD (RV64/128) -> sd rs2', offset[7:3](rs1')*/
>          gen_store_c(ctx, OPC_RISC_SD, rs1s, rd_rs2,
> -                  GET_C_LD_IMM(ctx->opcode));
> +                  GET_C_LD_IMM(opcode));
>  #else
>          /* C.FSW (RV32) -> fsw rs2', offset[6:2](rs1')*/
>          gen_fp_store(ctx, OPC_RISC_FSW, rs1s, rd_rs2,
> -                     GET_C_LW_IMM(ctx->opcode));
> +                     GET_C_LW_IMM(opcode));
>  #endif
>          break;
>      }
>  }
>
> -static void decode_RV32_64C(DisasContext *ctx)
> +static void decode_RV32_64C(DisasContext *ctx, uint16_t opcode)
>  {
> -    uint8_t op =3D extract32(ctx->opcode, 0, 2);
> +    uint8_t op =3D extract16(opcode, 0, 2);
>
>      switch (op) {
>      case 0:
> -        decode_RV32_64C0(ctx);
> +        decode_RV32_64C0(ctx, opcode);
>          break;
>      }
>  }
> @@ -709,22 +708,25 @@ static bool gen_shift(DisasContext *ctx, arg_r *a,
>  /* Include the auto-generated decoder for 16 bit insn */
>  #include "decode_insn16.inc.c"
>
> -static void decode_opc(DisasContext *ctx)
> +static void decode_opc(CPURISCVState *env, DisasContext *ctx, uint16_t o=
pcode)
>  {
>      /* check for compressed insn */
> -    if (extract32(ctx->opcode, 0, 2) !=3D 3) {
> +    if (extract16(opcode, 0, 2) !=3D 3) {
>          if (!has_ext(ctx, RVC)) {
>              gen_exception_illegal(ctx);
>          } else {
>              ctx->pc_succ_insn =3D ctx->base.pc_next + 2;
> -            if (!decode_insn16(ctx, ctx->opcode)) {
> +            if (!decode_insn16(ctx, opcode)) {
>                  /* fall back to old decoder */
> -                decode_RV32_64C(ctx);
> +                decode_RV32_64C(ctx, opcode);
>              }
>          }
>      } else {
> +        uint32_t opcode32 =3D opcode;
> +        opcode32 =3D deposit32(opcode32, 16, 16,
> +                             translator_lduw(env, ctx->base.pc_next + 2)=
);
>          ctx->pc_succ_insn =3D ctx->base.pc_next + 4;
> -        if (!decode_insn32(ctx, ctx->opcode)) {
> +        if (!decode_insn32(ctx, opcode32)) {
>              gen_exception_illegal(ctx);
>          }
>      }
> @@ -776,9 +778,9 @@ static void riscv_tr_translate_insn(DisasContextBase =
*dcbase, CPUState *cpu)
>  {
>      DisasContext *ctx =3D container_of(dcbase, DisasContext, base);
>      CPURISCVState *env =3D cpu->env_ptr;
> +    uint16_t opcode16 =3D translator_lduw(env, ctx->base.pc_next);
>
> -    ctx->opcode =3D translator_ldl(env, ctx->base.pc_next);
> -    decode_opc(ctx);
> +    decode_opc(env, ctx, opcode16);
>      ctx->base.pc_next =3D ctx->pc_succ_insn;
>
>      if (ctx->base.is_jmp =3D=3D DISAS_NEXT) {
> --
> 2.20.1
>
>

