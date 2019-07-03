Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C560C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:41:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 496D12085A
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 19:41:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tY6ENfxB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 496D12085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39762 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hil8A-0001us-LC
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 15:41:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48946)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hil5k-0008N7-3p
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hil5h-00061J-Od
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:38:55 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436]:32823)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hil5f-000608-Tv
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 15:38:52 -0400
Received: by mail-wr1-x436.google.com with SMTP id n9so4125088wru.0
 for <qemu-devel@nongnu.org>; Wed, 03 Jul 2019 12:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=6Cp3ZViQ1SqEDCzTXm0p5ZKw3+3se+u9vknYaIXe794=;
 b=tY6ENfxBG0Y9jvUbvlk+tLNdTxp8HYbG24Lr+g4tr0KSjJFw97nHnAL9zZy4d5pejA
 AM+wV7ReXXlzhjRJhL8Vkr6BTOXqJylyUclTMugLCqKrE+asCi4VzZCGkC92PaC1JS8y
 6tPzXtFaNECWs0fT7o7GuDjbNZ4PqLLGrqvnsnCIxWMpGF5tMMIDQM0GX0wG+eUb41vE
 mTesWeFIksxOfLQCUysAtvjHMkZ3TaX/g7iTA2NgsyQGHH7Of8bji9zdmwwAmGnQIAv5
 YqQ3tGhTFvkHcoVeSMmKZnj4arcNddwT9HdD/LJTCZoVxepKaa95kV1AWfLgdTqfBO9G
 EC1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=6Cp3ZViQ1SqEDCzTXm0p5ZKw3+3se+u9vknYaIXe794=;
 b=c/lHhp9k988kM+ZbCgldFMpHfSSkFaWDZ50SCf3bVjyFNgrD+YglNQSGViOt5EyY3q
 R8HzIPsicwiezQUA4mDtEaivjncr+r1dblXLKx6dGBAisZZQwBg6Sruy6jTGsYV34M4w
 tSc9dkiOCt61EUzjt9l+AQHKcj6kf4MGvfQGSOjBk/bj7/jTkrFhD1Lnc7qJXcOXVFaI
 UN+XSCVm9Kr+/34GrjknSC3im0YuYzegBkvS94citL24TYoOg1KghYLdzRrmP1MJF5rv
 dV6PLq7ywcjATh8LVc9usaZi+1wNweIdF7XLeTn54nNDjPSJvgpUSWEBHQuzjCYyte1z
 7C1w==
X-Gm-Message-State: APjAAAV7aJ6HsOZ0cKOxENOPz3WgVogh8RSyPXwFWAyPo6PFTdibSdsX
 nu7UYh3nPcFT8+uVl25BE3Wg38yeNozrLg==
X-Google-Smtp-Source: APXvYqwMXYrvKFOFW6jODiPNx0CoDLt4PduEHgs1qJ6ywlevqPQih1oY5mRxIVQWedqF9nQktfEAig==
X-Received: by 2002:a5d:43d0:: with SMTP id v16mr28863212wrr.252.1562182729997; 
 Wed, 03 Jul 2019 12:38:49 -0700 (PDT)
Received: from [192.168.3.43] (93-34-153-63.ip50.fastwebnet.it. [93.34.153.63])
 by smtp.gmail.com with ESMTPSA id a84sm3480010wmf.29.2019.07.03.12.38.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 03 Jul 2019 12:38:49 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190702150542.12008-1-richard.henderson@linaro.org>
 <CAFEAcA8SH6OfWQ=3okD23pdpvp0LuG4H=2P0xR3b19UcZoHfpQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ffd97646-c497-7556-49c5-d10fed0b552a@linaro.org>
Date: Wed, 3 Jul 2019 21:38:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8SH6OfWQ=3okD23pdpvp0LuG4H=2P0xR3b19UcZoHfpQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::436
Subject: Re: [Qemu-devel] [PULL 0/3] tcg patch queue
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/3/19 6:21 PM, Peter Maydell wrote:
>> Alistair Francis (1):
>>       tcg/riscv: Fix RISC-VH host build failure
>>
>> Richard Henderson (2):
>>       tcg: Fix mmap lock assert on translation failure
>>       tcg: Fix expansion of INDEX_op_not_vec
> 
> Hi. This seems to cause an assertion failure running an
> x86-64 linux-user guest:
> 
> /home/petmay01/linaro/qemu-for-merges/build/all-linux-static/x86_64-linux-user/qemu-x86_64
> -L ./gnemul/qemu-x86_64 x86_64/ls -l dummyfile
> qemu-x86_64: /home/petmay01/linaro/qemu-for-merges/accel/tcg/translate-all.c:2562:
> page_check_range: Assertion `start < ((target_ulong)1 <<
> L1_MAP_ADDR_SPACE_BITS)' failed.
> qemu-x86_64: /home/petmay01/linaro/qemu-for-merges/accel/tcg/cpu-exec.c:703:
> cpu_exec: Assertion `!have_mmap_lock()' failed.
> Makefile:6: recipe for target 'test' failed

Presumably this is the test from the old linux-user-test-0.3?
Well, it works for me, for both x86_64 and aarch64 hosts.

What does the rest of this host look like?


r~

