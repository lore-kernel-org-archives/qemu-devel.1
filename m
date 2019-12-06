Return-Path: <SRS0=8N/K=Z4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E65DAC43603
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:33:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A9BAF21835
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Dec 2019 18:33:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gYVWDaYI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A9BAF21835
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1idIPX-00087X-Mq
	for qemu-devel@archiver.kernel.org; Fri, 06 Dec 2019 13:33:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59296)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1idHLZ-0007iL-EX
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:24:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1idHLV-0005gy-E1
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:24:51 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:35864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1idHLT-0005bw-Ds
 for qemu-devel@nongnu.org; Fri, 06 Dec 2019 12:24:47 -0500
Received: by mail-oi1-x243.google.com with SMTP id c16so465195oic.3
 for <qemu-devel@nongnu.org>; Fri, 06 Dec 2019 09:24:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=LjwkGMfMivkNEOABq6/iocmNEW8IwVdsiGvVDx9zgTk=;
 b=gYVWDaYIkaPg4FVyan//omJHZ+gpg0v8i+/DTItee17y6WX8gD21y/ZZN+UNZIIBJE
 6cezWLHlkCPoZJZIj94imwryoE9vBmCO1XnQJ8C3ViqWEwTEm/nilho0JfgjL4er7kK9
 hWphb+SgY+q9WQgSfhpTzYwjQalpVO8dhrQi1iSsIpajLOcvsjVvPUzOLfd5y4foTKGg
 lbpMWbWiGdl0gwsOuUJ9myS7Vbe/favri1+fAw2rFz94L0hlcMc7XH0H8/kiVIcZe7Hb
 e7+pmT7xrPNs391KtB+cR9VKLyAj3RL/YRsGkPmP0jClUaWD+NE99JOYsQM2xTGI5IOv
 titQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=LjwkGMfMivkNEOABq6/iocmNEW8IwVdsiGvVDx9zgTk=;
 b=bjY4AtwQZuG5ZZ45uiLxM0xgbdGYwcfIEz0x5aE1h/1ijanaz+kB1TucBd/FQ/0Yut
 PtODy9vUoDnsCKyDr4BfhOy2OApREdfMaIQRP8bmGp+uRWIKybIgcmMunN6XIxRf9SWd
 c9ulZ5T88eFc9QhbYxzWX3430NeQ0egb6tJeJ0SjdFuCR2SlyXcxSg0/aXGgz5h9vSQ/
 Wcv/ixAqSg64dMSIA6sBG7BQpvyw45+vZWdG/BZjEqugwrP+f+PqeGRFw35wxU9GJcX/
 GAPpYzjZ/IcXQsm3FQvrQW/Q4wvdLYkwVmdTc1q1+S+Oedt7WlPKvgC3dEnDygxd68No
 fDXg==
X-Gm-Message-State: APjAAAXs+YkACNyZ0WZ04x1Jr+OaRYYo5ReWKsSyLxdYoRh0xVAKLnnM
 9LuU0rjcX7lY+d13zhyHdQcV7HUsGc6EP0vgj/xvgw==
X-Google-Smtp-Source: APXvYqzP/919uQcYzEWFDHGVgSvr+3EWsB1dvsFpwnJKNCD88tJ+FApRbwcMqj+5HbGrmJcV6LFBST2nIFZwfixqgZw=
X-Received: by 2002:a05:6808:996:: with SMTP id
 a22mr12691392oic.146.1575653083385; 
 Fri, 06 Dec 2019 09:24:43 -0800 (PST)
MIME-Version: 1.0
References: <20191203022937.1474-1-richard.henderson@linaro.org>
 <20191203022937.1474-28-richard.henderson@linaro.org>
In-Reply-To: <20191203022937.1474-28-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Dec 2019 17:24:32 +0000
Message-ID: <CAFEAcA8taFKOtz0pM-N3KRiQrguh43SNLSM__ZJH5xzVK5YkZg@mail.gmail.com>
Subject: Re: [PATCH v4 27/40] target/arm: Add VHE system register redirection
 and aliasing
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
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 3 Dec 2019 at 02:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Several of the EL1/0 registers are redirected to the EL2 version when in
> EL2 and HCR_EL2.E2H is set.  Many of these registers have side effects.
> Link together the two ARMCPRegInfo structures after they have been
> properly instantiated.  Install common dispatch routines to all of the
> relevant registers.
>
> The same set of registers that are redirected also have additional
> EL12/EL02 aliases created to access the original register that was
> redirected.
>
> Omit the generic timer registers from redirection here, because we'll
> need multiple kinds of redirection from both EL0 and EL2.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/cpu.h    |  44 ++++++++----
>  target/arm/helper.c | 162 ++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 193 insertions(+), 13 deletions(-)
>
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 4bd1bf915c..bb5a72520e 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -2488,19 +2488,6 @@ struct ARMCPRegInfo {
>       */
>      ptrdiff_t fieldoffset; /* offsetof(CPUARMState, field) */
>
> -    /* Offsets of the secure and non-secure fields in CPUARMState for the
> -     * register if it is banked.  These fields are only used during the static
> -     * registration of a register.  During hashing the bank associated
> -     * with a given security state is copied to fieldoffset which is used from
> -     * there on out.
> -     *
> -     * It is expected that register definitions use either fieldoffset or
> -     * bank_fieldoffsets in the definition but not both.  It is also expected
> -     * that both bank offsets are set when defining a banked register.  This
> -     * use indicates that a register is banked.
> -     */
> -    ptrdiff_t bank_fieldoffsets[2];
> -
>      /* Function for making any access checks for this register in addition to
>       * those specified by the 'access' permissions bits. If NULL, no extra
>       * checks required. The access check is performed at runtime, not at
> @@ -2535,6 +2522,37 @@ struct ARMCPRegInfo {
>       * fieldoffset is 0 then no reset will be done.
>       */
>      CPResetFn *resetfn;
> +
> +    union {
> +        /*
> +         * Offsets of the secure and non-secure fields in CPUARMState for
> +         * the register if it is banked.  These fields are only used during
> +         * the static registration of a register.  During hashing the bank
> +         * associated with a given security state is copied to fieldoffset
> +         * which is used from there on out.
> +         *
> +         * It is expected that register definitions use either fieldoffset
> +         * or bank_fieldoffsets in the definition but not both.  It is also
> +         * expected that both bank offsets are set when defining a banked
> +         * register.  This use indicates that a register is banked.
> +         */
> +        ptrdiff_t bank_fieldoffsets[2];
> +
> +        /*
> +         * "Original" writefn and readfn.
> +         * For ARMv8.1-VHE register aliases, we overwrite the read/write
> +         * accessor functions of various EL1/EL0 to perform the runtime
> +         * check for which sysreg should actually be modified, and then
> +         * forwards the operation.  Before overwriting the accessors,
> +         * the original function is copied here, so that accesses that
> +         * really do go to the EL1/EL0 version proceed normally.
> +         * (The corresponding EL2 register is linked via opaque.)
> +         */
> +        struct {
> +            CPReadFn *orig_readfn;
> +            CPWriteFn *orig_writefn;
> +        };

Does this really need to be a union ? It's not clear to me
why we know the two halves of it are never used at the same time.

> +    };
>  };
>
>  /* Macros which are lvalues for the field in CPUARMState for the
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 1812588fa1..0baf188078 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -5306,6 +5306,158 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
>      REGINFO_SENTINEL
>  };
>
> +#ifndef CONFIG_USER_ONLY
> +/* Test if system register redirection is to occur in the current state.  */
> +static bool redirect_for_e2h(CPUARMState *env)
> +{
> +    return arm_current_el(env) == 2 && (arm_hcr_el2_eff(env) & HCR_E2H);
> +}
> +
> +static uint64_t el2_e2h_read(CPUARMState *env, const ARMCPRegInfo *ri)
> +{
> +    CPReadFn *readfn;
> +
> +    if (redirect_for_e2h(env)) {
> +        /* Switch to the saved EL2 version of the register.  */
> +        ri = ri->opaque;
> +        readfn = ri->readfn;
> +    } else {
> +        readfn = ri->orig_readfn;
> +    }
> +    if (readfn == NULL) {
> +        readfn = raw_read;
> +    }
> +    return readfn(env, ri);
> +}
> +
> +static void el2_e2h_write(CPUARMState *env, const ARMCPRegInfo *ri,
> +                          uint64_t value)
> +{
> +    CPWriteFn *writefn;
> +
> +    if (redirect_for_e2h(env)) {
> +        /* Switch to the saved EL2 version of the register.  */
> +        ri = ri->opaque;
> +        writefn = ri->writefn;
> +    } else {
> +        writefn = ri->orig_writefn;
> +    }
> +    if (writefn == NULL) {
> +        writefn = raw_write;
> +    }
> +    writefn(env, ri, value);
> +}

I see how this works when we have a readfn or writefn,
but how does the redirection work where the access
goes directly via .fieldoffset ?

thanks
-- PMM

