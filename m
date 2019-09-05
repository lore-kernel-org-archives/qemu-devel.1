Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B876FC47420
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:59:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D91420828
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOLxxx3G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D91420828
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46432 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5sId-0006NI-NW
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 09:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53052)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5sHT-0005S3-LU
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:58:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5sHQ-0007iW-OI
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:58:35 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:40917)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5sHP-0007f5-SZ
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:58:32 -0400
Received: by mail-wm1-x344.google.com with SMTP id t9so3168133wmi.5
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 06:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=c4ZznlnZYhNGCB11jbY/1+z7ec+WFFEdfK45/injP1c=;
 b=WOLxxx3GQpYeIF4Kv9CvrCdB6ioB8oFLGBQ54FO03blvNSZYLNU8HYFrj1cfPNelv0
 J+2fBuhvK5vhj7kjvemk1sYnPKoWn6uIuolPUm1abxjNHfgpy0Lo9JXeq2QSpYABkHsu
 L8JFa89AphMcdMpILQgDh+OcM4lidsBtmz3qYpapSBQOJseuLzboCU+ku9TxqIJXR+Vg
 oOBY8CzJ75ZpyRwNr32XzNXvnXURySxNXVQoxRUiKdZe8ZOaTBGgyZrQBUNvYghElKE5
 P+T6TzxqOcYmKnAl4w5pUW1wDWip6tg/q4QErGygrQLLJ3QFcknQOYRT1BWBqQjxJ6Jf
 KKiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=c4ZznlnZYhNGCB11jbY/1+z7ec+WFFEdfK45/injP1c=;
 b=Rwq+LGMhmLzITcLS5KCW+5PQIs1MVzURniADn0MpJQ8eJKx7AlfyJ5OHffFQ1MIoNs
 exxUIDbDv8ayXGhHweXUtZYbHceysHp75Nrs/xvY5kIGw7+xmX7t/Obm0Xf7oPX9etoV
 89ZMXuEPQp6dwXKNlq2TdROyx/ZD+Hj+GlvWtqgN/ehfS3YANq+YvBF/XmJ5eVjRpwck
 M9flxlQMp3UbD63TH3mlrbrpWpK+RF6b+d8i1gJJ5zM7q6Qd0/ryhmuHi/xLYTEk3NCW
 BE94zbwCc4QKZ1jgGeLCceMQ+41xSq3BMO+NgklY9Ls5kAwRu5ksU5tqXggnSrRqaF27
 4s8g==
X-Gm-Message-State: APjAAAUU3FaDQVHlJpyXFROQNOfpGKxgzOk2VXkFkaotHtXo+Aldo1Ik
 25GZkzHk4Eo2cH9y1JhhqnB6NA==
X-Google-Smtp-Source: APXvYqxfvusqWnKF4WeTEsiH3rNfUOHMROF+p0SYqWEtdu3hr8wqZWgWMw13ZcpFci+Qc9ZVBI9EuA==
X-Received: by 2002:a1c:4b14:: with SMTP id y20mr3206920wma.10.1567691910557; 
 Thu, 05 Sep 2019 06:58:30 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a18sm3894457wrh.25.2019.09.05.06.58.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 06:58:29 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 3B1D31FF87;
 Thu,  5 Sep 2019 14:58:29 +0100 (BST)
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190820210720.18976-2-richard.henderson@linaro.org>
Date: Thu, 05 Sep 2019 14:58:29 +0100
Message-ID: <878sr2975m.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 01/17] target/arm: Split out
 rebuild_hflags_common
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

> Create a function to compute the values of the TBFLAG_ANY bits
> that will be cached.  For now, the env->hflags variable is not
> used, and the results are fed back to cpu_get_tb_cpu_state.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h    | 29 ++++++++++++++++++-----------
>  target/arm/helper.c | 26 +++++++++++++++++++-------
>  2 files changed, 37 insertions(+), 18 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 0981303170..3dc52c032b 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -231,6 +231,9 @@ typedef struct CPUARMState {
>      uint32_t pstate;
>      uint32_t aarch64; /* 1 if CPU is in aarch64 state; inverse of PSTATE=
.nRW */
>
> +    /* Cached TBFLAGS state.  See below for which bits are included.  */
> +    uint32_t hflags;
> +
>      /* Frequently accessed CPSR bits are stored separately for efficienc=
y.
>         This contains all the other bits.  Use cpsr_{read,write} to access
>         the whole CPSR.  */
> @@ -3136,15 +3139,18 @@ typedef ARMCPU ArchCPU;
>
>  #include "exec/cpu-all.h"
>
> -/* Bit usage in the TB flags field: bit 31 indicates whether we are
> +/*
> + * Bit usage in the TB flags field: bit 31 indicates whether we are
>   * in 32 or 64 bit mode. The meaning of the other bits depends on that.
>   * We put flags which are shared between 32 and 64 bit mode at the top
>   * of the word, and flags which apply to only one mode at the bottom.
> + *
> + * Unless otherwise noted, these bits are cached in env->hflags.
>   */
>  FIELD(TBFLAG_ANY, AARCH64_STATE, 31, 1)
>  FIELD(TBFLAG_ANY, MMUIDX, 28, 3)
>  FIELD(TBFLAG_ANY, SS_ACTIVE, 27, 1)
> -FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)
> +FIELD(TBFLAG_ANY, PSTATE_SS, 26, 1)     /* Not cached. */
>  /* Target EL if we take a floating-point-disabled exception */
>  FIELD(TBFLAG_ANY, FPEXC_EL, 24, 2)
>  FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
> @@ -3155,13 +3161,14 @@ FIELD(TBFLAG_ANY, BE_DATA, 23, 1)
>  FIELD(TBFLAG_ANY, DEBUG_TARGET_EL, 21, 2)
>
>  /* Bit usage when in AArch32 state: */
> -FIELD(TBFLAG_A32, THUMB, 0, 1)
> -FIELD(TBFLAG_A32, VECLEN, 1, 3)
> -FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)
> +FIELD(TBFLAG_A32, THUMB, 0, 1)          /* Not cached. */
> +FIELD(TBFLAG_A32, VECLEN, 1, 3)         /* Not cached. */
> +FIELD(TBFLAG_A32, VECSTRIDE, 4, 2)      /* Not cached. */
>  /*
>   * We store the bottom two bits of the CPAR as TB flags and handle
>   * checks on the other bits at runtime. This shares the same bits as
>   * VECSTRIDE, which is OK as no XScale CPU has VFP.
> + * Not cached, because VECLEN+VECSTRIDE are not cached.
>   */
>  FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
>  /*
> @@ -3170,15 +3177,15 @@ FIELD(TBFLAG_A32, XSCALE_CPAR, 4, 2)
>   * the same thing as the current security state of the processor!
>   */
>  FIELD(TBFLAG_A32, NS, 6, 1)
> -FIELD(TBFLAG_A32, VFPEN, 7, 1)
> -FIELD(TBFLAG_A32, CONDEXEC, 8, 8)
> +FIELD(TBFLAG_A32, VFPEN, 7, 1)          /* Not cached. */
> +FIELD(TBFLAG_A32, CONDEXEC, 8, 8)       /* Not cached. */
>  FIELD(TBFLAG_A32, SCTLR_B, 16, 1)
>  /* For M profile only, set if FPCCR.LSPACT is set */
> -FIELD(TBFLAG_A32, LSPACT, 18, 1)
> +FIELD(TBFLAG_A32, LSPACT, 18, 1)        /* Not cached. */
>  /* For M profile only, set if we must create a new FP context */
> -FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1)
> +FIELD(TBFLAG_A32, NEW_FP_CTXT_NEEDED, 19, 1) /* Not cached. */
>  /* For M profile only, set if FPCCR.S does not match current security st=
ate */
> -FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1)
> +FIELD(TBFLAG_A32, FPCCR_S_WRONG, 20, 1) /* Not cached. */
>  /* For M profile only, Handler (ie not Thread) mode */
>  FIELD(TBFLAG_A32, HANDLER, 21, 1)
>  /* For M profile only, whether we should generate stack-limit checks */
> @@ -3190,7 +3197,7 @@ FIELD(TBFLAG_A64, SVEEXC_EL, 2, 2)
>  FIELD(TBFLAG_A64, ZCR_LEN, 4, 4)
>  FIELD(TBFLAG_A64, PAUTH_ACTIVE, 8, 1)
>  FIELD(TBFLAG_A64, BT, 9, 1)
> -FIELD(TBFLAG_A64, BTYPE, 10, 2)
> +FIELD(TBFLAG_A64, BTYPE, 10, 2)         /* Not cached. */
>  FIELD(TBFLAG_A64, TBID, 12, 2)
>
>  static inline bool bswap_code(bool sctlr_b)
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 7e0d5398ab..f2c6419369 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11016,6 +11016,22 @@ ARMMMUIdx arm_stage1_mmu_idx(CPUARMState *env)
>  }
>  #endif
>
> +static uint32_t rebuild_hflags_common(CPUARMState *env, int fp_el,
> +                                      ARMMMUIdx mmu_idx, uint32_t flags)
> +{
> +    flags =3D FIELD_DP32(flags, TBFLAG_ANY, FPEXC_EL, fp_el);
> +    flags =3D FIELD_DP32(flags, TBFLAG_ANY, MMUIDX,
> +                       arm_to_core_mmu_idx(mmu_idx));
> +
> +    if (arm_cpu_data_is_big_endian(env)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
> +    }
> +    if (arm_singlestep_active(env)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
> +    }
> +    return flags;
> +}
> +
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> @@ -11107,7 +11123,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>          }
>      }
>
> -    flags =3D FIELD_DP32(flags, TBFLAG_ANY, MMUIDX, arm_to_core_mmu_idx(=
mmu_idx));
> +    flags =3D rebuild_hflags_common(env, fp_el, mmu_idx, flags);
>
>      /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
>       * states defined in the ARM ARM for software singlestep:
> @@ -11115,9 +11131,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>       *     0            x       Inactive (the TB flag for SS is always 0)
>       *     1            0       Active-pending
>       *     1            1       Active-not-pending
> +     * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
>       */
> -    if (arm_singlestep_active(env)) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_ANY, SS_ACTIVE, 1);
> +    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)) {
>          if (is_a64(env)) {
>              if (env->pstate & PSTATE_SS) {
>                  flags =3D FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
> @@ -11128,10 +11144,6 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>              }
>          }
>      }
> -    if (arm_cpu_data_is_big_endian(env)) {
> -        flags =3D FIELD_DP32(flags, TBFLAG_ANY, BE_DATA, 1);
> -    }
> -    flags =3D FIELD_DP32(flags, TBFLAG_ANY, FPEXC_EL, fp_el);
>
>      if (arm_v7m_is_handler_mode(env)) {
>          flags =3D FIELD_DP32(flags, TBFLAG_A32, HANDLER, 1);


--
Alex Benn=C3=A9e

