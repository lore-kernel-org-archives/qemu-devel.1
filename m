Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF927C2BBE2
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:19:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEFB52464E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 16:19:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s7UKlPpB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEFB52464E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idGKM-0005Fu-Bb
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 11:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58910)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idEyg-0008Lt-Sk
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idEyf-0005G5-KM
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:06 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:43425)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idEyf-0005EP-8R
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 09:53:05 -0500
Received: by mail-oi1-x242.google.com with SMTP id x14so2821326oic.10
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 06:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6SeJWuW7smgEfzxeMhKUR3tViJ1MMS3OliKE3zzGKtU=;
 b=s7UKlPpBZD1y3gEUPUtZSvKlf+9xf3fyBPXTbvolyaLSa3/gXKLvv18JDrNBynJ29X
 M9VnbeztwyV6mhNSQpvM/AWI35JqfDTE0H2q/kRP6xmZnO78giE7niRuGBrH0uIBoT56
 yeYghhciwt9trXxFMxfhCO3dkzyZTqTbpoOXDcL3uak5Jwps5TzlgFiVEwLkxBH95Vh2
 rKq/0soWsRqx3UIntqXNG88V+vHoxG1iYRcoQjh1hAN+To0TxOKTxdjfwtsim2WcMb+r
 5i0+LS3K+ZQN2UaYLrAhTPNcuxBt6fpWsP2fmreNyqiWIbSmN6yM05wmF8RXtSLqFTrf
 1Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6SeJWuW7smgEfzxeMhKUR3tViJ1MMS3OliKE3zzGKtU=;
 b=iuRIPhW2I9WbOcGZmioU8BHq8cnlQspNA5S2uZUJVjTv1zyW8RPCsVOQmAG70+Vt4y
 56dkgNEb+mg7ixjUyKrrmEhOuz+0zyh0ZFMWLvDGvgf0wnkS533LAgwecODGy8shf9kb
 QIk91sTJxmftJR7HdeGDzii+JuxDmXl3kB5LSWRy7GQwrbaNceMT9fq9C2rs6ScHBgFv
 oUHfKypFrVUG0x6CY7WmAaUIWBG4yBrrhmjCvcvy48XbQmJ1JQpVpsmoPt9rBbAgH14E
 ny7fBjbWpMLmwtsZ3HlPSISZWO6LG5LNu6vmyp3UpxJ8Vu1fSWV63hcwpF107hBA4tly
 QekQ==
X-Gm-Message-State: APjAAAVQJpRJX8xqJjCntx8PE2wcP3pSQ6d3ONHJ8T1fn3Q6iefKsroD
 WTwICCqdI4JxMU+ZPjJ3El3IVXE+6dMcuRGc528d9sJ9
X-Google-Smtp-Source: APXvYqy1yYb6XgF1yeK+H7REH5tkoChDUJ1cNFgFWZI+AySwvrFoOEBeLnw54auwS7gj63wLVpOlCfYehquYJy4l0S0=
X-Received: by 2002:aca:edd5:: with SMTP id l204mr12369452oih.98.1575637362903; 
 Fri, 06 Dec 2019 05:02:42 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-23-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-23-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 13:02:32 +0000
Message-ID: <CAFEAcA8AaCOBKSgVrpMxAiEGN0+JmJjJtMY-=M4ed06SAoe69g@mail.gmail.com>
Subject: Re: [PATCH v5 22/22] target/arm: Add allocation tag storage for
 system mode
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::242
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/mte_helper.c | 61 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 61 insertions(+)
>
> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
> index e8d8a6bedb..657383ba0e 100644
> --- a/target/arm/mte_helper.c
> +++ b/target/arm/mte_helper.c
> @@ -28,8 +28,69 @@
>  static uint8_t *allocation_tag_mem(CPUARMState *env, uint64_t ptr,
>                                     bool write, uintptr_t ra)
>  {
> +#ifdef CONFIG_USER_ONLY
>      /* Tag storage not implemented.  */
>      return NULL;
> +#else
> +    CPUState *cs = env_cpu(env);
> +    uintptr_t index;
> +    int mmu_idx;
> +    CPUTLBEntry *entry;
> +    CPUIOTLBEntry *iotlbentry;
> +    MemoryRegionSection *section;
> +    hwaddr physaddr, tag_physaddr;
> +
> +    /*
> +     * Find the TLB entry for this access.
> +     * As a side effect, this also raises an exception for invalid access.
> +     *
> +     * TODO: Perhaps there should be a cputlb helper that returns a
> +     * matching tlb entry + iotlb entry.  That would also be able to
> +     * make use of the victim tlb cache, which is currently private.
> +     */
> +    mmu_idx = cpu_mmu_index(env, false);
> +    index = tlb_index(env, mmu_idx, ptr);
> +    entry = tlb_entry(env, mmu_idx, ptr);
> +    if (!tlb_hit(write ? tlb_addr_write(entry) : entry->addr_read, ptr)) {
> +        bool ok = arm_cpu_tlb_fill(cs, ptr, 16,
> +                                   write ? MMU_DATA_STORE : MMU_DATA_LOAD,
> +                                   mmu_idx, false, ra);
> +        assert(ok);
> +        index = tlb_index(env, mmu_idx, ptr);
> +        entry = tlb_entry(env, mmu_idx, ptr);
> +    }
> +
> +    /* If the virtual page MemAttr != Tagged, nothing to do.  */
> +    iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
> +    if (!iotlbentry->attrs.target_tlb_bit1) {
> +        return NULL;
> +    }
> +
> +    /*
> +     * Find the physical address for the virtual access.
> +     *
> +     * TODO: It should be possible to have the tag mmu_idx map
> +     * from main memory ram_addr to tag memory host address.
> +     * that would allow this lookup step to be cached as well.
> +     */
> +    section = iotlb_to_section(cs, iotlbentry->addr, iotlbentry->attrs);
> +    physaddr = ((iotlbentry->addr & TARGET_PAGE_MASK) + ptr
> +                + section->offset_within_address_space
> +                - section->offset_within_region);

I'm surprised that going from vaddr to (physaddr, attrs) requires
this much effort, it seems like the kind of thing we would
already have a function to do.

> +
> +    /* Convert to the physical address in tag space.  */
> +    tag_physaddr = physaddr >> (LOG2_TAG_GRANULE + 1);
> +
> +    /* Choose the tlb index to use for the tag physical access.  */
> +    mmu_idx = iotlbentry->attrs.secure ? ARMMMUIdx_TagS : ARMMMUIdx_TagNS;
> +    mmu_idx = arm_to_core_mmu_idx(mmu_idx);
> +
> +    /*
> +     * FIXME: Get access length and type so that we can use
> +     * probe_access, so that pages are marked dirty for migration.
> +     */
> +    return tlb_vaddr_to_host(env, tag_physaddr, MMU_DATA_LOAD, mmu_idx);

Hmm, does that mean that a setup with MemTag is not migratable?
If so, we should at least install a migration-blocker for CPUs
in that configuration.

> +#endif
>  }
>
>  static int get_allocation_tag(CPUARMState *env, uint64_t ptr, uintptr_t ra)
> --
> 2.17.1
>


thanks
-- PMM

