Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BC81C43331
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:29:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C96D6206B8
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 15:29:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SrcKeWtV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C96D6206B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47358 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5thW-0008S7-Rr
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 11:29:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43264)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1i5tbs-0002Ri-PM
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:23:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1i5tbr-0008GT-91
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:23:44 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:36670)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1i5tbr-0008G6-1s
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 11:23:43 -0400
Received: by mail-wm1-x344.google.com with SMTP id p13so3589231wmh.1
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 08:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=rEpItSB4Xub7nz9HFGLE3Rzi5nzh261DJBKUgDULZ0U=;
 b=SrcKeWtV/pCsOiMiBmsgewWzYfAIVRwzGozsy5NF3Ca3xSQ/5u9M1IQmZkes/lev+z
 2sgQYNGnzwCjaxLJ26vE9RDLOtaZRcGp67GQ4lbUaQb5pfnzR1S64Z6x4xUxphLn7uJb
 FD/SC0t4TgenassrnSpn2KRHQPQJJXHq0Nrm0hUCJ5+/c2H65UI/E9VVwySuFwAReenW
 MROE4IPW3KR8KdJl+E4AWOCSF4nGzt/Pc65SsXGlQFOCt98DyqS4bjhLinAjLOr9FZdc
 ciMxtjL0HpdGIToaDCzxg0H4goETcx5REMTd+FChSpGeKuJXT7vCmt78Eher3Lqawjpp
 lIfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=rEpItSB4Xub7nz9HFGLE3Rzi5nzh261DJBKUgDULZ0U=;
 b=VStaEj8Beh2iWSX4F4NIHqlSe9JfrBFHEZ9UskzKfZpVgK0/BlzBJ6X3tDl9jdso0V
 eUSLCH26yhzqWGeMIiEDzWrvmBDb7qUThmk9cgl1xYu7HhcNBKU3FgQlxM7R6s6mdX8x
 g20fNws1C2hEoq+Xie7IkEe3yIr/iLoTpY4G2wPv/yIWNTKNz6pJVmUamtkNzJfJrsco
 /Ejt/Zwf1V6FxOaF0UOxVGpfwxABTFebswxgd4yZgkRYHaQTs4zy6OYwgPZYTq87952B
 mERc8Xqbo85ABGvAFPzp2+yeHFIeiliwAt+I8Xm6o14KFD1AGlOnHe9LJXeoHxLj3s7r
 Bkug==
X-Gm-Message-State: APjAAAWxI6nC9h5POZ5ExBQAv/LegFp+LEH3g5w9jb2GMvaf6zI+tGxO
 P7XESF6TbIRXecmJFF18umiMog==
X-Google-Smtp-Source: APXvYqzoqxCm3gqiCe6kX4WcOJrx+5C1DT7MUz/zgRv7kn41fWzGP1zvy/bBszITtRBW8Z+Llsf/1w==
X-Received: by 2002:a1c:3c43:: with SMTP id j64mr3401930wma.65.1567697021878; 
 Thu, 05 Sep 2019 08:23:41 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i73sm4103667wmg.33.2019.09.05.08.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Sep 2019 08:23:41 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 6F9671FF87;
 Thu,  5 Sep 2019 16:23:40 +0100 (BST)
References: <20190820210720.18976-1-richard.henderson@linaro.org>
 <20190820210720.18976-18-richard.henderson@linaro.org>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190820210720.18976-18-richard.henderson@linaro.org>
Date: Thu, 05 Sep 2019 16:23:40 +0100
Message-ID: <877e6m937n.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 17/17] target/arm: Rely on
 hflags correct in cpu_get_tb_cpu_state
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

> This is the payoff.
>
> From perf record -g data of ubuntu 18 boot and shutdown:
>
> BEFORE:
>
> -   23.02%     2.82%  qemu-system-aar  [.] helper_lookup_tb_ptr
>    - 20.22% helper_lookup_tb_ptr
>       + 10.05% tb_htable_lookup
>       - 9.13% cpu_get_tb_cpu_state
>            3.20% aa64_va_parameters_both
>            0.55% fp_exception_el
>
> -   11.66%     4.74%  qemu-system-aar  [.] cpu_get_tb_cpu_state
>    - 6.96% cpu_get_tb_cpu_state
>         3.63% aa64_va_parameters_both
>         0.60% fp_exception_el
>         0.53% sve_exception_el
>
> AFTER:
>
> -   16.40%     3.40%  qemu-system-aar  [.] helper_lookup_tb_ptr
>    - 13.03% helper_lookup_tb_ptr
>       + 11.19% tb_htable_lookup
>         0.55% cpu_get_tb_cpu_state
>
>      0.98%     0.71%  qemu-system-aar  [.] cpu_get_tb_cpu_state
>
>      0.87%     0.24%  qemu-system-aar  [.] rebuild_hflags_a64
>
> Before, helper_lookup_tb_ptr is the second hottest function in the
> application, consuming almost a quarter of the runtime.  Within the
> entire execution, cpu_get_tb_cpu_state consumes about 12%.
>
> After, helper_lookup_tb_ptr has dropped to the fourth hottest function,
> with consumption dropping to a sixth of the runtime.  Within the
> entire execution, cpu_get_tb_cpu_state has dropped below 1%, and the
> supporting function to rebuild hflags also consumes about 1%.
>
> Assertions are retained for --enable-debug-tcg.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

Hmm something must have been missed for M-profile because:

  make run-tcg-tests-arm-softmmu V=3D1

Leads to:

  timeout 15  /home/alex/lsrc/qemu.git/builds/all.debug/arm-softmmu/qemu-sy=
stem-arm -monitor none -display none -chardev file,path=3Dtest-armv6m-undef=
.out,id=3Doutput -semihosting -M microbit -kernel test-armv6m-undef
  qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

  R00=3D00000000 R01=3D00000000 R02=3D00000000 R03=3D00000000
  R04=3D00000000 R05=3D00000000 R06=3D00000000 R07=3D00000000
  R08=3D00000000 R09=3D00000000 R10=3D00000000 R11=3D00000000
  R12=3D00000000 R13=3D20003fe0 R14=3Dfffffff9 R15=3D000000c0
  XPSR=3D41000003 -Z-- T handler
  FPSCR: 00000000
  timeout: the monitored command dumped core

But annoyingly not shown up by the debug-tcg verification. The commit
before works fine.

> Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Retain asserts for future debugging.
> ---
>  target/arm/helper.c | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index d1bf71a260..5e4f996882 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11211,12 +11211,15 @@ void HELPER(rebuild_hflags_a64)(CPUARMState *en=
v, int el)
>  void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>                            target_ulong *cs_base, uint32_t *pflags)
>  {
> -    uint32_t flags, pstate_for_ss;
> +    uint32_t flags =3D env->hflags;
> +    uint32_t pstate_for_ss;
>
>      *cs_base =3D 0;
> -    flags =3D rebuild_hflags_internal(env);
> +#ifdef CONFIG_TCG_DEBUG
> +    assert(flags =3D=3D rebuild_hflags_internal(env));
> +#endif
>
> -    if (is_a64(env)) {
> +    if (FIELD_EX32(flags, TBFLAG_ANY, AARCH64_STATE)) {
>          *pc =3D env->pc;
>          if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);


--
Alex Benn=C3=A9e

