Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147E5ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1C1320854
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 16:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QP9Jqjxa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1C1320854
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52776 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK2rh-0006Fk-EY
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 12:06:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35888)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2mV-0000A0-8B
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:01:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK2mQ-0003Q7-Mu
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:01:09 -0400
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:37873)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK2mP-0003NZ-BR
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 12:01:05 -0400
Received: by mail-wr1-x441.google.com with SMTP id p14so20364979wro.4
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 09:01:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=+8Ll768UMDhgJThTm9Va8TfwkSSJbJmMfkNgOXExeTI=;
 b=QP9JqjxamLziB9s+AeKryXB18vOQf9eYPbJ0dNUUh7kz8ChmNcGV2L+S1AZ8WUirE8
 CtHa6kE2lYLN2PMuxGoLhmFGxdLsg/SJuMG2yLkzIpJZwej3LKESk4H2wFmkn57NY62g
 Q/s6eRcWTdl4+bVtrsWoTNe0YqCLISzeYdV8sNDSx2mFStnps/BU2+d0fnE8rCr/NtMT
 Uss4yHFRP4rS+ZgxFPo5KfDFmIwOoLHoYlgiUSoarjcs/Bl3UE1Fk471j58owmhvDE+x
 w+nJopph9bvvawKrXHbfCfWC1U9BEG+rUsdorJl/EMOQCkXewADfEiMeome1vL4gT0xD
 x3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=+8Ll768UMDhgJThTm9Va8TfwkSSJbJmMfkNgOXExeTI=;
 b=BlHz0v+Qpx2+CkGKyrK2I5RpMcE23XEOiu3qyvzsharNkv5Ogzmq29bqULb6ibmpgZ
 e8XroCwDh4/arBAzG2AJDkD2XjzRD2i8NlPllkXiyjuX58EbfuiRLefqTacRHWMrC85P
 FDNv+YjPpJJpxxNB+6+f+zQHFiSPwU6jDWkKS5bFPHxDmROVqjDGIarNlC9yMLM5ZgbB
 wU+V2YHRR9GK3RL7QdgmxPCsXpM0eqwyQu7SXAnSlZWfElAYlkuBAzQ05c/yKbz2d8n/
 Hh+5l+c6tSA/H3S4VN6dhUQxnTND+BhctltwfW2wrQEWa6M2JJcO9UsNFTXhf33KaUVa
 eN2A==
X-Gm-Message-State: APjAAAXnbicUfAmycgGCi6koE5Rvm3xpmp8RZO8sToyo/84NanCsaiUy
 t2KoBjVLZUtHf/sw/iaORJigDQ==
X-Google-Smtp-Source: APXvYqyN5NdbwGO5XX16nNHwCHop6CWqeqfFrNemBXBp5llGGGlDmjv1TDACnrFMXxA9M6T/FTTUkw==
X-Received: by 2002:a5d:6745:: with SMTP id l5mr22520948wrw.51.1571068864081; 
 Mon, 14 Oct 2019 09:01:04 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id q19sm37513441wra.89.2019.10.14.09.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 09:01:03 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id AFDFE1FF87;
 Mon, 14 Oct 2019 17:01:02 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-5-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 04/20] target/arm: Split arm_cpu_data_is_big_endian
In-reply-to: <20191011155546.14342-5-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 17:01:02 +0100
Message-ID: <87sgnvmi4h.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Set TBFLAG_ANY.BE_DATA in rebuild_hflags_common_32 and
> rebuild_hflags_a64 instead of rebuild_hflags_common, where we do
> not need to re-test is_a64() nor re-compute the various inputs.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h    | 49 +++++++++++++++++++++++++++------------------
>  target/arm/helper.c | 16 +++++++++++----
>  2 files changed, 42 insertions(+), 23 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index ad79a6153b..4d961474ce 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3108,33 +3108,44 @@ static inline uint64_t arm_sctlr(CPUARMState *env=
, int el)
>      }
>  }
>
> +static inline bool arm_cpu_data_is_big_endian_a32(CPUARMState *env,
> +                                                  bool sctlr_b)
> +{
> +#ifdef CONFIG_USER_ONLY
> +    /*
> +     * In system mode, BE32 is modelled in line with the
> +     * architecture (as word-invariant big-endianness), where loads
> +     * and stores are done little endian but from addresses which
> +     * are adjusted by XORing with the appropriate constant. So the
> +     * endianness to use for the raw data access is not affected by
> +     * SCTLR.B.
> +     * In user mode, however, we model BE32 as byte-invariant
> +     * big-endianness (because user-only code cannot tell the
> +     * difference), and so we need to use a data access endianness
> +     * that depends on SCTLR.B.
> +     */
> +    if (sctlr_b) {
> +        return true;
> +    }
> +#endif
> +    /* In 32bit endianness is determined by looking at CPSR's E bit */
> +    return env->uncached_cpsr & CPSR_E;
> +}
> +
> +static inline bool arm_cpu_data_is_big_endian_a64(int el, uint64_t sctlr)
> +{
> +    return sctlr & (el ? SCTLR_EE : SCTLR_E0E);
> +}
>
>  /* Return true if the processor is in big-endian mode. */
>  static inline bool arm_cpu_data_is_big_endian(CPUARMState *env)
>  {
> -    /* In 32bit endianness is determined by looking at CPSR's E bit */
>      if (!is_a64(env)) {
> -        return
> -#ifdef CONFIG_USER_ONLY
> -            /* In system mode, BE32 is modelled in line with the
> -             * architecture (as word-invariant big-endianness), where lo=
ads
> -             * and stores are done little endian but from addresses which
> -             * are adjusted by XORing with the appropriate constant. So =
the
> -             * endianness to use for the raw data access is not affected=
 by
> -             * SCTLR.B.
> -             * In user mode, however, we model BE32 as byte-invariant
> -             * big-endianness (because user-only code cannot tell the
> -             * difference), and so we need to use a data access endianne=
ss
> -             * that depends on SCTLR.B.
> -             */
> -            arm_sctlr_b(env) ||
> -#endif
> -                ((env->uncached_cpsr & CPSR_E) ? 1 : 0);
> +        return arm_cpu_data_is_big_endian_a32(env, arm_sctlr_b(env));
>      } else {
>          int cur_el =3D arm_current_el(env);
>          uint64_t sctlr =3D arm_sctlr(env, cur_el);
> -
> -        return (sctlr & (cur_el ? SCTLR_EE : SCTLR_E0E)) !=3D 0;
> +        return arm_cpu_data_is_big_endian_a64(cur_el, sctlr);
>      }
>  }
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index f05d042474..4c65476d93 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11061,9 +11061,6 @@ static uint32_t rebuild_hflags_common(CPUARMState=
 *env, int fp_el,
>      flags =3D FIELD_DP32(flags, TBFLAG_ANY, MMUIDX,
>                         arm_to_core_mmu_idx(mmu_idx));
>
> -    if (arm_cpu_data_is_big_endian(env)) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
> -    }
>      if (arm_singlestep_active(env)) {
>          flags =3D FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
>      }
> @@ -11073,7 +11070,14 @@ static uint32_t rebuild_hflags_common(CPUARMStat=
e *env, int fp_el,
>  static uint32_t rebuild_hflags_common_32(CPUARMState *env, int fp_el,
>                                           ARMMMUIdx mmu_idx, uint32_t fla=
gs)
>  {
> -    flags =3D FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, arm_sctlr_b(env));
> +    bool sctlr_b =3D arm_sctlr_b(env);
> +
> +    if (sctlr_b) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_A32, SCTLR_B, 1);
> +    }
> +    if (arm_cpu_data_is_big_endian_a32(env, sctlr_b)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
> +    }
>      flags =3D FIELD_DP32(flags, TBFLAG_A32, NS, !access_secure_reg(env));
>
>      return rebuild_hflags_common(env, fp_el, mmu_idx, flags);
> @@ -11122,6 +11126,10 @@ static uint32_t rebuild_hflags_a64(CPUARMState *=
env, int el, int fp_el,
>
>      sctlr =3D arm_sctlr(env, el);
>
> +    if (arm_cpu_data_is_big_endian_a64(el, sctlr)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
> +    }
> +
>      if (cpu_isar_feature(aa64_pauth, env_archcpu(env))) {
>          /*
>           * In order to save space in flags, we record only whether


--
Alex Benn=C3=A9e

