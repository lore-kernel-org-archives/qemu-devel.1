Return-Path: <SRS0=D5YA=6O=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26A33C47247
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:49:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E98762073E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2020 16:49:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c0Ea0HGc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E98762073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37056 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jUCNV-0003vp-3G
	for qemu-devel@archiver.kernel.org; Thu, 30 Apr 2020 12:49:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUCLr-0001xG-TS
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:48:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUCKY-00023k-JI
 for qemu-devel@nongnu.org; Thu, 30 Apr 2020 12:47:55 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52349)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jUCKY-000200-5X; Thu, 30 Apr 2020 12:46:34 -0400
Received: by mail-wm1-x344.google.com with SMTP id 188so2667665wmc.2;
 Thu, 30 Apr 2020 09:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PQQH9wY7/N3+aWm6+YUNmCylmQwM21bBF6zV6A0UdvY=;
 b=c0Ea0HGcu/J1M9Go7Et5k/Vj49ctzx9cgHChHJjgY98WPoXWzGDXN3NbcY9N4ha+X9
 n+bCDV6YhAAuMw7oTtq/Zouj1GXOacbkWfxaiivm7GVQ4OiKTdSKD6BfhylFnXBGmGot
 AD52XLMT+vQL3A5CNy3V/Cx5bqMn0oeGEzihIM503pJb7RLbCB2WRQ9x97jOEttS0ob1
 /Rm0Fq+K1vI7vLwtLpwpinPWFq1YKkNszmAhMNhb/TXcZ0xqtpG9jUfwv/vVAgjj7qxT
 TtsdKm8HcYia6zCW24htFejWsaIIWPJIA//Drw+HV8e1moR4dB/oJCHtPjDKtfXRR1fp
 axEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PQQH9wY7/N3+aWm6+YUNmCylmQwM21bBF6zV6A0UdvY=;
 b=LsWN1exrE8eNPSeoBy0b4Hz+xMX6EbG+OUWicpEksiaPSC2MS/1Y3Fd40JIX/NJYHm
 LZXbpWz3ulTTGIYfTxqi27Az7GCmlojSLlvL6hlAMaCb67Eb50lPmkHTZusxMXF2F2hK
 RUuPXpu8nLitlNI1NLF4GhBxHKH1x6aM3jTKZxyD1muILKzd+GJilVS0nDMFc27vT2qB
 Lm1fiDJ7iu/Fh5bKJBPqYCbVzsyzdmtpfSWbG5u6voAc19PqAoedbwW3u0GWyvXiO4t6
 ZVkGu5aGOVRDWQ82W9R1NcLMwX6Zrw3ugv7DQDHf+HbERGGq3LBToqK84IR8TKVtG96n
 P+dQ==
X-Gm-Message-State: AGi0PuY7x16Ws6fqWvjSm8IvWdaMF8FLsIa265seXqGdNeO5PP82w4hb
 qOlDNxitqaEBKkltd1RBHwc5OREmufs=
X-Google-Smtp-Source: APiQypJmT9X0ROhdLrI0zg98aAO5xvcNr1o2uYyEFiybxEAXBfUbRVSvVSu0WEmyaUUo5QqSA2n1Sw==
X-Received: by 2002:a1c:dc0a:: with SMTP id t10mr3849010wmg.113.1588265191613; 
 Thu, 30 Apr 2020 09:46:31 -0700 (PDT)
Received: from [192.168.1.39] (137.red-88-21-205.staticip.rima-tde.net.
 [88.21.205.137])
 by smtp.gmail.com with ESMTPSA id o18sm411655wrp.23.2020.04.30.09.46.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Apr 2020 09:46:30 -0700 (PDT)
Subject: Re: [PATCH v3] target/arm: Use correct variable for setting 'max'
 cpu's MIDR_EL1
To: Peter Maydell <peter.maydell@linaro.org>
References: <20200428172634.29707-1-f4bug@amsat.org>
 <CAFEAcA8RymJaowHcp1_Er_GghPAzMV6RTP7jgxNVmZEvR5ssbg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e904ba34-3a8d-8a69-68cf-6758f3bda1d4@amsat.org>
Date: Thu, 30 Apr 2020 18:46:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8RymJaowHcp1_Er_GghPAzMV6RTP7jgxNVmZEvR5ssbg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x344.google.com
X-detected-operating-system: by eggs.gnu.org: Error: [-] PROGRAM ABORT :
 Malformed IPv6 address (bad octet value).
 Location : parse_addr6(), p0f-client.c:67
X-Received-From: 2a00:1450:4864:20::344
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
Cc: Laurent Desnogues <laurent.desnogues@gmail.com>,
 qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/30/20 5:59 PM, Peter Maydell wrote:
> On Tue, 28 Apr 2020 at 18:26, Philippe Mathieu-Daudé <f4bug@amsat.org> wrote:
>>
>> MIDR_EL1 a 64-bit system register with the top 32-bit being RES0.
>>
>> This fixes when compiling with -Werror=conversion:
>>
>>    target/arm/cpu64.c: In function ‘aarch64_max_initfn’:
>>    target/arm/cpu64.c:628:21: error: conversion from ‘uint64_t’ {aka ‘long unsigned int’} to ‘uint32_t’ {aka ‘unsigned int’} may change value [-Werror=conversion]
>>      628 |         cpu->midr = t;
>>          |                     ^
>>
>> Suggested-by: Laurent Desnogues <laurent.desnogues@gmail.com>
>> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> 
> Applied to target-arm.next, with the commit message fixed
> up to match the patch contents:
> 
>      target/arm: Use uint64_t for midr field in CPU state struct
> 
>      MIDR_EL1 is a 64-bit system register with the top 32-bit being RES0.
>      Represent it in QEMU's ARMCPU struct with a uint64_t, not a
>      uint32_t.
> 
>      This fixes an error when compiling with -Werror=conversion
>      because we were manipulating the register value using a
>      local uint64_t variable:
> 
>        target/arm/cpu64.c: In function ‘aarch64_max_initfn’:
>        target/arm/cpu64.c:628:21: error: conversion from ‘uint64_t’
> {aka ‘long unsigned int’} to ‘uint32_t      ’ {aka ‘unsigned int’} may
> change value [-Werror=conversion]
>          628 |         cpu->midr = t;
>              |                     ^
> 
>      and future-proofs us against a possible future architecture
>      change using some of the top 32 bits.

Thanks Peter for updating the description.

> 
> thanks
> -- PMM
> 

