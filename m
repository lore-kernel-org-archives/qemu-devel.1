Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7360ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:22:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A5792089C
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 18:22:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o8ErCFGV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A5792089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iK4zQ-0001lw-Mh
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 14:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56640)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iK4y6-0001EV-PP
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:21:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iK4y5-0006LS-E1
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:21:18 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35407)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iK4y5-0006LE-6O
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 14:21:17 -0400
Received: by mail-wr1-x444.google.com with SMTP id v8so20835198wrt.2
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=aZm2f/WCH7N0VhBrjaf/2NY3tUbeva/AFHZy0OJvEx0=;
 b=o8ErCFGV5f1EdleEI3EP4l4nPL/OKIz1TN7JyD47+fk2fCWkCENigBKxKFbb/L2sVu
 oZvxjVQBfZFiCxVUEb0oCgD3LDO7uWiXBUrb/ix4GxtvcZf00CftdhhKHTI2yFGfeAx5
 Y+9I+PBjBo+Zp/bQgxlXwbMOJEcEJO5w8bRb9WCWdKobHOrU/abKMtFG/kT+HY25Q5FS
 P4Tnx0wMjTKChyySOzSdLubaXzgrbBYR26c5jz94OxvXfujldRjtCEWcnhpNHrxOpaJH
 g0hMsw+YiDkEwzN/rZUPLk3GfhORfxP+HBNL3xtQUwXUHnb9zCfq0o1dA2URBfUm5hM+
 b0Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=aZm2f/WCH7N0VhBrjaf/2NY3tUbeva/AFHZy0OJvEx0=;
 b=CYxwKX/ZJp9iZikVmW9vp4VWzsVEjf0q8/7dd5VL8VRtct3bL9O5cI6T3RmbXif4Tu
 +LU8KiIZ/v0p1aM+6Nk86FTXkmz8OIgZeG7c9uw0RhczT+BC4ov/CUSDa/12SDk1zIwA
 qyyrSEjTWQNp0a2qlGbsWc/6Nk6uVLzddSjpMdyLiM83aEi9KHeqgXlbuULhsUiCuWSW
 F4lffvjDXYVITrC87+23wcM+3UiIFXmNzDS8TYozZSikUbC3S3lN896vKn0GRSNphcMf
 R4Qf+nbQCrPnGr2OsfoIGIEDplzHJl4A+GBMJHm+MKrb4wbrshyl7ALR3fI1LcLCi626
 NOlw==
X-Gm-Message-State: APjAAAUGK+kHnd51Cvr0VS+7NGUGGsWnLERMD+/TO0w3ls3oqm07kQfV
 xqv8qsMxaX/OsU3r1y2i2vF7TQ==
X-Google-Smtp-Source: APXvYqy8vKXTmalE6h9QkJDsyBOZbszR1FKcj8jX159m+PaNMyI6QjHXD2CM0kbtXaFTqRqtxRJDoA==
X-Received: by 2002:adf:fa87:: with SMTP id h7mr28546868wrr.304.1571077275706; 
 Mon, 14 Oct 2019 11:21:15 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n14sm16456526wro.83.2019.10.14.11.21.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Oct 2019 11:21:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 44C7F1FF87;
 Mon, 14 Oct 2019 19:21:14 +0100 (BST)
References: <20191011155546.14342-1-richard.henderson@linaro.org>
 <20191011155546.14342-11-richard.henderson@linaro.org>
User-agent: mu4e 1.3.5; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v6 10/20] target/arm: Simplify set of PSTATE_SS in
 cpu_get_tb_cpu_state
In-reply-to: <20191011155546.14342-11-richard.henderson@linaro.org>
Date: Mon, 14 Oct 2019 19:21:14 +0100
Message-ID: <87h84bmbmt.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: laurent.desnogues@gmail.com, peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Hoist the variable load for PSTATE into the existing test vs is_a64.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

> ---
>  target/arm/helper.c | 20 ++++++++------------
>  1 file changed, 8 insertions(+), 12 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index e2a62cf19a..398e5f5d6d 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -11197,7 +11197,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>      ARMMMUIdx mmu_idx =3D arm_mmu_idx(env);
>      int current_el =3D arm_current_el(env);
>      int fp_el =3D fp_exception_el(env, current_el);
> -    uint32_t flags;
> +    uint32_t flags, pstate_for_ss;
>
>      if (is_a64(env)) {
>          *pc =3D env->pc;
> @@ -11205,6 +11205,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targe=
t_ulong *pc,
>          if (cpu_isar_feature(aa64_bti, env_archcpu(env))) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A64, BTYPE, env->btype);
>          }
> +        pstate_for_ss =3D env->pstate;
>      } else {
>          *pc =3D env->regs[15];
>
> @@ -11257,9 +11258,11 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>              || arm_el_is_aa64(env, 1) || arm_feature(env, ARM_FEATURE_M)=
) {
>              flags =3D FIELD_DP32(flags, TBFLAG_A32, VFPEN, 1);
>          }
> +        pstate_for_ss =3D env->uncached_cpsr;
>      }
>
> -    /* The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
> +    /*
> +     * The SS_ACTIVE and PSTATE_SS bits correspond to the state machine
>       * states defined in the ARM ARM for software singlestep:
>       *  SS_ACTIVE   PSTATE.SS   State
>       *     0            x       Inactive (the TB flag for SS is always 0)
> @@ -11267,16 +11270,9 @@ void cpu_get_tb_cpu_state(CPUARMState *env, targ=
et_ulong *pc,
>       *     1            1       Active-not-pending
>       * SS_ACTIVE is set in hflags; PSTATE_SS is computed every TB.
>       */
> -    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE)) {
> -        if (is_a64(env)) {
> -            if (env->pstate & PSTATE_SS) {
> -                flags =3D FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
> -            }
> -        } else {
> -            if (env->uncached_cpsr & PSTATE_SS) {
> -                flags =3D FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
> -            }
> -        }
> +    if (FIELD_EX32(flags, TBFLAG_ANY, SS_ACTIVE) &&
> +        (pstate_for_ss & PSTATE_SS)) {
> +        flags =3D FIELD_DP32(flags, TBFLAG_ANY, PSTATE_SS, 1);
>      }
>
>      *pflags =3D flags;


--
Alex Benn=C3=A9e

