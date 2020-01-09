Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88FD9C33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:32:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52F102067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 02:32:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uPaKxCIp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52F102067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53598 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipNcl-0002Yl-4Q
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 21:32:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56061)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNZV-0007br-6c
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipNZP-0007Mz-J8
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:17 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:42582)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipNZP-0007L6-An
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 21:29:11 -0500
Received: by mail-pf1-x442.google.com with SMTP id 4so2574877pfz.9
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 18:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=OJpwUxUV10+vYr6gKA66GfXYLyKZRcdceafVK3pMzf4=;
 b=uPaKxCIpLMrk1B1WrHhkLmamcqi1KwRR/nIl6ofwPRCvC434ssobdaa9EPjpjFLUYe
 R6xplOu7d8/pLGVrObtCzY5CDobE23AZeM8m39gHtc4LrEAZajsJXiA/DZw9ImWnKXoH
 GhdPVYCzQRiClg01jzY6+IVkkbJnQdL9usfmZVwpp4umBDKZdqAiOw7YXSULtD3X+0Tj
 Pz52eaLWLzglgFuyAiAd0IyLKSSfMLPUqxgzHqK1fp8BgOrgLnD16BWxwOuY+xc9+Nz/
 d6taNTqszSArQw7vSFYPu0ePEA8Ord4uOHnTwX1K3oda+9xc/YZEAA4fqO1E7jaCRUfu
 wMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=OJpwUxUV10+vYr6gKA66GfXYLyKZRcdceafVK3pMzf4=;
 b=g9T7Egde3FMC5tlJYwE5L7xmkLwVnZ+ZV84Ct73Gd4yclBelzifCltWO225+iZG3r6
 7OPTudKP3GCgtCWzwDOC1sjQue3vsP+se00Omr7Ga7dqt6Z9YsTdaOCk8FubEHjeGnrZ
 0Zn3zFPYueG5QAruieIDMfzEVEpOkPgFfFSTG/GVkjxDQhxEynh3i5ezyV6dd0FLeR5c
 EnxKFn3M21n59s5T8KTqe8U/I1Ug8ZDyTAZWvdEVHwibQs/bI50+kOCuaFqTyo1suQF8
 93SbSqkRGESGqDKowJGrNQ/NATvf7995SVu9DyeaJSRLnVg0msojUw0FyfnRN8u6mV7M
 i28A==
X-Gm-Message-State: APjAAAWPwjQ0kSNfzq/MDZltO3xMrRDwSB2bcXj77QYxE3C67CS/wpM2
 7kDOO2e+5VpVEgo+9yGagyE2+nlaKUw=
X-Google-Smtp-Source: APXvYqx+Hk9fT5wt6feQ3aa/ekhsI6vr5lF2BIrfp05Gw9rGN0TpNJDpDqSnA+R3d/qZaRLp7JbNNA==
X-Received: by 2002:a62:33c6:: with SMTP id z189mr8699089pfz.246.1578536949965; 
 Wed, 08 Jan 2020 18:29:09 -0800 (PST)
Received: from localhost (189.8.197.35.bc.googleusercontent.com.
 [35.197.8.189])
 by smtp.gmail.com with ESMTPSA id a6sm4847000pgg.25.2020.01.08.18.29.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 18:29:09 -0800 (PST)
Date: Wed, 08 Jan 2020 18:29:09 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 18:29:00 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 34/36] target/riscv: Add support for the 32-bit
 MSTATUSH CSR
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <2c161240299cf0f78fe676ec6b1c59e94203c324.1575914822.git.alistair.francis@wdc.com>
References: <2c161240299cf0f78fe676ec6b1c59e94203c324.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-ed859073-c5ab-407c-a322-480fee5a730d@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::442
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

On Mon, 09 Dec 2019 10:12:09 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu.c        |  6 ++++++
>  target/riscv/cpu.h        |  7 +++++++
>  target/riscv/cpu_bits.h   |  3 +++
>  target/riscv/cpu_helper.c |  7 +++++++
>  target/riscv/csr.c        | 25 +++++++++++++++++++++++++
>  target/riscv/op_helper.c  |  4 ++++
>  6 files changed, 52 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index e61cf46a73..ac8f53a49d 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -237,6 +237,9 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>  #ifndef CONFIG_USER_ONLY
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mhartid ", env->mhartid);
>      qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatus ", *env->mstatus);
> +#ifdef TARGET_RISCV32
> +    qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "mstatush ", *env->mstatush);
> +#endif
>      if (riscv_has_ext(env, RVH)) {
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "hstatus ", env->hstatus);
>          qemu_fprintf(f, " %s " TARGET_FMT_lx "\n", "vsstatus ", env->vsstatus);
> @@ -473,6 +476,9 @@ static void riscv_cpu_init(Object *obj)
>
>  #ifndef CONFIG_USER_ONLY
>      env->mstatus = &env->mstatus_novirt;
> +# ifdef TARGET_RISCV32
> +    env->mstatush = &env->mstatush_novirt;
> +# endif
>  #endif
>  }
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index b411a1f900..84a07971dc 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -127,6 +127,10 @@ struct CPURISCVState {
>
>      target_ulong mip;
>
> +#ifdef TARGET_RISCV32
> +    target_ulong *mstatush;
> +#endif
> +
>      uint32_t miclaim;
>
>      target_ulong mie;
> @@ -153,6 +157,9 @@ struct CPURISCVState {
>       * required to handle the Hypervisor register swapping.
>       */
>      target_ulong mstatus_novirt;
> +#ifdef TARGET_RISCV32
> +    target_ulong mstatush_novirt;
> +#endif
>
>      /* Hypervisor CSRs */
>      target_ulong hstatus;
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index a24654d137..049032f2ae 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -135,6 +135,9 @@
>  #define CSR_MTVEC           0x305
>  #define CSR_MCOUNTEREN      0x306
>
> +/* 32-bit only */
> +#define CSR_MSTATUSH        0x310
> +
>  /* Legacy Counter Setup (priv v1.9.1) */
>  /* Update to #define CSR_MCOUNTINHIBIT 0x320 for 1.11.0 */
>  #define CSR_MUCOUNTEREN     0x320
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index aa033b8590..c2ad0bbce7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -938,10 +938,17 @@ void riscv_cpu_do_interrupt(CPUState *cs)
>              if (riscv_cpu_virt_enabled(env)) {
>                  riscv_cpu_swap_hypervisor_regs(env);
>              }
> +#ifdef TARGET_RISCV32
> +            *env->mstatush = set_field(*env->mstatush, MSTATUS_MPV,
> +                                       riscv_cpu_virt_enabled(env));
> +            *env->mstatush = set_field(*env->mstatush, MSTATUS_MTL,
> +                                       riscv_cpu_force_hs_excep_enabled(env));
> +#else
>              *env->mstatus = set_field(*env->mstatus, MSTATUS_MPV,
>                                        riscv_cpu_virt_enabled(env));
>              *env->mstatus = set_field(*env->mstatus, MSTATUS_MTL,
>                                        riscv_cpu_force_hs_excep_enabled(env));
> +#endif
>
>              mtval2 = env->guest_phys_fault_addr;
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index d028dfb60b..b28058f9d5 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -372,6 +372,27 @@ static int write_mstatus(CPURISCVState *env, int csrno, target_ulong val)
>      return 0;
>  }
>
> +#ifdef TARGET_RISCV32
> +static int read_mstatush(CPURISCVState *env, int csrno, target_ulong *val)
> +{
> +    *val = *env->mstatush;
> +    return 0;
> +}
> +
> +static int write_mstatush(CPURISCVState *env, int csrno, target_ulong val)
> +{
> +    if ((val ^ *env->mstatush) & (MSTATUS_MPV)) {
> +        tlb_flush(env_cpu(env));
> +    }
> +
> +    val &= MSTATUS_MPV | MSTATUS_MTL;
> +
> +    *env->mstatush = val;
> +
> +    return 0;
> +}
> +#endif
> +
>  static int read_misa(CPURISCVState *env, int csrno, target_ulong *val)
>  {
>      *val = env->misa;
> @@ -1215,6 +1236,10 @@ static riscv_csr_operations csr_ops[CSR_TABLE_SIZE] = {
>      [CSR_MTVEC] =               { any,  read_mtvec,       write_mtvec       },
>      [CSR_MCOUNTEREN] =          { any,  read_mcounteren,  write_mcounteren  },
>
> +#if defined(TARGET_RISCV32)
> +    [CSR_MSTATUSH] =            { any,  read_mstatush,    write_mstatush    },
> +#endif
> +
>      /* Legacy Counter Setup (priv v1.9.1) */
>      [CSR_MUCOUNTEREN] =         { any,  read_mucounteren, write_mucounteren },
>      [CSR_MSCOUNTEREN] =         { any,  read_mscounteren, write_mscounteren },
> diff --git a/target/riscv/op_helper.c b/target/riscv/op_helper.c
> index e5128570e6..a0a631d722 100644
> --- a/target/riscv/op_helper.c
> +++ b/target/riscv/op_helper.c
> @@ -153,7 +153,11 @@ target_ulong helper_mret(CPURISCVState *env, target_ulong cpu_pc_deb)
>          get_field(mstatus, MSTATUS_MPIE));
>      mstatus = set_field(mstatus, MSTATUS_MPIE, 1);
>      mstatus = set_field(mstatus, MSTATUS_MPP, 0);
> +#ifdef TARGET_RISCV32
> +    *env->mstatush = set_field(*env->mstatush, MSTATUS_MPV, 0);
> +#else
>      mstatus = set_field(mstatus, MSTATUS_MPV, 0);
> +#endif
>      *env->mstatus = mstatus;
>      riscv_cpu_set_mode(env, prev_priv);

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

