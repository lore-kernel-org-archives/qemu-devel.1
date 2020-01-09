Return-Path: <SRS0=I8Mx=26=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B6DC33C9E
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 01:42:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7413E2067D
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2020 01:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bKLNTpF0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7413E2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52978 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ipMq8-0000EJ-JR
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 20:42:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:43236)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <palmerdabbelt@google.com>) id 1ipMpP-00089h-GW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 20:41:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <palmerdabbelt@google.com>) id 1ipMpJ-0004mz-2p
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 20:41:38 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34239)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <palmerdabbelt@google.com>)
 id 1ipMpH-0004gD-1N
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 20:41:31 -0500
Received: by mail-pl1-x641.google.com with SMTP id x17so1874189pln.1
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 17:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:subject:cc:to:in-reply-to:references:message-id
 :mime-version:content-transfer-encoding;
 bh=WuWhx15qnOyg1gRVt71tiFMKU0IEV7PZgk3YZc3+yfc=;
 b=bKLNTpF0eKeK4W3nB9oZgYLwyA/xSzkWm6xZFjve7ko+IL3TQzBNLzKkxbsrWa+hey
 PzyFbM1+DqsOUgUSLv+J4gdOBJqPyiCKRt1MGsnQrPpSFp6lTmW+qCEx5u/Z1wUEgrQW
 pYHpjIaA+dQJOd5mv3F8sYYjNFdAXrBQE4ZCDQcvm6m5e+KDYrxChcKspdkW/Qw9jGki
 OsTdBWQIvcGArzcogNx+8+zITz6yfJ3uzZHlMF/DXvDMbYdWLcynbhWNdNVGbQ56HXIr
 8zmzHz2szPwn2Plgkm7KlOOYP8sBiuNkeUYTPDwFbLxRgywVO3ykEwu7kBY9w4CKex+y
 qCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:cc:to:in-reply-to:references
 :message-id:mime-version:content-transfer-encoding;
 bh=WuWhx15qnOyg1gRVt71tiFMKU0IEV7PZgk3YZc3+yfc=;
 b=pcgazTUC9+v6W3iocHdZnOIxuJkV/ziJt/2t1mPAUieZwAbrDupc54/YdkMXPBmSxo
 pakSNHERuE4cdfB4m+MpQ9ZAZSmYDxbeTaDmrjrKcI7XlCBLxUXIaCwriUba+5OiU6R3
 CqyDgzwL8pYcQ9ylMbPOacbelOr04ulJrrgEGeJ2o5FzxHqCJHrz3xKacShYbkFMWen4
 ieNgYAI98VY6QbCyLT6DJH6NlsD99SnUWIW01oRKUuphCUAXWBRzrHiYg/8GlTW4XB5J
 gtlDq7USngsIWI2A3+TXZpHnnVHgscrAbXJCGKO3ag5YnDG8n7YWvuTLaEv8UCdVMC5W
 gCNQ==
X-Gm-Message-State: APjAAAXJDISGlb9tD9RcOdlQyR0oxqI/9K4jHFaPuINKeoUCRYhlCu8v
 PN7F/4FhFAq7nPU1uGk3otgJIxQJ+kk=
X-Google-Smtp-Source: APXvYqzgViiZt/G9S9d71YjHtPwmtjtD0UQDgwf2fMFh+trl1DfyOhFqmyHaAqIFPZiM0LSaWSgGDA==
X-Received: by 2002:a17:90a:8545:: with SMTP id a5mr2061993pjw.3.1578534088977; 
 Wed, 08 Jan 2020 17:41:28 -0800 (PST)
Received: from localhost ([2620:0:1000:2514:7f69:cd98:a2a2:a03d])
 by smtp.gmail.com with ESMTPSA id a15sm5084494pfh.169.2020.01.08.17.41.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Jan 2020 17:41:28 -0800 (PST)
Date: Wed, 08 Jan 2020 17:41:28 -0800 (PST)
X-Google-Original-Date: Wed, 08 Jan 2020 17:41:27 PST (-0800)
From: Palmer Dabbelt <palmerdabbelt@google.com>
X-Google-Original-From: Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v1 30/36] target/riscv: Allow specifying MMU stage
CC: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Alistair Francis <Alistair.Francis@wdc.com>, alistair23@gmail.com
To: Alistair Francis <Alistair.Francis@wdc.com>
In-Reply-To: <1cd8d1423b81dd4705e03923f644840e35143ed5.1575914822.git.alistair.francis@wdc.com>
References: <1cd8d1423b81dd4705e03923f644840e35143ed5.1575914822.git.alistair.francis@wdc.com><cover.1575914822.git.alistair.francis@wdc.com>
Message-ID: <mhng-e5d082cc-1654-401c-bd75-d218ace4aad4@palmerdabbelt-glaptop>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

On Mon, 09 Dec 2019 10:11:59 PST (-0800), Alistair Francis wrote:
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/cpu_helper.c | 39 ++++++++++++++++++++++++++++++---------
>  1 file changed, 30 insertions(+), 9 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2040fc0208..8b234790a7 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -279,10 +279,19 @@ void riscv_cpu_set_mode(CPURISCVState *env, target_ulong newpriv)
>   *
>   * Adapted from Spike's mmu_t::translate and mmu_t::walk
>   *
> + * @env: CPURISCVState
> + * @physical: This will be set to the calculated physical address
> + * @prot: The returned protection attributes
> + * @addr: The virtual address to be translated
> + * @access_type: The type of MMU access
> + * @mmu_idx: Indicates current privilege level
> + * @first_stage: Are we in first stage translation?
> + *               Second stage is used for hypervisor guest translation
>   */
>  static int get_physical_address(CPURISCVState *env, hwaddr *physical,
>                                  int *prot, target_ulong addr,
> -                                int access_type, int mmu_idx)
> +                                int access_type, int mmu_idx,
> +                                bool first_stage)
>  {
>      /* NOTE: the env->pc value visible here will not be
>       * correct, but the value visible to the exception handler
> @@ -485,13 +494,23 @@ restart:
>  }
>
>  static void raise_mmu_exception(CPURISCVState *env, target_ulong address,
> -                                MMUAccessType access_type, bool pmp_violation)
> +                                MMUAccessType access_type, bool pmp_violation,
> +                                bool first_stage)
>  {
>      CPUState *cs = env_cpu(env);
> -    int page_fault_exceptions =
> -        (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> -        get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
> -        !pmp_violation;
> +    int page_fault_exceptions;
> +    if (first_stage) {
> +        page_fault_exceptions =
> +            (env->priv_ver >= PRIV_VERSION_1_10_0) &&
> +            get_field(env->satp, SATP_MODE) != VM_1_10_MBARE &&
> +            !pmp_violation;
> +        riscv_cpu_set_force_hs_excep(env, 0);
> +    } else {
> +        page_fault_exceptions =
> +            get_field(env->hgatp, HGATP_MODE) != VM_1_10_MBARE &&
> +            !pmp_violation;
> +        riscv_cpu_set_force_hs_excep(env, 1);
> +    }
>      switch (access_type) {
>      case MMU_INST_FETCH:
>          cs->exception_index = page_fault_exceptions ?
> @@ -518,7 +537,8 @@ hwaddr riscv_cpu_get_phys_page_debug(CPUState *cs, vaddr addr)
>      int prot;
>      int mmu_idx = cpu_mmu_index(&cpu->env, false);
>
> -    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx)) {
> +    if (get_physical_address(&cpu->env, &phys_addr, &prot, addr, 0, mmu_idx,
> +                             true)) {
>          return -1;
>      }
>      return phys_addr;
> @@ -583,7 +603,8 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      qemu_log_mask(CPU_LOG_MMU, "%s ad %" VADDR_PRIx " rw %d mmu_idx %d\n",
>                    __func__, address, access_type, mmu_idx);
>
> -    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx);
> +    ret = get_physical_address(env, &pa, &prot, address, access_type, mmu_idx,
> +                               true);
>
>      if (mode == PRV_M && access_type != MMU_INST_FETCH) {
>          if (get_field(*env->mstatus, MSTATUS_MPRV)) {
> @@ -610,7 +631,7 @@ bool riscv_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>      } else if (probe) {
>          return false;
>      } else {
> -        raise_mmu_exception(env, address, access_type, pmp_violation);
> +        raise_mmu_exception(env, address, access_type, pmp_violation, true);
>          riscv_raise_exception(env, cs->exception_index, retaddr);
>      }
>  #else

Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>

