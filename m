Return-Path: <SRS0=EA86=VT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 196EFC76188
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:53:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA4502199C
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jul 2019 09:53:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="himsk/4D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA4502199C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60108 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hpV0c-0008Jy-4k
	for qemu-devel@archiver.kernel.org; Mon, 22 Jul 2019 05:53:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50973)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alex.bennee@linaro.org>) id 1hpV0R-0007vd-4P
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:53:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1hpV0P-00076h-1y
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:53:19 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:37651)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1hpV0O-00075N-I1
 for qemu-devel@nongnu.org; Mon, 22 Jul 2019 05:53:16 -0400
Received: by mail-wr1-x442.google.com with SMTP id n9so13640317wrr.4
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2019 02:53:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=qS4bTqzNESz250WDwg0jgHoC+WIUVcB5f7nhGfn1RWo=;
 b=himsk/4Da1O1nqP+/YfqcpUQoPf6ZTX7YMawWdiB4qd8hoAU15Bachmr/opcCMBe4g
 Jl1Ihb5KZYIYMgfx3nfoIq/bsYScD/H5k7zdM1e3pQLzlaXBdc+ZBJV0n7kd4ZKDae+t
 QS91q3ATDmbohzEvYR4TZgrQe8y7BmdjupWci9IMRhcg87T2cNWrwl3zi5IpQ/owmhu1
 d6rnjPRJ2hjmB0Ej6JiR+YMV5FHcEoD5la7IoQhrwexS+9x6oRjeNk5hAhGQkC+r7KE4
 ugOGnsLh0ilSQ/GfkFOvYcxxsnC3Nr32rj3uNeDeQUiwe+VqgRm1XkPrDESYWJhc9CdC
 M2cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=qS4bTqzNESz250WDwg0jgHoC+WIUVcB5f7nhGfn1RWo=;
 b=sHEfTvDbydF2KqtBUzBdZWEDxzchd4klsuLxxcmsBXUyUC8mAlQKUXq2JZJR41T4I0
 1I89Fv90aO8XdsmPJunk5VClX+peGWVadKECeaSvsi9zyvI5sd3wW9iEoFgssFsgsMXZ
 X0gRp8Zsglubns1f4ZORBsXn/ZD3cv6EiknzD1XnLDVBnSq7ou/Zde4WNFBL2aI54Zrw
 owM4N95GDGiOObIOtJdb0ZcEXfrngSOgn8cGVBj2qdFX7Fp9Kz94wMqMdLm5IbZCaRdr
 M8Cveg0IlraeSBsUVD0yKs+cfO8yeyMx+M2jBAeRV41wO2F63jDUQqSze5uZ+5zQ5XHZ
 zZZg==
X-Gm-Message-State: APjAAAUft9eghCH+AIUwjiooEWis+PCBsqinPF65BpIq7L8aUg99miaN
 +HkpnjVZcXptRHF8GvHQnrg5Kg==
X-Google-Smtp-Source: APXvYqzywq+VdXGHRAWUPPPXDga4takqEGhFPycHTdvchAuTMzeHKdhXslox6ubUur4FRB5shWYLkA==
X-Received: by 2002:adf:d4cc:: with SMTP id w12mr75688479wrk.121.1563789194721; 
 Mon, 22 Jul 2019 02:53:14 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
 by smtp.gmail.com with ESMTPSA id n9sm75984832wrp.54.2019.07.22.02.53.14
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 22 Jul 2019 02:53:14 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CB5C21FF87;
 Mon, 22 Jul 2019 10:53:13 +0100 (BST)
References: <20190719210326.15466-1-richard.henderson@linaro.org>
 <20190719210326.15466-2-richard.henderson@linaro.org>
User-agent: mu4e 1.3.3; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
In-reply-to: <20190719210326.15466-2-richard.henderson@linaro.org>
Date: Mon, 22 Jul 2019 10:53:13 +0100
Message-ID: <87o91mv1iu.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
Subject: Re: [Qemu-devel] [PATCH for-4.2 01/24] cputlb: Add
 tlb_set_asid_for_mmuidx
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
Cc: peter.maydell@linaro.org, beata.michalska@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Richard Henderson <richard.henderson@linaro.org> writes:

> Although we can't do much with ASIDs except remember them, this
> will allow cleanups within target/ that should make things clearer.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>
> ---
> v2: Assert cpu_is_self; only flush idx w/ asid mismatch.
> ---
>  include/exec/cpu-all.h  | 11 +++++++++++
>  include/exec/cpu-defs.h |  2 ++
>  include/exec/exec-all.h | 19 +++++++++++++++++++
>  accel/tcg/cputlb.c      | 26 ++++++++++++++++++++++++++
>  4 files changed, 58 insertions(+)
>
> diff --git a/include/exec/cpu-all.h b/include/exec/cpu-all.h
> index 536ea58f81..40b140cbba 100644
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -439,4 +439,15 @@ static inline CPUTLB *env_tlb(CPUArchState *env)
>      return &env_neg(env)->tlb;
>  }
>
> +/**
> + * cpu_tlb(env)
> + * @cpu: The generic CPUState
> + *
> + * Return the CPUTLB state associated with the cpu.
> + */
> +static inline CPUTLB *cpu_tlb(CPUState *cpu)
> +{
> +    return &cpu_neg(cpu)->tlb;
> +}
> +
>  #endif /* CPU_ALL_H */
> diff --git a/include/exec/cpu-defs.h b/include/exec/cpu-defs.h
> index 9bc713a70b..73584841c0 100644
> --- a/include/exec/cpu-defs.h
> +++ b/include/exec/cpu-defs.h
> @@ -169,6 +169,8 @@ typedef struct CPUTLBDesc {
>      size_t n_used_entries;
>      /* The next index to use in the tlb victim table.  */
>      size_t vindex;
> +    /* The current ASID for this tlb.  */
> +    uint32_t asid;

is it worth adding a "if used" to the comment. I assume there are arches
that will never set and therefore care about ASID.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

>      /* The tlb victim table, in two parts.  */
>      CPUTLBEntry vtable[CPU_VTLB_SIZE];
>      CPUIOTLBEntry viotlb[CPU_VTLB_SIZE];
> diff --git a/include/exec/exec-all.h b/include/exec/exec-all.h
> index 16034ee651..9c77aa5bf9 100644
> --- a/include/exec/exec-all.h
> +++ b/include/exec/exec-all.h
> @@ -225,6 +225,21 @@ void tlb_flush_by_mmuidx_all_cpus(CPUState *cpu, uin=
t16_t idxmap);
>   * depend on when the guests translation ends the TB.
>   */
>  void tlb_flush_by_mmuidx_all_cpus_synced(CPUState *cpu, uint16_t idxmap);
> +/**
> + * tlb_set_asid_for_mmuidx:
> + * @cpu: Originating cpu
> + * @asid: Address Space Identifier
> + * @idxmap: bitmap of MMU indexes to set to @asid
> + * @depmap: bitmap of dependent MMU indexes
> + *
> + * Set an ASID for all of @idxmap.  If any previous ASID was different,
> + * then we will flush the mmu idx.  If a flush is required, then also fl=
ush
> + * all dependent mmu indicies in @depmap.  This latter is typically used
> + * for secondary page resolution, for implementing virtualization within
> + * the guest.
> + */
> +void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
> +                             uint16_t idxmap, uint16_t dep_idxmap);
>  /**
>   * tlb_set_page_with_attrs:
>   * @cpu: CPU to add this TLB entry for
> @@ -310,6 +325,10 @@ static inline void tlb_flush_by_mmuidx_all_cpus_sync=
ed(CPUState *cpu,
>                                                         uint16_t idxmap)
>  {
>  }
> +static inline void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid,
> +                                           uint16_t idxmap, uint16_t dep=
map)
> +{
> +}
>  #endif
>
>  #define CODE_GEN_ALIGN           16 /* must be >=3D of the size of a ica=
che line */
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index bb9897b25a..c68f57755b 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -540,6 +540,32 @@ void tlb_flush_page_all_cpus_synced(CPUState *src, t=
arget_ulong addr)
>      tlb_flush_page_by_mmuidx_all_cpus_synced(src, addr, ALL_MMUIDX_BITS);
>  }
>
> +void tlb_set_asid_for_mmuidx(CPUState *cpu, uint32_t asid, uint16_t idxm=
ap,
> +                             uint16_t depmap)
> +{
> +    CPUTLB *tlb =3D cpu_tlb(cpu);
> +    uint16_t work, to_flush =3D 0;
> +
> +    /* It doesn't make sense to set context across cpus.  */
> +    assert_cpu_is_self(cpu);
> +
> +    /*
> +     * We don't support ASIDs except for trivially.
> +     * If there is any change, then we must flush the TLB.
> +     */
> +    for (work =3D idxmap; work !=3D 0; work &=3D work - 1) {
> +        int mmu_idx =3D ctz32(work);
> +        if (tlb->d[mmu_idx].asid !=3D asid) {
> +            tlb->d[mmu_idx].asid =3D asid;
> +            to_flush |=3D 1 << mmu_idx;
> +        }
> +    }
> +    if (to_flush) {
> +        to_flush |=3D depmap;
> +        tlb_flush_by_mmuidx_async_work(cpu, RUN_ON_CPU_HOST_INT(to_flush=
));
> +    }
> +}
> +
>  /* update the TLBs so that writes to code in the virtual page 'addr'
>     can be detected */
>  void tlb_protect_code(ram_addr_t ram_addr)


--
Alex Benn=C3=A9e

