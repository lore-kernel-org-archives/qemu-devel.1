Return-Path: <SRS0=FIxb=52=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DA7C2BA2B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 15:18:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 002EC20753
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2020 15:18:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r479Od7G"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 002EC20753
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMvQH-0002JA-6h
	for qemu-devel@archiver.kernel.org; Fri, 10 Apr 2020 11:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57181)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jMvPc-0001tS-IQ
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:17:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jMvPZ-0001PW-3f
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:17:44 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:44356)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jMvPY-0001P5-Tm
 for qemu-devel@nongnu.org; Fri, 10 Apr 2020 11:17:41 -0400
Received: by mail-pf1-x443.google.com with SMTP id b72so1144101pfb.11
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2020 08:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GwXG6ErAjfAnu0xZx2e52/h71MsP7tVE5p8G8fgQ2cI=;
 b=r479Od7GL5Qbv3YSyleA3spvdNK3rz0+XpMc7+uaVLPPBRMUPfjtdhMBjF8KHSyy2R
 XR9wtekzxs1Iv0IBAm86pPq1ZsQ7iGQJmtbq9lvnhZrQDuotuYmbHNQVD4r/NEurYU+f
 qJbfeNfsCmuDeKdREZ00JibXILApWJ2rlpIygKJBYzS3sNDhb2XlbPF3CGQXAhV/mGnU
 VhjmRjm+9kYS3/7HDQXma+xz2OfhTmrw1PWsmuO2kSJMxEzzPmvbHTmKFX6oPkg57PlB
 Hk3Tlf090jO7jNHiV+xLWFbdORk0oZ5RJuSMc65wlZbJfR/O1vzciiHPbsNhlDGz/8vY
 Xp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GwXG6ErAjfAnu0xZx2e52/h71MsP7tVE5p8G8fgQ2cI=;
 b=f1JuIk0kWnmp8s4jnOVGV57NCsh3C03/O1HQvUg/yyICY69dKIyxmEA0KWPTX8osq+
 cXzTQ/uqN5+1/Aj9qEXEjNuCYdqseiJ7Dkn0CRUOlhk6TPUmcNw0bri2QM8qiZj6saRH
 Lr8m4LUoX96OAGoDlfXOKun/o/Ak3rr6DIrK6IucEYYUf6pCt2mlW73fNkQ0ntdDUtG3
 qmgIOxDhcIdjPd6vRnT1FaoscRX2xT1CAdkqfUD4Zt5Y76jp3y3ibYwC8bmviVRMK0sW
 SY64sNSAESL/CmZ4dXKh/M95SW5mlgT4XLKftiwi/fYAku/c6qJbimQMGf8iI7PGOwYF
 HDxg==
X-Gm-Message-State: AGi0PubyeH5cK9Kk9otoH+Kil3F2SM4/DbsRIt7PXn5o32GmmZ0ycDjg
 OoTCORW4j7FwYv0gd2MpA+/kIQ==
X-Google-Smtp-Source: APiQypJZ5Mp3/aW+u3TJte4ZZPEbsKYe5sr3tadJWkQQbir8qBuHzOOwri2Qs6hIiL/hsXwpK9T3yQ==
X-Received: by 2002:a63:3702:: with SMTP id e2mr5132224pga.211.1586531859439; 
 Fri, 10 Apr 2020 08:17:39 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id d5sm1992850pfa.59.2020.04.10.08.17.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Apr 2020 08:17:38 -0700 (PDT)
Subject: Re: [PULL 08/13] softfloat: Fix BAD_SHIFT from
 normalizeFloatx80Subnormal
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20200407155118.20139-1-alex.bennee@linaro.org>
 <20200407155118.20139-9-alex.bennee@linaro.org>
 <CAHiYmc7Eu0XsCe_bkV=tP_S3wyWy4St1RR2AphE7Obko-18mNQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45a7fe3b-cede-c8e9-fe98-99914bef0e97@linaro.org>
Date: Fri, 10 Apr 2020 08:17:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <CAHiYmc7Eu0XsCe_bkV=tP_S3wyWy4St1RR2AphE7Obko-18mNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/10/20 2:38 AM, Aleksandar Markovic wrote:
> 17:55 Uto, 07.04.2020. Alex Bennée <alex.bennee@linaro.org
> <mailto:alex.bennee@linaro.org>> је написао/ла:
>>
>> From: Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>>
>>
>> All other calls to normalize*Subnormal detect zero input before
>> the call -- this is the only outlier.  This case can happen with
>> +0.0 + +0.0 = +0.0 or -0.0 + -0.0 = -0.0, so return a zero of
>> the correct sign.
>>
>> Reported-by: Coverity (CID 1421991)
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org
> <mailto:richard.henderson@linaro.org>>
>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org
> <mailto:alex.bennee@linaro.org>>
>> Message-Id: <20200327232042.10008-1-richard.henderson@linaro.org
> <mailto:20200327232042.10008-1-richard.henderson@linaro.org>>
>> Message-Id: <20200403191150.863-8-alex.bennee@linaro.org
> <mailto:20200403191150.863-8-alex.bennee@linaro.org>>
>>
>> diff --git a/fpu/softfloat.c b/fpu/softfloat.c
>> index 301ce3b537b..ae6ba718540 100644
>> --- a/fpu/softfloat.c
>> +++ b/fpu/softfloat.c
>> @@ -5856,6 +5856,9 @@ static floatx80 addFloatx80Sigs(floatx80 a, floatx80 b,
> flag zSign,
>>          zSig1 = 0;
>>          zSig0 = aSig + bSig;
>>          if ( aExp == 0 ) {
>> +            if (zSig0 == 0) {
>> +                return packFloatx80(zSign, 0, 0);
>> +            }
>>              normalizeFloatx80Subnormal( zSig0, &zExp, &zSig0 );
>>              goto roundAndPack;
>>          }
>> --
>> 2.20.1
>>
>>
> 
> We in MIPS have extensive FP tests, that certainly include many cases of
> operations with +0 and -0. And they are all correct even before this patch.

This is for the 80-bit extended-double type, only used on x86 and m68k.  You
will not execute this path using MIPS.

> Alex, from the commit message, it not clear if this is a fix of a bug (in which
> case a test example would be useful to have, and the assesment on what
> scenarios could be affected), or just a correction for some rare condition that
> practically for all intents and purposes was never triggered, or perhaps
> something third.

This only avoids a Coverity out-of-range shift warning.

Beforehand, we executed 0 << 64, got 0 as the result (regardless of whether or
not the host truncates the shift count), and constructed the correctly signed
fp zero in the end.

There was more discussion about this in an earlier thread, associated with a
different patch for this same problem:

https://lists.nongnu.org/archive/html/qemu-devel/2020-03/msg08278.html


> Secondly, and not related to this patch only, I see more and more patches
> integrated into the main tree without "Reviewed-by:" tag. I don't think this is
> the best way an open source community works. In my personal opinion, this must
> stop.

The only way to avoid this is to have more developers review code outside their
own bailiwick.  The patch has been on the list for two weeks and was pinged
twice.

Although why Alex didn't add his own R-b to my patch when merging it to his
branch, I don't know.


r~

