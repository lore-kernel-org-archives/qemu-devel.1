Return-Path: <SRS0=WvtD=VW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D684C7618B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:03:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE08C22C7B
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2019 16:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+CWfRux"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE08C22C7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqgCv-0000i9-Vt
	for qemu-devel@archiver.kernel.org; Thu, 25 Jul 2019 12:03:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56400)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hqgCf-0000JE-GP
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:02:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hqgCe-0008MK-4l
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:02:49 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:39281)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hqgCd-0008LL-Tv
 for qemu-devel@nongnu.org; Thu, 25 Jul 2019 12:02:48 -0400
Received: by mail-wm1-x344.google.com with SMTP id u25so34869927wmc.4
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2019 09:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=b52blbUYMDEyLbuwF3GzpC7K2W0MevbI8D3GpngcMAU=;
 b=g+CWfRux5QagT9EmZMQVw+shyCxu/ESOHs1MY+9T5H0+QIL1Z9J0P534LG+lthmMam
 zhDMc5FKa+If0KyXg7O4wFcL4VHKXaRM19y98hfUvQZfWSsoT8J+KRJKT0ZbqNxc8S7e
 dRunA2nnUAb5D/xj7GEd2FpbH1QDKP5r8auMlHh4hI3Jtn5rQA7MWV+nJxS4uEIDA9Ax
 1XfdAXoLEKefOnRKPUW9B8wSG8e+e7dWZiOsrzIIemOdWw4s54ftgGS6NThcG2YxQuyi
 U2Fb3WyeR2wEsuPU79c7VjdRdGwJ1p0aQ1ZipWkMuaXsuvRBK2aZyPAaRdkOpBdCaM2B
 a84w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=b52blbUYMDEyLbuwF3GzpC7K2W0MevbI8D3GpngcMAU=;
 b=YoIKaH29nrgqtTo5sZINouFLHHVm/ubDIKFlajyKBe7YbwtzzVPeBKhM91tTTT2N3r
 HO207ot3erCy6lJx4E4Fv7mL/otTq/jnKM0mpqIjORPpxncG0e1TViOUfsqLozrTXqOH
 GiBDtXk0PB3lKQQr6ppy6/zleyM+GAgljJRLr5HkgVBopj1+PIpT1+RBpddp+YPkQZoG
 7Wrn1anFmhgrySnRa4ABHdw7Xe/tgt4dQIPEVt0q2sx+9zai58Wjs0zdglOtk0ZNFWFn
 Kb/mhE6S1tki9lwrNGvxDaSyhffhEoo3c8w9j3lpG5IeYItblQ+FA9MDwl29PJpiEkGt
 +bOw==
X-Gm-Message-State: APjAAAUMJEESoeIJhadzS1wykXp1Dtvi7VtFhnYlJRwm6PUwtsUH1r/9
 SRchUGrQwK+dcgv4rtXywNlz3A==
X-Google-Smtp-Source: APXvYqw+szPR1gGuC2XkT5flLF954fn0NiNGpKfEESMnKS3uKHo1Em6Lib1flMbkQKoMeC9wYqLh7w==
X-Received: by 2002:a7b:c247:: with SMTP id b7mr83956773wmj.13.1564070566564; 
 Thu, 25 Jul 2019 09:02:46 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id d10sm41415768wrx.34.2019.07.25.09.02.45
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 25 Jul 2019 09:02:45 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 9FB621FF87;
 Thu, 25 Jul 2019 17:02:45 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-19-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-19-richard.henderson@linaro.org>
Date: Thu, 25 Jul 2019 17:02:45 +0100
Message-ID: <87sgquyue2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [PATCH for-4.2 18/24] target/arm: Update arm_sctlr
 for VHE
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Use this function in many more places in order to select
> the correct control.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/cpu.h          | 10 ++++++----
>  target/arm/arch_dump.c    |  2 +-
>  target/arm/helper-a64.c   |  2 +-
>  target/arm/helper.c       | 10 +++++-----
>  target/arm/pauth_helper.c |  9 +--------
>  5 files changed, 14 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 7310adfd9b..7efbb488d9 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -3104,11 +3104,13 @@ static inline bool arm_sctlr_b(CPUARMState *env)
>  static inline uint64_t arm_sctlr(CPUARMState *env, int el)
>  {
>      if (el =3D=3D 0) {
> -        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> -        return env->cp15.sctlr_el[1];
> -    } else {
> -        return env->cp15.sctlr_el[el];
> +        if (arm_el_is_aa64(env, 2) && (arm_hcr_el2_eff(env) & HCR_E2H)) {
> +            el =3D 2;
> +        } else {
> +            el =3D 1;
> +        }
>      }
> +    return env->cp15.sctlr_el[el];
>  }
>
>
> diff --git a/target/arm/arch_dump.c b/target/arm/arch_dump.c
> index 26a2c09868..5fbd008d8c 100644
> --- a/target/arm/arch_dump.c
> +++ b/target/arm/arch_dump.c
> @@ -320,7 +320,7 @@ int cpu_get_dump_info(ArchDumpInfo *info,
>       * dump a hypervisor that happens to be running an opposite-endian
>       * kernel.
>       */
> -    info->d_endian =3D (env->cp15.sctlr_el[1] & SCTLR_EE) !=3D 0
> +    info->d_endian =3D (arm_sctlr(env, 1) & SCTLR_EE) !=3D 0
>                       ? ELFDATA2MSB : ELFDATA2LSB;
>
>      return 0;
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 060699b901..3bf1b731e7 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -70,7 +70,7 @@ static void daif_check(CPUARMState *env, uint32_t op,
>                         uint32_t imm, uintptr_t ra)
>  {
>      /* DAIF update to PSTATE. This is OK from EL0 only if UMA is set.  */
> -    if (arm_current_el(env) =3D=3D 0 && !(env->cp15.sctlr_el[1] & SCTLR_=
UMA)) {
> +    if (arm_current_el(env) =3D=3D 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)=
) {
>          raise_exception_ra(env, EXCP_UDEF,
>                             syn_aa64_sysregtrap(0, extract32(op, 0, 3),
>                                                 extract32(op, 3, 3), 4,
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 54c328b844..db13a8f9c0 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3868,7 +3868,7 @@ static void aa64_fpsr_write(CPUARMState *env, const=
 ARMCPRegInfo *ri,
>  static CPAccessResult aa64_daif_access(CPUARMState *env, const ARMCPRegI=
nfo *ri,
>                                         bool isread)
>  {
> -    if (arm_current_el(env) =3D=3D 0 && !(env->cp15.sctlr_el[1] & SCTLR_=
UMA)) {
> +    if (arm_current_el(env) =3D=3D 0 && !(arm_sctlr(env, 0) & SCTLR_UMA)=
) {
>          return CP_ACCESS_TRAP;
>      }
>      return CP_ACCESS_OK;
> @@ -3887,7 +3887,7 @@ static CPAccessResult aa64_cacheop_access(CPUARMSta=
te *env,
>      /* Cache invalidate/clean: NOP, but EL0 must UNDEF unless
>       * SCTLR_EL1.UCI is set.
>       */
> -    if (arm_current_el(env) =3D=3D 0 && !(env->cp15.sctlr_el[1] & SCTLR_=
UCI)) {
> +    if (arm_current_el(env) =3D=3D 0 && !(arm_sctlr(env, 0) & SCTLR_UCI)=
) {
>          return CP_ACCESS_TRAP;
>      }
>      return CP_ACCESS_OK;
> @@ -4114,7 +4114,7 @@ static CPAccessResult aa64_zva_access(CPUARMState *=
env, const ARMCPRegInfo *ri,
>      /* We don't implement EL2, so the only control on DC ZVA is the
>       * bit in the SCTLR which can prohibit access for EL0.
>       */
> -    if (arm_current_el(env) =3D=3D 0 && !(env->cp15.sctlr_el[1] & SCTLR_=
DZE)) {
> +    if (arm_current_el(env) =3D=3D 0 && !(arm_sctlr(env, 0) & SCTLR_DZE)=
) {
>          return CP_ACCESS_TRAP;
>      }
>      return CP_ACCESS_OK;
> @@ -5344,7 +5344,7 @@ static CPAccessResult ctr_el0_access(CPUARMState *e=
nv, const ARMCPRegInfo *ri,
>      /* Only accessible in EL0 if SCTLR.UCT is set (and only in AArch64,
>       * but the AArch32 CTR has its own reginfo struct)
>       */
> -    if (arm_current_el(env) =3D=3D 0 && !(env->cp15.sctlr_el[1] & SCTLR_=
UCT)) {
> +    if (arm_current_el(env) =3D=3D 0 && !(arm_sctlr(env, 0) & SCTLR_UCT)=
) {
>          return CP_ACCESS_TRAP;
>      }
>      return CP_ACCESS_OK;
> @@ -8161,7 +8161,7 @@ static void take_aarch32_exception(CPUARMState *env=
, int new_mode,
>      env->uncached_cpsr =3D (env->uncached_cpsr & ~CPSR_M) | new_mode;
>      /* Set new mode endianness */
>      env->uncached_cpsr &=3D ~CPSR_E;
> -    if (env->cp15.sctlr_el[arm_current_el(env)] & SCTLR_EE) {
> +    if (arm_sctlr(env, arm_current_el(env)) & SCTLR_EE) {
>          env->uncached_cpsr |=3D CPSR_E;
>      }
>      /* J and IL must always be cleared for exception entry */
> diff --git a/target/arm/pauth_helper.c b/target/arm/pauth_helper.c
> index d3194f2043..42c9141bb7 100644
> --- a/target/arm/pauth_helper.c
> +++ b/target/arm/pauth_helper.c
> @@ -386,14 +386,7 @@ static void pauth_check_trap(CPUARMState *env, int e=
l, uintptr_t ra)
>
>  static bool pauth_key_enabled(CPUARMState *env, int el, uint32_t bit)
>  {
> -    uint32_t sctlr;
> -    if (el =3D=3D 0) {
> -        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> -        sctlr =3D env->cp15.sctlr_el[1];
> -    } else {
> -        sctlr =3D env->cp15.sctlr_el[el];
> -    }
> -    return (sctlr & bit) !=3D 0;
> +    return (arm_sctlr(env, el) & bit) !=3D 0;
>  }
>
>  uint64_t HELPER(pacia)(CPUARMState *env, uint64_t x, uint64_t y)


--
Alex Benn=C3=A9e

