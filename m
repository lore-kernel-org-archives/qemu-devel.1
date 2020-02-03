Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB94C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:38:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED57B2465D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 13:38:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i8ybQ+V+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED57B2465D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iybw7-0007At-32
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 08:38:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48857)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iybvM-0006aK-Rg
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:38:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iybvJ-00022W-7G
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:38:00 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:38671)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iybvH-00020L-M4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 08:37:57 -0500
Received: by mail-wr1-x443.google.com with SMTP id y17so18192156wrh.5
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 05:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=HCSn6sHEOZ6kfJRgou8gFxoVsNYb/EG7kEffDAzU4m8=;
 b=i8ybQ+V+4omp7W+YNipQ6jNEHD/L6kY9n6EiNAUK/KiWf/fsaZ2JSg2iBbIWploTHt
 P0tpk7YubXBJRdgkr4ZpdYQHxlTdA/tixjJoaryzQeY4Ik43bz1TEXT7KKbdtlCGL4V5
 WYNa/Z7FlVUhmAOuTXnMxlkG9US9+gymbWEnTGSPkR62FKbxyCHD9F2jehiU74A+1kTr
 SQPcIldW1gfqp8zrwcylbnOco6HvJP7yLcqRttsoYDaO1hoN+1XU9BbblXwL0Kfbo77v
 e51HZ9ZTg+5HmaDLNK6vFpYZlbRaMUKYc/W4Eu8G9suN8bp49IiN4h0ju7ge3v9WnQn8
 rTQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=HCSn6sHEOZ6kfJRgou8gFxoVsNYb/EG7kEffDAzU4m8=;
 b=iwkQBs4mCNhTMWOb0OgdFjwxypu3aHuQ5U7e8aUt307UN4zqT033doSsR0eEU4RgfC
 d409npTf5DfwEdlzzkhtxZa06/FGD9/ZCMRkzO4MjLBtrZkdkAC4e+KGSE1iqrrynnoT
 gGPbwjGrBYOoIfLkN8oAPHWH2RZWkSsmK7jvj3lPQIf4Jey7DvnM+G6ujSnei/xR0hBd
 nCaIFR3C3kyMlpSd7AaAeqMXas66rZVGVKhxqafBuv/Za5lEF2Yka14wyvSkfB7tHhHz
 bDLL7vjBuWXW2zQf9RsYYJ5jgsEj7FV8w1OKx0+gwkgQKC4EEDJ1EaqzvBx+1s8BZ4Pl
 Qi7A==
X-Gm-Message-State: APjAAAUHqqge6YoDMCqx7fI3keYA6HAVWCbetFv1GNeg5IYW0hAQ9KHA
 Yhk86wJUXcix+a6xLmzIeQB6UQ==
X-Google-Smtp-Source: APXvYqziFIUtEPeca2veqXv4RQvs8OO6RMpRS0+kJ+vOzhVTMeEnvkNE5Gyr4mAJCqbTbwVZs1U3xA==
X-Received: by 2002:adf:f80c:: with SMTP id s12mr15680842wrp.1.1580737074094; 
 Mon, 03 Feb 2020 05:37:54 -0800 (PST)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id d204sm23446179wmd.30.2020.02.03.05.37.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2020 05:37:52 -0800 (PST)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 16F2D1FF87;
 Mon,  3 Feb 2020 13:37:52 +0000 (GMT)
References: <20200202010439.6410-1-richard.henderson@linaro.org>
 <20200202010439.6410-6-richard.henderson@linaro.org>
User-agent: mu4e 1.3.7; emacs 27.0.60
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2 05/14] target/arm: Update MSR access for PAN
In-reply-to: <20200202010439.6410-6-richard.henderson@linaro.org>
Date: Mon, 03 Feb 2020 13:37:52 +0000
Message-ID: <87k153aj0v.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
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
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> For aarch64, there's a dedicated msr (imm, reg) insn.
> For aarch32, this is done via msr to cpsr; and writes
> from el0 are ignored.
>
> Since v8.0, the CPSR_RESERVED bits have been allocated.
> We are not yet implementing ARMv8.0-SSBS or ARMv8.4-DIT,
> so retain CPSR_RESERVED for now, so that the bits remain RES0.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
> v2: Move regdef to file scope; merge patch for CPSR_RESERVED:
>     do not remove CPSR_SSBS from CPSR_RESERVED yet, mask PAN
>     from CPSR if feature not enabled (pmm).
> ---
>  target/arm/cpu.h           | 11 +++++++++--
>  target/arm/helper-a64.c    |  6 ++++++
>  target/arm/helper.c        | 21 +++++++++++++++++++++
>  target/arm/op_helper.c     |  9 ++++++++-
>  target/arm/translate-a64.c | 14 ++++++++++++++
>  target/arm/translate.c     |  6 +++++-
>  6 files changed, 63 insertions(+), 4 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 08b2f5d73e..b11fdc3001 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -1186,12 +1186,18 @@ void pmu_init(ARMCPU *cpu);
>  #define CPSR_IT_2_7 (0xfc00U)
>  #define CPSR_GE (0xfU << 16)
>  #define CPSR_IL (1U << 20)
> -/* Note that the RESERVED bits include bit 21, which is PSTATE_SS in
> +/*
> + * Note that the RESERVED bits include bit 21, which is PSTATE_SS in
>   * an AArch64 SPSR but RES0 in AArch32 SPSR and CPSR. In QEMU we use
>   * env->uncached_cpsr bit 21 to store PSTATE.SS when executing in AArch3=
2,
>   * where it is live state but not accessible to the AArch32 code.
> + *
> + * TODO: With ARMv8.4-DIT, bit 21 is DIT in AArch32 (bit 24 for AArch64).
> + * We will need to move AArch32 SS somewhere else at that point.
> + * TODO: With ARMv8.0-SSBS, bit 23 is SSBS in AArch32 (bit 12 for AArch6=
4).
>   */
> -#define CPSR_RESERVED (0x7U << 21)
> +#define CPSR_RESERVED (5U << 21)
> +#define CPSR_PAN (1U << 22)
>  #define CPSR_J (1U << 24)
>  #define CPSR_IT_0_1 (3U << 25)
>  #define CPSR_Q (1U << 27)
> @@ -1258,6 +1264,7 @@ void pmu_init(ARMCPU *cpu);
>  #define PSTATE_BTYPE (3U << 10)
>  #define PSTATE_IL (1U << 20)
>  #define PSTATE_SS (1U << 21)
> +#define PSTATE_PAN (1U << 22)
>  #define PSTATE_V (1U << 28)
>  #define PSTATE_C (1U << 29)
>  #define PSTATE_Z (1U << 30)
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index bf45f8a785..70d6407f80 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -1014,6 +1014,9 @@ void HELPER(exception_return)(CPUARMState *env, uin=
t64_t new_pc)
>           * will sort the register banks out for us, and we've already
>           * caught all the bad-mode cases in el_from_spsr().
>           */
> +        if (!cpu_isar_feature(aa32_pan, env_archcpu(env))) {
> +            spsr &=3D ~CPSR_PAN;
> +        }
>          cpsr_write(env, spsr, ~0, CPSRWriteRaw);
>          if (!arm_singlestep_active(env)) {
>              env->uncached_cpsr &=3D ~PSTATE_SS;
> @@ -1031,6 +1034,9 @@ void HELPER(exception_return)(CPUARMState *env, uin=
t64_t new_pc)
>                        cur_el, new_el, env->regs[15]);
>      } else {
>          env->aarch64 =3D 1;
> +        if (!cpu_isar_feature(aa64_pan, env_archcpu(env))) {
> +            spsr &=3D ~PSTATE_PAN;
> +        }
>          pstate_write(env, spsr);
>          if (!arm_singlestep_active(env)) {
>              env->pstate &=3D ~PSTATE_SS;
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 795ef727d0..90a22921dc 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -4163,6 +4163,24 @@ static void aa64_daif_write(CPUARMState *env, cons=
t ARMCPRegInfo *ri,
>      env->daif =3D value & PSTATE_DAIF;
>  }
>=20=20
> +static uint64_t aa64_pan_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    return env->pstate & PSTATE_PAN;
> +}
> +
> +static void aa64_pan_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                           uint64_t value)
> +{
> +    env->pstate =3D (env->pstate & ~PSTATE_PAN) | (value & PSTATE_PAN);
> +}
> +
> +static const ARMCPRegInfo pan_reginfo =3D {
> +    .name =3D "PAN", .state =3D ARM_CP_STATE_AA64,
> +    .opc0 =3D 3, .opc1 =3D 0, .crn =3D 4, .crm =3D 2, .opc2 =3D 3,
> +    .type =3D ARM_CP_NO_RAW, .access =3D PL1_RW,
> +    .readfn =3D aa64_pan_read, .writefn =3D aa64_pan_write
> +};
> +
>  static CPAccessResult aa64_cacheop_access(CPUARMState *env,
>                                            const ARMCPRegInfo *ri,
>                                            bool isread)
> @@ -7608,6 +7626,9 @@ void register_cp_regs_for_features(ARMCPU *cpu)
>      if (cpu_isar_feature(aa64_lor, cpu)) {
>          define_arm_cp_regs(cpu, lor_reginfo);
>      }
> +    if (cpu_isar_feature(aa64_pan, cpu)) {
> +        define_one_arm_cp_reg(cpu, &pan_reginfo);
> +    }
>=20=20
>      if (arm_feature(env, ARM_FEATURE_EL2) && cpu_isar_feature(aa64_vh, c=
pu)) {
>          define_arm_cp_regs(cpu, vhe_reginfo);
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 27d16ad9ad..7ba578e826 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -400,11 +400,18 @@ void HELPER(cpsr_write)(CPUARMState *env, uint32_t =
val, uint32_t mask)
>  /* Write the CPSR for a 32-bit exception return */
>  void HELPER(cpsr_write_eret)(CPUARMState *env, uint32_t val)
>  {
> +    uint32_t mask;
> +
>      qemu_mutex_lock_iothread();
>      arm_call_pre_el_change_hook(env_archcpu(env));
>      qemu_mutex_unlock_iothread();
>=20=20
> -    cpsr_write(env, val, CPSR_ERET_MASK, CPSRWriteExceptionReturn);
> +    mask =3D CPSR_ERET_MASK;
> +    if (!cpu_isar_feature(aa32_pan, env_archcpu(env))) {
> +        mask &=3D ~CPSR_PAN;
> +    }
> +
> +    cpsr_write(env, val, mask, CPSRWriteExceptionReturn);
>=20=20
>      /* Generated code has already stored the new PC value, but
>       * without masking out its low bits, because which bits need
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 49631c2340..d8ba240a15 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1602,6 +1602,20 @@ static void handle_msr_i(DisasContext *s, uint32_t=
 insn,
>          s->base.is_jmp =3D DISAS_NEXT;
>          break;
>=20=20
> +    case 0x04: /* PAN */
> +        if (!dc_isar_feature(aa64_pan, s) || s->current_el =3D=3D 0) {
> +            goto do_unallocated;
> +        }
> +        if (crm & 1) {
> +            set_pstate_bits(PSTATE_PAN);
> +        } else {
> +            clear_pstate_bits(PSTATE_PAN);
> +        }
> +        t1 =3D tcg_const_i32(s->current_el);
> +        gen_helper_rebuild_hflags_a64(cpu_env, t1);
> +        tcg_temp_free_i32(t1);
> +        break;
> +
>      case 0x05: /* SPSel */
>          if (s->current_el =3D=3D 0) {
>              goto do_unallocated;
> diff --git a/target/arm/translate.c b/target/arm/translate.c
> index d58c328e08..0b1f0e0fea 100644
> --- a/target/arm/translate.c
> +++ b/target/arm/translate.c
> @@ -2760,13 +2760,17 @@ static uint32_t msr_mask(DisasContext *s, int fla=
gs, int spsr)
>      if (!arm_dc_feature(s, ARM_FEATURE_THUMB2)) {
>          mask &=3D ~CPSR_IT;
>      }
> +    if (!dc_isar_feature(aa32_pan, s)) {
> +        mask &=3D ~CPSR_PAN;
> +    }
>      /* Mask out execution state and reserved bits.  */
>      if (!spsr) {
>          mask &=3D ~(CPSR_EXEC | CPSR_RESERVED);
>      }
>      /* Mask out privileged bits.  */
> -    if (IS_USER(s))
> +    if (IS_USER(s)) {
>          mask &=3D CPSR_USER;
> +    }
>      return mask;
>  }


--=20
Alex Benn=C3=A9e

