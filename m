Return-Path: <SRS0=8V6M=V6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65F4EC32750
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:27:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 350342087E
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2019 16:27:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y9PWMX8l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 350342087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36348 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1htaOw-0001ef-He
	for qemu-devel@archiver.kernel.org; Fri, 02 Aug 2019 12:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37087)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1htaOX-0001Ev-L7
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:27:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1htaOW-0004bZ-N0
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:27:05 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:35402)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1htaOW-0004bD-Du
 for qemu-devel@nongnu.org; Fri, 02 Aug 2019 12:27:04 -0400
Received: by mail-pg1-x543.google.com with SMTP id n4so1044227pgv.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2019 09:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GS8ER9DbxbrmSZza9XhZrac1/kV/t+hDGahI/wKxDyI=;
 b=Y9PWMX8lCsqFdI1gTTuHnE8GHPx75MODVn5LfizK5RxSqZIOYVj/F9z2K1+PPYrd6k
 y3+93WN48CEYJSpLrg2Viavd6UbS+EFuycR1Ba6oQkj02pZzm3FV6Lj5YEGix5kpR0Uq
 /bm4qB8eWpMCUg7E5J+OWBUimlMjr9w5N97Qq/Q6l6tOL7rY6p8ZMYVjqNOfX2sk2pTX
 vUu7xje6sNcDZC2LgDDWlF5Ssv2YYwMQztHMMMl10q8qWrOA4GVtDHnyUjxrpBPkz6u6
 uGxYWYvwZYIkTRwDKt41EvPh1RbGB94Qe0u3EcPHLyArQsNGg2YLD35uxSCiHsNTDspP
 xRHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GS8ER9DbxbrmSZza9XhZrac1/kV/t+hDGahI/wKxDyI=;
 b=LCVHbXJ+agGsvPi3WBdVXeuZPAgm+Z2KOpJIF0cj4MxuUjKIRWJED0W/25oOE2IgFi
 FQjyM/IRyoN5dnkw8KAxua365JzjEymfogjX4KEG7/MdMpWhGUpYZVgmspYrdTrnVJKf
 4farDAby/77FWviA+6EBL0Ajztt7vcJsgNMUcjbUvF4t5sQ6slUP5gqGBgZy5bGj4/zz
 WK962poSxaMnPDClsYaolrUd88mb1ME/Sl/wmPAPtQ/szgNkRcWcF7V//Hhuht1tOY68
 xZ6e+VWz5QuyHmf69JEDIDtMdh1LX1QXpAIkAfWCK1dxKb3WlFYaKWG/MftzYWw/pCqW
 WXuw==
X-Gm-Message-State: APjAAAX8A5HRiCO92IoP6zNvD5lapZAYK71fTAT0RDnLayUhHvcQFQFr
 XbhFG5SIhJPiOII9cDgUrShLmw==
X-Google-Smtp-Source: APXvYqxd+uO5rua+zoo+RjlQPPvZcii0QrBwMpr0HdTEQJsT7oBwOXCVayQInrz6mYAO4N8xqU1usw==
X-Received: by 2002:aa7:81d9:: with SMTP id c25mr61603169pfn.255.1564763223043; 
 Fri, 02 Aug 2019 09:27:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a3sm78757971pfi.63.2019.08.02.09.27.01
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 09:27:02 -0700 (PDT)
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20190802122540.26385-1-drjones@redhat.com>
 <20190802122540.26385-4-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d0983bd5-c1a5-adf6-324d-2b199ca0e23c@linaro.org>
Date: Fri, 2 Aug 2019 09:27:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190802122540.26385-4-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH v3 03/15] target/arm/monitor: Introduce
 qmp_query_cpu_model_expansion
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/2/19 5:25 AM, Andrew Jones wrote:
> Note, certainly more features may be added to the list of
> advertised features, e.g. 'vfp' and 'neon'. The only requirement
> is that their property set accessors fail when invalid
> configurations are detected. For vfp we would need something like
> 
>  set_vfp()
>  {
>    if (arm_feature(env, ARM_FEATURE_AARCH64) &&
>        cpu->has_vfp != cpu->has_neon)
>        error("AArch64 CPUs must have both VFP and Neon or neither")
> 
> in its set accessor, and the same for neon, rather than doing that
> check at realize time, which isn't executed at qmp query time.

How could this succeed?  Either set_vfp or set_neon would be called first, at
which point the two features are temporarily out of sync, but the error would
trigger anyway.

This would seem to require some separate "qmp validate" step that is processed
after a collection of properties are set.

I was about to say something about this being moot until someone actually wants
to be able to disable vfp+neon on aarch64, but then...

> +A note about CPU feature dependencies
> +-------------------------------------
> +
> +It's possible for features to have dependencies on other features. I.e.
> +it may be possible to change one feature at a time without error, but
> +when attempting to change all features at once an error could occur
> +depending on the order they are processed.  It's also possible changing
> +all at once doesn't generate an error, because a feature's dependencies
> +are satisfied with other features, but the same feature cannot be changed
> +independently without error.  For these reasons callers should always
> +attempt to make their desired changes all at once in order to ensure the
> +collection is valid.

... this language makes me think that you've already encountered an ordering
problem that might be better solved with a separate validate step?

The actual code looks good.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

