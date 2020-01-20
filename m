Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14069C33CAF
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:37:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B11D206B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 00:37:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GzLEo2OI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B11D206B7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55754 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itL4T-0003GH-FR
	for qemu-devel@archiver.kernel.org; Sun, 19 Jan 2020 19:37:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36394)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1itL3q-0002qJ-CJ
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:36:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1itL3p-0003bV-Br
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:36:58 -0500
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:34019)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1itL3p-0003az-2x
 for qemu-devel@nongnu.org; Sun, 19 Jan 2020 19:36:57 -0500
Received: by mail-lf1-x141.google.com with SMTP id l18so22637060lfc.1
 for <qemu-devel@nongnu.org>; Sun, 19 Jan 2020 16:36:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nFTnbOfAoYUZ711yJunw7FDiNaO3wvrgdS8fTlf82iY=;
 b=GzLEo2OIP6nWVqIzhDgPmKWgjbXCItQArXbe17cZlhcvBYc2QKN9ygt6wxP1bHeqvv
 fL9oh/P+2slKoEJZoELcAw97az7tnIU+pVG/Z/5Xou7Ko2PfvjNAaVO2OhPcPAXOGp8O
 bWvLF8PZskZsI4W+HnEUj48J8A8eO4nGrwqHVSHsd3NzpMvCvEnhmiNX5Wdc+TFNXyCL
 1yL/8AMuPEec7AXH4Wdme4XzPLn7MdmbA5Gv2p/YpcnrPZcSxO2DmG59k2ZzSCTTGZRa
 EEnEzbpbfnv7EWP9Q2pnR7J2zCHnAVfPwm2/pEqgW9ZzfARnlPwE57vle+i4hcAsKtIc
 2uGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nFTnbOfAoYUZ711yJunw7FDiNaO3wvrgdS8fTlf82iY=;
 b=mTpzkgok+MTMJeMRwi5tEHIOePFd0lWiDJtJ3Jbe50/qbZ1G2FoKtLKrXTGI1udgYU
 LcU4jLA6fRngLcyiDY2wbKs4rzzK61fL4+jS1uo9xl8ar9cuAjjBADA5CBy/UrjktxTe
 I/z3gB5bdLKGAUC4jxmiRpsFc4bZPY5TXtrna3w3QIfwHgZtoDaIxfonsSHtfW7KWWWr
 YGylNte2rVEXJALqDvnAKd/83p2/6XvHpE2egVTZQNY56xu7jGrrWO+cJwbrruthG4Ek
 EBJ4Fqk356+Jw4ASjzh9ZKW5bAdZfp8yG2LdRyMBhChakA4M6nEcGfaWXKNgzlpYafk6
 UQSg==
X-Gm-Message-State: APjAAAU8jVwScHK7xgkU2cb7itpsdsYwReFfSUbhXAerNfPXQxA3PRKj
 P+WfsuZr3UAlvlvWzLOJWiU2ZoXEq0SxfH2aHlc=
X-Google-Smtp-Source: APXvYqzTzEr1gMUs45DJ1zTiMBaV9JvNh7TfocnlOKmb1s2xLSV34/dc3eho9AtbCdDXLfkTT5qOUb6dfyzF3Y4n2bg=
X-Received: by 2002:ac2:4422:: with SMTP id w2mr11718162lfl.178.1579480615843; 
 Sun, 19 Jan 2020 16:36:55 -0800 (PST)
MIME-Version: 1.0
References: <20200109024907.2730-1-richard.henderson@linaro.org>
 <20200109024907.2730-3-richard.henderson@linaro.org>
In-Reply-To: <20200109024907.2730-3-richard.henderson@linaro.org>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 20 Jan 2020 10:36:28 +1000
Message-ID: <CAKmqyKNZkv4ew1R2s_r=25hJZuG-_1ExV2Lrs=FfL5Ce0SLL0w@mail.gmail.com>
Subject: Re: [PATCH 2/9] cputlb: Make tlb_n_entries private to cputlb.c
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
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
Cc: Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 9, 2020 at 12:49 PM Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> There are no users of this function outside cputlb.c,
> and its interface will change in the next patch.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  include/exec/cpu_ldst.h | 5 -----
>  accel/tcg/cputlb.c      | 5 +++++
>  2 files changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index a46116167c..53de19753a 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -234,11 +234,6 @@ static inline uintptr_t tlb_index(CPUArchState *env, uintptr_t mmu_idx,
>      return (addr >> TARGET_PAGE_BITS) & size_mask;
>  }
>
> -static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> -{
> -    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> -}
> -
>  /* Find the TLB entry corresponding to the mmu_idx + address pair.  */
>  static inline CPUTLBEntry *tlb_entry(CPUArchState *env, uintptr_t mmu_idx,
>                                       target_ulong addr)
> diff --git a/accel/tcg/cputlb.c b/accel/tcg/cputlb.c
> index 1a81886e58..e4a8ed9534 100644
> --- a/accel/tcg/cputlb.c
> +++ b/accel/tcg/cputlb.c
> @@ -80,6 +80,11 @@ QEMU_BUILD_BUG_ON(sizeof(target_ulong) > sizeof(run_on_cpu_data));
>  QEMU_BUILD_BUG_ON(NB_MMU_MODES > 16);
>  #define ALL_MMUIDX_BITS ((1 << NB_MMU_MODES) - 1)
>
> +static inline size_t tlb_n_entries(CPUArchState *env, uintptr_t mmu_idx)
> +{
> +    return (env_tlb(env)->f[mmu_idx].mask >> CPU_TLB_ENTRY_BITS) + 1;
> +}
> +
>  static inline size_t sizeof_tlb(CPUArchState *env, uintptr_t mmu_idx)
>  {
>      return env_tlb(env)->f[mmu_idx].mask + (1 << CPU_TLB_ENTRY_BITS);
> --
> 2.20.1
>
>

