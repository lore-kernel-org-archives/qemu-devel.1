Return-Path: <SRS0=HheB=ZZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D84FC432C0
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:16:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE7CB206EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2019 11:16:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PAy2SmgT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE7CB206EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ic6A0-00041L-1C
	for qemu-devel@archiver.kernel.org; Tue, 03 Dec 2019 06:16:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:32974)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ic5w7-0005gs-83
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ic5vk-0005b2-PQ
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:01:26 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:37283)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ic5vk-0005O4-Fe
 for qemu-devel@nongnu.org; Tue, 03 Dec 2019 06:01:20 -0500
Received: by mail-oi1-x243.google.com with SMTP id x195so2871641oix.4
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2019 03:01:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Rab/J5gH/QbKQ/NgfodcNxsJh57te6atcpnHBg9t3eU=;
 b=PAy2SmgTsS5JcIbgUmCWPLVJatVpMmYZxaQNPwB1EG22CiHXRxnj6VVFL7HVo0zTnm
 M/to28nX2Fz8VmLtAu7bU3dq5jMa42mW5DMsZyc1G1u9qEDZJx89zAPqCkEO/xnPV2OW
 D4xb+iTlQqXzrL/CFVqsNFXXMX/A+OcMaybP/leS4YwC5L3GqP169UlCcEgN5jFe/9gB
 CP4f3ohkRDA8UR1PJnFsBVjoWP0Fy3OZ0TrquET543REMgCB0Ry1NbPnfNh9GVLHT4Oc
 lwnjslKUAA3CHr9BNz1vnJWNYQjlz3QptrlmS42Orw4YX2KwWZLnXIazhLxbHwlsKEwj
 V6rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Rab/J5gH/QbKQ/NgfodcNxsJh57te6atcpnHBg9t3eU=;
 b=oGp8ayw8ZJlfbvHzcKiz/e+NA97LILPYQ0B0BE6CX3XzBXVEd328+c/PphO0ZgI8Yb
 i3pZcho2/B1icNs59cO2HMREss+GnfSRrUw41kMRoMCxsWeXaWVPJI6e/067flttUO/Z
 SnJS5zgxGz5Udv788Gf7e/zHHEdcNCnyPtxzbVlCaMxx9DyNnEn/JA2YctORXBH181G1
 K+SyuVMsBEtpF7mkKT48ykt6dy9QQ1PcdYkjHbGzZy3u+Ao/YaJ1FZDOIcBNdQoKb2pU
 kIpf/Lto1oXTccsBkAlLpdqQxkQ6vpl2mrjT7LAQr9Pv5QL0DfsQhG5J5v7W1EWrwiVr
 guDA==
X-Gm-Message-State: APjAAAWp/y8eEt9NSwpGA3FHtz9KDvd9UpEQBxNIJ2X/iuETDZGqAtt5
 1WhXjQUBXkkP40JbKxRYkTAeE6/gbnXmyRUib/Ei5g==
X-Google-Smtp-Source: APXvYqzo369TCbyMLBfHzWcVH1SG1EA2iSery8uovBYdOhSZS9GbPc4LTpTMsUbh3zLDLhTJiJvlQRl1BgOK5QNoa9o=
X-Received: by 2002:aca:1a0a:: with SMTP id a10mr2915763oia.146.1575370876886; 
 Tue, 03 Dec 2019 03:01:16 -0800 (PST)
MIME-Version: 1.0
References: <20191011134744.2477-1-richard.henderson@linaro.org>
 <20191011134744.2477-3-richard.henderson@linaro.org>
In-Reply-To: <20191011134744.2477-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2019 11:01:05 +0000
Message-ID: <CAFEAcA_Ob3_fGNo3n9hgB6oa-y9abSbtN7Y1u3jpY9uaXNwbSQ@mail.gmail.com>
Subject: Re: [PATCH v5 02/22] target/arm: Add regime_has_2_ranges
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 11 Oct 2019 at 14:48, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> A translation with 2 ranges has both positive and negative addresses.
> This is true for the EL1&0 and the as-yet unimplemented EL2&0 regimes.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/internals.h     | 14 ++++++++++++++
>  target/arm/helper.c        | 22 +++++-----------------
>  target/arm/translate-a64.c |  3 +--
>  3 files changed, 20 insertions(+), 19 deletions(-)
>
> diff --git a/target/arm/internals.h b/target/arm/internals.h
> index dcc5d6cca3..9486680b87 100644
> --- a/target/arm/internals.h
> +++ b/target/arm/internals.h
> @@ -804,6 +804,20 @@ static inline void arm_call_el_change_hook(ARMCPU *cpu)
>      }
>  }
>
> +/* Return true if this address translation regime has two ranges.  */
> +static inline bool regime_has_2_ranges(ARMMMUIdx mmu_idx)
> +{
> +    switch (mmu_idx) {
> +    case ARMMMUIdx_S12NSE0:
> +    case ARMMMUIdx_S12NSE1:
> +    case ARMMMUIdx_S1NSE0:
> +    case ARMMMUIdx_S1NSE1:
> +        return true;

Don't S1SE0 and S1SE1 also need to be here?

> +    default:
> +        return false;
> +    }
> +}
> +
>  /* Return true if this address translation regime is secure */
>  static inline bool regime_is_secure(CPUARMState *env, ARMMMUIdx mmu_idx)
>  {
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index b690eda136..f9dee51ede 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -8774,15 +8774,8 @@ static int get_S1prot(CPUARMState *env, ARMMMUIdx mmu_idx, bool is_aa64,
>      }
>
>      if (is_aa64) {
> -        switch (regime_el(env, mmu_idx)) {
> -        case 1:
> -            if (!is_user) {
> -                xn = pxn || (user_rw & PAGE_WRITE);
> -            }
> -            break;
> -        case 2:
> -        case 3:
> -            break;
> +        if (regime_has_2_ranges(mmu_idx) && !is_user) {
> +            xn = pxn || (user_rw & PAGE_WRITE);
>          }

(I was sceptical that 'regime_has_2_ranges()' was the right condition
here, but the Arm ARM really does define it as "valid only when stage
1 of the translation regime can support two VA ranges".)

>      } else if (arm_feature(env, ARM_FEATURE_V7)) {
>          switch (regime_el(env, mmu_idx)) {
> @@ -9316,7 +9309,6 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
>                                          ARMMMUIdx mmu_idx)
>  {
>      uint64_t tcr = regime_tcr(env, mmu_idx)->raw_tcr;
> -    uint32_t el = regime_el(env, mmu_idx);
>      bool tbi, tbid, epd, hpd, tcma, using16k, using64k;
>      int select, tsz;
>
> @@ -9326,7 +9318,7 @@ ARMVAParameters aa64_va_parameters_both(CPUARMState *env, uint64_t va,
>       */
>      select = extract64(va, 55, 1);
>
> -    if (el > 1) {
> +    if (!regime_has_2_ranges(mmu_idx)) {
>          tsz = extract32(tcr, 0, 6);
>          using64k = extract32(tcr, 14, 1);
>          using16k = extract32(tcr, 15, 1);
> @@ -9486,10 +9478,7 @@ static bool get_phys_addr_lpae(CPUARMState *env, target_ulong address,
>          param = aa64_va_parameters(env, address, mmu_idx,
>                                     access_type != MMU_INST_FETCH);
>          level = 0;
> -        /* If we are in 64-bit EL2 or EL3 then there is no TTBR1, so mark it
> -         * invalid.
> -         */
> -        ttbr1_valid = (el < 2);
> +        ttbr1_valid = regime_has_2_ranges(mmu_idx);
>          addrsize = 64 - 8 * param.tbi;
>          inputsize = 64 - param.tsz;
>      } else {
> @@ -11095,8 +11084,7 @@ void cpu_get_tb_cpu_state(CPUARMState *env, target_ulong *pc,
>              ARMVAParameters p0 = aa64_va_parameters_both(env, 0, stage1);
>              int tbii;
>
> -            /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> -            if (regime_el(env, stage1) < 2) {
> +            if (regime_has_2_ranges(mmu_idx)) {

Now that the rebuild_hflags patchset has landed this is in
rebuild_hflags_a64().

>                  ARMVAParameters p1 = aa64_va_parameters_both(env, -1, stage1);
>                  tbid = (p1.tbi << 1) | p0.tbi;
>                  tbii = tbid & ~((p1.tbid << 1) | p0.tbid);
> diff --git a/target/arm/translate-a64.c b/target/arm/translate-a64.c
> index 51f3af9cd9..c85db69db4 100644
> --- a/target/arm/translate-a64.c
> +++ b/target/arm/translate-a64.c
> @@ -175,8 +175,7 @@ static void gen_top_byte_ignore(DisasContext *s, TCGv_i64 dst,
>      if (tbi == 0) {
>          /* Load unmodified address */
>          tcg_gen_mov_i64(dst, src);
> -    } else if (s->current_el >= 2) {
> -        /* FIXME: ARMv8.1-VHE S2 translation regime.  */
> +    } else if (!regime_has_2_ranges(s->mmu_idx)) {
>          /* Force tag byte to all zero */
>          tcg_gen_extract_i64(dst, src, 0, 56);
>      } else {

The comment above this function also needs updating to no longer
refer to "EL2 and EL3" vs "EL0 and EL1". (You might also remove
the use of the imperial 'We' in the last sentence in it ;-))

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

