Return-Path: <SRS0=3HrQ=6A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E32C2BB55
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F610206B9
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2020 13:04:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SX5EpVc8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F610206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34000 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jP4Bx-0000Db-Im
	for qemu-devel@archiver.kernel.org; Thu, 16 Apr 2020 09:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58766)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4B7-00085R-75
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:03:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jP4B5-0004E4-7Q
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:03:36 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:38962)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jP4B5-0004De-0x
 for qemu-devel@nongnu.org; Thu, 16 Apr 2020 09:03:35 -0400
Received: by mail-ot1-x341.google.com with SMTP id m13so2960237otf.6
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2020 06:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ymdPh0UvFhhDw29CTxGDGdgLqYba+DJ1MWHMztUn+iA=;
 b=SX5EpVc8rYBqpME43Xm7vpmaT/21RhCK4CQ1V7bX8Koi6oKRGm+ayZsxd0L6yfdNaR
 2ZEakBJcqkre6AgUEcKp09ZlpNOc8OoPzEqvqO0p/IPymw4j4MwTZ0XKsPwQDugz8oWW
 LFJogSTkLQ6/yyQZx0fMXjCRZH/g873Q1Mplg4+oZhV74QZZJ2o/GkzImaiW/vRs937Z
 HuRLzHgjbZS4tIV6x/MAvIaTrDpfAIdY56LBnr92JQqZBV/wsL2tT/mMXGbtqBavoaaC
 pmI0khuhEGcEk3p32lLxyFeYSqHzjpINGCth0KAoDNXkks1GjUzMsdmMa/RSioG5GOI+
 4psQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ymdPh0UvFhhDw29CTxGDGdgLqYba+DJ1MWHMztUn+iA=;
 b=L4vfftn9ug9JW/gL85DhVOMbcCHZdotXnVe9e4m3cHAzdKaYiQnj1HegM9muI8OshG
 g4AYOEQjngcdd5TlCQbzXdMJ0R9nsNjdaHLMhtUMw9YW7ai2CjAs3wV8shscF7aN7mDt
 AwdhST65Nsrz49ykThibDXz2ACrt5zBOR7OU3wuBYEm96a1RUNEJ4f5mDq9i8VQZbP1D
 PTsb3RxIwrkRgyeL091hNOhBBD7TcYaHqWPJcHNFkd7PbJU/UBjRygA2F7MQYYXxFvAe
 htgwenou5tsS3ItmokzxzjKYSforXNpHaqS3nX5FnPmvJunznzMnyAPHwVcYTQulLLrO
 YRCA==
X-Gm-Message-State: AGi0PuaArbF6CSvpUweKLuPm6Dth/hHd4aNXNDdKDOuEUJvUNamGh5V4
 Lj4lTGsv2vgHP9N+l8T7rqRds9XjJGnRYCTZqT27Xw==
X-Google-Smtp-Source: APiQypKqJT5P7hZkFE2jq80NKkZOzECuxbRoO2/KQkmILYxeXuM1ITmonPsos5vQpa/ozFteTkQ2s8e/1q+Mei6Dkug=
X-Received: by 2002:a05:6830:1e4e:: with SMTP id
 e14mr8050522otj.91.1587042213709; 
 Thu, 16 Apr 2020 06:03:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200311064420.30606-1-richard.henderson@linaro.org>
 <20200311064420.30606-7-richard.henderson@linaro.org>
In-Reply-To: <20200311064420.30606-7-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 Apr 2020 14:03:22 +0100
Message-ID: <CAFEAcA8F2Qmdh=9RXFhN9_WPjhjhai9iO2Cn0dL5UAGV_r4AGw@mail.gmail.com>
Subject: Re: [PATCH 06/16] target/arm: Add sve infrastructure for page lookup
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
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

On Wed, 11 Mar 2020 at 06:44, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> For contiguous predicated memory operations, we want to
> minimize the number of tlb lookups performed.  We have
> open-coded this for sve_ld1_r, but for correctness with
> MTE we will need this for all of the memory operations.
>
> Create a structure that holds the bounds of active elements,
> and metadata for two pages.  Add routines to find those
> active elements, lookup the pages, and run watchpoints
> for those pages.
>
> Temporarily mark the functions unused to avoid Werror.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/sve_helper.c | 240 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 240 insertions(+)
>
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 8b470991db..3f653e46a0 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -4155,6 +4155,246 @@ static intptr_t max_for_page(target_ulong base, intptr_t mem_off,
>      return MIN(split, mem_max - mem_off) + mem_off;
>  }
>
> +/*
> + * Resolve the guest virtual address to info->host and info->flags.
> + * If @nofault, return false if the page is invalid, otherwise
> + * exit via page fault exception.
> + */
> +
> +typedef struct {
> +    void *host;
> +    int flags;
> +    MemTxAttrs attrs;
> +} SVEHostPage;
> +
> +static bool sve_probe_page(SVEHostPage *info, bool nofault,
> +                           CPUARMState *env, target_ulong addr,
> +                           int mem_off, MMUAccessType access_type,
> +                           int mmu_idx, uintptr_t retaddr)
> +{
> +    int flags;
> +
> +    addr += mem_off;
> +    flags = probe_access_flags(env, addr, access_type, mmu_idx, nofault,
> +                               &info->host, retaddr);
> +    info->flags = flags;
> +
> +    if (flags & TLB_INVALID_MASK) {
> +        g_assert(nofault);
> +        return false;
> +    }
> +
> +    /* Ensure that info->host[] is relative to addr, not addr + mem_off. */
> +    info->host -= mem_off;
> +
> +#ifdef CONFIG_USER_ONLY
> +    memset(&info->attrs, 0, sizeof(info->attrs));

Could just write "info->attrs = {};" ?

> +#else
> +    /*
> +     * Find the iotlbentry for addr and return the transaction attributes.
> +     * This *must* be present in the TLB because we just found the mapping.
> +     */
> +    {
> +        uintptr_t index = tlb_index(env, mmu_idx, addr);
> +
> +# ifdef CONFIG_DEBUG_TCG
> +        CPUTLBEntry *entry = tlb_entry(env, mmu_idx, addr);
> +        target_ulong comparator = (access_type == MMU_DATA_LOAD
> +                                   ? entry->addr_read
> +                                   : tlb_addr_write(entry));
> +        g_assert(tlb_hit(comparator, addr));
> +# endif
> +
> +        CPUIOTLBEntry *iotlbentry = &env_tlb(env)->d[mmu_idx].iotlb[index];
> +        info->attrs = iotlbentry->attrs;
> +    }
> +#endif
> +
> +    return true;
> +}
> +
> +
> +/*
> + * Analyse contiguous data, protected by a governing predicate.
> + */
> +
> +typedef enum {
> +    FAULT_NO,
> +    FAULT_FIRST,
> +    FAULT_ALL,
> +} SVEContFault;
> +
> +typedef struct {
> +    /* First and last element wholy contained within the two pages. */

"wholly"


> +    int16_t mem_off_first[2];
> +    int16_t reg_off_first[2];
> +    int16_t reg_off_last[2];

It would be helpful to document what these actually are,
and in particular what the behaviour is if the whole thing
fits in a single page. (Judging by the code, the elements
at index 1 for the 2nd page are set to -1 ?)

> +
> +    /* One element that is misaligned and spans both pages. */
> +    int16_t mem_off_split;
> +    int16_t reg_off_split;
> +    int16_t page_split;
> +
> +    /* TLB data for the two pages. */
> +    SVEHostPage page[2];
> +} SVEContLdSt;
> +
> +/*
> + * Find first active element on each page, and a loose bound for the
> + * final element on each page.  Identify any single element that spans
> + * the page boundary.  Return true if there are any active elements.
> + */
> +static bool __attribute__((unused))
> +sve_cont_ldst_elements(SVEContLdSt *info, target_ulong addr, uint64_t *vg,
> +                       intptr_t reg_max, int esz, int msize)
> +{
> +    const int esize = 1 << esz;
> +    const uint64_t pg_mask = pred_esz_masks[esz];
> +    intptr_t reg_off_first = -1, reg_off_last = -1, reg_off_split;
> +    intptr_t mem_off_last, mem_off_split;
> +    intptr_t page_split, elt_split;
> +    intptr_t i;

intptr_t seems like a funny type to be using here, since these
aren't actually related to pointers as far as I can tell.
It's also odd that the type is not the same one used in the SVEContLdSt
struct for the corresponding fields.

> +
> +    /* Set all of the element indicies to -1, and the TLB data to 0. */

"indices"

> +    memset(info, -1, offsetof(SVEContLdSt, page));

I guess this isn't conceptually much different from zeroing
out integer struct fields, but it feels a bit less safe somehow.

> +    memset(info->page, 0, sizeof(info->page));
> +
> +    /* Gross scan over the entire predicate to find bounds. */
> +    i = 0;
> +    do {
> +        uint64_t pg = vg[i] & pg_mask;
> +        if (pg) {
> +            reg_off_last = i * 64 + 63 - clz64(pg);
> +            if (reg_off_first < 0) {
> +                reg_off_first = i * 64 + ctz64(pg);
> +            }
> +        }
> +    } while (++i * 64 < reg_max);
> +
> +    if (unlikely(reg_off_first < 0)) {
> +        /* No active elements, no pages touched. */
> +        return false;
> +    }
> +    tcg_debug_assert(reg_off_last >= 0 && reg_off_last < reg_max);
> +
> +    info->reg_off_first[0] = reg_off_first;
> +    info->mem_off_first[0] = (reg_off_first >> esz) * msize;
> +    mem_off_last = (reg_off_last >> esz) * msize;
> +
> +    page_split = -(addr | TARGET_PAGE_MASK);

What is the negation for ?

> +    if (likely(mem_off_last + msize <= page_split)) {
> +        /* The entire operation fits within a single page. */
> +        info->reg_off_last[0] = reg_off_last;
> +        return true;
> +    }
> +
> +    info->page_split = page_split;
> +    elt_split = page_split / msize;
> +    reg_off_split = elt_split << esz;
> +    mem_off_split = elt_split * msize;
> +
> +    /*
> +     * This is the last full element on the first page, but it is not
> +     * necessarily active.  If there is no full element, i.e. the first
> +     * active element is the one that's split, this value remains -1.
> +     * It is useful as iteration bounds.
> +     */
> +    if (elt_split != 0) {
> +        info->reg_off_last[0] = reg_off_split - esize;
> +    }
> +
> +    /* Determine if an unaligned element spans the pages.  */
> +    if (page_split % msize != 0) {
> +        /* It is helpful to know if the split element is active. */
> +        if ((vg[reg_off_split >> 6] >> (reg_off_split & 63)) & 1) {
> +            info->reg_off_split = reg_off_split;
> +            info->mem_off_split = mem_off_split;
> +
> +            if (reg_off_split == reg_off_last) {
> +                /* The page crossing element is last. */
> +                return true;
> +            }
> +        }
> +        reg_off_split += esize;
> +        mem_off_split += msize;
> +    }
> +
> +    /*
> +     * We do want the first active element on the second page, because
> +     * this may affect the address reported in an exception.
> +     */
> +    reg_off_split = find_next_active(vg, reg_off_split, reg_max, esz);
> +    tcg_debug_assert(reg_off_split <= reg_off_last);
> +    info->reg_off_first[1] = reg_off_split;
> +    info->mem_off_first[1] = (reg_off_split >> esz) * msize;
> +    info->reg_off_last[1] = reg_off_last;
> +    return true;
> +}

thanks
-- PMM

