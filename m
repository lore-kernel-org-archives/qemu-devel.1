Return-Path: <SRS0=YrRb=Z3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C0CAC43603
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:19:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EE0942464F
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2019 18:19:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ipl2EU0N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EE0942464F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59276 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1icvit-0006zN-Vk
	for qemu-devel@archiver.kernel.org; Thu, 05 Dec 2019 13:19:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54135)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1icvh7-0005om-Iq
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1icvh5-0001DR-QY
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:41 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:41368)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1icvh5-00019g-Jx
 for qemu-devel@nongnu.org; Thu, 05 Dec 2019 13:17:39 -0500
Received: by mail-ot1-x341.google.com with SMTP id r27so3423709otc.8
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2019 10:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YZ4Mv11SbDP5AhWiY1/9jeSZG9dC8AF0VxMGlBUfvlo=;
 b=Ipl2EU0Nj4ZgDIEFzKSAjPGLxvdDU6FB7z0H+28C46+NaH88JCG/94tMI2O2DIT1eG
 f4JN8+xm2HKsjFudmLkE/0rzk2E3ZaW5p8JcIey0JDKhbluASgJNJxTpDe3xe79DKTwO
 FWrMHErCqvaBecO+jZe1ROvWw0N0Tv4KfNbxS2JJGJpZN6+rU1fi1UQGy7rOggyTcNJ/
 UDcU4fv/KCZd09zWix0UmGIzDxCBOtOf3CnpGvU+QbOXg1sZwPr0QpWPynqAFpjiEmbV
 UO8ybBBRzgrYWsDk3h5z/DyQGDHAwH94mn57pVT/pijUw5nccb1hcgwb6moJe9ugRb+5
 cScQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YZ4Mv11SbDP5AhWiY1/9jeSZG9dC8AF0VxMGlBUfvlo=;
 b=i4c18hEntP1JuIAwDk+kygMAwpDOSwZjGe/wwFUpbGecXtsqt7I3ahyS4hEN+8+NyZ
 OYzlrvF3IrVJTz9cBEm6K7TZE4u8qq9io7/dXiDB9SuDQXCtj8j3fv/t46mTSTCOnLrf
 isBkIYwdxbKPAlYgeAxKRUTYX3nRxqpOw59QDPLpbnoAtXgAq+TXp00tsuJ1wykCa99a
 KVCyeJbslzG4tlwZN9HfRUFJ6/kxli4jPZtjub66QQGgC1VOG++q8qHDZKRupzhvwEEO
 lWeclmPHiBJsjO2gQUxKIpKjG8Md8coc2o31BLQ1lwvBMvxTxHFsrcthOOP4Uxqkbv4p
 Fzww==
X-Gm-Message-State: APjAAAVIqSA3ar4y3OhX2KG2pWYVuECyc9ussDAX4EM0lAt9UlXYMUxr
 6EYElvtMngFlBka90ytsRw6GMkNBeFtU6aiibZSK+w==
X-Google-Smtp-Source: APXvYqzkxcU2015HGUspQwgwNwRnTrMjHDlzJSVP5pjq2g6nclp0TxuEvWiZjawykVA39s0nDPTqlf4yzM0juF86HkY=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr1878403otd.91.1575569858679; 
 Thu, 05 Dec 2019 10:17:38 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-17-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-17-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Dec 2019 18:17:27 +0000
Message-ID: <CAFEAcA_K4wreQRXxEdDB4M-NCBC3NmGTyT0aEZxfAwBbSp23Rg@mail.gmail.com>
Subject: Re: [PATCH v5 16/22] target/arm: Implement data cache set allocation
 tags
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

On Fri, 11 Oct 2019 at 14:50, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> This is DC GVA and DC GZVA.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Use allocation_tag_mem + memset.
> v3: Require pre-cleaned addresses.
> ---

> diff --git a/target/arm/mte_helper.c b/target/arm/mte_helper.c
> index f1315bae37..e8d8a6bedb 100644
> --- a/target/arm/mte_helper.c
> +++ b/target/arm/mte_helper.c
> @@ -510,3 +510,31 @@ void HELPER(stzgm)(CPUARMState *env, uint64_t ptr, uint64_t val)
>          }
>      }
>  }
> +
> +void HELPER(dc_gva)(CPUARMState *env, uint64_t ptr)
> +{
> +    ARMCPU *cpu = env_archcpu(env);
> +    size_t blocklen = 4 << cpu->dcz_blocksize;
> +    int el;
> +    uint64_t sctlr;
> +    uint8_t *mem;
> +    int rtag;
> +
> +    ptr = QEMU_ALIGN_DOWN(ptr, blocklen);
> +
> +    /* Trap if accessing an invalid page.  */
> +    mem = allocation_tag_mem(env, ptr, true, GETPC());
> +
> +    /* No action if page does not support tags, or if access is disabled.  */
> +    el = arm_current_el(env);
> +    sctlr = arm_sctlr(env, el);
> +    if (!mem || !allocation_tag_access_enabled(env, el, sctlr)) {
> +        return;
> +    }
> +
> +    rtag = allocation_tag_from_addr(ptr);
> +    rtag |= rtag << 4;
> +
> +    assert(QEMU_IS_ALIGNED(blocklen, 2 * TAG_GRANULE));

Could we assert this on CPU init rather than in this helper?
That way if anybody tries to create a CPU whose dcz_blocksize
doesn't work with the TAG_GRANULE they'll realize immediately
rather than only if they happen to run a guest workload that
use DC GVA or DC GZVA.

I also had to think a bit to work out which way round this
assert is checking: it's testing that the ZVA block length
(usually 64 bytes) is a multiple of (twice the TAG_GRANULE),
which is to say a multiple of 32. Given that the blocksize
is stored as a log2 value, this can only fail for blocksizes
16, 8, 4, 2 or 1, which are all fairly unlikely.

> +    memset(mem, rtag, blocklen / (2 * TAG_GRANULE));
> +}
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 49817b96ae..31260f97f9 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -1769,6 +1769,15 @@ static void handle_sys(DisasContext *s, uint32_t insn, bool isread,
>          tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
>          gen_helper_dc_zva(cpu_env, tcg_rt);
>          return;
> +    case ARM_CP_DC_GVA:
> +        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
> +        gen_helper_dc_gva(cpu_env, tcg_rt);
> +        return;
> +    case ARM_CP_DC_GZVA:
> +        tcg_rt = clean_data_tbi(s, cpu_reg(s, rt), false);
> +        gen_helper_dc_zva(cpu_env, tcg_rt);
> +        gen_helper_dc_gva(cpu_env, tcg_rt);

I think this means that if there's a watchpoint set on the memory
partway through the block we're zeroing then we'll take the
watchpoint with some of the memory zeroed but without the
corresponding tags having been updated. But that's probably OK
(at any rate I wouldn't worry about it for now...)

> +        return;
>      default:
>          break;
>      }
> --

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

