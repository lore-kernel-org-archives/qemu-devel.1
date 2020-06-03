Return-Path: <SRS0=6rdr=7Q=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A026C433E1
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 02:08:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 012EE2072F
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jun 2020 02:07:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bQZWEvKI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 012EE2072F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54490 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jgIox-0006mF-7Z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jun 2020 22:07:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54258)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgIoO-0006IH-Mf
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 22:07:24 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:42733)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jgIoN-0006sP-H3
 for qemu-devel@nongnu.org; Tue, 02 Jun 2020 22:07:24 -0400
Received: by mail-pf1-x443.google.com with SMTP id b5so494910pfp.9
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2020 19:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=KxQ9bU/9YiYkR+SepYOdCUKrovepFPnrpLJQCbR0mFk=;
 b=bQZWEvKIOvToHS+zZzBirh2ZFl4qylaLrclTHNH5djAWbsz98520oWQAtSW3sjgR33
 A4a3uCv/TRP/yT5bNYS4GeYS46wbrd43DLwLl17M6oNanUbPNcmMvtPwdPCKm4PQROfG
 n/+tFdLas8hB5yJK2abE1w3ogZDF6kiGwhRMfyN/k0VyYZhFUgXNo06ThP+02vWPreST
 FEDOllZYBTNBqUlT/MdcZAc8HDIPpYTWiFMX8zaO1zsqQFV/PxqevzTQkGLAbC9YMhHT
 t7H7REZpR3wQpAKWkhIgL8KcS1GBWceTXmbiNSEJgiRDKF3qlKmA7ZWgYgfFwo4528cL
 QD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=KxQ9bU/9YiYkR+SepYOdCUKrovepFPnrpLJQCbR0mFk=;
 b=U8BQUvPVvNA/1r5wsF4KLImxKzYwN02VISAnkVZOXC/SOJ5IfAOc+YW3c+M6l1o51z
 hTCbQGzvYIEsjqq+CRHHv7RolBrYBuJXVax+LTDm96aLl/EbCQ6eCcYfIuE4zISQ0Inz
 wG7QjXRh7hL0yj/sGTnNjLaj/Qpe1x17qsBTUBfkbyieALo9Q51H+XXzVIPAyP+cG8P/
 jTMm7Kgj82Yd/RWWGubVW8Nkb1bDck1+Y8wWt6hHD4DuWTmg+29CGmciEGCc5LZBUTzW
 U7a4zDrdsX11kQ1V+7XoYb5WpsJHzdqzibR/xYNGSDtPr747VBbZriZSwdhT6iBVbszz
 VWWw==
X-Gm-Message-State: AOAM530QRYUXD6zVNs/gUWR837fFAvNlvfCd4D3GVxbQqd0O43XYFnTf
 YBE4h+YiNfGr2mO5mPAzK+Nk+A==
X-Google-Smtp-Source: ABdhPJzb7sKAtbvFNopGwAzpOAMipvhM4WHJFCHspTQ84gUX/pxlp5SMzokkwR2vr8npWZpoSFgaiQ==
X-Received: by 2002:a17:90a:7446:: with SMTP id
 o6mr2609275pjk.217.1591150041677; 
 Tue, 02 Jun 2020 19:07:21 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id a2sm222229pgh.81.2020.06.02.19.07.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2020 19:07:20 -0700 (PDT)
Subject: Re: [PATCH v3] osdep: Make MIN/MAX evaluate arguments only once
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
References: <20200603013603.2400199-1-eblake@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <03a13d47-fe7d-88e5-b92e-3c396591f9c7@linaro.org>
Date: Tue, 2 Jun 2020 19:07:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200603013603.2400199-1-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 crosthwaite.peter@gmail.com, quintela@redhat.com, f4bug@amsat.org,
 dgilbert@redhat.com, kraxel@redhat.com, dirty.ice.hu@gmail.com,
 pbonzini@redhat.com, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/2/20 6:36 PM, Eric Blake wrote:
> --- a/include/exec/cpu-all.h
> +++ b/include/exec/cpu-all.h
> @@ -176,11 +176,9 @@ extern unsigned long reserved_va;
>   * avoid setting bits at the top of guest addresses that might need
>   * to be used for tags.
>   */
> -#if MIN(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32
> -# define GUEST_ADDR_MAX_  UINT32_MAX
> -#else
> -# define GUEST_ADDR_MAX_  (~0ul)
> -#endif
> +#define GUEST_ADDR_MAX_                                                 \
> +    ((MIN_CONST(TARGET_VIRT_ADDR_SPACE_BITS, TARGET_ABI_BITS) <= 32) ?  \
> +     UINT32_MAX : ~0ul)

This new expression is a type promotion to unsigned long...

>  #define GUEST_ADDR_MAX    (reserved_va ? reserved_va - 1 : GUEST_ADDR_MAX_)

... which is probably ok, since it would be done here anyway.
But I did wonder why the change.

> +/*
> + * Two variations of MIN/MAX macros. The first is for runtime use, and
> + * evaluates arguments only once (so it is safe even with side
> + * effects), but will not work in constant contexts (such as array
> + * size declarations).  The second is for compile-time use, where
> + * evaluating arguments twice is safe because the result is going to
> + * be constant anyway.
> + */
> +#undef MIN
> +#define MIN(a, b)                                       \
> +    ({                                                  \
> +        typeof(1 ? (a) : (b)) _a = (a), _b = (b);       \
> +        _a < _b ? _a : _b;                              \
> +    })
> +#define MIN_CONST(a, b)                                         \
> +    __builtin_choose_expr(                                      \
> +        __builtin_constant_p(a) && __builtin_constant_p(b),     \
> +        (a) < (b) ? (a) : (b),                                  \
> +        __builtin_unreachable())

Is it possible to use qemu_build_not_reached?

I'd prefer we generate a compile-time error than a runtime trap (or nothing,
depending on compiler flags controlling __builtin_unreachable).

> diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
> index 42ce1dfcff77..d77add79b218 100644
> --- a/accel/tcg/translate-all.c
> +++ b/accel/tcg/translate-all.c
> @@ -2565,9 +2565,9 @@ int page_check_range(target_ulong start, target_ulong len, int flags)
>      /* This function should never be called with addresses outside the
>         guest address space.  If this assert fires, it probably indicates
>         a missing call to h2g_valid.  */
> -#if TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS
> -    assert(start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
> -#endif
> +    if (TARGET_ABI_BITS > L1_MAP_ADDR_SPACE_BITS) {
> +        assert(start < ((target_ulong)1 << L1_MAP_ADDR_SPACE_BITS));
> +    }

IIRC the ifdef is required for clang warnings vs the shift.
Have you tested that?


r~

