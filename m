Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33726C4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:42:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA7E321655
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 17:42:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wwxpVGxA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA7E321655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55102 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDuGD-00082a-QR
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 13:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58837)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuEG-0006z1-26
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:40:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iDuEE-0006Jj-Mi
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:40:27 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430]:46333)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iDuED-0006He-Vx
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 13:40:26 -0400
Received: by mail-pf1-x430.google.com with SMTP id q5so1966257pfg.13
 for <qemu-devel@nongnu.org>; Fri, 27 Sep 2019 10:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=nkJn1fxu5RKUPf8wS2PwKkwn8IyODpibc0Y6hd8vVPU=;
 b=wwxpVGxAbcxyN+CWb/85c55Y4xFdq8gL8QxYczFKbGPFcdWdZBUOYczxFATIvsN/Fn
 CkPurxzgKd6KaoDhoACzPX8143UcZ//L+QL1c9Wp6yub0NJAP2wlNTtyt1SBWFdOGSWH
 9ow9ckAPyqVaCXQzFGYxb9hIhbM4Uavlz5Qi84uuu0R5R+8k2xtqdkTdYG5QhGkk+Yf+
 x2XzcNN6RJgB8sI6wxFvBLvIYIFwRfho8CZDfevZV4dPoG9vK/5jLaA+KT6LzRjwtK7l
 XjCV2D+RklRCmMi3qDd0twV6XOycXnWS0rTlXP2oyiFZ4PH5EX0vJh2s7GTX6xhAVhPZ
 682w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=nkJn1fxu5RKUPf8wS2PwKkwn8IyODpibc0Y6hd8vVPU=;
 b=dpQqdYRCcgjMATymK4UZUVupIOmc9qStRSlKxqFyZiY6cIDY8MOgwwNQHjdtboXSTF
 kumi3PwQYYeD6SIvnJOgV+7FBgHjDDGi81OmLlLf3cKxND+ZTIahJRsY01UM7h5rOpYU
 /+I6YStudbzs5cweHSTbeVszDuu6CxqhFy3Hk8ocSwRWh2z/etU/a+MFn5U3lTm9eqNA
 4zxPKSbmm4Od3Cn6+J3k9M6SMkGEcXvTv6p9EjCYIdP+kcklBkXdDQa/zBVFM7ZNKmey
 9xBPCFOPDnU74bAyy7QRt3f8mmPZiaKm5gDAvAb7m5C4FNe7tTNkkuElf+QNuiHwZdvr
 tAtg==
X-Gm-Message-State: APjAAAVLjdQRNEU2b9oKCARnyVePQCI0589ScqOcrASHorwJbISFS/tT
 f+lA6hBD3ZVh0r0naVcHwAn7Kw==
X-Google-Smtp-Source: APXvYqyJ7OfHuXLfB2gOWqAdhpeulCXfHPBq6Dn/pokEFne/MkrVK1D4qyeU5/UAWUNKhoPc9agc9w==
X-Received: by 2002:aa7:96a9:: with SMTP id g9mr5679928pfk.16.1569606022726;
 Fri, 27 Sep 2019 10:40:22 -0700 (PDT)
Received: from [172.20.32.216] ([12.157.10.118])
 by smtp.gmail.com with ESMTPSA id r186sm3116373pfr.40.2019.09.27.10.40.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 27 Sep 2019 10:40:21 -0700 (PDT)
Subject: Re: ptimer use of bottom-half handlers
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA8HGEdHs74-m3Wa7RHU_ZE5g9kEidP-9Z69zhsMkCPRZQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <40ec672d-b6a0-9b3b-f619-331b2fac05c2@linaro.org>
Date: Fri, 27 Sep 2019 10:40:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8HGEdHs74-m3Wa7RHU_ZE5g9kEidP-9Z69zhsMkCPRZQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::430
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/27/19 3:01 AM, Peter Maydell wrote:
>  (2) call the device's callback function directly when the
>      ptimer triggers from the QEMU timer expiry. But for
>      the case of "a call to ptimer_set_count() etc caused
>      the timer to trigger", don't call the callback, instead
>      return a boolean from those functions which tells the
>      caller that the timer triggered, and they need to deal
>      with it (by calling their callback function when they've
>      finished messing with the timer).
...
> I think overall I favour option 2, which is a bit more
> syntactically invasive in terms of changing API signatures etc,
> but semantically easier to reason about (because the
> callback-function in the device is still not called when
> the device might be partway through doing an update to
> the ptimer state that changes multiple parameters of the
> ptimer).
> 
> Is there another cleverer fix that I haven't thought of?

If "other things" are being changed along with ptimer_set_count, then is the
boolean result of ptimer_set_count necessarily still relevant after the "other
things"?

Can we record the set of things to be done within a
ptimer_transaction_{begin,commit}() pair and then invoke the callback (if
necessary) when committing?  Is it even easy to see the set of "other things"
that would need to be wrapped?

I think I need a bit of time understanding the use cases in hw/timer/ before
being able to suggest anything more definite...


r~

