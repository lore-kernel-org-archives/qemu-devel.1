Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D86ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78C5B206A3
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 19:03:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IwF+S5jh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78C5B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK5ct-0007jF-Dz
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 15:03:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34878)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5bJ-0006gW-CT
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:01:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK5bH-0003jJ-Q5
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:01:48 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:53634)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK5bE-0003gh-9d
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 15:01:45 -0400
Received: by mail-wm1-x344.google.com with SMTP id i16so18331681wmd.3
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 12:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=gYVM4myFjiNmtXIyo/vfPHerj9yY1dHHwKP9BS6D/is=;
 b=IwF+S5jhbC3IKUouqHag1NHtFQxQAVmw1HxoFIAArC3hvCwQBvpmxBEgwcWB5wrgzd
 5HmVWmM19szxGSU97Zsdq0tPTMhkTaJP/nBemuUVxuBzLZBOHkIYz2MbY2G5CrtQzPxp
 ty4nsTxFvpWTc0vEl/aWTjjrWakiK7IFAPAtXto58uOYI0+380vAYUoQFvQTnJ2vI/dR
 /LkMV1ujciGw3uVybSlw7+0FuU8s5DvtfAMsXb+7AfUSlalxnysNhR3T7spQB2PlFHDH
 vcfdreD6aXUM0RiE3vfJrufQcE9mOoKCaAeDDk2YIuUP6bH8basqGWsPY3kIbysVL4Tz
 gLJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=gYVM4myFjiNmtXIyo/vfPHerj9yY1dHHwKP9BS6D/is=;
 b=iBxgprgAgmKE3gJlhJQEdp84oaA7XHcuzpE0iQL3SudXxtSbjlDT/jA7iXZ+ZQkY7Z
 LcJQ8Xa30V+e+/QF9+WdCxdlQC/MkCzJnsCBfUchjMFs3ETlrGhrdlj1rwdcd/Q5e0oC
 yYi92ValQCLA0PcCMba2Y+OC5/gS62btxdi5cREM+lesnidKEVTIaPuSEW2uUUy3k59C
 30vHCVjzpWvcv+I6RzlOGCjTZJ/INltfxnGUN/zLD3hx1O7wGDnseDZdk7/e1bn/5FaH
 n1QzxZK59eKAvMjJdEFEa0fETHve8wk6+U5oiJ7cwCtzvilRfHCFcflFBRPoBvqFGAIB
 zvvA==
X-Gm-Message-State: APjAAAVE72YbpO2YO9mQz4BCkue2qoDJeZA7ks6/Rz1bH2EnsfKX0iaO
 s5A7d5v32vt5IG/afCjTrQK18g==
X-Google-Smtp-Source: APXvYqx5rEPOjhvAsIBjLwdKpbYD9R8eufIebRZnGE1CHrX4HxRmN9O5suncYHgAsTVKsNntlNy5XA==
X-Received: by 2002:a1c:f718:: with SMTP id v24mr15458493wmh.82.1571079700652; 
 Mon, 14 Oct 2019 12:01:40 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n1sm24149211wrg.67.2019.10.14.12.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 12:01:40 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 665F01FF87;
 Mon, 14 Oct 2019 20:01:39 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-17-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
Subject: Re: [PATCH v6 16/20] target/arm: Rebuild hflags at EL changes
In-reply-to: <20191011155546.14342-17-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 20:01:39 +0100
Message-ID: <878spnm9rg.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
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

> Begin setting, but not relying upon, env->hflags.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  linux-user/syscall.c    | 1 +
>  target/arm/cpu.c        | 1 +
>  target/arm/helper-a64.c | 3 +++
>  target/arm/helper.c     | 2 ++
>  target/arm/machine.c    | 1 +
>  target/arm/op_helper.c  | 1 +
>  6 files changed, 9 insertions(+)
>
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index e2af3c1494..ebefd05140 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -9982,6 +9982,7 @@ static abi_long do_syscall1(void *cpu_env, int num,=
 abi_long arg1,
>                      aarch64_sve_narrow_vq(env, vq);
>                  }
>                  env->vfp.zcr_el[1] =3D vq - 1;
> +                arm_rebuild_hflags(env);
>                  ret =3D vq * 16;
>              }
>              return ret;
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 2399c14471..d043e75166 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -406,6 +406,7 @@ static void arm_cpu_reset(CPUState *s)
>
>      hw_breakpoint_update_all(cpu);
>      hw_watchpoint_update_all(cpu);
> +    arm_rebuild_hflags(env);
>  }
>
>  bool arm_cpu_exec_interrupt(CPUState *cs, int interrupt_request)
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index bca80bdc38..b4cd680fc4 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -1025,6 +1025,7 @@ void HELPER(exception_return)(CPUARMState *env, uin=
t64_t new_pc)
>          } else {
>              env->regs[15] =3D new_pc & ~0x3;
>          }
> +        helper_rebuild_hflags_a32(env, new_el);
>          qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d t=
o "
>                        "AArch32 EL%d PC 0x%" PRIx32 "\n",
>                        cur_el, new_el, env->regs[15]);
> @@ -1036,10 +1037,12 @@ void HELPER(exception_return)(CPUARMState *env, u=
int64_t new_pc)
>          }
>          aarch64_restore_sp(env, new_el);
>          env->pc =3D new_pc;
> +        helper_rebuild_hflags_a64(env, new_el);
>          qemu_log_mask(CPU_LOG_INT, "Exception return from AArch64 EL%d t=
o "
>                        "AArch64 EL%d PC 0x%" PRIx64 "\n",
>                        cur_el, new_el, env->pc);
>      }
> +
>      /*
>       * Note that cur_el can never be 0.  If new_el is 0, then
>       * el0_a64 is return_to_aa64, else el0_a64 is ignored.
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b2d701cf00..aae7b62458 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -7998,6 +7998,7 @@ static void take_aarch32_exception(CPUARMState *env=
, int new_mode,
>          env->regs[14] =3D env->regs[15] + offset;
>      }
>      env->regs[15] =3D newpc;
> +    arm_rebuild_hflags(env);
>  }
>
>  static void arm_cpu_do_interrupt_aarch32_hyp(CPUState *cs)
> @@ -8345,6 +8346,7 @@ static void arm_cpu_do_interrupt_aarch64(CPUState *=
cs)
>      pstate_write(env, PSTATE_DAIF | new_mode);
>      env->aarch64 =3D 1;
>      aarch64_restore_sp(env, new_el);
> +    helper_rebuild_hflags_a64(env, new_el);
>
>      env->pc =3D addr;
>
> diff --git a/target/arm/machine.c b/target/arm/machine.c
> index 5c36707a7c..eb28b2381b 100644
> --- a/target/arm/machine.c
> +++ b/target/arm/machine.c
> @@ -756,6 +756,7 @@ static int cpu_post_load(void *opaque, int version_id)
>      if (!kvm_enabled()) {
>          pmu_op_finish(&cpu->env);
>      }
> +    arm_rebuild_hflags(&cpu->env);
>
>      return 0;
>  }
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 0fd4bd0238..ccc2cecb46 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -404,6 +404,7 @@ void HELPER(cpsr_write_eret)(CPUARMState *env, uint32=
_t val)
>       * state. Do the masking now.
>       */
>      env->regs[15] &=3D (env->thumb ? ~1 : ~3);
> +    arm_rebuild_hflags(env);
>
>      qemu_mutex_lock_iothread();
>      arm_call_el_change_hook(env_archcpu(env));


--
Alex Benn=C3=A9e

