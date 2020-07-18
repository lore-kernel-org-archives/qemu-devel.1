Return-Path: <SRS0=NumX=A5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC2BBC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 18:57:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FD542073E
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jul 2020 18:57:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WHfChN9E"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FD542073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jws1q-0006HF-QS
	for qemu-devel@archiver.kernel.org; Sat, 18 Jul 2020 14:57:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49096)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jws13-0005o8-OQ
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 14:56:57 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:40075)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jws12-00038e-0l
 for qemu-devel@nongnu.org; Sat, 18 Jul 2020 14:56:57 -0400
Received: by mail-pf1-x442.google.com with SMTP id u5so7005943pfn.7
 for <qemu-devel@nongnu.org>; Sat, 18 Jul 2020 11:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=3UW2JTlOvsJcBhk76vTmowayaV7lM0qAfOoaT/ODzY0=;
 b=WHfChN9EsDYdiHEpcn4m5IpRvjaqAc/L/tMmWM74r1CRrKLqU/03udRrxM+hFU6bGI
 f3UjTVAIhswSK6KquuyfqIE2nwTNncOadajuuhfvauNsYDTp5zAwtlWfbhRW/fxlOwIv
 Yj9rvlIaiJ+O+Fg17/n5ePYaDKiSramOFqTzGiz8By1M76Ps1CtWavsWpn2YRJ6mRnIq
 UI08DVZSnmzYHQ1CNjT4VdN3sUL76rnMpyM+OBT1ieZBoXOWvtCpnW2XfmKXZuZ6iIp0
 /jghPikaRtylg3Me252ZU+JVDWgVIEvXhPnW80/CkGwC1qs9ncCKZJrv3wzPoyVhwjT5
 lsEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=3UW2JTlOvsJcBhk76vTmowayaV7lM0qAfOoaT/ODzY0=;
 b=cQ5TZ3j+4BVttk2x2bzK1OyFi01kbH+v+Yd+NRDojZlhGT82+cFlm+Po01YEJgTkek
 ccc1hozbX+aYidh3+uaBBoQnDxZyyeZc9wA3vpsXk41GxpJrbeVakAcnBjXR50ScV157
 8fE/Y3McUX5pl5EYFaMbhcYcZpEsGbkG40qg1etf6VUff+hFN8rCvCjVVhODRaOtTTEt
 WrGXQy8CmzUsJJ0nclvXZFZ8mLO+k27Zy26MaBa6qduJW9mwtX4Gx/ke1gcyGbN4eOoo
 YnVAm1xnKEspoa+wUHpSnO2vN9ptARU8EXgTm/nJn96IHrhD+TTlI54ngxd2IPE1kMTX
 B4YQ==
X-Gm-Message-State: AOAM531GoJw+F7e1/JBDbXae7es5+gBEXyein1ghJj5q3DMkzNywHE2v
 0bKRYcueaxM6S0fGGm5zB7FQTC1gqe0=
X-Google-Smtp-Source: ABdhPJxHbi4UW41EK6uDqGq5oiS1FEY/D+YfjXYrjy97vu+RBrUQUQI+bOEq6NFklQWKEjOdmFsvCg==
X-Received: by 2002:a62:346:: with SMTP id 67mr13131712pfd.111.1595098613664; 
 Sat, 18 Jul 2020 11:56:53 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 q1sm11795651pfk.132.2020.07.18.11.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 18 Jul 2020 11:56:52 -0700 (PDT)
Subject: Re: [PATCH v2] goldfish_rtc: Fix non-atomic read behaviour of
 TIME_LOW/TIME_HIGH
To: Jessica Clarke <jrtc27@jrtc27.com>, qemu-riscv@nongnu.org
References: <20200718002027.82300-1-jrtc27@jrtc27.com>
 <20200718004934.83174-1-jrtc27@jrtc27.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <181ead03-ff89-9971-a527-1ff2038c35fd@linaro.org>
Date: Sat, 18 Jul 2020 11:56:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200718004934.83174-1-jrtc27@jrtc27.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 7/17/20 5:49 PM, Jessica Clarke wrote:
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
> Changes since v1:
> 
>  * Add time_high to goldfish_rtc_vmstate and increment version.
> 
>  hw/rtc/goldfish_rtc.c         | 17 ++++++++++++++---
>  include/hw/rtc/goldfish_rtc.h |  1 +
>  2 files changed, 15 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

