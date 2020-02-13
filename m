Return-Path: <SRS0=ry7b=4B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B13C352A3
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 05:39:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B96420873
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2020 05:39:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Ni9V8NTf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B96420873
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j27EE-0005dA-NC
	for qemu-devel@archiver.kernel.org; Thu, 13 Feb 2020 00:39:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44745)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j27Dd-00055z-NA
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 00:39:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j27Dc-0006ew-FO
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 00:39:21 -0500
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:35918)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j27Dc-0006eX-8W
 for qemu-devel@nongnu.org; Thu, 13 Feb 2020 00:39:20 -0500
Received: by mail-pj1-x1043.google.com with SMTP id gv17so1907049pjb.1
 for <qemu-devel@nongnu.org>; Wed, 12 Feb 2020 21:39:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=lDCVuErHQJjOmhI7dDFKkfqmlT2bJoLE7QQMKQfbVfY=;
 b=Ni9V8NTfEAOdi1Z5NnbynC5Gz8fFGrMdxg4zVfCaNj1njZxPToICMcCG2hzK13Nbni
 1cyC0f9+62AhsLhcjvDfPEADicinKZChrJNcDb5JKomdcT65SzQoxQp71lMA/YAS76Ja
 bceStlBd3K1Jx8y3UPBLLtIhIojnaMEoamJL0Akfi1Ch1KryJJT5Lr3E605wrlSQIHka
 mouCZEb+YHTBU3ygLl9Sfh/JaJ3Gc7fDokblSJ55UPh1EzlENs9MSOLzRz+BTWj1IyAO
 X7r+zpv09q3zXysazShJmI6D3GjAJ5TNKFpTSfJ8jyT7agmZh8AaJBw8luc+yuGW3SR9
 a4KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=lDCVuErHQJjOmhI7dDFKkfqmlT2bJoLE7QQMKQfbVfY=;
 b=ts+1mTSd3ltEidubgBDX24UKj1gu+Qom2SOfUL1SBKbOMCrbB2oMSMKzkihxlp3fNI
 kcqu5Z0r8EtGe2cNcAGEt0imBCP8Mxe0O1czP+Ky8UZez6ZXNeHvuYB+snRpfIiaNVQP
 XeX3qpnWkgSTserAPAwRcl/V1kS1Co6Hk8iT8YffLdQjP9OFx2SUPwTsLaJe0z/3Z8o1
 ip2MkTtLeJ4oJ3JzRlmObxpbnUW0bCXMxO0c94gyJAZKYeTCcoDjwnXbV1H3FUWuPOPc
 dgWQGjh17JfjVV+LJZzttC69tj7uFytAm/WgKLLooJMB2TRALGF//+bDnnPpot6JN0to
 Tgkg==
X-Gm-Message-State: APjAAAXHMRciTxPiZ0IGszJY4bXvpkp3v7aLNAAI44ICmpNJpfgR8Hgo
 eyXHuDQlTJOtjSXnBc8S9g72Dw==
X-Google-Smtp-Source: APXvYqxLrsiIG1h23rEFN0p/cPjgohuwwxQ/bND/KrEF7pxlJsqUgOXcy3UfpSX9sEGb4Gi17oNJ6w==
X-Received: by 2002:a17:90b:14a:: with SMTP id
 em10mr3196018pjb.4.1581572358870; 
 Wed, 12 Feb 2020 21:39:18 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 84sm1035165pgg.90.2020.02.12.21.39.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Feb 2020 21:39:18 -0800 (PST)
Subject: Re: [RESEND RFC PATCH v2 1/2] target/arm: Allow to inject SError
 interrupt
To: Gavin Shan <gshan@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20200205110541.37811-2-gshan@redhat.com>
 <8dce7dbe-c6c1-122a-f960-0fc29257dd1c@redhat.com>
 <CAFEAcA-RiVfrFFkxppB=z8x76rjorF-5onyGwVAdsHY7W1U88g@mail.gmail.com>
 <21e4051a-4d06-03cb-6d8e-5331b5b570c4@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a0ff5b47-876d-533f-ea18-e53ee371ceba@linaro.org>
Date: Wed, 12 Feb 2020 21:39:15 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <21e4051a-4d06-03cb-6d8e-5331b5b570c4@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::1043
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
Cc: Andrew Jones <drjones@redhat.com>, jthierry@redhat.com,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Marc Zyngier <maz@kernel.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm <qemu-arm@nongnu.org>, Shan Gavin <shan.gavin@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/12/20 7:49 PM, Gavin Shan wrote:
> On 2/12/20 10:34 PM, Peter Maydell wrote:
>> Yeah, this is on my list to look at; Richard Henderson also could
>> have a look at it. From a quick scan I suspect you may be missing
>> handling for AArch32.
>>
> 
> [Thanks for copying Richard Henderson]
> 
> Yes, the functionality is only supported on aarch64 currently by intention
> because the next patch enables it on "max" and "host" CPU models and both
> of them are running in aarch64 mode.

We shouldn't leave the aarch32 exception entry paths unimplemented though.  C.f.

AArch32.TakePhysicalSErrorException()
AArch32.TakeVirtualSErrorException()

It really shouldn't be more than a couple of lines, just like
arm_cpu_do_interrupt_aarch64.  Remember both arm_cpu_do_interrupt_aarch32 and
arm_cpu_do_interrupt_aarch32_hyp.

> However, it seems there is a long list of aarch32 CPU models, defined
> in target/arm/cpu.c::arm_cpus. so which CPU models you prefer to see with
> this supported? I think we might choose one or two popular CPU models if
> you agree.

Even qemu-system-aarch64 -cpu max can exercise this path when EL1 is running in
aarch32 mode.  Admittedly it would be easier if we had the rest of the plumbing
so that -cpu max,aarch64=off worked.

FWIW, the rest of the patch looks good.


r~

