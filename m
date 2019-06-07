Return-Path: <SRS0=3yEa=UG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14CD3C2BCA1
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:08:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8202212F5
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2019 13:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cPbPscjg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8202212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50936 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZEbq-0001ME-4k
	for qemu-devel@archiver.kernel.org; Fri, 07 Jun 2019 09:08:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59147)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEaB-0000Kv-Tx
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:07:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hZEaA-0002nk-6R
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:06:59 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:43003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hZEa9-0002V8-Uj
 for qemu-devel@nongnu.org; Fri, 07 Jun 2019 09:06:58 -0400
Received: by mail-ot1-x343.google.com with SMTP id l15so1742528otn.9
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2019 06:06:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=cI6qVar/GplES/T834XGOnsU08ypLGNAaozaLc69CYE=;
 b=cPbPscjgw3ZW4z/lKPYMTC8Z+R3xs00PZ2OoSsg+UQuF7Sx/ox/zkAJIjn2/Mwsa+G
 1vm9TQfe3VNE/4gwxKt2DDRJXWckXLu92DeOdB5E7GZQ6ZoCGJbGpM6I/ZaWPHPzm0gB
 gxYUI9LF8x9yjwfFnoYxGnX4EOOlqr90rE3TMW+SAh4XtYyD6Wlul1uJVcyL5Wn6zdSw
 F1MUfmmme9ncwo5KoNxj8o4Fs1+cgEmnH8eQM1IjkCGhNqxuxfO1S0qjlsIfL6ZQKRIK
 PzC28wlPBwJzMv8gY3OFxiDWTa6zMSScBQBh5it4m5l9ylzaOF6CvfOerQMa2yHLL15L
 5k9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=cI6qVar/GplES/T834XGOnsU08ypLGNAaozaLc69CYE=;
 b=G2wXQpldWGhLOzdp8sMiHPorlikr5WKixJIpRykCdlJMeHfKl9fB6LMtjtFePpoMCH
 3lpzG34MWqwmfaVphddF6P88XioX8PVfolcSpkbYBONHPtGMU/1UJdsDAJbPtypGLbYx
 /px1D3GZCH7BEpo2YYbpzQb8Ap2dvlZPSkGmUxv1G4FCAlCjlaQcwqDMtEhzbpsx2trG
 OK4X8YNMErtJbLyBe5NrTfnrpKxzcCBR08ArPwulbj9ANqcRfV3ROvC4OIZeSpXW1QXu
 M40aqfrk8ZnKPIATi8MMl5HwDKip9PqdJX3gZCrBAY5R7YGG8Dnvk5XDIJo4mAGA2T0Z
 N2+g==
X-Gm-Message-State: APjAAAVk5XtG7yTOcoqPgZyXrEVipiaVWSNnZS72h98Eh/T+J056ypzR
 X2JlHYr7bKR3Xab0HMo8FsRxrSh4lxZgd0RUS/ZeIRCHD0Y=
X-Google-Smtp-Source: APXvYqz3W/1YIrq1SUfNE8ByFIvTPgYJaNvEYn6X6FqvpYnm+ipQUrPE1p0s5EGyTzVll7Gmoec9Z+dq0+nDwI8lc7o=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr19503710otp.91.1559912808666; 
 Fri, 07 Jun 2019 06:06:48 -0700 (PDT)
MIME-Version: 1.0
References: <20190510110357.18825-1-peter.maydell@linaro.org>
In-Reply-To: <20190510110357.18825-1-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Jun 2019 14:06:37 +0100
Message-ID: <CAFEAcA_FnpYF_AegaYUqfPhr_k9ZXUS=JCamtD3+nSvonHC1vg@mail.gmail.com>
To: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH v2] target/arm: Implement NSACR gating of
 floating point
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
Cc: Richard Henderson <richard.henderson@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for code review, please?

thanks
-- PMM

On Fri, 10 May 2019 at 12:03, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> The NSACR register allows secure code to configure the FPU
> to be inaccessible to non-secure code. If the NSACR.CP10
> bit is set then:
>  * NS accesses to the FPU trap as UNDEF (ie to NS EL1 or EL2)
>  * CPACR.{CP10,CP11} behave as if RAZ/WI
>  * HCPTR.{TCP11,TCP10} behave as if RAO/WI
>
> Note that we do not implement the NSACR.NSASEDIS bit which
> gates only access to Advanced SIMD, in the same way that
> we don't implement the equivalent CPACR.ASEDIS and HCPTR.TASE.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Changes v1->v2:
>  * fixed bug in cptr_el2_read() that meant we were forcing
>    HCPTR.{TCP11,TCP10} to 0 when they should be 1
> ---
>  target/arm/helper.c | 75 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 2 deletions(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 1e6eb0d0f36..f1fcce0313b 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -928,9 +928,36 @@ static void cpacr_write(CPUARMState *env, const ARMCPRegInfo *ri,
>          }
>          value &= mask;
>      }
> +
> +    /*
> +     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
> +     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
> +     */
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> +        value &= ~(0xf << 20);
> +        value |= env->cp15.cpacr_el1 & (0xf << 20);
> +    }
> +
>      env->cp15.cpacr_el1 = value;
>  }
>
> +static uint64_t cpacr_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /*
> +     * For A-profile AArch32 EL3 (but not M-profile secure mode), if NSACR.CP10
> +     * is 0 then CPACR.{CP11,CP10} ignore writes and read as 0b00.
> +     */
> +    uint64_t value = env->cp15.cpacr_el1;
> +
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> +        value &= ~(0xf << 20);
> +    }
> +    return value;
> +}
> +
> +
>  static void cpacr_reset(CPUARMState *env, const ARMCPRegInfo *ri)
>  {
>      /* Call cpacr_write() so that we reset with the correct RAO bits set
> @@ -996,7 +1023,7 @@ static const ARMCPRegInfo v6_cp_reginfo[] = {
>      { .name = "CPACR", .state = ARM_CP_STATE_BOTH, .opc0 = 3,
>        .crn = 1, .crm = 0, .opc1 = 0, .opc2 = 2, .accessfn = cpacr_access,
>        .access = PL1_RW, .fieldoffset = offsetof(CPUARMState, cp15.cpacr_el1),
> -      .resetfn = cpacr_reset, .writefn = cpacr_write },
> +      .resetfn = cpacr_reset, .writefn = cpacr_write, .readfn = cpacr_read },
>      REGINFO_SENTINEL
>  };
>
> @@ -4681,6 +4708,36 @@ uint64_t arm_hcr_el2_eff(CPUARMState *env)
>      return ret;
>  }
>
> +static void cptr_el2_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                           uint64_t value)
> +{
> +    /*
> +     * For A-profile AArch32 EL3, if NSACR.CP10
> +     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
> +     */
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> +        value &= ~(0x3 << 10);
> +        value |= env->cp15.cptr_el[2] & (0x3 << 10);
> +    }
> +    env->cp15.cptr_el[2] = value;
> +}
> +
> +static uint64_t cptr_el2_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    /*
> +     * For A-profile AArch32 EL3, if NSACR.CP10
> +     * is 0 then HCPTR.{TCP11,TCP10} ignore writes and read as 1.
> +     */
> +    uint64_t value = env->cp15.cptr_el[2];
> +
> +    if (arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +        !arm_is_secure(env) && !extract32(env->cp15.nsacr, 10, 1)) {
> +        value |= 0x3 << 10;
> +    }
> +    return value;
> +}
> +
>  static const ARMCPRegInfo el2_cp_reginfo[] = {
>      { .name = "HCR_EL2", .state = ARM_CP_STATE_AA64,
>        .type = ARM_CP_IO,
> @@ -4728,7 +4785,8 @@ static const ARMCPRegInfo el2_cp_reginfo[] = {
>      { .name = "CPTR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 1, .crm = 1, .opc2 = 2,
>        .access = PL2_RW, .accessfn = cptr_access, .resetvalue = 0,
> -      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]) },
> +      .fieldoffset = offsetof(CPUARMState, cp15.cptr_el[2]),
> +      .readfn = cptr_el2_read, .writefn = cptr_el2_write },
>      { .name = "MAIR_EL2", .state = ARM_CP_STATE_BOTH,
>        .opc0 = 3, .opc1 = 4, .crn = 10, .crm = 2, .opc2 = 0,
>        .access = PL2_RW, .fieldoffset = offsetof(CPUARMState, cp15.mair_el[2]),
> @@ -13527,6 +13585,19 @@ int fp_exception_el(CPUARMState *env, int cur_el)
>          break;
>      }
>
> +    /*
> +     * The NSACR allows A-profile AArch32 EL3 and M-profile secure mode
> +     * to control non-secure access to the FPU. It doesn't have any
> +     * effect if EL3 is AArch64 or if EL3 doesn't exist at all.
> +     */
> +    if ((arm_feature(env, ARM_FEATURE_EL3) && !arm_el_is_aa64(env, 3) &&
> +         cur_el <= 2 && !arm_is_secure_below_el3(env))) {
> +        if (!extract32(env->cp15.nsacr, 10, 1)) {
> +            /* FP insns act as UNDEF */
> +            return cur_el == 2 ? 2 : 1;
> +        }
> +    }
> +
>      /* For the CPTR registers we don't need to guard with an ARM_FEATURE
>       * check because zero bits in the registers mean "don't trap".
>       */
> --
> 2.20.1

