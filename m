Return-Path: <SRS0=Hhxc=6L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D860C54FD0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:49:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A7BF20663
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2020 09:49:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uwbvparh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A7BF20663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jT0OQ-0000K4-EM
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 05:49:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36172)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT0LW-0005UY-0I
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:46:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jT0LE-0000YM-Dz
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:46:34 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36691)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jT0LD-0000Xs-Pc
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 05:46:20 -0400
Received: by mail-ot1-x342.google.com with SMTP id b13so25126516oti.3
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2020 02:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=qLLozm+WjNC4qFdEhxcPREzCwkfElD1ZJ3jbX1lYfPE=;
 b=uwbvparharVA5hoFzvO40fNXV5cTWJnRqNBopiR0Aw2l2Bk4mk4AoyZkq8AbMvXLEL
 mE4/BBkGO4tSWyHePkOSQ9zKRvYXwO/dSk2KQF2nFsgu5DTgYT7qf/bJWcXo7ztFTn6p
 TU+8LC8Ifo9q/AwmngWW5DLVRZvZgdRqLCC9WOnkYje2gJA2xuOK69hxPOyQ4k6fXYJV
 35Y5wZnPtgdVDu2jaqTg3lcIcK8RIXN3UugC6lX5u2KG8wVw42BKk3zrdERkGxcxXmvt
 Wh2Q474+M5mb9IoIOOkrBYJG2S7yuEWcnz2RHw9dWNBIuV8uF1u/BGb7buYKEuNTL119
 zB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=qLLozm+WjNC4qFdEhxcPREzCwkfElD1ZJ3jbX1lYfPE=;
 b=lBM7Y7rQ8hRgBFGYkEFueQJy4YoIblYp/7HQ/1qbM3pFboduH01M+rBnr5aofcf9fY
 LE5PlHx/v82gKNYPfwFDEq6tJKS5Yr83HIFl2/byP7p5lloQ28HQmQcD8qZhuWJ0Auh4
 g9XRQvHjy88uLDNX2pWRbULkZBwoJo3GhD58vi/OfdNTeXliRKOYGun7QSqb2Uq++CPq
 3jY51RzOw/VaxBwDShWZ9n1RS198mrzMHDfHIj337X//j28O18rvvsfEQshvazic9Wsb
 dqupSTn2rkShEKRtRnfJj7UL84cZ22pYkvCNbiP3ntPB2J4Z/07aa6R5ZiVAgBnm+xPD
 I95A==
X-Gm-Message-State: AGi0PubGoXHyVJe9dHZVjE5++i5xvtf261I6md8J75fazup74HR33QQb
 Xcsmz2iFBGTCG61U03KPG6VB5xwLeEHeG8ct11Z1S/YAuWY=
X-Google-Smtp-Source: APiQypLYS7sqwv2FjRe4d5kzcjCicRe1+7e/OsNVbIe3b5h1Lx86iA0jPZafssRCu4TR+HAQSUMB+3R1RkGaCaz4dis=
X-Received: by 2002:a9d:2c08:: with SMTP id f8mr18044018otb.135.1587980777230; 
 Mon, 27 Apr 2020 02:46:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200422043309.18430-1-richard.henderson@linaro.org>
 <20200422043309.18430-6-richard.henderson@linaro.org>
In-Reply-To: <20200422043309.18430-6-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Apr 2020 10:46:06 +0100
Message-ID: <CAFEAcA_nX69ppW-w3Fs99b4yqfQ-mfjBQHU2PrAHsU6Wam1Zqg@mail.gmail.com>
Subject: Re: [PATCH v3 05/18] accel/tcg: Add endian-specific cpu_{ld,
 st}* operations
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::342;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x342.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2607:f8b0:4864:20::342
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

On Wed, 22 Apr 2020 at 05:33, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> We currently have target-endian versions of these operations,
> but no easy way to force a specific endianness.  This can be
> helpful if the target has endian-specific operations, or a mode
> that swaps endianness.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  docs/devel/loads-stores.rst |  39 +++--
>  include/exec/cpu_ldst.h     | 277 +++++++++++++++++++++++++++---------
>  accel/tcg/cputlb.c          | 236 ++++++++++++++++++++++--------
>  accel/tcg/user-exec.c       | 211 ++++++++++++++++++++++-----
>  4 files changed, 587 insertions(+), 176 deletions(-)
>
> diff --git a/docs/devel/loads-stores.rst b/docs/devel/loads-stores.rst
> index 0d99eb24c1..9a944ef1af 100644
> --- a/docs/devel/loads-stores.rst
> +++ b/docs/devel/loads-stores.rst
> @@ -97,9 +97,9 @@ function, which is a return address into the generated code.
>
>  Function names follow the pattern:
>
> -load: ``cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmuidx, retaddr)``
> +load: ``cpu_ld{sign}{size}{end}_mmuidx_ra(env, ptr, mmuidx, retaddr)``
>
> -store: ``cpu_st{size}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
> +store: ``cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
>
>  ``sign``
>   - (empty) : for 32 or 64 bit sizes
> @@ -112,9 +112,14 @@ store: ``cpu_st{size}_mmuidx_ra(env, ptr, val, mmuidx, retaddr)``
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits
>
> +``end``
> + - (empty) : for target endian, or 8 bit sizes
> + - ``_be`` : big endian
> + - ``_le`` : little endian
> +
>  Regexes for git grep:
> - - ``\<cpu_ld[us]\?[bwlq]_mmuidx_ra\>``
> - - ``\<cpu_st[bwlq]_mmuidx_ra\>``
> + - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_mmuidx_ra\>``
> + - ``\<cpu_st[bwlq](_[bl]e)\?_mmuidx_ra\>``
>
>  ``cpu_{ld,st}*_data_ra``
>  ~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -129,9 +134,9 @@ be performed with a context other than the default.
>
>  Function names follow the pattern:
>
> -load: ``cpu_ld{sign}{size}_data_ra(env, ptr, ra)``
> +load: ``cpu_ld{sign}{size}{end}_data_ra(env, ptr, ra)``
>
> -store: ``cpu_st{size}_data_ra(env, ptr, val, ra)``
> +store: ``cpu_st{size}{end}_data_ra(env, ptr, val, ra)``
>
>  ``sign``
>   - (empty) : for 32 or 64 bit sizes
> @@ -144,9 +149,14 @@ store: ``cpu_st{size}_data_ra(env, ptr, val, ra)``
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits
>
> +``end``
> + - (empty) : for target endian, or 8 bit sizes
> + - ``_be`` : big endian
> + - ``_le`` : little endian
> +
>  Regexes for git grep:
> - - ``\<cpu_ld[us]\?[bwlq]_data_ra\>``
> - - ``\<cpu_st[bwlq]_data_ra\>``
> + - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_data_ra\>``
> + - ``\<cpu_st[bwlq](_[bl]e)\?_data_ra\>``
>
>  ``cpu_{ld,st}*_data``
>  ~~~~~~~~~~~~~~~~~~~~~
> @@ -163,9 +173,9 @@ the CPU state anyway.
>
>  Function names follow the pattern:
>
> -load: ``cpu_ld{sign}{size}_data(env, ptr)``
> +load: ``cpu_ld{sign}{size}{end}_data(env, ptr)``
>
> -store: ``cpu_st{size}_data(env, ptr, val)``
> +store: ``cpu_st{size}{end}_data(env, ptr, val)``
>
>  ``sign``
>   - (empty) : for 32 or 64 bit sizes
> @@ -178,9 +188,14 @@ store: ``cpu_st{size}_data(env, ptr, val)``
>   - ``l`` : 32 bits
>   - ``q`` : 64 bits
>
> +``end``
> + - (empty) : for target endian, or 8 bit sizes
> + - ``_be`` : big endian
> + - ``_le`` : little endian
> +
>  Regexes for git grep
> - - ``\<cpu_ld[us]\?[bwlq]_data\>``
> - - ``\<cpu_st[bwlq]_data\+\>``
> + - ``\<cpu_ld[us]\?[bwlq](_[bl]e)\?_data\>``
> + - ``\<cpu_st[bwlq](_[bl]e)\?_data\+\>``
>
>  ``cpu_ld*_code``
>  ~~~~~~~~~~~~~~~~
> diff --git a/include/exec/cpu_ldst.h b/include/exec/cpu_ldst.h
> index 53de19753a..1ba515bfcc 100644
> --- a/include/exec/cpu_ldst.h
> +++ b/include/exec/cpu_ldst.h
> @@ -26,12 +26,18 @@
>   * The syntax for the accessors is:
>   *
>   * load:  cpu_ld{sign}{size}_{mmusuffix}(env, ptr)
> + *        cpu_ld{sign}{size}{end}_{mmusuffix}(env, ptr)
>   *        cpu_ld{sign}{size}_{mmusuffix}_ra(env, ptr, retaddr)
> + *        cpu_ld{sign}{size}{end}_{mmusuffix}_ra(env, ptr, retaddr)
>   *        cpu_ld{sign}{size}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
> + *        cpu_ld{sign}{size}{end}_mmuidx_ra(env, ptr, mmu_idx, retaddr)
>   *
>   * store: cpu_st{size}_{mmusuffix}(env, ptr, val)
> + *        cpu_st{size}{end}_{mmusuffix}(env, ptr, val)
>   *        cpu_st{size}_{mmusuffix}_ra(env, ptr, val, retaddr)
> + *        cpu_st{size}{end}_{mmusuffix}_ra(env, ptr, val, retaddr)
>   *        cpu_st{size}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)
> + *        cpu_st{size}{end}_mmuidx_ra(env, ptr, val, mmu_idx, retaddr)

Since '{end}' can be the empty string, these new lines should
replace the old ones, not just be added. (The other changes
in this doc do the right thing.)

>   *
>   * sign is:
>   * (empty): for 32 and 64 bit sizes
> @@ -44,6 +50,11 @@
>   *   l: 32 bits
>   *   q: 64 bits
>   *
> + * end is:
> + * (empty): for target native endian, or for 8 bit access
> + *     _be: for forced big endian
> + *     _le: for forced little endian
> + *
>   * mmusuffix is one of the generic suffixes "data" or "code", or "mmuidx".
>   * The "mmuidx" suffix carries an extra mmu_idx argument that specifies
>   * the index to use; the "data" and "code" suffixes take the index from

Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

