Return-Path: <SRS0=TwS2=YA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6412ECE58C
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4D120673
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="f0cpZ7YZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4D120673
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47414 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHVpQ-0007Dy-Sm
	for qemu-devel@archiver.kernel.org; Mon, 07 Oct 2019 12:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57277)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@sifive.com>) id 1iHVg4-0005ao-RF
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:16:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@sifive.com>) id 1iHVg3-0003ex-5r
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:16:04 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:43780)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@sifive.com>) id 1iHVg2-0003ck-W2
 for qemu-devel@nongnu.org; Mon, 07 Oct 2019 12:16:03 -0400
Received: by mail-pg1-x544.google.com with SMTP id i32so1198487pgl.10
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2019 09:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=F5KcZ05xCSG+C6zK4MWjs4KZwuOvY5DewcEsAGMwKZg=;
 b=f0cpZ7YZCZrJKz9CrE6m8uYUIKGkBQSzChOWh5MRov16P5UUkG+g8lMDAonrHaFKqv
 2GZ8wTPszQuKsom7O+Wznx8CQSU/RhnZNOvCPtkX2xkv0RnySTWQyuzY8Rs6jJ4Cvj1M
 wt+4+3ckrXoyI1STaq6waNPmZJoiOFit228mpW+baLSHiZHUB7JpUT5YNSCSVj0COkWu
 tE8sInmzRStYmf4loNHfBgdt9VDzbnofsTPKPrihYzULBsaeHENNR+KRF6uvmn+1CeA+
 HtUag0WfmdyZm3g7pX9ByGjE2I+3Bh4ZYZSL2q+i4k7zE6LDcHxHH+I0q6QUB/8i/qXv
 JSCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=F5KcZ05xCSG+C6zK4MWjs4KZwuOvY5DewcEsAGMwKZg=;
 b=jY43EPY/kCJr3gyIE90eHM5JRIk50nrvB1afpr0E2P5f0DR12RslsYqS4jeqXk0Rsk
 kNrwnXZ0TKAio2gONKADZQpXLLUpQN9PWgayeK4DufAe6FpwR6+yFN9WPWUiUmlYDPx1
 CxLcW2ehY0KqpxAZYf4xWV3UHtuanWEAqJEOviD4hd77GOz/w2CLPQZNTV5vIYq3gljF
 xcSjuMcvwpI7bEFhFDuw0u0ntbrhNeujV/7wS+7kINZETlqq8iuk4vIl7xJSaE4GMOWI
 Ebof6uyJToEbM6KWoFbklWZThiUIDipaLruwRAlV2aZwG9vd9sOoEM6VyOoLHohtxoXX
 T4VA==
X-Gm-Message-State: APjAAAUkC3+hBikt3jH9dmkAT3F66Xy0pSnmcWF9oircDAIssEuEgvNr
 qP6/u2TqjKvm6G7q5LebFKrMYFr6C8w2OA==
X-Google-Smtp-Source: APXvYqzGHulA17E5bcK9+NDhvNZyeKJDbCqySzfXkQObH6dPCdLFFd5YC0uyjfJKgCHliIZHEI+LBA==
X-Received: by 2002:a63:6441:: with SMTP id y62mr13874896pgb.177.1570464960709; 
 Mon, 07 Oct 2019 09:16:00 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id 7sm12841486pgj.35.2019.10.07.09.15.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2019 09:15:59 -0700 (PDT)
Date: Mon, 07 Oct 2019 09:15:59 -0700 (PDT)
X-Google-Original-Date: Mon, 07 Oct 2019 09:04:43 PDT (-0700)
Subject: Re: [PATCH v1 24/28] target/riscv: Implement second stage MMU
In-Reply-To: <67e93a4f45693067abb03441e159b1f4a0a48276.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-a9412752-518e-4527-ad6c-3830ddead66d@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: qemu-riscv@nongnu.org, Anup Patel <Anup.Patel@wdc.com>,
 qemu-devel@nongnu.org, Atish Patra <Atish.Patra@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 23 Aug 2019 16:38:52 PDT (-0700), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 96 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 86 insertions(+), 10 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 8b9871f9ea..188d5cb39f 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -337,13 +337,40 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>       * (riscv_cpu_do_interrupt) is correct */
>
>      int mode = mmu_idx;
> +    bool use_background = false;
>
> +    /*
> +     * Check if we should use the background registers for the two
> +     * stage translation. We don't need to check if we actually need
> +     * two stage translation as that happened before this function
> +     * was called. Background registers will be used if the guest has
> +     * forced a two stage translation to be on (in HS or M mode).
> +     */
>      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
>          if (get_field(*env->mstatus, MSTATUS_MPRV)) {
>              mode = get_field(*env->mstatus, MSTATUS_MPP);
> +
> +            if (riscv_has_ext(env, RVH) &&
> +                get_field(*env->mstatus, MSTATUS_MPV)) {
> +                use_background = true;
> +            }
>          }
>      }
>
> +    if (mode == PRV_S && access_type != MMU_INST_FETCH &&
> +        riscv_has_ext(env, RVH) && !riscv_cpu_virt_enabled(env)) {
> +        if (get_field(env->hstatus, HSTATUS_SPRV)) {
> +            mode = get_field(*env->mstatus, SSTATUS_SPP);
> +            use_background = true;
> +        }
> +    }
> +
> +    if (first_stage == false) {
> +        /* We are in stage 2 translation, this is similar to stage 1. */
> +        /* Stage 2 is always taken as U-mode */
> +        mode = PRV_U;
> +    }
> +
>      if (mode == PRV_M || !riscv_feature(env, RISCV_FEATURE_MMU)) {
>          *physical = addr;
>          *prot = PAGE_READ | PAGE_WRITE | PAGE_EXEC;
> @@ -353,13 +380,30 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>      *prot = 0;
>
>      target_ulong base;
> -    int levels, ptidxbits, ptesize, vm, sum;
> -    int mxr = get_field(*env->mstatus, MSTATUS_MXR);
> +    int levels, ptidxbits, ptesize, vm, sum, mxr, widened;
> +
> +    if (first_stage == true) {
> +        mxr = get_field(*env->mstatus, MSTATUS_MXR);
> +    } else {
> +        mxr = get_field(env->vsstatus, MSTATUS_MXR);
> +    }
>
>      if (env->priv_ver >= PRIV_VERSION_1_10_0) {
> -        base = get_field(env->satp, SATP_PPN) << PGSHIFT;
> +        if (first_stage == true) {
> +            if (use_background) {
> +                base = get_field(env->vsatp, SATP_PPN) << PGSHIFT;
> +                vm = get_field(env->vsatp, SATP_MODE);
> +            } else {
> +                base = get_field(env->satp, SATP_PPN) << PGSHIFT;
> +                vm = get_field(env->satp, SATP_MODE);
> +            }
> +            widened = 0;
> +        } else {
> +            base = get_field(env->hgatp, HGATP_PPN) << PGSHIFT;
> +            vm = get_field(env->hgatp, HGATP_MODE);
> +            widened = 2;
> +        }
>          sum = get_field(*env->mstatus, MSTATUS_SUM);
> -        vm = get_field(env->satp, SATP_MODE);
>          switch (vm) {
>          case VM_1_10_SV32:
>            levels = 2; ptidxbits = 10; ptesize = 4; break;
> @@ -377,6 +421,7 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>            g_assert_not_reached();
>          }
>      } else {
> +        widened = 0;
>          base = env->sptbr << PGSHIFT;
>          sum = !get_field(*env->mstatus, MSTATUS_PUM);
>          vm = get_field(*env->mstatus, MSTATUS_VM);
> @@ -397,9 +442,16 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>      }
>
>      CPUState *cs = env_cpu(env);
> -    int va_bits = PGSHIFT + levels * ptidxbits;
> -    target_ulong mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> -    target_ulong masked_msbs = (addr >> (va_bits - 1)) & mask;
> +    int va_bits = PGSHIFT + levels * ptidxbits + widened;
> +    target_ulong mask, masked_msbs;
> +
> +    if (TARGET_LONG_BITS > (va_bits - 1)) {
> +        mask = (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> +    } else {
> +        mask = 0;
> +    }
> +    masked_msbs = (addr >> (va_bits - 1)) & mask;
> +
>      if (masked_msbs != 0 && masked_msbs != mask) {
>          return TRANSLATE_FAIL;
>      }
> @@ -411,17 +463,36 @@ static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>  restart:
>  #endif
>      for (i = 0; i < levels; i++, ptshift -= ptidxbits) {
> -        target_ulong idx = (addr >> (PGSHIFT + ptshift)) &
> +        target_ulong idx;
> +        if (i == 0) {
> +            idx = (addr >> (PGSHIFT + ptshift)) &
> +                           ((1 << (ptidxbits + widened)) - 1);
> +        } else {
> +            idx = (addr >> (PGSHIFT + ptshift)) &
>                             ((1 << ptidxbits) - 1);
> +        }
>
>          /* check that physical address of PTE is legal */
> -        target_ulong pte_addr = base + idx * ptesize;
> +        target_ulong pte_addr;
> +
> +        if (two_stage && first_stage) {
> +            hwaddr vbase;
> +
> +            /* Do the second stage translation on the base PTE address. */
> +            get_physical_address(env, &vbase, prot, base, access_type,
> +                                 mmu_idx, false, true);
> +
> +            pte_addr = vbase + idx * ptesize;
> +        } else {
> +            pte_addr = base + idx * ptesize;
> +        }
>
>          if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>              !pmp_hart_has_privs(env, pte_addr, sizeof(target_ulong),
>              1 << MMU_DATA_LOAD, PRV_S)) {
>              return TRANSLATE_PMP_FAIL;
>          }
> +
>  #if defined(TARGET_RISCV32)
>          target_ulong pte = ldl_phys(cs->as, pte_addr);
>  #elif defined(TARGET_RISCV64)
> @@ -507,7 +578,12 @@ restart:
>              /* for superpage mappings, make a fake leaf PTE for the TLB's
>                 benefit. */
>              target_ulong vpn = addr >> PGSHIFT;
> -            *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
> +            if (i == 0) {
> +                *physical = (ppn | (vpn & ((1L << (ptshift + widened)) - 1))) <<
> +                             PGSHIFT;
> +            } else {
> +                *physical = (ppn | (vpn & ((1L << ptshift) - 1))) << PGSHIFT;
> +            }
>
>              /* set permissions on the TLB entry */
>              if ((pte & PTE_R) || ((pte & PTE_X) && mxr)) {

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

