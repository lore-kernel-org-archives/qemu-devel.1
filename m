Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AEF6C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EB420833
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 14:37:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mvpTG4Bb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EB420833
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48048 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcslb-0006C8-2p
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 10:37:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41357)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsQg-0001Fc-5B
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:16:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hcsQd-0005L0-Ep
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:16:14 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40486)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hcsQc-0005KQ-Vo
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 10:16:11 -0400
Received: by mail-wr1-x443.google.com with SMTP id p11so10159327wre.7
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 07:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=nnehQM8Sv1jpgMg1ksb+qmJfU7wSH141wt7vRUcBbH0=;
 b=mvpTG4Bbw4gpymjuLS3N+37svuximtBCe2nJjY5hx6l5sjUkHcF1gHKSDxFyefEn3P
 Ehg2wGNjZlkgkcWb6sGEBSmwd7A6Huz+KDctZHcNdx2A41sFmn8RpuwAfA5kbUZ3kqg0
 ssFiz7xltaUmFLg4G17KVX8o2eiMOzmnyjexOdOuwiPEKVZ81Lq115kUw+IFPWbDwEGP
 5QrFZIej6wv0Fo4cmvveyq5Ud+blmIhpWKyPJQBfZ4sWSl34UfqaTQ99i8084u57YSww
 zQOfFWtTk7CfsGHO4YRRdA7J4OZgnWbfqsl8bo+k4UdjKhfKaW9Vr93frnyv0RPB5V4A
 AaXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=nnehQM8Sv1jpgMg1ksb+qmJfU7wSH141wt7vRUcBbH0=;
 b=ilgz40BAtixBR9AxmetvZribAk8SOq5Gjox2gaxE/ijrfyj7PkI3+q9Ez23ceN0WaG
 vlygnWEdLlVH/ZyUCqUZDhpADi86MMPpnzCAtdhdhjuUzh3aiOuV2CTxg0pdJRea/AB4
 pA2bCnp0/t/cTC554bMTT6cHrBaicKzL4V4WHvcvEmyBC/XgcZ3wfh4scJLzP3Kbc6Nv
 LI0Y5Ch0R/u3CU/m7vHSWyo+RELBVu3JfiOlf5uJpqqwi/8E2RsO4Bmq1fcWZ01d9iK2
 6ZXak50jgR7aIbZUm3jenDM7UtFjbDmxof6KVqBU4ZZlLi2KKx46/eBW9TowzqkZsX2M
 x95Q==
X-Gm-Message-State: APjAAAUGm9PnHZFGGERzG25OAgGMgu2hnQ0DPGhy3rH5yXHWuwUAmbbe
 Bm4dUv+1CmYj73H7OS/bIUq5aQ==
X-Google-Smtp-Source: APXvYqwRDF+Dl2oXM4XmfRkPWT3tgQRchcl9cV+H539sgIAZu/TJ4PvIkArv889WxDq1bOWZU+EAZw==
X-Received: by 2002:a5d:4a8d:: with SMTP id o13mr1684662wrq.350.1560780969779; 
 Mon, 17 Jun 2019 07:16:09 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id q20sm28543491wra.36.2019.06.17.07.16.09
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 17 Jun 2019 07:16:09 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B389E1FF87;
 Mon, 17 Jun 2019 15:16:08 +0100 (BST)
References: <20190615154352.26824-1-philmd@redhat.com>
 <20190615154352.26824-16-philmd@redhat.com>
User-agent: mu4e 1.3.2; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-arm@nongnu.org
In-reply-to: <20190615154352.26824-16-philmd@redhat.com>
Date: Mon, 17 Jun 2019 15:16:08 +0100
Message-ID: <87lfy09u1j.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::443
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 15/23] target/arm: Make ARM
 TLB filling routine static
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:

> From: Samuel Ortiz <sameo@linux.intel.com>
>
> It's only used in op_helper.c, it does not need to be exported and
> moreover it should only be build when TCG is enabled.
>
> Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> [PMD: Rebased]
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
>  target/arm/helper.c    | 53 ---------------------------------------
>  target/arm/internals.h |  2 ++
>  target/arm/op_helper.c | 56 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+), 53 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 673ada1e86..a4af02c984 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -10621,59 +10621,6 @@ hwaddr arm_cpu_get_phys_page_attrs_debug(CPUStat=
e *cs, vaddr addr,
>
>  #endif
>
> -bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> -                      MMUAccessType access_type, int mmu_idx,
> -                      bool probe, uintptr_t retaddr)
> -{
> -    ARMCPU *cpu =3D ARM_CPU(cs);
> -
> -#ifdef CONFIG_USER_ONLY
> -    cpu->env.exception.vaddress =3D address;
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        cs->exception_index =3D EXCP_PREFETCH_ABORT;
> -    } else {
> -        cs->exception_index =3D EXCP_DATA_ABORT;
> -    }
> -    cpu_loop_exit_restore(cs, retaddr);
> -#else
> -    hwaddr phys_addr;
> -    target_ulong page_size;
> -    int prot, ret;
> -    MemTxAttrs attrs =3D {};
> -    ARMMMUFaultInfo fi =3D {};
> -
> -    /*
> -     * Walk the page table and (if the mapping exists) add the page
> -     * to the TLB.  On success, return true.  Otherwise, if probing,
> -     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
> -     * register format, and signal the fault.
> -     */
> -    ret =3D get_phys_addr(&cpu->env, address, access_type,
> -                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
> -                        &phys_addr, &attrs, &prot, &page_size, &fi,
> NULL);

Shouldn't we be moving the rest of the tlb filling code that gets
referred to here? Maybe we could keep it all together in tlb-helper.c?


> -    if (likely(!ret)) {
> -        /*
> -         * Map a single [sub]page. Regions smaller than our declared
> -         * target page size are handled specially, so for those we
> -         * pass in the exact addresses.
> -         */
> -        if (page_size >=3D TARGET_PAGE_SIZE) {
> -            phys_addr &=3D TARGET_PAGE_MASK;
> -            address &=3D TARGET_PAGE_MASK;
> -        }
> -        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
> -                                prot, mmu_idx, page_size);
> -        return true;
> -    } else if (probe) {
> -        return false;
> -    } else {
> -        /* now we have a real cpu fault */
> -        cpu_restore_state(cs, retaddr, true);
> -        arm_deliver_fault(cpu, address, access_type, mmu_idx, &fi);
> -    }
> -#endif
> -}
> -
>  /* Note that signed overflow is undefined in C.  The following routines =
are
>     careful to use unsigned types where modulo arithmetic is required.
>     Failure to do so _will_ break on newer gcc.  */
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index fe9e4665e2..37ca493635 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -761,9 +761,11 @@ static inline bool arm_extabort_type(MemTxResult res=
ult)
>      return result !=3D MEMTX_DECODE_ERROR;
>  }
>
> +#ifdef CONFIG_TCG
>  bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
>                        MMUAccessType access_type, int mmu_idx,
>                        bool probe, uintptr_t retaddr);
> +#endif
>
>  void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUAccessType access_typ=
e,
>                         int mmu_idx, ARMMMUFaultInfo *fi) QEMU_NORETURN;
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index 29b56039e5..e43c99ebf0 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -179,6 +179,62 @@ void arm_deliver_fault(ARMCPU *cpu, vaddr addr, MMUA=
ccessType access_type,
>      env->exception.fsr =3D fsr;
>      raise_exception(env, exc, syn, target_el);
>  }
> +#endif
> +
> +bool arm_cpu_tlb_fill(CPUState *cs, vaddr address, int size,
> +                      MMUAccessType access_type, int mmu_idx,
> +                      bool probe, uintptr_t retaddr)
> +{
> +    ARMCPU *cpu =3D ARM_CPU(cs);
> +
> +#ifdef CONFIG_USER_ONLY
> +    cpu->env.exception.vaddress =3D address;
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        cs->exception_index =3D EXCP_PREFETCH_ABORT;
> +    } else {
> +        cs->exception_index =3D EXCP_DATA_ABORT;
> +    }
> +    cpu_loop_exit_restore(cs, retaddr);
> +#else
> +    hwaddr phys_addr;
> +    target_ulong page_size;
> +    int prot, ret;
> +    MemTxAttrs attrs =3D {};
> +    ARMMMUFaultInfo fi =3D {};
> +
> +    /*
> +     * Walk the page table and (if the mapping exists) add the page
> +     * to the TLB.  On success, return true.  Otherwise, if probing,
> +     * return false.  Otherwise populate fsr with ARM DFSR/IFSR fault
> +     * register format, and signal the fault.
> +     */
> +    ret =3D get_phys_addr(&cpu->env, address, access_type,
> +                        core_to_arm_mmu_idx(&cpu->env, mmu_idx),
> +                        &phys_addr, &attrs, &prot, &page_size, &fi, NULL=
);
> +    if (likely(!ret)) {
> +        /*
> +         * Map a single [sub]page. Regions smaller than our declared
> +         * target page size are handled specially, so for those we
> +         * pass in the exact addresses.
> +         */
> +        if (page_size >=3D TARGET_PAGE_SIZE) {
> +            phys_addr &=3D TARGET_PAGE_MASK;
> +            address &=3D TARGET_PAGE_MASK;
> +        }
> +        tlb_set_page_with_attrs(cs, address, phys_addr, attrs,
> +                                prot, mmu_idx, page_size);
> +        return true;
> +    } else if (probe) {
> +        return false;
> +    } else {
> +        /* now we have a real cpu fault */
> +        cpu_restore_state(cs, retaddr, true);
> +        arm_deliver_fault(cpu, address, access_type, mmu_idx, &fi);
> +    }
> +#endif
> +}
> +
> +#if !defined(CONFIG_USER_ONLY)
>
>  /* Raise a data fault alignment exception for the specified virtual addr=
ess */
>  void arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,


--
Alex Benn=C3=A9e

