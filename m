Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24763C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:59:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E594720716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:59:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlqQa1Yj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E594720716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48292 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwpkq-00007z-5f
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:59:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56800)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iwpjS-0007R6-Us
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:58:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iwpjR-0005XT-Ep
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:58:22 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:46653)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iwpjR-0005Uw-7E
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:58:21 -0500
Received: by mail-oi1-x244.google.com with SMTP id a22so124079oid.13
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:58:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xREOXbAGrSczc9ttMRDemdVlY/CguXIIJAyyD1SVFlw=;
 b=XlqQa1Yjr0duEQyBW2haJk6+mOeD8eQofvemgcB+Qhw20fvWz6pSZuCfaZsk4lc5gM
 sLXXk/X1ZnhajFsyllCBOmbChvU5z2gn5wSLIDkGDZPj9aC0Py6nIQ6Xg23hoWspIxXZ
 CMFw+2kTFc3yxgD1dj8xK/WTRZEwbyC4FlraHBa57P+nSRMb6wm2kTZouf9JL57NWAds
 CUAdLYSNzSLo7NpK5jCCyyK5Mff+G/LY0QvvL1fuDfKbVVwlJh0j4rvCWi/lvs1xHr96
 aDUFgKPQ5U5u+eUuMDzOMT2eCpEMLKd22PGDkeGmlNKEGsoFKx6e4aDIa142i8GSXIOR
 40dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xREOXbAGrSczc9ttMRDemdVlY/CguXIIJAyyD1SVFlw=;
 b=LXf6Y4WcA1H3i6hol4ihXXabO5IVNexELaWMqQ5Is7QGxzqg19Tre98NA+NGTLcZq8
 WqujIXBF+Tl0PJ+YKeCzOQSAJQkosVtq4gPPiuUq+PawEpPOr+k+BZNNyUWBZxxgFVw6
 L+hVRl9MfoDFebwyCO7XL2SyplgazyujaX51goHA5pBaD92fHQOW0OSGjk4jrS4dDOuF
 dK0wYrtPSp0epizH33UCa78NyHx2gClwljokaaVsBmau5RNz13fa47BShSRz7HkRaHUq
 kIdl4KL9K259mYPa6gG2tpuaz3vlYfZXuZjMJCAiA1A31W6R8zxnBHBZU8+ztUzh02Xl
 3Eaw==
X-Gm-Message-State: APjAAAUjTrJRLGzOCAVeOKDUKrYY5ZnCbyjlkYh8wlBcdyktaSkJY73p
 0qkH8WWBF7jR3q5Mx59a/u4qBXpxdEz/fcCme0zZmw==
X-Google-Smtp-Source: APXvYqxSjyTd1sHx3dlk1l6GRSfjlxkNfWlrrMceTItGFra1TSow2LVhKIOsGji21CA/xnORfFnq7aTz4lyh8dRubbs=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr6887740oif.163.1580313499976; 
 Wed, 29 Jan 2020 07:58:19 -0800 (PST)
MIME-Version: 1.0
References: <20200128233224.515233-1-keithp@keithp.com>
In-Reply-To: <20200128233224.515233-1-keithp@keithp.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 29 Jan 2020 15:58:08 +0000
Message-ID: <CAFEAcA_dD3eAfKvOGOoXe3NWKg1PiW8=s2Xk41w19Tk67R-R4A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Add semihosting support [v4]
To: Keith Packard <keithp@keithp.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Riku Voipio <riku.voipio@iki.fi>, QEMU Developers <qemu-devel@nongnu.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 28 Jan 2020 at 23:34, Keith Packard via <qemu-devel@nongnu.org> wrote:
>
> Adapt the arm semihosting support code for RISCV. This implementation
> is based on the standard for RISC-V semihosting as documented in
>
>         https://riscv.org/specifications/
>
> Signed-off-by: Keith Packard <keithp@keithp.com>
>
> ---

> + *  ARM Semihosting is documented in:
> + *     Semihosting for AArch32 and AArch64 Release 2.0
> + *     https://static.docs.arm.com/100863/0200/semihosting.pdf

True but irrelevant. You need to refer to a proper
risc-v specification for your semihosting.

> +    case TARGET_SYS_EXIT:
> +    case TARGET_SYS_EXIT_EXTENDED:
> +        if (nr == TARGET_SYS_EXIT_EXTENDED || sizeof(target_ulong) == 0) {
> +            /*
> +             * The A64 version of SYS_EXIT takes a parameter block,
> +             * so the application-exit type can return a subcode which
> +             * is the exit status code from the application.
> +             * SYS_EXIT_EXTENDED is an a new-in-v2.0 optional function
> +             * which allows A32/T32 guests to also provide a status code.
> +             */

This code and comment describe Arm semihosting, where we
made this bad decision about the API for 32-bit Arm, fixed
it for 64-bit Arm and then put in an extension to add the more
sensible API to 32-bit as a backwards-compatible new function.
Nobody else should make this API choice from the start.
What does RISC-V want to do here? This should be in
your specification.

> +            GET_ARG(0);
> +            GET_ARG(1);
> +
> +            if (arg0 == ADP_Stopped_ApplicationExit) {
> +                ret = arg1;
> +            } else {
> +                ret = 1;
> +            }
> +        } else {
> +            /*
> +             * The A32/T32 version of SYS_EXIT specifies only
> +             * Stopped_ApplicationExit as normal exit, but does not
> +             * allow the guest to specify the exit status code.
> +             * Everything else is considered an error.
> +             */
> +            ret = (args == ADP_Stopped_ApplicationExit) ? 0 : 1;
> +        }
> +        gdb_exit(env, ret);
> +        exit(ret);
> +    case TARGET_SYS_SYNCCACHE:
> +        /*
> +         * Clean the D-cache and invalidate the I-cache for the specified
> +         * virtual address range. This is a nop for us since we don't
> +         * implement caches. This is only present on A64.
> +         */
> +        if (sizeof(target_ulong) == 8) {
> +            return 0;
> +        }
> +        /* fall through -- invalid for A32/T32 */

Again, this is an Arm-ism, where the old A32 ABI
doesn't have this function but the new A64 one does. What
does RISC-V want to specify here?

> +    default:
> +        fprintf(stderr, "qemu: Unsupported SemiHosting SWI 0x%02x\n", nr);
> +        cpu_dump_state(cs, stderr, 0);
> +        abort();

This is repeating the Arm ABI mistake of allowing implementations
to just crash and burn if they're handed a function call they don't
recognize. Ideally it should be avoided in a new ABI.

> +    }
> +}

thanks
-- PMM

