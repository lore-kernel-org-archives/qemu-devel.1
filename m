Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C537C33CAC
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:37:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 174CB20658
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 11:37:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nv7jlb9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 174CB20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iya2M-0007WT-Ae
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 06:37:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36326)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iya1d-000703-9Z
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:36:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iya1c-00067S-54
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:36:21 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:39687)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iya1b-00066a-W4
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 06:36:20 -0500
Received: by mail-ot1-x343.google.com with SMTP id 77so13301743oty.6
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2020 03:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=WjvcwcjrT89kMVrD2gN+cHLbR83zRSARv+WYvKIJ6y4=;
 b=Nv7jlb9TFFF5iHQyzfHydE9FvUnVFfc6L3AQH4mFbUNrG/69ewAlReCFDm/WQi1RHd
 aPjJVDgulSf8xJi2Gi6TfOXDB36iWGomfEeaXgbdKEhnvMEdbkbSnpZv18igPBSgk1ZV
 pNOPNsl7B+Wv1Dkho6NpIraSoqN2YpjGFpOGzjKgE2pLf0RNQkE7EXopGCRmBCnAF2Vd
 Mr201C6RqNHiC8R/fwVi4qkZ1vp6OCY3Wk4n5HfK7/K5GO6gmX4eYtN3wrbk3p0lRGEz
 RFAPUXRsp7EenT1z0+ZeC/plcsyBI+SbWHbLiSIdiwosy9iGLGAPduklKvWvxDQJk0H+
 2koQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=WjvcwcjrT89kMVrD2gN+cHLbR83zRSARv+WYvKIJ6y4=;
 b=of+GqAblKRw6uTNCJfCpgg8SZK10gJG2tChS5xMuGw8jLbQEH+OCFw0iodC7aYmW6G
 rBnVOAGRAy4Sibf7NQ0DfrWmcTme/FXqnY/pRyhn1gt0WHuqsS+m01o4bKRvpBmPytst
 vIwEmeVq8RYLygyeMtYa08tQd+NI+yZStPl15GSXhm1qI5QssxP5aQjz8dFcQkTjUV6Y
 90fUd6wpPbCXDlq3nZTvCDsh/4AALuG1Zisd6PZ62gU0EI8G3qazg3CbMWidUdSVxV0e
 56r6HVmF8M7jFcYHW8NHgH9ne+2+SLfMw4lI/A8RnUPs2rL2Voh2s4UBkF3VaCzaXsfm
 svLA==
X-Gm-Message-State: APjAAAW7nTKOZ/YnUkLHbO4YlCLdDh34kjseaZhkXsSMU5I6sSFCHEJI
 FKmd6fSHs8ZLMXZFshEE5Nt7MDXv8dzQzA/4gLBScw==
X-Google-Smtp-Source: APXvYqzpkEame9QXNJthdawdODrQb2VrUwm3WRr+8Cm/uCW8iC0huE8aiRdz/RSzvrNGmqg7pTUg2iqEofBo5VFuJs8=
X-Received: by 2002:a05:6830:13da:: with SMTP id
 e26mr16419976otq.97.1580729778972; 
 Mon, 03 Feb 2020 03:36:18 -0800 (PST)
MIME-Version: 1.0
References: <20200201192916.31796-1-richard.henderson@linaro.org>
 <20200201192916.31796-31-richard.henderson@linaro.org>
In-Reply-To: <20200201192916.31796-31-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Feb 2020 11:36:08 +0000
Message-ID: <CAFEAcA_0at8qwiyxqwwqath9i3URBWBEKf-9nfgWikhnOfcO6A@mail.gmail.com>
Subject: Re: [PATCH v6 30/41] target/arm: Flush tlb for ASID changes in EL2&0
 translation regime
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 1 Feb 2020 at 19:29, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Since we only support a single ASID, flush the tlb when it changes.
>
> Note that TCR_EL2, like TCR_EL1, has the A1 bit that chooses between
> the two TTBR* registers for the location of the ASID.
>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 22 +++++++++++++++-------
>  1 file changed, 15 insertions(+), 7 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index cfa6ce59dc..f9be6b052f 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -3763,7 +3763,7 @@ static void vmsa_ttbcr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>      tcr->base_mask = 0xffffc000u;
>  }
>
> -static void vmsa_tcr_el1_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +static void vmsa_tcr_el12_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                 uint64_t value)
>  {
>      ARMCPU *cpu = env_archcpu(env);
> @@ -3789,7 +3789,17 @@ static void vmsa_ttbr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>  static void vmsa_tcr_ttbr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
>                                      uint64_t value)
>  {
> -    /* TODO: There are ASID fields in here with HCR_EL2.E2H */
> +    /*
> +     * If we are running with E2&0 regime, then an ASID is active.
> +     * Flush if that might be changing.  Note we're not checking
> +     * TCR_EL2.A1 to know if this is really the TTBRx_EL2 that
> +     * holds the active ASID, only checking the field that might.
> +     */
> +    if (extract64(raw_read(env, ri) ^ value, 48, 16) &&
> +        (arm_hcr_el2_eff(env) & HCR_E2H)) {
> +        tlb_flush_by_mmuidx(env_cpu(env),
> +                            ARMMMUIdxBit_E20_2 | ARMMMUIdxBit_E20_0);
> +    }
>      raw_write(env, ri, value);

Since we don't flush TLBs when HCR_EL2.E2H changes, I'm wondering
about this sequence:

 * initially HCR_EL2.E2H == 1 and the E2&0 TLBs are populated
 * HCR_EL2.E2H is set to 0
 * TTBR1_EL2 is written with a different ASID from step 1,
   but we don't flush the TLBs because HCR_EL2.E2H is 0
 * HCR_EL2.E2H is set to 1
 * guest will pick up wrong-ASID TLB entries from step 1

Does the architecture require that the guest did some TLB
maintenance ops somewhere along the line to avoid this?
I haven't tried to look for them, but given the different
ASIDs I'm not sure it does...

thanks
-- PMM

