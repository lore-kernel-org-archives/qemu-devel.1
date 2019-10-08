Return-Path: <SRS0=wvJ7=YB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50875C4360C
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:55:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 303F2206B6
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2019 17:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 303F2206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59574 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iHti6-00068b-Au
	for qemu-devel@archiver.kernel.org; Tue, 08 Oct 2019 13:55:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54073)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmer@dabbelt.com>) id 1iHtgf-00052S-4d
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:54:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmer@dabbelt.com>) id 1iHtgd-0003LR-EN
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:54:17 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:43153)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmer@dabbelt.com>) id 1iHtgc-0003Ff-7D
 for qemu-devel@nongnu.org; Tue, 08 Oct 2019 13:54:15 -0400
Received: by mail-pg1-f195.google.com with SMTP id i32so3354441pgl.10
 for <qemu-devel@nongnu.org>; Tue, 08 Oct 2019 10:54:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=B7wKIi/5798WS7RpfpfHrlyTL9zGtqpyds0KiQbN+mI=;
 b=aoQAvIn4P2MNZhPbt3cGmUZZB2XNgfEOjtx5W/YodUeaegQOXbrMJ4fLNA3f8cDY2+
 Q3jNxBTErhzkKS8GTWHp8XZAkTwKgZWxFCxiFF0PEDrs64neIfZ1ohJW1PUvi0iEMQTt
 QFoAgNxZG+jLag4cvwajMx6YxcOBB1Rf2p48XDAI0rchnS/7vR5yJbg7kLQNwAYPFUa+
 SXmrg96p5I+JQkgVKhGEuVtuuJGADOttB+OyDbQQSANuDwADYccsc6tQkcbT3OOErSGF
 5dRDP8e/DXZ/8awGw4SLcYjdJMeUkKh5E25waCXbxROEZAyLEFrJH21v0SHuDi+NBIm9
 N2KA==
X-Gm-Message-State: APjAAAVRKagK5jwUE4DLlW7CiMpf4KEshAZB40nn9T+1mL2+kd4HY5EM
 0DfWrVwD54NcVfIRdiOfPf6kN0DdYpY=
X-Google-Smtp-Source: APXvYqxZ708jkMHd7L+EYrLojCQ+qJp9AHgpI3JAGVtF4gu6ApkwdIjHqg69tml3D7Ud+glEVp345w==
X-Received: by 2002:a62:1cf:: with SMTP id 198mr41272175pfb.31.1570557250406; 
 Tue, 08 Oct 2019 10:54:10 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id x18sm18652176pge.76.2019.10.08.10.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Oct 2019 10:54:09 -0700 (PDT)
Date: Tue, 08 Oct 2019 10:54:09 -0700 (PDT)
X-Google-Original-Date: Tue, 08 Oct 2019 10:53:10 PDT (-0700)
Subject: Re: [PATCH v1 25/28] target/riscv: Call the second stage MMU in
 virtualisation mode
In-Reply-To: <39abe56d7ba4d0ba392af6df09986af849f19403.1566603412.git.alistair.francis@wdc.com>
From: Palmer Dabbelt <palmer@sifive.com>
To: Alistair Francis <Alistair.Francis@wdc.com>
Message-ID: <mhng-e7dcbf56-f54c-41fd-9198-f729fc818f96@palmer-si-x1e>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.215.195
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

On Fri, 23 Aug 2019 16:38:55 PDT (-0700), Alistair Francis wrote:
> The qemu_log_mask(CPU_LOG_MMU,... calls trigger false positive
> checkpatch errors which are being ignored.
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 94 +++++++++++++++++++++++++++++++++++----
>  1 file changed, 86 insertions(+), 8 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 188d5cb39f..0761191f11 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -642,15 +642,23 @@ static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
>  hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>  {
>      RISCVCPU *cpu = RISCV_CPU(cs);
> +    CPURISCVState *env = &cpu->env;
>      hwaddr phys_addr;
>      int prot;
>      int mmu_idx = cpu_mmu_index(&cpu->env, false);
>
> -    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
> -                             true, false)) {
> +    if (get_physical_address(env, &phys_addr, &prot, addr, 0, mmu_idx,
> +                             true, riscv_cpu_virt_enabled(env))) {
>          return -1;
>      }
>
> +    if (riscv_cpu_virt_enabled(env)) {
> +        if (get_physical_address(env, &phys_addr, &prot, phys_addr,
> +                                 0, mmu_idx, false, true)) {
> +            return -1;
> +        }
> +    }
> +
>      return phys_addr;
>  }
>
> @@ -701,17 +709,35 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>  #ifndef CONFIG_USER_ONLY
>      RISCVCPU *cpu = RISCV_CPU(cs);
>      CPURISCVState *env = &cpu->env;
> +    vaddr im_address;
>      hwaddr pa = 0;
>      int prot;
>      bool pmp_violation = false;
> +    bool m_mode_two_stage = false;
> +    bool hs_mode_two_stage = false;
> +    bool first_stage_error = true;
>      int ret = TRANSLATE_FAIL;
>      int mode = mmu_idx;
>
>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>                    __func__, address, access_type, mmu_idx);
>
> -    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
> -                               true, false);
> +    /*
> +     * Determine if we are in M mode and MPRV is set or in HS mode and SPRV is
> +     * set and we want to access a virtulisation address.
> +     */
> +    if (riscv_has_ext(env, RVH)) {
> +        m_mode_two_stage = env->priv == PRV_M &&
> +                           access_type != MMU_INST_FETCH &&
> +                           get_field(*env->mstatus, MSTATUS_MPRV) &&
> +                           get_field(*env->mstatus, MSTATUS_MPV);
> +
> +        hs_mode_two_stage = env->priv == PRV_S &&
> +                            !riscv_cpu_virt_enabled(env) &&
> +                            access_type != MMU_INST_FETCH &&
> +                            get_field(env->hstatus, HSTATUS_SPRV) &&
> +                            get_field(env->hstatus, HSTATUS_SPV);
> +    }
>
>      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
>          if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> @@ -719,10 +745,58 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>          }
>      }
>
> -    qemu_log_mask(CPU_LOG_MMU,
> -                  "%s address=%" VADDR_PRIx " ret %d physical " TARGET_FMT_plx
> -                  " prot %d\n", __func__, address, ret, pa, prot);
> +    if (riscv_cpu_virt_enabled(env) || m_mode_two_stage || hs_mode_two_stage) {
> +        /* Two stage lookup */
> +        ret = get_physical_address(env, &pa, &prot, address, access_type,
> +                                   mmu_idx, true, true);
> +
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s 1st-stage address=%" VADDR_PRIx " ret %d physical "
> +                      TARGET_FMT_plx " prot %d\n",
> +                      __func__, address, ret, pa, prot);
> +
> +        if (ret == TRANSLATE_FAIL) {
> +            goto tlb_lookup_done;
> +        }
> +
> +        /* Second stage lookup */
> +        im_address = pa;
>
> +        ret = get_physical_address(env, &pa, &prot, im_address, access_type, mmu_idx,
> +                                   false, true);
> +
> +        qemu_log_mask(CPU_LOG_MMU,
> +                "%s 2nd-stage address=%" VADDR_PRIx " ret %d physical "
> +                TARGET_FMT_plx " prot %d\n",
> +                __func__, im_address, ret, pa, prot);
> +
> +        if (riscv_feature(env, RISCV_FEATURE_PMP) &&
> +            (ret == TRANSLATE_SUCCESS) &&
> +            !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
> +            ret = TRANSLATE_PMP_FAIL;
> +        }
> +
> +        if (ret != TRANSLATE_SUCCESS) {
> +            /*
> +             * Guest physical address translation failed, this is a HS
> +             * level exception
> +             */
> +            first_stage_error = false;
> +            address = im_address | (address & (TARGET_PAGE_SIZE - 1));
> +            goto tlb_lookup_done;
> +        }
> +    } else {
> +        /* Single stage lookup */
> +        ret = get_physical_address(env, &pa, &prot, address, access_type,
> +                                   mmu_idx, true, false);
> +
> +        qemu_log_mask(CPU_LOG_MMU,
> +                      "%s address=%" VADDR_PRIx " ret %d physical "
> +                      TARGET_FMT_plx " prot %d\n",
> +                      __func__, address, ret, pa, prot);
> +    }
> +
> +tlb_lookup_done:
>      if (riscv_feature(env, RISCV_FEATURE_PMP) &&
>          (ret == TRANSLATE_SUCCESS) &&
>          !pmp_hart_has_privs(env, pa, size, 1 << access_type, mode)) {
> @@ -731,6 +805,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      if (ret == TRANSLATE_PMP_FAIL) {
>          pmp_violation = true;
>      }
> +
>      if (ret == TRANSLATE_SUCCESS) {
>          tlb_set_page(cs, address & TARGET_PAGE_MASK, pa & TARGET_PAGE_MASK,
>                       prot, mmu_idx, TARGET_PAGE_SIZE);
> @@ -738,9 +813,12 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      } else if (probe) {
>          return false;
>      } else {
> -        raise_mmu_exception(env, address, access_type, pmp_violation, true);
> +        raise_mmu_exception(env, address, access_type, pmp_violation, first_stage_error);
>          riscv_raise_exception(env, cs->exception_index, retaddr);
>      }
> +
> +    return true;
> +
>  #else
>      switch (access_type) {
>      case MMU_INST_FETCH:

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

