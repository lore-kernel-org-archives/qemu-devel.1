Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 753CFC433E8
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 00:44:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3AF5F2076A
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 00:44:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eYQ46k9T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AF5F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36042 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jway6-0002wS-Ef
	for qemu-devel@archiver.kernel.org; Fri, 17 Jul 2020 20:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwaxP-0002VY-QU
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 20:44:03 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:34486)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jwaxO-0004Nn-1o
 for qemu-devel@nongnu.org; Fri, 17 Jul 2020 20:44:03 -0400
Received: by mail-pf1-x443.google.com with SMTP id u185so6169563pfu.1
 for <qemu-devel@nongnu.org>; Fri, 17 Jul 2020 17:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JVvRs6TaeL278GRwMZHjUcDEou8fMfoAqCcn7X52Ms8=;
 b=eYQ46k9TuliI3LQABP5p1iuJOpccdweI67OmrY6+g+1aAzXPtKZNWVQuQIJADGeIoM
 JVMYaGJhAStf5zD19tP0GCWEVVa00l9fVDNx8nbjdbfmC/HBU4OKv2RkBsTj+JWiM/ob
 YYgaEXJXHyrmrF8LzDL9GTfpCyaaZOD2fd4JzatN33hGJBmHRcNqKIvxewdmkofbQFkL
 JNkol1hFJ3ZqSTTMFowF1306ftwk8mtT+vL1l2VSFijuvE6lOdebm+4+hoW2oQ8W0PCx
 Fc02seLtZl92zZ1XRn18Wfh4MHJWm46F13Jxt4tfVH44hgrfRBWtRqn3PCj8julbOhOu
 g3mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JVvRs6TaeL278GRwMZHjUcDEou8fMfoAqCcn7X52Ms8=;
 b=rZsGTfVhcalrVot6seU9J0nhCOZqdubMRQcfAqnwttyI1trD+5bZjq7Du1w8LsJdCA
 PFjSyDmMpabSknXrUV6q/sZ7KRZtuSUWYfRlU7pcefS5Zt3B9ZA2Tv5Kh9ww/b9AWbN2
 8pG32v5OyIc5HpBRZNNJz168An/ifLO/0/L+lGFhTcaMe9qmzQSO/KN5Phw9MZbn0ydn
 Vq7Out4B/whs68x/aI8fkBfjJwCafVxvh47vv3RXDKGQEkacRDcZQ2Eug5/tqdGGN5aw
 P9xo+fRwfScKy6c4vVR4ctPBR6/gVfgMmiu8g3iGYs9kKiFhICzlH6JaBoIYRVFQPFjb
 DEqg==
X-Gm-Message-State: AOAM5309tYq5lJxOdpmX37FwPzjPpH9hTMQG6ua+uaTi3w68WVzC/85o
 /if+Tn2LVF3o4ega+GAM+7bGYXIzSlg=
X-Google-Smtp-Source: ABdhPJyVK1XA6JzZGDpiqzmoCnr7FBfHjbPSjeOfqX8hMNmhbAjQXZAc8Xu9FxgaYBDUEt0q+pCBbA==
X-Received: by 2002:a62:e919:: with SMTP id j25mr10286480pfh.123.1595033040203; 
 Fri, 17 Jul 2020 17:44:00 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 k2sm8493787pgm.11.2020.07.17.17.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 17 Jul 2020 17:43:59 -0700 (PDT)
Subject: Re: [PATCH] goldfish_rtc: Fix non-atomic read behaviour of
 TIME_LOW/TIME_HIGH
To: Jessica Clarke <jrtc27@jrtc27.com>, qemu-riscv@nongnu.org
References: <20200718002027.82300-1-jrtc27@jrtc27.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0ad6100-9b80-1852-03e3-1e2a96639cb8@linaro.org>
Date: Fri, 17 Jul 2020 17:43:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718002027.82300-1-jrtc27@jrtc27.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Anup Patel <anup.patel@wdc.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/17/20 5:20 PM, Jessica Clarke wrote:
> The specification says:
> 
>    0x00  TIME_LOW   R: Get current time, then return low-order 32-bits.
>    0x04  TIME_HIGH  R: Return high 32-bits from previous TIME_LOW read.
> 
>    ...
> 
>    To read the value, the kernel must perform an IO_READ(TIME_LOW),
>    which returns an unsigned 32-bit value, before an IO_READ(TIME_HIGH),
>    which returns a signed 32-bit value, corresponding to the higher half
>    of the full value.
> 
> However, we were just returning the current time for both. If the guest
> is unlucky enough to read TIME_LOW and TIME_HIGH either side of an
> overflow of the lower half, it will see time be in the future, before
> jumping backwards on the next read, and Linux currently relies on the
> atomicity guaranteed by the spec so is affected by this. Fix this
> violation of the spec by caching the correct value for TIME_HIGH
> whenever TIME_LOW is read, and returning that value for any TIME_HIGH
> read.
> 
> Signed-off-by: Jessica Clarke <jrtc27@jrtc27.com>
> ---
>  hw/rtc/goldfish_rtc.c         | 14 ++++++++++++--
>  include/hw/rtc/goldfish_rtc.h |  1 +
>  2 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/rtc/goldfish_rtc.c b/hw/rtc/goldfish_rtc.c
> index 01e9d2b083..9b577bf159 100644
> --- a/hw/rtc/goldfish_rtc.c
> +++ b/hw/rtc/goldfish_rtc.c
> @@ -94,12 +94,22 @@ static uint64_t goldfish_rtc_read(void *opaque, hwaddr offset,
>      GoldfishRTCState *s = opaque;
>      uint64_t r = 0;
>  
> +    /*
> +     * From the documentation linked at the top of the file:
> +     *
> +     *   To read the value, the kernel must perform an IO_READ(TIME_LOW), which
> +     *   returns an unsigned 32-bit value, before an IO_READ(TIME_HIGH), which
> +     *   returns a signed 32-bit value, corresponding to the higher half of the
> +     *   full value.
> +     */
>      switch (offset) {
>      case RTC_TIME_LOW:
> -        r = goldfish_rtc_get_count(s) & 0xffffffff;
> +        r = goldfish_rtc_get_count(s);
> +        s->time_high = r >> 32;
> +        r &= 0xffffffff;
>          break;
>      case RTC_TIME_HIGH:
> -        r = goldfish_rtc_get_count(s) >> 32;
> +        r = s->time_high;
>          break;
>      case RTC_ALARM_LOW:
>          r = s->alarm_next & 0xffffffff;
> diff --git a/include/hw/rtc/goldfish_rtc.h b/include/hw/rtc/goldfish_rtc.h
> index 16f9f9e29d..9bd8924f5f 100644
> --- a/include/hw/rtc/goldfish_rtc.h
> +++ b/include/hw/rtc/goldfish_rtc.h
> @@ -41,6 +41,7 @@ typedef struct GoldfishRTCState {
>      uint32_t alarm_running;
>      uint32_t irq_pending;
>      uint32_t irq_enabled;
> +    uint32_t time_high;
>  } GoldfishRTCState;

You need to add the new field to goldfish_rtc_vmstate, and increment the version.


r~

