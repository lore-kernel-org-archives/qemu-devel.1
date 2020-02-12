Return-Path: <SRS0=xDnh=4A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76FA3C352A4
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:04:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3FF5921739
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2020 20:04:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ae0cQpHx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3FF5921739
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42698 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j1yFM-00071q-Fw
	for qemu-devel@archiver.kernel.org; Wed, 12 Feb 2020 15:04:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37793)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1j1yEj-0006Zz-VE
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:03:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1j1yEi-00020g-NP
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:03:53 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:33028)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1j1yEi-00020F-Fe
 for qemu-devel@nongnu.org; Wed, 12 Feb 2020 15:03:52 -0500
Received: by mail-pf1-x444.google.com with SMTP id n7so1775858pfn.0
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 12:03:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:in-reply-to:cc:to:message-id:mime-version
 :content-transfer-encoding;
 bh=ku0u44AaXoWhDq+EGfoD3hhpjQe5d615GZuiFC5+jSA=;
 b=Ae0cQpHxGFtKGvlbMZLYFXBCzA4+0XVN1wH5eVR0pxQsUcTivZoI0HYzDWz3g3bTvt
 vkoSLquSjQnLfjHNhfaNWBsBmQZfYccxAmQL56M0aZ7xMm8pHtYNBzVLGvvVOvFC5309
 QWtlQQs0UDdUQ8ReSE/ii6YvxrCNo2Qm9etaevZlBPQIN6wGgs97uCJe0yMheAuwDRdg
 YAHIYLgaIvEDBMDrSwrwD5hs+61u0bT8NWfnmpiccqXEQfqFjaGNgrPgaJbPoN4BDvcW
 7flzD8PeSyuL1VP+MW9Cf3psBlC2jpJKUs8BrgI6yVryYu8pC9H48LcSMazTneFrL0Il
 as/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:in-reply-to:cc:to:message-id
 :mime-version:content-transfer-encoding;
 bh=ku0u44AaXoWhDq+EGfoD3hhpjQe5d615GZuiFC5+jSA=;
 b=H2BHsMwH1fQkgEqRfwYbjOSAu/8CRSV418VWiUu1JaaMP6VgTQp42qPICNx3IEGLi5
 EheapHfZ8MHjVoPke3HUZSAjAeavOclXCUNwcQ528q4XmPXmVeGiPVy16W3P8p1wUElK
 B8cRKOVF0GmQWxgB64tHyJPBjQmvzwUBV3OY8n+hCKrqpjHV+kGLViahhjRyrcglzOgI
 nfKidjIkDwHe5SYeY3vKkb3iVNEqWVdBlrMQO2R7YBI7qH7CTU8TY3EauGVic9WTZGBI
 qEh/XnbK7zhkF5mEko24Do+koqDhv4YDoGwn9YvPmiXjd+TZsI7ppbvmw/qk2HuU83p7
 IWog==
X-Gm-Message-State: APjAAAW61g3PHiT7aXrBCVAhv35GlfaZ9unJg3eXFzF59wLHm9M+ju/0
 b5cXGpsHIETgIA28qTrgbssMjHqOj78=
X-Google-Smtp-Source: APXvYqybEyBz6aZCFIco49ZXh1fSVeezuSMKPMUySe5EwzVt3DY/FyxkZlAiYcCH+jrIfdTOdbLFJg==
X-Received: by 2002:a62:790e:: with SMTP id u14mr13693447pfc.174.1581537830747; 
 Wed, 12 Feb 2020 12:03:50 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:23a5:d584:6a92:3e3c])
 by smtp.gmail.com with ESMTPSA id b24sm73925pfo.84.2020.02.12.12.03.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Feb 2020 12:03:50 -0800 (PST)
Date: Wed, 12 Feb 2020 12:03:50 -0800 (PST)
X-Google-Original-Date: Wed, 12 Feb 2020 12:03:47 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v2 21/35] target/riscv: Add hypvervisor trap support
In-Reply-To: <7ee4badbb4dfc33ab2e75151b69559f09d733575.1580518859.git.alistair.francis@wdc.com>
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-d32ca7fd-b39f-45d3-a373-ff66d707397b@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 31 Jan 2020 17:02:30 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 69 +++++++++++++++++++++++++++++++++------
>  1 file changed, 59 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 98017df33b..e7728cb0ca 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -639,6 +639,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> +    bool force_hs_execp = riscv_cpu_force_hs_excep_enabled(env);
> +    target_ulong s;
>
>      /* cs->exception is 32-bits wide unlike mcause which is XLEN-bits wide
>       * so we mask off the MSB and separate into trap type and cause.
> @@ -648,19 +650,14 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong deleg = async ? env->mideleg : env->medeleg;
>      target_ulong tval = 0;
>
> -    static const int ecall_cause_map[] = {
> -        [PRV_U] = RISCV_EXCP_U_ECALL,
> -        [PRV_S] = RISCV_EXCP_S_ECALL,
> -        [PRV_H] = RISCV_EXCP_VS_ECALL,
> -        [PRV_M] = RISCV_EXCP_M_ECALL
> -    };
> -
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
>          switch (cause) {
>          case RISCV_EXCP_INST_GUEST_PAGE_FAULT:
>          case RISCV_EXCP_LOAD_GUEST_ACCESS_FAULT:
>          case RISCV_EXCP_STORE_GUEST_AMO_ACCESS_FAULT:
> +            force_hs_execp = true;
> +            /* fallthrough */
>          case RISCV_EXCP_INST_ADDR_MIS:
>          case RISCV_EXCP_INST_ACCESS_FAULT:
>          case RISCV_EXCP_LOAD_ADDR_MIS:
> @@ -678,7 +675,16 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          /* ecall is dispatched as one cause so translate based on mode */
>          if (cause == RISCV_EXCP_U_ECALL) {
>              assert(env->priv <= 3);
> -            cause = ecall_cause_map[env->priv];
> +
> +            if (env->priv == PRV_M) {
> +                cause = RISCV_EXCP_M_ECALL;
> +            } else if (env->priv == PRV_S && riscv_cpu_virt_enabled(env)) {
> +                cause = RISCV_EXCP_VS_ECALL;
> +            } else if (env->priv == PRV_S && !riscv_cpu_virt_enabled(env)) {
> +                cause = RISCV_EXCP_S_ECALL;
> +            } else if (env->priv == PRV_U) {
> +                cause = RISCV_EXCP_U_ECALL;
> +            }
>          }
>      }
>
> @@ -688,7 +694,36 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      if (env->priv <= PRV_S &&
>              cause < TARGET_LONG_BITS && ((deleg >> cause) & 1)) {
>          /* handle the trap in S-mode */
> -        target_ulong s = env->mstatus;
> +        if (riscv_has_ext(env, RVH)) {
> +            target_ulong hdeleg = async ? env->hideleg : env->hedeleg;
> +
> +            if (riscv_cpu_virt_enabled(env) && ((hdeleg >> cause) & 1) &&
> +                !force_hs_execp) {
> +                /* Trap to VS mode */
> +            } else if (riscv_cpu_virt_enabled(env)) {
> +                /* Trap into HS mode, from virt */
> +                riscv_cpu_swap_hypervisor_regs(env);
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
> +                                         get_field(env->hstatus, HSTATUS_SPV));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
> +                                         get_field(env->mstatus, SSTATUS_SPP));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
> +                                         riscv_cpu_virt_enabled(env));
> +
> +                riscv_cpu_set_virt_enabled(env, 0);
> +                riscv_cpu_set_force_hs_excep(env, 0);
> +            } else {
> +                /* Trap into HS mode */
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2V,
> +                                         get_field(env->hstatus, HSTATUS_SPV));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SP2P,
> +                                         get_field(env->mstatus, SSTATUS_SPP));
> +                env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
> +                                         riscv_cpu_virt_enabled(env));
> +            }
> +        }
> +
> +        s = env->mstatus;
>          s = set_field(s, MSTATUS_SPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_SIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_SPP, env->priv);
> @@ -702,7 +737,21 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          riscv_cpu_set_mode(env, PRV_S);
>      } else {
>          /* handle the trap in M-mode */
> -        target_ulong s = env->mstatus;
> +        if (riscv_has_ext(env, RVH)) {
> +            if (riscv_cpu_virt_enabled(env)) {
> +                riscv_cpu_swap_hypervisor_regs(env);
> +            }
> +            env->mstatus = set_field(env->mstatus, MSTATUS_MPV,
> +                                      riscv_cpu_virt_enabled(env));
> +            env->mstatus = set_field(env->mstatus, MSTATUS_MTL,
> +                                      riscv_cpu_force_hs_excep_enabled(env));
> +
> +            /* Trapping to M mode, virt is disabled */
> +            riscv_cpu_set_virt_enabled(env, 0);
> +            riscv_cpu_set_force_hs_excep(env, 0);
> +        }
> +
> +        s = env->mstatus;
>          s = set_field(s, MSTATUS_MPIE, env->priv_ver >= PRIV_VERSION_1_10_0 ?
>              get_field(s, MSTATUS_MIE) : get_field(s, MSTATUS_UIE << env->priv));
>          s = set_field(s, MSTATUS_MPP, env->priv);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

