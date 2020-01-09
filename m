Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84E3C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:30:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F2C02067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:30:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="v3sg1jl2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F2C02067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53582 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNb4-0000UO-Dw
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:30:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNZS-0007bP-0J
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNZN-0007I1-1Q
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:13 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40265)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipNZM-0007GN-Os
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:08 -0500
Received: by mail-pf1-x443.google.com with SMTP id q8so2579659pfh.7
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=c1g4KjNM+qkVDVTlknC7rp97fBZUpR2N0uQTHXmdxPw=;
 b=v3sg1jl2PhAGEgNA5gc+TG7kPpfhw2ek/p8HujvU/8ckuTj0XiYryrEBRlX2mVd+ll
 v63dEf/RXGIdTBVetE17ASAIUGbabimCerPbkl45fzZ1Rp13hPdWLtG2zIQOYKn+GA1k
 0J7NkRyxBUE0O0tVBx4bzDICmNVo2Q4VW9hsU2f6KFYOA4HaQF5hfar/8dvNdGk+RUAg
 emJrb42Rpks2rR6OgD1AHPO1k7FfchkEANSKpGU/u5RmKLhOGt97Usx/d0GbOSNqhrOm
 K1WmBX9fY8XwEG9CfA9c1bUNUqba9E5nNVLm3EdKa+7K3OZeH1YqZmQSCUohAusnbsgf
 Ne5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=c1g4KjNM+qkVDVTlknC7rp97fBZUpR2N0uQTHXmdxPw=;
 b=MuCEU35ot/2gsKHSe5lVlQ++/M1Jgcvskvv/0+1qCR6Sg/1CJfue0B95uJ2PIldqZY
 nD6H4pW5i9Yt3T5rRgDT7jLKSJ8rKTNqGUmB5SNwypKHDD4cpjx52KbOp5WERDJonNnQ
 dCU3jPSYTCdyJZYU7QJ6SFc0C0MsCCXn8yk9RT2W3yTzSWfwinaXjtqwDDRWW69/N3o0
 eCqD9WX2CBvmqFymkd5wzVOxThsrwmd/DnlN2JKZbfzxV33focDZCwrjuJ5igAokbp9m
 noVAcwugiaFaLDjAdK9hu7RTK25lgAjsi+Tm0jZDB1zz6Ydr8VvwLT0E+inMZuVzoibM
 Fhtg==
X-Gm-Message-State: APjAAAU24JGJocgBEeaSVi1kK4Z2Dgb9bBqd/aBPEvDsur7Sn8ti08/z
 awPKivuKy4xEH7plvheuObRYUgtVv4c=
X-Google-Smtp-Source: APXvYqyEeCBzdLzq4pOo9ZRxOQqfdwJ4r5z87zXhpUzSbk3JIUSpgWEaQPs8hIWNejyt3Q0BleALxQ==
X-Received: by 2002:aa7:9562:: with SMTP id x2mr8587219pfq.147.1578536947505; 
 Wed, 08 Jan 2020 18:29:07 -0800 (PST)
Received: from localhost (189.8.197.35.bc.googleusercontent.com.
 [35.197.8.189])
 by smtp.gmail.com with ESMTPSA id q11sm5193077pff.111.2020.01.08.18.29.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:29:07 -0800 (PST)
Date: Wed, 08 Jan 2020 18:29:07 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 18:27:19 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 33/36] target/riscv: Set htval and mtval2 on execptions
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <3d0d12048c2cf4c5c5ec888b9ff602620285fa5b.1575914822.git.alistair.francis@wdc.com>
References: <3d0d12048c2cf4c5c5ec888b9ff602620285fa5b.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-2a93260d-6691-4cf1-920c-01af14feedea@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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

On Mon, 09 Dec 2019 10:12:06 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 43c6629014..aa033b8590 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -841,6 +841,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>      target_ulong cause = cs->exception_index & RISCV_EXCP_INT_MASK;
>      target_ulong deleg = async ? env->mideleg : env->medeleg;
>      target_ulong tval = 0;
> +    target_ulong htval = 0;
> +    target_ulong mtval2 = 0;
>
>      if (!async) {
>          /* set tval to badaddr for traps with address information */
> @@ -900,6 +902,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                  env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
>                                           riscv_cpu_virt_enabled(env));
>
> +                htval = env->guest_phys_fault_addr;
> +
>                  riscv_cpu_set_virt_enabled(env, 0);
>                  riscv_cpu_set_force_hs_excep(env, 0);
>              } else {
> @@ -910,6 +914,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>                                           get_field(*env->mstatus, SSTATUS_SPP));
>                  env->hstatus = set_field(env->hstatus, HSTATUS_SPV,
>                                           riscv_cpu_virt_enabled(env));
> +
> +                htval = env->guest_phys_fault_addr;
>              }
>          }
>
> @@ -922,6 +928,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->scause = cause | ((target_ulong)async << (TARGET_LONG_BITS - 1));
>          env->sepc = env->pc;
>          env->sbadaddr = tval;
> +        env->htval = htval;
>          env->pc = (env->stvec >> 2 << 2) +
>              ((async && (env->stvec & 3) == 1) ? cause * 4 : 0);
>          riscv_cpu_set_mode(env, PRV_S);
> @@ -936,6 +943,8 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
>                                        riscv_cpu_force_hs_excep_enabled(env));
>
> +            mtval2 = env->guest_phys_fault_addr;
> +
>              /* Trapping to M mode, virt is disabled */
>              riscv_cpu_set_virt_enabled(env, 0);
>          }
> @@ -949,6 +958,7 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>          env->mcause = cause | ~(((target_ulong)-1) >> async);
>          env->mepc = env->pc;
>          env->mbadaddr = tval;
> +        env->mtval2 = mtval2;
>          env->pc = (env->mtvec >> 2 << 2) +
>              ((async && (env->mtvec & 3) == 1) ? cause * 4 : 0);
>          riscv_cpu_set_mode(env, PRV_M);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

