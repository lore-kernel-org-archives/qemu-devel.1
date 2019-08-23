Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4907C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:24:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92C4D2173E
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 14:24:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dH7enH3x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92C4D2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56678 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1AUb-0000L1-Cl
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 10:24:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48421)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i1ASd-000789-6l
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:22:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i1ASb-0001SX-S6
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:22:38 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:43720)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i1ASb-0001RZ-Ki
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 10:22:37 -0400
Received: by mail-pl1-x641.google.com with SMTP id 4so5662093pld.10
 for <qemu-devel@nongnu.org>; Fri, 23 Aug 2019 07:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=66p1y4OA4qvXcxScLC8OUgkRGDTJQaJ/jKO13ndKLMQ=;
 b=dH7enH3xjNk0ntRIUz9Flaw+o66k5EGgPG/e2ARtkOPBTOnUvX4CgFusyktaWnvjC5
 DQC+VhRcfu86XfIBCK8AlBVNZi8xVlT1gn8RHqqtZUlYqlQ17eSAH31TU3dt43zX7S1k
 HwCb8Nm/I5u8ozD6UWANz6N2BHcAYAgbYa1gJloxVJo05skCTdr7RVnNIxA1gBpvxzV/
 y77iMi/BKEDx5ynOxg/aTW29Pwfc5BeuHMysUOKMhdvvtSaAlNY148t5N58ayFm1TYmJ
 j2ZtxEHUa4MnPhquhna7otJyEqjhzhG+KmipcubGUmkLmce9z0OI0q8H6Sa4lbLl9RhH
 /Zdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=66p1y4OA4qvXcxScLC8OUgkRGDTJQaJ/jKO13ndKLMQ=;
 b=mZ4kA/Gk9aR+6kJHB0Xjqjt3MajrCOQ0yX4YOGn/tpMkiTMfKET5ISE67BzI5yG4k+
 YFRsJHKpuHMGKP48A0Nriu/hQWWZFkUIcxQ8dQl7CGioorfFWxcEriThXhnWWgQ1bylZ
 VDHiUycqvz/1KgW2GbguiqzyQVyA3iyyV2ZK+y7AVWwD52PxcOn2xMmSeswdzORAbNUT
 JPC4w9SfoIfAw1Np0c7w3eZ0C3uvnh5/UlrLhJisAg4ZcNAokMIKRNLGTs8LTKTDLgOb
 Iz9QeQ2NlsJdG47sewpvfgPMVh01ZVe+cRdtDYlUxpeQE6XAwfE8mEew/s9lLe7ivBtF
 Imug==
X-Gm-Message-State: APjAAAX+086fStL4yyw8/iPvT+BQcg3XPtqiG/vLz6fNWRWDq/dTCble
 8QJl+uqajy7KoLyb5mGliXOWqw==
X-Google-Smtp-Source: APXvYqzsqTWbrEEAuDluNGTelN4+t2+KjcnlmyyZ+bAyYdba5sZC9VZ3WUFFVUv/yOS609DcFE6cWw==
X-Received: by 2002:a17:902:aa03:: with SMTP id
 be3mr5142817plb.240.1566570156217; 
 Fri, 23 Aug 2019 07:22:36 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a18sm2093410pgl.44.2019.08.23.07.22.34
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 23 Aug 2019 07:22:35 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-16-richard.henderson@linaro.org>
 <CAFEAcA9r3LvFAfu5WWD71ETyhEOzWmsZTUjid2nfGEMu1tOnTg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <69cf4f6e-7453-c858-75fb-ae8bedd9dde1@linaro.org>
Date: Fri, 23 Aug 2019 07:22:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9r3LvFAfu5WWD71ETyhEOzWmsZTUjid2nfGEMu1tOnTg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [PATCH v2 15/68] target/arm: Convert BX, BXJ,
 BLX (register)
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

On 8/23/19 4:49 AM, Peter Maydell wrote:
> On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  target/arm/translate.c | 78 ++++++++++++++++++++----------------------
>>  target/arm/a32.decode  |  7 ++++
>>  target/arm/t32.decode  |  2 ++
>>  3 files changed, 47 insertions(+), 40 deletions(-)
> 
>> @@ -195,8 +196,14 @@ CRC32CW          .... 0001 0100 .... .... 0010 0100 ....      @rndm
>>
>>  %sysm            8:1 16:4
>>
>> +@rm              ---- .... .... .... .... .... .... rm:4      &r
>> +
>>  MRS_bank         ---- 0001 0 r:1 00 .... rd:4 001. 0000 0000  &mrs_bank %sysm
>>  MSR_bank         ---- 0001 0 r:1 10 .... 1111 001. 0000 rn:4  &msr_bank %sysm
>>
>>  MRS_reg          ---- 0001 0 r:1 00 1111   rd:4 0000 0000 0000  &mrs_reg
>>  MSR_reg          ---- 0001 0 r:1 10 mask:4 1111 0000 0000 rn:4  &msr_reg
>> +
>> +BX               .... 0001 0010 1111 1111 1111 0001 ....      @rm
>> +BXJ              .... 0001 0010 1111 1111 1111 0010 ....      @rm
>> +BLX_r            .... 0001 0010 1111 1111 1111 0011 ....      @rm
> 
> Why do the decode patterns for these use '....' in the cond field
> rather than '----' like the other patterns ?

As much as possible I've tried to put the "----" in the format, so that it'll
be easier in future to add a cond:4 field.  Except that the MRS/MSR insns are
all one-offs so I didn't bother creating a separate format.


r~

> 
> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> 
> thanks
> -- PMM
> 


