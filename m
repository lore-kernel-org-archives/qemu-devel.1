Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C76CC433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:03:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8B32072E
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:03:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edw2SyVX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8B32072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36072 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfuOZ-0006QU-5w
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 20:03:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48190)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuNS-0005h9-S2
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:01:58 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:42916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuNQ-0006ou-Ta
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:01:58 -0400
Received: by mail-pl1-x641.google.com with SMTP id x11so575045plv.9
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0Y9MymB8EH4WPbs5YJ4U9Yi/bl85mXT6ng35Rjn9q5Q=;
 b=Edw2SyVXvNjIalNpxNwF7T1QSWEx1gi2b2md7fj+D2hlUBWPRgNLqfpAs5k71VqbQn
 hlnQHvBZkm4GJ4SE2xICrap7WgAbDbjM5r54UVBZBk3FUhtalsMWOCAbdciRLjaYV6ED
 VzOaxGv6SoR0QPBGpB1MncKRQfvF/RxfnUvfVL5OpciG/72yubGe0H8asXNGwmv11dC/
 b85I0RIK1zCijiJqSdS2OIqsIu0Sy/+CJLka8nQLke/GnLuaSZUmWs1fGYPkkxU90J1Y
 L2T3+O8tpMewhGJUkzreu9PeF6LZLSIcMsKLxCuqvTjmuBBAhwm/Ta6k+e0PxFeOtiCv
 Rtmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0Y9MymB8EH4WPbs5YJ4U9Yi/bl85mXT6ng35Rjn9q5Q=;
 b=l6RqZH8lsLD+6929FsLh0bmWDjcO/Rqlj4bRwDpJuRGptVpeckxqG9EdoCCCxh+ZrN
 kc+koY7VE9zAr3s6ROEZlFg3fzcjqKHQ6x4v/uzzGkD3PkSx3zOVJzEENba+BjmRVI7a
 G3z1NcLCQB2uqxrmAWy9TRVqo3GNcFI+JqSp/lG73sE4nldCFYEI4sM4smqplXbzvJpn
 xEx8/XwSne9T6mGHxzKjPJJy1IAvzioTn9WxdeMJrsW0Eyr+BkoAJm5nVTMRvNQVJaoW
 FfvKE00djDKwFoi4W6cxrhp07Ni+hUchrjI3rLwm4d0nDAAm69dzpAspBPSINRLLPu4W
 UyEw==
X-Gm-Message-State: AOAM533wdgdbd4VympGCA0yWu5fbjRIqttTDBc0X1/if8V6OCvP/6PA7
 pbKqzPYlnYUv4ToiYDi/eQiKQw==
X-Google-Smtp-Source: ABdhPJz2/xHXgDWv5FLSW2OCdo3odqbJmSMVACqU5kTguTTlPLnhU88C/gWpZigOHs+yTO20promSA==
X-Received: by 2002:a17:902:7e41:: with SMTP id
 a1mr22142932pln.72.1591056115229; 
 Mon, 01 Jun 2020 17:01:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f18sm481151pga.75.2020.06.01.17.01.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 17:01:54 -0700 (PDT)
Subject: Re: [PATCH 5/6] exec: Restrict 32-bit CPUs to 32-bit address space
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20200531175425.10329-1-f4bug@amsat.org>
 <20200531175425.10329-6-f4bug@amsat.org>
 <CAFEAcA9CkBy=e3EmJhKko9XGbL7A_E_vedm8jt_H3+Gr6yzbhA@mail.gmail.com>
 <2e78619d-543b-55b7-f241-7652274fcf4a@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <eddd2573-84cc-dcd3-09b0-85c6ba989721@linaro.org>
Date: Mon, 1 Jun 2020 17:01:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2e78619d-543b-55b7-f241-7652274fcf4a@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Beniamino Galvani <b.galvani@gmail.com>, qemu-s390x <qemu-s390x@nongnu.org>,
 qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/1/20 1:09 AM, Philippe Mathieu-Daudé wrote:
> On 5/31/20 9:09 PM, Peter Maydell wrote:
>> On Sun, 31 May 2020 at 18:54, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>>
>>> It is pointless to have 32-bit CPUs see a 64-bit address
>>> space, when they can only address the 32 lower bits.
>>>
>>> Only create CPU address space with a size it can address.
>>> This makes HMP 'info mtree' command easier to understand
>>> (on 32-bit CPUs).
>>
>>> diff --git a/exec.c b/exec.c
>>> index 5162f0d12f..d6809a9447 100644
>>> --- a/exec.c
>>> +++ b/exec.c
>>> @@ -2962,9 +2962,17 @@ static void tcg_commit(MemoryListener *listener)
>>>
>>>  static void memory_map_init(void)
>>>  {
>>> +    uint64_t system_memory_size;
>>> +
>>> +#if TARGET_LONG_BITS >= 64
>>> +    system_memory_size = UINT64_MAX;
>>> +#else
>>> +    system_memory_size = 1ULL << TARGET_LONG_BITS;
>>> +#endif
>>
>> TARGET_LONG_BITS is a description of the CPU's virtual
>> address size; but the size of the system_memory memory
>> region is related to the CPU's physical address size[*].
> 
> OK I misunderstood it was the physical size, not virtual.

It is the physical size.

In the armv7 case, the lpae page table entry maps a 32-bit virtual address to a
40-bit physical address.  The i686 page table extensions do something similar.

See TARGET_PHYS_ADDR_SPACE_BITS.


r~

